function Get-FPPWledPalette {
    <#
    .SYNOPSIS
    List available WLED palette names.
    
    .DESCRIPTION
    List available WLED palette names.

    .EXAMPLE
    Get-FPPWledPalette
    Returns a list of available WLED palette names.
    #>
    [CmdletBinding()]
    param (
        # The name of the palette you want. Accepts wildcards.
        [Parameter(Mandatory = $false)]
        [String]
        $Name
    )

    $paletteNames = @(
        'Default',
        '* Random Cycle',
        '* Color 1',
        '* Colors 1&2',
        '* Color Gradient',
        '* Colors Only',
        'Party',
        'Cloud',
        'Lava',
        'Ocean',
        'Forest',
        'Rainbow',
        'Rainbow Bands',
        'Sunset',
        'Rivendell',
        'Breeze',
        'Red & Blue',
        'Yellowout',
        'Analogous',
        'Splash',
        'Pastel',
        'Sunset 2',
        'Beech',
        'Vintage',
        'Departure',
        'Landscape',
        'Beach',
        'Sherbet',
        'Hult',
        'Hult 64',
        'Drywet',
        'Jul',
        'Grintage',
        'Rewhi',
        'Tertiary',
        'Fire',
        'Icefire',
        'Cyane',
        'Light Pink',
        'Autumn',
        'Magenta',
        'Magred',
        'Yelmag',
        'Yelblu',
        'Orange & Teal',
        'Tiamat',
        'April Night',
        'Orangery',
        'C9',
        'Sakura',
        'Aurora',
        'Atlantica',
        'C9 2',
        'C9 New',
        'Temperature',
        'Aurora 2'
    )

    if (![string]::IsNullOrEmpty($Name)) {
        $namesFound = $paletteNames -like $Name
        $paletteNames = $paletteNames | Where-Object { $_ -in $namesFound }
    }

    return $paletteNames
}