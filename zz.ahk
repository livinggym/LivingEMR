#Persistent
#SingleInstance force
#WinActivateForce
SetTitleMatchMode, 2
SetControlDelay -1

return

F1::
doLogin("DOC1234A","112", "", 12)
return


F5::
reload
return

doLogin(_id, _pw:="", _dept:="", _room:="") {
If !WinExist("換科登入") and !WinExist("台北榮民總醫院門診系統")
  errorMsg("請先開啟病患清單畫面")
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
Sendinput, +{tab}
; sleep, 30
; Sendinput, ^a
Sleep, 30
paste(_id, "tab")
paste(_pw, "tab")
paste(_dept, "tab")
paste(_room)
; Sleep, 30
; If (now_pw != "") and (now_id != "") and (chair_in != "")
  ; Controlclick, 登入, 換科登入
; Clipboard := old_clip
; BlockInput, Default

  ; checkTest()

; IfWinExist, 台北榮民總醫院門診系統, 醫事卡認證
  ; {
  ; Winactivate 台北榮民總醫院門診系統
  ; Controlclick, x340 y107, 台北榮民總醫院門診系統
  ; sleep, 50
  ; paste(_id)
  ; sleep, 50
  ; paste(now_pw, "t")
  ; sleep, 50
  ; Sendinput, {tab}
  ; paste(now_ch, "e")
  ; Exit
  ; }
    ; Exit
  }





editOrder(_no,_pos,_num) {
  ; if (_no = 1) {
    ; waitWin("過敏記錄：")
	; sleep, 30
	; Click 160, 580
	; click right
	; click 220, 635
	; click 120, 415
	; paste(_pos)
	; sendinput, {tab 2}
	; paste(_num)
	; sleep 30
	; click 975, 415
	; sleep, 30
	; controlclick, 隱藏, 過敏記錄：
	; }
  ; else if (_no = 2){
    ; waitWin("過敏記錄：")
	; sleep, 30
	; Click 160, 605
	; click right
	; click 220, 660
	; click 120, 415
	; paste(_pos)
	; sendinput, {tab 2}
	; paste(_num)
	; sleep 30
	; click 975, 415
	; sleep, 30
	; controlclick, 隱藏, 過敏記錄：
	; }
  
  waitWin("過敏記錄：")
  nowY1 := _no * 25 + 555
  nowY2 := nowY1 + 55
  Click 160, %nowY1%
  Click right
  sleep, 30
  click 220, %nowY2%
  sleep, 30
  click 120, 415
  paste(_pos)
  sendinput, {tab 2}
  paste(_num)
  sleep, 30
  click 975, 415
  sleep, 30
  controlclick, 隱藏, 過敏記錄：
  }
  
  
toothPos := [18,17,16,15,14,13,12,11,00,21,22,23,24,25,26,27,28,48,47,46,45,44,43,42,41,00,31,32,33,34,35,36,37,38]
CRFAntNum := ["前牙1面", "前牙2面", "前牙3面"]
CRFPostNum := ["後牙1面", "後牙2面", "後牙3面"]
toothSurface := ["M", "O", "D", "B", "P", "L", "I"]
DeptTxOD := "CRF||AMF|GIF|IRM|SC"
TxOSs := "Ext||S.Ext|Bur|Chisel|I&D|AVP"
payCode := Object("AntCRF1", 83091816, "AntCRF2", 83091822, "AntCRF3", 83091850, "PostCRF1", 83091817, "PostCRF2", 83091823, "PostCRF3", 83091851, "AntAMF1", 83090000, "AntAMF2", 83090000, "AntAMF3", 83090000, "PostAMF1", 83090000, "PostAMF2", 83090000, "PostAMF3", 83090000)


actEMR() {
  waitWin("過敏記錄：", "請先開啟 SOAP 畫面")
  ; checkTest()
  old_clip := clipboard
  BlockInput, SendAndMouse
  Controlclick, x485 y205, 過敏記錄 ;S of SOAP
  Sleep, 50
  global nowS, nowO, nowP
  send, {end}
  paste_tab(nowS)
  paste_tab(nowO)
  paste_tab(nowP)
  sendICD()
  Sleep, 50
  waitWin("過敏記錄：")
  if !WinExist("ahk_exe Vghtpe.Dcr.Win.exe")
    errorMsg("done")
  }

