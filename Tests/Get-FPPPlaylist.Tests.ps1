BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-FPPPlaylist' {
        BeforeAll {
            Mock -ModuleName $ModuleName Invoke-FPPApiMethod {
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
                return (@'
[
    {
        "name": "Playlist1",
        "mainPlaylist": [
            {
                "type": "pause",
                "enabled": 1,
                "playOnce": 0,
                "duration": 5
            }
        ],
        "playlistInfo": {
            "total_duration": 8,
            "total_items": 1
        }
    },
    {
        "name": "Playlist2",
        "mainPlaylist": [
            {
                "type": "pause",
                "enabled": 1,
                "playOnce": 0,
                "duration": 10
            }
        ],
        "playlistInfo": {
            "total_duration": 15,
            "total_items": 2
        }
    }
]
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Get-FPPPlaylist } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-FPPPlaylist | Should -BeOfType System.Object
        }

        It 'should return a single object when "Name" is provided' {
            Get-FPPPlaylist -Name 'Playlist1' | Should -BeOfType System.Object
        }
    }
}