/**  
*/
Ditto_On(){
	$ditto_path := Path("%Commander_Path%\_Utilities\Ditto\Ditto.exe").getPath()
	Run, %$ditto_path%
	Windows_TrayRefresh()
}
/**  
*/
Ditto_Off(){
	RunWait, taskkill /im Ditto.exe /f,,hide ;;; kill ditto
}


;Ditto_On()

;exitApp