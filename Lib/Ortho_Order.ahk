
Ortho_Order_GUI:
OD_order := ["SC", "前1", "前2", "前3", "後1", "後2", "後3", "-", "-"]
RPD_order := ["分析", "Ceph", "CBCT", "CT", "FD3", "FD4"]
Repair_order := ["RP1a", "RP1c", "RP1d", "RP1e", "調整", "黏合"]
Temp_order := ["RP3", "RP9"]
Other_order := ["SP6", "FLC"]
pay_code := Object("FP1", 83090000, "FP2", 83090002, "FP7", 83090007, "FP7A", 83090008, "FP9", 83091750, "FP9a", 83091751, "FP10", 83091752, "FP10a", 83091753, "FP12", 83091793, "FLC", 83090050, "SP6", 83090035, "RP6", 83090020, "RP7", 83090021, "RP10", 83091792, "FD2", 83090026, "FD4", 83091791, "RP3", 83090017, "RP9", 83090023, "RP1A", 83090010, "RP1c", 83090012, "RP1D", 83090013, "RP1E", 83090014, "調整", 83090054, "黏合", 83090011, "根尖X光", 83091059)
fee_code := ["8309170R", "8309170G", "8309170I", "8309171S", "8309170J", "8309170K", "8309170L", "8309170E", "8309170O"]

Gui, Hide
#SingleInstance force

SetTitleMatchMode, 2
WinGettitle, opd_title, 過敏記錄
stringsplit, opd_title_, opd_title, %A_space%

fee_alert := 0
order_s := 1
fee_num := 0
Ortho_order := []
order_code := []
; tx_fee_code := []
Gui, Ortho_Order: New
Gui, Ortho_Order: +AlwaysOnTop
Gui, Show, x400 y100 h490 w400, Ortho Order
Gui, Font, S10 CDefault, Meiryo UI
Gui, Add, GroupBox, x008 y005 w75 h475, OD
Gui, Add, GroupBox, x098 y005 w75 h325, 活動假牙
Gui, Add, GroupBox, x098 y355 w75 h125, 臨時假牙
Gui, Add, GroupBox, x188 y005 w75 h325, 假牙修補
Gui, Add, GroupBox, x188 y355 w75 h125, 其　　他
Gui, Add, GroupBox, x278 y155 w100 h175, Order List
; Gui, Add, Text, x285 y010 w100 h40 vaaa, %opd_title_7%
Gui, Font, S12 CDefault, Meiryo UI
loop, 9 {
  OD_order_y := 50 * A_Index - 20
  OD_order_now := OD_order[A_Index]
  Gui, Add, Button, x015 y%OD_order_y% w60 h40 gclick_order, %OD_order_now%
  }

loop, 6 {
  RPD_order_y := 50 * A_Index - 20
  RPD_order_now := RPD_order[A_Index]
  Gui, Add, Button, x105 y%RPD_order_y% w60 h40 gclick_order, %RPD_order_now%
  }


loop, 2 {
  Temp_order_y := 50 * A_Index + 330
  Temp_order_now := Temp_order[A_Index]
  Gui, Add, Button, x105 y%Temp_order_y% w60 h40 gclick_order, %Temp_order_now%
  }

loop, 6 {
  Repair_order_y := 50 * A_Index - 20
  Repair_order_now := Repair_order[A_Index]
  Gui, Add, Button, x195 y%Repair_order_y% w60 h40 gclick_order, %Repair_order_now%
  }

loop, 2 {
  other_order_y := 50 * A_Index + 330
  other_order_now := other_order[A_Index]
  Gui, Add, Button, x195 y%other_order_y% w60 h40 gclick_order, %other_order_now%
  }

Gui, Add, Button, x278 y430 w100 h40 gsent_order, 確認
Gui, Add, Button, x278 y380 w100 h40 greset_order, 重設
; Gui, Add, Button, x278 y030 w100 h40 gclick_order, 根尖X光
; Gui, Add, Button, x278 y080 w100 h40 gother_order, 其他醫囑
Gui, Add, Text, x278 y080 w100 h60 +center, 請先輸入 ICD10

