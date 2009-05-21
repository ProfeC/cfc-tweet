<cfcomponent name="Twitter Account Tools" hint="Provides user names and passwords for Twitter accounts that have opted into our service.">

	<cffunction name="getPassword" access="public" output="true" returntype="string">
		<!--- !Arguments --->
		<cfargument name="userName" type="string" required="true" default="" displayname="User Name" hint="Provide the name of the user you need the password for." />
		
		<!--- !search through all provided accounts for the correct password --->
		<cfswitch expression="#arguments.userName#">
			<cfcase value="SHUWebDev">
				<cfset password="xxxxxxxxxxxxxxxx" />
			</cfcase>
			<cfdefaultcase>
				<cfset password="" />
			</cfdefaultcase>
		</cfswitch>
		
		<!--- !Return the password for the provided user name --->
		<cfreturn password />
	</cffunction>

</cfcomponent>