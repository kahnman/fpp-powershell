#requires -modules InvokeBuild

<#
.SYNOPSIS
    This script contains the tasks for building the 'FPPPowerShell' PowerShell module

.DESCRIPTION
    This script contains the tasks for building the 'FPPPowerShell' PowerShell module
#>
Set-StrictMode -Version Latest

# Install build dependencies
Enter-Build {

    # Setting build script variables
    Write-Verbose 'Initializing build variables' -Verbose
    Write-Verbose "  Existing BuildRoot [$BuildRoot]" -Verbose

    $script:ModuleName = Get-ChildItem .\*\*.psm1 | Select-Object -ExpandProperty BaseName
    Write-Verbose "  Module Name [$ModuleName]" -Verbose

    $script:DocsPath = Join-Path -Path $BuildRoot -ChildPath 'Docs'
    Write-Verbose "  DocsPath [$DocsPath]" -Verbose

    $script:Output = Join-Path -Path $BuildRoot -ChildPath 'Output'
    Write-Verbose "  Output [$Output]" -Verbose

    $script:TestsPath = Join-Path -Path $BuildRoot -ChildPath 'Tests'
    Write-Verbose "  Tests [$TestsPath]" -Verbose

    $script:ModuleSourcePath = Join-Path -Path $BuildRoot -ChildPath $ModuleName
    Write-Verbose "  ModuleSourcePath [$ModuleSourcePath]" -Verbose

    $script:Destination = Join-Path -Path $Output -ChildPath $ModuleName
    Write-Verbose "  Destination [$Destination]" -Verbose

    $script:ManifestPath = Join-Path -Path $Destination -ChildPath "$ModuleName.psd1"
    Write-Verbose "  ManifestPath [$ManifestPath]" -Verbose

    $script:ModulePath = Join-Path -Path $Destination -ChildPath "$ModuleName.psm1"
    Write-Verbose "  ModulePath [$ModulePath]" -Verbose

    $script:ProductionPSRepository = 'HHSPSGallery'
    Write-Verbose "  ProductionPSRepository [$ProductionPSRepository]" -Verbose

    <# $script:PestorTestData = @{
        ModuleName  = $script:ModuleName
        ProjectRoot = ([System.IO.Path]::Combine($script:Output,$script:ModuleName))
    } #>
}

# Synopsis: Default task
task Default Clean, Build, Test, UpdateSource

task QuickBuild Clean, Build, ImportModule

# Synopsis: Test the project
task Test Build, ImportModule, TestModule, Analyze, TestFunctions

# Synopsis: Build the project
task Build Copy, BuildManifest, SetVersion

# Synopsis: Generate markdown help and XML based help for the module
task Helpify GenerateMarkdown, GenerateHelp

task Copy {
    Write-Verbose 'Entering Task Copy ...'
    Write-Host "Creating Directory [$Destination]..."
    $null = New-Item -ItemType 'Directory' -Path $Destination -ErrorAction 'Ignore'

    $files = Get-ChildItem -Path $ModuleSourcePath -File |
        Where-Object 'Name' -NotMatch "$ModuleName\.psd1"

    foreach ($file in $files) {
        Write-Host ('Creating [.{0}]...' -f $file.FullName.Replace($BuildRoot, ''))
        Copy-Item -Path $file.FullName -Destination $Destination -Force
    }

    $directories = Get-ChildItem -Path $ModuleSourcePath -Directory

    foreach ($directory in $directories) {
        Write-Host ('Creating [.{0}]...' -f $directory.FullName.Replace($BuildRoot, ''))
        Copy-Item -Path $directory.FullName -Destination $Destination -Recurse -Force
    }
}

task BuildManifest {
    Write-Verbose 'Entering Task BuildManifest ...'
    Write-Host "Updating [$ManifestPath]..."
    Copy-Item -Path "$ModuleSourcePath\$ModuleName.psd1" -Destination $ManifestPath

    $functions = Get-ChildItem -Path "$ModuleName\Public" -Recurse -Filter *.ps1 -ErrorAction 'Ignore' |
        Where-Object 'Name' -NotMatch 'Tests'

    if ($functions) {
        Write-Host 'Setting FunctionsToExport...'
        Set-ModuleFunctions -Name $ManifestPath -FunctionsToExport $functions.BaseName
    }
}

