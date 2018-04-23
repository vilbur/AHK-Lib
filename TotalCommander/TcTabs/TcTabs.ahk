#Include %A_LineFile%\..\includes.ahk
#Include %A_LineFile%\..\TcTabsGetter\TcTabsGetter.ahk
#Include %A_LineFile%\..\TcTabsLoader\TcTabsLoader.ahk
/** TcTabs
 *
 */
Class TcTabs
{
	_TcTabsGetter 	:= new TcTabsGetter()
	_TcTabsLoader 	:= new TcTabsLoader()
	

}