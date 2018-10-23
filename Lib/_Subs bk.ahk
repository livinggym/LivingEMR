toothOD:
Gui, toothODGUI: New
Gui, toothODGUI: +AlwaysOnTop
; Gui, toothODGUI: +Owner
Gui, Show, x400 y300 h300 w320, 治療內容 - LivingEMR
Gui, Font, S12 CDefault, Meiryo UI

loop, 4 {
  nowTooth := A_Index
  nowDisp := "#" . nowTooth
  nowVar1 := "toothPos" . nowTooth
  nowVar2 := "toothPos" . nowTooth . "e"
  nowVar3 := "toothSurface" . nowTooth
  nowVar := "toothTx" . nowTooth
  nowY := 40 * nowTooth -32
  Gui, Add, Text, x008 y%nowY%, %nowDisp%
  Gui, Add, Edit, x090 yp-3 w70 center v%nowVar2%, 
  Gui, Font, S10
  Gui, Add, Button, x040 yp-1 hp+2 center gchooseToothPos v%nowVar1%, 牙位
  Gui, Font, S12
  Gui, Add, DDL, x170 yp+1 w80 v%nowVar%, %DeptTxOD%
  Gui, Add, Text, x270 yp+3 w40 v%nowVar3% gchooseToothSurface, 牙面
  }
Gui, Add, Button, x008 y250 w040 gdonetooth, Confirm
return



clickToothSurface:
clickToothPos:
if (is%A_GuiControl% = "") or (is%A_GuiControl% = 0){
  is%A_GuiControl% := 1
  Gui, Font, cRed 
  GuiControl, Font, %A_GuiControl%
  }
else {
  is%A_GuiControl% := ""
  Gui, Font, cBlack
  GuiControl, Font, %A_GuiControl%
  }
return	



donetooth:

; msgbox %aaa%
Gui, toothODGUI: Submit, Nohide
loop, 4 {
  nowToothNum := A_Index
  ; 判斷顆數
  toothNum%A_Index% := StrLen(toothPos%A_Index%e) // 2
  ; if (toothNum%nowToothNum% = 0)
    ; continue
  ; 判斷面數
  toothSurfaceNum%A_Index% := StrLen(toothSurface%A_Index%)
  ; 未輸入牙面
  if (toothNum%A_Index% > 0) and (toothSurfaceNum%A_Index% = 0) and ((toothTx%A_Index% = "CRF") or (toothTx%A_Index% = "AMF"))
	errorMsg("未輸入牙面")

  ; 判斷前後
  if (SubStr(toothPos%A_Index%e, 2, 1) > 3)
    isAnt%A_Index% := "Post"
  else
    isAnt%A_Index% := "Ant"
  ; 判斷治療
  if (toothTx%A_Index% = "CRF") {
    if (isAnt%A_Index% = "Post")
  	  toothCode%A_Index% := payCode["PostCRF" . toothSurfaceNum%A_Index%]
    else
  	  toothCode%A_Index% := payCode["AntCRF" . toothSurfaceNum%A_Index%]
	}
  else if (toothTx%A_Index% = "AMF") {
    if (isAnt%A_Index% = "Post")
  	  toothCode%A_Index% := payCode["PostAMF" . toothSurfaceNum%A_Index%]
    else
  	  toothCode%A_Index% := payCode["PostAMF" . toothSurfaceNum%A_Index%]
	}
  else if (toothTx%A_Index% = "SC")
    toothCode%A_Index% := 83091814
  else if (toothTx%A_Index% = "GIF")
    toothCode%A_Index% := "GIF"
  else if (toothTx%A_Index% = "IRM")
    toothCode%A_Index% := "IRM"
  ; 跳過空白
  if (toothTx%A_Index% != "SC") and (toothNum%A_Index% = 0) 
    toothCode%A_Index% := ""
  }
; toothPos1_1 := SubStr(toothPos1e, 1, 2)
; if (SubStr(toothPos1_1, 2, 2) > 3) ;後牙
  ; msgbox, %toothPos1_1%後牙
; else
  ; msgbox, %toothPos1_1%前牙
  
; msgbox, %toothNum1% %toothNum2% %toothNum3%
msgbox, %toothCode1%, %toothCode2%, %toothCode3%, %toothCode4%
; msgbox, %toothPos1e%: %toothSurface1%    %toothPos2e%: %toothSurface2%    %toothPos3e%: %toothSurface3%    %toothPos4e%: %toothSurface4%
; gosub, txOD
return


chooseToothSurface:
sendBackGUI := A_Gui
nowToothNum := numOnly(A_GuiControl)
nowToothSurface := ""
CoordMode, Mouse, Screen
MouseGetPos, nowX, nowY
nowX += 25
nowY -= 5
Gui, toothSurfaceGUI: New 
Gui, toothSurfaceGUI: +AlwaysOnTop -Caption
Gui, Color, FFFFFF
Gui, Show, x%nowX% y%nowY% h065 w145, 選擇牙面
Gui, Font, S11 CDefault, Meiryo UI
loop, 7 {
  nowDisp := toothSurface[A_Index]
  nowVar := "toothSurface" . nowToothNum . nowDisp
  is%nowVar% := ""
  if (A_Index = 1)
    Gui, Add, Text, x005 y005 w20 v%nowVar% gclickToothSurface, %nowDisp%
  else
    Gui, Add, Text, xp+20 yp wp v%nowVar% gclickToothSurface, %nowDisp%
  }
