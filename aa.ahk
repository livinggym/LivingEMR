MouseGetPos, xpos, ypos 
Msgbox, The cursor is at X%xpos% Y%ypos%. 

; 这里例子允许您移动鼠标来查看
; 鼠标悬停窗口的标题:
#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, , , id, control
WinGetTitle, title, ahk_id %id%
WinGetClass, class, ahk_id %id%
ToolTip, ahk_id %id%`nahk_class %class%`n%title%`nControl: %control%
return
