#Requires AutoHotkey v2.0

/*
    ^ is Ctrl
    + is Shift
    Send("{Blind}^") could be used to reactivate ctrl down (so it doesn't need to be pushed again)
    
    Mapping to Ctrl & a instead of ^a will allow chaining multiple commands together with ctrl held.
    If using ^a, the Ctrl will be undone with any "Send" commands.
    But, this disables the native command! In this case, selecting all with Ctrl+A will never work
*/

global PowerScribe := "PowerScribe"
global Epic := "Hyperspace"
global RadCalc := "RadCalc"

Activate_Send_Return(window,message,delay:="")
{
    SetKeyDelay (10, 30) ; 10ms between keys, 50ms press duration, hopefully more reliable

    current := WinActive("A")
    
    if window==current
    {
        Send(message)
    }
    else
    {
        WinActivate(window)
        ; Sleep delay ; Not needed
        Send(message)
        if delay
        {
            Sleep delay ; Definitely needed for dictation toggle!
        }
        WinActivate(current)
    }

    Return
}

BackgroundSend(window,message)
{
    hWnd := WinExist(window)
    if hWnd
    {
        SetKeyDelay (10, 30) ; 10ms between keys, 50ms press duration

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

SendActiveWindowDown()
{
    Send("#{Down}")
    Send("#{Down}")
}

ToggleVisibility(window,maximize)
{
    /*
        Pushes window down if it's active.
        Send Down twice in case the window is maximized
    */
    if WinActive(window)
    {
         SendActiveWindowDown()
    }
    else
    {
        WinActivate(window)
        if maximize
        {
            WinMaximize(window)
        }
    }
    Return
}

; 0 - Copy everything from powerscribe into browser
^+0::
{
    WinActivate(Powerscribe)
    Send("^a")
    Sleep(100)
    Send("^x")
    Sleep(100)
    SendActiveWindowDown()
    Sleep(200)
    WinActivate(RadCalc)
    Sleep(200)
    CoordMode("Mouse", "Client")
    Click("543 128")
    Sleep(100)
    A_Clipboard := "" ; Clear the clipboard to avoid problems!
}

; 00
^+;::
{
    ToggleVisibility(Powerscribe, true)
}

; . Del
^+.::
{
    if A_Clipboard == ""
    {
        MsgBox("Clipboard is empty!")
    }
    else
    {
        if WinExist(RadCalc)
        {
            WinActivate(Powerscribe)
            Send("^a")
            Send("^v")
            Send("^{Home}")
            Sleep(1000)
            Send("{F12}") ; sign report
        }
        else
        {
            MsgBox("No RadCalc Window")
        }
    }
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
    Activate_Send_Return(PowerScribe, "{F4}", 10)
}

; 6
^+6::
{
    Activate_Send_Return(PowerScribe, "{Tab}")
}

; 7
^+7::
{
    Activate_Send_Return(PowerScribe, "{Backspace}")
}

; 8, still mapped to * for some reason
^+8::
{
    Send("8 pressed.")
}

; 9
^+9::
{
    Activate_Send_Return(PowerScribe, "{Delete}")
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
        WinActivate(RadCalc)
}



; Enter
^+Enter::
{
    Activate_Send_Return(PowerScribe, "{F4}", 10)
    
}

Alt & v::
{
    Activate_Send_Return(PowerScribe, "+{Tab}")
}


Alt & b::
{
    Activate_Send_Return(PowerScribe, "{F4}", 10)
    
}

Alt & n::
{
    Activate_Send_Return(PowerScribe, "{Tab}")
}

Ctrl & e::
{
    ToggleVisibility("Hyperspace",false)
}