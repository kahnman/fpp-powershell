BeforeAll {
    Import-Module $ModulePath -Force
}

Describe -Tags ('Unit') "$ModuleName Function Unit Tests" {
    Context 'Get-FPPWledEffect' {

        It 'should not throw' {
            { Get-FPPWledEffect } | Should -Not -Throw
        }

        It 'should return an object' {
            Get-FPPWledEffect | Should -BeOfType System.Object
        }

        It 'should return a single object when "Name" is provided' {
            Get-FPPWledEffect -name 'Android' | Should -BeOfType System.Object
        }
    }
}