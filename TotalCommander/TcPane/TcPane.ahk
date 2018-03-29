#Include %A_LineFile%\..\..\TotalCommander.ahk
/*	Pane
	To get selection call this script in Total commander with parameter %S
*/
Class TcPane extends TotalCommander
{
	_panes :=	{"TOTALCMD.EXE":	{ "TMyListBox2": "TPathPanel1"	; left pane: path
			,"TMyListBox1": "TPathPanel2"}	; right pane: path
		,"TOTALCMD64.EXE":	{"LCLListBox2": "Window9"	; left pane: path
			,"LCLListBox1": "Window14"}}	; right pane: path

	__New()
	{
		this._init()
	}

	/** @return string ClassNN of active pane
	 */
	getSourcePaneClass()
	{
		this._saveActiveWindow()

		WinActivate, % this.hwnd()

		ControlGetFocus, $source_pane, % this.hwnd()

		this._restorePreviousWindow()

		return %$source_pane%
	}
	/** @return string ClassNN of active pane
	 */
	getTargetPaneClass()
	{
		$source_pane	:= this.getSourcePaneClass()
		$process_name	:= this.proccesName()

		if( $process_name == "TOTALCMD.EXE")
			return % $source_pane == "TMyListBox2" ? "TMyListBox1" : "TMyListBox2"
		else
			return % $source_pane == "LCLListBox2" ? "LCLListBox1" : "LCLListBox2"
	}
	/**
	  * @param string pane 'source|target'
	 */
	getPanedHwnd( $pane:="source" )
	{
		$class_nn := $pane == "source" ? this.getSourcePaneClass() : this.getTargetPaneClass()

		ControlGet, $hwnd, Hwnd  ,, %$class_nn%, % this.hwnd()

		return $hwnd
	}
	/** @return string path of active pane
	 */
	getSourcePath()
	{
		$class_nn := this._panes[this.proccesName()][this.getSourcePaneClass()]

		return % this._getPath($class_nn)
	}
	/** @return string path of in active pane
	 */
	getTargetPath()
	{
		$class_nn := this._panes[this.proccesName()][this.getTargetPaneClass()]

		return % this._getPath($class_nn)
	}
	/** refresh pane
	*/
	refresh($pane:="source")
	{
		$dir	:= $pane == "source" ? this.getSourcePath() : this.getTargetPath()
		$process_name	:= this._process_name
		$pane	:= $pane == "source" ? "L" : "R"

		Run, %COMMANDER_PATH%\%$process_name% /O /S /%$pane%=%$dir%
	}
	/**
	 */
	_getPath($class_nn)
	{
		ControlGetText, $path , %$class_nn%, % this.hwnd()

		SplitPath, $path,, $path_dir ; remove mask liek "*.*" from end of path

		return $path_dir
	}




}
