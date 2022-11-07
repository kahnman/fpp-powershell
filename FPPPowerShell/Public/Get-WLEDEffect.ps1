function Get-WLEDEffect {
    <#
    .SYNOPSIS
    Get a list of available effects on the WLED controller.
    
    .DESCRIPTION
    Get a list of available effects on the WLED controller.

    .EXAMPLE
    Get-WLEDEffect -WLEDHost '192.168.1.5'
    Get the list of effects on the WLED controller with IP address 192.168.1.5
    #>
    [CmdletBinding()]
    param (
        # The hostname or IP address of the WLED controller
        [Parameter(Mandatory = $true)]
        [String]
        $WLEDHost
    )

    $uri = ('http://{0}/json/effects' -f $WLEDHost)

    $webRequestSplat = @{
        Uri             = $uri
        Method          = 'GET'
        UseBasicParsing = $true
    }

    try {
        Invoke-RestMethod @webRequestSplat
    } catch {
        throw "Failed to get WLED effects: $_"
    }
}