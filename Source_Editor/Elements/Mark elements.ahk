﻿;mark an element or connection. If parameter additional is true, mark it additionally to others
MarkOne(p_ID,additional:=false)
{
	global _flows
	global FlowID
	
	markedElements:=_flows[FlowID].markedElements
	allConnections:=_flows[FlowID].allConnections
	allElements:=_flows[FlowID].allElements
	markedElements:=_flows[FlowID].markedElements
	
	
	;~ ToolTip,% p_id " - " additional
	if (p_ID="")
		return
	
	
	if (additional=false)
	{
		UnmarkEverything(false)
		
		;Mark one element
		if p_ID contains connection
		{
			_flows[FlowID].allConnections[p_ID].marked:=true
		}
		else
		{
			_flows[FlowID].allElements[p_ID].marked:=true
		}
		
		
	}
	else ;if (additional=true)
	{
		if p_ID contains connection
		{
			_flows[FlowID].allConnections[p_ID].marked:=true
		}
		else
		{
			_flows[FlowID].allElements[p_ID].marked:=true
		}
		
		
	}
	
	CreateMarkedList()

	;~ ToolTip("-" p_ID "-" tempList[p_ID].marked "-" markedElement )
	;~ ui_UpdateStatusbartext()
}

;Unmark all elements and connections
UnmarkEverything(CreateList=true)
{
	global _flows 
	global FlowID 
	
	markedElements:=_flows[FlowID].markedElements
	allConnections:=_flows[FlowID].allConnections
	allElements:=_flows[FlowID].allElements
	
	
	
	
	for forID, forElement in allElements ;Add all marked elements into array
	{
		allElements[forID].marked:=false
	}
	for forID, forElement in allConnections ;Add all marked elements into array
	{
		allConnections[forID].marked:=false
	}
	
	if (CreateList)
		CreateMarkedList()
	;~ ui_UpdateStatusbartext()
	
}

MarkEverything()
{
	global _flows
	global FlowID
	
	markedElements:=_flows[FlowID].markedElements
	allConnections:=_flows[FlowID].allConnections
	allElements:=_flows[FlowID].allElements
	
	
	
	for forID, forElement in allElements ;Add all marked elements into array
	{
		allElements[forID].marked:=true
	}
	for forID, forElement in allConnections ;Add all marked elements into array
	{
		allElements[forID].marked:=true
	}
	
	CreateMarkedList()
	
	;~ ui_UpdateStatusbartext()	
}

CreateMarkedList()
{
	global
	;~ SoundBeep
	local markedElementsClone
	markedElements:=_flows[FlowID].markedElements
	allConnections:=_flows[FlowID].allConnections
	allElements:=_flows[FlowID].allElements
	
	markedElementsClone:=markedElements.clone() 
	for forID, forElement in markedElementsClone
	{
		markedElements.delete(forID)
	} 
	
	for forID, forElement in allElements ;Add all marked elements into array
	{
		if (allElements[forID].marked=true)
			markedElements[forID]:=forID
	}
	for forID, forElement in allConnections ;Add all marked elements into array
	{
		if (allConnections[forID].marked=true)
			markedElements[forID]:=forID
	}
	
	if (markedElements.count()=1)
	{
		for forID, forID2 in markedElements
		{
			_flows[FlowID].markedElement:=forID
		}
	}
	else
	{
		;~ ToolTip no element
		_flows[FlowID].markedElement:=""
	}
}