BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Add-FPPPlaylistPause' {
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
            { Add-FPPPlaylistPause -PlaylistName 'Christmas' -DurationSeconds 1 } | Should -Not -Throw
        }

        It 'should throw if PlaylistName is null' {
            { Add-FPPPlaylistPause -PlaylistName $null -DurationSeconds 1 } | Should -Throw "Cannot bind argument to parameter 'PlaylistName' because it is an empty string."
        }

        It 'should throw if incorrect SectionName provided' {
            { Add-FPPPlaylistPause -PlaylistName 'Christmas' -SectionName 'incorrectSectionName' -DurationSeconds 1 } | Should -Throw "Cannot validate argument on parameter 'SectionName'. The argument `"incorrectSectionName`" does not belong to the set `"LeadIn,MainPlaylist,LeadOut`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }

        It 'should throw if DurationSeconds is less than 1' {
            { Add-FPPPlaylistPause -PlaylistName 'Christmas' -DurationSeconds 0 } | Should -Throw "Cannot validate argument on parameter 'DurationSeconds'. The 0 argument is less than the minimum allowed range of 1. Supply an argument that is greater than or equal to 1 and then try the command again."
        }

        It 'should throw if DurationSeconds is not a number' {
            { Add-FPPPlaylistPause -PlaylistName 'Christmas' -DurationSeconds 'a' } | Should -Throw "Cannot process argument transformation on parameter 'DurationSeconds'. Cannot convert value `"a`" to type `"System.Int32`". Error: `"Input string was not in a correct format.`""
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
            { Add-FPPPlaylistPause -PlaylistName 'Christmas' -DurationSeconds 1 } | Should -Throw 'Failed to insert pause into playlist the "Christmas" playlist: Add-FPPPlaylistItem threw and error'
        }
    }
}