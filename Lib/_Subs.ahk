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
