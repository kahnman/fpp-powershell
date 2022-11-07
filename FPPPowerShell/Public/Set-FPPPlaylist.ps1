function Set-FPPPlaylist {
    <#
    .SYNOPSIS
    Update/Insert a specific playlist.

    .DESCRIPTION
    Update/Insert a specific playlist.

    .EXAMPLE
    $json = '{
        "name": "MyUpdatedPlaylist",
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
    Set-FPPPlaylist -Json $json
    Create a new playlist called MyNewPlaylist.
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param (
        # The name of the playlist in which you want edit.
        [Parameter(Mandatory = $true)]
        [String]
        $Name,

        # The JSON that contains the definition of the playlist.
        [Parameter(Mandatory = $true)]
        [String]
        $Json
    )

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlist'

        $playlistEndpointAddress = $endpointAddress + "/$Name"

        if ($PSCmdlet.ShouldProcess('', "Are you sure you update the `"$Name`" playlist?", '')) {

            $result = Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress -Method 'POST' -Body $Json -ContentType 'application/json'

            Write-Verbose "Returned Status: $($result.Status)"

            if ($result.Status -ne 'OK') {
                throw "FPP returned message `"$($result.Message)`""
            }

            Write-Host "Playlist `"$Name`" updated"
        }
    } catch {
        throw "Failed to update `"$Name`" playlist: $_"
    }
}