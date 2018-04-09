#SingleInstance force

#Include %A_LineFile%\..\..\TcPane.ahk

$TcPane := new TcPane()

;Dump($TcPane.getSourcePaneClass(), "getSourcePaneClass()", 1)
;Dump($TcPane.getTargetPaneClass(), "getTargetPaneClass()", 1)
;
;
;Dump($TcPane.getSourcePath(), "getSourcePane()", 1)

Dump($TcPane.getPath(), "getPath('left')", 1)
Dump($TcPane.getPath("right"),	"getPath('right')", 1)
;
;Dump($TcPane.getPanedHwnd(),	"getPanedHwnd('source')", 1)
;Dump($TcPane.getPanedHwnd("target"),	"getPanedHwnd('target')", 1)
;
;Dump($TcPane.getPaneSide(),	"getPaneSide('source')", 1)
;Dump($TcPane.getPaneSide("target"),	"getPaneSide('target')", 1)