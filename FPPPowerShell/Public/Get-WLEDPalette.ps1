function Get-WLEDPalette {
    <#
    .SYNOPSIS
    Get a list of available palettes on the WLED controller.

    .DESCRIPTION
    Get a list of available palettes on the WLED controller.

    .EXAMPLE
    Get-WLEDPalette -WLEDHost '192.168.1.5'
    Get the list of palettes on the WLED controller with IP address 192.168.1.5
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    [CmdletBinding()]
    param (
        # The hostname or IP address of the WLED controller
        [Parameter(Mandatory = $true)]
        [String]
        $WLEDHost
    )

    $uri = ('http://{0}/json/palettes' -f $WLEDHost)

    $webRequestSplat = @{
        Uri             = $uri
        Method          = 'GET'
        UseBasicParsing = $true
    }

    try {
        Invoke-RestMethod @webRequestSplat
    } catch {
        throw "Failed to get WLED palettes: $_"
    }
}