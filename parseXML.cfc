<cfcomponent name="Generic XML Paser for Twitter Responses" hint="Parses the XML output from the Twitter API v1.x">

	<cffunction name="status" access="public" output="no" displayname="Parse Returned Status XML" description="This function will parse the XML from a successful HTTP transaction">
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

	<cffunction name="directMessage" access="public" output="yes" displayname="Parse Returned Direct Message XML" description="This function will parse the XML from a successful HTTP Direct Message transaction">
		<cfargument name="returnedXML" required="yes" type="xml" displayname="Returned XML" hint="The XML returned from the response code function" />
		<cfargument name="method" required="no" type="string" displayname="Method Used" hint="The calling function so we can provide the correct language to display." />
		
		<cfset var myXML=#xmlParse(arguments.returnedXML)# />
		<cfset var messageCount=#arrayLen(myXML['direct-messages'].direct_message)# />
		<cfdump var="#myXML['direct-messages']#" expand="yes" />

		<cfsavecontent variable="responseOutput">
			<cfloop from="1" to="#messageCount#" index="i">
				<cfoutput>#myXML.xmlName.xmlChildren[i].id.xmlText#</cfoutput>
			</cfloop>
		</cfsavecontent>
		
		<cfreturn responseOutput />
		<!---
		<cfset var responseSource="#myXML.direct-messages.direct_message.xmlText#" /><!- -- where this update was posted from -- ->
		
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
			<!- -- <cfdump var="#myXML#" expand="no" label="response.cfc Response XML" /> -- ->
						
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
		--->
	</cffunction>

</cfcomponent>