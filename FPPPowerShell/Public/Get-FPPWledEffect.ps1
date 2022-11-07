function Get-FPPWledEffect {
    <#
    .SYNOPSIS
    List available WLED effect names.

    .DESCRIPTION
    List available WLED effect names.

    .EXAMPLE
    Get-FPPWledEffect
    Returns a list of available WLED effect names.
    #>
    [CmdletBinding()]
    param (
        # The name of the effect you want. Accepts wildcards.
        [Parameter(Mandatory = $false)]
        [String]
        $Name
    )

    $effectNames = @(
        'Stop Effects'
        'Android',
        'Aurora',
        'Blends',
        'Blink Rainbow',
        'Bouncing Balls',
        'Bpm',
        'Breathe',
        'Candle',
        'Candle Multi',
        'Candy Cane',
        'Chase',
        'Chase Flash',
        'Chase Flash Rnd',
        'Chase Rainbow',
        'Chase Random',
        'Chunchun',
        'Circus',
        'Colorful',
        'Colorloop',
        'Colortwinkles',
        'Colorwaves',
        'Dancing Shadows',
        'Dissolve',
        'Dissolve Rnd',
        'Drip',
        'Dynamic',
        'Dynamic Smooth',
        'Fade',
        'Fill Noise',
        'Fire 2012',
        'Fire Flicker',
        'Fireworks',
        'Fireworks 1D',
        'Fireworks Starburst',
        'Flow',
        'Glitter',
        'Gradient',
        'Halloween',
        'Halloween Eyes',
        'Heartbeat',
        'ICU',
        'Juggle',
        'Lake',
        'Lighthouse',
        'Lightning',
        'Loading',
        'Merry Christmas',
        'Meteor',
        'Meteor Smooth',
        'Multi Comet',
        'Noise 1',
        'Noise 2',
        'Noise 3',
        'Noise 4',
        'Noise Pal',
        'Oscillate',
        'Pacifica',
        'Palette',
        'Percent',
        'Phased',
        'Phased Noise',
        'Plasma',
        'Police',
        'Police All',
        'Popcorn',
        'Pride 2015',
        'Railway',
        'Rain',
        'Rainbow',
        'Rainbow Runner',
        'Random Colors',
        'Ripple',
        'Ripple Rainbow',
        'Running',
        'Running 2',
        'Saw',
        'Scan',
        'Scan Dual',
        'Scanner',
        'Scanner Dual',
        'Sine',
        'Sinelon',
        'Sinelon Dual',
        'Sinelon Rainbow',
        'Solid Glitter',
        'Solid Pattern',
        'Solid Pattern Tri',
        'Sparkle',
        'Sparkle Dark',
        'Sparkle Plus',
        'Spots',
        'Spots Fade',
        'Stream',
        'Stream 2',
        'Strobe',
        'Strobe Mega',
        'Strobe Rainbow',
        'Sunrise',
        'Sweep',
        'Sweep Random',
        'TV Simulator',
        'Theater',
        'Theater Rainbow',
        'Traffic Light',
        'Tri Chase',
        'Tri Fade',
        'Tri Wipe',
        'Twinkle',
        'Twinklecat',
        'Twinklefox',
        'Twinkleup',
        'Two Areas',
        'Two Dots',
        'Washing Machine',
        'Wipe',
        'Wipe Random'
    )

    if (![string]::IsNullOrEmpty($Name)) {
        $namesFound = $effectNames -like $Name
        $effectNames = $effectNames | Where-Object { $_ -in $namesFound }
    }

    return $effectNames
}