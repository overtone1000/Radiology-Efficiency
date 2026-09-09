#Requires AutoHotkey v2.0

#Include Constants.ahk
#Include GenericWindowFunctions.ahk



PowerscribeToggleDictation()
{
    Activate_Send_Return(PowerScribe, "{F4}", 30)
}

PowerscribePreviousField()
{
    Activate_Send_Return(PowerScribe, "+{Tab}")
}

PowerscribeNextField()
{
    Activate_Send_Return(PowerScribe, "{Tab}")
}
