ver := 20180906
#Persistent
#SingleInstance force
#WinActivateForce
SetTitleMatchMode, 2
SetControlDelay -1
#include <_Functions>

iniName := "Login.ini"
loop, 9 {
  IniRead, docID%A_Index%, %iniName%, login, docID%A_Index%, %A_space%
  IniRead, docPW%A_Index%, %iniName%, login, docPW%A_Index%, %A_space%
  IniRead, docDisp%A_Index%, %iniName%, login, docDisp%A_Index%, %A_space%
  IniRead, docRoom%A_Index%, %iniName%, login, docRoom%A_Index%, %A_space%
  }
return

F2::
; IniRead, docID1, Login.ini, login, docID1, zz
; msgbox, %qwer%
; msgbox, %doc_1_id%
return

F1::
gosub, loginEdit
return

f5::reload



loginEdit:
Gui, login_edit: New
Gui, login_edit: +AlwaysOnTop
Gui, Font, S12 CDefault, Meiryo UI
Gui, Show, x600 y100 h450 w400, 修改登入資訊
Gui, Add, Text, x005 y010 w020 h25 +center, #
Gui, Add, Text, xp+35 y010 w040 h25 +center, 顯示
Gui, Add, Text, xp+55 yp w070 h25 +center, 燈號
Gui, Add, Text, xp+85 yp w070 h25 +center, 密碼
Gui, Add, Text, xp+85 yp w040 h25 +center, 椅位
loop, 9 {
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
Gui, Add, Button, x005 y365 w090 h35 +Center gdoneEdit, 更改完成

return

doneEdit:
Gui, login_edit: Submit, Nohide
loop, 9 {
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
