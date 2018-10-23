txOD:
nowTx := "OD"
Gui, toothGUI: New
; Gui, toothGUI: +AlwaysOnTop
; Gui, toothGUI: +Owner
Gui, Show, x700 y300 h230 w320, 治療內容 - LivingEMR
Gui, Font, S12 CDefault, Meiryo UI

loop, 4 {
  nowTooth := A_Index
  nowDisp := "#" . nowTooth
  nowVar1 := "toothPos" . nowTooth
  nowVar2 := "toothPos" . nowTooth . "e"
  nowVar3 := "toothSurface" . nowTooth
  nowVar := "toothTx" . nowTooth
  nowY := 40 * nowTooth -27
  Gui, Add, Text, x008 y%nowY%, %nowDisp%
  Gui, Add, Edit, x090 yp-3 w70 center v%nowVar2%, 
  Gui, Font, S10
  Gui, Add, Button, x040 yp-1 hp+2 center gchooseToothPos v%nowVar1%, 牙位
  Gui, Font, S12
  loop, 7 {
	nowDisp := toothSurface[A_Index]
	nowVar := "toothSurface_" . nowTooth . "_" . nowDisp
	is%nowVar% := ""
	if (A_Index = 1)
	  Gui, Add, Text, x170 yp+3 w20 v%nowVar% gclickToothSurface, %nowDisp%
	else
	  Gui, Add, Text, xp+20 yp wp v%nowVar% gclickToothSurface, %nowDisp%
	}
  }
Gui, Add, Button, x008 yp+40 w300 h45 gdoneToothOD, 確認
return



txOD2:
; SOAP
icd_1 := "M26.4"
icd_2 := "K02.52"

toothCaries := toothPos1e . "(" . toothSurface1 . ") "
if (toothPos2e != "")
  toothCaries .= toothPos2e . "(" . toothSurface2 . ") "
if (toothPos3e != "")
  toothCaries .= toothPos3e . "(" . toothSurface3 . ") "
if (toothPos4e != "")
  toothCaries .= toothPos4e . "(" . toothSurface4 . ") "
  
nowS := "Ask for dental check-up, thermal sensitivity.`r`nC.C.: Malalignment."
nowO := "Caries over tooth " . toothCaries 
nowP := "Remove " . toothCaries . "caries, cavity preparation, composite resin filling."

actEMR()

; Order and drug
doOrder("醫囑")
loop, 4 {
  nowVar1 := toothNum%A_Index%
  nowVar2 := toothCode%A_Index%
  if (nowVar1 > 0)
    serach_order(nowVar2)
  }
Controlclick, 確認, 開立醫囑  

loop, 4 {
  nowVar1 := toothNum%A_Index%
  nowVar2 := toothPos%A_Index%e
  if (nowVar1 > 0)
    editOrder(A_Index, nowVar2, nowVar1)
  sleep 30
  }
  
doneEMR()
return



doneToothOD:
Gui, toothGUI: Submit, Nohide
loop, 4 {
  nowToothNum := A_Index
  ToothSurface%A_Index% := ""
  loop, 7 {
    nowDisp := toothSurface[A_Index]
    if (istoothSurface_%nowToothNum%_%nowDisp% = 1)
      toothSurface%nowToothNum% .= nowDisp
  }
  ; 判斷顆數
  toothNum%A_Index% := StrLen(toothPos%A_Index%e) // 2
  ; 判斷面數
  toothSurfaceNum%A_Index% := StrLen(toothSurface%A_Index%)
  ; 未輸入牙面
  if (toothNum%A_Index% > 0) and (toothSurfaceNum%A_Index% = 0)
	errorMsg("請輸入牙面")
  ; 判斷前後
  if (SubStr(toothPos%A_Index%e, 2, 1) > 3)
    isAnt%A_Index% := "Post"
  else
    isAnt%A_Index% := "Ant"
  ; 判斷治療
  if (isAnt%A_Index% = "Post")
	toothCode%A_Index% := payCode["PostCRF" . toothSurfaceNum%A_Index%]
  else
	toothCode%A_Index% := payCode["AntCRF" . toothSurfaceNum%A_Index%]
}
if ((toothNum1 + toothNum2 + toothNum3 + toothNum4) = 0)
  errorMsg("請輸入牙位")
; msgbox, 
; (
; [1] 牙位%toothPos1e% 牙面%toothSurface1% 數量 %toothNum1% 代碼%toothCode1% 
; [2] 牙位%toothPos2e% 牙面%toothSurface2% 數量 %toothNum2% 代碼%toothCode2% 
; [3] 牙位%toothPos3e% 牙面%toothSurface3% 數量 %toothNum3% 代碼%toothCode3% 
; [4] 牙位%toothPos4e% 牙面%toothSurface4% 數量 %toothNum4% 代碼%toothCode4% 
; )
Gui, toothGUI: Hide
gosub, txOD2
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



chooseToothPos:
CoordMode, Mouse, Screen
MouseGetPos, nowX, nowY
nowX -= 225
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
if (nowTx = "OD")
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
if (StrLen(nowToothPos) > 6) and (nowTx = "OD"){
  msgbox, 一次最多選擇3顆牙，請重新選擇
  exit
  }
  Gui, toothPosGUI: Submit
if (nowTx = "OD")
  GuiControl, %sendBackGUI%: Text, %sendBackVar%e, %nowToothPos%
else if (nowTx = "Ext")
  GuiControl, %sendBackGUI%: Text, %sendBackVar%e, %nowToothPos%
return
