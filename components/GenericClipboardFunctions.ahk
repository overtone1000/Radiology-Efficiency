#Requires AutoHotkey v2.0

CopyFromActiveWindow(timeout:=2000)
{
    A_Clipboard:="" ; empty clipboard prior to using clipwait
    Send("^c")
    return ClipWait(timeout,1) ; 0 if timeout, otherwise 1
}

PasteToActiveWindow()
{
    Send("^v")
    Sleep(500)
}