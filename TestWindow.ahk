#Persistent
#SingleInstance force
SOAP:
Gui, PtList: Destroy
Gui, SOAP: Destroy
Gui, PtList: New
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x300 y150 w1017 h730, 12345678 王小名 先生 56歲 (2010/1/5) 一般健保 A123456789 BSA：0 BMI：0 過敏記錄：無
Gui, Add, Picture, x000 y000, %A_ScriptDir%\Res\soap.jpg
Gui, Add, Edit  , x038 y030 w468 h158, 
Gui, Add, Edit  , x546 y030 w468 h158, 
Gui, Add, Edit  , x546 y220 w468 h124, 
Gui, Add, Edit  , x068 y230 w076 h024, 
Gui, Add, Edit  , x068 y260 w076 h024, 
Gui, Add, Button, x003 y681 w175 h045 gPtList, 回首頁
Gui, Add, Button, x839 y681 w175 h045 greload, Reload
return

PtList:
Gui, PtList: Destroy
Gui, SOAP: Destroy
Gui, PtList: New
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x300 y150 w1016 h732, 台北榮民總醫院門診系統【S721】【版本：P1.5.0.1】
Gui, Add, Picture, x000 y000, %A_ScriptDir%\Res\ptList.jpg
Gui, Add, Button, x130 y559 w097 h057 gSOAP, 確認
Gui, Add, Button, x839 y681 w175 h045 greload, Reload
return

PtListGuiClose:
Gui, PtList: Destroy
return

SOAPGuiClose:
; SOAPGuiEscape:
Gui, SOAP: Destroy
return

f02:
Gui, f02: New
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x100 y200 h100 w100, 換科登入
return

f02GuiClose:
Gui, f02: Destroy
return

reload:
reload
return
