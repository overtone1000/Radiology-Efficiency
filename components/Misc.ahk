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
        
        ; Doesn't quite work.
    }    
    Return
}