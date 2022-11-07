BeforeDiscovery {
    # Dynamically defining the functions to analyze
    $scriptAnalyzerSettings = "$testsPath\ScriptAnalyzerSettings.psd1"
    Write-Host "ScriptAnalyzerSettings: $scriptAnalyzerSettings"
    $functionPaths = @()
    if (Test-Path -Path "$moduleSourcePath\Private\*.ps1") {
        $functionPaths += Get-ChildItem -Path "$moduleSourcePath\Private\*.ps1" -Exclude '*.Tests.*'
    }
    if (Test-Path -Path "$moduleSourcePath\Public\*.ps1") {
        $functionPaths += Get-ChildItem -Path "$moduleSourcePath\Public\*.ps1" -Exclude '*.Tests.*'
    }

    $script:testCases = foreach ($functionPath in $functionPaths) {
        $results = Invoke-ScriptAnalyzer -Path $functionPath -Settings $scriptAnalyzerSettings -Verbose:$false
        $functionName = $functionPath.BaseName

        foreach ($rule in $results) {
            @{
                Path         = $functionPath.FullName
                FunctionName = $functionName
                Rule         = $rule.RuleName
                Severity     = $rule.Severity
                Line         = $rule.Line
                Message      = $rule.Message
            }
        }
    }
}

Describe 'All commands pass PSScriptAnalyzer rules' -Tag 'Analyze' {
    It '[<Rule>] <FunctionName>' -TestCases $testCases -Skip:(!$testCases) {
        param($Severity,$Line,$Message)
        $because = '{0} {1} {2}' -f $Severity,$Line,$Message
        $Message | Should -BeNullOrEmpty -Because $because
    }
}