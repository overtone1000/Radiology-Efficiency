#Requires AutoHotkey v2.0

#Include components/Constants.ahk
#Include components/GenericWindowFunctions.ahk
#Include components/Powerscribe.ahk
#Include components/DEXA.ahk
#Include components/AAo.ahk
#Include components/Testing.ahk

; 0 - Copy everything from powerscribe into browser
^+0::
{
    CopyFromPowerscribeToRadcalcDEXA()
}

; 00
^+;::
{
    ToggleVisibility(Powerscribe, true)
}

; . Del
^+.::
{
    CopyFromRadcalcDEXAToPowerscribeAndSignReport()
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
    PowerscribePreviousField()
}

; 5
^+5::
{
    bound_function()
    {
        Sleep(300)
        Send("{Tab}")
        Sleep(500)
        Send("+{Tab}")
    }
    ;Activate_Run_Return(Powerscribe,bound_function,10)
    ;This is working poorly when dictation is on.
}

; 6
^+6::
{
    PowerscribeNextField()
}

; 7
^+7::
{
    Activate_Send_Return(PowerScribe, "{Backspace}")
}

; 8, still mapped to * for some reason
^+*::
{
    CopyInfoFromEpicIntoRadcalcAAoAndCalculate()
}

; 9
^+9::
{
    Activate_Send_Return(PowerScribe, "{Delete}")
}

; +
^+=::
{
    Test()
}

; * mapped to ,
^+,::
{
    MsgBox("*")
}

; -
^+-::
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

    Return
}

; Not working with slash...
^+/::
{
    MsgBox("Slash") ; Not responding
}

; Numlock
^+'::
{
    Activate_Click_Return(Intellispace, max_button, 10, true)
}

; Enter
^+Enter::
{
    PowerscribeToggleDictation()
}

Alt & v::
{
    PowerscribePreviousField()
}


Alt & b::
{
    PowerscribeToggleDictation()
}

Alt & n::
{
    PowerscribeNextField()
}

Ctrl & e::
{
    ToggleVisibility(Epic,false)
}