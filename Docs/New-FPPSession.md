---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# New-FPPSession

## SYNOPSIS
Establish a new context for FPP API session.

## SYNTAX

```
New-FPPSession [-HostUrl] <String> [<CommonParameters>]
```

## DESCRIPTION
Set environment variables as needed for standard FPP API calls.

Variables that get set:
$env:FPP_URL

## EXAMPLES

### EXAMPLE 1
```
New-FPPSession -HostUrl 'http://fpphost'
```

## PARAMETERS

### -HostUrl
The URL for your FPP instance.

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
