#SingleInstance force

#Include %A_LineFile%\..\..\TcPane.ahk


global $TcPane := new TcPane()

/* Get ClassNN of pane
*/
getClassTest()
{
	Dump($TcPane._getPaneClass("source"), "_getPaneClass('source')", 1)
	Dump($TcPane._getPaneClass("target"), "_getPaneClass('target')", 1)
	
	Dump($TcPane._getPaneClass("left"), "_getPaneClass('left')", 1)
	Dump($TcPane._getPaneClass("right"), "_getPaneClass('right')", 1)
}

/* Get path of current pane
*/
getPathTest()
{
	Dump($TcPane.getPath("source"), "getPath('source')", 1)
	Dump($TcPane.getPath("target"), "getPath('target')", 1)
	
	Dump($TcPane.getPath("left"), "getPath('left')", 1)
	Dump($TcPane.getPath("right"), "getPath('right')", 1)
}

/* Active pane
*/
/**
 */
activatePaneTest()
{
	sleep, 1000
	$TcPane.activePane("right")
	
	sleep, 1000
	$TcPane.activePane("left")
	
	sleep, 1000
	$TcPane.activePane("right")
	
	sleep, 1000
	$TcPane.activePane("target")
}

/**
	1) create test file in target pane
	2) refresh target pane 	
	3) delete test file
 */
refreshPaneTest()
{
	$test_file := $TcPane.getPath("target") "\test.txt"
	FileAppend, "", %$test_file% 
	
	$TcPane.refresh("target")
	
	sleep, 1000
	FileDelete, %$test_file%
	
	$TcPane.refresh("target")
}

getClassTest()
getPathTest()
activatePaneTest()
refreshPaneTest()
