#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk
#Include AutoIndicationAndPrior.ahk

CopyFromPowerscribeToRadcalcDEXA()
{
    if(WinExist(RadCalcDEXA))
    {
        WinActivate(Powerscribe)
        WinWaitActive(PowerScribe)
        Send("^a")
        Sleep(200) ; Make sure selection happens
        Send("^x")
        Sleep(200) ; Make sure full cut happens
        WinMinimize(Powerscribe)
        Sleep(200)
        
        WinActivate(RadCalcDEXA)
        WinWaitActive(RadCalcDEXA)

        CoordMode("Mouse", "Client")
        Click(radcalc_ingest_button)
        Sleep(100)
        A_Clipboard := "" ; Clear the clipboard to avoid problems!

        CopyPriorDateIfExists()
    }
    else
    {
        MsgBox("RadCalcDEXA not open.")
    }
}

CopyPriorDateIfExists()
{
    date:=GetPriorDate()
    A_Clipboard:=""
    date_field_coords:="504 271"
    WinActivate(RadCalcDEXA)
    WinWaitActive(RadCalcDEXA)
    if(IsSet(date) AND date!="" AND date.date_result!="")
    {
        CoordMode("Mouse", "Client")
        Click(date_field_coords)
        Sleep(0)
        
        if(date.date_result.month<10){
            Send("0")
        }
        Send(date.date_result.month)
        if(date.date_result.day<10){
            Send("0")
        }
        Send(date.date_result.day)
        Send(date.date_result.year)
    }
}

CopyFromRadcalcDEXAToPowerscribeAndSignReport()
{
    if A_Clipboard == ""
    {
        MsgBox("Clipboard is empty!")
    }
    else
    {
        if WinExist(RadCalcDEXA)
        {
            if WinActive(RadCalcDEXA)
            {
                WinActivate(Powerscribe)
                WinWaitActive(PowerScribe)
                Send("^a")
                PasteToActiveWindow()
                Send("^{Home}") ; To beginning of report
                Sleep(1000)
                Send("{F12}") ; sign report
            }
            else
            {
                MsgBox("RadCalc is not the active window. Aborting for safety.")
            }
        }
        else
        {
            MsgBox("No RadCalc Window")
        }
    }
}