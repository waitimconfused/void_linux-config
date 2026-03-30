# i3 Configuration

## Keybinds

All actions other than volume, brightness, and other F-row keys use $mod (the Windows key).

### Mod+Shift
Using the `shift` key is used to control each window.

> Note: Some keys use the `ctrl` key. This is the workspace-modifier.
> 
> Keys with `ctrl` will *also* be shown under [Modifiers/Ctrl](#ctrl).

| Keybind              | Description                                                                                                                              |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| mod+shift+Left       | Move the current window left                                                                                                             |
| mod+shift+Down       | Move the current window down                                                                                                             |
| mod+shift+Up         | Move the current window up                                                                                                               |
| mod+shift+Right      | Move the current window right                                                                                                            |
| mod+shift+ctrl+left  | Move the view and current window to the previous workspace                                                                               |
| mod+shift+ctrl+right | Move the view and current window to the next workspace                                                                                   |
| mod+shift+h          | Set the window split-mode (how to split the current window when launching a new window) to *horizontal*                                  |
| mod+shift+v          | Set the window split-mode (howa to split the current window when launching a new window) to *vertical*                                   |
| mod+shift+space      | Toggle floating-mode for the current window. Does not work when a workspace has only one window                                          |
| mod+shift+(0-9)      | Move the current window to the workspace with the corrisponding number (`0`-`9`)                                                         |
| mod+shift+grave      | Move the current window to a empty workspace. If the current workspace only has one window, nothing happens                              |
| mod+shift+ctrl+grave | Move the view and to a empty workspace. If the workspace is empty, nothing happens                                                       |
| mod+ctrl+shift+(0-9) | Move the current window and view to the workspace with the corrisponding number (`0`-`9`)                                                |
| mod+shift+r          | Open window-resize mode. Pressing up/down/left/right will change the size of the current window. Press `mod+shift+r` or `escape` to exit |

### Mod+Ctrl
Using the `ctrl` key is used to control each workspace.

> Note: Some keys use the `shift` key. This is the window-modifier.
> 
> Keys with `shift` will *also* be shown under [Modifiers/Shift](#shift).

| Keybind              | Description                                                                               |
| -------------------- | ----------------------------------------------------------------------------------------- |
| mod+ctrl+(0-9)       | Move the view to the workspace with the corrisponding number (0-9)                        |
| mod+ctrl+left        | Move the view to previous workspace (eg: 4 to 3)                                          |
| mod+ctrl+right       | Move the view to next workspace (eg: 2 to 3)                                              |
| mod+ctrl+grave       | Move the view to a empty workspace. If the workspace is empty, nothing happens            |
| mod+ctrl+shift+(0-9) | Move the view and current window to the workspace with the corrisponding number (0-9)     |
| mod+ctrl+shift+left  | Move the view and current window to the previous workspace                                |
| mod+ctrl+shift+right | Move the view and current window to the next workspace                                    |
| mod+ctrl+shift+grave | Move the view and to a empty workspace. If the workspace is empty, nothing happens        |
| mod+ctrl+space       | Toggle sticky mode for the current window; Window will now stay visible across workspaces |

## Mod+Alt
Using the `alt` key is used to control `i3`.

| Keybind       | Description                                                   |
|---------------|---------------------------------------------------------------|
| mod+alt+c     | Reload the `i3` configuration file (`~/.config/i3/config`)    |
| mod+alt+r     | Restart `i3`                                                  |
| mod+alt+power | Shows confirmation popup for exiting i3. Press again to exit. |

## Uncatagorized Shortcuts

| Keybind           | Description                                                                              |
|-------------------|------------------------------------------------------------------------------------------|
| volume_up         | Increases the volume by 5%                                                               |
| volume_down       | Lowers the volume by 5%                                                                  |
| alt+volume_up     | Skip to next track                                                                       |
| alt+volume_down   | Go to previous track                                                                     |
| volume_mute       | Mutes the volume                                                                         |
| volume_mic_mute   | Mutes the microphone volume                                                              |
| volume_play_pause | Plays/pauses the current audio                                                           |
| brightness_up     | Increases the screen brightness by 5%                                                    |
| brightness_down   | Decreases the screen brightness by 5%                                                    |
| power (release)   | Opens `i3lock` (the lock screen)                                                         |
| mod+enter         | Opens `alacritty`                                                                        |
| mod+space         | Opens `rofi -show drun`                                                                  |
| alt+tab           | Opens `rofi -show window`                                                                |
| mod+q             | Closes the current window                                                                |
| mod+l             | Opens `i3lock` (the lock screen)                                                         |
| `project`         | Reloads `autorandr`                                                                      |
| alt+`project`     | Toggles night mode                                                                       |
| print             | Takes a screenshot (saved to `~/Pictures/Screenshots/`) and opens the image in Ristretto |
| `XF86Calculator`  | Opens `rofi -show calc`                                                                  |
| mod+f             | Toggles fullscreen for the current window                                                |
| mod+a             | Focuses the current windows parent                                                       |
| mod+d             | Focusess the current windows child                                                       |
| power             | Opens i3lock and suspends screen                                                         |


## `bindsym` Keyboard Lookup

Instead of using the actual key name, I've assigned (only in the README file, not in the config files)

| `bindsym` key           | Human-readable value           |
|-------------------------|--------------------------------|
| `Mod4`                  | mod (AKA: Super, Windows)      |
| `Mod1`                  | alt                            |
| `XF86AudioRaiseVolume`  | volume_up                      |
| `XF86AudioLowerVolume`  | volume_down                    |
| `XF86AudioMute`         | volume_mute                    |
| `XF86AudioPlay`         | volume_play_pause              |
| `XF86AudioMicMute`      | volume_mic_mute                |
| `XF86MonBrightnessUp`   | brightness_up                  |
| `XF86MonBrightnessDown` | brightness_down                |
| `XF86PowerOff`          | power                          |
| `XF86Calculator`        | calculator                     |
| `grave`                 | backtick (`` ` ``)             |
| `project`               | Project key (alias to `mod+p`) |
