ver := 20180829
#Persistent
#SingleInstance force
#WinActivateForce
SetTitleMatchMode, 2
SetControlDelay -1

; WinKill, ahk_exe LivingEMR_Ortho.exe
#include <_Functions>
#include <Ortho_General>
#include <Ortho_Tx>
#include <Ortho_OD>
; #include <Ortho_Order>
#include <_Subs>

#include <Updater>
#include <Login>


;@Ahk2Exe-SetName LivingEMR-Ortho
;@Ahk2Exe-SetDescription LivingEMR-Ortho
;@Ahk2Exe-SetVersion 2018.8.27.0
;@Ahk2Exe-SetCopyright Copyright (c) 2018`, LivingGym


;@Ahk2Exe-IgnoreBegin

F5::
reload
return

F1::
; gosub, loginEdit
; msgbox, %loginNum%
return

;@Ahk2Exe-IgnoreEnd
