function Start-FPPPlaylist {
    <#
    .SYNOPSIS
    Start the specified playlist.

    .DESCRIPTION
    Start the specified playlist.

    .EXAMPLE
    Start-FPPPlaylist -PlaylistName "Christmas"
    Starts the playlist called "Christmas"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
    param (
        # The name of the playlist that you want to start.
        [Parameter(Mandatory = $true)]
        [String]
        $PlaylistName
    )

    try {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlist'
        $playlistEndpointAddress = $endpointAddress + "/$PlaylistName/start"

        if ($PSCmdlet.ShouldProcess('', "Are you sure you want to start the `"$PlaylistName`" playlist?", '')) {
            $null = Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress

            Write-Host 'Playlist starting'
        }
    } catch {
        throw "Failed to start the `"$PlaylistName`" playlist: $_"
    }
}
$completerSB = {
    param($commandName,$parameterName,$stringMatch)
    Write-Verbose "CommandName: $commandName" # Needed to make PSSA happy since $commandName isn't used elsewhere
    Write-Verbose "ParameterName: $parameterName" # Needed to make PSSA happy since $parameterName isn't used elsewhere

    (Get-FPPPlaylist -Name "$stringMatch*").Name
}
Register-ArgumentCompleter -CommandName Start-FPPPlaylist -ParameterName PlaylistName -ScriptBlock $completerSB