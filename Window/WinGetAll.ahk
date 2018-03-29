/** https://autohotkey.com/board/topic/30323-wingetall-get-all-windows-titleclasspidprocess-name/
  
	WinGetAll()	- Return Window Titles from all windows
	WinGetAll("Title")	- Same as above
	WinGetAll("Class")	- Return Window Classes from all windows
	WinGetAll("Hwnd")	- Return Window Handles (Unique ID) from all windows
	WinGetAll("Process")	- Return Process Names from all windows
	WinGetAll("PID")	- Return Process Identifier from all windows
	WinGetAll("ANY parameter of above", "On"/0/Whatever than blank) - Include hidden windows
  */
WinGetAll(Which="Title", DetectHidden="Off"){
	O_DHW := A_DetectHiddenWindows, O_BL := A_BatchLines ;Save original states
	DetectHiddenWindows, % (DetectHidden != "off" && DetectHidden) ? "on" : "off"
	SetBatchLines, -1
		WinGet, all, list ;get all hwnd
		If (Which="Title") ;return Window Titles
		{
			Loop, %all%
			{
				WinGetTitle, WTitle, % "ahk_id " all%A_Index%
				If WTitle ;Prevent to get blank titles
					Output .= WTitle "`n"        
			}
		}
		Else If (Which="Process") ;return Process Names
		{
			Loop, %all%
			{
				WinGet, PName, ProcessName, % "ahk_id " all%A_Index%
				Output .= PName "`n"
			}
		}
		Else If (Which="Class") ;return Window Classes
		{
			Loop, %all%
			{
				WinGetClass, WClass, % "ahk_id " all%A_Index%
				Output .= WClass "`n"
			}
		}
		Else If (Which="hwnd") ;return Window Handles (Unique ID)
		{
			Loop, %all%
				Output .= all%A_Index% "`n"
		}
		Else If (Which="PID") ;return Process Identifiers
		{
			Loop, %all%
			{
				WinGet, PID, PID, % "ahk_id " all%A_Index%
				Output .= PID "`n"        
			}
			Sort, Output, U N ;numeric order and remove duplicates
		}
	DetectHiddenWindows, %O_DHW% ;back to original state
	SetBatchLines, %O_BL% ;back to original state
		Sort, Output, U ;remove duplicates
		Return Output
}

;dump(WinGetAll("Process") , "WinGetAll('Process') ", 0)