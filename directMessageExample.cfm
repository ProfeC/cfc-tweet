<!--- 
- create a form to select different users and give a preview of the text that will be submitted.
- status response should replace the form, if possible.
--->
<cfajaximport tags="cfform,cfdiv,cfgrid" />
<cfparam name="form.step" default="0" type="integer" min="1" max="3" />

<cfoutput><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
	<head>
		<title>Direct Message Example Twitter Form</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		</cfoutput>
	<cfoutput></head>
	</cfoutput>
	<cfif #form.step# neq 2>
		<cfoutput><body>
		</cfoutput>
	<cfelse>
		<cfoutput><body>
		<h2>Here are the messages you requested...</h2>
		</cfoutput>
	</cfif>

		<cfdiv style="margin:0; padding:13px auto; background-color:##f7f7f7">
			<cfform name="sendTweet" action="##" method="post" format="flash" accessible="yes" preloader="yes" timeout="60" width="725" height="420" skin="haloBlue" style="margin:auto 20; fontSize:11; headerColors:##0070ac,##048; backgroundColor:##f7f7f7; headerHeight:35">
				<!--- ##00 70 AC , ##00 44 88  --->
				<cfformitem type="html"><p align="center"><font size="24" color="#ff0000" face="'Trebuchet MS',Arial,Verdana,Sans-Serif">Please select the user you want direct messages for...</font></p></cfformitem><!--- since this is a flash form, it has to use HTML 4.01 crap! --->
				<cfformgroup type="hbox">
					<cfformgroup type="panel" width="205" label="Available Accounts" style="color:##fff; cornerRadius:0">
						<cfformitem type="text" style="color:##000">Select the account you want this tweet to be sent to.</cfformitem>
						<cfselect name="userName" label="" required="yes" size="10" multiple="yes" message="Please select at least one user to submit this tweet as." style="color:##000; padding:3px">
							<option value="SHUWebDev">Web Development</option>
							<option value="ProfeC">Lee</option>
							<option value="222">222</option>
							<option value="333">333</option>
						</cfselect>
						<cfformitem type="spacer" height="10" />
					</cfformgroup>
					<cfformgroup type="panel" label="Direct Messages" style="color:##fff; cornerRadius:0">
						<!--- <cftextarea name="directMesssages" label="" height="250" required="no" wrap="soft" style="color:##000" disabled="yes"> --->
							<cfif #form.step# neq 2>
								<cfformitem type="html" enabled="no"><h1>Message will show here...</h1>
								</cfformitem>
							<cfelse>
								<cfgrid name="results" format="html" autoWidth="yes" stripeRows="yes" style="color:##000" bindOnLoad="no" bind="cfc:directMessage.getDefault({form.userName},{cfgridpage},{cfgridpagesize},
            {cfgridsortcolumn},{cfgridsortdirection})">
									<cfgridcolumn name="any" header="Any" />
<!---
									<cfgridcolumn name="from" header="From" />
									<cfgridcolumn name="text" header="Text" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
									<cfgridrow data="#now()#,me,<h1>GET OFF MY LAWN!!!</h1>" />
--->
								</cfgrid>
							</cfif>
						<!--- </cftextarea> --->
					</cfformgroup>
				</cfformgroup>
				<cfformitem type="spacer" height="10" />
				<cfformgroup type="horizontal"style="horizontalAlign:center">
					<cfinput type="submit" name="btnSubmit" value=" Get Messages! " style="color:##000" />
				</cfformgroup>
				
				<cfinput type="hidden" name="step" value="2" />
			</cfform>
		</cfdiv>
	<cfoutput>
	</body>
</html>

</cfoutput>

