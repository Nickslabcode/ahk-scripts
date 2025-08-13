#Include %A_ScriptDir%\Lib\helper.ahk ; Import class from helper lib
#Requires AutoHotkey v2.0
#SingleInstance Force ; Skips dialog box and replaces old instance automatically. Similar to `Reload` command

; === Key mapping ===
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

