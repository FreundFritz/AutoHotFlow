﻿;Always add this element class name to the global list
AllElementClasses.push("Action_Get_Control_Text")

;Element type of the element
Element_getElementType_Action_Get_Control_Text()
{
	return "Action"
}

;Name of the element
Element_getName_Action_Get_Control_Text()
{
	return lang("Get_Control_Text")
}

;Category of the element
Element_getCategory_Action_Get_Control_Text()
{
	return lang("Window")
}

;This function returns the package of the element.
;This is a reserved function for future releases,
;where it will be possible to install additional add-ons which provide more elements.
Element_getPackage_Action_Get_Control_Text()
{
	return "default"
}

;Minimum user experience to use this element.
;Elements which are complicated or rarely used by beginners should not be visible to them.
;This will help them to get started with AHF
Element_getElementLevel_Action_Get_Control_Text()
{
	;"Beginner" or "Advanced" or "Programmer"
	return "Beginner"
}

;Icon path which will be shown in the background of the element
Element_getIconPath_Action_Get_Control_Text()
{
}

;How stable is this element? Experimental elements will be marked and can be hidden by user.
Element_getStabilityLevel_Action_Get_Control_Text()
{
	;"Stable" or "Experimental"
	return "Stable"
}

;Returns a list of all parameters of the element.
;Only those parameters will be saved.
Element_getParameters_Action_Get_Control_Text()
{
	parametersToEdit:=Object()
	
	parametersToEdit.push({id: "Varname"})
	parametersToEdit.push({id: "IdentifyControlBy"})
	parametersToEdit.push({id: "ControlTextMatchMode"})
	parametersToEdit.push({id: "Control_identifier"})
	parametersToEdit.push({id: "TitleMatchMode"})
	parametersToEdit.push({id: "Wintitle"})
	parametersToEdit.push({id: "excludeTitle"})
	parametersToEdit.push({id: "winText"})
	parametersToEdit.push({id: "FindHiddenText"})
	parametersToEdit.push({id: "ExcludeText"})
	parametersToEdit.push({id: "ahk_class"})
	parametersToEdit.push({id: "ahk_exe"})
	parametersToEdit.push({id: "ahk_id"})
	parametersToEdit.push({id: "ahk_pid"})
	parametersToEdit.push({id: "FindHiddenWindow"})
	
	return parametersToEdit
}

;Returns an array of objects which describe all controls which will be shown in the element settings GUI
Element_getParametrizationDetails_Action_Get_Control_Text(Environment)
{
	parametersToEdit:=Object()

	parametersToEdit.push({type: "Label", label: lang("Output variable_name")})
	parametersToEdit.push({type: "Edit", id: "Varname", default: "ControlText", content: "VariableName"})
	
	parametersToEdit.push({type: "Label", label: lang("Control_Identification")})
	parametersToEdit.push({type: "Label", label: lang("Method_for_control_Identification"), size: "small"})
	parametersToEdit.push({type: "Radio", id: "IdentifyControlBy", result: "enum", default: 2, choices: [lang("Text_in_control"), lang("Classname and instance number of the control"), lang("Unique control ID")], enum: ["Text", "Class", "ID"]})
	parametersToEdit.push({type: "Label", id: "Label_Control_Identification", label: lang("Control_Identification"), size: "small"})
	parametersToEdit.push({type: "Radio", id: "ControlTextMatchMode", default: 2, choices: [lang("Start_with"), lang("Contain_anywhere"), lang("Exactly")]})
	parametersToEdit.push({type: "Edit", id: "Control_identifier", content: "String", WarnIfEmpty: true})
	
	parametersToEdit.push({type: "Label", label: lang("Window identification")})
	parametersToEdit.push({type: "Label", label: lang("Title_of_Window"), size: "small"})
	parametersToEdit.push({type: "Radio", id: "TitleMatchMode", default: 1, choices: [lang("Start_with"), lang("Contain_anywhere"), lang("Exactly")]})
	parametersToEdit.push({type: "Edit", id: "Wintitle", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Exclude_title"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "excludeTitle", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Text_of_a_control_in_Window"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "winText", content: "String"})
	parametersToEdit.push({type: "Checkbox", id: "FindHiddenText", default: 0, label: lang("Detect hidden text")})
	parametersToEdit.push({type: "Label", label: lang("Exclude_text_of_a_control_in_window"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "ExcludeText", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Window_Class"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "ahk_class", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Process_Name"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "ahk_exe", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Unique_window_ID"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "ahk_id", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Unique_Process_ID"), size: "small"})
	parametersToEdit.push({type: "Edit", id: "ahk_pid", content: "String"})
	parametersToEdit.push({type: "Label", label: lang("Hidden window"), size: "small"})
	parametersToEdit.push({type: "Checkbox", id: "FindHiddenWindow", default: 0, label: lang("Detect hidden window")})
	parametersToEdit.push({type: "Label", label: lang("Import window identification"), size: "small"})
	parametersToEdit.push({type: "button", goto: "Action_Get_Control_Text_ButtonWindowAssistant", label: lang("Import window identification")})
	
	return parametersToEdit
}

