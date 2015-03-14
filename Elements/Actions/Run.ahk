﻿iniAllActions.="Run|" ;Add this action to list of all actions on initialisation

runActionRun(InstanceID,ElementID,ElementIDInInstance)
{
	global
	if ( %ElementID%ReplaceVariables)
		run, % %ElementID%ToRun, UseErrorLevel,ActionRuntempPid 
	else
		run, % v_replaceVariables(InstanceID,%ElementID%ToRun), UseErrorLevel,ActionRuntempPid
	
	if (ErrorLevel)
	{
		MarkThatElementHasFinishedRunning(InstanceID,ElementID,ElementIDInInstance,"exception")
	}
	else
	{
		v_setVariable(InstanceID,t_pid,ActionRuntempPid)
		MarkThatElementHasFinishedRunning(InstanceID,ElementID,ElementIDInInstance,"normal")
	}
	return
}
getNameActionRun()
{
	return lang("Run")
}
getCategoryActionRun()
{
	return lang("Process")
}

getParametersActionRun()
{
	global
	
	parametersToEdit:=["Label|" lang("Program, document, URL, etc. to open"),"Text||ToRun","Label| " lang("Value"),"Checkbox|0|ReplaceVariables|" lang("Replace variables")]
	return parametersToEdit
}

GenerateNameActionRun(ID)
{
	global
	;MsgBox % %ID%text_to_show
	
	return lang("Run") ": "  GUISettingsOfElement%ID%ToRun
	
}