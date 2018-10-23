attachWindow:
#SingleInstance force
SetTitleMatchMode, 2

;病患清單畫面
If !WinExist("切換椅位") and WinActive("台北榮民總醫院門診系統【") and !WinExist("換科登入")
  {
  WinGetPos, opd_x, opd_y, opd_w, , 台北榮民總醫院門診系統【
  nowX := opd_x + opd_w
  nowY := opd_y + 150
  loginNum := 0
  sleep, 30
  Gui, loginButton: New
  Gui, loginButton: -Caption +AlwaysOnTop
  ; Gui, Show, x%nowX% y%nowY% w40 h%nowH%, 切換椅位
  Gui, Font, S12 CDefault, Meiryo UI
  Gui, Add, text, x0 y-40 w30 h30 , 
  loop, %DocNum% {
  nowDisp := docDisp%A_Index%
  nowVar := "loginButton" . A_Index
  if (nowDisp != "") {
    Gui, Add, button, x0 yp+40 w40 h40 gclickLogin v%nowVar%, %nowDisp%
	loginNum += 1
	}
  }
  Gui, Add, Button, xp yp+40 w40 h40 gloginEdit, 改
  nowH := loginNum * 40 + 40
  Gui, Show, x%nowX% y%nowY% w40 h%nowH%, 切換椅位
  sleep, 25
  winactivate 台北榮民總醫院門診系統【
  winactivate ahk_exe Vghtpe.Dcr.Win.exe
}
  
if !WinActive("台北榮民總醫院門診系統【") and !WinActive("切換椅位") {	
  Gui, loginButton: hide
}
return

clickLogin:
nowVar := numOnly(A_GuiControl)
nowID := docID%nowVar%
nowPW := docPW%nowVar%
nowRoom := docRoom%nowVar%
nowDisp := docDisp%nowVar%
msgbox, %nowID%, %nowPW%

return













loginEdit:
Gui, login_edit: New
Gui, login_edit: +AlwaysOnTop
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x700 y200 h650 w400, 修改登入資訊
Gui, Add, Text, x005 y010 w020 h25 +center, #
Gui, Add, Text, xp+35 y010 w040 h25 +center, 顯示
Gui, Add, Text, xp+55 yp w070 h25 +center, 燈號
Gui, Add, Text, xp+85 yp w070 h25 +center, 密碼
Gui, Add, Text, xp+85 yp w040 h25 +center, 椅位
loop, %DocNum% {
  nowID := docID%A_Index%
  nowPW := docPW%A_Index%
  nowRoom := docRoom%A_Index%
  nowDisp := docDisp%A_Index%
  newID := "newDocID" . A_Index
  newPW := "newDocPW" . A_Index
  newRoom := "newDocRoom" . A_Index
  newDisp := "newDocDisp" . A_Index
  
  nowY :=  A_Index * 35 + 10
  Gui, Add, Text, x005 y%nowY% w020 h25 +center, %A_Index%
  Gui, Add, Edit, xp+35 yp w040 h25 +center v%newDisp%, %nowDisp%
  Gui, Add, Edit, xp+55 yp w070 h25 +center v%newID%, %nowID%
  ; Gui, Add, Edit, xp+55 yp w070 h25 +center v%newID%, 1111A
  Gui, Add, Edit, xp+85 yp w070 h25 +center v%newPW%, %nowPW%
  Gui, Add, Edit, xp+85 yp w040 h25 +center v%newRoom%, %nowRoom%     
  }
Gui, Add, Button, x005 yp+35 w090 h35 +Center gdoneLoginEdit, 更改完成

return

doneLoginEdit:
Gui, login_edit: Submit
loop, %DocNum% {
  nowID := "docID" . A_Index
  nowPW := "docPW" . A_Index
  nowRoom := "docRoom" . A_Index
  nowDisp := "docDisp" . A_Index
  newID := newDocID%A_Index%
  newPW := newDocPW%A_Index%
  newRoom := newDocRoom%A_Index%
  newDisp := newDocDisp%A_Index% 
  Iniwrite, %newID%, %iniName%, Login, %nowID%
  Iniwrite, %newPW%, %iniName%, Login, %nowPW%
  Iniwrite, %newRoom%, %iniName%, Login, %nowRoom%
  Iniwrite, %newDisp%, %iniName%, Login, %nowDisp%
  }
reload
return
