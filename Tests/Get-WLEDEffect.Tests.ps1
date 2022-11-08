BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-WLEDEffect' {
        BeforeAll {
            Mock -ModuleName $ModuleName Invoke-RestMethod {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $Uri,

                    [Parameter(Mandatory = $false)]
                    [ValidateSet('DELETE','GET','POST','PUT')]
                    [String]
                    $Method = 'GET',

                    [Parameter(Mandatory = $false)]
                    [Switch]
                    $UseBasicParsing
                )
                return (@'
[
    "Solid","Blink","Breathe","Wipe","Wipe Random","Random Colors","Sweep","Dynamic","Colorloop","Rainbow",
    "Scan","Scan Dual","Fade","Theater","Theater Rainbow","Running","Saw","Twinkle","Dissolve","Dissolve Rnd",
    "Sparkle","Sparkle Dark","Sparkle+","Strobe","Strobe Rainbow","Strobe Mega","Blink Rainbow","Android","Chase","Chase Random",
    "Chase Rainbow","Chase Flash","Chase Flash Rnd","Rainbow Runner","Colorful","Traffic Light","Sweep Random","Chase 2","Aurora","Stream",
    "Scanner","Lighthouse","Fireworks","Rain","Tetrix","Fire Flicker","Gradient","Loading","Police","Fairy",
    "Two Dots","Fairytwinkle","Running Dual","Halloween","Chase 3","Tri Wipe","Tri Fade","Lightning","ICU","Multi Comet",
    "Scanner Dual","Stream 2","Oscillate","Pride 2015","Juggle","Palette","Fire 2012","Colorwaves","Bpm","Fill Noise",
    "Noise 1","Noise 2","Noise 3","Noise 4","Colortwinkles","Lake","Meteor","Meteor Smooth","Railway","Ripple",
    "Twinklefox","Twinklecat","Halloween Eyes","Solid Pattern","Solid Pattern Tri","Spots","Spots Fade","Glitter","Candle","Fireworks Starburst",
    "Fireworks 1D","Bouncing Balls","Sinelon","Sinelon Dual","Sinelon Rainbow","Popcorn","Drip","Plasma","Percent","Ripple Rainbow",
    "Heartbeat","Pacifica","Candle Multi", "Solid Glitter","Sunrise","Phased","Twinkleup","Noise Pal", "Sine","Phased Noise",
    "Flow","Chunchun","Dancing Shadows","Washing Machine","Candy Cane","Blends","TV Simulator","Dynamic Smooth"
]
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Get-WLEDEffect -WLEDHost '127.0.0.1' } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-WLEDEffect -WLEDHost '127.0.0.1' | Should -BeOfType System.Object
        }
    }
}