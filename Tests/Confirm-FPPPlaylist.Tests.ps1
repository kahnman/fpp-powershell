BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Confirm-FPPPlaylist' {
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
    "name": "Delete_Media",
    "valid": false,
    "message": [
      "Invalid Playlist Christmas Every Day.mp3"
    ]
  },
  {
    "name": "Delete_Sequence",
    "valid": false,
    "message": [
      "Invalid mediaName Christmas Every Day.mp3",
      "Invalid Sequence Christmas Every Day_128.fseq"
    ]
  },
  {
    "name": "Delete_Sequence2",
    "valid": false,
    "message": [
      "Invalid Sequence Christmas Every Day_128.fseq"
    ]
  },
  {
    "name": "Parent_delete_test",
    "valid": false,
    "message": [
      "Invalid Playlist deleted_playlist"
    ]
  },
  {
    "name": "Test1",
    "valid": true,
    "message": []
  },
  {
    "name": "Test2",
    "valid": true,
    "message": []
  },
  {
    "name": "Test3",
    "valid": true,
    "message": []
  },
  {
    "name": "Test4",
    "valid": true,
    "message": []
  }
]
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Confirm-FPPPlaylist } | Should -Not -Throw
        }
    }
        
}