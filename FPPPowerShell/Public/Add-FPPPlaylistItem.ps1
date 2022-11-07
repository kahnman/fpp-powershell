function Add-FPPPlaylistItem {
    <#
    .SYNOPSIS
    Insert an item into the specified section of a playlist

    .DESCRIPTION
    Insert an item into the specified section of a playlist

    .EXAMPLE
    $json = '{
        "type": "pause",
        "enabled": 1,
        "playOnce": 0,
        "duration": 8
        }'
    Add-FPPPlaylistItem -PlaylistName 'Christmas' -SectionName 'leadIn' -ItemJson $json
    Insert a pause item to the Lead In section of the playlist called "Christmas".
    #>
    [CmdletBinding()]
    param (
        # The name of the playlist in which you want to insert an item.
        [Parameter(Mandatory = $true)]
        [String]
        $PlaylistName,

        # The section name where you want to insert the item.
        [Parameter(Mandatory = $false)]
        [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
        [String]
        $SectionName = 'MainPlaylist',

        # The JSON that contains the definition of the item you want to insert.
        [Parameter(Mandatory = $true)]
        [String]
        $ItemJson
    )

    try {
        $SectionName = $SectionName.Substring(0,1).ToLower() + $SectionName.Substring(1)
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlist'

        $playlistEndpointAddress = $endpointAddress + "/$PlaylistName/$SectionName/item"

        $result = Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress -Method 'POST' -Body $ItemJson -ContentType 'application/json'

        Write-Verbose "Returned Status: $($result.Status)"

        if ($result.Status -ne 'OK') {
            throw "FPP returned message `"$($result.Message)`""
        }

        Write-Host "Item inserted into `"$PlaylistName`" playlist"
    } catch {
        throw "Failed to insert item into `"$PlaylistName`" playlist: $_"
    }
}
$completerSB = {
    param($commandName,$parameterName,$stringMatch)
    Write-Verbose "CommandName: $commandName" # Needed to make PSSA happy since $commandName isn't used elsewhere
    Write-Verbose "ParameterName: $parameterName" # Needed to make PSSA happy since $parameterName isn't used elsewhere

    (Get-FPPPlaylist -Name "$stringMatch*").Name
}
Register-ArgumentCompleter -CommandName Add-FPPPlaylistItem -ParameterName PlaylistName -ScriptBlock $completerSB