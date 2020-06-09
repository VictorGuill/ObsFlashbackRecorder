#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance,Force ; Only allows one script instance oppened
SetTitleMatchMode, RegEx

Menu, Tray, NoStandard
Menu, Tray, Add, Exit, EXIT
Menu, Tray, Icon, icon_tray.ico
Menu, Tray, Tip, Obs flashback recorder

;;;;;;;;;;;;;;;;;;;;;;;OBS SCRIPT CONFIGURATION;;;;;;;;;;;;;;;;;;;;;;;

Use_collection = "flashback_games" ; Put here your obs scene collection, setting "" will use last one used
Use_profile = "Videogames" ; Put here your obs video recording profile, setting "" will use last one used

Start_minimized = 1 ; How OBS starts 0=Nomal 1=Minimized 2=Maximized 3=Hides on tray

rec_buffer = 1 ; 1=Buffer recording 0=Normal recording(Not recommended unless using .mkv) 

Obs_path = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\OBS Studio\OBS Studio (64bit)"

;;;;;;;;;;;;;;;;;;;;;;;PROGRAMS AND GAMES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

prg1 = notepad.exe ; Change program1 to your program process. EXAMPLE: program1.exe = csgo.exe
prg2 = program2.exe
prg3 = csgo.exe
prg4 = program4.exe
prg5 = program5.exe
prg6 = program6.exe
prg7 = program7.exe
prg8 = program8.exe
prg9 = program9.exe
prg10 = program10.exe

Scene1 = scene_program1 ; Change scene_program1 to obs scene name. EXAMPLE: scene_program1 = csgo_game
Scene2 = scene_program2
Scene3 = csgo_rec
Scene4 = scene_program4
Scene5 = scene_program5
Scene6 = scene_program6
Scene7 = scene_program7
Scene8 = scene_program8
Scene9 = scene_program9
Scene10 = scene_program10

;;;;;;;;;;;;;;;;;;;;;;;SCRIPT NOTIFICATION SOUND;;;;;;;;;;;;;;;;;;;;;;

SB_t = 2 ; SoundBeep repeat times, 0=Disable, will make no sound 2
SB_f = 800 ; Tone frequency in hz
SB_d = 100 ; Tone duration in ms
SB_s = 50 ; Pause between beeps in ms

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;DON'T MODIFY ANYTHING UNDER THIS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;unles you know what you are doing;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prs1 = ahk_exe %prg1% 
prs2 = ahk_exe %prg2%
prs3 = ahk_exe %prg3% ; Some variables trick to simplify user experience
prs4 = ahk_exe %prg4%
prs5 = ahk_exe %prg5%
prs6 = ahk_exe %prg6%
prs7 = ahk_exe %prg7%
prs8 = ahk_exe %prg8%
prs9 = ahk_exe %prg9%
prs10 = ahk_exe %prg10%
prs = ahk_exe %prg1%|%prg2%|%prg3%|%prg4%|%prg5%|%prg6%|%prg7%|%prg8%|%prg9%|%prg10%

start_tray = ; Resets the variable empty
min = ; Resets the variable empty

If Start_minimized = 0 ; The 4 reactions minimize variable
	min = 
else if Start_minimized = 1
	min = Min
else if Start_minimized = 2
	min = Max
else
	start_tray = --minimize-to-tray

If rec_buffer = 0 ; The 2 reactions record variable
	rec_mode = --startrecording
else if rec_buffer = 1
	rec_mode = --startreplaybuffer

SetTimer, CloseStuff, 250 ; Timer to scan if any .exe has been oppened
return
CloseStuff:
If !WinExist(prs)
	return
SetTimer, CloseStuff, off
If (WinExist(prs1)) ; If to check witch of the 10 programs has been oppened
	scene = "%Scene1%"
else if (WinExist(prs2))
	scene = "%Scene2%"
else if (WinExist(prs3))
	scene = "%Scene3%"
else if (WinExist(prs4))
	scene = "%Scene4%"
else if (WinExist(prs5))
	scene = "%Scene5%"
else if (WinExist(prs6))
	scene = "%Scene6%"
else if (WinExist(prs7))
	scene = "%Scene7%"
else if (WinExist(prs8))
	scene = "%Scene8%"
else if (WinExist(prs9))
	scene = "%Scene9%"
else if (WinExist(prs10))
	scene = "%Scene10%"

Run, %Obs_path% %rec_mode% --profile %Use_profile% --collection %Use_collection% --scene %scene% %start_tray% --multi, -m,%min%,obs ; Obs launch parameter with all the variables

WinWaitClose, %prs%
Process, Close, %obs%
SetTimer, CloseStuff, on
return
EXIT:
ExitApp
return

!F10:: ; Hotkey notification sound 
Sleep, 50
Loop %SB_t%
{
	SoundBeep, %SB_f%, %SB_d%
	Sleep, %SB_s%
}
return