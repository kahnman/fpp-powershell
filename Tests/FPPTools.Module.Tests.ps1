BeforeDiscovery {
  # Dynamically defining the functions to analyze
  $functionPaths = @()
  # $arrTestCases = @()
  if (Test-Path -Path "$moduleSourcePath\Private\*.ps1") {
    $functionPaths += Get-ChildItem -Path "$moduleSourcePath\Private\*.ps1" -Exclude '*.Tests.*'
  }
  if (Test-Path -Path "$moduleSourcePath\Public\*.ps1") {
    $functionPaths += Get-ChildItem -Path "$moduleSourcePath\Public\*.ps1" -Exclude '*.Tests.*'
  }

  $script:testCases = foreach ($functionPath in $functionPaths) {
    $functionName = $functionPath.BaseName
    $isPublicFundtion = ($functionPath -like '*Public*')

    @{
      Path           = $functionPath.FullName
      FunctionName   = $functionName
      PublicFunction = $isPublicFundtion
    }
  }
}

Describe "$moduleName Module Tests" -Tag "Module" {

  Context 'Module Setup' {
    It "has the root .psm1 module $moduleName.psm1" {
      "$moduleSourcePath\$moduleName.psm1" | Should -Exist
    }

    It "has a .psd1 manifest file containing reference to $moduleName.psm1" {
      "$moduleSourcePath\$moduleName.psd1" | Should -Exist
      "$moduleSourcePath\$moduleName.psd1" | Should -FileContentMatch "$moduleName.psm1"
    }

    It 'Public folder has cmdlet scripts' {
      "$moduleSourcePath\Public\*.ps1" | Should -Exist
    }

    It "$moduleName.psm1 is valid PowerShell code" {
      $psFile = Get-Content -Path "$moduleSourcePath\$moduleName.psm1" -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should -Be 0
    }

  } # Context 'Module Setup'

  Context '<FunctionName> Common Function Tests' -Foreach $testCases {

    It '<FunctionName>.ps1 should exist / function should match name of file' {
      "$Path" | Should -Exist
    }

    It '<FunctionName>.ps1 filename should match function name' {
      "$Path" | Should -FileContentMatch "Function $functionName"
    }

    if ($PublicFunction) {
      It '<FunctionName>.ps1 should have help block' {
        "$Path" | Should -FileContentMatch '<#'
        "$Path" | Should -FileContentMatch '#>'
      }

      It '<FunctionName>.ps1 should have a SYNOPSIS section in the help block' {
        "$Path" | Should -FileContentMatch '.SYNOPSIS'
      }

      It '<FunctionName>.ps1 should have a DESCRIPTION section in the help block' {
        "$Path" | Should -FileContentMatch '.DESCRIPTION'
      }

      It '<FunctionName>.ps1 should have a EXAMPLE section in the help block' {
        "$Path" | Should -FileContentMatch '.EXAMPLE'
      }
    }

    It '<FunctionName>.ps1 should be an advanced function' {
      "$Path" | Should -FileContentMatch 'function'
      "$Path" | Should -FileContentMatch 'cmdletbinding'
      "$Path" | Should -FileContentMatch 'param'
    }
    It '<FunctionName>.ps1 is valid PowerShell code' {
      $psFile = Get-Content -Path "$Path" -ErrorAction Stop
      $errors = $null
      $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
      $errors.Count | Should -Be 0
    }
  }
}