doneEMR() {
  MsgBox, 64, LivingEMR, 完成, 0.5
  clipboard := old_clip
  BlockInput, Default
  }

sendICD() {
  icds := ""
  loop, 2 {
    Controlclick, x140 y269 ;ICD-1
    if (icd_%A_Index% = "")
  	continue
    icd_%A_Index%s := SubStr(icd_%A_Index%, 1, 1) . "{Numpad" . SubStr(icd_%A_Index%, 2, 1) . "}{Numpad" . SubStr(icd_%A_Index%, 3, 1) . "}{NumpadDot}{Numpad" . SubStr(icd_%A_Index%, 5, 1) . "}"
    if (StrLen(icd_%A_Index%) > 5)
  	icd_%A_Index%s .= "{Numpad" . SubStr(icd_%A_Index%, 6, 1) . "}"
    icds .= icd_%A_Index%s . "{tab}"
    }
    ; sleep, 	1000
	Sendinput, {home}{del}{del}{del}{del}{del}{del}
    ; sleep, 1000
    Sendinput, %icds%
  }



doOrder(_option) {
  SetTitleMatchMode, 2
  If (_option = "組套") {
	Controlclick, x375 y42, 過敏記錄
	waitWin("組套")
	}
  Else if (_option = "科常用") {
	Controlclick, x315 y42, 過敏記錄
	waitWin("生日：")
	Controlclick, x570 y77, 生日
	}
  Else if (_option = "醫囑") {
	Winactivate 過敏記錄
	Sendinput, {alt}{right 3}{enter}{enter}
	waitWin("開立醫囑")
	}
  }  

order_go(option) {
  SetTitleMatchMode, 2
  If (option = "組套") {
	Controlclick, x375 y42, 過敏記錄
	waitWin("組套")
	}
  Else if (option = "科常用") {
	Controlclick, x315 y42, 過敏記錄
	waitWin("生日：")
	click_tx("sort")
	}
  Else if (option = "醫囑") {
    Winactivate 過敏記錄
	Sendinput, {alt}{right 3}{enter}{enter}
	waitWin("開立醫囑")
	}
}
  
  
click_tx(tx) {
  SetTitleMatchMode, 2
  Winactivate, 生日：
  SetControlDelay -1
  If (tx = "sort")
	Controlclick, x570 y77, 生日
  Else if (tx = "down")
	Controlclick, x1000 y360, 生日
  Else if (tx = "a1c")
    Controlclick, x680 y100, 生日
  Else if (tx = "p1c")
    Controlclick, x680 y125, 生日
  Else if (tx = "a2c")
    Controlclick, x680 y150, 生日
  Else if (tx = "p2c")
    Controlclick, x680 y175, 生日
  Else if (tx = "a3c")
    Controlclick, x680 y200, 生日
  Else if (tx = "p3c")
    Controlclick, x680 y225, 生日
  Else if (tx = "af1")
    Controlclick, x680 y245, 生日
  Else if (tx = "af2")
    Controlclick, x680 y275, 生日
  Else if (tx = "af3")
    Controlclick, x680 y300, 生日
  Else if (tx = "IRM")
	Controlclick, x680 y365, 生日
  Else if (tx = "ext")
	Controlclick, x680 y510, 生日
  Else if (tx = "ok")
	Controlclick, 確認, 生日
; =================================
  Else if (tx = "rounding")
    Controlclick, x680 y100, 生日
  Sleep, 10
}


click_med(_med) {
  SetTitleMatchMode, 2
  Winactivate, 生日：
  SetControlDelay -1
  If (_med = "sort")
	Controlclick, x135 y77, 生日
  Else if (_med = "down")
	Controlclick, x495 y600, 生日
  Else if (_med = "amo")
	Controlclick, x135 y125, 生日
  Else if (_med = "cli")
	Controlclick, x135 y390, 生日
  Else if (_med = "vor")
	Controlclick, x135 y627, 生日
  Else if (_med = "sca")
	Controlclick, x135 y485, 生日
  Else if (_med = "mei")
	Controlclick, x135 y215, 生日
  Sleep, 10
}

