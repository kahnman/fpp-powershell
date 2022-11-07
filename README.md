# fpp-powershell
FPPPowerShell is a PowerShell module that lets you perform actions on and make changes to a Falcon Pi Player (FPP) instance using its built in API.

This was primarily made for myself and by no means complete, but I'm happy to share what I've done with others.

Pull requests and other contributions would be welcome!

# Instructions

## One time setup
- Download the repository
- Unblock the zip
- Extract the FPPPowerShell folder to a module path (e.g. `$env:USERPROFILE\Documents\WindowsPowerShell\Modules\`)
  - *Tip:* Use `$env:PSModulePath` to view list of directories where modules are stored.

## Prerequisites
- PowerShell 7 or later
  - Although this module will likely work on older versions of PowerShell, it was originally developed and tested on PowerShell 7.2.7.
- The IP address or host name of the FPP instance you want to manage.

TODO Write Examples
# Examples
Here are some examples, but you can also [check out the docs](Docs/FPPPowerShell.md) for information about each function.
## Create a new playlist
```powershell

```

## Create a new playlist entry based on the current visual settings of a local WLED controller.
```powershell

```
## Add an entry to an existing playlist

## Add a pause entry to an existing playlist
## Add an Overlay Model (WLED) Effect  to an existing playlist
## Delete a playlist
## Start a playlist
## Pause a playlist
## Resume a playlist
## Stop a playlist