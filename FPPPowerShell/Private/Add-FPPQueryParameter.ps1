function Add-FPPQueryParameter {
    <#
    .SYNOPSIS
    Correctly formats the parameter string for FPP API call

    .DESCRIPTION
    Correctly formats the parameter string for FPP API call

    .EXAMPLE
    Add-FPPQueryParameter -Url 'https://fpp/api/playlists' -QueryParameter @{search_fields = "name"; search = "*"}

    Adds the 'name' and 'search' parameters to the end of the Url, so effectively becomes...
    https://fpp/api/playlists?search_fields=name&search=`"*`"
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$Url,

        [Parameter(Mandatory = $true)]
        [Hashtable]$QueryParameter
    )

    $urlParams = ''

    foreach ($paramKey in $QueryParameter.Keys) {
        if (![string]::IsNullOrEmpty($QueryParameter[$paramKey])) {

            if ([string]::IsNullOrEmpty($urlParams)) {
                $paramSeparator = '?'
            } else {
                $paramSeparator = '&'
            }

            $urlParams += $paramSeparator + $paramKey + '=' + $QueryParameter[$paramKey]
        }
    }
    $urlWithParams = $Url + $urlParams

    return $urlWithParams
}