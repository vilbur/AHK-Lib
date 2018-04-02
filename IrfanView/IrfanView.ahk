#Include %A_LineFile%\..\Lib\Parent\Parent.ahk
#Include %A_LineFile%\..\Lib\Icon.ahk
/** Class IrfanView
*/
Class IrfanView
{
	_iview_path	:= ""
	_Icon 	:= new Icon().Parent(this)
	
	__New()
	{
		$iViewPath	= %COMMANDER_PATH%\_Utilities\IrfanView\i_view64.exe
		this._iview_path	:= $iViewPath
		
		this._Icon.iViewPath( $iViewPath )
	}
	/**
	 */
	Icon( $path )
	{
		return % this._Icon.path($path)
	}
	/**
	 */
	crop(  )
	{
		
	}
	/**
	 */
	convert(  )
	{
		
	}	
	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this
	}

	
	
}
 