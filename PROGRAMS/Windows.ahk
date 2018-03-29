#SingleInstance force


/** Refresh system tray icons
	Requires utility 'SystemTrayRefresh' source: http://visualfantasy.tk/
  */
Windows_TrayRefresh(){
	Run, %Commander_Path%\_Utilities\SystemTrayRefresh\SystemTrayRefresh.exe,,min
}

