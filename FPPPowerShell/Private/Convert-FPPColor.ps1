function Convert-FPPColor {
    <#
    .SYNOPSIS
    This color converter gives you the hexadecimal values of your RGB colors and vice versa (RGB to HEX)

    .DESCRIPTION
    This color converter gives you the hexadecimal values of your RGB colors and vice versa (RGB to HEX). Use it to convert your colors and prepare your graphics and HTML web pages.
    This function was taken and modified from the Convert-Color function in the PSSharedGoods (https://github.com/EvotecIT/PSSharedGoods) module.

    .PARAMETER RBG
    Enter the Red Green Blue value comma separated. Red: 51 Green: 51 Blue: 204 for example needs to be entered as 51,51,204

    .PARAMETER HEX
    Enter the Hex value to be converted. Do not use the '#' symbol. (Ex: 3333CC converts to Red: 51 Green: 51 Blue: 204)

    .EXAMPLE
    Convert-FPPColor -HEX FFFFFF
    Converts hex value FFFFFF to RGB
 
    .EXAMPLE
    Convert-FPPColor -RGB 123,200,255
    Converts Red = 123 Green = 200 Blue = 255 to Hex value

    .LINK
    https://github.com/EvotecIT/PSSharedGoods/blob/master/Public/Converts/Convert-Color.ps1

    .LINK
    https://github.com/EvotecIT/PSSharedGoods

    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'RGB', Position = 0)]
        [ValidatePattern('^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$')]
        [array]
        $RGB,

        [Parameter(Mandatory = $true, ParameterSetName = 'HEX', Position = 0)]
        [ValidatePattern('([0-9a-fA-F]){3}')]
        [string]
        $HEX
    )
    switch ($PsCmdlet.ParameterSetName) {
        'RGB' {
            if ($null -eq $RGB[2]) {
                throw 'Value missing. Please enter all three values seperated by comma.'
            }

            $red = [convert]::Tostring($RGB[0], 16)
            $green = [convert]::Tostring($RGB[1], 16)
            $blue = [convert]::Tostring($RGB[2], 16)

            if ($red.Length -eq 1) {
                $red = '0' + $red
            }

            if ($green.Length -eq 1) {
                $green = '0' + $green
            }

            if ($blue.Length -eq 1) {
                $blue = '0' + $blue
            }

            ('{0}{1}{2}' -f $red, $green, $blue)
        }
        'HEX' {
            $red = $HEX.Remove(2, 4)
            $green = $HEX.Remove(4, 2)
            $green = $green.Remove(0, 2)
            $blue = $hex.Remove(0, 4)

            $red = [convert]::ToInt32($red, 16)
            $green = [convert]::ToInt32($green, 16)
            $blue = [convert]::ToInt32($blue, 16)

            ('{0}, {1}, {2}' -f $red, $green, $blue)
        }
    }
}