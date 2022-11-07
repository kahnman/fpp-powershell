---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Stop-FPPPlaylist

## SYNOPSIS
Stop the currently running playlist.
By default, the playlist stops immediately, but you can use the "Gracefully"
or "GracefullyAfterLoop" parameters to stop the playlist gracefully.

## SYNTAX

```
Stop-FPPPlaylist [-Gracefully] [-GracefullyAfterLoop] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Stop the currently running playlist.
By default, the playlist stops immediately, but you can use the "Gracefully"
or "GracefullyAfterLoop" parameters to stop the playlist gracefully.

## EXAMPLES

### EXAMPLE 1
```
Stop-FPPPlaylist
Stops the currently running playlist immediately.
```

### EXAMPLE 2
```
Stop-FPPPlaylist -Gracefully
Gracefully stop the currently running playlist.
```

### EXAMPLE 3
```
Stop-FPPPlaylist -GracefullyAfterLoop
Gracefully stop the currently running playlist after completion of the current loop.
```

## PARAMETERS

### -Gracefully
Gracefully stop the currently running playlist.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -GracefullyAfterLoop
Gracefully stop the currently running playlist after completion of the current loop.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
