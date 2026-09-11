#Requires AutoHotkey v2.0

#Include ../libraries/OCR.ahk

OCRSpecificControl(window,control,inverted:=false)
{
    try
    {
        ControlGetPos(&x,&y,&w,&h,control,window)
        
        options := {
            scale: 3,
            grayscale: false,
            ; monochrome: 0-255
            invertcolors: inverted,
            rotate: 0,
            flip: 0,
            x: x,
            y: y,
            w: w,
            h: h,
            ;decoder: gif | ico | jpeg | jpegxr | png | tiff | bmp
        }

        ; ocr_result:=OCR.FromBitmap(original_bmp, options)
        return OCR.FromWindow(window,options)
    }
}
