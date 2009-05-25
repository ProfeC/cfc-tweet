<cfcomponent name="Twitter Direct Message Coldfusion Tools" hint="Returns a list direct messages sent to the authenticating user. The XML and JSON versions include detailed information about the sending and recipient users via the Twitter API v1.x">

	<!--- !Global Variables --->
	<cfset directMessageURL="http://twitter.com/direct_messages.xml" />
	
	<!--- !Default Direct Message Request --->
	<cffunction name="getDefault" access="remote" output="yes" returntype="any" hint="Returns a list of the 20 most recent direct messages sent to the authenticating user.">
	
	<!--- !Arguments for updating status. We need a name and a message. ---> 
		<cfargument name="userName" type="string" required="yes" default="" hint="Provide the userName posting this update." displayname="User Name" />
		
		<!--- !Get the password for the Tweetor --->
		<cfinvoke component="accounts" method="getPassword" returnVariable="myPassword">
			<cfinvokeArgument name="userName" value="#arguments.userName#" />
		</cfinvoke>
		
		<!--- !Get Messages --->
		<cfhttp method="get" url="#directMessageURL#" password="#myPassword#" userName="#arguments.userName#" charset="utf-8" result="myDirectMessages" />
		<!--- <cfdump var="#myDirectMessages#" expand="no" label="myDirectMessages from directMessages.cfc" /> --->
				
		<!--- !Parse out the return values from the HTTP request --->
		<cfinvoke component="responseCodes" method="returnStatusCode" returnVariable="myStatus">
			<cfinvokeargument name="providedResponse" value="#myDirectMessages#" />
		</cfinvoke>
		<!--- <cfdump var="#myStatus#" expand="no" label="myStatus from directMessages.cfc" /> --->
		
		<!--- Since this is a list of messages, the caller is responsible for parsing the XML. --->
		<cfreturn myStatus />
	</cffunction>

</cfcomponent>