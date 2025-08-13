#Requires AutoHotkey v2.0

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

/**
 * Class VDesktop - Manages Windows virtual desktops.
 * 
 * 
 * Static Methods:
 * @method Add - Creates a new virtual desktop and switches to it.
 * 
 * @method Delete - Deletes the current virtual desktop.
 * 
 * @method SwitchToPrev - Switches to the previous virtual desktop if available.
 * 
 * @method SwitchToNext - Switches to the next virtual desktop if available.
 * 
 * @method JumpTo(targetDesktop) - Jumps to a specific virtual desktop by number.
 *   @param {Integer} targetDesktop - The desktop number to jump to.
 *   Skips if the number is out of range.
 */
class VDesktop {
    static _CurrentDesktop := 1
    static _DesktopCount := 2

    static Add() {
        VDesktop._DesktopCount++
        VDesktop._CurrentDesktop := VDesktop._DesktopCount
        Send '^#d'
    }

    static Delete() {
        if (VDesktop._DesktopCount > 1) {
            VDesktop._DesktopCount--
            VDesktop._CurrentDesktop := VDesktop._DesktopCount
            Send '^#{F4}'
        }
    }

    static SwitchToPrev() {
        if (VDesktop._CurrentDesktop > 1) {
            VDesktop._CurrentDesktop--
            Send '^#{Left}'
        }
    }

    static SwitchToNext() {
        if (VDesktop._CurrentDesktop < VDesktop._DesktopCount) {
            VDesktop._CurrentDesktop++
            Send '^#{Right}'
        }
    }

    static JumpTo(targetDesktop) {
        if (targetDesktop < 1 || targetDesktop > VDesktop._DesktopCount)
            return

        while (targetDesktop != VDesktop._CurrentDesktop) {
            if (targetDesktop > VDesktop._CurrentDesktop)
                VDesktop.SwitchToNext()
            else
                VDesktop.SwitchToPrev()
        }
    }
}