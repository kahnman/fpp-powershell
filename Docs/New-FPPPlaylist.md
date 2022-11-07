---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# New-FPPPlaylist

## SYNOPSIS
Create a new FPP Playlist.

## SYNTAX

```
New-FPPPlaylist [-Json] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Create a new FPP Playlist.

## EXAMPLES

### EXAMPLE 1
```
$json = '{
    "name": "MyNewPlaylist",
    "mainPlaylist": [
        {
        "type": "pause",
        "enabled": 1,
        "playOnce": 0,
        "duration": 8
        }
    ],
    "playlistInfo": {
        "total_duration": 8,
        "total_items": 1
    }
    }'
New-FPPPlaylist -Json $json
Create a new playlist called MyNewPlaylist.
```

## PARAMETERS

### -Json
The JSON that contains the definition of the playlist

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

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
