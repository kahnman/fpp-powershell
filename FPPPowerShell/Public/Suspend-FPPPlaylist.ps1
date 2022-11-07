function Suspend-FPPPlaylist {
    <#
    .SYNOPSIS
    Pause the currently running playlist

    .DESCRIPTION
    Pause the currently running playlist

    .EXAMPLE
    Suspend-FPPPlaylist
    Pause the currently running playlist
    #>
    [CmdletBinding()]
    param ()

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'
        $playlistEndpointAddress = $endpointAddress + '/pause'

        Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress
    } catch {
        throw "Failed to pause playlist: $_"
    }
}