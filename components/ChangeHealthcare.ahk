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
    ["g","9"],
    ["a","4"],
    ["l","1"]
]

month_lookalikes:=
[
    ["juf","jul"]
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

modalities:=
[
    "CT",
    "MR",
    "PT",
    "NM"
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

ForceToKnownMonth(str)
{
    str:=ForceToLetters(str)

    for(lookalike in month_lookalikes)
    {
        if(str==lookalike[1])
        {
            str:=lookalike[2]
            break
        }
    }

    return str
}

GetModalityFromControlText(text)
{
    modality_regex:="(,)([A-Za-z]{2,4})(,)"

    no_spaces:=StrReplace(text, " ", "")

    result:=RegExMatch(no_spaces,modality_regex,&modality_result)

    if(result>0)
    {
        found_modality:=modality_result[2]

        for(modality in modalities)
        {
            if(found_modality==modality)
            {
                return found_modality
            }
        }

        MsgBox("Unexpected modality " found_modality " found.")
    }
    else
    {
        ;MsgBox("No modality found in " text)
    }
}

GetDateFromControlText(text)
{
    retval:=""

    ; Regex
    ; Two chars, a dash, three chars, a dash, four chars
    date_regex:="(.{2}-.{3}-.{4})"
    
    ; Remove spaces, sometimes erroneously detects a space character
    no_spaces:=StrReplace(text, " ", "")

    ;Change emdashes to simple dashes
    monodash:=StrReplace(no_spaces,"—","-")

    result:=RegExMatch(monodash,date_regex,&date_result)

    if(result>0)
    {
        rawdateregex:=date_result[1]
        
        ;Force to lowercase
        rawdateregex:=StrLower(rawdateregex)

        fields:=StrSplit(rawdateregex,"-")
        
        day:=ForceToNumbers(fields[1])
        day:=LTrim(day,"0") ; Remove leading zeroes

        month:=ForceToKnownMonth(fields[2])
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
    else
    {
        ;Only for debugging
        ;MsgBox(no_spaces)
    }
    
    return retval
}

GetPriorDate()
{
    control:=GetStudyOnRightControl()
    if(IsSet(control))
    {
        ; ocr_result:=OCRSpecificControl(ChangePACS,control,CHANGE_DATE_OCR_OPTIONS)
        ocr_result:=OCRSpecificControl_Capture2Text(ChangePACS,control)
        if(IsSet(ocr_result) AND ocr_result!="")
        {
            date:=GetDateFromControlText(ocr_result.Text)
            modality:=GetModalityFromControlText(ocr_result.Text)
            return {
                ocr_result:ocr_result,
                date:date,
                modality:modality
            }
        }
        else
        {
            OutputDebug("No result.")
        }
    }
}