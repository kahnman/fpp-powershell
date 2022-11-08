BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Add-FPPWledOverlayModelEffect' {
        BeforeAll {
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
                    PlaylistName    = 'Christmas'
                    SectionName     = 'LeadIn'
                    Note            = 'Fake Note'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    AutoEnable      = 'False'
                    Effect          = 'Bars'
                    BufferMapping   = 'Horizontal Flipped'
                    Brightness      = 255
                    Speed           = 255
                    Intensity       = 255
                    Palette         = 'Default'
                    Color1          = '00ff00'
                    Color2          = 'ff0000'
                    Color3          = '0000ff'
                    DurationSeconds = 1
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Not -Throw
        }

        It 'should throw if PlaylistName is null' {
            {
                $splat = @{
                    PlaylistName = $null
                    Models       = @('Fake Model 1', 'Fake_Model_2')
                    Effect       = 'Bars'
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Throw "Cannot bind argument to parameter 'PlaylistName' because it is an empty string."
        }

        It 'should throw if incorrect SectionName provided' {
            {
                $splat = @{
                    PlaylistName = 'Christmas'
                    SectionName  = 'incorrectSectionName'
                    Models       = @('Fake Model 1', 'Fake_Model_2')
                    Effect       = 'Bars'
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Throw "Cannot validate argument on parameter 'SectionName'. The argument `"incorrectSectionName`" does not belong to the set `"LeadIn,MainPlaylist,LeadOut`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }

        It 'should throw if DurationSeconds is less than 0' {
            {
                $splat = @{
                    PlaylistName    = 'Christmas'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Effect          = 'Bars'
                    DurationSeconds = -1
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Throw "Cannot validate argument on parameter 'DurationSeconds'. The -1 argument is less than the minimum allowed range of 0. Supply an argument that is greater than or equal to 0 and then try the command again."
        }

        It 'should throw if DurationSeconds is not a number' {
            {
                $splat = @{
                    PlaylistName    = 'Christmas'
                    Models          = @('Fake Model 1', 'Fake_Model_2')
                    Effect          = 'Bars'
                    DurationSeconds = 'a'
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Throw "Cannot process argument transformation on parameter 'DurationSeconds'. Cannot convert value `"a`" to type `"System.Int32`". Error: `"Input string was not in a correct format.`""
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
                    PlaylistName = 'Christmas'
                    Models       = @('Fake Model 1', 'Fake_Model_2')
                    Effect       = 'Bars'
                }
                Add-FPPWledOverlayModelEffect @splat
            } | Should -Throw 'Failed to insert WLED effect into playlist the "Christmas" playlist: Add-FPPPlaylistItem threw and error'
        }
    }
}