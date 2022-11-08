function Copy-FPPEffectFromWled {
    <#
    .SYNOPSIS
    Copy the currently playing effect on a WLED controller to the specified FPP playlist.

    .DESCRIPTION
    Copy the currently playing effect on a WLED controller to the specified FPP playlist.

    .EXAMPLE
    Copy-FPPEffectFromWled
    #>
    [CmdletBinding()]
    param (
        # The hostname or IP address of the WLED controller.
        [Parameter(Mandatory = $true)]
        [String]
        $WLEDHost,

        # The ID of the WLED segment in which you want to copy the effect from.
        [Parameter(Mandatory = $false)]
        [Int]
        $WLEDSegment = 0,

        # The name of the playlist in which you want to insert the copied effect.
        [Parameter(Mandatory = $true)]
        [String]
        $PlaylistName,

        # The section name where you want to insert the copied effect.
        [Parameter(Mandatory = $false)]
        [ValidateSet('LeadIn','MainPlaylist','LeadOut')]
        [String]
        $SectionName = 'MainPlaylist',

        # The models in which you want to apply the copied effect.
        [Parameter(Mandatory = $true)]
        [String[]]
        $Models,

        # The brightness of the effect.
        [Parameter(Mandatory = $false)]
        [ValidateRange(0, 255)]
        [Int]
        $Brightness,

        # The buffer mapping for the Overlay Model Effect.
        [Parameter(Mandatory = $false)]
        [ValidateSet('Horizontal','Vertical','Horizontal Flipped','Vertical Flipped')]
        [String]
        $BufferMapping = 'Horizontal',

        # The amount of time in seconds you want this effect to be going.
        [Parameter(Mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [Int]
        $DurationSeconds
    )

    try {
        $SectionName = $SectionName.Substring(0,1).ToLower() + $SectionName.Substring(1)

        $ModelsCsv = $Models -join ','

        # Get information from the WLED controller
        $wledState = Get-WLEDState -WLEDHost $WLEDHost

        if ($null -eq $wledState) {
            throw 'Failed to get information from the WLED host.'
        }

        if ($null -eq $wledState.seg[$WLEDSegment]) {
            throw "The `"$WLEDSegment`" WLED segement doesn't exist."
        }

        $wledEffectName = $wledState.seg[$WLEDSegment].fxName
        $wledPaletteName = $wledState.seg[$WLEDSegment].palName
        $wledSpeed = $wledState.seg[$WLEDSegment].sx
        $wledIntensity = $wledState.seg[$WLEDSegment].ix
        $wledColor = $wledState.seg[$WLEDSegment].col

        if ($null -eq $Brightness) {
            $Brightness = $wledState.seg[$WLEDSegment].bri
        }

        # Convert the RGB values in WLED for color1, color2 and color3 into HEX, which is what FPP needs.
        $wledColorsHEX = @{}
        for ($i = 0; $i -lt 3; $i++) {
            $wledRGB = $wledColor[$i][0..2] # Only use the first 3 numbers of this value, which should be Red, Green, Blue
            $wledHEX = Convert-FPPColor -RGB $wledRGB
            $wledColorsHEX[$i] = "#$wledHEX"
        }

        if ($null -eq (Get-FPPWledEffect -Name $wledEffectName)) {
            throw "The WLED effect `"$wledEffectName`" doesn't exist on your Kulp controller"
        }

        if ($null -eq (Get-FPPWledPalette -Name $wledPaletteName)) {
            throw "The WLED palette `"$wledPaletteName`" doesn't exist on your Kulp controller"
        }

        # Start the playlist item object
        $playlistItem = [PSCustomObject]@{
            type     = 'command'
            enabled  = 1
            playOnce = 0
            command  = 'Overlay Model Effect'
            note     = ''
            args     = @(
                $ModelsCsv,
                'Enabled',
                "WLED - $wledEffectName",
                $BufferMapping,
                $Brightness,
                $wledSpeed,
                $wledIntensity,
                $wledPaletteName,
                $wledColorsHEX[0],
                $wledColorsHEX[1],
                $wledColorsHEX[2]
            )
        }

        $itemJson = $playlistItem | ConvertTo-Json -Compress
        Write-Verbose $itemJson

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
        'PlaylistName' {
            (Get-FPPPlaylist -Name "$stringMatch*").Name
            break
        }

    }
}
Register-ArgumentCompleter -CommandName Copy-FPPEffectFromWled -ParameterName Models -ScriptBlock $completerSB
Register-ArgumentCompleter -CommandName Copy-FPPEffectFromWled -ParameterName PlaylistName -ScriptBlock $completerSB