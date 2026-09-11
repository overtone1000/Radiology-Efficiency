#Requires AutoHotkey v2.0

#Include ../libraries/OCR.ahk

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

OCRSpecificControl(window,control,options)
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