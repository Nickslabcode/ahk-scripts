#Requires AutoHotkey v2.0
#SingleInstance Force

activateGroup(groupName, criteriaType, criteriaValue) {
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

+#r::activateGroup('ChromeGroup', 'ahk_exe', 'chrome.exe')
+#e::activateGroup('EdgeGroup', 'ahk_exe', 'msedge.exe')
+#w::activateGroup('ObsidianGroup', 'ahk_exe', 'Obsidian.exe')
+#t::activateGroup('AnkiGroup', 'ahk_class', 'Qt691QWindowIcon')
+#`::activateGroup('TerminalGroup', 'ahk_class', 'CASCADIA_HOSTING_WINDOW_CLASS')
+#q::activateGroup('vscGroup', 'ahk_exe', 'Code.exe')