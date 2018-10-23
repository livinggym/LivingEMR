; 讀取設定檔
iniName := "Login.ini"
DocNum := 13
loop, %DocNum% {
  IniRead, docID%A_Index%, %iniName%, login, docID%A_Index%, %A_space%
  IniRead, docPW%A_Index%, %iniName%, login, docPW%A_Index%, %A_space%
  IniRead, docDisp%A_Index%, %iniName%, login, docDisp%A_Index%, %A_space%
  IniRead, docRoom%A_Index%, %iniName%, login, docRoom%A_Index%, %A_space%
  }




; Menu, tray, NoStandard 
Menu, tray, add, Ver. %ver%, nullFunc
; Menu, tray, add, 檢查更新, check_ver
; Menu, tray, add, 程式資訊, aboutEMR
Menu, tray, add, 關閉程式, exit_app

; 自動顯示側邊視窗
SetTimer, attachWindow, 250

; 檢查更新
; gosub, check_ver
return

; 自動執行部分結束===========================================================================================



attach_window:
#SingleInstance force
SetTitleMatchMode, 2

;病患清單畫面
If !WinExist("切換椅位") and WinActive("台北榮民總醫院門診系統【") and !WinExist("換科登入")
  {
  WinGetPos, opd_x, opd_y, opd_w, , 台北榮民總醫院門診系統【
  login_x := opd_x + opd_w
  login_y := opd_y + 150
  sleep, 30
  Gui, loginButton: New
  Gui, loginButton: -Caption +AlwaysOnTop
  Gui, Show, x%login_x% y%login_y% w30 h360, 切換椅位
  Gui, Font, S12 CDefault, Meiryo UI
  ; Gui, Add, button, x0 y000 w30 h100 , 89
  ; Gui, Add, button, x0 y100 w30 h100 , 90 
  ; Gui, Add, button, x0 y200 w30 h100 , 91
  ; loop, 8 {
	; gui_y := A_Index * 40 - 40
	; now_chair := Chair[A_Index]
	; Gui, Add, Button, x0 y%gui_y% w40 h40 gdo_login, %now_chair%
	; }
  ; Gui, Add, Button, x0 y320 w40 h40 gedit_pw_gui, 改
  sleep, 25
  winactivate 台北榮民總醫院門診系統【
  winactivate ahk_exe Vghtpe.Dcr.Win.exe
  }
  
if !WinActive("台北榮民總醫院門診系統【") and !WinActive("切換椅位") {	
  Gui, loginButton: hide
  }

  ; SOAP畫面
If WinActive("過敏記錄：") and !WinExist("快速病歷") {
  WinGetPos, opd_x, opd_y, opd_w, , 過敏記錄：
  login_x := opd_x + opd_w
  login_y := opd_y + 55
  sleep, 30
  Gui, emrButton: New
  Gui, emrButton: -Caption +AlwaysOnTop
  Gui, Show, x%login_x% y%login_y% w30 h560, 快速病歷
  Gui, Font, S14, 微軟正黑體
  Gui, Add, button, x0 y000 w30 h100 gtxCharting, 分析
  Gui, Add, button, x0 yp+100 w30 hp gtxScaling, 洗牙
  Gui, Add, button, x0 yp+100 w30 hp gtxOD, OD	
  Gui, Add, button, x0 yp+100 w30 hp gtxExt, 拔牙骨釘
  Gui, Add, button, x0 yp+100 w30 hp gtxMonthlydue, 開帳

  ; Gui, Add, button, x0 y480 w30 h080 , 綜合
  Gui, Add, button, x0 y500 w30 h060 , 修改
  sleep, 25
  winactivate ahk_exe Vghtpe.Dcr.Win.exe
  }

if !WinActive("過敏記錄：") and !WinActive("快速病歷") {
  Gui, emrButton: hide
  }
return
