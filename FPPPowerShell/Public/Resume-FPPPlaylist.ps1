function Resume-FPPPlaylist {
    <#
    .SYNOPSIS
    Resume a previously paused playlist

    .DESCRIPTION
    Resume a previously paused playlist

    .EXAMPLE
    Resume-FPPPlaylist
    Resume a previously paused playlist
    #>
    [CmdletBinding()]
    param ()

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'
        $playlistEndpointAddress = $endpointAddress + '/resume'

        Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress
    } catch {
        throw "Failed to resume playlist: $_"
    }
}