;Returns the detailed name of the element. The name can vary depending on the parameters.
Element_GenerateName_Action_Get_Control_Text(Environment, ElementParameters)
{
	
	local tempNameString
	if (ElementParameters.Wintitle)
	{
		if (ElementParameters.TitleMatchMode=1)
			tempNameString:=tempNameString "`n" lang("Title begins with") ": " ElementParameters.Wintitle
		else if (ElementParameters.TitleMatchMode=2)
			tempNameString:=tempNameString "`n" lang("Title includes") ": " ElementParameters.Wintitle
		else if (ElementParameters.TitleMatchMode=3)
			tempNameString:=tempNameString "`n" lang("Title is exatly") ": " ElementParameters.Wintitle
	}
	if (ElementParameters.excludeTitle)
		tempNameString:=tempNameString "`n" lang("Exclude_title") ": " ElementParameters.excludeTitle
	if (ElementParameters.winText)
		tempNameString:=tempNameString "`n" lang("Control_text") ": " ElementParameters.winText
	if (ElementParameters.ExcludeText)
		tempNameString:=tempNameString "`n" lang("Exclude_control_text") ": " ElementParameters.ExcludeText
	if (ElementParameters.ahk_class)
		tempNameString:=tempNameString "`n" lang("Window_Class") ": " ElementParameters.ahk_class
	if (ElementParameters.ahk_exe)
		tempNameString:=tempNameString "`n" lang("Process") ": " ElementParameters.ahk_exe
	if (ElementParameters.ahk_id)
		tempNameString:=tempNameString "`n" lang("Window_ID") ": " ElementParameters.ahk_id
	if (ElementParameters.ahk_pid)
		tempNameString:=tempNameString "`n" lang("Process_ID") ": " ElementParameters.ahk_pid
	
	return lang("Get_Control_Text") ": " tempNameString
}

;Called every time the user changes any parameter.
;This function allows to check the integrity of the parameters. For example you can:
;- Disable options which are not available because of other options
;- Correct misconfiguration
Element_CheckSettings_Action_Get_Control_Text(Environment, ElementParameters)
{	
	
}


;Called when the element should execute.
;This is the most important function where you can code what the element acutally should do.
Element_run_Action_Get_Control_Text(Environment, ElementParameters)
{
	Varname := x_replaceVariables(Environment, ElementParameters.Varname)
	if not x_CheckVariableName(Varname)
	{
		;On error, finish with exception and return
		x_finish(Environment, "exception", lang("%1% is not valid", lang("Ouput variable name '%1%'", Varname)))
		return
	}

	IdentifyControlBy := ElementParameters.IdentifyControlBy
	ControlTextMatchMode := ElementParameters.ControlTextMatchMode

	Control_identifier := x_replaceVariables(Environment,ElementParameters.Control_identifier)

	tempWinTitle:=x_replaceVariables(Environment, ElementParameters.Wintitle) 
	tempWinText:=x_replaceVariables(Environment, ElementParameters.winText)
	tempTitleMatchMode :=ElementParameters.TitleMatchMode
	tempahk_class:=x_replaceVariables(Environment, ElementParameters.ahk_class)
	tempahk_exe:=x_replaceVariables(Environment, ElementParameters.ahk_exe)
	tempahk_id:=x_replaceVariables(Environment, ElementParameters.ahk_id)
	tempahk_pid:=x_replaceVariables(Environment, ElementParameters.ahk_pid)
	
	tempwinstring:=tempWinTitle
	if tempahk_class
		tempwinstring:=tempwinstring " ahk_class " tempahk_class
	if tempahk_id
		tempwinstring:=tempwinstring " ahk_id " tempahk_id
	if tempahk_pid
		tempwinstring:=tempwinstring " ahk_pid " tempahk_pid
	if tempahk_exe
		tempwinstring:=tempwinstring " ahk_exe " tempahk_exe
	
	;If no window specified, error
	if (tempwinstring="" and tempWinText="")
	{
		x_enabled(Environment, "exception", lang("No window specified"))
		return
	}
	
	if ElementParameters.findhiddenwindow=0
		tempFindHiddenWindows = off
	else
		tempFindHiddenWindows = on
	if ElementParameters.findhiddentext=0
		tempfindhiddentext = off
	else
		tempfindhiddentext = on
	
	SetTitleMatchMode,%tempTitleMatchMode%
	DetectHiddenWindows,%tempFindHiddenWindows%
	DetectHiddenText,%tempfindhiddentext%
	
	tempWinid:=winexist(tempwinstring,tempWinText,tempExcludeTitle,tempExcludeText) ;Example code. Remove it
	if not tempWinid
	{
		x_finish(Environment, "exception", lang("Error! Seeked window does not exist")) 
		return
	}
	
	SetTitleMatchMode,%ControlTextMatchMode%
	controlget,tempControlID,hwnd,,% Control_identifier,ahk_id %tempWinid%
	if not tempControlID
	{
		x_finish(Environment, "exception", lang("Error! Seeked control does not exist in the specified windows")) 
		return
	}
	ControlGetText,tempText,,ahk_id %tempControlID%
	
	x_SetVariable(Environment,Varname,tempText)
	x_SetVariable(Environment,"A_WindowID",tempWinid,"Thread")
	x_SetVariable(Environment,"A_ControlID",tempControlID,"Thread")
	
	x_finish(Environment, "normal")
	return
	
}

;Called when the execution of the element should be stopped.
;If the task in Element_run_...() takes more than several seconds, then it is up to you to make it stoppable.
Element_stop_Action_Get_Control_Text(Environment, ElementParameters)
{
	
}


Action_Get_Control_Text_ButtonWindowAssistant()
{
	x_assistant_windowParameter({wintitle: "Wintitle", excludeTitle: "excludeTitle", winText: "winText", FindHiddenText: "FindHiddenText", ExcludeText: "ExcludeText", ahk_class: "ahk_class", ahk_exe: "ahk_exe", ahk_id: "ahk_id", ahk_pid: "ahk_pid", FindHiddenWindow: "FindHiddenWindow", IdentifyControlBy: "IdentifyControlBy", ControlTextMatchMode: "ControlTextMatchMode", Control_identifier: "Control_identifier"})
}
