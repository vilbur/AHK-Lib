#SingleInstance force

#Include %A_LineFile%\..\..\INI.ahk

$INI 	:= new INI()
;$INI.file("\..\test_relative.ini").create()
;$INI.file("test.ini").create()

$INI
.set("section-empty")
.set("section", "empty-key")
.set("section","key","value-A")

.set( {"section-obj":{"key1":"value1", "key2":"value2"}} )
.set( "section-obj-key-value", {"key":"value-B"} )


Dump($INI.get(), "get() all", 1)
Dump($INI.get("section-empty"), "get() section-empty", 1)
Dump($INI.get("section-obj"), "get() section-obj", 1)

Dump($INI.getSections(), "getSections()", 1)
Dump($INI.getKeys("section-obj"), "getKeys(""section-obj"")", 1)
Dump($INI.getValues("section-obj"), "getValues(""section-obj"")", 1)

Dump($INI.length(), "length() of all", 1)
Dump($INI.length("section-obj"), "length(""section-obj"")", 1)

Dump($INI.lists("key"), "lists(""key"") to object"  , 1)
Dump($INI.lists("key", "array"), "lists(""key"", ""array"") to array", 1)

Dump($INI.flattern(), "flattern()"  , 1)

$INI.delete("section-empty")
$INI.delete("section", "empty-key")


Dump($INI, "INI", 1)