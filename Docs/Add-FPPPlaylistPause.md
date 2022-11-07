---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Add-FPPPlaylistPause

## SYNOPSIS
Insert a pause into the specified section of a playlist

## SYNTAX

```
Add-FPPPlaylistPause [-PlaylistName] <String> [[-SectionName] <String>] [-DurationSeconds] <Int32>
 [<CommonParameters>]
```

## DESCRIPTION
Insert an pause into the specified section of a playlist

## EXAMPLES

### EXAMPLE 1
```
Add-FPPPlaylistPause -PlaylistName "Christmas" -SectionName 'MainPlaylist -DurationSeconds 60
Adds a 1 minute pause to the "Christmas" playlist in the Main Playlist section.
```

## PARAMETERS

### -DurationSeconds
The amount of time in seconds you want this effect to be going.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
