#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

switchToWindow(groupName, criteriaType, criteriaValue) {
  try {
    if (WinExist(criteriaType criteriaValue)) {
      GroupAdd groupName, criteriaType criteriaValue
      if WinActive(criteriaType criteriaValue)
        GroupActivate groupName, 'R' ; Go back to the most recent group window
      else
        WinActivate criteriaType criteriaValue
    } else {
      ToolTip 'Starting ' . criteriaValue
      SetTimer () => ToolTip(), -2000 ; Remove tooltip after 2s
      Run criteriaValue
    }
  } catch {
    MsgBox('Could not start ' . criteriaValue . '. Please start the application manually first!')
  }
}

; === key mapping ===

+#r::switchToWindow('ChromeGroup', 'ahk_exe', 'chrome.exe')
+#e::switchToWindow('EdgeGroup', 'ahk_exe', 'msedge.exe')
+#w::switchToWindow('ObsidianGroup', 'ahk_exe', 'Obsidian.exe')
+#t::switchToWindow('AnkiGroup', 'ahk_class', 'Qt691QWindowIcon')
+#`::switchToWindow('TerminalGroup', 'ahk_class', 'CASCADIA_HOSTING_WINDOW_CLASS')
+#q::switchToWindow('vscGroup', 'ahk_exe', 'Code.exe')