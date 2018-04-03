#SingleInstance force

#Include %A_LineFile%\..\..\IrfanView.ahk

$icon_dir := A_ScriptDir "\icons"

$IrfanView 	:= new IrfanView()


$IrfanView.Icon( $icon_dir "\Single.ico" ).text("Single").create()


$IrfanView.Icon( $icon_dir "\longString.ico" )
			.color("", "blue")
			.text("LARAVEL VENDOR")
			.create()
			

$IrfanView.Icon( $icon_dir "\green.ico" )
			.color("green")
			.text("green icon")
			.create()