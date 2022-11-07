---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Add-FPPPlaylistItem

## SYNOPSIS
Insert an item into the specified section of a playlist

## SYNTAX

```
Add-FPPPlaylistItem [-PlaylistName] <String> [[-SectionName] <String>] [-ItemJson] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Insert an item into the specified section of a playlist

## EXAMPLES

### EXAMPLE 1
```
$json = '{
    "type": "pause",
    "enabled": 1,
    "playOnce": 0,
    "duration": 8
    }'
Add-FPPPlaylistItem -PlaylistName 'Christmas' -SectionName 'leadIn' -ItemJson $json
Insert a pause item to the Lead In section of the playlist called "Christmas".
```

## PARAMETERS

### -ItemJson
The JSON that contains the definition of the item you want to insert.

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

### -PlaylistName
The name of the playlist in which you want to insert an item.

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
The section name where you want to insert the item.

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
