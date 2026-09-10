#Requires AutoHotkey v2.0

#Include Powerscribe.ahk
#Include ChangeHealthcare.ahk

PutPriorDateInReport()
{
    date:=GetPriorDate()
    WinActivate(PowerScribe)
    WinWaitActive(PowerScribe)
    Send("^{Home}") ; To beginning of report
    Send("{Down}")
    Send("{Tab}")
    Sleep(100)
    Send("{Tab}")
    Sleep(100)

    if(date)
    {
        Send(date)
    }
    else
    {
        Send("None")
    }
}