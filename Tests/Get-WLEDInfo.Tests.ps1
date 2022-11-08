BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-WLEDInfo' {
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
    "ver": "0.13.3",
    "vid": 2208222,
    "leds": {
        "count": 150,
        "pwr": 463,
        "fps": 41,
        "maxpwr": 850,
        "maxseg": 16,
        "seglc": [
            3
        ],
        "lc": 3,
        "rgbw": true,
        "wv": 2,
        "cct": 0
    },
    "str": false,
    "name": "WLED",
    "udpport": 21324,
    "live": false,
    "liveseg": -1,
    "lm": "",
    "lip": "",
    "ws": 1,
    "fxcount": 118,
    "palcount": 71,
    "wifi": {
        "bssid": "00:00:00:00:00:00",
        "rssi": -69,
        "signal": 62,
        "channel": 1
    },
    "fs": {
        "u": 40,
        "t": 1024,
        "pmt": 0
    },
    "ndc": 1,
    "arch": "esp8266",
    "core": "2_7_4_7",
    "lwip": 1,
    "freeheap": 18760,
    "uptime": 346888,
    "opt": 111,
    "brand": "WLED",
    "product": "FOSS",
    "mac": "000000000000",
    "ip": "127.0.0.1"
}
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Get-WLEDInfo -WLEDHost '127.0.0.1' } | Should -Not -Throw
        }
    }
}