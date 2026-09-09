#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk

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

PrintScreen()
{
    Send("!{PrintScreen}") ; Alt+Printscreen, this is confirmed working and copies current active window to clipboard.

    ; https://github.com/buliasz/AHKv2-Gdip
    /*
        #Include Gdip_All.ahk  ; Make sure you have the Gdip_All library

    ^!c::  ; Press Ctrl+Alt+C to crop the clipboard image
    pToken := Gdip_Startup()
    pBitmap := Gdip_CreateBitmapFromClipboard()

    if !pBitmap
    {
        MsgBox, No image found in clipboard!
        Gdip_Shutdown(pToken)
        return
    }

    ; Define crop coordinates (x, y, width, height in pixels)
    x := 50
    y := 50
    width := 300
    height := 200

    ; Create a new bitmap for the cropped area
    pBitmapCropped := Gdip_CreateBitmap(width, height)
    G := Gdip_GraphicsFromImage(pBitmapCropped)

    ; Draw the specified section of the original image into the new cropped bitmap
    Gdip_DrawImage(G, pBitmap, 0, 0, width, height, x, y, width, height)

    ; Send the new cropped image back to the clipboard
    Gdip_SetBitmapToClipboard(pBitmapCropped)

    ; Clean up resources
    Gdip_DeleteGraphics(G)
    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(pBitmapCropped)
    Gdip_Shutdown(pToken)

    ToolTip, Image cropped and copied!
    Sleep, 1000
    ToolTip
    return

    */
}

Test(){
    PrintScreen()
    MsgBox("Test complete")
}