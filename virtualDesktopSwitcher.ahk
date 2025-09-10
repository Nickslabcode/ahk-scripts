#Requires AutoHotkey v2.0
#SingleInstance Force

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

; === key mapping ===

+#q::
+#XButton1::VDesktop.SwitchToPrev()

+#w::
+#XButton2::VDesktop.SwitchToNext()

+#n::VDesktop.Add()
+#d::VDesktop.Delete()

+#1::VDesktop.JumpTo(1)
+#2::VDesktop.JumpTo(2)
+#3::VDesktop.JumpTo(3)
+#4::VDesktop.JumpTo(4)