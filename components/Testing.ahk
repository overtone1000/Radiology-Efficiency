#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

Test(){
    ReportControl:="WindowsForms10.RICHEDIT50"
    len:=StrLen(ReportControl)
    controls:=WinGetControls(Powerscribe)
    
    for(control in controls)
    {
        front:=SubStr(control,1,len)
        if(front==ReportControl)
        {
            text:=ControlGetText(control,Powerscribe)
            MsgBox("Found text " . text)
            ; Looks like it's the first one. Check size too might help?
        }
    }
    
    ; report:=ControlGetText(ReportControl, PowerScribe)   

    ; MsgBox(report)
    
    ; ControlGetText()
    MsgBox("Test complete")
}