BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Add-FPPPlaylistItem' {
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
                return ('{"Status": "OK","Message": ""}' | ConvertFrom-Json)
            }
        }

        It 'should throw if PlaylistName is null' {
            { Add-FPPPlaylistItem -PlaylistName $null -ItemJson '{"fake":"json"}' } | Should -Throw "Cannot bind argument to parameter 'PlaylistName' because it is an empty string."
        }

        It 'should throw if incorrect SectionName provided' {
            { Add-FPPPlaylistItem -PlaylistName 'Christmas' -SectionName 'incorrectSectionName' -ItemJson '{"fake":"json"}' } | Should -Throw "Cannot validate argument on parameter 'SectionName'. The argument `"incorrectSectionName`" does not belong to the set `"LeadIn,MainPlaylist,LeadOut`" specified by the ValidateSet attribute. Supply an argument that is in the set and then try the command again."
        }

        It 'should throw if ItemJson is not provided' {
            { Add-FPPPlaylistItem -PlaylistName 'Christmas' -ItemJson $null } | Should -Throw "Cannot bind argument to parameter 'ItemJson' because it is an empty string."
        }

        It 'should throw if Invoke-FPPApiMethod returns error' {
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
                return ('{"Status": "ERROR","Message": "An error occured"}' | ConvertFrom-Json)
            }
            { Add-FPPPlaylistItem -PlaylistName 'Christmas' -ItemJson '{"fake":"json"}' } | Should -Throw "Failed to insert item into `"Christmas`" playlist: FPP returned message `"An error occured`""
        }

        It 'should not throw' {
            { Add-FPPPlaylistItem -PlaylistName 'Christmas' -ItemJson '{"fake":"json"}' } | Should -Not -Throw
        }
    }
        
}