#SingleInstance force

#Include %A_LineFile%\..\..\TcPane.ahk

$TcPane := new TcPane()

Dump($TcPane.getSourcePaneClass(), "getSourcePaneClass()", 1)
Dump($TcPane.getTargetPaneClass(), "getTargetPaneClass()", 1)


Dump($TcPane.getSourcePath(), "getSourcePane()", 1)
Dump($TcPane.getTargetPath(), "getTargetPath()", 1)

Dump($TcPane.getPanedHwnd(),	"getPanedHwnd('source')", 1)
Dump($TcPane.getPanedHwnd("target"),	"getPanedHwnd('target')", 1)

Dump($TcPane.getPanedSide(),	"getPanedSide('source')", 1)
Dump($TcPane.getPanedSide("target"),	"getPanedSide('target')", 1)