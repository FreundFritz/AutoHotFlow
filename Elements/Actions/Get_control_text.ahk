﻿iniAllActions.="Get_control_text|" ;Add this action to list of all actions on initialisation

runActionGet_control_text(InstanceID,ThreadID,ElementID,ElementIDInInstance)
{
	global
	local varname:=v_replaceVariables(InstanceID,ThreadID,%ElementID%Varname)
	
	if not v_CheckVariableName(varname)
	{
		logger("f0","Instance " InstanceID " - " %ElementID%type " '" %ElementID%name "': Error! Ouput variable name '" varname "' is not valid")
		MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"exception",lang("%1% is not valid",lang("Ouput variable name '%1%'",varname)) )
		return
	}
	
	local tempWinTitle:=v_replaceVariables(InstanceID,ThreadID,%ElementID%Wintitle)
	local tempExcludeTitle:=v_replaceVariables(InstanceID,ThreadID,%ElementID%excludeTitle)
	local tempWinText:=v_replaceVariables(InstanceID,ThreadID,%ElementID%winText)
	local tempExcludeText:=v_replaceVariables(InstanceID,ThreadID,%ElementID%ExcludeText)
	local tempTitleMatchMode :=%ElementID%TitleMatchMode
	local tempControlTextMatchMode :=%ElementID%ControlTextMatchMode
	local tempahk_class:=v_replaceVariables(InstanceID,ThreadID,%ElementID%ahk_class)
	local tempahk_exe:=v_replaceVariables(InstanceID,ThreadID,%ElementID%ahk_exe)
	local tempahk_id:=v_replaceVariables(InstanceID,ThreadID,%ElementID%ahk_id)
	local tempahk_pid:=v_replaceVariables(InstanceID,ThreadID,%ElementID%ahk_pid)
	local tempWinid
	
	local tempText	
	local tempControl_identifier:=v_replaceVariables(InstanceID,ThreadID,%ElementID%Control_identifier)
	
	local tempwinstring:=tempWinTitle
	
	if tempahk_class<>
		tempwinstring=%tempwinstring% ahk_class %tempahk_class%
	if tempahk_id<>
		tempwinstring=%tempwinstring% ahk_id %tempahk_id%
	if tempahk_pid<>
		tempwinstring=%tempwinstring% ahk_pid %tempahk_pid%
	if tempahk_exe<>
		tempwinstring=%tempwinstring% ahk_exe %tempahk_exe%
	if tempwinstring=
		tempwinstring=A
	
	
	
	SetTitleMatchMode,%tempTitleMatchMode%
	
	if %ElementID%findhiddenwindow=0
		DetectHiddenWindows off
	else
		DetectHiddenWindows on
	if %ElementID%findhiddentext=0
		DetectHiddenText off
	else
		DetectHiddenText on
	
	WinGet,tempWinid,ID,%tempwinstring%,%tempWinText%,%tempExcludeTitle%,%tempExcludeText%

	if tempWinid=
	{
		logger("f0","Instance " InstanceID " - " %ElementID%type " '" %ElementID%name "': Error! Seeked window does not exist")
		MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"Exception", lang("Seeked window does not exist"))
		return
	}
	;~ MsgBox %tempControlTextMatchMode%
	SetTitleMatchMode,%tempControlTextMatchMode%
	
	controlget,tempControlID,hwnd,,% tempControl_identifier,ahk_id %tempWinid%
	if tempControlID=
	{
		logger("f0","Instance " InstanceID " - " %ElementID%type " '" %ElementID%name "': Error! Seeked control does not exist")
		MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"Exception", lang("Seeked control does not exist"))
		return
		
	}
	
	ControlGetText,tempText,,ahk_id %tempControlID%
	v_SetVariable(InstanceID,ThreadID,varname,tempText)
	v_SetVariable(InstanceID,ThreadID,"A_WindowID",tempWinid,,c_SetBuiltInVar)
	v_SetVariable(InstanceID,ThreadID,"A_ControlID",tempControlID,,c_SetBuiltInVar)
	MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"normal")
	
	
	

	return
}
getNameActionGet_control_text()
{
	return lang("Get_control_text")
}
getCategoryActionGet_control_text()
{
	return lang("Window")
}

