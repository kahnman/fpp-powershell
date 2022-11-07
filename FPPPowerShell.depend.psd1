@{
    # Build dependencies
    InvokeBuild      = @{ target = 'CurrentUser'; version = 'latest' }
    Pester           = @{ target = 'CurrentUser'; version = '5.3.1' }
    PSScriptAnalyzer = @{ target = 'CurrentUser'; version = 'latest' }
    BuildHelpers     = @{ target = 'CurrentUser'; version = 'latest' }
    PlatyPS          = @{ target = 'CurrentUser'; version = 'latest' }
}
