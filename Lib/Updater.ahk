check_ver:
root_url := "http://box.ymdd.tw/LivingEMR/"
file_name := A_ScriptName
file_url := root_url . file_name
file_ver := file_url . ".txt?" . ver  . "-" . A_ComputerName

req := ComObjCreate("Msxml2.XMLHTTP")
req.open("GET", file_ver, true)
req.onreadystatechange := Func("GetVer")
req.send()
sleep 1000
; msgbox, 最新版本%new_ver%，目前版本%ver%
If (new_ver = "") or (new_ver = 0)
  exit
FileRead, lastUpdate, update.ini
If (new_ver > ver) and (A_IsCompiled = 1) and (A_YDay > lastUpdate) {
  msgbox, 1, , 最新版本%new_ver%，目前版本%ver%，是否要更新？
  IfMsgBox Yes
	gosub, updater
  }
return

updater:
; MsgBox, 64, LivingEMR, 自動更新病歷程式中，請稍候, 0.5
root_url := "http://box.ymdd.tw/LivingEMR/"
file_name := A_ScriptName
file_url := root_url . file_name

bat=
		(LTrim
:start
	bitsadmin.exe /transfer "JobName" %file_url% %A_ScriptDir%\%file_name%.tmp
	ping 127.0.0.1 -n 2>nul
	if exist %file_name%.bak del %file_name%.bak
	taskkill /F /IM %file_name%
	ping 127.0.0.1 -n 1>nul
	ren %file_name% %file_name%.bak
	ren %file_name%.tmp %file_name%
	ping 127.0.0.1 -n 1>nul
	start %file_name%
	del `%0
	)
	batfilename := "LivingEMR-Updater.bat"
	; urldownloadtofile, %file_url%, %file_name%.tmp
	
	IfExist %batfilename%
		FileDelete %batfilename%
	FileAppend, %bat%, %batfilename%
	IfExist update.ini
		FileDelete update.ini
	FileAppend, %A_YDay%, update.ini
	Run, %batfilename% "%A_ScriptFullPath%", , Hide
	; ExitApp
return

GetVer() {
  global req, new_ver
  if (req.readyState != 4)  ; Not done yet.
	return
  if (req.status == 200 || req.status == 304) ; OK.
	new_ver := req.responseText
  else
	new_ver := 0
  Exit
}
