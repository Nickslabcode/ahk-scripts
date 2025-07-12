#Requires AutoHotkey v2.0

Numpad0::
{
  MsgBox 'You have pressed ' . ThisHotkey ; Reports Numpad0
  try {
    InputBoxObject := InputBox('Type an app to launch', 'App Launcher')

    Run InputBoxObject.Value
  } catch Error as e {
    MsgBox 'There was a problem runing the app:`n' . e.Message, 'Oops!'
  }
}
