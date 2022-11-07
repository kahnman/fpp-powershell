---
Module Name: FPPPowerShell
Module Guid: e01a4f96-bc81-4037-9749-00b02ef9857d
Download Help Link:
Help Version: 1.0.0.0
Locale: en-US
---

# FPPPowerShell Module
## Description
A PowerShell module that lets you perform actions on and make changes to a Falcon Pi Player (FPP) instance using its built in API.

## FPPPowerShell Cmdlets
### [Add-FPPPlaylistItem](Add-FPPPlaylistItem.md)
Insert an item into the specified section of a playlist.

### [Add-FPPPlaylistPause](Add-FPPPlaylistPause.md)
Insert a pause into the specified section of a playlist.

### [Add-FPPWledOverlayModelEffect](Add-FPPWledOverlayModelEffect.md)
Insert an Overlay Model Effect into the specified section of a playlist.

### [Confirm-FPPPlaylist](Confirm-FPPPlaylist.md)
Returns a list of playlist and any validation errors that are present.

### [Copy-FPPEffectFromWled](Copy-FPPEffectFromWled.md)
Copy the currently playing effect on a WLED controller to the specified FPP playlist.

### [Get-FPPModel](Get-FPPModel.md)
Get information about one multiple models. If Name isn't provided, all models are listed.

### [Get-FPPPlaylist](Get-FPPPlaylist.md)
Get information about one or more FP playlist. If you do not specify a playlist name, all playlist names are listed.

### [Get-FPPWledEffect](Get-FPPWledEffect.md)
List available WLED effect names.

### [Get-FPPWledPalette](Get-FPPWledPalette.md)
List available WLED palette names.

### [Get-WLEDEffect](Get-WLEDEffect.md)
Get a list of available effects on the WLED controller.

### [Get-WLEDInfo](Get-WLEDInfo.md)
Get info about the WLED controller.

### [Get-WLEDPalette](Get-WLEDPalette.md)
Get a list of available palettes on the WLED controller.

### [Get-WLEDState](Get-WLEDState.md)
Get the state of a WLED controller.

### [New-FPPPlaylist](New-FPPPlaylist.md)
Create a new FPP Playlist.

### [New-FPPSession](New-FPPSession.md)
Set environment variables needed for standard FPP API calls.

### [Remove-FPPPlaylist](Remove-FPPPlaylist.md)
Delete a playlist from FPP.

### [Resume-FPPPlaylist](Resume-FPPPlaylist.md)
Resume a previously paused playlist.

### [Set-FPPPlaylist](Set-FPPPlaylist.md)
Update/Insert a specific playlist.

### [Start-FPPPlaylist](Start-FPPPlaylist.md)
Start the specified playlist.

### [Stop-FPPPlaylist](Stop-FPPPlaylist.md)
Stop the currently running playlist. By default, the playlist stops immediately, but you can use the "Gracefully" or "GracefullyAfterLoop" parameters to stop the playlist gracefully.

### [Suspend-FPPPlaylist](Suspend-FPPPlaylist.md)
Pause the currently running playlist.

