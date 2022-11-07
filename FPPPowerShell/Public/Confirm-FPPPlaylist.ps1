function Confirm-FPPPlaylist {
    <#
    .SYNOPSIS
    Returns a list of playlist and any validation errors that are present

    .DESCRIPTION
    Returns a list of playlist and any validation errors that are present

    .EXAMPLE
    Confirm-FPPPlaylist
    Returns a list of playlist and any validation errors that are present
    #>
    [CmdletBinding()]
    param ()

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'
        $playlistEndpointAddress = $endpointAddress + '/validate'

        Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress
    } catch {
        throw "Failed to validate playlists: $_"
    }
}