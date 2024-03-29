<!--- 
- create a form to select different users and give a preview of the text that will be submitted.
- status response should replace the form, if possible.
--->
<cfajaximport tags="cfform,cfdiv,cfwindow" />
<cfparam name="form.step" default="0" type="integer" min="1" max="3" />

<cfoutput><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
	<head>
		<title>Status Update Example Twitter Form</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		</cfoutput>
	<cfoutput></head>
	</cfoutput>
	<cfif #form.step# neq 2>
		<cfoutput><body>
		</cfoutput>
	<cfelse>
		<cfoutput><body onLoad="setTimeout('self.close()',10000)">
		<h2>This window will self close in 10 seconds</h2>
		</cfoutput>
	</cfif>

		<cfdiv style="margin:0; padding:13px auto; background-color:##f7f7f7">
			<cfif #form.step# neq 2>
			<cfparam name="url.rlink" default="" type="string" />
			<cfparam name="url.title" default="" type="string" />
			<cfparam name="url.status" default="" type="string" />
			<cfparam name="url.link" default="http://example.com" type="url" />
			<cfparam name="url.method" default="" type="string" />

			 	<!--- <cfdump var="#url#" expand="no" label="URL Scope" /> --->
				
				<cfform name="sendTweet" action="##" method="post" format="flash" accessible="yes" preloader="yes" timeout="60" width="725" height="420" skin="haloBlue" style="margin:auto 20; fontSize:11; headerColors:##0070ac,##048; backgroundColor:##f7f7f7; headerHeight:35">
					<!--- ##00 70 AC , ##00 44 88  --->
					<cfformitem type="html"><p align="center"><font size="24" color="#ff0000" face="'Trebuchet MS',Arial,Verdana,Sans-Serif">Please double check the tweet before it is submitted...</font></p></cfformitem><!--- since this is a flash form, it has to use HTML 4.01 crap! --->
					<cfformgroup type="hbox">
						<cfformgroup type="panel" width="205" label="Available Accounts" style="color:##fff; cornerRadius:0">
							<cfformitem type="text" style="color:##000">Select the account you want this tweet to be sent to.</cfformitem>
							<cfselect name="userName" label="" required="yes" size="10" multiple="yes" message="Please select at least one user to submit this tweet as." style="color:##000; padding:3px">
								<option value="SHUWebDev">Web Development</option>
								<option value="111">111</option>
								<option value="222">222</option>
								<option value="333">333</option>
								<option value="444">444</option>
								<option value="555">555</option>
								<option value="666">666</option>
								<option value="777">777</option>
								<option value="888">888</option>
								<option value="999">999</option>
								<option value="000">000</option>
							</cfselect>
							<cfformitem type="spacer" height="10" />
						</cfformgroup>
						<cfformgroup type="panel" label="Tweet: #url.title#" style="color:##fff; cornerRadius:0">
							<cfformitem type="text" style="color:##000">Review the tweet to be sent:</cfformitem>
							<cftextarea name="status" label="" height="150" required="yes" message="A status message is required" value="#url.status#" wrap="soft" style="color:##000" />
							<cfformitem type="text" style="color:##000">Auto-generated URL included with the tweet:</cfformitem>
							<cftextarea name="rLink" label="" value="#url.rlink#" height="25" required="no" disabled="yes" wrap="soft" style="color:##000" />
						</cfformgroup>
					</cfformgroup>
					<cfformitem type="spacer" height="10" />
					<cfformgroup type="horizontal"style="horizontalAlign:center">
						<cfinput type="submit" name="btnSubmit" value=" Tweet It! " style="color:##000" />
					</cfformgroup>
					
					<cfinput type="hidden" name="step" value="2" />
					<cfinput type="hidden" name="method" value="update" />
					<cfinput type="hidden" name="link" value="#url.link#" />
				</cfform>
				
			<cfelse>
				<cfset myNewTweet="Testing from home @ #now()#: What happens if this is more than 140 characters? Where does it truncate to? Testing tweets from my CFC 1234567890123456789012345678901234567890" />
				
				<cfswitch expression="#form.method#">
					<cfcase value="update">
						<cfloop list="#form.userName#" index="name">
							<cfinvoke component="status" method="update" returnVariable="myStatusUpdate">
								<cfinvokeArgument name="userName" value="#name#" />
								<cfinvokeargument name="status" value="#form.link# - #form.status#" />
							</cfinvoke>  
							<cfoutput>#myStatusUpdate#						
							</cfoutput>	
						</cfloop>
					</cfcase>
					
					<cfcase value="show">
						<cfoutput><h2>Show Status Info</h2>
						</cfoutput>
						<cfinvoke component="status" method="show" returnVariable="myStatus">
							<cfinvokeargument name="id" value="#url.id#" />
							<cfif #url.name# is not "">
								<cfinvokeargument name="userName" value="#url.name#" />
							</cfif>
						</cfinvoke>
						<cfoutput>#myStatus#
						</cfoutput>	
					</cfcase>
					
					<cfcase value="destroy">
						<cfoutput><h2>Destroy Status Info</h2>
						</cfoutput>
						<cfinvoke component="status" method="destroy" returnVariable="myStatus">
							<cfinvokeargument name="id" value="#url.id#" />
							<cfif #url.name# is not "">
								<cfinvokeargument name="userName" value="#url.name#" />
							</cfif>
						</cfinvoke>
						<cfoutput>#myStatus#
						</cfoutput>	
					</cfcase>
					
					<cfdefaultcase>
						<cfoutput><h1>GET OFF MY LAWN!!!</h1></cfoutput>
					</cfdefaultcase>
				</cfswitch>
				

			</cfif>
		</cfdiv>

	<cfoutput>
	</body>
</html>

</cfoutput>

