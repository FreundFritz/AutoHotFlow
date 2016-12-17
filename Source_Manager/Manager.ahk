﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%\..  ; Ensures a consistent starting directory.
;~ MsgBox %A_WorkingDir%
parentAHKThread := AhkExported()
onexit exit
#include lib\Object to file\String-object-file.ahk

#include language\language.ahk
;initialize languages
lang_Init()

#include Source_Manager\User Interface\manager gui.ahk
#include Source_Manager\User Interface\help.ahk
#include Source_Manager\User Interface\Change Category GUI.ahk
#include Source_Manager\User Interface\Select language.ahk
#include Source_Manager\User Interface\Global_Settings.ahk
#include Source_Manager\Flows\Manage Flows.ahk
#include Source_Manager\Flows\Execute Flows.ahk
#include Source_Manager\API\API receiver manager.ahk

#include source_Common\Global variables\global variables.ahk
#include source_Common\Debug\Debug.ahk
#include source_Common\Debug\Logger.ahk
#include source_Common\Multithreading\API Caller Main.ahk


menu,tray, tip, Manager
init_Manager_GUI()
Show_Manager_GUI()

FindFlows()

return

exit_all()
{
	global
	API_Main_Exit()
}

exit:
if (exiting != true)
exit_all()
exiting := true
exitapp
return