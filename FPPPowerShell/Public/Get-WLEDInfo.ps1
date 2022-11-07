function Get-WLEDInfo {
    <#
    .SYNOPSIS
    Get info about the WLED controller.
    
    .DESCRIPTION
    Get info about the WLED controller.

    .EXAMPLE
    Get-WLEDInfo -WLEDHost '192.168.1.5'
    Get info about the WLED controller with IP address 192.168.1.5
    #>
    [CmdletBinding()]
    param (
        # The hostname or IP address of the WLED controller
        [Parameter(Mandatory = $true)]
        [String]
        $WLEDHost
    )

    $uri = ('http://{0}/json/info' -f $WLEDHost)

    $webRequestSplat = @{
        Uri             = $uri
        Method          = 'GET'
        UseBasicParsing = $true
    }

    try {
        Invoke-RestMethod @webRequestSplat
    } catch {
        throw "Failed to get WLED info: $_"
    }
}