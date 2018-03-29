#SingleInstance force

#Include %A_LineFile%\..\..\File.ahk

/*
-----------------------------------------------
	TEST FUNCTIONS
-----------------------------------------------
*/
/* !!! MAIN PATH VARIABLE !!!
*/
global $dir_path	:= "%temp%\_AHK_FileTest"

/** CREATE MAIN DIR and SUBDIRS into it
*/
File_createMainDir(){
	File($dir_path)
		.createDir("CreatedDir1")
		.createDir("CreatedDir2")
}
/** CREATE SUBDIR in Dir and move\rename it
*/
File_moveDir(){
	File($dir_path)
		.combine("DirToMove")
		.createDir()
		.createDir("Subdir")
		.move("DirMoved",false)
}
/** CREATE SUBDIR then create SubuSubDirs into SubDir
*/
File_createSubDirs(){
	File($dir_path).combine("Dir1")
		.createDir()
		.copy("Dir1Copy")
		.copy("Dir2\SubDir2")
}
/** CREATE PARENT DIR of path
*/
File_createParentDirOfPath(){
	File($dir_path).combine("ParentDir\ChildDir")
		.createParentDir()
		.createDir()
}
/** COPY DIR !!! TEST DEPENDS ON $ParentDir TEST
*/
File_copyDir(){
	File($dir_path "\ParentDir")
		.createDir()
		.copy("\ParentDirCopy")	; COPY & RENAME	E.G: C:\Dir >> C:\DirCopy
		.copy("\CopyToDir\\")	; COPY TO FOLDER	E.G: C:\Dir >> C:\CopyToDir\Dir
}

/** Create and get new file, then copy it to subdir
*/
File_createAndCopy(){
	File($dir_path "\file.txt")
		.create("content", true )
		.copy("file_copy.txt","bak")	; COPY IN SAME DIRECOTRY
		.copy("\CopyFiles\\")	; COPY TO DIRECTORY
		.copy("\CopyFiles\renamed_copy.txt")	; COPY AND RENAME
}
/** Create and get new file, then copy it to subdirectory
*/
File_hardlink(){
	File($dir_path "\file_for_hardlink.txt")
		.create("content", true )
		.hardlink("\Hardlink\hardlink.txt")
}
/** Create SHORTCUT to file
*/
File_shortcut(){
	File($dir_path "\file_for_shortcut.txt")
		.create("content", true )
		.shortcut("\Shortcuts\\")
		.shortcut("\Shortcuts\shortcut_renamed.lnk")
}
/** Create SHORTCUT to folder
*/
File_folderShortcut(){
	File($dir_path)
		.shortcut("\Shortcuts\\")
		.shortcut("\Shortcuts\folder_shordcut.lnk")
}
/** Copy files by mask
*/
File_copyFilesByMask(){
	File($dir_path "\*.txt" )
		.copy("\_AHK_FilesTxt\*.txt")
}

/** copyAllByMask
*/
File_copyAllByMask(){
	File($dir_path "\*.*" )
		.copy("\..\_AHK_FilesAll")
}
/** Create and get new file, then move\rename it
*/
File_moveFile(){
	File($dir_path)
		.combine("file_to_move.txt")
		.create("content")
		.move("file_moved.txt")
}
/** Create hardlink
*/
File_hardlinkToFolder(){
	File("%ProgramFiles%")
		.hardlink($dir_path "\ProgramFiles")
}


/*
-----------------------------------------------
	RUN TEST
-----------------------------------------------
*/
;File_createMainDir()
;File_moveDir()
;File_createSubDirs()
;File_createParentDirOfPath()
;File_copyDir()
;File_createAndCopy()
;File_hardlink()
;File_shortcut()
;File_folderShortcut()
;File_copyFilesByMask()
;File_copyAllByMask()
;File_moveFile()
;File_hardlinkToFolder()
