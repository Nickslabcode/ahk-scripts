#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

; ====================================================
; ================ Program dictionary ================
; ====================================================

global Programs := Map(
  'Chrome', { criteriaType: 'ahk_exe', criteriaValue: 'chrome.exe' },
  'Edge', { criteriaType: 'ahk_exe', criteriaValue: 'msedge.exe' },
  'Obsidian', { criteriaType: 'ahk_exe', criteriaValue: 'Obsidian.exe' },
  'Outlook', { criteriaType: 'ahk_class', criteriaValue: 'Outlook Host' },
  'Terminal', { criteriaType: 'ahk_class', criteriaValue: 'CASCADIA_HOSTING_WINDOW_CLASS' },
  'VSCode', { criteriaType: 'ahk_exe', criteriaValue: 'Code.exe' },
  'Clock', { criteriaType: '', criteriaValue: 'ms-clock:' }, ; ms-clock: - specific to UWP apps from MS Store
  'WebStorm', { criteriaType: 'ahk_class', criteriaValue: 'SunAwtFrame' },
  'Teams', { criteriaType: 'ahk_exe', criteriaValue: 'ms-teams.exe' },
  'Zed', { criteriaType: 'ahk_exe', criteriaValue: 'zed.exe' }
)

/**
 * Groups windows based on `ahk_` criteria and switches to a specific group.
 *
 * If attempting to switch to a window that's currently active,
 * it cycles to the most recent active window from the same group.
 *
 * If attempting to switch to a window that's not active, it will attempt to run it.
 * @param {String} groupName Key into the `Programs` map
 */
switchToWindow(groupName) {
  criteriaType := Programs[groupName].criteriaType
  criteriaValue := Programs[groupName].criteriaValue
  try {
    if (WinExist(criteriaType criteriaValue)) {
      GroupAdd groupName, criteriaType criteriaValue
      if WinActive(criteriaType criteriaValue)
        GroupActivate groupName, 'R' ; Go back to the most recent group window
      else
        WinActivate criteriaType criteriaValue
    } else {
      ToolTip 'Starting ' . groupName
      SetTimer () => ToolTip(), -2000 ; Remove tooltip after 2s
      Run criteriaValue
    }
  } catch {
    MsgBox('Could not start ' . criteriaValue . '. Please start the application manually first!')
  }
}

/**
 * Registers a hotkey that switches to the given program's window group.
 * @param {String} shortcut Hotkey key combination (e.g. '+#r')
 * @param {String} program Key into the `Programs` dictionary
 */
mapKey(shortcut, program) {
  Hotkey(shortcut, (*) => switchToWindow(program))
}

; ====================================================
; ==== key mappings: 1. Shortcut, 2. Program name ====
; ====================================================

mapKey('+#r', 'Chrome')
mapKey('+#e', 'Edge')
mapKey('+#w', 'Obsidian')
mapKey('+#t', 'Outlook')
mapKey('+#``', 'Terminal') ; `` escapes to a literal backtick
mapKey('+#q', 'VSCode')
mapKey('+#a', 'Clock')
mapKey('+#1', 'WebStorm')
mapKey('+#d', 'Teams')
mapKey('+#z', 'Zed')
