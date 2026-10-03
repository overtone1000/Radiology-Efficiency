#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk
#Include AutoIndicationAndPrior.ahk

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

Test(){
    OutputDebug("Starting test.")
   
    test:="1.*{Hx one}*2.*{Hx 2}*3.*{Hx3}*4.*{Hx4}*5.*{Hx5}*"

    results:=[]

    regex:="\*{(.*?)}\*"
    
    while (i:=RegexMatch(test,regex,&res,start)){
        results.Push(res[1])
        OutputDebug("   " res[1] " (" res.Len ")")
        start:=i+res.Len
        OutputDebug("Start is now " start)
    }

    OutputDebug("Test complete!")
}

Test()