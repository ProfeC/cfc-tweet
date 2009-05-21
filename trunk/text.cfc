<cfcomponent name="Text Conversion Tools" hint="Provides methods to clean up provided text">
	<!--- 
	DISCLAIMER!!!
	I can't remember where I found this, but if you are the originator of this code, please let me know so I can give you credit for it 
	--->
	<cffunction name="tagStripper" access="public" output="no" returntype="string">
	    <cfargument name="source" required="true" type="string">
	    <cfargument name="action" required="false" type="string" default="strip">
	    <cfargument name="tagList" required="false" type="string" default="">
	   
	<!---
	    source = string variable
	        This is the string to be modified
	       
	    action = "preserve" or "strip"
	        This function will either strip all tags except
	        those specified in the tagList argument, or it will
	        preserve all tags except those in the taglist argument.
	        The default action is "strip"
	
	    tagList = string variable
	        This argument contains a comma separated list of tags to be excluded from
	        the action.  If the action is "strip", then these tags won't be stripped.
	        If the action os "preserve", then these tags won't be preserved (ie, only
	        these tags will be stripped)
	       
	    EXAMPLE
	   
	    tagStripper(myString,"strip","b,i")
	   
	    This invocation will strip all html tags except for
	    <b></b> and <i></i>
	--->
	    <cfscript>
	    var str = arguments.source;
	    var i = 1;
	   
	    if (trim(lcase(action)) eq "preserve")
	    {
	        // strip only the exclusions
	        for (i=1;i lte listlen(arguments.tagList); i = i + 1)
	        {
	            tag = listGetAt(tagList,i);
	            str = REReplaceNoCase(str,"</?#tag#.*?>","","ALL");
	        }
	    } else {
	        // if there are exclusions, mark them with NOSTRIP
	        if (tagList neq "")
	        {
	            for (i=1;i lte listlen(tagList); i = i + 1)
	            {
	                tag = listGetAt(tagList,i);
	                str = REReplaceNoCase(str,"<(/?#tag#.*?)>","___TEMP___NOSTRIP___\1___TEMP___ENDNOSTRIP___","ALL");
	            }
	        }
	        str = reReplaceNoCase(str,"</?[A-Z].*?>","","ALL");
	        // convert excluded tags back to normal
	        str = replace(str,"___TEMP___NOSTRIP___","<","ALL");
	        str = replace(str,"___TEMP___ENDNOSTRIP___",">","ALL");
	    }
	   
	    return str;   
	    </cfscript>
	</cffunction>

</cfcomponent>