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
 * @param {'ahk_class' | 'ahk_exe' | 'ahk_pid' | 'ahk_id' | ''} criteriaType 
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
      ToolTip 'Starting ' . groupName
      SetTimer () => ToolTip(), -2000 ; Remove tooltip after 2s
      Run criteriaValue
    }
  } catch {
    MsgBox('Could not start ' . criteriaValue . '. Please start the application manually first!')
  }
}

; === key mapping ===

+#r::switchToWindow('Chrome', 'ahk_exe', 'chrome.exe')
+#e::switchToWindow('Edge', 'ahk_exe', 'msedge.exe')
+#w::switchToWindow('Obsidian', 'ahk_exe', 'Obsidian.exe')
+#t::switchToWindow('Anki', 'ahk_class', 'Qt691QWindowIcon')
+#`::switchToWindow('Terminal', 'ahk_class', 'CASCADIA_HOSTING_WINDOW_CLASS')
+#q::switchToWindow('VSCode', 'ahk_exe', 'Code.exe')
+#a::switchToWindow('Clock', '', 'ms-clock:') ; ms-clock: - specific to UWP apps from MS Store
+#1::switchToWindow('WebStorm', 'ahk_class', 'SunAwtFrame')
+#d::switchToWindow('Teams', 'ahk_exe', 'ms-teams.exe')