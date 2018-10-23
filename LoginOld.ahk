ver = 20160911
SetTitleMatchMode, 2
#Persistent
#include <_Function>
BlockInput, SendAndMouse
now_ke := "0Z0 一般牙科"
; load_par
loop, 9 {
  IniRead, doc_%A_Index%_id, Living_EMR.ini, login, doc_%A_Index%_id, %A_space%
  IniRead, doc_%A_Index%_pw, Living_EMR.ini, login, doc_%A_Index%_pw, %A_space%
  IniRead, doc_%A_Index%_ch, Living_EMR.ini, login, doc_%A_Index%_ch, %A_space%
  IniRead, doc_%A_Index%_dp, Living_EMR.ini, login, doc_%A_Index%_dp, %A_space%
  }

SetTimer, attach_window, 250
return

attach_window:
#SingleInstance force
SetTitleMatchMode, 2
If !WinExist("切換椅位") and WinActive("台北榮民總醫院門診系統【") and !WinExist("換科登入")
  {
  WinGetPos, opd_x, opd_y, opd_w, , 台北榮民總醫院門診系統【
  login_x := opd_x + opd_w
  login_y := opd_y + 150
  
  Gui, login_btn: New
  Gui, login_btn: -Caption +AlwaysOnTop
  Gui, Show, x%login_x% y%login_y% w40 h400, 切換椅位
  Gui, Font, S12 CDefault, Meiryo UI
  loop, 9 {
    gui_y := A_Index * 40 - 40
    now_dp := doc_%A_Index%_dp
    Gui, Add, Button, x0 y%gui_y% w40 h40 gdo_login, %now_dp%
    }
    Gui, Add, Button, x0 y360 w40 h40 glogin_edit, 改
  ; sleep, 25
  ; winactivate ahk_exe Vghtpe.Dcr.Win.exe
  }
If !WinActive("台北榮民總醫院門診系統【") and !WinActive("切換椅位") {
  Gui, login_btn: hide
  }
return

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


login_edit:
Gui, login_edit: New
Gui, login_edit: +AlwaysOnTop
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x600 y200 h345 w255, 修改登入密碼
Gui, Add, Text, x005 y010 w020 h25 +center, 診
Gui, Add, Text, x005 y040 w020 h25 +center, 1
Gui, Add, Text, x005 y070 w020 h25 +center, 2
Gui, Add, Text, x005 y100 w020 h25 +center, 3
Gui, Add, Text, x005 y130 w020 h25 +center, 4
Gui, Add, Text, x005 y160 w020 h25 +center, 5
Gui, Add, Text, x005 y190 w020 h25 +center, 6
Gui, Add, Text, x005 y220 w020 h25 +center, 7
Gui, Add, Text, x005 y250 w020 h25 +center, 8
Gui, Add, Text, x030 y010 w070 h25 +center, 燈號
Gui, Add, Edit, x030 y040 w070 h25 +center vnew_doc1_id, %doc1_id%
Gui, Add, Edit, x030 y070 w070 h25 +center vnew_doc2_id, %doc2_id%
Gui, Add, Edit, x030 y100 w070 h25 +center vnew_doc3_id, %doc3_id%
Gui, Add, Edit, x030 y130 w070 h25 +center vnew_doc4_id, %doc4_id%
Gui, Add, Edit, x030 y160 w070 h25 +center vnew_doc5_id, %doc5_id%
Gui, Add, Edit, x030 y190 w070 h25 +center vnew_doc6_id, %doc6_id%
Gui, Add, Edit, x030 y220 w070 h25 +center vnew_doc7_id, %doc7_id%
Gui, Add, Edit, x030 y250 w070 h25 +center vnew_doc8_id, %doc8_id%
Gui, Add, Text, x110 y010 w140 h25 +center, 密碼
Gui, Add, Edit, x110 y040 w140 h25 +center password vnew_doc1_pw, %doc1_pw%
Gui, Add, Edit, x110 y070 w140 h25 +center password vnew_doc2_pw, %doc2_pw%
Gui, Add, Edit, x110 y100 w140 h25 +center password vnew_doc3_pw, %doc3_pw%
Gui, Add, Edit, x110 y130 w140 h25 +center password vnew_doc4_pw, %doc4_pw%
Gui, Add, Edit, x110 y160 w140 h25 +center password vnew_doc5_pw, %doc5_pw%
Gui, Add, Edit, x110 y190 w140 h25 +center password vnew_doc6_pw, %doc6_pw%
Gui, Add, Edit, x110 y220 w140 h25 +center password vnew_doc7_pw, %doc7_pw%
Gui, Add, Edit, x110 y250 w140 h25 +center password vnew_doc8_pw, %doc8_pw%
Gui, Add, Button, x5 y280 w245 h40 +center glogin_update, 修改完成
Gui, Font, S8 CDefault, Meiryo UI
Gui, Add, Text, x005 y325 w245 h20, Ver. %ver% by LivingGym
return

login_update:
return

F5::reload


; loop, 16 {
  ; now_id := "doc_" . A_Index . "_id"
  ; now_pw := "doc_" . A_Index . "_pw"
  ; now_ch := "doc_" . A_Index . "_ch"
  ; now_dp := "doc_" . A_Index . "_dp"

  ; new_ids := "new_doc" . Chair[A_Index] . "_id"
  ; new_id := %new_ids%
  ; now_pw := "doc" . Chair[A_Index] . "_pw"
  ; new_pws := "new_doc" . Chair[A_Index] . "_pw"
  ; new_pw := encode(%new_pws%)
  ; Iniwrite, %new_id%, Living_EMR.ini, login, %now_id%
  ; Iniwrite, %new_pw%, Living_EMR.ini, login, %now_pw%
  ; Iniwrite, %new_ch%, Living_EMR.ini, login, %now_ch%
  ; Iniwrite, %new_dp%, Living_EMR.ini, login, %now_dp%
  ; }
  
  
  
  ; do_login_OLD(){
  ; global now_id, now_pw, now_dept, now_chair
  ; old_clip := Clipboard
  ; SetTitleMatchMode, 2
  ; =========== 登入畫面 =========== 
  ; If WinExist("台北榮民總醫院門診系統", "醫事卡認證"){
	; Winactivate 台北榮民總醫院門診系統
	; Controlclick, x340 y107, 台北榮民總醫院門診系統
	; paste(now_id)
	; paste_tab(now_pw)
	; sleep, 30
	; Send, {tab}
	; paste_enter(now_chair)
	; Exit
	; }
  ; =========== 病患清單畫面 =========== 
  ; If WinExist("換科登入") or WinExist("台北榮民總醫院門診系統")
	; Gosub, in_login
  ; Else 
	; error_msg("請先開啟病患清單畫面")
  ; If WinExist("台北榮民總醫院門診系統"){
	; WinActivate 台北榮民總醫院門診系統
	; ControlClick, x80 y45 ; 輔助功能
	; Sleep 100
	; Click, 80, 115 ; 換科登入
	; }
  ; waitWin("換科登入")
  ; sleep, 25
  ; Controlclick, x200 y140, 換科登入 ; 第二格
  ; Sendinput, +{tab}
  ; sleep, 25
  ; paste_tab(now_id)
  ; paste_tab(now_pw)
  ; paste_tab(now_dept)
  ; paste(now_chair)
  ; sleep, 25
  ; If (now_pw != "")
	; Controlclick, 登入, 換科登入
  ; Clipboard := old_clip
}