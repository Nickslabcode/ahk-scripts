#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

#Include windowSwitcher/lib.ahk

; ====================================================
; ================ Program dictionary ================
; ====================================================

; `criteriaType`/`criteriaValue` find the window; the optional `run` is what gets
; launched when no window exists. Launch paths come from Windows user environment
; variables (see README for how to set them); an unset variable is '' and falls
; back to running the `criteriaValue` as-is — that only works for URIs and exe
; names registered in App Paths (chrome.exe, msedge.exe, Code.exe), never for
; ahk_class values.

global Programs := Map(
    'Chrome', { criteriaType: 'ahk_exe', criteriaValue: 'chrome.exe' },
    'Edge', { criteriaType: 'ahk_exe', criteriaValue: 'msedge.exe' },
    'Obsidian', { criteriaType: 'ahk_exe', criteriaValue: 'Obsidian.exe', run: EnvGet('OBSIDIAN_PATH') },
    'Outlook', { criteriaType: 'ahk_class', criteriaValue: 'Outlook Host', run: EnvGet('OUTLOOK_PATH') },
    'Terminal', { criteriaType: 'ahk_class', criteriaValue: 'CASCADIA_HOSTING_WINDOW_CLASS', run: EnvGet(
        'TERMINAL_PATH') },
    'VSCode', { criteriaType: 'ahk_exe', criteriaValue: 'Code.exe' },
    'Clock', { criteriaType: '', criteriaValue: 'ms-clock:' }, ; ms-clock: - specific to UWP apps from MS Store
    'WebStorm', { criteriaType: 'ahk_class', criteriaValue: 'SunAwtFrame', run: EnvGet('WEBSTORM_PATH') },
    'Teams', { criteriaType: 'ahk_exe', criteriaValue: 'ms-teams.exe', run: EnvGet('TEAMS_PATH') },
    'Zed', { criteriaType: 'ahk_exe', criteriaValue: 'zed.exe', run: EnvGet('ZED_PATH') }
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