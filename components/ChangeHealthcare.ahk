#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include OCR_functions.ahk

GetStudyOnRightControl()
{
    WinActivate(ChangePACS)
    WinWaitActive(ChangePACS)
    
    control1:="AliTbCntrlStudyDetails1"
    control2:="AliTbCntrlStudyDetails2"

    try 
    {
        ControlGetPos(&x1,&y1,&w1,&h1,control1,ChangePACS)
    }
    try 
    {
        ControlGetPos(&x2,&y2,&w2,&h2,control2,ChangePACS)
    }


    if(IsSet(x1) AND IsSet(x2))
    {
        if(x1>x2)
        {
            return control1
        }
        else
        {
            return control2
        }
    }
    else
    {
        if(IsSet(x1))
        {
            if(x1>0)
            {
                return control1
            }
        }
        else if(IsSet(x2))
        {
            if(x2>0)
            {
                return control2
            }
        }
        return
    }
}

number_letter_lookalikes:=
[
    ["i","1"],
    ["o","0"],
    ["g","9"]
]

months:=
[
    "jan",
    "feb",
    "mar",
    "apr",
    "may",
    "jun",
    "jul",
    "aug",
    "sep",
    "oct",
    "nov",
    "dec",
]

ForceToNumbers(str)
{
    retval:=str
    for(pair in number_letter_lookalikes)
    {
        retval:=StrReplace(retval,pair[1],pair[2])
    }
    return retval
}

ForceToLetters(str)
{
    retval:=str
    for(pair in number_letter_lookalikes)
    {
        retval:=StrReplace(retval,pair[2],pair[1])
    }
    return retval
}

GetDateFromControlText(text)
{
    retval:=""

    ; Regex
    ; One space on the front and back
    ; Two digits, a dash, three letters, a dash, four digits
    date_regex:="( )(.{2}-.{3}-.{4})( )"
    
    result:=RegExMatch(text,date_regex,&date_result)

    if(result>0)
    {
        rawdateregex:=date_result[2]
        
        ;Force to lowercase
        rawdateregex:=StrLower(rawdateregex)

        fields:=StrSplit(rawdateregex,"-")
        
        day:=ForceToNumbers(fields[1])
        month:=ForceToLetters(fields[2])
        year:=ForceToNumbers(fields[3])

        for(index,value in months)
        {
            if(month==value)
            {
                month:=index
                break
            }
        }

        retval:=month . "/" . day . "/" . year
    }

    return retval
}

GetPriorDate()
{
    control:=GetStudyOnRightControl()
    if(IsSet(control))
    {
        ocr_result:=OCRSpecificControl(ChangePACS,control,true)
        if(IsSet(ocr_result) AND ocr_result!="")
        {
            date:=GetDateFromControlText(ocr_result.Text)
            return {
                ocr_result:ocr_result,
                date:date
            }
        }
    }
}