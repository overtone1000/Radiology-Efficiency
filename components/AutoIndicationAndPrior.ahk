#Requires AutoHotkey v2.0

#Include Powerscribe.ahk
#Include ChangeHealthcare.ahk
#Include GenericClipboardFunctions.ahk
#Include GenericWindowFunctions.ahk

AutoIndicationAndPrior()
{
    date_function_result:=GetPriorDate() ;This causes powerscribe to lose focus, so do it first thing.

    if Activate_And_Wait(Powerscribe,2)==0 
    {
        return
    }

    Send("^{Home}") ; To beginning of report
    Sleep(100)
    Send("{Down}")
    Sleep(100)
    Send("{Tab}")
    Sleep(500)
    CopyFromActiveWindow()

    parsed_histories:=[]

    
    ; This way doesn't work because some histories are separated by lines.
    /*
    histories:=StrSplit(A_Clipboard,"`n","`r")
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
    */

    regex:="\*{(.*?)}\*"
    start:=1
    
    while (i:=RegexMatch(A_Clipboard,regex,&history_result,start)){
        parsed_histories.Push(history_result[1])
        OutputDebug("   " history_result[1] " (" history_result.Len ")")
        start:=i+history_result.Len
        OutputDebug("Start is now " start)
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

    ;No need to sleep here. PasteToActiveWindow handles its own sleep.
    ;Sleep(500)
    Send("{Tab}")
    Sleep(500)

    if(IsSet(date_function_result) AND date_function_result!="" AND date_function_result.date_result!="" AND date_function_result.date_result.datestring!="")
    {
        if(date_function_result.modality!="")
        {
            A_Clipboard:=date_function_result.modality . " " . date_function_result.date_result.datestring
        }
        else
        {
            A_Clipboard:=date_function_result.date_result.datestring
        }
    }
    else
    {
        A_Clipboard:="None"
    }
    
    PasteToActiveWindow()
    
    Sleep(1000) ; Can sleep for a long time here, the rest is just for debugging
    if(IsSet(date_function_result) AND date_function_result!="" AND date_function_result.ocr_result!="")
    {
        A_Clipboard:=date_function_result.ocr_result.Text
    }
}