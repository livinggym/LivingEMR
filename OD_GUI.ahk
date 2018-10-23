txOD:
toothSurface := ["M", "O", "D", "B", "P", "L", "I"]

nowTx := "OD"
Gui, toothGUI: New
; Gui, toothGUI: +AlwaysOnTop
; Gui, toothGUI: +Owner
Gui, Show, x400 y300 h230 w320, 治療內容 - LivingEMR
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

doneToothOD:
chooseToothPos:
clickToothSurface:
return
