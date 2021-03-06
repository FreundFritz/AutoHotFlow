﻿iniAllActions.="Empty_recycle_bin|" ;Add this action to list of all actions on initialisation

runActionEmpty_recycle_bin(InstanceID,ThreadID,ElementID,ElementIDInInstance)
{
	global
	
	if %ElementID%AllDrives=1
		FileRecycleEmpty
	else
		FileRecycleEmpty, % v_replaceVariables(InstanceID,ThreadID,%ElementID%Drive)
	if ErrorLevel
	{
		logger("f0","Instance " InstanceID " - " %ElementID%type " '" %ElementID%name "': Error! Recycle bin could not be emptied.")
		MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"exception",lang("Recycle bin could not be emptied."))
		return
	}
	MarkThatElementHasFinishedRunning(InstanceID,ThreadID,ElementID,ElementIDInInstance,"normal")
	return
}
getNameActionEmpty_recycle_bin()
{
	return lang("Empty_recycle_bin")
}
getCategoryActionEmpty_recycle_bin()
{
	return lang("Files")
}

getParametersActionEmpty_recycle_bin()
{
	global
	
	parametersToEdit:=Object()
	parametersToEdit.push({type: "Label", label: lang("Which drive")})
	parametersToEdit.push({type: "Radio", id: "AllDrives", default: 1, choices: [lang("All drives"), lang("Specified drive")]})
	parametersToEdit.push({type: "Folder", id: "drive", label: lang("Select the root Folder of a drive")})

	return parametersToEdit
}

GenerateNameActionEmpty_recycle_bin(ID)
{
	global
	;MsgBox % %ID%text_to_show
	
	return lang("Empty_recycle_bin")
	
}

CheckSettingsActionEmpty_recycle_bin(ID)
{
	if (GUISettingsOfElement%ID%AllDrives1 = 1)
	{
		
		GuiControl,Disable,GUISettingsOfElement%ID%drive
	}
	else
	{
		
		GuiControl,Enable,GUISettingsOfElement%ID%drive
	}
	
	
}