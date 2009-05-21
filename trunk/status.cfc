<cfcomponent name="Twitter Coldfusion Tools" hint="Provides methods to update user statuses and locations via the Twitter API v1.x">
	
	<!--- !Global Variables --->
	<cfset statusURL="http://twitter.com/statuses" />

	<!--- !Update Status --->	
	<cffunction name="update" access="remote" output="no" returntype="any" hint="Updates the authenticating user's status. A status update with text identical to the authenticating user's current status will be ignored to prevent duplicates.">
		
		<!--- !Arguments for updating status. We need a name and a message. ---> 
		<cfargument name="userName" type="string" required="yes" default="" hint="Provide the userName posting this update." displayname="User Name" />
		<cfargument name="status" type="string" required="yes" hint="The text that you  want to set as the status update." displayname="Status Content" />
		
		<!---
<cfset var myStatus="" />
		<cfset var cleanedStatus="#tagStripper(arguments.status,'strip','')#" />
--->
		
		<!--- !Get the password for the Tweetor --->
		<cfinvoke component="accounts" method="getPassword" returnVariable="myPassword">
			<cfinvokeArgument name="userName" value="#arguments.userName#" />
		</cfinvoke>
		
		<!--- !Send Update Request --->
		<cfhttp method="post" url="#statusURL#/update.xml" password="#myPassword#" userName="#arguments.userName#" charset="utf-8" result="myStatusUpdate">
