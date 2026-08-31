#Requires AutoHotkey v2.0

/*
    ^ is Ctrl
    + is Shift
    Send("{Blind}^") could be used to reactivate ctrl down (so it doesn't need to be pushed again)
*/

global PowerScribe := "PowerScribe"
global Epic := "Hyperspace"

ActivateAndSend(window,message)
{
    WinActivate(window)
    Sleep 1 ;Make sure keystrokes are done
    Send(message)
    Return
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
    ActivateAndSend(PowerScribe, "+{Tab}")
}

; 5
^+5::
{
    ActivateAndSend(PowerScribe, "{F4}")
}

; 6
^+6::
{
    ActivateAndSend(PowerScribe, "{Tab}")
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
    ActivateAndSend(PowerScribe, "{F4}")
}

^Space::
{
    ActivateAndSend(PowerScribe, "{F4}")
}

^4::
{
    /*
        Pushes powerscribe window down if it's active.
        Resends Ctrl (^) since sending the down input undoes it.
    */
    if WinActive("PowerScribe")
    {
        Send("#{Down}")
        Send("#{Down}")
        Send("{Blind}^")   
    }
    Return
}

^e::
{
    ToggleVisibility("Hyperspace")
}