loop, 5 {
  order_y := 30 * A_Index + 150
  Gui, Add, Text, x302 y%order_y% w50 h20 vord_%A_Index% +center, ---
  }

; IfInString, opd_title_7, 榮民
  ; Gui, Add, Checkbox, x278 y350 vpay_tx_fee, 收 Tx fee
; Else
  ; Gui, Add, Checkbox, x278 y350 vpay_tx_fee Checked, 收 Tx fee
return

click_order:
GuiControl, Text, ord_%order_s%, %A_GuiControl%
Ortho_order.Insert(A_GuiControl)
if (order_s > 5)
  error_msg("一次限輸入 5 項醫囑", 2)
else
  order_s += 1
return

; Ortho_OrderGuiClose:
; Ortho_OrderGuiEscape:
; Gui, Hide
; gosub, Ortho_Main_GUI
; Return

reset_order:
order_s := 1
fee_num := 0
Ortho_order := []
order_code := []
tx_fee_code := []
loop, 5 {
  GuiControl, Text, ord_%A_Index%, ---
  }
return

sent_order:
Gui, Submit
old_clip := clipboard
loop, 5 {
  now_order := Ortho_order[A_Index]
  If (now_order = "FD3")
    now_code := "830917A2"
  else
    now_code := pay_code[now_order]
  order_code.insert(now_code)
}
; activate_emr()
; order_go("醫囑")
; sleep, 25
; loop, %order_s% {
  ; now_code := order_code[A_Index]
  ; ifinstring, now_code, 8309
    ; serach_order(now_code)
  ; else
	; continue
  ; sleep, 25
  ; }
; If (pay_tx_fee = "1")
  ; gosub, tx_fees
; sleep, 50
; Controlclick, 確認, 開立醫囑
; clipboard := old_clip
return

; tx_fees:
; loop, %order_s% {
  ; now_order := Ortho_order[A_Index]
  ; If (now_order = "FP1") or (now_order = "FP2") or (now_order = "RP3")
	; serach_order(fee_code[1]) ; 200
  ; Else if (now_order = "FP7A")
    ; serach_order(fee_code[2]) ; 500
  ; Else if (now_order = "FP10") or (now_order = "FP10A")
    ; serach_order(fee_code[3]) ; 1000
  ; Else if (now_order = "FP9") or (now_order = "FP9A")
    ; serach_order(fee_code[5]) ; 1500
  ; Else if (now_order = "FP12") or (now_order = "RP7")
    ; serach_order(fee_code[6]) ; 2000
  ; Else if (now_order = "RP9")
    ; serach_order(fee_code[4]) ; 1200
  ; Else if (now_order = "FD3")
    ; serach_order(fee_code[7]) ; 3000
  ; Else if (now_order = "FP12") or (now_order = "RP7")
    ; serach_order(fee_code[6]) ; 2000
  ; Else if (now_order = "RP6") {
    ; serach_order(fee_code[1]) ; 500
	; sleep, 25
    ; serach_order(fee_code[2]) ; 200
	; }
  ; Else if (now_order = "RP10") {
    ; serach_order(fee_code[7]) ; 3000
	; sleep, 25
    ; serach_order(fee_code[8]) ; 300
	; }
  ; Else if (now_order = "FD2") {
    ; serach_order(fee_code[6]) ; 2000
	; sleep, 25
    ; serach_order(fee_code[2]) ; 500
	; sleep, 25
    ; serach_order(fee_code[8]) ; 300
	; }
  ; Else if (now_order = "FD4") {
    ; serach_order(fee_code[9]) ; 1000
	; sleep, 25
    ; serach_order(fee_code[1]) ; 200
	; }
  ; Else
	; continue
  ; sleep, 25
  ; }
; return

; other_order:
; return
