#Requires AutoHotkey v2.0

ToggleMicrophoneView()
{
    MicrophoneWindow:="Sound"
    if WinExist(MicrophoneWindow)
    {
        WinClose(MicrophoneWindow)
    }
    else
    {
        tabs:="SysTabControl321"
        list:="SysListView321"
        window:="Sound"
        Run("control.exe mmsys.cpl,,1") ; opens to recording tab
        ;WinWait (window) ; Wait until it's open
        ;WinActivate(window)
        ;WinWaitActive(window)
        ;result:=ListViewGetContent("",list,window) ;
        ;MsgBox(result)
        ;ControlFocus(list, window)
        ;ControlSend("Rode Microphone",list,window)

        ; Doesn't quite work.
    }    
    Return
}