function ImportModule {
    param(
        [string]$Path,
        [switch]$PassThru
    )


    if (-not(Test-Path -Path $Path)) {
        Write-Host "Cannot find [$Path]."
        Write-Error -Message "Could not find module manifest [$Path]"
    } else {
        $file = Get-Item $Path
        $name = $file.BaseName

        $loaded = Get-Module -Name $name -All -ErrorAction Ignore
        if ($loaded) {
            Write-Host "Unloading Module [$name] from a previous import..."
            $loaded | Remove-Module -Force
        }

        Write-Host "Importing Module [$name] from [$($file.fullname)]..."
        Import-Module -Name $file.fullname -Force -PassThru:$PassThru
    }
}
task ImportModule {
    Write-Verbose 'Entering Task ImportModule ...'
    ImportModule -Path $ManifestPath
}
function GetModulePublicInterfaceMap {
    param($Path)

    Write-Host "Importing $Path"
    $module = ImportModule -Path $Path -PassThru
    $exportedCommands = @(
        $module.ExportedFunctions.values
        $module.ExportedCmdlets.values
        $module.ExportedAliases.values
    )

    foreach ($command in $exportedCommands) {
        foreach ($parameter in $command.Parameters.Keys) {
            if ($false -eq $command.Parameters[$parameter].IsDynamic) {
                '{0}:{1}' -f $command.Name, $command.Parameters[$parameter].Name
                foreach ($alias in $command.Parameters[$parameter].Aliases) {
                    '{0}:{1}' -f $command.Name, $alias
                }
            }
        }
    }
}

task SetVersion {
    Write-Verbose 'Entering Task SetVersion ...'
    $version = [version]'0.1.0'
    $publishedModule = $null
    $bumpVersionType = 'Patch'
    $versionStamp = (git rev-parse origin/main) + (git rev-parse head)

    Write-Host 'Load current version'
    [version] $sourceVersion = (Get-Metadata -Path $ManifestPath -PropertyName 'ModuleVersion')
    Write-Host "  Source version [$sourceVersion]"

    $downloadFolder = Join-Path -Path $Output -ChildPath 'downloads'
    $null = New-Item -ItemType Directory -Path $downloadFolder -Force -ErrorAction Ignore

    $versionFile = Join-Path -Path $downloadFolder -ChildPath 'versionfile'

    if (Test-Path $versionFile) {
        $versionFileData = Get-Content $versionFile -Raw
        if ($versionFileData -eq $versionStamp) {
            continue
        }
    }

    Write-Host 'Checking for published version'
    $publishedModule = Find-Module -Name $ModuleName -ErrorAction 'Ignore' |
        Sort-Object -Property { [version]$_.Version } -Descending |
        Select-Object -First 1

    if ($null -ne $publishedModule) {
        [version] $publishedVersion = $publishedModule.Version
        Write-Host "  Published version [$publishedVersion]"

        $version = $publishedVersion

        Write-Host 'Downloading published module to check for breaking changes'
        $publishedModule | Save-Module -Path $downloadFolder

        [System.Collections.Generic.HashSet[string]] $publishedInterface = @(GetModulePublicInterfaceMap -Path (Join-Path $downloadFolder $ModuleName))
        [System.Collections.Generic.HashSet[string]] $buildInterface = @(GetModulePublicInterfaceMap -Path $ManifestPath)

        if (-not $publishedInterface.IsSubsetOf($buildInterface)) {
            $bumpVersionType = 'Major'
        } elseif ($publishedInterface.count -ne $buildInterface.count) {
            $bumpVersionType = 'Minor'
        }
    }

    if ($version -lt ([version] '1.0.0')) {
        Write-Host "Module is still in beta; don't bump major version."
        if ($bumpVersionType -eq 'Major') {
            $bumpVersionType = 'Minor'
        } else {
            $bumpVersionType = 'Patch'
        }
    }

    Write-Host "  Steping version [$bumpVersionType]"
    $version = [version] (Step-Version -Version $version -Type $bumpVersionType)

    Write-Host "  Comparing to source version [$sourceVersion]"
    if ($sourceVersion -gt $version) {
        Write-Host '    Using existing version'
        $version = $sourceVersion
    }

    if ( -not [string]::IsNullOrEmpty( $env:Build_BuildID ) ) {
        $build = $env:Build_BuildID
        $version = [version]::new($version.Major, $version.Minor, $version.Build, $build)
    } elseif ( -not [string]::IsNullOrEmpty( $env:APPVEYOR_BUILD_ID ) ) {
        $build = $env:APPVEYOR_BUILD_ID
        $version = [version]::new($version.Major, $version.Minor, $version.Build, $build)
    }

    Write-Host "  Setting version [$version]"
    Update-Metadata -Path $ManifestPath -PropertyName 'ModuleVersion' -Value $version

    (Get-Content -Path $ManifestPath -Raw -Encoding UTF8) |
        ForEach-Object { $_.TrimEnd() } |
        Set-Content -Path $ManifestPath -Encoding UTF8

    Set-Content -Path $versionFile -Value $versionStamp -NoNewline -Encoding UTF8

    if (Test-Path "$BuildRoot\fingerprint") {
        Remove-Item "$BuildRoot\fingerprint"
    }
}

