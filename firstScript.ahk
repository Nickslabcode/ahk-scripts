#Requires AutoHotkey v2.0

; MsgBox 'Hi'

; Run('chrome', 'Minimize')

try {
  Run 'nonexistingscript'
} catch Error as e {
  ErrorMessage := 'There was an error:`n'  e.Message

  MsgBox ErrorMessage
}