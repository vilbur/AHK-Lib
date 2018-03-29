#SingleInstance force


  


$array	:= ["DUMP TEST 1", "item2"]
;$object := {	"key":"value"	
;	,"key2":"value2"		
;	,"key3":"value4" }
;
$object	:= {"nested object":{"nested KEY":"nested VALUE"}}


$object := {	"key":"value"
	,"integer wery www": 9
	,"nested object":{"nested KEY":"nested VALUE"}	
	,"multi nested":{"nested KEY":{"multi KEY":"multi VALUE"}}}
	
	
	
$object2 := {	"key":"value"	
	,"integer": 9
	,"integer long": 9
	,"iiiii": 9
	,"Array": $array 		
	,"XXXXX": 9
			,"nested object":{"nested KEY":"nested VALUE"}	
			,"multi nested":{"foo key":"foo value","nested KEY":{"multi KEY":"multi VALUE"}}
			;,["arrayitem_1","arrayitem_2"]
			,"array":["arrayitem_1","arrayitem_2"] }

	
Dump(	$array, "array" ,1)
Dump(	$object2, "object2",1 )
Dump(	 "TEST" )
Dump(	9999999 )

 
  
  