function Invoke-FPPApiMethod {
    <#
.SYNOPSIS
    Wrapper for invoke of API call using Invoke-RESTMethod.
.DESCRIPTION
    This function is used to actually invoke the API call to the a supported API. Invoke-RESTMethod is used to make the API calls.

.PARAMETER EndpointAddress
Partial api endpoint address from the API root address. For example if you want to send a request to the api endpoint http://fpp/api/playlists
then this parameter should be set to 'api/playlists'.

The root api endpoint (http://fpp/) will be pulled from the environment variable FPP_URL
which gets set by the New-FPPSession function

.PARAMETER Method
'DELETE','GET','POST','PUT'

.PARAMETER Body
Body of request.

.PARAMETER ContentType
Content type of the web request. ContentType will be overridden when a MultipartFormDataContent object is supplied for Body.

.EXAMPLE
    Invoke-HETApiMethod -EndpointAddress '/api/playlists'
    Performs an Invoke-RESTMethod call to the EndpointAddress given using default values for the rest of the parameters.
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $EndpointAddress,

        [Parameter(Mandatory = $false)]
        [ValidateSet('DELETE','GET','POST','PUT')]
        [String]
        $Method = 'GET',

        [Parameter(Mandatory = $false)]
        [String]
        $Body,

        [Parameter(Mandatory = $false)]
        [String]
        $ContentType
    )

    try {
        if ([string]::IsNullOrEmpty($env:FPP_URL)) {
            throw 'FPP URL is not set. Run New-FPPSession to set the FPP URL.'
        }
    
        $apiUrl = $env:FPP_URL
    
        # Prefix base URL to EndpointAddress that is passed
        if ($EndpointAddress.StartsWith('/') -eq $False) {
            $EndpointAddress = '/' + $EndpointAddress
        }
        $uri = $apiUrl + $EndpointAddress

        Write-Verbose "URL: $uri"

        $webRequestSplat = @{
            Uri             = $uri
            Method          = $Method
            UseBasicParsing = $true
        }

        if (![string]::IsNullOrEmpty($ContentType)) {
            $null = $webRequestSplat.Add('ContentType', $ContentType)
        }

        if (![string]::IsNullOrEmpty($Body)) {
            $webRequestSplat.Add('Body',$Body)
        }

        $returnedData = Invoke-RestMethod @webRequestSplat

        return $returnedData

    } catch {
        throw $_
    }
}
