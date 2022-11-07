---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Get-WLEDPalette

## SYNOPSIS
Get a list of available palettes on the WLED controller.

## SYNTAX

```
Get-WLEDPalette [-WLEDHost] <String> [<CommonParameters>]
```

## DESCRIPTION
Get a list of available palettes on the WLED controller.

## EXAMPLES

### EXAMPLE 1
```
Get-WLEDPalette -WLEDHost '192.168.1.5'
Get the list of palettes on the WLED controller with IP address 192.168.1.5
```

## PARAMETERS

### -WLEDHost
The hostname or IP address of the WLED controller

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
