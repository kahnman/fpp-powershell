BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-WLEDPalette' {
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
    "Default","* Random Cycle","* Color 1","* Colors 1&2","* Color Gradient","* Colors Only","Party","Cloud","Lava","Ocean",
    "Forest","Rainbow","Rainbow Bands","Sunset","Rivendell","Breeze","Red & Blue","Yellowout","Analogous","Splash",
    "Pastel","Sunset 2","Beech","Vintage","Departure","Landscape","Beach","Sherbet","Hult","Hult 64",
    "Drywet","Jul","Grintage","Rewhi","Tertiary","Fire","Icefire","Cyane","Light Pink","Autumn",
    "Magenta","Magred","Yelmag","Yelblu","Orange & Teal","Tiamat","April Night","Orangery","C9","Sakura",
    "Aurora","Atlantica","C9 2","C9 New","Temperature","Aurora 2","Retro Clown","Candy","Toxy Reaf","Fairy Reaf",
    "Semi Blue","Pink Candy","Red Reaf","Aqua Flash","Yelblu Hot","Lite Light","Red Flash","Blink Red","Red Shift","Red Tide",
    "Candy2"
]
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Get-WLEDPalette -WLEDHost '127.0.0.1' } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-WLEDPalette -WLEDHost '127.0.0.1' | Should -BeOfType System.Object
        }
    }
}