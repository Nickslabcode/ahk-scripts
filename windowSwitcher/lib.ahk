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
    MsgBox('Could not start ' . groupName . '. Please start the application manually first!')
  }
}

/**
 * Registers a hotkey that switches to the given program's window group.
 * @param {String} shortcut Hotkey key combination (e.g. '+#r')
 * @param {String} program Key into the `Programs` dictionary
 */
mapKey(shortcut, program) {
  global Programs
  Hotkey(shortcut, (*) => switchToWindow(program, Programs[program].criteriaType, Programs[program].criteriaValue))
}

