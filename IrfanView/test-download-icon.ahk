#SingleInstance force

;$path_dir	:= A_ScriptDir "\test"
;$path_gif	:= $path_dir ".gif"
;$path_ico	:= $path_dir ".ico"
;
;;UrlDownloadToFile, https://dummyimage.com/24x24/005bbd/fff.gif&text=T, %$path_gif%
;UrlDownloadToFile, https://dummyimage.com/24x12/005bbd/fff.gif&text=line1, %$path_gif%
;
;
;;Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe " $path_gif " /convert=" $path_ico


$path_dir	:= A_ScriptDir "\line1"

$line1_gif	:= $path_dir "line1.gif"
$line2_gif	:= $path_dir "line2.gif"

$path_ico	:= $path_dir ".ico"

;UrlDownloadToFile, https://dummyimage.com/24x24/005bbd/fff.gif&text=T, %$path_gif%
;UrlDownloadToFile, https://dummyimage.com/24x12/005bbd/fff.gif&text=line1, %$line1_gif%
;UrlDownloadToFile, https://dummyimage.com/24x12/005bbd/fff.gif&text=line2, %$line2_gif%

;UrlDownloadToFile, https://dummyimage.com/24x12/ffffff/000000.gif&text=line1, %$line1_gif%
;UrlDownloadToFile, https://dummyimage.com/24x12/ffffff/000000.gif&text=line2, %$line2_gif%

UrlDownloadToFile, https://dummyimage.com/36x24/ffffff/000000.gif&text=+tc++, %$line1_gif%
UrlDownloadToFile, https://dummyimage.com/36x24/ffffff/000000.gif&text=tools, %$line2_gif%

sleep, 500
;Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe /panorama=(2," $line1_gif "," $line2_gif ")" " /convert=" $path_ico

;Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe " $path_ico " /crop=(3,0,32,32)"

Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe " $line1_gif " /crop=(5,8,24,12) /convert=" $line1_gif
sleep, 200
Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe " $line2_gif " /crop=(5,8,24,12) /convert=" $line2_gif
sleep, 200

Run, % "c:\GoogleDrive\TotalComander\_Utilities\IrfanView\i_view64.exe /panorama=(2," $line1_gif "," $line2_gif ")" " /convert=" $path_ico
