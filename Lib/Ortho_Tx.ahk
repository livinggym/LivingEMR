txCharting:
; SOAP
icd_1 := "M26.4"
; icd_2 := "K02.9"

nowS := ""
nowO := ""
nowP := "Arrange orthodontic charting and analysis."

actEMR()
if (A_IsCompiled = 1) {
; Order and drug
waitWin("過敏記錄：")
doOrder("醫囑")
serach_order("83091810")
serach_order("83091054")
serach_order("15014004")
Controlclick, 確認, 開立醫囑
}
doneEMR()
return

txScaling:
; SOAP
icd_1 := "M26.4"
icd_2 := "K03.6"

nowS := "Full mouth bleeding, thermal sensitivity."
nowO := "Full mouth gingiva inflammation with calculus deposition."
nowP := "Active orthodontic Tx.`r`nPeriodontal probing, Full mouth ultrasonic scaling, plaque control program and oral hygiene instructions."

actEMR()
; Order and drug
waitWin("過敏記錄：")
doOrder("醫囑")
serach_order("83091814")
Controlclick, 確認, 開立醫囑
doneEMR()
return

txExt:
nowTx := "Ext"
Gui, ExtGUI: New
Gui, Show, x500 y300 h250 w250, 治療內容 - LivingEMR
Gui, Font, S12 CDefault, Meiryo UI
Gui, Add, Text, x010 y010, 拔牙
Gui, Font, S10
Gui, Add, Button, xp+40 yp-3 center gchooseToothPos vtoothPos1, 牙位
Gui, Font, S12
Gui, Add, Edit, xp+50 yp+1 hp-2 w100 center vtoothPos1e, 
Gui, Add, Text, x010 y060, 骨釘
Gui, Font, S10
Gui, Add, Button, xp+40 yp-3 center gchooseToothPos vtoothPos2, 牙位
Gui, Font, S12
Gui, Add, Edit, xp+50 yp+1 hp-2 w100 center vtoothPos2e, 
Gui, Add, DDL, x050 yp+40 w60 center vscrewType, MIA||A1
Gui, Add, DDL, xp+80 yp w70 center vscrewSize, 2x10||2x8|1.5x8
; Gui, Add, Text, x010 y140, 開藥(未完成)
Gui, Add, Text, x010 y140, 
Gui, Add, Button, xp yp+40 w230 h45 gdoneToothExt, 確認
return

doneToothExt:
Gui, ExtGUI: Submit, Nohide
toothNum1 := StrLen(toothPos1e) // 2
toothNum2 := StrLen(toothPos2e) // 2
if ((toothNum1 + toothNum2) = 0)
  errorMsg("請輸入牙位")
Gui, ExtGUI: Hide

; SOAP
icd_1 := "M26.4"
; icd_2 := "K02.9"

nowS := "Crowded dentition."
nowO := "Malocclusion."
nowP := ""

if (toothNum1 > 0) {
  nowS .= " Asking for extraction."
  nowP .= "Extraction of tooth " . toothPos1e . " with forceps under local anesthesia, post-extraction instructions, medication for pain and infection control. "
  }
if (toothNum2 > 0) {
  nowP .= "Under local anesthesia, insertion " . screwType . " screw, length " . screwSize . ", on tooth " . toothPos2e . "."
  }
  
actEMR()

; 拔牙
waitWin("過敏記錄：")
doOrder("醫囑")
; sleep, 30
serach_order("83091818") ;simple ext
serach_order("83091861") ;screw
Controlclick, 確認, 開立醫囑  
waitWin("過敏記錄：")
; 拔牙牙位
Click 160, 580
if (toothNum1 = 0)
  sendinput, {del}
else {
  click right
  click 220, 635
  click 120, 415
  paste(toothPos1e)
  sendinput, {tab 2}
  paste(toothNum1)
  sleep 30
  click 975, 415
  sleep, 30
  controlclick, 隱藏, 過敏記錄：
  }

; 開藥
doOrder("科常用")
click_med("sort")
click_med("amo")
click_med("down")
click_med("mei")
Controlclick, 確認, 生日：
waitWin("過敏記錄：")
doneEMR()
return





txMonthlydue:
if (A_IsCompiled = 1) {
waitWin("過敏記錄：")
doOrder("醫囑")
serach_order("83091862")
Controlclick, 確認, 開立醫囑
}
return
