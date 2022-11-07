function New-FPPPlaylist {
    <#
    .SYNOPSIS
    Create a new FPP Playlist.
    
    .DESCRIPTION
    Create a new FPP Playlist.

    .EXAMPLE
    $json = '{
        "name": "MyNewPlaylist",
        "mainPlaylist": [
            {
            "type": "pause",
            "enabled": 1,
            "playOnce": 0,
            "duration": 8
            }
        ],
        "playlistInfo": {
            "total_duration": 8,
            "total_items": 1
        }
        }'
    New-FPPPlaylist -Json $json
    Create a new playlist called MyNewPlaylist.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        # The JSON that contains the definition of the playlist
        [Parameter(Mandatory = $true)]
        [String]
        $Json
    )

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'

        if ($PSCmdlet.ShouldProcess('', 'Are you sure you want to create the a new playlist?', '')) {

            Invoke-FPPApiMethod -EndpointAddress $endpointAddress -Method 'POST' -Body $Json -ContentType 'application/json'
            
            Write-Host 'Playlist created'
        }
    } catch {
        throw "Failed to create playlist: $_"
    }
}