click_op(op) {
  SetTitleMatchMode, 2
  Winactivate, 過敏記錄
  SetControlDelay -1
  If (op = "loc")
	Controlclick, x120 y415, 過敏記錄
  Else if (op = "op1")
	Controlclick, x160 y580, 過敏記錄
  Else if (op = "op2")
	Controlclick, x160 y605, 過敏記錄
  Else if (op = "op3")
	Controlclick, x160 y630, 過敏記錄
  Else if (op = "op4")
	Controlclick, x160 y655, 過敏記錄
  Else if (op = "op5")
	Controlclick, x160 y680, 過敏記錄
  Else if (op = "ed1")
	Controlclick, x220 y635, 過敏記錄
  Else if (op = "ed2")
	Controlclick, x220 y660, 過敏記錄
  Else if (op = "ed3")
	Controlclick, x220 y685, 過敏記錄
  Else if (op = "ed4")
	Controlclick, x220 y710, 過敏記錄
  Else if (op = "ed5")
	Controlclick, x220 y735, 過敏記錄
  Else if (op = "hide")
	Controlclick, 隱藏, 過敏記錄
  Else if (op = "edit")
	Controlclick, x975 y415, 過敏記錄
  Else if (op = "s")
	Controlclick, x485 y205, 過敏記錄
  Else if (op = "icd10")
	ControlClick, x95 y270, 過敏記錄
}

serach_order(code){
  SetTitleMatchMode, 2
  Controlclick, 醫囑搜尋, 開立醫囑
  waitWin("醫囑搜尋功能")
  sleep, 30
  paste(code)
  sleep, 30
  SetTitleMatchMode, 1
  Controlclick, x149 y98, 醫囑搜尋功能 ; 收費代碼
  Controlclick, 搜尋, 醫囑搜尋功能
  click 190, 160, 2
  sleep, 30
  Controlclick, 關閉搜尋視窗, 醫囑搜尋功能
  }
  
getAge() {
  SetTitleMatchMode, 2
  WinGettitle, opd_title, 過敏記錄：
  stringsplit, opd_title_, opd_title, %A_space%
  StringTrimRight, age, opd_title_4, 1
  return age
  }

paste_tab(word) {
  clipboard := word
  ; Send, ^a
  Send, {end}
  Send, ^v{tab}
  Sleep, 25
}

paste_enter(word) {
  clipboard := word
  Send, ^v{enter}
  Sleep, 25
}

paste(_word, _func:=0) {
  clipboard := _word
  Sendinput, ^v
  if (_func = "enter") ; enter
	Sendinput, {enter}
  else if (_func = "tab") ; tab
	Sendinput, {tab}
  Sleep, 25
}

error_msg(_msg:="", _time:=1) {
  if (_msg = "")
    MsgBox, 16, 錯誤, 發生錯誤，請重試, %_time%
  else
    MsgBox, 16, 錯誤, %_msg%, %_time%
  exit
}

errorMsg(_msg:="", _time:=1) {
  if (_msg = "")
    MsgBox, 16, 錯誤, 發生錯誤，請重試, %_time%
  else
    MsgBox, 16, 錯誤, %_msg%, %_time%
  exit
}

waitWin(_title, _msg:="", _sec:="3") {
  SetTitleMatchMode, 2
  WinWait, %_title%, , %_sec%
  If ErrorLevel
	error_msg(_msg)
  Winactivate, %_title%
  }

checkTest() {
  if WinExist("ahk_exe Vghtpe.Dcr.Win.exe")
	waitWin("過敏記錄", "請先開啟SOAP畫面")
  else
	exit
  }
  
numOnly(_word) {
  _word := RegExReplace(_word, "\D")
  return _word
}
  
; get_age:
; SetTitleMatchMode, 2
; age := opd_title_1 := opd_title_2 := ""
; If WinExist("過敏記錄") {
  ; WinGettitle, opd_title, 過敏記錄
  ; stringsplit, opd_title_, opd_title, %A_space%
  ; StringTrimRight, ec_no, opd_title_1, 1
  ; StringTrimRight, ec_pt, opd_title_2, 1
  ; StringTrimRight, age, opd_title_4, 1
  ; }