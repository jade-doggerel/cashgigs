;; cashgigs: A simple key remapper and macro recorder for Windows.

#Requires AutoHotkey v2.0

ProcessSetPriority "High"
InstallKeybdHook
TraySetIcon "Shell32.dll", 174

LoadIni()

LoadIni() {
    Apps := Array()
    AppsString := IniRead("grogan.ini")
    Loop Parse, AppsString, "`n"
        Apps.Push A_LoopField ; Create an array of applications
    
    for App in Apps {
        if App != "persistent"
            HotIfWinActive("ahk_exe " App)
        Keylist := IniRead("grogan.ini", App)
        Loop Parse, Keylist, "`n" { ; Loop through all hotkeys.
            delimit := InStr(A_LoopField, "=") ; Find the delimiter between keys and values, because why would there be a way to return all section results with IniRead
            Source := SubStr(A_LoopField, 1, delimit-1) ; Key (to remap)
            Dest := SubStr(A_LoopField, delimit+1) ; Value (to remap to)
            Hotkey(Source, ((Dest, Source) => (SendInput(Dest))).Bind(Dest))
        }
        HotIf()
    }
}

GetKeyPress() {
    InputHookObj := InputHook()

    InputHookObj.KeyOpt('{All}', "ES") ; Stop on first keypress and suppress input
    InputHookObj.KeyOpt('{LCtrl}{LAlt}{LShift}{LWin}', "-ES") ; except left-hand modifiers

    InputHookObj.Start()
    InputHookObj.Wait()
    return {
        Key: Format("sc{:X}", GetKeySC(InputHookObj.EndKey)), ; Use the hex value of the scancode as we use this val in a couple of different formats
        Mods: RegExReplace(InputHookObj.EndMods, "[<>](.)(?:>\1)?", "$1") ; Use 'unsigned' modifiers, rather than left/right
    }
}

GetMacro(FromKey) {
    InputHookObj := InputHook()
    
    InputHookObj.KeyOpt('{All}', "NS") ; Notify on any keypress and suppress input
    InputHookObj.KeyOpt("{" FromKey "}", "IE-N") ; except escape character (NOTE: key up on escape character is still being recorded.
    
    Keypresses := Array()
    InputHookObj.OnKeyDown := ArrayDown
    InputHookObj.OnKeyUp := ArrayUp

    ArrayDown(InputHookObj, VK, SC)
    {
        Keypresses.Push "{" GetKeyName(Format("vk{:x}sc{:x}", VK, SC)) " down}"
    }
    ArrayUp(InputHookObj, VK, SC)
    {
        Keypresses.Push "{" GetKeyName(Format("vk{:x}sc{:x}", VK, SC)) " up}"
    }

    InputHookObj.Start()
    InputHookObj.Wait()

    MacroString := ""
    for Key in Keypresses
        MacroString .= Key
    return MacroString
}

CreateRemap(Macro := false) {
    Process := WinGetProcessName("A")
    SoundPlay A_WinDir "\Media\Speech On.wav"

    Suspend 1
    From := GetKeyPress()
    SoundPlay A_WinDir "\Media\Speech Misrecognition.wav"
    if Macro
        To := GetMacro(From.Key)
    else {
        To := GetKeyPress()
        To := To.Mods "{" GetKeyName(To.Key) "}"
    }
    Suspend 0

    if From

    HotIfWinActive("ahk_exe " Process)
    Hotkey From.Mods GetKeyName(From.Key), (*) => SendInput(To)
    HotIf()

    If Process = "explorer.exe"
        Process := "persistent"
    IniWrite To, "grogan.ini", Process, From.Mods GetKeyName(From.Key)
    TrayTip GetKeyName(From.Key) " is now mapped to " To " (" Process ")"

    SoundPlay A_WinDir "\Media\Speech Sleep.wav"
}

#Esc::CreateRemap()
+#Esc::CreateRemap(true)
;#4::ListHotkeys
#q:: {
    SoundPlay A_WinDir "\Media\Speech Off.wav", 1
    Reload
}