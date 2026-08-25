# ahk-scripts

Personal [AutoHotkey v2](https://www.autohotkey.com/) scripts for window and virtual desktop management on Windows.

## Prerequisites

1. Download and install **AutoHotkey v2.0** from https://www.autohotkey.com/ (make sure to pick the v2 installer, not v1.1).
2. Clone or copy this repository to a folder on your Windows machine.

## Scripts

### `windowSwitcher.ahk`

Adds hotkeys (`Win+Shift+<key>`) that switch to a running application, or launch it if it isn't running. Pressing the hotkey again while that app is focused cycles to the next window in the same group.

Programs are configured in the `Programs` map at the top of the file. Each entry maps a name to the `ahk_` criteria used to find its window:

```ahk
'Chrome', { criteriaType: 'ahk_exe', criteriaValue: 'chrome.exe' },
```

When no matching window exists, the app is launched. By default the `criteriaValue` is run as-is, which only works for URIs (`ms-clock:`) and exe names registered in the Windows App Paths registry (`chrome.exe`, `Code.exe`, ...). Anything else - apps matched by `ahk_class`, or exes Windows can't find by bare name - needs an explicit launch path, provided through a **Windows user environment variable**. Each entry's `run` property reads one, e.g.:

```ahk
'Obsidian', { criteriaType: 'ahk_exe', criteriaValue: 'Obsidian.exe', run: EnvGet('OBSIDIAN_PATH') },
```

The script reads these variables (set only the ones you need - an unset variable falls back to the default behavior above):

| Variable | Program | Typical value |
| --- | --- | --- |
| `OBSIDIAN_PATH` | Obsidian | `%LocalAppData%\Programs\Obsidian\Obsidian.exe` |
| `OUTLOOK_PATH` | Outlook (new) | `%LocalAppData%\Microsoft\WindowsApps\olk.exe` |
| `TERMINAL_PATH` | Windows Terminal | `%LocalAppData%\Microsoft\WindowsApps\wt.exe` |
| `TEAMS_PATH` | Microsoft Teams | `%LocalAppData%\Microsoft\WindowsApps\ms-teams.exe` |
| `WEBSTORM_PATH` | WebStorm | wherever your `webstorm64.exe` lives |
| `ZED_PATH` | Zed | wherever your `zed.exe` lives |

To set a variable, pick one of:

- **GUI:** `Win+R` → `rundll32 sysdm.cpl,EditEnvironmentVariables` → under **User variables** click **New...** and enter the name (e.g. `OBSIDIAN_PATH`) and the full path to the exe.
- **PowerShell:**

  ```powershell
  [Environment]::SetEnvironmentVariable('OBSIDIAN_PATH', "$env:LOCALAPPDATA\Programs\Obsidian\Obsidian.exe", 'User')
  ```

Afterwards, fully **exit** the running script (tray icon → Exit) and start it again from Explorer - a tray **Reload** keeps the process's old environment and won't pick up new variables, and a terminal opened before the change needs to be reopened before launching the script from it.

To make a new program launchable, add a `run: EnvGet('YOUR_VAR')` property to its `Programs` entry and set that variable.

Hotkeys are registered near the bottom via `mapKey(shortcut, program)`, e.g.:

```ahk
mapKey('+#r', 'Chrome')
```

To add a new shortcut, add an entry to `Programs` and a corresponding `mapKey(...)` call.

#### Hotkey modifier symbols

Prefix one or more of these to a key name to build a shortcut string, e.g. `'+#r'` = Shift+Win+R:

| Symbol | Modifier | Example -> Meaning |
| --- | --- | --- |
| `#` | Win | `#r` -> Win+R |
| `!` | Alt | `!r` -> Alt+R |
| `^` | Ctrl | `^r` -> Ctrl+R |
| `+` | Shift | `+r` -> Shift+R |
| `&` | Combine two keys into a custom hotkey | `a & b` -> A and B held together |
| `<` | Use the left key of a modifier pair | `<^r` -> Left Ctrl+R |
| `>` | Use the right key of a modifier pair | `>^r` -> Right Ctrl+R |
| `*` | Wildcard: fire even if extra modifiers are held | `*r` -> R (with any combination of modifiers) |
| `~` | Passthrough: don't block the key's native function | `~r` -> R (native action still happens) |
| `$` | Force the keyboard hook (avoids `Send` re-triggering) | `$r` -> R |

Modifiers can be combined, e.g. `+#r` (used throughout `windowSwitcher.ahk`).

#### Finding a program's `ahk_class` / `ahk_exe` with Window Spy

`Window Spy` is a tool bundled with AutoHotkey that shows the class name, exe name, and other details of whatever window is under your mouse. Use it to find the `criteriaType`/`criteriaValue` for a new `Programs` entry:

1. Make sure AutoHotkey is installed, then run any `.ahk` script (e.g. double-click `windowSwitcher.ahk`) so an AutoHotkey icon (green "H") appears in the system tray, near the clock.
2. Right-click the tray icon and choose **Window Spy** from the menu.
3. Click on, or just hover your mouse over, the window of the program you want to map. Window Spy updates live as you move the mouse.
4. In the Window Spy window, note the **"ahk_class"** value (for `criteriaType: 'ahk_class'`) or the **"ahk_exe"** value (for `criteriaType: 'ahk_exe'`) - either works, pick whichever value looks more stable/unique for that app.
5. Add a new entry to the `Programs` map in `windowSwitcher.ahk` using the value you copied, then add a `mapKey('<shortcut>', '<name>')` call for it.
6. Right-click the AutoHotkey tray icon and choose **Reload** to apply your changes.

### `virtualDesktopSwitcher.ahk`

Adds hotkeys for navigating Windows virtual desktops (create, delete, switch to previous/next, jump to a specific desktop number). See the `; === key mapping ===` section in the file for the exact bindings.

### `startWindowSwitcher.ps1`

A small PowerShell helper that starts `windowSwitcher.ahk`. Useful for launching the script automatically (e.g. from a shortcut, Task Scheduler, or the Startup folder) without having to double-click the `.ahk` file manually. Update the path in the script to match where you placed this repository before using it.

## Running the scripts

- **Manually:** double-click a `.ahk` file (requires AutoHotkey to be installed) to run it. An AutoHotkey tray icon will appear while the script is active.
- **Via PowerShell:** run `startWindowSwitcher.ps1` to launch `windowSwitcher.ahk`.
- **At Windows startup:** place a shortcut to the `.ahk` file(s) (or to `startWindowSwitcher.ps1`) in the Startup folder (`Win+R` → `shell:startup`), or create a Task Scheduler task that runs at logon.

To stop a running script, right-click its tray icon and choose **Exit**, or use **Reload** to apply changes after editing.
