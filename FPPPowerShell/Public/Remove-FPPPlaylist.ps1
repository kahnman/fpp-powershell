function Remove-FPPPlaylist {
    <#
    .SYNOPSIS
    Delete a playlist from FPP.

    .DESCRIPTION
    Delete a playlist from FPP.

    .EXAMPLE
    Remove-FPPPlaylist -Name 'Christmas'
    Delete the playlist called "Christmas"
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        # The name of the playlist in which you want information.
        [Parameter(Mandatory = $true)]
        [String]
        $Name
    )

    if ($PSCmdlet.ShouldProcess('', "Are you sure you want to delete the `"$Name`" playlist?", '')) {
        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'playlist'
        $playlistEndpointAddress = $endpointAddress + "/$Name"
        try {
            $result = Invoke-FPPApiMethod -EndpointAddress $playlistEndpointAddress -Method 'DELETE'

            Write-Verbose "Returned Status: $($result.Status)"

            if ($result.Status -ne 'OK') {
                throw "FPP returned message `"$($result.Message)`""
            }

            Write-Host "`"$Name`" playlist deleted"
        } catch {
            throw "Failed to delete playlist `"$Name`": $_"
        }
    }
}