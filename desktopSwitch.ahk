#Requires AutoHotkey v2.0

; Global variables
CurrentDesktop := 1
DesktopCount := 2 ; On Windows start, the virtual desktops are 2

; Key mapping
+#q::
+#XButton1:: switchToPrevDesktop

+#w::
+#XButton2:: switchToNextDesktop

+#n:: addNewDesktop

+#d:: deleteCurrentDesktop

+#1:: jumpToTargetDesktop 1
+#2:: jumpToTargetDesktop 2
+#3:: jumpToTargetDesktop 3
+#4:: jumpToTargetDesktop 4

addNewDesktop() {
    global CurrentDesktop, DesktopCount

    DesktopCount++
    CurrentDesktop := DesktopCount

    Send '^#d'
}

deleteCurrentDesktop() {
    global CurrentDesktop, DesktopCount

    DesktopCount--
    CurrentDesktop := DesktopCount

    Send '^#{F4}'
}

switchToPrevDesktop() {
    global CurrentDesktop

    if (CurrentDesktop == 1)
        return

    CurrentDesktop--

    Send '^#{Left}'
}

switchToNextDesktop() {
    global CurrentDesktop, DesktopCount

    if (CurrentDesktop == DesktopCount)
        return

    CurrentDesktop++

    Send '^#{Right}'
}

jumpToTargetDesktop(targetDesktop) {
    global CurrentDesktop, DesktopCount

    if (targetDesktop > DesktopCount || targetDesktop < 1)
        return

    while (targetDesktop != CurrentDesktop) {
        if (targetDesktop > CurrentDesktop) {
            switchToNextDesktop
        } else if (targetDesktop < CurrentDesktop) {
            switchToPrevDesktop
        }
    }
}