# Synopsis: Analyze the project with PSScriptAnalyzer
task Analyze {
    Write-Verbose 'Entering Task Analyze ...'
    # Get-ChildItem parameters
    $gciSplat = @{
        Path    = $testsPath
        Recurse = $true
        Include = '*.PSSA.Tests.*'
    }

    $testFiles = Get-ChildItem @gciSplat

    # Pester configuration
    $pesterConfig = @{
        Run = @{ # Run configuration.
            PassThru  = $true # Return result object after finishing the test run.
            Container = (New-PesterContainer -Path $testFiles)
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    if ($env:BHBuildSystem -eq 'Azure Pipelines') {
        if (-not (Test-Path -Path $Output -ErrorAction SilentlyContinue)) {
            New-Item -Path $Output -ItemType Directory
        }
        $Timestamp = Get-Date -UFormat '%Y%m%d-%H%M%S'
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "AnalysisResults_PS$PSVersion`_$TimeStamp.xml"

        $testResultsConfig = @{
            Enabled      = $true
            OutputFormat = 'NUnitXml'
            OutputPath   = (Join-Path -Path $Output -ChildPath $TestResultFile)
        }

        $pesterConfig.Add('TestResult', $testResultsConfig)
    }

    # Invoke all tests
    $testResults = Invoke-Pester -Configuration $pesterConfig
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error "Failed [$($testResults.FailedCount)] Pester tests."
        # throw 'One or more PSScriptAnalyzer rules have been violated. Build cannot continue!'
    }
}

# Synopsis: Test the project module with Pester tests
task TestModule {
    Write-Verbose 'Entering Task TestModule ...'
    # Get-ChildItem parameters
    $gciSplat = @{
        Path    = $testsPath
        Recurse = $true
        Include = '*.Module.Tests.*'
    }

    $testFiles = Get-ChildItem @gciSplat

    # Pester configuration
    $pesterConfig = @{
        Run = @{ # Run configuration.
            PassThru  = $true # Return result object after finishing the test run.
            Container = (New-PesterContainer -Path $testFiles)
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    if ($env:BHBuildSystem -eq 'Azure Pipelines') {
        if (-not (Test-Path -Path $Output -ErrorAction SilentlyContinue)) {
            New-Item -Path $Output -ItemType Directory
        }
        $Timestamp = Get-Date -UFormat '%Y%m%d-%H%M%S'
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"

        $testResultsConfig = @{
            Enabled      = $true
            OutputFormat = 'NUnitXml'
            OutputPath   = (Join-Path -Path $Output -ChildPath $TestResultFile)
        }

        $pesterConfig.Add('TestResult', $testResultsConfig)
    }
    # Invoke all tests
    $testResults = Invoke-Pester -Configuration $pesterConfig
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error "Failed [$($testResults.FailedCount)] Pester tests."
        # throw 'One or more Module Pester tests have failed. Build cannot continue!'
    }
}

# Synopsis: Test the project functions with Pester tests
task TestFunctions {
    Write-Verbose 'Entering Task TestFunctions ...'
    # Get-ChildItem parameters
    $gciSplat = @{
        Path    = $testsPath
        Recurse = $true
        Include = '*.Tests.*'
        Exclude = '*.PSSA.*','*.Module.*'
    }

    $testFiles = Get-ChildItem @gciSplat

    # Pester configuration
    $pesterConfig = @{
        Run = @{ # Run configuration.
            PassThru  = $true # Return result object after finishing the test run.
            Container = (New-PesterContainer -Path $testFiles)
        }
    }

    # Additional parameters on Azure Pipelines agents to generate test results
    if ($env:BHBuildSystem -eq 'Azure Pipelines') {
        if (-not (Test-Path -Path $Output -ErrorAction SilentlyContinue)) {
            New-Item -Path $Output -ItemType Directory
        }
        $Timestamp = Get-Date -UFormat '%Y%m%d-%H%M%S'
        $PSVersion = $PSVersionTable.PSVersion.Major
        $TestResultFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"

        $testResultsConfig = @{
            Enabled      = $true
            OutputFormat = 'NUnitXml'
            OutputPath   = (Join-Path -Path $Output -ChildPath $TestResultFile)
        }

        $pesterConfig.Add('TestResult', $testResultsConfig)
    }

    # Invoke all tests
    $testResults = Invoke-Pester -Configuration $pesterConfig
    if ($testResults.FailedCount -gt 0) {
        $testResults | Format-List
        Write-Error "Failed [$($testResults.FailedCount)] Pester tests."
        # throw 'One or more Pester tests have failed. Build cannot continue!'
    }
}

task UpdateSource {
    Write-Verbose 'Entering Task UpdateSource ...'
    Copy-Item -Path $ManifestPath -Destination "$ModuleSourcePath\$ModuleName.psd1"

    $content = Get-Content -Path "$ModuleSourcePath\$ModuleName.psd1" -Raw -Encoding UTF8
    $content.Trim() | Set-Content -Path "$ModuleSourcePath\$ModuleName.psd1" -Encoding UTF8
}

# Synopsis: Generate markdown documentation based on the comment based help in each function.
task GenerateMarkdown {
    Write-Verbose 'Entering Task GenerateMarkdown ...'
    $module = Import-Module -FullyQualifiedName $ManifestPath -Force -PassThru

    try {
        if ($module.ExportedFunctions.Count -eq 0) {
            Write-Host 'No functions have been exported for this module. Skipping Markdown generation...'
            return
        }

        $markDownFiles = Get-ChildItem -Path $DocsPath -Filter '*.md' -Exclude "$ModuleName.md" -Recurse
        if ($null -ne $markDownFiles) {
            foreach ($markDownFile in $markDownFiles) {
                Write-Host "Updating Markdown help in [$($markDownFile.BaseName)]..."
                $null = Update-MarkdownHelp -Path $markDownFile.FullName -AlphabeticParamsOrder
            }
        }

        $params = @{
            AlphabeticParamsOrder = $true
            ErrorAction           = 'SilentlyContinue'
            Locale                = 'en-US'
            Module                = $ModuleName
            OutputFolder          = $DocsPath
            WithModulePage        = $true
        }

        # ErrorAction is set to SilentlyContinue so this
        # command will not overwrite an existing Markdown file.
        Write-Host "Creating new Markdown help for [$ModuleName]..."
        $null = New-MarkdownHelp @params
    } finally {
        Remove-Module -Name $ModuleName -Force
    }
}

# Synopsis: Generate an XML based help file. Note: This is not currently used.
task GenerateHelp {
    Write-Verbose 'Entering Task GenerateHelp ...'
    if (!(Get-ChildItem -Path $DocsPath -Filter '*.md' -Recurse -ErrorAction 'Ignore')) {
        Write-Host 'No Markdown help files to process. Skipping help file generation...'
        return
    }

    $params = @{
        ErrorAction = 'SilentlyContinue'
        Force       = $true
        OutputPath  = "$Destination\en-US"
        Path        = $DocsPath
    }

    # Generate the module's primary MAML help file.
    Write-Host "Creating new External help for [$ModuleName]..."
    $null = New-ExternalHelp @params
}

# Synopsis: Clean up the target build directory
task Clean {
    Write-Verbose 'Entering Task Clean ...'
    if (Test-Path $Output) {
        Write-Host "Cleaning Output files in [$Output]..."
        $null = Get-ChildItem -Path $Output -File -Recurse |
            Remove-Item -Force -ErrorAction 'Ignore'

        Write-Host "Cleaning Output directories in [$Output]..."
        $null = Get-ChildItem -Path $Output -Directory -Recurse |
            Remove-Item -Recurse -Force -ErrorAction 'Ignore'
    }
}