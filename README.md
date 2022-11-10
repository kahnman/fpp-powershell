# FPPPowerShell
FPPPowerShell is a PowerShell module that lets you perform actions on and make changes to a Falcon Pi Player (FPP) instance using its built in API.

This was primarily made for myself and by no means complete, but am making my code public so others can benefit.

Pull requests and other contributions would be welcome! If you find a bug or have a feature request, please [submit an issue on GitHub](https://github.com/kahnman/fpp-powershell/issues).

# Installation Instructions

## One time setup
- Download the repository
- Unblock the zip
- Extract the FPPPowerShell folder to a module path (e.g. `$env:USERPROFILE\Documents\WindowsPowerShell\Modules\`)
  - *Tip:* Use `$env:PSModulePath` to view list of directories where modules are stored.

## Prerequisites
- PowerShell 7 or later
  - Although this module will likely work on older versions of PowerShell, it was originally developed and tested with PowerShell 7.2.7.
- The IP address or host name of the FPP instance you want to manage.

# Examples
Here are some examples, but you can also [check out the docs](Docs/FPPPowerShell.md) for information about each function.

## Create a "session" with an FPP instance
```powershell
# Before you can run any of the commands provided by this module, you need to create a "session" with your FPP instance.
New-FPPSession -HostUrl 'http://fpphost'

# HostUrl can also be an IP address.
New-FPPSession -HostUrl '192.168.1.5'

# In case anyone is curious, I put "session" in quotes because New-FPPSession doesn't create a session in the traditional sense.
# New-FPPSession only sets an environment variable FPP_URL (and does a little validation), which is used by all of the other module commands.
```
## Create a new playlist
```powershell
# Create a new empty playlist called "Christmas".
New-FPPPlaylist -Name 'Christmas'
```

## Create a new playlist entry based on the current visual settings of a local WLED controller.
```powershell
# Create a new empty playlist called "WLED Copy".
$playlistName = 'WLED Copy'
New-FPPPlaylist -Name $playlistName

# Copy the currently playing effect and pallet from the WLED controller at '192.168.1.5' to the FPP overlay models called Matrix1 and Matrix2.
Copy-FromWledToFpp -WLEDHost '192.168.1.5' -PlaylistName $playlistName -Models Matrix1, Matrix2 -Brightness 50
```
## Add an entry to an existing playlist
```powershell
# This is the playlist item that we'll be adding in JSON format.
$json = '{
      "type": "pause",
      "enabled": 1,
      "playOnce": 0,
      "duration": 8
    }'

# Add the item to the Lead In section of the playlist called "Christmas".
Add-FPPPlaylistItem -PlaylistName 'Christmas' -SectionName 'LeadIn' -ItemJson $json
```
## Add a pause entry to an existing playlist
```powershell
# Add a 1 minute pause to the "Main" section of the Christmas playlist.
Add-FPPPlaylistPause -PlaylistName 'Christmas' -SectionName 'MainPlaylist' -DurationSeconds 60
```
## Add an Overlay Model (WLED) Effect to an existing playlist
```powershell
# Define the parameters using a [splat](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting?view=powershell-7.3) that'll be passed to Add-FPPWledOverlayModelEffect.
$splatParams = @{
    PlaylistName = 'Christmas'
    SectionName = 'LeadIn'
    Models = 'Matrix1','Matrix2'
    Effect = 'Twinkle'
    Palette = 'Lava'
    Brightness = 52
    Speed = 200
    Intensity = 100
    Color1 = 'ff0000'
    Color2 = '00ff00'
    Color3 = '0000ff'
}

# Create an Overlay Model Effect item in the Lead In section of the "Christmas" playlist with the requested settings.
Add-FPPWledOverlayModelEffect @splatParams
```
## Delete a playlist
```powershell
# Delete the playlist called "Christmas".
Remove-FPPPlaylist -Name 'Christmas'
```
## Playlist controls
```powershell
# Starts the playlist called "Christmas".
Start-FPPPlaylist -Name 'Christmas'

# Pause whatever playlist is currently running.
Suspend-FPPPlaylist

# Resumes a playlist that was previously paused.
Resume-FPPPlaylist

# Stop the currently running playlist immediately.
Start-FPPPlaylist

# Gracefully stop the currently running playlist.
Stop-FPPPlaylist -Gracefully

# Gracefully stop the currently running playlist after completion of the current loop.
Stop-FPPPlaylist -GracefullyAfterLoop
```