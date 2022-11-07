function Get-FPPEndpointAddress {
    <#
    .SYNOPSIS
        Get the endpoint address for the given supported API endpoint alias
    .DESCRIPTION
        Get the endpoint address for the given supported API endpoint alias
    .EXAMPLE
        Get-FPPEndpointAddress -Endpoint 'playlists'
        Returns the FPP endpoint address /api/playlists
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('commands','playlists','playlist','models')]
        [String]$EndpointAlias
    )

    switch ($EndpointAlias) {
        'commands' {
            $endpointAddress = '/api/commands';
            break
        }
        'playlists' {
            $endpointAddress = '/api/playlists';
            break
        }
        'playlist' {
            $endpointAddress = '/api/playlist';
            break
        }
        'models' {
            $endpointAddress = '/api/models';
            break
        }
    }

    return $endpointAddress
}