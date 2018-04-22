#SingleInstance force

#Include %A_LineFile%\..\..\TcPane.ahk

$TcPane := new TcPane()

;sleep, 2000

;$TcPane._getSourcePaneClass()


Dump($TcPane._getSourcePaneClass(), "_getSourcePaneClass()", 1)
Dump($TcPane._getTargetPaneClass(), "_getTargetPaneClass()", 1)


;Dump($TcPane.getSourcePath(), "getSourcePath()", 1)
;Dump($TcPane.getTargetPath(), "getTargetPath()", 1)

;Dump($TcPane.getPath(), "getPath('left')", 1)
;Dump($TcPane.getPath("right"),	"getPath('right')", 1)
;
;Dump($TcPane.getPanedHwnd(),	"getPanedHwnd('source')", 1)
;Dump($TcPane.getPanedHwnd("target"),	"getPanedHwnd('target')", 1)
;
;Dump($TcPane.getPane(),	"getPane('source')", 1)
;Dump($TcPane.getPane("target"),	"getPane('target')", 1)

;Dump($TcPane.activePane() , "activePane", 1)
;
;
;sleep, 2000
;$TcPane.activePane("right")
;sleep, 2000
;$TcPane.activePane("left")