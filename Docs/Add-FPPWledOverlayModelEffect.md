---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Add-FPPWledOverlayModelEffect

## SYNOPSIS
Insert an Overlay Model Effect into the specified section of a playlist

## SYNTAX

```
Add-FPPWledOverlayModelEffect [-PlaylistName] <String> [[-SectionName] <String>] [[-Note] <String>]
 [-Models] <String[]> [[-AutoEnable] <String>] [-Effect] <String> [[-BufferMapping] <String>]
 [[-Brightness] <Int32>] [[-Speed] <Int32>] [[-Intensity] <Int32>] [[-Palette] <String>] [[-Color1] <String>]
 [[-Color2] <String>] [[-Color3] <String>] [[-DurationSeconds] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Insert an Overlay Model Effect into the specified section of a playlist

## EXAMPLES

### EXAMPLE 1
```
$splatParams = @{
    PlaylistName = 'Christmas'
    SectionName = 'LeadIn'
    Models = 'Matrix1','Matrix2'
    Effect = 'Twinkle'
    Palette = 'Lava'
    Brightness = 52
    Speed = 200
    Intensity = 100
    Color1 = 'ff0000'
    Color2 = '00ff00'
    Color3 = '0000ff'
}
Add-FPPWledOverlayModelEffect @splatParams
```

## PARAMETERS

### -AutoEnable
The Auto Enable/Disable value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Enabled
Accept pipeline input: False
Accept wildcard characters: False
```

### -Brightness
The brightness of the effect.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 128
Accept pipeline input: False
Accept wildcard characters: False
```

### -BufferMapping
The buffer mapping for the Overlay Model Effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Horizontal
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color1
The first color to use in hex color code format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: Ff0000
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color2
The second color to use in hex color code format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0000ff
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color3
The third color to use in hex color code format.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 000000
Accept pipeline input: False
Accept wildcard characters: False
```

### -DurationSeconds
The amount of time in seconds you want this effect to be going.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Effect
The Effect to display.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Intensity
The intensity of the effect.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 128
Accept pipeline input: False
Accept wildcard characters: False
```

### -Models
The models in which this Overlay Model Effect will be applied.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Note
The note for this playlist Overlay Model Effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Palette
The color palette to use.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlaylistName
The name of the playlist in which you want to insert the Overlay Model Effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionName
The section name where you want to insert the Overlay Model Effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: MainPlaylist
Accept pipeline input: False
Accept wildcard characters: False
```

### -Speed
The speed of the effect.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 128
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
