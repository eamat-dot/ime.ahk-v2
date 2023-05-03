#Requires AutoHotkey v2.0

IME_SET(SetSts, WinTitle:="A"){
    hwnd := WinGetID(WinTitle)
    if	(WinActive(WinTitle)){
        ptrSize := !A_PtrSize ? 4 : A_PtrSize
        cbSize:=4+4+(PtrSize*6)+16
        stGTI := Buffer(cbSize, 0)
        NumPut("UInt", cbSize, stGTI, 0)   ;	DWORD   cbSize;
        hwnd := DllCall("GetGUIThreadInfo", "Uint",0, "Uint", stGTI.Ptr)
                 ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
    }

    return DllCall("SendMessage"
          , "UInt", DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",hwnd)
          , "UInt", 0x0283  ;Message : WM_IME_CONTROL
          ,  "Int", 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  "Int", SetSts) ;lParam  : 0 or 1
}
