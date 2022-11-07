---
external help file: FPPPowerShell-help.xml
Module Name: FPPPowerShell
online version:
schema: 2.0.0
---

# Get-FPPModel

## SYNOPSIS
Get information about one multiple models.
If Name isn't provided, all models are listed.

## SYNTAX

```
Get-FPPModel [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Get information about one multiple models.
If Name isn't provided, all models are listed.

## EXAMPLES

### EXAMPLE 1
```
Get-FPPModel
List all models
```

### EXAMPLE 2
```
Get-FPPModel -Name 'Matrix'
Show information about the model with name "Matrix"
```

### EXAMPLE 3
```
Get-FPPModel -Name 'Matrix', 'Matrix2'
Show information about the models with names "Matrix" and "Matrix2"
```

## PARAMETERS

### -Name
The name of one or more models in you want information.

```yaml
Type: String[]
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
