# Module manifest
@{

    # Script module or binary module file associated with this manifest.
    RootModule        = '.\FPPPowerShell.psm1'

    # Version number of this module.
    ModuleVersion     = '0.1.1'

    # ID used to uniquely identify this module (get your own GUID for new module!)
    GUID              = 'e01a4f96-bc81-4037-9749-00b02ef9857d'

    # Author of this module
    Author            = 'Kahnman'

    # Company or vendor of this module
    CompanyName       = ''

    # Copyright statement for this module
    Copyright         = ''

    # Description of the functionality provided by this module
    Description       = 'A PowerShell module that lets you perform actions on and make changes to a Falcon Pi Player (FPP) instance using its built in API.'

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    #RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module
    FunctionsToExport = @('Add-FPPPlaylistItem','Add-FPPPlaylistPause','Add-FPPWledOverlayModelEffect','Confirm-FPPPlaylist','Copy-FPPEffectFromWled','Get-FPPModel','Get-FPPPlaylist','Get-FPPWledEffect','Get-FPPWledPalette','Get-WLEDEffect','Get-WLEDInfo','Get-WLEDPalette','Get-WLEDState','New-FPPPlaylist','New-FPPSession','Remove-FPPPlaylist','Resume-FPPPlaylist','Set-FPPPlaylist','Start-FPPPlaylist','Stop-FPPPlaylist','Suspend-FPPPlaylist')

    # Cmdlets to export from this module
    CmdletsToExport   = '*'

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module
    AliasesToExport   = '*'

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    # PrivateData = ''

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}
