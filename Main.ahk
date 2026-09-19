#Requires AutoHotkey v2.0

#Include components/Constants.ahk
#Include components/GenericWindowFunctions.ahk
#Include components/Powerscribe.ahk
#Include components/DEXA.ahk
#Include components/AAo.ahk
#Include components/AutoIndicationAndPrior.ahk
#Include components/Misc.ahk
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
     ; Can get this working by running in VSCode with AHK++ either right click and run "Debug Configurations"
     ; or Ctrl+Alt+F9
    OutputDebug("Debug output!")
    Test()
}

; * mapped to ,
^+,::
{
    AutoIndicationAndPrior()
}

; -
^+-::
{
    ToggleMicrophoneView()
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

^+a::
{
    CopyInfoFromEpicIntoRadcalcAAoAndCalculate()
}

^+h::
{
    AutoIndicationAndPrior()
}

Ctrl & e::
{
    ToggleVisibility(Epic,false)
}