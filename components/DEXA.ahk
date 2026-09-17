#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

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
    }
    else
    {
        MsgBox("RadCalcDEXA not open.")
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