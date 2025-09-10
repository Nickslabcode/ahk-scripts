#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

/**
 * Groups windows based on `ahk_` criteria and switches to a specific group.
 * 
 * If attempting to switch to a window that's currently active,
 * it cycles to the most recent active window from the same group. 
 * 
 * If attempting to switch to a window that's not active, it will attempt to run it.
 * @param {String} groupName
 * @param {'ahk_class' | 'ahk_exe' | 'ahk_pid' | 'ahk_id'} criteriaType 
 * @param {String} criteriaValue
 */
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

+#r::switchToWindow('ChromeGroup', 'ahk_exe', 'chrome.exe') ; chrome
+#e::switchToWindow('EdgeGroup', 'ahk_exe', 'msedge.exe') ; edge
+#w::switchToWindow('ObsidianGroup', 'ahk_exe', 'Obsidian.exe') ; obsidian
+#t::switchToWindow('AnkiGroup', 'ahk_class', 'Qt691QWindowIcon') ; anki
+#`::switchToWindow('TerminalGroup', 'ahk_class', 'CASCADIA_HOSTING_WINDOW_CLASS') ; terminal
+#q::switchToWindow('VscGroup', 'ahk_exe', 'Code.exe') ; vscode