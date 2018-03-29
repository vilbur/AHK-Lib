#SingleInstance force

#Include %A_LineFile%\..\..\TcSelection.ahk

/**
  *
  */
Access_via_class()
{

	dump(new TcSelection().get(), "Selection.get() get all", 1)	
	dump(new TcSelection().getFolders(), "Selection.getFolders()", 1)
	dump(new TcSelection().getFiles("(.ahk|.md)$"), "Selection.getFiles('(.ahk|.md)$')", 1)

	dump(new TcSelection().getFocused(), "Selection.getFocused() get focused item", 1)
	dump(new TcSelection().getSelectionOrFocused(), "Selection.getFocused() get selection if exist otherwise focused item", 1)
}



/*
-----------------------------------------------
	RUN TEST
-----------------------------------------------

*/

Access_via_class()
