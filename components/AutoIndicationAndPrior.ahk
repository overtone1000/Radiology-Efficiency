#Requires AutoHotkey v2.0

#Include Powerscribe.ahk
#Include ChangeHealthcare.ahk
#Include GenericClipboardFunctions.ahk


AutoIndicationAndPrior()
{
    WinActivate(PowerScribe)
    WinWaitActive(PowerScribe)
    Send("^{Home}") ; To beginning of report
    Sleep(100)
    Send("{Down}")
    Sleep(100)
    Send("{Tab}")
    Sleep(500)
    CopyFromActiveWindow()

    histories:=StrSplit(A_Clipboard,"`n","`r")
    parsed_histories:=[]
    for(item in histories)
    {
        parsed_history:=item
        if(SubStr(item,2,2)==". ")
        {
            parsed_history:=SubStr(parsed_history,4,StrLen(item))
        }
        parsed_history:=Trim(parsed_history)
        if(parsed_history !== "")
        {
            parsed_histories.Push(parsed_history)
        }
    }
    
    if(parsed_histories.length>0)
    {
        selected_history:=""
        if(parsed_histories.length==1)
        {
            selected_history:=parsed_histories[1]
        }
        else
        {
            for(parsed_history in parsed_histories)
            {
                if(StrLen(selected_history)<StrLen(parsed_history))
                {
                    selected_history:=parsed_history
                }
            }
        }
        if(selected_history!="")
        A_Clipboard:=selected_history
        Sleep(500)
        PasteToActiveWindow()
    }

    Sleep(500)
    Send("{Tab}")
    Sleep(500)

    res:=GetPriorDate()
    WinActivate(PowerScribe)
    if(IsSet(res) AND res.date!="")
    {
        A_Clipboard:=res.date
    }
    else
    {
        A_Clipboard:="None"
    }
    WinWaitActive(PowerScribe)
    PasteToActiveWindow()
    
    Sleep(1000) ; Can sleep for a long time here, the rest is just for debugging
    A_Clipboard:=res.ocr_result.Text
}