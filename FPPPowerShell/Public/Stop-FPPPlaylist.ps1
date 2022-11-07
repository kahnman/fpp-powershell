function Stop-FPPPlaylist {
    <#
    .SYNOPSIS
    Stop the currently running playlist. By default, the playlist stops immediately, but you can use the "Gracefully"
    or "GracefullyAfterLoop" parameters to stop the playlist gracefully.

    .DESCRIPTION
    Stop the currently running playlist. By default, the playlist stops immediately, but you can use the "Gracefully"
    or "GracefullyAfterLoop" parameters to stop the playlist gracefully.

    .EXAMPLE
    Stop-FPPPlaylist
    Stops the currently running playlist immediately.

    .EXAMPLE
    Stop-FPPPlaylist -Gracefully
    Gracefully stop the currently running playlist.

    .EXAMPLE
    Stop-FPPPlaylist -GracefullyAfterLoop
    Gracefully stop the currently running playlist after completion of the current loop.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        # Gracefully stop the currently running playlist.
        [Parameter(Mandatory = $false)]
        [Switch]
        $Gracefully,

        # Gracefully stop the currently running playlist after completion of the current loop.
        [Parameter(Mandatory = $false)]
        [Switch]
        $GracefullyAfterLoop
    )

    try {
        if ($Gracefully -and $GracefullyAfterLoop) {
            throw 'Only specify -Gracefully or -GracefullyAfterLoop, but not both.'
        }

        if ($Gracefully) {
            $action = 'stopgracefully'
            $actionConfirmText = 'Playlist stopping gracefully'
        } elseif ($GracefullyAfterLoop) {
            $action = 'stopgracefullyafterloop'
            $actionConfirmText = 'Playlist stopping after the next loop'
        } else {
            $action = 'stop'
            $actionConfirmText = 'Playlist stopped'
        }

        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'
        $playlistEndpointAddress = $endpointAddress + '/' + $action

        if ($PSCmdlet.ShouldProcess('', "Are you sure you want to stop the `"$PlaylistName`" playlist?", '')) {
            $null = Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress

            Write-Host $actionConfirmText
        }
    } catch {
        throw "Failed to stop playlist: $_"
    }
}