<!--- 			<cfhttpparam type="url" encoded="true" name="status" value="#cleanedStatus#" /> --->
			<cfhttpparam type="url" encoded="true" name="status" value="#arguments.status#" />
		</cfhttp>
		<!--- <cfdump var="#myStatusUpdate#" expand="no" label="myStatusUpdate" /> --->
		
		<!--- !Parse out the return values from the HTTP request --->
		<cfinvoke component="responseCodes" method="returnStatusCode" returnVariable="myStatus">
			<cfinvokeargument name="providedResponse" value="#myStatusUpdate#" />
		</cfinvoke>
		<!--- <cfdump var="#myStatus#" expand="no" label="myStatus" /> --->
		
		<cfif #isXML(myStatus)#>
			<cfinvoke method="parseXML" returnVariable="myStatus">
				<cfinvokeargument name="returnedXML" value="#myStatus#" />
				<cfinvokeargument name="method" value="update" />
			</cfinvoke>
			<cfreturn myStatus />
		<cfelse>
			<cfreturn myStatus />	
		</cfif>
	</cffunction>
	
	<!--- !Show Status by ID --->
	<cffunction name="show" access="remote" output="no" returntype="any" hint="Returns a single status, specified by the id parameter below.  The status's author will be returned inline.">
		<cfargument name="id" type="numeric" required="yes" hint="Provide the id of the status update you want to display" displayname="Status Update ID" />
		<cfargument name="userName" type="string" required="no" default="" hint="Provide the userName posting this update." displayname="User Name" />
		<cfset var myStatus="" />

		<cfif #arguments.userName# is not "">
			<!--- !Get the password for the Tweetor --->
			<cfinvoke component="accounts" method="getPassword" returnVariable="myPassword">
				<cfinvokeArgument name="userName" value="#arguments.userName#" />
			</cfinvoke>		
		</cfif>
		
		<cfhttp method="get" url="#statusURL#/show/#arguments.id#.xml" charset="utf-8" result="myResult" password="#myPassword#" userName="#arguments.userName#" />
		<!--- <cfdump var="#myResult#" expand="no" label="status.cfc HTTP Request" /> --->
		
		<!--- !Parse out the return values from the HTTP request --->
		<cfinvoke component="responseCodes" method="returnStatusCode" returnVariable="myStatus">
			<cfinvokeargument name="providedResponse" value="#myResult#" />
		</cfinvoke>
		<!--- <cfdump var="#myStatus#" expand="no" label="myStatus" /> --->
		
		<cfif #isXML(myStatus)#>
			<cfinvoke method="parseXML" returnVariable="myStatus">
				<cfinvokeargument name="returnedXML" value="#myStatus#" />
				<cfinvokeargument name="method" value="show" />
			</cfinvoke>
			<cfreturn myStatus />
		<cfelse>
			<cfreturn myStatus />	
		</cfif>
	</cffunction>

	<!--- !Destroy Status by ID --->
	<cffunction name="destroy" access="remote" output="no" returntype="any" hint="Destroys the status specified by the required ID parameter.  The authenticating user must be the author of the specified status.">
		<cfargument name="id" type="numeric" required="yes" hint="Provide the id of the status update you want to destroy" displayname="Status Destroy ID" />
		<cfargument name="userName" type="string" required="no" default="" hint="Provide the userName destroying this status message." displayname="User Name" />
		<cfset var myStatus="" />

		<cfif #arguments.userName# is not "">
			<!--- !Get the password for the Tweetor --->
			<cfinvoke component="accounts" method="getPassword" returnVariable="myPassword">
				<cfinvokeArgument name="userName" value="#arguments.userName#" />
			</cfinvoke>		
		</cfif>
		
		<cfhttp method="post" url="#statusURL#/destroy/#arguments.id#.xml" charset="utf-8" result="myResult" password="#myPassword#" userName="#arguments.userName#">
			<cfhttpparam type="url" encoded="true" name="id" value="#arguments.id#" />
		</cfhttp>
		<!--- <cfdump var="#myResult#" expand="no" label="status.cfc HTTP Request" /> --->
		
		<!--- !Parse out the return values from the HTTP request --->
		<cfinvoke component="responseCodes" method="returnStatusCode" returnVariable="myStatus">
			<cfinvokeargument name="providedResponse" value="#myResult#" />
		</cfinvoke>
		<!--- <cfdump var="#myStatus#" expand="no" label="myStatus" /> --->
		
		<cfif #isXML(myStatus)#>
			<cfinvoke method="parseXML" returnVariable="myStatus">
				<cfinvokeargument name="returnedXML" value="#myStatus#" />
				<cfinvokeargument name="method" value="destroy" />
			</cfinvoke>
			<cfreturn myStatus />
		<cfelse>
			<cfreturn myStatus />	
		</cfif>
	</cffunction>

	<cffunction name="parseXML" access="private" output="no" displayname="Parse Returned Status XML" description="This function will parse the XML from a successful HTTP transaction">
		<cfargument name="returnedXML" required="yes" type="xml" displayname="Returned XML" hint="The XML returned from the response code function" />
		<cfargument name="method" required="yes" type="string" displayname="Method Used" hint="The calling function so we can provide the correct language to display." />
		
		<cfset var myXML=#arguments.returnedXML# />
		<cfset var responseSource="#myXML.status.source.xmlText#" /><!--- where this update was posted from --->
		
		<cfswitch expression="#arguments.method#">
			<cfcase value="destroy">
				<cfset myHeading="Successfully Destroyed!" />
				<cfset myImportantMessage="The status has been removed." />
			</cfcase>
			<cfcase value="update">
				<cfset myHeading="Successfully Updated!" />
			<cfif #myXML.status.truncated.xmlText# is "true">
				<cfset myImportantMessage="Your status update was truncated!" />
			</cfif>
			</cfcase>
			<cfcase value="show">
				<cfset myHeading="Showing the status you requested" />
			</cfcase>
		</cfswitch>

		<cfsavecontent variable="responseOutput">
			<!--- <cfdump var="#myXML#" expand="no" label="response.cfc Response XML" /> --->
						
			<cfoutput><h2>#myHeading#</h2>
			</cfoutput>
			<cfif #isDefined("myImportantMessage")#>
				<cfoutput><h3 style="color:##f00; font-weight:bold; font-style:italics">#myImportantMessage#</h3>
				</cfoutput>
			</cfif>
			
			<cfoutput><p>ID: #myXML.status.id.xmlText#<br />
			Date Created: #myXML.status.created_at.xmlText#<br />
			Submitted By: #myXML.status.user.name.xmlText#<br />
			Submitted Text: #myXML.status.text.xmlText#<br />
			
			</p>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn responseOutput />
	</cffunction>
</cfcomponent>