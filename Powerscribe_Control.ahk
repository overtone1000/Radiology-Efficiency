#Requires AutoHotkey v2.0

/*
    ^ is Ctrl
    + is Shift
    Send("{Blind}^") could be used to reactivate ctrl down (so it doesn't need to be pushed again)
*/

global PowerScribe := "PowerScribe"
global Epic := "Hyperspace"

Activate_Send_Return(window,message)
{
    current := WinActive("A")

    WinActivate(window)
    Sleep -1 ;Make sure keystrokes are done
    Send(message)
    Sleep -1 ;Make sure keystrokes are done

    WinActivate(current)
    Return
}

BackgroundSend(window,message)
{
    hWnd := WinExist(window)
    if hWnd
    {
        SetKeyDelay (10, 50) ; 10ms between keys, 50ms press duration

        ;F1::ControlSend, ahk_parent, {F4}, ahk_exe Nuance.PowerScribe360.exe

        ;MsgBox("ahk_id " . hWnd)
        ;ControlSend(message,  "ahk_id " . hWnd) ;This doesn't work
        ;ControlSend(message, hWnd) ;This doesn't work
        ;ControlSend(message, "ahk_parent", "ahk_exe Nuance.PowerScribe360.exe") ;This doesn't work
        ;PostMessage(WM_CHAR, , 0, hWnd)
    }
    else
    {
        MsgBox("Couldn't find window.")
    }
}

ToggleVisibility(window)
{
    /*
        Pushes window down if it's active.
        Send Down twice in case the window is maximized
    */
    if WinActive(window)
    {
        Send("#{Down}")
        Send("#{Down}")   
    }
    else
    {
        WinActivate(window)
    }
    Return
}

; 0
^+0::
{
    Send("^a")
    Send("^x")
}

; 00
^+;::
{
    ToggleVisibility(Powerscribe)
}

; . Del
^+.::
{
    Send("^a")
    Send("^v")
}

; 1
^+1::
{
}

; 2
^+2::
{
}

; 3
^+3::
{
}

; 4
^+4::
{
    Activate_Send_Return(PowerScribe, "+{Tab}")
}

; 5
^+5::
{
    Activate_Send_Return(PowerScribe, "{F4}")
}

; 6
^+6::
{
    Activate_Send_Return(PowerScribe, "{Tab}")
}

; 7
^+7::
{
}

; 8, still mapped to * for some reason
^+8::
{
    Send("8 pressed.")
}

; 9
^+9::
{
}

; *
^+,::
{
}

; -
^+-::
{
}

; mapped to ,
^+*::
{
}

^+/::
{
}

; Numlock
^+'::
{
}



; Enter
^+Enter::
{
    Activate_Send_Return(PowerScribe, "{F4}")
}

^Space::
{
    Activate_Send_Return(PowerScribe, "{F4}")
}

^e::
{
    ToggleVisibility("Hyperspace")
}