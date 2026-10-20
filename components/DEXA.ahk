#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk
#Include AutoIndicationAndPrior.ahk

CopyFromPowerscribeToRadcalcDEXA()
{
    if(WinExist(RadCalcDEXA))
    {
        date := GetFormattedPriorDateIfExists()

        A_Clipboard:=""
        ActivateIfExistsAndNotActive(Powerscribe)
        Send("^a")
        Sleep(200) ; Make sure selection happens
        Send("^x")
        ;Sleep(200) ; Make sure full cut happens
        ClipWait(3,0)
        WinMinimize(Powerscribe)
        
        ;Sleep(200) ;Necessary? Yes, copy seems to fail. Necessary with ClipWait?
        
        if A_Clipboard == ""
        {
            MsgBox("Clipboard is empty! RadCalc DEXA copy aborting.")
        }
        else
        {
            if(IsSet(date) 
                AND date!="" 
            )
            {
                ingest := A_Clipboard          
                ingest := "comparison_exam_date:" . date . "`n" . ingest
                A_Clipboard := ""
                A_Clipboard := ingest
                ClipWait(3,0)
            }
            
            ActivateIfExistsAndNotActive(RadCalcDEXA)
            CoordMode("Mouse", "Client")
            Click(radcalc_ingest_button)
            Sleep(100)
            A_Clipboard := "" ; Clear the clipboard to avoid problems!
        }
    }
    else
    {
        MsgBox("RadCalcDEXA not open.")
    }
}

GetFormattedPriorDateIfExists()
{
    date:=GetPriorDate()
    retval:=""
    if(IsSet(date) 
        AND date!="" 
        AND date.date_result!=""
        AND date.date_result.month!=""
        AND date.date_result.day!=""
        AND date.date_result.year!=""
    )
    {
        month:=""
        if(date.date_result.month<10){
            month:="0" . date.date_result.month
        }
        else
        {
            month:=date.date_result.month
        }
                
        if(date.date_result.day<10){
            day:="0" . date.date_result.day
        }
        else
        {
            day:=date.date_result.day
        }
        
        
        retval:= date.date_result.year "-" month "-" day

        OutputDebug("Returning " retval)
    }

    return retval
}

CopyPriorDateIfExists()
{
    date:=GetFormattedPriorDateIfExists()

    MsgBox("This is defunct. Need to just send numbers, no slashes or dashes.")

    ;retval:=""
    ;if(date.date_result.month<10){
    ;    retval:=retval . "0"
    ;}
    ;retval:=retval . date.date_result.month
    ;if(date.date_result.day<10){
    ;    retval:=retval . "0"
    ;}
    ;retval:=retval . date.date_result.day}
    ;retval:=retval . date.date_result.year

    A_Clipboard:=""
    date_field_coords:="504 271"
    ActivateIfExistsAndNotActive(RadCalcDEXA)
    if(IsSet(date) 
        AND date!="" 
    )
    {
        CoordMode("Mouse", "Client")
        Click(date_field_coords)
        Sleep(0)
        
        Send(date)
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
                ActivateIfExistsAndNotActive(Powerscribe)
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