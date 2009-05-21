<cfcomponent name="Twitter Direct Message Coldfusion Tools" hint="Provides functions to send direct messages via the Twitter API v1.x">

	<!--- !Global Variables --->
	<cfparam name="dfltReturnFormat" default="xml" type="string" />
	<cfparam name="dfltUserName" default="SHUWebDev" type="string" />
	<cfparam name="dfltPassword" default="20CamelBak09" type="string" />
	
	<!--- Global Methods --->

	
	<!--- !Direct Message Methods --->
	<cffunction name="statusDestroy" access="remote" output="true" returntype="any">
		<cfreturn "output" />
	</cffunction>

</cfcomponent>