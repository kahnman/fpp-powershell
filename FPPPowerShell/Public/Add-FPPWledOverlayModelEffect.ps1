function Add-FPPWledOverlayModelEffect {
    <#
    .SYNOPSIS
    Insert an Overlay Model Effect into the specified section of a playlist

    .DESCRIPTION
    Insert an Overlay Model Effect into the specified section of a playlist

    .EXAMPLE
    Add-FPPWledOverlayModelEffect -PlaylistName 'Christmas' -SectionName 'leadIn'
    #>
    [CmdletBinding()]
    param (
        # The name of the playlist in which you want to insert the Overlay Model Effect.
        [Parameter(Mandatory = $true)]
        [String]
        $PlaylistName,

        # The section name where you want to insert the Overlay Model Effect.
        [Parameter(Mandatory = $false)]
        [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
        [String]
        $SectionName = 'MainPlaylist',

        # The note for this playlist Overlay Model Effect.
        [Parameter(Mandatory = $false)]
        [String]
        $Note,

        # The models in which this Overlay Model Effect will be applied.
        [Parameter(Mandatory = $true)]
        [String[]]
        $Models,

        # The Auto Enable/Disable value.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Enabled','False','Transparent','Transparent RGB')]
        [String]
        $AutoEnable = 'Enabled',

        # The Effect to display.
        [Parameter(Mandatory = $true)]
        [String]
        $Effect,

        # The buffer mapping for the Overlay Model Effect.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Horizontal','Vertical','Horizontal Flipped','Vertical Flipped')]
        [String]
        $BufferMapping = 'Horizontal',

        # The brightness of the effect.
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 255)]
        [Int]
        $Brightness = 128,

        # The speed of the effect.
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 255)]
        [Int]
        $Speed = 128,

        # The intensity of the effect.
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 255)]
        [Int]
        $Intensity = 128,

        # The color palette to use.
        [Parameter(Mandatory = $false)]
        [String]
        $Palette,

        # The first color to use in hex color code format.
        [Parameter(Mandatory = $false)]
        [ValidatePattern('([0-9a-fA-F]){3}')]
        [String]
        $Color1 = 'ff0000',

        # The second color to use in hex color code format.
        [Parameter(Mandatory = $false)]
        [ValidatePattern('([0-9a-fA-F]){3}')]
        [String]
        $Color2 = '0000ff',

        # The third color to use in hex color code format.
        [Parameter(Mandatory = $false)]
        [ValidatePattern('([0-9a-fA-F]){3}')]
        [String]
        $Color3 = '000000',

        # The amount of time in seconds you want this effect to be going.
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, [int]::MaxValue)]
        [Int]
        $DurationSeconds = 0
    )

    try {
        $SectionName = $SectionName.Substring(0,1).ToLower() + $SectionName.Substring(1)

        if ($Effect -ne 'Stop Effects') {
            $Effect = "WLED - $Effect"
        }

        $ModelsCsv = $Models -join ','

        # Start the playlist item object
        $playlistItem = [PSCustomObject]@{
            type     = 'command'
            enabled  = 1
            playOnce = 0
            command  = 'Overlay Model Effect'
            note     = $Note
            args     = @(
                $ModelsCsv,
                $AutoEnable,
                $Effect,
                $BufferMapping,
                $Brightness,
                $Speed,
                $Intensity,
                $Palette,
                "#$Color1",
                "#$Color2",
                "#$Color3"
            )
        }

        $itemJson = $playlistItem | ConvertTo-Json -Compress
        Write-Verbose $itemJson

        Write-Verbose "$SectionName $PlaylistName"

        Add-FPPPlaylistItem -PlaylistName $PlaylistName -SectionName $SectionName -ItemJson $itemJson

        if ($DurationSeconds -gt 0) {
            Add-FPPPlaylistPause -PlaylistName $PlaylistName -SectionName $SectionName -DurationSeconds $DurationSeconds
        }
    } catch {
        throw "Failed to insert WLED effect into playlist the `"$PlaylistName`" playlist: $_"
    }
}
$completerSB = {
    param($commandName,$parameterName,$stringMatch)
    Write-Verbose "CommandName: $commandName" # Needed to make PSSA happy since $commandName isn't used elsewhere
    switch ($parameterName) {
        'Models' {
            (Get-FPPModel -Name "$stringMatch*").Name
            break
        }
        'Effect' {
            Get-FPPWledEffect -Name "$stringMatch*"
            break
        }
        'Palette' {
            Get-FPPWledPalette -Name "$stringMatch*"
            break
        }
        'PlaylistName' {
            (Get-FPPPlaylist -Name "$stringMatch*").Name
            break
        }
    }
}
Register-ArgumentCompleter -CommandName Add-FPPWledOverlayModelEffect -ParameterName Models -ScriptBlock $completerSB
Register-ArgumentCompleter -CommandName Add-FPPWledOverlayModelEffect -ParameterName Effect -ScriptBlock $completerSB
Register-ArgumentCompleter -CommandName Add-FPPWledOverlayModelEffect -ParameterName Palette -ScriptBlock $completerSB
Register-ArgumentCompleter -CommandName Add-FPPWledOverlayModelEffect -ParameterName PlaylistName -ScriptBlock $completerSB