Gui, Add, Button, x005 y030 w130 gdoneToothSurface, 確認牙面
return



doneToothSurface:
Gui, toothSurfaceGUI: Submit
nowToothSurface := ""
sendBackVar := "toothSurface" . nowToothNum
loop, 7 {
  nowVar := "toothSurface" . nowToothNum . toothSurface[A_Index]
  isVar := is%nowVar%
  if (isVar = 1)
    nowToothSurface .= toothSurface[A_Index]
  }
GuiControl, %sendBackGUI%: Text, %sendBackVar%, %nowToothSurface%
%sendBackVar% := nowToothSurface
if (nowToothSurface = "")
  nowToothSurface := "牙面"
return



chooseToothPos:
CoordMode, Mouse, Screen
MouseGetPos, nowX, nowY
nowX += 25
nowY -= 15
nowToothPos := ""
sendBackGUI := A_Gui
sendBackVar := A_GuiControl
Gui, toothPosGUI: New
Gui, toothPosGUI: +AlwaysOnTop
; Gui, toothPosGUI: +OwnerchooseToothPosold
Gui, Show, x%nowX% y%nowY% h190 w450, 選擇牙位
Gui, Font, S11 CDefault, Meiryo UI
loop, 34 {
  if (A_Index = 9) or (A_Index = 26)
    continue
  nowX := A_Index * 25 - 15 - 425*Floor(A_Index/18)
  nowY := Floor(A_Index/18)*35 + 10
  nowVar := toothPos[A_Index]
  Gui Add, Text, x%nowX% y%nowY% w25 h25 gclickToothPos center +Border, %nowVar%
  is%nowVar% := ""
  }
Gui Add, Text, x010 y080 h25 cBlue, 一次最多選擇 3 顆牙
; Gui Add, Text, x010 y080 w50 h25 center +Border gclickToothPos, UR
; Gui Add, Text, x060 y080 w50 h25 center +Border gclickToothPos, UL
; Gui Add, Text, x110 y080 w50 h25 center +Border gclickToothPos, LR
; Gui Add, Text, x160 y080 w50 h25 center +Border gclickToothPos, LL
; Gui Add, Text, x235 y080 w50 h25 center +Border gclickToothPos, FM
; Gui Add, Text, x285 y080 w50 h25 center +Border gclickToothPos, 99
Gui Add, Button, x010 y120 w425 h040 gdoneToothPos, Done
return



doneToothPos:
nowToothPos := ""
loop, 34 {
  nowVar := toothPos[A_Index]
  isVar :=is%nowVar%
  if (isVar = 1)
    nowToothPos .= nowVar
  }
if (StrLen(nowToothPos) > 6) {
  msgbox, 一次最多選擇3顆牙，請重新選擇
  exit
  }
Gui, toothPosGUI: Submit
GuiControl, %sendBackGUI%: Text, %sendBackVar%e, %nowToothPos%
return



nullFunc:
return



exit_app:
exitapp
return



aboutEMR:
If (new_ver = 0)
  new_ver := "[無法取得最新版本]"
msgbox, 4160, LivingEMR, 目前版本：%ver%`r`n最新版本：%new_ver%`r`n作者：LivingGym`r`n信箱：livinggym@gmail.com
return



;to-be-renewed
do_login:
#SingleInstance force
; find dr no.
if (A_GuiControl = "")
  exit
loop, 9 {
  now_dp := doc_%A_Index%_dp
  if (now_dp = A_GuiControl) {
	doc_no := A_Index
	break
	}
  }
now_id := doc_%doc_no%_id
now_pw := doc_%doc_no%_pw
now_ch := doc_%doc_no%_ch
now_dp := doc_%doc_no%_dp
IfWinExist, 台北榮民總醫院門診系統, 醫事卡認證
  {
  Winactivate 台北榮民總醫院門診系統
  Controlclick, x340 y107, 台北榮民總醫院門診系統
  sleep, 50
  paste(now_id)
  sleep, 50
  paste(now_pw, "t")
  sleep, 50
  Sendinput, {tab}
  paste(now_ch, "e")
  Exit
  }
  
If !WinExist("換科登入") and !WinExist("台北榮民總醫院門診系統")
  error_msg("請先開啟病患清單畫面")
IfWinExist, 換科登入
  WinActivate 換科登入
Else IfWinExist, 台北榮民總醫院門診系統
  {
  WinActivate 台北榮民總醫院門診系統
  Controlclick, x80 y45, 台北榮民總醫院門診系統 ; 輔助功能
  Sleep 100
  Click, 80, 115 ; 換科登入
  }
waitWin("換科登入")
Controlclick, x200 y140, 換科登入 ; 第二格
Send, +{tab}
Sleep, 30
old_clip := Clipboard
paste(now_id, "t")
paste(now_pw, "t")
paste(now_ke, "t")
paste(now_ch)
Sleep, 30
If (now_pw != "") and (now_id != "") and (chair_in != "")
  Controlclick, 登入, 換科登入
Clipboard := old_clip
BlockInput, Default
Return
