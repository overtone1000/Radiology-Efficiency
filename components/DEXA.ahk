#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

CopyFromPowerscribeToRadcalcDEXA()
{
    WinActivate(Powerscribe)
    Send("^a")
    Sleep(200) ; Make sure selection happens
    Send("^x")
    Sleep(200) ; Make sure full cut happens
    WinMinimize(Powerscribe)
    Sleep(200)
    
    WinActivate(RadCalc)
    
    while((A_Index < 300) && NOT WinActive(RadCalc))
    {
        Sleep(10)
    }

    if WinActive(RadCalc)
    {
        CoordMode("Mouse", "Client")
        Click(radcalc_ingest_button)
        Sleep(100)
        A_Clipboard := "" ; Clear the clipboard to avoid problems!
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
        if WinExist(RadCalc)
        {
            if WinActive(RadCalc)
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
                MsgBox("RadCalc is not the active window. Aborting for safety.")
            }
        }
        else
        {
            MsgBox("No RadCalc Window")
        }
    }
}