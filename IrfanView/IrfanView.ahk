#Include %A_LineFile%\..\Lib\Includes.ahk
/** Class IrfanView
*/
Class IrfanView
{
	_iview_path	:= ""
	_Icon 	:= new Icon().Parent(this)
	
	__New()
	{
		$iViewPath	= %COMMANDER_PATH%\_Utilities\IrfanView\i_view64.exe
		;$iViewPath	= c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe		
		this._iview_path	:= $iViewPath
		
		this._Icon.iViewPath( $iViewPath )
	}
	/**
	 */
	Icon( $path )
	{
		return % this._Icon.clone().path($path)
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
 