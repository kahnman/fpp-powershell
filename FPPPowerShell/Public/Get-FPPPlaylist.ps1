function Get-FPPPlaylist {
    <#
    .SYNOPSIS
    Get information about one or more FP playlist. If you do not specify a playlist name, all playlist names are listed.
    
    .DESCRIPTION
    Get information about one or more FP playlist. If you do not specify a playlist name, all playlist names are listed.

    .EXAMPLE
    Get-FPPPlaylist
    List the name of every playlist

    .EXAMPLE
    Get-FPPPlaylist -Name 'Christmas'
    Show detailed information about the playlist with name "Christmas"
    #>
    [CmdletBinding()]
    param (
        # The name of the playlist in which you want information.
        [Parameter(Mandatory = $false)]
        [String]
        $Name
    )

    try {
        # Get a list of all playlists so we can get and return information about each of them
        $playlistsEndpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlists'

        $playlistNames = Invoke-FPPApiMethod -EndpointAddress $playlistsEndpointAddress
    } catch {
        throw "Failed to get a list of playlists: $_"
    }

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlist'

        $playlistData = foreach ($playlistName in $playlistNames) {
            $playlistEndpointAddress = $endpointAddress + "/$playlistName"
            Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress
        }

        if (![string]::IsNullOrEmpty($Name)) {
            $namesFound = $playlistData.name -like $Name
            $playlistData = $playlistData | Where-Object { $_.name -in $namesFound }
        }

        return $playlistData
    } catch {
        throw "Failed to get playlist information: $_"
    }
}
$completerSB = {
    param($commandName,$parameterName,$stringMatch)
    Write-Verbose "CommandName: $commandName" # Needed to make PSSA happy since $commandName isn't used elsewhere
    Write-Verbose "ParameterName: $parameterName" # Needed to make PSSA happy since $parameterName isn't used elsewhere

    (Get-FPPPlaylist -Name "$stringMatch*").Name
}
Register-ArgumentCompleter -CommandName Get-FPPPlaylist -ParameterName Name -ScriptBlock $completerSB