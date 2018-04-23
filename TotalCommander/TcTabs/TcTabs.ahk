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
	
	/** Get tabs from both side, or only one
	 * 
	 * @param	string	$side	"left|right|void" get tabs from both sides if param empty
	 */
	get( $side:="" )
	{
		return % this._TcTabsGetter.getTabs($side)
	}
	/** Load tabs file
	 *		
	 * @param	string	$tab_file_path	path to *.tab file
	 * @param	string	$side	"left|right|void" load tabs to side, load to active if param empty
	 */
	load( $tab_file_path, $side:="" )
	{
		this._TcTabsLoader.load( $tab_file_path, $side )
	}
	
}