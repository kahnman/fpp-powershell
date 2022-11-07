---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Copy-FPPEffectFromWled

## SYNOPSIS
Copy the currently playing effect on a WLED controller to the specified FPP playlist.

## SYNTAX

```
Copy-FPPEffectFromWled [-WLEDHost] <String> [[-WLEDSegment] <Int32>] [-PlaylistName] <String>
 [[-SectionName] <String>] [-Models] <String[]> [[-Brightness] <Int32>] [[-BufferMapping] <String>]
 [-DurationSeconds] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Copy the currently playing effect on a WLED controller to the specified FPP playlist.

## EXAMPLES

### EXAMPLE 1
```
Copy-FPPEffectFromWled
```

## PARAMETERS

### -Brightness
The brightness of the effect.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
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

### -DurationSeconds
The amount of time in seconds you want this effect to be going.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Models
The models in which you want to apply the copied effect.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlaylistName
The name of the playlist in which you want to insert the copied effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionName
The section name where you want to insert the copied effect.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: MainPlaylist
Accept pipeline input: False
Accept wildcard characters: False
```

### -WLEDHost
The hostname or IP address of the WLED controller.

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

### -WLEDSegment
The ID of the WLED segment in which you want to copy the effect from.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
