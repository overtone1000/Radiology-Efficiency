#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

CopyInfoFromEpicIntoRadcalcAAoAndCalculate()
{
        monitor_index:=0
    MonitorGet(monitor_index, &left, &top, &right, &bottom)
    x_half:=(left+right)/2
    height:=(bottom-top)
   
    Run("https://radcalc.overdesigned.org/AscendingAorticDiameter")
    WinActivate(Browser)
    WinWaitActive(Browser)
    WinMove(0,top,x_half,bottom,Browser)
    
    WinActivate(Epic)
    WinWaitActive(Epic)
    WinMove(x_half,top,x_half,bottom,Epic)
    Sleep(200)

    CoordMode("Mouse", "Client")
    SendMode("Event")
    
    ;This would search for vitals but wasn't reliable.
    ;Send("^{Space}")
    ;Sleep(100)
    ;Send("Vitals")
    ;Sleep(100)
    ;Send("{Enter}")
    ;Sleep(500)
    ;CoordMode("Mouse", "Client")
    ;Click("226, 254")
    ;Sleep(500)
    ;Click("312, 155")
    ;Sleep(200)

    profile:=[58,87]
    bottom:=[150,1105]
    top:=[2,133]
    
    Click(profile[1],profile[2])
    Sleep(1000)
    MouseMove(bottom[1],bottom[2],0)
    Sleep(-1)
    Send("{Wheeldown 10}")
    ;Send("{LButton Down}")
    ;Sleep(-1)
    ;Send("{LButton Up}")
    ;Sleep(-1)
    Send("{LButton Down}")
    ;Sleep(-1)
    MouseMove(top[1],top[2],0)
    Sleep(-1)
    Send("{LButton Up}")
    ;Sleep(-1)
    Send("^c")
    Sleep(100) ;Takes time for clipboard to populate
    Click(bottom[1],bottom[2])
    
    weight_regex:="\((.*?)kg\)"
    height_regex:="\((.*?)m\)"
    age_regex:=", (.*?) yrs,"
    female_regex:="Female"
    male_regex:="Male"

    weight_result:=""
    height_result:=""
    age_result:=""

    weight_index:=RegExMatch(A_Clipboard,weight_regex,&weight_result)
    height_index:=RegExMatch(A_Clipboard,height_regex,&height_result)
    age_index:=RegExMatch(A_Clipboard,age_regex,&age_result)
    male_index:=RegExMatch(A_Clipboard,male_regex)
    female_index:=RegExMatch(A_Clipboard,female_regex)

    ; Clear clipboard of identifying information
    A_Clipboard:=""

    is_male:=male_index>0
    is_female:=female_index>0

    weight_in_kg:=""
    height_in_m:=""
    age:=""

    if(weight_index==0)
    {
        MsgBox("Couldn't get weight.")
    }
    else
    {
        weight_in_kg:=weight_result[1]
    }

    if(height_index==0)
    {
        MsgBox("Couldn't get height.")
    }
    else
    {
        height_in_m:=height_result[1]
    }
    
    if(age_index==0)
    {
        MsgBox("Couldn't get age.")
    }
    else
    {
        age:=age_result[1]
    }

    WinActivate(Browser)
    WinWaitActive(Browser)
    Send("^0")

    age_box:="59, 421"
    height_box:="76, 474"
    weight_box:="151, 526"
    male_radio:="17, 564"
    female_radio:="18, 592"
    empty:="167, 650"

    enter_info(location, value)
    {
        Click(location)
        Send(value)
        Sleep(10)
    }

    if(age!=="")
    {
        enter_info(age_box,age)
    }
    if(height_in_m!=="")
    {
        enter_info(height_box,Round(height_in_m*100,1))
    }
    if(weight_in_kg!=="")
    {
        enter_info(weight_box,weight_in_kg)
    }

    if(is_male == is_female)
    {
        MsgBox("Couldn't determine sex.")
    }
    else
    {
        if(is_male)
        {
            Click(male_radio)
        }
        else
        {
            Click(female_radio)
        }
    }

    Click(empty)
}