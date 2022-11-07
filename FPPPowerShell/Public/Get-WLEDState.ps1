function Get-WLEDState {
    <#
    .SYNOPSIS
    Get the state of a WLED controller.
    
    .DESCRIPTION
    Get the state of a WLED controller.

    .EXAMPLE
    Get-WLEDState -WLEDHost '192.168.1.5'
    Get the state of the WLED controller with IP address 192.168.1.5
    #>
    [CmdletBinding()]
    param (
        # The hostname or IP address of the WLED controller
        [Parameter(Mandatory = $true)]
        [String]
        $WLEDHost
    )

    $uri = ('http://{0}/json/state' -f $WLEDHost)

    $webRequestSplat = @{
        Uri             = $uri
        Method          = 'GET'
        UseBasicParsing = $true
    }

    try {
        $result = Invoke-RestMethod @webRequestSplat

        $effects = Get-WLEDEffect -WLEDHost $WLEDHost
        $palettes = Get-WLEDPalette -WLEDHost $WLEDHost

        for ($i = 0; $i -lt ($result.seg).Count; $i++) {
            $result.seg[$i] | Add-Member -Name 'fxName' -Value $effects[$result.seg[$i].fx] -MemberType NoteProperty
            $result.seg[$i] | Add-Member -Name 'palName' -Value $palettes[$result.seg[$i].pal] -MemberType NoteProperty
        }

        return $result
    } catch {
        throw "Failed to get WLED state: $_"
    }
}