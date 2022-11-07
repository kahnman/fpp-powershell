function New-FPPSession {
    <#
    .SYNOPSIS
    Establish a new context for FPP API session.
    
    .DESCRIPTION
    Set environment variables needed for standard FPP API calls.
    
    Variables that get set:
    $env:FPP_URL

    .PARAMETER HostUrl
    The URL for your FPP instance.

    .EXAMPLE
    New-FPPSession -HostUrl 'http://fpphost'
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [String]
        $HostUrl
    )

    try {
        if ($HostUrl.StartsWith('http') -eq $False) {
            throw 'HostUrl is not valid URL. Must begin with http or https.'
        }
    
        #Set API URL environment variable
        $env:FPP_URL = $HostUrl

        $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'commands'
        $response = Invoke-FPPApiMethod -EndpointAddress $endpointAddress
        #evaluate contents to confirm able to get health (minimum viable proof of valid API key)

        if ([string]::IsNullOrEmpty($response[0].name)) {
            throw 'Failed to connect to FPP API.'
        }
    } catch {
        throw "Unable to create FPP Session: $_"
    }
}