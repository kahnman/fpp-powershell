BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-FPPWledPalette' {

        It 'should not throw' {
            { Get-FPPWledPalette } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-FPPWledPalette | Should -BeOfType System.Object
        }

        It 'should return a single object when "Name" is provided' {
            Get-FPPWledPalette -name 'Default' | Should -BeOfType System.Object
        }
    }
}