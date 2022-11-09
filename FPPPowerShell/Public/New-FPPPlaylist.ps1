function New-FPPPlaylist {
    <#
    .SYNOPSIS
    Create a new FPP Playlist. If you use the "Name" parameter, an empty playlist with that name will be created.
    If you use the "Json" parameter, you can create a new playlist and populate it at the same time.
    If Force switch is used and the name of the new playlist matches an existing playlist, the existing playlist will be overwritten without warning.
    
    .DESCRIPTION
    Create a new FPP Playlist. If you use the "Name" parameter, an empty playlist with that name will be created.
    If you use the "Json" parameter, you can create a new playlist and populate it at the same time.
    If Force switch is used and the name of the new playlist matches an existing playlist, the existing playlist will be overwritten without warning.

    .EXAMPLE
    New-FPPPlaylist -Name 'Christmas'
    Create a new empty playlist called "Christmas".

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
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low', DefaultParameterSetName = 'Name')]
    param (
        # The Name of your new playlist.
        [Parameter(Mandatory = $true, ParameterSetName = 'Name')]
        [String]
        $Name,

        # The JSON that contains the definition of the playlist
        [Parameter(Mandatory = $true, ParameterSetName = 'Json')]
        [String]
        $Json,

        # If Force switch is used and the name of the new playlist matches an existing playlist, the existing playlist will be overwritten without warning.
        [Parameter(Mandatory = $false)]
        [Switch]
        $Force
    )

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'

        if ($PsCmdlet.ParameterSetName -eq 'Name') {
            $Json = ([PSCustomObject]@{
                    name = $Name
                }) | ConvertTo-Json -Compress
        } else {
            $playlistObj = ConvertFrom-Json -InputObject $Json

            if ($null -eq $playlistObj.name) {
                throw 'Valid playlist JSON contains a "name" key with a value of your playlist name, but the JSON you provided doesn''t.'
            }

            $Name = $playlistObj.name
        }

        if ($PSCmdlet.ShouldProcess('', 'Are you sure you want to create the a new playlist?', '')) {

            # Determine if a playlist with this name already exists
            $playlistExists = ($null -ne (Get-FPPPlaylist -Name $Name))
            $overwritePlaylist = $false

            # Ask the user if they wants to overwrite an existing playlist
            if ($playlistExists -eq $true) {
                $shouldContinueMsg = "A playlist with name `"$Name`" already exists. Do you want to overwrite it?"
                if ($Force -or $PSCmdlet.ShouldContinue($shouldContinueMsg,'Overwrite Playlist?')) {
                    $overwritePlaylist = $true
                }
            }

            if ($playlistExists -eq $true -and $overwritePlaylist -eq $false) {
                Write-Host 'New playlist NOT created because it would have overwritten an existing playlist.'
                return
            }

            $result = Invoke-FPPApiMethod -EndpointAddress $endpointAddress -Method 'POST' -Body $Json -ContentType 'application/json'

            Write-Verbose $result

            Write-Host 'Playlist created'
        }
    } catch {
        throw "Failed to create playlist: $_"
    }
}