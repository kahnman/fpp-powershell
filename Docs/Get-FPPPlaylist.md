---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Get-FPPPlaylist

## SYNOPSIS
Get information about one or more FP playlist.
If you do not specify a playlist name, all playlsit names are listed.

## SYNTAX

```
Get-FPPPlaylist [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION
Get information about one or more FP playlist.
If you do not specify a playlist name, all playlsit names are listed.

## EXAMPLES

### EXAMPLE 1
```
Get-FPPPlaylist
List the name of every playlist
```

### EXAMPLE 2
```
Get-FPPPlaylist -Name 'Christmas'
Show detailed information about the playlist with name "Christmas"
```

## PARAMETERS

### -Name
The name of the playlist in which you want information.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
