#Requires AutoHotkey v2.0

#Include ../libraries/OCR.ahk
#Include Constants.ahk

CHANGE_DATE_OCR_OPTIONS := {
    scale: 3,
    ; grayscale: true,
    monochrome: 125, ; 0-255
    invertcolors: false,
    rotate: 0,
    flip: 0,
    ;decoder: gif | ico | jpeg | jpegxr | png | tiff | bmp

    ; x: x,
    ; y: y,
    ; w: w,
    ; h: h,
}

OCRSpecificControl_Windows(window,control,options)
{
    try
    {
        
        ControlGetPos(&x,&y,&w,&h,control,window)

        options := options
        options.x:=x
        options.y:=y
        options.w:=w
        options.h:=h

        ; ocr_result:=OCR.FromBitmap(original_bmp, options)
        return OCR.FromWindow(window,options)
    }
}

OCRSpecificControl_Capture2Text(window,control)
{
    try
    {
        
        ControlGetPos(&x,&y,&w,&h,control,window)
        
        ; Change to absolute screen coordinates for Capture2Text
        WinGetPos(&winx, &winy, , , window)
        x:=winx+x
        y:=winy+y

        ; ocr_result:=OCR.FromBitmap(original_bmp, options)

        Coordinates := "`"" . x . " " . y  . " " . x+w . " " . y+h . "`""
        ; Use /k for debugging, /c for production
        Mode1:=" /c "
        ; Use "Max" for debugging, "Hide" for production
        Mode2:="Hide"
        Command := A_Comspec . Mode1 . Capture2Text_Executable . " --clipboard" . " --screen-rect " . Coordinates . ""
        OutputDebug("Command is: " . Command)
        A_Clipboard:=""
        RunWait(Command,Capture2Text_Directory,Mode2)
        ClipWait(3)
        OutputDebug("Clipboard is " . A_Clipboard)
        OutputDebug("")
        return {
            Text:A_Clipboard
        }
    }
}