BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-FPPModel' {
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
    "ChannelCount": 6144,
    "Name": "Matrix",
    "Orientation": "horizontal",
    "StartChannel": 1,
    "StartCorner": "TL",
    "StrandsPerString": 1,
    "StringCount": 32
    },
    {
    "ChannelCount": 6144,
    "Name": "Matrix2",
    "Orientation": "horizontal",
    "StartChannel": 6145,
    "StartCorner": "BL",
    "StrandsPerString": 1,
    "StringCount": 16
    }
]
'@ | ConvertFrom-Json)
            }
        }

        It 'should not throw' {
            { Get-FPPModel } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-FPPModel | Should -BeOfType System.Object
        }

        It 'should return a single object when "Name" is provided' {
            Get-FPPModel -name 'Matrix' | Should -BeOfType System.Object
        }
    }
}