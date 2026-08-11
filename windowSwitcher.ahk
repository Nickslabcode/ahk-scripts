#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

#Include windowSwitcher/lib.ahk

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
