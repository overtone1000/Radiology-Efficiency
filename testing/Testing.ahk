#Requires AutoHotkey v2.0

#Include ../components/Constants.ahk
#Include ../components/GenericWindowFunctions.ahk
#Include ../components/AutoIndicationAndPrior.ahk

PowerscribeDirectReportAccess()
{
    ReportControl:="WindowsForms10.RICHEDIT50"
    len:=StrLen(ReportControl)
    controls:=WinGetControls(Powerscribe)
    
    for(control in controls)
    {
        front:=SubStr(control,1,len)
        if(front==ReportControl)
        {
            text:=ControlGetText(control,Powerscribe)
            ControlGetPos(&OutX, &OutY, &OutWidth, &OutHeight, control,Powerscribe)
            ; Looks like it's the first one. Check size too might help?
            ; Maybe move mouse around to determine which elements have this type?
        }
    }
    
    ; report:=ControlGetText(ReportControl, PowerScribe)   

    ; MsgBox(report)
    
    ; ControlGetText()
}

FuzzPowerscribe()
{
    ; Got to about 16000 and didn't get anything

    MsgType   := 0x0111 ; WM_COMMAND
    DelayMs := 1
    Loop
    {
        HexStr := Format("0x{:X}", A_Index)
        OutputDebug("Sending Msg: " HexStr " (" A_Index ")")
        
        ; PostMessage does not wait for a response, making it faster for fuzzing
        PostMessage(MsgType, A_Index, 0, , PowerScribe)
        
        Sleep(DelayMs)
    }
}

TimeTest()
{
    start := A_TickCount
    iterations:=20

    n:=0
    loop{
        OutputDebug(n)
        WinActivate(Powerscribe)
        WinWaitActive(PowerScribe)
        n:=n+1
    }until n>=iterations-1

    end:= A_TickCount
    time:= (end-start)/iterations

    OutputDebug("Winactivate + wait takes " time " ms.")
}

Test(){
    OutputDebug("Starting test.")
   
    
    
    OutputDebug("Test complete!")
}

Test()