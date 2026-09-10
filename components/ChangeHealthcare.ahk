#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include OCR_functions.ahk

GetStudyOnRightControl()
{
    control1:="AliTbCntrlStudyDetails1"
    control2:="AliTbCntrlStudyDetails2"
    ControlGetPos(&x1,&y1,&w1,&h1,control1,ChangePACS)
    ControlGetPos(&x2,&y2,&w2,&h2,control2,ChangePACS)

    if(x1>x2)
    {
        return control1
    }
    else
    {
        return control2
    }
}

GetDateFromControlText(text)
{
    retval:=""

    ; Regex
    ; One space on the front and back
    ; Two digits, a dash, three letters, a dash, four digits
    date_regex:="( )(\d{2}-[A-Za-z]{3}-\d{4})( )"
    
    result:=RegExMatch(text,date_regex,&date_result)

    if(result>0)
    {
        retval:=date_result[2]
    }

    return retval
}

GetPriorDate()
{
    control:=GetStudyOnRightControl()
    ocr_result:=OCRSpecificControl(ChangePACS,control,true)
    date:=GetDateFromControlText(ocr_result.Text)
    return {
        ocr_result:ocr_result,
        date:date
    }
}