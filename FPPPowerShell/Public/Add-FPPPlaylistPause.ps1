function Add-FPPPlaylistPause {
    <#
    .SYNOPSIS
    Insert a pause into the specified section of a playlist

    .DESCRIPTION
    Insert an pause into the specified section of a playlist

    .EXAMPLE
    Add-FPPPlaylistPause -PlaylistName 'Christmas' -SectionName 'MainPlaylist' -DurationSeconds 60
    Adds a 1 minute pause to the "Christmas" playlist in the Main Playlist section.
    #>
    [CmdletBinding()]
    param (
        # The name of the playlist in which you want to insert the Overlay Model Effect.
        [Parameter(Mandatory = $true)]
        [String]
        $PlaylistName,

        # The section name where you want to insert the Overlay Model Effect.
        [Parameter(Mandatory = $false)]
        [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
        [String]
        $SectionName = 'MainPlaylist',

        # The amount of time in seconds you want this effect to be going.
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]
        $DurationSeconds
    )

    try {
        $SectionName = $SectionName.Substring(0,1).ToLower() + $SectionName.Substring(1)

        # Start the playlist item object
        $playlistItem = [PSCustomObject]@{
            type     = 'pause'
            enabled  = 1
            playOnce = 0
            duration = $DurationSeconds
        }

        $itemJson = $playlistItem | ConvertTo-Json -Compress
        Write-Verbose $itemJson

        Add-FPPPlaylistItem -PlaylistName $PlaylistName -SectionName $SectionName -ItemJson $itemJson
    } catch {
        throw "Failed to insert pause into playlist the `"$PlaylistName`" playlist: $_"
    }
}
$completerSB = {
    param($commandName,$parameterName,$stringMatch)
    Write-Verbose "CommandName: $commandName" # Needed to make PSSA happy since $commandName isn't used elsewhere
    Write-Verbose "ParameterName: $parameterName" # Needed to make PSSA happy since $parameterName isn't used elsewhere

    (Get-FPPPlaylist -Name "$stringMatch*").Name
}
Register-ArgumentCompleter -CommandName Add-FPPPlaylistPause -ParameterName PlaylistName -ScriptBlock $completerSB