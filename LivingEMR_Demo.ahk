ver := 20180818
#Persistent
#SingleInstance force
#WinActivateForce
SetTitleMatchMode, 2
SetControlDelay -1
; BlockInput, SendAndMouse

#include <_Functions>
; #include <Demo_General>
; #include <Demo_Tx>
return
#include <_Subs>
; #include <Encode>
; #include <Pedo_General>
; #include <Pedo_Fluoride>
; #include <Pedo_Edit>
; #include <Pedo_Order>
; #include <Updater>


;@Ahk2Exe-SetName LivingEMR-Demo
;@Ahk2Exe-SetDescription LivingEMR-Demo
;@Ahk2Exe-SetVersion 1.2.3
;@Ahk2Exe-SetCopyright Copyright (c) 2015-2018`, LivingGym


;@Ahk2Exe-IgnoreBegin

F5::
reload
return

F1::
gosub, toothOD
return

;@Ahk2Exe-IgnoreEnd
