<cfcomponent name="Twitter HTTP Response Codes and Errors" hint="Provides response code and errors from the Twitter API v1.x">

	<cffunction name="returnStatusCode" access="public" output="no" returntype="string" hint="Returns the appropriate data from API generated responses">
<!--- 		<cfargument name="providedCode" required="true" type="string" hint="The HTTP status code provided by the HTTP request" displayname="Provided Status Code" /> --->
		<cfargument name="providedResponse" type="struct" required="yes" hint="The HTTP response provided by the HTTP request" displayname="Provided Response" />
		
		<cfset var argPR="#arguments.providedResponse#" />
		<!--- <cfdump var="#argPR#" expand="no" label="responseCodes.cfc Provided Response" /> --->
		<cfset responseStatusCode="#argPR.statusCode#" />
		<cfset responseErrorDetail="#argPR.errorDetail#" />
		<cfset responseXML=#xmlParse(argPR.fileContent)# />
<!---
		<cfdump var="#myStatusUpdate#" expand="no" label="myStatusUpdate" />
		<cfdump var="#responseXML#" expand="no" />
--->
		
		<cfswitch expression="#argPR.statusCode#">
			<!--- !Status Code 200 --->
			<cfcase value="200 OK">
<!---
				<cfset responseRows=#xmlSearch(responseXML, "//status")# />
				<cfset responseID="#responseXML.status.id.xmlText#" /><!- -- the id of the status update -- ->
				<cfset responseDateCreated="#responseXML.status.created_at.xmlText#" /><!- -- created time stamp -- ->
				<cfset responseText="#responseXML.status.text.xmlText#" /><!- -- submitted text -- ->
				<cfset responseSource="#responseXML.status.source.xmlText#" /><!- -- where this update was posted from -- ->
				<cfset responseTruncated="#responseXML.status.truncated.xmlText#" /><!- -- whether or not this update was truncated -- ->

				<cfsavecontent variable="responseOutput">
					<cfdump var="#argPR#" expand="no" />

					<cfdump var="#responseXML#" expand="no" label="response.cfc Response XML" />
					<cfloop array="#responseRows#" index="i">
						<cfoutput>#i#
						</cfoutput>
					</cfloop>
					
					<cfoutput><h3>Success!</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response ID: #responseID#<br />
					Response Date Created: #responseDateCreated#<br />
					</cfoutput>
					
					<cfif #responseTruncated# is "true">
						<cfoutput><br /><span style="color:##f00; font-weight:bold">Your status update was truncated!</span></br /></cfoutput>
					</cfif>
					
					<cfoutput></p>
					</cfoutput>
				</cfsavecontent>
				
				<cfset myReturnCode="#responseOutput#" />
--->
				<cfset myReturnCode="#responseXML#" />
			</cfcase>

			<!--- !Status Code 304 --->
			<cfcase value="304 Not Modified">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>There was no new data to return.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 400 --->
			<cfcase value="400 Bad Request">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>The request was invalid.  An accompanying error message will explain why. This is the status code will be returned during <a href="http://apiwiki.twitter.com/Rate-limiting" target="_blank">rate limiting</a>.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 401 --->
			<cfcase value="401 Unauthorized">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3><a href="http://apiwiki.twitter.com/Authentication" target="_blank">Authentication credentials</a> were missing or incorrect.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>

			<!--- !Status Code 403 --->
			<cfcase value="403 Forbidden">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>The request is understood, but it has been refused.  An accompanying error message will explain why.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 404 --->
			<cfcase value="404 Not Found">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>The URI requested is invalid or the resource requested, such as a user, does not exists.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 406 --->
			<cfcase value="406 Not Acceptable">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>Returned by the Search API when an invalid format is specified in the request.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 500 --->
			<cfcase value="500 Internal Server Error">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>Something is broken.  Please post <a href="http://apiwiki.twitter.com/Support" target="_blank">to the group</a> so the Twitter team can investigate.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 502 --->
			<cfcase value="502 Bad Gateway">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>Twitter is down or being upgraded.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
			<!--- !Status Code 503 --->
			<cfcase value="503 Service Unavailable">
				<cfset responseRequestURI="#responseXML.hash.request.xmlText#" /><!--- the URL that was requested --->
				<cfset responseReason="#responseXML.hash.error.xmlText#" /><!--- the error message that was returned --->
				
				<cfsavecontent variable="responseOutput">
					<cfoutput><h3>The Twitter servers are up, but overloaded with requests. Try again later. The search and trend methods use this to indicate when you are being <a href="http://apiwiki.twitter.com/Rate-limiting" target="_blank">rate limited</a>.</h3>
					<p>Status Code: #responseStatusCode#<br />
					Response Error Detail: #responseErrorDetail#<br />
					Reason: #responseReason#<br />
					</p>
					</cfoutput>
				</cfsavecontent>
	
				<cfset myReturnCode="#responseOutput#" />
			</cfcase>
			
		</cfswitch>

		
		<cfreturn myReturnCode />
	
	</cffunction>

</cfcomponent>