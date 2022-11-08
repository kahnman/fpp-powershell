BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-WLEDState' {
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
{
    "on": true,
    "bri": 25,
    "transition": 7,
    "ps": -1,
    "pl": -1,
    "nl": {
        "on": false,
        "dur": 60,
        "mode": 1,
        "tbri": 0,
        "rem": -1
    },
    "udpn": {
        "send": false,
        "recv": true
    },
    "lor": 0,
    "mainseg": 0,
    "seg": [
        {
            "id": 0,
            "start": 0,
            "stop": 150,
            "len": 150,
            "grp": 1,
            "spc": 0,
            "of": 0,
            "on": true,
            "frz": false,
            "bri": 255,
            "cct": 127,
            "col": [
                [
                    221,
                    0,
                    255,
                    0
                ],
                [
                    8,
                    255,
                    0,
                    0
                ],
                [
                    0,
                    0,
                    255,
                    0
                ]
            ],
            "fx": 2,
            "sx": 120,
            "ix": 190,
            "pal": 9,
            "sel": true,
            "rev": false,
            "mi": false
        }
    ]
}
'@ | ConvertFrom-Json)
            }
            Mock -ModuleName $ModuleName Get-WLEDEffect {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $WLEDHost
                )
                return @('Breathe')
            }
            Mock -ModuleName $ModuleName Get-WLEDPalette {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $WLEDHost
                )
                return @('Ocean')
            }
        }

        It 'should not throw' {
            { Get-WLEDState -WLEDHost '127.0.0.1' } | Should -Not -Throw
        }
    }
}