#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

epic_profile:=[58,87]
epic_field_bottom:=[150,1105]
epic_field_top:=[2,133]

weight_regex:="\((.*?)kg\)"
height_regex:="\((.*?)m\)"
age_regex:=", (.*?) yrs,"
female_regex:="Female"
male_regex:="Male"

GetEpicData()
{
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
    
    Click(epic_profile[1],epic_profile[2])
    Sleep(1000)
    MouseMove(epic_field_bottom[1],epic_field_bottom[2],0)
    Sleep(-1)
    Send("{Wheeldown 10}")
    ;Send("{LButton Down}")
    ;Sleep(-1)
    ;Send("{LButton Up}")
    ;Sleep(-1)
    Send("{LButton Down}")
    ;Sleep(-1)
    MouseMove(epic_field_top[1],epic_field_top[2],0)
    Sleep(-1)
    Send("{LButton Up}")
    ;Sleep(-1)
    Send("^c")
    Sleep(100) ;Takes time for clipboard to populate
    Click(epic_field_bottom[1],epic_field_bottom[2])

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

    return {
        weight_in_kg:weight_in_kg,
        height_in_m:height_in_m,
        age:age,
        is_male:is_male,
        is_female:is_female
    }
}

EnterInfoIntoRadcalc(data)
{
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

    if(data.age!=="")
    {
        enter_info(age_box,data.age)
    }
    if(data.height_in_m!=="")
    {
        enter_info(height_box,Round(data.height_in_m*100,1))
    }
    if(data.weight_in_kg!=="")
    {
        enter_info(weight_box,data.weight_in_kg)
    }

    if(data.is_male == data.is_female)
    {
        MsgBox("Couldn't determine sex.")
    }
    else
    {
        if(data.is_male)
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

GetMonitorCoords(monitor_index)
{
    MonitorGetWorkArea(monitor_index, &left, &top, &right, &bottom)
    
    x_half:=(left+right)/2
    height:=(bottom-top)

    return {
        x_half:x_half,
        height:height,
        left:left,
        top:top,
        bottom:bottom,
        right:right
    }
}

CopyInfoFromEpicIntoRadcalcAAoAndCalculate()
{
    monitor_index:=0
    monitor:=GetMonitorCoords(monitor_index)
      
    WinActivate(Epic)
    WinWaitActive(Epic)
    WinMove(monitor.x_half,monitor.top,monitor.x_half,monitor.bottom,Epic)
    Sleep(200)

    data:=GetEpicData()

    WinActivate(MSEdge)
    WinWaitActive(MSEdge)
    Send("^0")

    url:="https://radcalc.overdesigned.org/AscendingAorticDiameter?"

    append_url(key,value)
    {
        url:=url . key . "=" . value . "&"
    }
    
    if(data.age!=="")
    {
        append_url("age",data.age)
    }
    if(data.height_in_m!=="")
    {
        append_url("height",Round(data.height_in_m*100,1))
    }
    if(data.weight_in_kg!=="")
    {
        append_url("weight",data.weight_in_kg)
    }

    if(data.is_male == data.is_female)
    {
        MsgBox("Couldn't determine sex.")
    }
    else
    {
        if(data.is_male)
        {
            append_url("sex","M")
        }
        else
        {
            append_url("sex","F")
        }
    }

    Run(url)
    WinActivate(MSEdge)
    WinWaitActive(MSEdge)
    WinMove(0,monitor.top,monitor.x_half,monitor.bottom,MSEdge)

    ; Old way, use GET parameters instead
    ; EnterInfoIntoRadcalc(data)
}