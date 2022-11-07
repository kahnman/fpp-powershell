function Get-FPPModel {
    <#
    .SYNOPSIS
    Get information about one multiple models. If Name isn't provided, all models are listed.
    
    .DESCRIPTION
    Get information about one multiple models. If Name isn't provided, all models are listed.

    .EXAMPLE
    Get-FPPModel
    List all models

    .EXAMPLE
    Get-FPPModel -Name 'Matrix'
    Show information about the model with name "Matrix"

    .EXAMPLE
    Get-FPPModel -Name 'Matrix', 'Matrix2'
    Show information about the models with names "Matrix" and "Matrix2"
    #>
    [CmdletBinding()]
    param (
        # The name of one or more models in you want information.
        [Parameter(Mandatory = $false)]
        [String[]]
        $Name
    )

    $endpointAddress = Get-FPPEndpointAddress -EndpointAlias 'models'

    try {
        $result = Invoke-FPPApiMethod -EndpointAddress $endpointAddress
    } catch {
        throw "Failed to get playlist information: $_"
    }

    if (![string]::IsNullOrEmpty($Name)) {
        $namesFound = $result.Name -like $Name
        $result = $result | Where-Object { $_.Name -in $namesFound }
    }

    return $result
}