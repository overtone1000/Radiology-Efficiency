#Requires AutoHotkey v2.0

#Include GenericWindowFunctions.ahk

ActivateIfExistsAndNotActive(window, wait:=true, timeout:=unset)
{
    if(WinExist(window))
    {
        if(not WinActive(window))
        {
            WinActivate(window)
            if(wait)
            {
                if(IsSet(timeout))
                {
                    return WinWaitActive(window,,timeout)
                }
                else
                {
                    return WinWaitActive(window)
                }
            }
            else
            {
                return WinGetID(window)
            }
        }
    }
    else
    {
        return 0
    }
}

Activate_And_Wait(window, timeout)
{
    return ActivateIfExistsAndNotActive(window,true,timeout)
}

Activate_Run_Return(window,bound_function,delay:="")
{
    if(WinExist(window))
    {        
        if WinActive(window)
        {
            bound_function()
        }
        else
        {
            current := WinActive("A")
            WinActivate(window)
            WinWaitActive(window)
            ; Sleep delay ; Not needed
            bound_function()
            if delay
            {
                Sleep delay ; Definitely needed for dictation toggle!
            }
            WinActivate(current)
        }
    }
}

Activate_Send_Return(window,message,delay:="")
{
    SetKeyDelay (10, 30) ; 10ms between keys, 50ms press duration, hopefully more reliable
    bound_send(){
        Send(message)
    }
    Activate_Run_Return(window,bound_send,delay)
}

Activate_Click_Return(window,coords,delay:="",return_to_original_position:=false)
{
    x:=""
    y:=""
    if(return_to_original_position)
    {
        CoordMode("Mouse", "Screen")
        MouseGetPos(&x,&y)
    }
    bound_click(){
        CoordMode("Mouse", "Client")
        Click(coords)
    }
    Activate_Run_Return(window,bound_click,delay)
    if(return_to_original_position)
    {
        CoordMode("Mouse", "Screen")
        MouseMove(x,y,0)
    }
}

BackgroundSend(window,message)
{
    hWnd := WinExist(window)
    if hWnd
    {
        SetKeyDelay (10, 30) ; 10ms between keys, 30ms press duration

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

 ;maybe phase this out, doesn't work as reliably as WinMinimize
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

    if ActivateIfExistsAndNotActive(window,true,)!=0
    {
        WinMinimize(window)
    }
}