getParametersActionGet_control_text()
{
	global
		parametersToEdit:=Object()
	parametersToEdit.push({type: "Label", label: lang("Output variable_name")})
	parametersToEdit.push({type: "Edit", id: "Varname", default: "NewVariable", content: "VariableName", WarnIfEmpty: true})
	parametersToEdit.push({type: "Label", label: lang("Method_for_control_Identification")})
	parametersToEdit.push({type: "Radio", id: "IdentifyControlBy", default: 2, choices: [lang("Text_in_control"), lang("Classname and instance number of the control"), lang("Unique control ID")]})
	parametersToEdit.push({type: "Label", id: "Label_Control_Identification", label: lang("Control_Identification")})
	parametersToEdit.push({type: "Radio", id: "ControlTextMatchMode", default: 2, choices: [lang("Start_with"), lang("Contain_anywhere"), lang("Exactly")]})
	parametersToEdit.push({type: "Edit", id: "Control_identifier", content: "String", WarnIfEmpty: true})
	parametersToEdit.push({type: "Label", label: lang("Title_of_Window")})
	parametersToEdit.push({type: "Radio", id: "TitleMatchMode", default: 1, choices: [lang("Start_with"), lang("Contain_anywhere"), lang("Exactly")]})
	parametersToEdit.push({type: "Edit", id: "Wintitle", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Exclude_title")})
	parametersToEdit.push({type: "Edit", id: "excludeTitle", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Text_of_a_control_in_Window")})
	parametersToEdit.push({type: "Edit", id: "winText", content: "String"})
	parametersToEdit.push({type: "Checkbox", id: "FindHiddenText", default: 0, label: lang("Detect hidden text")})
	parametersToEdit.push({type: "Label", label: lang("Exclude_text_of_a_control_in_window")})
	parametersToEdit.push({type: "Edit", id: "ExcludeText", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Window_Class")})
	parametersToEdit.push({type: "Edit", id: "ahk_class", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Process_Name")})
	parametersToEdit.push({type: "Edit", id: "ahk_exe", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Unique_window_ID")})
	parametersToEdit.push({type: "Edit", id: "ahk_id", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Unique_Process_ID")})
	parametersToEdit.push({type: "Edit", id: "ahk_pid", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Hidden window")})
	parametersToEdit.push({type: "Checkbox", id: "FindHiddenWindow", default: 0, label: lang("Detect hidden window")})
	parametersToEdit.push({type: "button", goto: "FunctionsForElementGetControlInformation", label: lang("Wizard_to_get_parameters")})

	
	

	;,"Label|" lang("Insert_a_keystroke"), "Hotkey||HotkeyToInsert,"Button|customSettingButtonOfActionGet_control_textHotkeyToInsert||" lang("Insert")
	return parametersToEdit
}


GenerateNameActionGet_control_text(ID)
{
	global
	
	return % lang("Get_control_text")  "`n" GUISettingsOfElement%ID%KeysToSend "`n" lang("Control") ": " GUISettingsOfElement%ID%Control_identifier
	
}


CheckSettingsActionGet_control_text(ID)
{
	;MsgBox % "GUISettingsOfElement%ID%IdentifyControlBy " GUISettingsOfElement%ID%IdentifyControlBy
	if (GUISettingsOfElement%ID%IdentifyControlBy3 = 1)
	{
		GuiControl,,GUISettingsOfElement%ID%Label_Control_Identification,% lang("Control ID")
		
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode1
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode2
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode3		
		GuiControl,disable,GUISettingsOfElement%ID%TitleMatchMode1
		GuiControl,disable,GUISettingsOfElement%ID%TitleMatchMode2
		GuiControl,disable,GUISettingsOfElement%ID%TitleMatchMode3
		GuiControl,disable,GUISettingsOfElement%ID%Wintitle
		GuiControl,disable,GUISettingsOfElement%ID%excludeTitle
		GuiControl,disable,GUISettingsOfElement%ID%winText
		GuiControl,disable,GUISettingsOfElement%ID%FindHiddenText
		GuiControl,disable,GUISettingsOfElement%ID%ExcludeText
		GuiControl,disable,GUISettingsOfElement%ID%ahk_class
		GuiControl,disable,GUISettingsOfElement%ID%ahk_exe
		GuiControl,disable,GUISettingsOfElement%ID%ahk_id
		GuiControl,disable,GUISettingsOfElement%ID%ahk_pid
		GuiControl,disable,GUISettingsOfElement%ID%FindHiddenWindow
	}
	else
	{
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode1
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode2
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode3		
		GuiControl,Enable,GUISettingsOfElement%ID%TitleMatchMode1
		GuiControl,Enable,GUISettingsOfElement%ID%TitleMatchMode2
		GuiControl,Enable,GUISettingsOfElement%ID%TitleMatchMode3
		GuiControl,Enable,GUISettingsOfElement%ID%Wintitle
		GuiControl,Enable,GUISettingsOfElement%ID%excludeTitle
		GuiControl,Enable,GUISettingsOfElement%ID%winText
		GuiControl,Enable,GUISettingsOfElement%ID%FindHiddenText
		GuiControl,Enable,GUISettingsOfElement%ID%ExcludeText
		GuiControl,Enable,GUISettingsOfElement%ID%ahk_class
		GuiControl,Enable,GUISettingsOfElement%ID%ahk_exe
		GuiControl,Enable,GUISettingsOfElement%ID%ahk_id
		GuiControl,Enable,GUISettingsOfElement%ID%ahk_pid
		GuiControl,Enable,GUISettingsOfElement%ID%FindHiddenWindow
		
	}
	
	
	if (GUISettingsOfElement%ID%IdentifyControlBy1 = 1)
	{
		
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode1
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode2
		GuiControl,Enable,GUISettingsOfElement%ID%ControlTextMatchMode3
		GuiControl,,GUISettingsOfElement%ID%Label_Control_Identification,% lang("Text_in_control")
	}
	else if (GUISettingsOfElement%ID%IdentifyControlBy2 = 1)
	{
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode1
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode2
		GuiControl,disable,GUISettingsOfElement%ID%ControlTextMatchMode3
		GuiControl,,GUISettingsOfElement%ID%Label_Control_Identification,% lang("Classname and instance number of the control")
	}
	
}
