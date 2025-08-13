#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command
#Include %A_ScriptDir%\lib\helper.ahk ; Import functions library

; === key mapping ===

+#r::switchToWindow('ChromeGroup', 'ahk_exe', 'chrome.exe')
+#e::switchToWindow('EdgeGroup', 'ahk_exe', 'msedge.exe')
+#w::switchToWindow('ObsidianGroup', 'ahk_exe', 'Obsidian.exe')
+#t::switchToWindow('AnkiGroup', 'ahk_class', 'Qt691QWindowIcon')
+#`::switchToWindow('TerminalGroup', 'ahk_class', 'CASCADIA_HOSTING_WINDOW_CLASS')
+#q::switchToWindow('VscGroup', 'ahk_exe', 'Code.exe')