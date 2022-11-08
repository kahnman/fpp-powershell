BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Copy-FPPEffectFromWled' {
        BeforeAll {
            Mock -ModuleName $ModuleName Get-WLEDState {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $WLEDHost
                )
                return ('{"on":true,"bri":25,"transition":7,"ps":-1,"pl":-1,"nl":{"on":false,"dur":60,"mode":1,"tbri":0,"rem":-1},"udpn":{"send":false,"recv":true},"lor":0,"mainseg":0,"seg":[{"id":0,"start":0,"stop":150,"len":150,"grp":1,"spc":0,"of":0,"on":true,"frz":false,"bri":255,"cct":127,"col":[[221,0,255,0],[8,255,0,0],[0,0,255,0]],"fx":2,"sx":120,"ix":190,"pal":9,"sel":true,"rev":false,"mi":false,"fxName":"Breathe","palName":"Ocean"}]}' | ConvertFrom-Json)
            }
            Mock -ModuleName $ModuleName Get-FPPWledEffect {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $Name
                )
                return 'Android'
            }
            Mock -ModuleName $ModuleName Get-FPPWledPalette {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $Name
                )
                return 'Default'
            }
            Mock -ModuleName $ModuleName Add-FPPPlaylistItem {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $PlaylistName,

                    [Parameter(Mandatory = $false)]
                    [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
                    [String]
                    $SectionName = 'MainPlaylist',

                    [Parameter(Mandatory = $true)]
                    [String]
                    $ItemJson
                )
            }
        }

        It 'should not throw' {
            {
                $splat = @{
                    WLEDHost        = '127.0.0.1'
                    WLEDSegment     = 0
                    PlaylistName    = 'Christmas'
                    SectionName     = 'LeadOut'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Brightness      = 255
                    BufferMapping   = 'Horizontal Flipped'
                    DurationSeconds = 1
                }
                Copy-FPPEffectFromWled @splat
            } | Should -Not -Throw
        }

        It 'should throw if PlaylistName is null' {
            {
                $splat = @{
                    WLEDHost        = '127.0.0.1'
                    WLEDSegment     = 0
                    PlaylistName    = $null
                    SectionName     = 'LeadOut'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Brightness      = 255
                    BufferMapping   = 'Horizontal Flipped'
                    DurationSeconds = 1
                }
                Copy-FPPEffectFromWled @splat
            } | Should -Throw "Cannot bind argument to parameter 'PlaylistName' because it is an empty string."
        }

        It 'should throw if incorrect SectionName provided' {
            {
                $splat = @{
                    WLEDHost        = '127.0.0.1'
                    WLEDSegment     = 0
                    PlaylistName    = 'Christmas'
                    SectionName     = 'incorrectSectionName'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Brightness      = 255
                    BufferMapping   = 'Horizontal Flipped'
                    DurationSeconds = 1
                }
                Copy-FPPEffectFromWled @splat
            } | Should -Throw "Cannot validate argument on parameter 'SectionName'. The argument `"incorrectSectionName`" does not belong to the set `"LeadIn,MainPlaylist,LeadOut`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }

        It 'should throw if Add-FPPPlaylistItem returns error' {
            Mock -ModuleName $ModuleName Add-FPPPlaylistItem {
                param (
                    [Parameter(Mandatory = $true)]
                    [String]
                    $PlaylistName,

                    [Parameter(Mandatory = $false)]
                    [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
                    [String]
                    $SectionName = 'MainPlaylist',

                    [Parameter(Mandatory = $true)]
                    [String]
                    $ItemJson
                )
                throw 'Add-FPPPlaylistItem threw and error'
            }
            {
                $splat = @{
                    WLEDHost        = '127.0.0.1'
                    WLEDSegment     = 0
                    PlaylistName    = 'Christmas'
                    SectionName     = 'LeadOut'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Brightness      = 255
                    BufferMapping   = 'Horizontal Flipped'
                    DurationSeconds = 1
                }
                Copy-FPPEffectFromWled @splat
            } | Should -Throw 'Failed to insert WLED effect into playlist the "Christmas" playlist: Add-FPPPlaylistItem threw and error'
        }
    }
        
}