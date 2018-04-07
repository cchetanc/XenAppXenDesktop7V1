﻿#Requires -Version 3.0
#This File is in Unicode format.  Do not edit in an ASCII editor.

#region help text

<#
.SYNOPSIS
	Creates an inventory of a Citrix XenDesktop 7.0 through 7.7 Site.
.DESCRIPTION
	Creates an inventory of a Citrix XenDesktop 7.0 through 7.7 Site using Microsoft 
	PowerShell, Word, plain text or HTML.
	
	This script requires at least PowerShell version 3 but runs best in version 5.

	Word is NOT needed to run the script. This script will output in Text and HTML.
	
	You do NOT have to run this script on a Controller. This script was developed and run 
	from a Windows 8.1 VM.
	
	You can run this script remotely using the -AdminAddress (AA) parameter.
	
	This script supports versions of XenApp/XenDesktop from 7.0 to 7.7. 
	Version 7.8+ is a separate script.
	
	By default, only gives summary information for:
		Administrators
		Applications
		Delivery Groups
		Hosting
		Logging
		Machine Catalogs
		Policies
		StoreFront

	The Summary information is what is shown in the top half of Citrix Studio for:
		Machine Catalogs
		Delivery Groups
		Applications
		Policies
		Logging
		Administrators
		Hosting
		StoreFront

	Using the MachineCatalogs parameter can cause the report to take a very long time to 
	complete and can generate an extremely long report.
	
	Using the DeliveryGroups parameter can cause the report to take a very long time to 
	complete and can generate an extremely long report.

	Using both the MachineCatalogs and DeliveryGroups parameters can cause the report to 
	take an extremely long time to complete and generate an exceptionally long report.

	Creates an output file named after the XenDesktop 7.x Site.
	
	Word and PDF Document includes a Cover Page, Table of Contents and Footer.
	Includes support for the following language versions of Microsoft Word:
		Catalan
		Chinese
		Danish
		Dutch
		English
		Finnish
		French
		German
		Norwegian
		Portuguese
		Spanish
		Swedish
		
.PARAMETER AdminAddress
	Specifies the address of a XenDesktop controller the PowerShell snapins will connect 
	to. 
	This can be provided as a host name or an IP address. 
	This parameter defaults to LocalHost.
	This parameter has an alias of AA.
.PARAMETER CompanyAddress
	Company Address to use for the Cover Page, if the Cover Page has the Address field.
	
	The following Cover Pages have an Address field:
		Banded (Word 2013/2016)
		Contrast (Word 2010)
		Exposure (Word 2010)
		Filigree (Word 2013/2016)
		Ion (Dark) (Word 2013/2016)
		Retrospect (Word 2013/2016)
		Semaphore (Word 2013/2016)
		Tiles (Word 2010)
		ViewMaster (Word 2013/2016)
		
	This parameter is only valid with the MSWORD and PDF output parameters.
	This parameter has an alias of CA.
.PARAMETER CompanyEmail
	Company Email to use for the Cover Page, if the Cover Page has the Email field.  
	
	The following Cover Pages have an Email field:
		Facet (Word 2013/2016)
	
	This parameter is only valid with the MSWORD and PDF output parameters.
	This parameter has an alias of CE.
.PARAMETER CompanyFax
	Company Fax to use for the Cover Page, if the Cover Page has the Fax field.  
	
	The following Cover Pages have a Fax field:
		Contrast (Word 2010)
		Exposure (Word 2010)
	
	This parameter is only valid with the MSWORD and PDF output parameters.
	This parameter has an alias of CF.
.PARAMETER CompanyName
	Company Name to use for the Cover Page.  
	The default value is contained in 
	HKCU:\Software\Microsoft\Office\Common\UserInfo\CompanyName or
	HKCU:\Software\Microsoft\Office\Common\UserInfo\Company, whichever is populated 
	on the computer running the script.
	This parameter has an alias of CN.
.PARAMETER CompanyPhone
	Company Phone to use for the Cover Page, if the Cover Page has the Phone field.  
	
	The following Cover Pages have a Phone field:
		Contrast (Word 2010)
		Exposure (Word 2010)
	
	This parameter is only valid with the MSWORD and PDF output parameters.
	This parameter has an alias of CPh.
.PARAMETER CoverPage
	What Microsoft Word Cover Page to use.
	Only Word 2010, 2013 and 2016 are supported.
	(default cover pages in Word en-US)

	Valid input is:
		Alphabet (Word 2010. Works)
		Annual (Word 2010. Doesn't work well for this report)
		Austere (Word 2010. Works)
		Austin (Word 2010/2013/2016. Doesn't work in 2013 or 2016, mostly 
		works in 2010 but Subtitle/Subject & Author fields need to be moved 
		after title box is moved up)
		Banded (Word 2013/2016. Works)
		Conservative (Word 2010. Works)
		Contrast (Word 2010. Works)
		Cubicles (Word 2010. Works)
		Exposure (Word 2010. Works if you like looking sideways)
		Facet (Word 2013/2016. Works)
		Filigree (Word 2013/2016. Works)
		Grid (Word 2010/2013/2016. Works in 2010)
		Integral (Word 2013/2016. Works)
		Ion (Dark) (Word 2013/2016. Top date doesn't fit; box needs to be 
		manually resized or font changed to 8 point)
		Ion (Light) (Word 2013/2016. Top date doesn't fit; box needs to be 
		manually resized or font changed to 8 point)
		Mod (Word 2010. Works)
		Motion (Word 2010/2013/2016. Works if top date is manually changed to 
		36 point)
		Newsprint (Word 2010. Works but date is not populated)
		Perspective (Word 2010. Works)
		Pinstripes (Word 2010. Works)
		Puzzle (Word 2010. Top date doesn't fit; box needs to be manually 
		resized or font changed to 14 point)
		Retrospect (Word 2013/2016. Works)
		Semaphore (Word 2013/2016. Works)
		Sideline (Word 2010/2013/2016. Doesn't work in 2013 or 2016, works in 
		2010)
		Slice (Dark) (Word 2013/2016. Doesn't work)
		Slice (Light) (Word 2013/2016. Doesn't work)
		Stacks (Word 2010. Works)
		Tiles (Word 2010. Date doesn't fit unless changed to 26 point)
		Transcend (Word 2010. Works)
		ViewMaster (Word 2013/2016. Works)
		Whisp (Word 2013/2016. Works)

	The default value is Sideline.
	This parameter has an alias of CP.
	This parameter is only valid with the MSWORD and PDF output parameters.
.PARAMETER UserName
	User name to use for the Cover Page and Footer.
	The default value is contained in $env:username
	This parameter has an alias of UN.
	This parameter is only valid with the MSWORD and PDF output parameters.
.PARAMETER HTML
	Creates an HTML file with an .html extension.
	This parameter is disabled by default.
.PARAMETER MSWord
	SaveAs DOCX file
	This parameter is set True if no other output format is selected.
.PARAMETER PDF
	SaveAs PDF file instead of DOCX file.
	This parameter is disabled by default.
	The PDF file is roughly 5X to 10X larger than the DOCX file.
	This parameter requires Microsoft Word to be installed.
	This parameter uses the Word SaveAs PDF capability.
.PARAMETER Text
	Creates a formatted text file with a .txt extension.
	This parameter is disabled by default.
.PARAMETER Administrators
	Give detailed information for Administrator Scopes and Roles.
	This parameter is disabled by default.
	This parameter has an alias of Admins.
.PARAMETER Applications
	Gives detailed information for all applications.
	This parameter is disabled by default.
	This parameter has an alias of Apps.
.PARAMETER DeliveryGroups
	Gives detailed information for all desktops in all Desktop (Delivery) Groups.
	
	Using the DeliveryGroups parameter can cause the report to take a very long 
	time to complete and can generate an extremely long report.
	
	Using both the MachineCatalogs and DeliveryGroups parameters can cause the 
	report to take an extremely long time to complete and generate an exceptionally 
	long report.
	
	This parameter is disabled by default.
	This parameter has an alias of DG.
.PARAMETER DeliveryGroupsUtilization
	Gives a chart with the delivery group utilization for the last 7 days 
	depending on the information in the database.
	
	This option is only available when the report is generated in Word and requires 
	Micosoft Excel to be locally installed.
	
	Using the DeliveryGroupsUtilization parameter causes the report to take a longer 
	time to complete and generates a longer report.
	
	This parameter is disabled by default.
	This parameter has an alias of DGU.
.PARAMETER Hosting
	Give detailed information for Hosts, Host Connections and Resources.
	This parameter is disabled by default.
	This parameter has an alias of Host.
.PARAMETER Logging
	Give the Configuration Logging report with, by default, details for the previous 
	seven days.
	This parameter is disabled by default.
.PARAMETER StartDate
	Start date for the Configuration Logging report.
	
	Format for date only is MM/DD/YYYY.
	
	Format to include a specific time range is "MM/DD/YYYY HH:MM:SS" in 24 hour format.
	The double quotes are needed.
	
	The default is today's date minus seven days.
	This parameter has an alias of SD.
.PARAMETER EndDate
	End date for the Configuration Logging report.
	
	Format for date only is MM/DD/YYYY.
	
	Format to include a specific time range is "MM/DD/YYYY HH:MM:SS" in 24 hour format.
	The double quotes are needed.
	
	The default is today's date.
	This parameter has an alias of ED.
.PARAMETER MachineCatalogs
	Gives detailed information for all machines in all Machine Catalogs.
	
	Using the MachineCatalogs parameter can cause the report to take a very long 
	time to complete and can generate an extremely long report.
	
	Using both the MachineCatalogs and DeliveryGroups parameters can cause the 
	report to take an extremely long time to complete and generate an exceptionally 
	long report.
	
	This parameter is disabled by default.
	This parameter has an alias of MC.
.PARAMETER MaxDetails
	Adds maximum detail to the report.
	
	This is the same as using the following parameters:
		Administrators
		Applications
		DeliveryGroups
		HardWare
		Hosting
		Logging
		MachineCatalogs
		Policies
		StoreFront

	Does not change the value of NoADPolicies.
	
	WARNING: Using this parameter can create an extremely large report and 
	can take a very long time to run.

	This parameter has an alias of MAX.
.PARAMETER Policies
	Give detailed information for both Site and Citrix AD based Policies.
	
	Using the Policies parameter can cause the report to take a very long time 
	to complete and can generate an extremely long report.
	
	There are three related parameters: Policies, NoPolicies and NoADPolicies.
	
	Policies and NoPolicies are mutually exclusive and priority is given to NoPolicies.
	
	Using both Policies and NoADPolicies results in only policies created in Studio
	being in the output document.
	
	This parameter is disabled by default.
	This parameter has an alias of Pol.
.PARAMETER NoPolicies
	Excludes all Site and Citrix AD based policy information from the output document.
	
	Using the NoPolicies parameter will cause the Policies parameter to be set to False.
	
	This parameter is disabled by default.
	This parameter has an alias of NP.
.PARAMETER NoADPolicies
	Excludes all Citrix AD based policy information from the output document.
	Includes only Site policies created in Studio.
	
	This switch is useful in large AD environments, where there may be thousands
	of policies, to keep SYSVOL from being searched.
	
	This parameter is disabled by default.
	This parameter has an alias of NoAD.
.PARAMETER StoreFront
	Give detailed information for StoreFront.
	This parameter is disabled by default.
	This parameter has an alias of SF.
.PARAMETER AddDateTime
	Adds a date time stamp to the end of the file name.
	Time stamp is in the format of yyyy-MM-dd_HHmm.
	June 1, 2018 at 6PM is 2018-06-01_1800.
	Output filename will be ReportName_2018-06-01_1800.docx (or .pdf).
	This parameter is disabled by default.
	This parameter has an alias of ADT.
.PARAMETER Folder
	Specifies the optional output folder to save the output report. 
.PARAMETER Hardware
	Use WMI to gather hardware information on: Computer System, Disks, Processor and 
	Network Interface Cards

	This parameter may require the script be run from an elevated PowerShell session 
	using an account with permission to retrieve hardware information (i.e. Domain Admin 
	or Local Administrator).

	Selecting this parameter will add to both the time it takes to run the script and 
	size of the report.

	This parameter is disabled by default.
	This parameter has an alias of HW.
.PARAMETER Section
	Processes a specific section of the report.
	Valid options are:
		Admins (Administrators)
		Apps (Applications)
		AppV
		Catalogs (Machine Catalogs)
		Config (Configuration)
		Controllers
		Groups (Delivery Groups)
		Hosting
		Licensing
		Logging
		Policies
		StoreFront
		Zones
		All
	This parameter defaults to All sections.
	
	Notes:
	Using Logging will force the Logging switch to True.
	Using Policies will force the Policies switch to True.
	If Policies is selected and the NoPolicies switch is used, the script will terminate.
	
.PARAMETER SmtpServer
	Specifies the optional email server to send the output report. 
.PARAMETER SmtpPort
	Specifies the SMTP port. 
	The default is 25.
.PARAMETER UseSSL
	Specifies whether to use SSL for the SmtpServer.
	The default is False.
.PARAMETER From
	Specifies the username for the From email address.
	If SmtpServer is used, this is a required parameter.
.PARAMETER To
	Specifies the username for the To email address.
	If SmtpServer is used, this is a required parameter.
.PARAMETER Dev
	Clears errors at the beginning of the script.
	Outputs all errors to a text file at the end of the script.
	
	This is used when the script developer requests more troubleshooting data.
	Text file is placed in the same folder from where the script is run.
	
	This parameter is disabled by default.
.PARAMETER ScriptInfo
	Outputs information about the script to a text file.
	Text file is placed in the same folder from where the script is run.
	
	This parameter is disabled by default.
	This parameter has an alias of SI.
.PARAMETER Log
	Generates a log file for troubleshooting.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1
	
	Will use all default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	The computer running the script for the AdminAddress.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -AdminAddress DDC01
	
	Will use all default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	DDC01 for the AdminAddress.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -PDF
	
	Will use all default values and save the document as a PDF file.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	The computer running the script for the AdminAddress.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -TEXT

	Will use all default values and save the document as a formatted text file.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -HTML

	Will use all default values and save the document as an HTML file.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -MachineCatalogs
	
	Creates a report with full details for all machines in all Machine Catalogs.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -DeliveryGroups
	
	Creates a report with full details for all desktops in all Desktop (Delivery) Groups.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -DeliveryGroupsUtilization
	
	Creates a report with utilization details for all Desktop (Delivery) Groups.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -DeliveryGroups -MachineCatalogs
	
	Creates a report with full details for all machines in all Machine Catalogs and 
	all desktops in all Delivery Groups.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Applications
	
	Creates a report with full details for all applications.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Policies
	
	Creates a report with full details for Policies.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -NoPolicies
	
	Creates a report with no Policy information.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -NoADPolicies
	
	Creates a report with no Citrix AD based Policy information.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Policies -NoADPolicies
	
	Creates a report with full details on Site policies created in Studio but 
	no Citrix AD based Policy information.
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Administrators
	
	Creates a report with full details on Administrator Scopes and Roles.
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Logging -StartDate 01/01/2018 -EndDate 01/31/2018
	
	Creates a report with Configuration Logging details for the dates 01/01/2018 through 
	01/31/2018.
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Logging -StartDate "06/01/2018 10:00:00" -EndDate 
	"06/01/2018 14:00:00"
	
	Creates a report with Configuration Logging details for the time range 
	06/01/2018 10:00:00AM through 06/01/2018 02:00:00PM.
	
	Narrowing the report down to seconds does not work. Seconds must be either 00 or 59.
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Hosting
	
	Creates a report with full details for Hosts, Host Connections and Resources.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -StoreFront
	
	Creates a report with full details for StoreFront.
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -MachineCatalogs -DeliveryGroups -Applications 
	-Policies -Hosting -StoreFront
	
	Creates a report with full details for all:
		Machines in all Machine Catalogs
		Desktops in all Delivery Groups
		Applications
		Policies
		Hosts, Host Connections and Resources
		StoreFront
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -MC -DG -Apps -Policies -Hosting
	
	Creates a report with full details for all:
		Machines in all Machine Catalogs
		Desktops in all Delivery Groups
		Applications
		Policies
		Hosts, Host Connections and Resources
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript .\XD7_Inventory.ps1 -CompanyName "Carl Webster Consulting" 
	-CoverPage "Mod" -UserName "Carl Webster" -AdminAddress DDC01

	Will use:
		Carl Webster Consulting for the Company Name.
		Mod for the Cover Page format.
		Carl Webster for the User Name.
		Controller named DDC01 for the AdminAddress.
.EXAMPLE
	PS C:\PSScript .\XD7_Inventory.ps1 -CN "Carl Webster Consulting" -CP "Mod" -UN 
	"Carl Webster"

	Will use:
		Carl Webster Consulting for the Company Name (alias CN).
		Mod for the Cover Page format (alias CP).
		Carl Webster for the User Name (alias UN).
		The computer running the script for the AdminAddress.
.EXAMPLE
	PS C:\PSScript .\XD7_Inventory.ps1 -CompanyName "Sherlock Holmes Consulting" `
	-CoverPage Exposure -UserName "Dr. Watson" `
	-CompanyAddress "221B Baker Street, London, England" `
	-CompanyFax "+44 1753 276600" `
	-CompanyPhone "+44 1753 276200"

	Will use:
		Sherlock Holmes Consulting for the Company Name.
		Exposure for the Cover Page format.
		Dr. Watson for the User Name.
		221B Baker Street, London, England for the Company Address.
		+44 1753 276600 for the Company Fax.
		+44 1753 276200 for the Compnay Phone.
.EXAMPLE
	PS C:\PSScript .\XD7_Inventory.ps1 -CompanyName "Sherlock Holmes Consulting" `
	-CoverPage Facet -UserName "Dr. Watson" `
	-CompanyEmail SuperSleuth@SherlockHolmes.com

	Will use:
		Sherlock Holmes Consulting for the Company Name.
		Facet for the Cover Page format.
		Dr. Watson for the User Name.
		SuperSleuth@SherlockHolmes.com for the Compnay Email.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -AddDateTime
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.

	Adds a date time stamp to the end of the file name.
	Time stamp is in the format of yyyy-MM-dd_HHmm.
	June 1, 2018 at 6PM is 2018-06-01_1800.
	Output filename will be XD7SiteName_2018-06-01_1800.docx
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -PDF -AddDateTime
	
	Will use all Default values and save the document as a PDF file.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.

	Adds a date time stamp to the end of the file name.
	Time stamp is in the format of yyyy-MM-dd_HHmm.
	June 1, 2018 at 6PM is 2018-06-01_1800.
	Output filename will be XD7SiteName_2018-06-01_1800.pdf
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Hardware
	
	Will use all default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Folder \\FileServer\ShareName
	
	Will use all default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	
	Output file will be saved in the path \\FileServer\ShareName
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -SmtpServer mail.domain.tld -From 
	XDAdmin@domain.tld -To ITGroup@domain.tld
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	
	Script will use the email server mail.domain.tld, sending from XDAdmin@domain.tld, 
	sending to ITGroup@domain.tld.
	Script will use the default SMPTP port 25 and will not use SSL.
	If the current user's credentials are not valid to send email, the user will be prompted 
	to enter valid credentials.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -SmtpServer smtp.office365.com -SmtpPort 587 
	-UseSSL -From Webster@CarlWebster.com -To ITGroup@CarlWebster.com
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	
	Script will use the email server smtp.office365.com on port 587 using SSL, sending from 
	webster@carlwebster.com, sending to ITGroup@carlwebster.com.
	If the current user's credentials are not valid to send email, the user will be prompted 
	to enter valid credentials.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Section Policies
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	Processes only the Policies section of the report.
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -MaxDetails
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or 
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	
	Set the following parameter values:
		Administrators      = True
		Applications        = True
		DeliveryGroups      = True
		HardWare            = True
		Hosting             = True
		Logging             = True
		MachineCatalogs     = True
		Policies            = True
		StoreFront          = True
		
		NoPolicies          = False
		Section             = "All"
.EXAMPLE
	PS C:\PSScript > .\XD7_Inventory.ps1 -Dev -ScriptInfo -Log
	
	Will use all Default values.
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\CompanyName="Carl 
	Webster" or 
	HKEY_CURRENT_USER\Software\Microsoft\Office\Common\UserInfo\Company="Carl Webster"
	$env:username = Administrator

	Carl Webster for the Company Name.
	Sideline for the Cover Page format.
	Administrator for the User Name.
	
	Creates a text file named XAXDV1InventoryScriptErrors_yyyy-MM-dd_HHmm.txt that 
	contains up to the last 250 errors reported by the script.
	
	Creates a text file named XAXDV1InventoryScriptInfo_yyyy-MM-dd_HHmm.txt that 
	contains all the script parameters and other basic information.
	
	Creates a text file for transcript logging named 
	XDV1DocScriptTranscript_yyyy-MM-dd_HHmm.txt.
.INPUTS
	None.  You cannot pipe objects to this script.
.OUTPUTS
	No objects are output from this script.  This script creates a Word, PDF
	plain text or HTML document.
.NOTES
	NAME: XD7_Inventory.ps1
	VERSION: 1.40.1
	AUTHOR: Carl Webster
	LASTEDIT: March 10, 2018
#>

#endregion

#region script parameters
#thanks to @jeffwouters and Michael B. Smith for helping me with these parameters
[CmdletBinding(SupportsShouldProcess = $False, ConfirmImpact = "None", DefaultParameterSetName = "Word") ]

Param(
	[parameter(Mandatory=$False)] 
	[ValidateNotNullOrEmpty()]
	[Alias("AA")]
	[string]$AdminAddress="LocalHost",

	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CA")]
	[ValidateNotNullOrEmpty()]
	[string]$CompanyAddress="",
    
	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CE")]
	[ValidateNotNullOrEmpty()]
	[string]$CompanyEmail="",
    
	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CF")]
	[ValidateNotNullOrEmpty()]
	[string]$CompanyFax="",
    
	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CN")]
	[ValidateNotNullOrEmpty()]
	[string]$CompanyName="",
    
	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CPh")]
	[ValidateNotNullOrEmpty()]
	[string]$CompanyPhone="",
    
	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("CP")]
	[ValidateNotNullOrEmpty()]
	[string]$CoverPage="Sideline", 

	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Alias("UN")]
	[ValidateNotNullOrEmpty()]
	[string]$UserName=$env:username,

	[parameter(ParameterSetName="HTML",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Switch]$HTML=$False,

	[parameter(ParameterSetName="Word",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Switch]$MSWord=$False,

	[parameter(ParameterSetName="PDF",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Switch]$PDF=$False,

	[parameter(ParameterSetName="Text",Mandatory=$False)] 
	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[Switch]$Text=$False,

	[parameter(Mandatory=$False)] 
	[Alias("Admins")]
	[Switch]$Administrators=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("Apps")]
	[Switch]$Applications=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("DG")]
	[Switch]$DeliveryGroups=$False,	

	[parameter(Mandatory=$False)] 
	[Alias("DGU")]
	[Switch]$DeliveryGroupsUtilization=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("Host")]
	[Switch]$Hosting=$False,	
	
	[parameter(Mandatory=$False)] 
	[Switch]$Logging=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("SD")]
	[Datetime]$StartDate = ((Get-Date -displayhint date).AddDays(-7)),

	[parameter(Mandatory=$False)] 
	[Alias("ED")]
	[Datetime]$EndDate = (Get-Date -displayhint date),
	
	[parameter(Mandatory=$False)] 
	[Alias("MC")]
	[Switch]$MachineCatalogs=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("MAX")]
	[Switch]$MaxDetails=$False,

	[parameter(Mandatory=$False)] 
	[Alias("Pol")]
	[Switch]$Policies=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("NP")]
	[Switch]$NoPolicies=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("NoAD")]
	[Switch]$NoADPolicies=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("SF")]
	[Switch]$StoreFront=$False,	
	
	[parameter(Mandatory=$False)] 
	[Alias("ADT")]
	[Switch]$AddDateTime=$False,
	
	[parameter(Mandatory=$False)] 
	[string]$Folder="",
	
	[parameter(Mandatory=$False)] 
	[Alias("HW")]
	[Switch]$Hardware=$False,

	[parameter(Mandatory=$False)] 
	[string]$Section="All",
	
	[parameter(ParameterSetName="SMTP",Mandatory=$True)] 
	[string]$SmtpServer="",

	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[int]$SmtpPort=25,

	[parameter(ParameterSetName="SMTP",Mandatory=$False)] 
	[switch]$UseSSL=$False,

	[parameter(ParameterSetName="SMTP",Mandatory=$True)] 
	[string]$From="",

	[parameter(ParameterSetName="SMTP",Mandatory=$True)] 
	[string]$To="",

	[parameter(Mandatory=$False)] 
	[Switch]$Dev=$False,
	
	[parameter(Mandatory=$False)] 
	[Alias("SI")]
	[Switch]$ScriptInfo=$False,
	
	[parameter(Mandatory=$False)] 
	[Switch]$Log=$False
	
	)
#endregion

#region script change log	
#webster@carlwebster.com
#@carlwebster on Twitter
#http://www.CarlWebster.com
#Created on October 20, 2013

# Version 1.0 released to the community on June 12, 2015

# Version 1.1 release June 29, 2015
#	For Policies, change Filter(s) to "Assigned to" to match what is shown in Studio.
#	For Policies, change the text "HDX Policy" to Policies to match what is shown in Studio,
#	In Machine Catalog HTML output, removed two unneeded lines
#	Add Machine Catalog summary table to beginning of section
#	Add Delivery Group summary table to beginning of section
#	In Delivery Group Word/PDF output, add in missing Machine type
#	Begin Delivery Group data on new page for Word/PDF output
#	In Delivery Group details, add:
#		AutomaticPowerOnForAssigned
#		AutomaticPowerOnForAssingedDuringPeak
#		Extended Power Management Settings:
#			During peak extended hours, when disconnected
#			During off-peak extended hours, when disconnected
#	Note: The previous four settings can only be set via PowerShell and are not shown in Studio
#	In Delivery Group, add Desktops:
#		Available
#		In USe
#		Never Registered
#		Preparing
#	In Delivery Group Details:
#		Fix display of State (Enabled, Disabled or Maintenance mode)
#		Add Description
#		Add Display Name
#		Add Color Depth
#		Add ShutdownDesktops After Use
#		Add Turn On Added Machine
#	For Hosting details, add Sessions
#	For Hosting details, begin Desktop OS, Server OS and Sessions data on new pages for Word/PDF output
#	Added new parameter, Administrators (Admins), to get full administrator details.
#	Added for Administrator Scopes, Objects and Administrators
#	Added for Administrator Roles, Role definition and Administrators.
#	Fix numerous typos
#	Removed all 449 references to the unused variable $CurrentServiceIndex
#
#Version 1.11
#	Add in updated hardware inventory code
#	Updated help text
#
#Version 1.12 5-Oct-2015
#	Added support for Word 2016
#
#Version 1.13 28-Dec-2015
#	Tested with version 7.7 and 7.6 FP3
#	Fixed several typos
#	Added "Hosting Server Name" to machine/desktop details
#	Added support for VDA version 7.7
#	Added policy setting ICA\Desktop launches [overlooked from initial script creation]
#	Added policy setting ICA\Adobe Flash Delivery\Flash Redirection\Flash video fallback prevention [new with 7.6 FP3]
#	Added policy setting ICA\Adobe Flash Delivery\Flash Redirection\Flash video fallback prevention error *.swf [new with 7.6 FP3]
#	Added policy setting ICA\File Redirection\Allow file transfer between desktop and client [new with 7.6 FP3]
#	Added policy setting ICA\File Redirection\Download file from desktop [new with 7.6 FP3]
#	Added policy setting ICA\File Redirection\Upload file to desktop [new with 7.6 FP3]
#	Added policy setting ICA\Graphics\Use video codec for compression [new with 7.6 FP3]
#	Added policy setting ICA\Graphics\Framehawk\Framehawk display channel [new with 7.6 FP3]
#	Added policy setting ICA\Graphics\Framehawk\Framehawk display channel port range [new with 7.6 FP3]
#	Added policy setting ICA\Multimedia\Windows media fallback prevention [new with 7.6 FP3] 
#	Added policy setting ICA\USB devices\Client USB device optimization rules [new with 7.6 FP3]
#	Added policy setting ICA\Visual Display\Preferred color depth for simple graphics [new with 7.6 FP3]
#	Renamed policy setting ICA\Multimedia\Optimization for Windows Media multimedia redirection to ICA\Multimedia\Optimization for Windows Media multimedia redirection over WAN
#	Renamed policy setting ICA\Multimedia\Use GPU for optimizing Windows Media multimedia redirection to ICA\Multimedia\Use GPU for optimizing Windows Media multimedia redirection over WAN
#	Added Zone section
#	Added Zones to Machine Catalog details
#	Added Zones to Hosting Connection details
#	Fixed the way Scopes are reported for Machine Catalogs
#
#Version 1.14 9-Feb-2016
#	Added specifying an optional output folder
#	Added the option to email the output file
#	Fixed several spacing and typo errors
#	Fixed output to HTML with -AddDateTime parameter
#	Add Section parameter
#		Valid Section options are:
#			Admins (Administrators)
#			Apps (Applications)
#			AppV
#			Catalogs (Machine Catalogs)
#			Config (Configuration)
#			Controllers
#			Groups (Delivery Groups)
#			Hosting
#			Licensing
#			Logging
#			Policies
#			StoreFront
#			Zones
#			All
#
#Version 1.15 29-Feb-2016
#	Fixed the remaining $Null comparison issues
#	Fixed a typo keeping the AlwaysCache policy setting from working
#	Fixed an issue where Manual Provisioning and Not RemotePC Machine Catalogs were missing from Word and Text output (thanks to Michael Foster)
#
#Version 1.16 17-Mar-2016
#	Fixed Zone information showing in the Hosting section for all XA/XD versions
#	For the Monitoring Database, show details and Grooming Retention Settings (for Jeremy Saunders)
#
#Version 1.17 19-Apr-2016
#	Add check to make sure script is not run on Version 7.8 or later
#	Add server machine details
#	Fixed, for desktop machine details text and HTML output, Session User Name was incorrect.
#
#Version 1.20 4-May-2016
#	Added -Dev parameter to create a text file of script errors
#	Added -ScriptInfo (SI) parameter to create a text file of script information
#	Added more script information to the console output when script starts
#	Changed from using arrays to populating data in tables to strings
#	Cleaned up some issues in the help text
#	Color variables needed to be [long] and not [int] except for $wdColorBlack which is 0
#	Fixed numerous issues discovered with the latest update to PowerShell V5
#	Fixed saving the HTML file when using AddDateTime, now only one file is created not two
#	Fixed several incorrect variable names that kept PDFs from saving in Windows 10 and Office 2013
#	Removed the 10 second pauses waiting for Word to save and close
#
#Version 1.21 17-Aug-2016
#	Added policy setting ICA\Launching of non-published programs during client connection 
#	Renamed Virtual Desktop Agent Settings to Virtual Delivery Agent Settings
#	Fixed a few issues with Text and HTML output in the Hardware region
#
#Version 1.22 26-Sep-2016
#	Add Configuration Logging Preferences
#	Add to machine catalog information for RemotePC, "No. of Machines" and "Allocated Machines"
#	Fix calculation for "No. of Machines" in Machine Catalogs summary and details
#
#Version 1.23 19-Oct-2016
#	Fixed formatting issues with HTML headings output
#
#Version 1.24 22-Oct-2016
#	More refinement of HTML output
#
#Version 1.25 7-Nov-2016
#	Added Chinese language support
#
#Version 1.26 29-Nov-2016
#	Fix bug when Delivery Type for a delivery group could not be determined
#	Fix bug in HTML output for delivery group details
#
#Version 1.27 6-Dec-2016
#	For Machine Catalog details, for PVS provisioned catalogs, add the PVS Server address
#
#Version 1.28 21-Dec-2016
#	Added Summary report page
#	Updated version checking
#	Updated version checking registry access to allow 32-bit PowerShell access to 64-bit registry
#
#Version 1.29 2-Jan-2017
#	Added Description to Machine Catalog details
#	Added RemotePC OU and Subfolder properties to RemotePC Machine Catalog details
#
#Version 1.30 7-Feb-2017
#	Fix numerous typos
#	Removed snapin citrix.common.commands as it is no longer used and no cmdlets are used from that snapin
#	Update help text
#
#Version 1.31 13-Feb-2017
#	Fixed French wording for Table of Contents 2 (Thanks to David Rouquier)
#
#Version 1.32 11-Jun-2017
#	Add four new Cover Page properties
#		Company Address
#		Company Email
#		Company Fax
#		Company Phone
#	Fix Function Check-LoadedModule
#	Fix Summary Page not checking for Zone support
#	Remove code (140 lines) that made sure all Parameters were set to default values if for some reason they did exist or values were $Null
#	Replace _SetDocumentProperty function with Jim Moyle's Set-DocumentProperty function
#	Update Function ProcessScriptEnd for the new Cover Page properties
#	Update Function ShowScriptOptions for the new Cover Page properties
#	Update Function UpdateDocumentProperties for the new Cover Page properties
#	Update help text
#
#Version 1.33 15-Jun-2017
#	Added back the WorkerGroup policy filter for XenApp 6.x
#	Added folder name to Function OutputApplication (Thanks to Brandon Mitchell)
#	Added sort applications by AdminFolderName and ApplicationName to Function ProcessApplications (Thanks to Brandon Mitchell)
#	Fix bug when retrieving Filters for a Policy that "applies to all objects in the Site"
#	Fix functions ProcessAppV and OutputAppv to handle multiple AppV servers (Thanks to Brandon Mitchell)
#	Fix two calls to Get-BrokerApplication that were retrieving the default of 250 records (Thanks to Brandon Mitchell)
#
#Version 1.34 17-Jun-2017
#	Fixed function OutputPolicySetting
#	Fixed numerous issues in the Policies section
#	Removed the Summary parameter as it was not used
#	Reordered the parameters in the help text and parameter list so they match and are grouped better
#	Updated help text
#
#Version 1.35 21-Jun-2017
#	Added new parameter MaxDetails:
#		This is the same as using the following parameters:
#			Administrators
#			Applications
#			DeliveryGroups
#			HardWare
#			Hosting
#			Logging
#			MachineCatalogs
#			Policies
#			StoreFront
#	Updated help text
#
#Version 1.36 26-Jun-2017
#	Added additional error checking for Site version information
#		If "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Citrix Desktop Delivery Controller" 
#		is not found on the computer running the script, then look on the computer specified for -AdminAddress
#		If still not found on that computer, abort the script
#	Added "Database Size" to the Datastores output
#	Added loading the SQL Server assembly so the database size calculations work consistently (thanks to Michael B. Smith)
#	Added showing the XenApp/XenDesktop version at the beginning of the script
#	Cleaned up many Switch () Statements
#	Fixed the "CPU Usage", "Disk Usage", and "Memory Usage" policy settings
#		When those settings are Disabled, they are stored as Enabled with a Value of -1
#	Updated Function OutputDatastores to:
#		Add database size
#		Fix output for mirrored databases
#		Check if SQL Server assembly is loaded before calculating database size
#	When -NoPolicies is specified, the Citrix.GroupPolicy.Commands module is no longer searched for
#	
#Version 1.37 30-Jun-2017
#	Added Function GetSQLVersion
#	Added Read-Committed Snapshot and SQL Server version data to Datastore table
#	If any of the databases are configured for mirroring and the database size is null,
#		use the mirror server's name to calculate the size
#		if the size is still null, report "Unable to determine"
#	If SQL Server mirroring is not configured, in the Datastore table use "Not Configured" for the Mirror Server Address
#
#Version 1.38 9-Oct-2017
#	From version 1.33:
#		Added sort applications by AdminFolderName and ApplicationName to Function ProcessApplications (Thanks to Brandon Mitchell)
#		This is only valid for XenApp/XenDesktop version 7.6 and later
#		Use (Get-BrokerServiceAddedCapability) -contains "ApplicationFolders" to determine version info
#		For XA/XD versions before 7.6, sort applications by Name property only
#		For versions 7.0 thru 7.5, use the Name property for output, 7.6+ use ApplicationName
#	
#Version 1.39 8-Dec-2017
#	Updated Function WriteHTMLLine with fixes from the script template
#
#Version 1.40 2-Mar-2018
#	Added additional SQL database information to the Configuration section
#	Added Log switch to create a transcript log
#		Added function TranscriptLogging
#		Citrix.GroupPolicy.Commands and New-PSDrive break transcript logging so restart logging after each New-PSDrive call
#		Removed the Log Alias from the Logging parameter
#	Added new function GetDBCompatibilityLevel
#	Move section headings for Machine Catalogs, Delivery Groups, and Applications to their respective "Process" functions.
#		This allows the "There are no Machine Catalogs/Delivery Groups/Applications" messages to appear in their own sections, 
#		and for Word/PDF output, not directly under the Table of Contents
#	Update help text
#	Updated function GetSQLVersion to add support for SQL Server 2017
#	Updated function OutputDatastores for the additional SQL Server and Database information
#		Changed Word/PDF and HTML output from a horizontal table to three vertical tables
#	Updated the "Default" message in function GetSQLVersion
#	When there are no Machine Catalogs, change the message from "There are no Machines" to "There are no Machine Catalogs"
#
#Version 1.40.1 10-Mar-2018
#	Fix $SQLVersion for SQL 2008 R2. Minor version is 50, not 5.
#
#Version 1.41 7-Apr-2018
#	Added Operating System information to Functions GetComputerWMIInfo and OutputComputerItem
#	Code clean-up for most recommendations made by Visual Studio Code
#	During the code clean up, I came across some "unused" variables. I had just
#		forgotten to add them to the output. OOPS! They are now added.
#			Off Peak Buffer Size Percent
#			Off Peak Disconnect Timeout (Minutes)
#			Off Peak Extended Disconnect Timeout (Minutes)
#			Off Peak LogOff Timeout (Minutes)
#			Peak Buffer Size Percent
#			Peak Disconnect Timeout (Minutes)
#			Peak Extended Disconnect Timeout (Minutes)
#			Peak LogOff Timeout (Minutes)
#			Settlement Period Before Auto Shutdown (HH:MM:SS)
#		Code clean up also found a copy and paste error with Session Linger
#			The "end session linger" value was still using the "end session prelaunch" variable
#			OOPS, sorry about that. Fixed.


#endregion

#region initial variable testing and setup
Set-StrictMode -Version 2

#force on
$PSDefaultParameterValues = @{"*:Verbose"=$True}
$SaveEAPreference = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'

#V1.40 added
If($Log) 
{
	#start transcript logging
	$Script:ThisScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
	$Script:LogPath = "$Script:ThisScriptPath\XDV1DocScriptTranscript_$(Get-Date -f yyyy-MM-dd_HHmm).txt"
	
	try 
	{
		Start-Transcript -Path $Script:LogPath -Force -Verbose:$false | Out-Null
		Write-Verbose "$(Get-Date): Transcript/log started at $Script:LogPath"
		$Script:StartLog = $true
	} 
	catch 
	{
		Write-Verbose "$(Get-Date): Transcript/log failed at $Script:LogPath"
		$Script:StartLog = $false
	}
}

If($Dev)
{
	$Error.Clear()
	$Script:DevErrorFile = "$($pwd.Path)\XAXD7V1InventoryScriptErrors_$(Get-Date -f yyyy-MM-dd_HHmm).txt"
}

If($Null -eq $MSWord)
{
	If($Text -or $HTML -or $PDF)
	{
		$MSWord = $False
	}
	Else
	{
		$MSWord = $True
	}
}

If($MSWord -eq $False -and $PDF -eq $False -and $Text -eq $False -and $HTML -eq $False)
{
	$MSWord = $True
}

Write-Verbose "$(Get-Date): Testing output parameters"

If($MSWord)
{
	Write-Verbose "$(Get-Date): MSWord is set"
}
ElseIf($PDF)
{
	Write-Verbose "$(Get-Date): PDF is set"
}
ElseIf($Text)
{
	Write-Verbose "$(Get-Date): Text is set"
}
ElseIf($HTML)
{
	Write-Verbose "$(Get-Date): HTML is set"
}
Else
{
	$ErrorActionPreference = $SaveEAPreference
	Write-Verbose "$(Get-Date): Unable to determine output parameter"
	If($Null -eq $MSWord)
	{
		Write-Verbose "$(Get-Date): MSWord is Null"
	}
	ElseIf($Null -eq $PDF)
	{
		Write-Verbose "$(Get-Date): PDF is Null"
	}
	ElseIf($Null -eq $Text)
	{
		Write-Verbose "$(Get-Date): Text is Null"
	}
	ElseIf($Null -eq $HTML)
	{
		Write-Verbose "$(Get-Date): HTML is Null"
	}
	Else
	{
		Write-Verbose "$(Get-Date): MSWord is $($MSWord)"
		Write-Verbose "$(Get-Date): PDF is $($PDF)"
		Write-Verbose "$(Get-Date): Text is $($Text)"
		Write-Verbose "$(Get-Date): HTML is $($HTML)"
	}
	Write-Error "Unable to determine output parameter.  Script cannot continue"
	Exit
}

#If the MaxDetails parameter is used, set a bunch of stuff true and some stuff false
If($MaxDetails)
{
	$Administrators		= $True
	$Applications		= $True
	$DeliveryGroups		= $True
	$HardWare			= $True
	$Hosting			= $True
	$Logging			= $True
	$MachineCatalogs	= $True
	$Policies			= $True
	$StoreFront			= $True
	
	$NoPolicies			= $False
	$Section			= "All"
}

If($NoPolicies)
{
	$Policies = $False
}

If($NoPolicies -and $Section -eq "Policies")
{
	#conflict
	$ErrorActionPreference = $SaveEAPreference
	Write-Error -Message "`n`tYou specified conflicting parameters.`n`n`tYou specified the $($Section) section but also selected NoPolicies.`n`n`tPlease change one of these options and rerun the script.`n`n
	Script cannot continue."
	Exit
}

$ValidSection = $False
Switch ($Section)
{
	"Admins"		{$ValidSection = $True; Break}
	"Apps"			{$ValidSection = $True; Break}
	"AppV" 			{$ValidSection = $True; Break}
	"Catalogs"		{$ValidSection = $True; Break}
	"Config"		{$ValidSection = $True; Break}
	"Controllers"	{$ValidSection = $True; Break}
	"Groups"		{$ValidSection = $True; Break}
	"Hosting"		{$ValidSection = $True; Break}
	"Licensing"		{$ValidSection = $True; Break}
	"Logging"		{$ValidSection = $True; $Logging = $True; Break}	#force $logging true if the config logging section is specified
	"Policies"		{$ValidSection = $True; $Policies = $True; Break} #force $policies true if the policies section is specified
	"StoreFront"	{$ValidSection = $True; Break}
	"Zones"			{$ValidSection = $True; Break}
	"All"			{$ValidSection = $True; Break}
}

If($ValidSection -eq $False)
{
	$ErrorActionPreference = $SaveEAPreference
	Write-Error -Message "`n`tThe Section parameter specified, $($Section), is an invalid Section option.`n`tValid options are:
	
	`t`tAdmins
	`t`tApps
	`t`tAppV
	`t`tCatalogs
	`t`tConfig
	`t`tControllers
	`t`tGroups
	`t`tHosting
	`t`tLicensing
	`t`tLogging
	`t`tPolicies
	`t`tStoreFront
	`t`tZones
	`t`tAll
	
	`tScript cannot continue."
	Exit
}

If($Folder -ne "")
{
	Write-Verbose "$(Get-Date): Testing folder path"
	#does it exist
	If(Test-Path $Folder -EA 0)
	{
		#it exists, now check to see if it is a folder and not a file
		If(Test-Path $Folder -pathType Container -EA 0)
		{
			#it exists and it is a folder
			Write-Verbose "$(Get-Date): Folder path $Folder exists and is a folder"
		}
		Else
		{
			#it exists but it is a file not a folder
			Write-Error "Folder $Folder is a file, not a folder.  Script cannot continue"
			Exit
		}
	}
	Else
	{
		#does not exist
		Write-Error "Folder $Folder does not exist.  Script cannot continue"
		Exit
	}
}
#endregion

#region initialize variables for Word, HTML and text
[string]$Script:RunningOS = (Get-WmiObject -class Win32_OperatingSystem -EA 0).Caption

If($MSWord -or $PDF)
{
	#try and fix the issue with the $CompanyName variable
	$Script:CoName = $CompanyName
	Write-Verbose "$(Get-Date): CoName is $($Script:CoName)"
	
	#the following values were attained from 
	#http://groovy.codehaus.org/modules/scriptom/1.6.0/scriptom-office-2K3-tlb/apidocs/
	#http://msdn.microsoft.com/en-us/library/office/aa211923(v=office.11).aspx
	[int]$wdAlignPageNumberRight = 2
	[long]$wdColorGray15 = 14277081
	[long]$wdColorGray05 = 15987699 
	[int]$wdMove = 0
	[int]$wdSeekMainDocument = 0
	[int]$wdSeekPrimaryFooter = 4
	[int]$wdStory = 6
	[long]$wdColorRed = 255
	[int]$wdColorBlack = 0
	[int]$wdWord2007 = 12
	[int]$wdWord2010 = 14
	[int]$wdWord2013 = 15
	[int]$wdWord2016 = 16
	[int]$wdFormatDocumentDefault = 16
	[int]$wdFormatPDF = 17
	#http://blogs.technet.com/b/heyscriptingguy/archive/2006/03/01/how-can-i-right-align-a-single-column-in-a-word-table.aspx
	#http://msdn.microsoft.com/en-us/library/office/ff835817%28v=office.15%29.aspx
	[int]$wdAlignParagraphLeft = 0
	[int]$wdAlignParagraphCenter = 1
	[int]$wdAlignParagraphRight = 2
	#http://msdn.microsoft.com/en-us/library/office/ff193345%28v=office.15%29.aspx
	[int]$wdCellAlignVerticalTop = 0
	[int]$wdCellAlignVerticalCenter = 1
	[int]$wdCellAlignVerticalBottom = 2
	#http://msdn.microsoft.com/en-us/library/office/ff844856%28v=office.15%29.aspx
	[int]$wdAutoFitFixed = 0
	[int]$wdAutoFitContent = 1
	[int]$wdAutoFitWindow = 2
	#http://msdn.microsoft.com/en-us/library/office/ff821928%28v=office.15%29.aspx
	[int]$wdAdjustNone = 0
	[int]$wdAdjustProportional = 1
	[int]$wdAdjustFirstColumn = 2
	[int]$wdAdjustSameWidth = 3

	[int]$PointsPerTabStop = 36
	[int]$Indent0TabStops = 0 * $PointsPerTabStop
	[int]$Indent1TabStops = 1 * $PointsPerTabStop
	[int]$Indent2TabStops = 2 * $PointsPerTabStop
	[int]$Indent3TabStops = 3 * $PointsPerTabStop
	[int]$Indent4TabStops = 4 * $PointsPerTabStop

	# http://www.thedoctools.com/index.php?show=wt_style_names_english_danish_german_french
	[int]$wdStyleHeading1 = -2
	[int]$wdStyleHeading2 = -3
	[int]$wdStyleHeading3 = -4
	[int]$wdStyleHeading4 = -5
	[int]$wdStyleNoSpacing = -158
	[int]$wdTableGrid = -155
	[int]$wdTableLightListAccent3 = -206

	#http://groovy.codehaus.org/modules/scriptom/1.6.0/scriptom-office-2K3-tlb/apidocs/org/codehaus/groovy/scriptom/tlb/office/word/WdLineStyle.html
	[int]$wdLineStyleNone = 0
	[int]$wdLineStyleSingle = 1

	[int]$wdHeadingFormatTrue = -1
	[int]$wdHeadingFormatFalse = 0 
	
}

If($HTML)
{
    Set-Variable htmlredmask         -Option AllScope -Value "#FF0000" 4>$Null
    Set-Variable htmlcyanmask        -Option AllScope -Value "#00FFFF" 4>$Null
    Set-Variable htmlbluemask        -Option AllScope -Value "#0000FF" 4>$Null
    Set-Variable htmldarkbluemask    -Option AllScope -Value "#0000A0" 4>$Null
    Set-Variable htmllightbluemask   -Option AllScope -Value "#ADD8E6" 4>$Null
    Set-Variable htmlpurplemask      -Option AllScope -Value "#800080" 4>$Null
    Set-Variable htmlyellowmask      -Option AllScope -Value "#FFFF00" 4>$Null
    Set-Variable htmllimemask        -Option AllScope -Value "#00FF00" 4>$Null
    Set-Variable htmlmagentamask     -Option AllScope -Value "#FF00FF" 4>$Null
    Set-Variable htmlwhitemask       -Option AllScope -Value "#FFFFFF" 4>$Null
    Set-Variable htmlsilvermask      -Option AllScope -Value "#C0C0C0" 4>$Null
    Set-Variable htmlgraymask        -Option AllScope -Value "#808080" 4>$Null
    Set-Variable htmlblackmask       -Option AllScope -Value "#000000" 4>$Null
    Set-Variable htmlorangemask      -Option AllScope -Value "#FFA500" 4>$Null
    Set-Variable htmlmaroonmask      -Option AllScope -Value "#800000" 4>$Null
    Set-Variable htmlgreenmask       -Option AllScope -Value "#008000" 4>$Null
    Set-Variable htmlolivemask       -Option AllScope -Value "#808000" 4>$Null

    Set-Variable htmlbold        -Option AllScope -Value 1 4>$Null
    Set-Variable htmlitalics     -Option AllScope -Value 2 4>$Null
    Set-Variable htmlred         -Option AllScope -Value 4 4>$Null
    Set-Variable htmlcyan        -Option AllScope -Value 8 4>$Null
    Set-Variable htmlblue        -Option AllScope -Value 16 4>$Null
    Set-Variable htmldarkblue    -Option AllScope -Value 32 4>$Null
    Set-Variable htmllightblue   -Option AllScope -Value 64 4>$Null
    Set-Variable htmlpurple      -Option AllScope -Value 128 4>$Null
    Set-Variable htmlyellow      -Option AllScope -Value 256 4>$Null
    Set-Variable htmllime        -Option AllScope -Value 512 4>$Null
    Set-Variable htmlmagenta     -Option AllScope -Value 1024 4>$Null
    Set-Variable htmlwhite       -Option AllScope -Value 2048 4>$Null
    Set-Variable htmlsilver      -Option AllScope -Value 4096 4>$Null
    Set-Variable htmlgray        -Option AllScope -Value 8192 4>$Null
    Set-Variable htmlolive       -Option AllScope -Value 16384 4>$Null
    Set-Variable htmlorange      -Option AllScope -Value 32768 4>$Null
    Set-Variable htmlmaroon      -Option AllScope -Value 65536 4>$Null
    Set-Variable htmlgreen       -Option AllScope -Value 131072 4>$Null
    Set-Variable htmlblack       -Option AllScope -Value 262144 4>$Null
}

If($TEXT)
{
	$Script:output = ""
}
#endregion

#region code for -hardware switch
Function GetComputerWMIInfo
{
	Param([string]$RemoteComputerName)
	
	# original work by Kees Baggerman, 
	# Senior Technical Consultant @ Inter Access
	# k.baggerman@myvirtualvision.com
	# @kbaggerman on Twitter
	# http://blog.myvirtualvision.com
	# modified 1-May-2014 to work in trusted AD Forests and using different domain admin credentials	
	# modified 17-Aug-2016 to fix a few issues with Text and HTML output
	# modified 2-Apr-2018 to add ComputerOS information

	#Get Computer info
	Write-Verbose "$(Get-Date): `t`tProcessing WMI Computer information"
	Write-Verbose "$(Get-Date): `t`t`tHardware information"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 "Computer Information: $($RemoteComputerName)"
		WriteWordLine 4 0 "General Computer"
	}
	ElseIf($Text)
	{
		Line 0 "Computer Information: $($RemoteComputerName)"
		Line 1 "General Computer"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 "Computer Information: $($RemoteComputerName)"
		WriteHTMLLine 4 0 "General Computer"
	}
	
	[bool]$GotComputerItems = $True
	
	Try
	{
		$Results = Get-WmiObject -computername $RemoteComputerName win32_computersystem
	}
	
	Catch
	{
		$Results = $Null
	}
	
	If($? -and $Null -ne $Results)
	{
		$ComputerItems = $Results | Select-Object Manufacturer, Model, Domain, `
		@{N="TotalPhysicalRam"; E={[math]::round(($_.TotalPhysicalMemory / 1GB),0)}}, `
		NumberOfProcessors, NumberOfLogicalProcessors
		$Results = $Null
		[string]$ComputerOS = (Get-WmiObject -class Win32_OperatingSystem -computername $RemoteComputerName -EA 0).Caption

		ForEach($Item in $ComputerItems)
		{
			OutputComputerItem $Item $ComputerOS
		}
	}
	ElseIf(!$?)
	{
		Write-Verbose "$(Get-Date): Get-WmiObject win32_computersystem failed for $($RemoteComputerName)"
		Write-Warning "Get-WmiObject win32_computersystem failed for $($RemoteComputerName)"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "Get-WmiObject win32_computersystem failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteWordLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteWordLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteWordLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "Get-WmiObject win32_computersystem failed for $($RemoteComputerName)"
			Line 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository"
			Line 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may"
			Line 2 "need to rerun the script with Domain Admin credentials from the trusted Forest."
			Line 2 ""
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "Get-WmiObject win32_computersystem failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): No results Returned for Computer information"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "No results Returned for Computer information" "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "No results Returned for Computer information"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "No results Returned for Computer information" "" $Null 0 $False $True
		}
	}
	
	#Get Disk info
	Write-Verbose "$(Get-Date): `t`t`tDrive information"

	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Drive(s)"
	}
	ElseIf($Text)
	{
		Line 1 "Drive(s)"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Drive(s)"
	}

	[bool]$GotDrives = $True
	
	Try
	{
		$Results = Get-WmiObject -computername $RemoteComputerName Win32_LogicalDisk
	}
	
	Catch
	{
		$Results = $Null
	}

	If($? -and $Null -ne $Results)
	{
		$drives = $Results | Select-Object caption, @{N="drivesize"; E={[math]::round(($_.size / 1GB),0)}}, 
		filesystem, @{N="drivefreespace"; E={[math]::round(($_.freespace / 1GB),0)}}, 
		volumename, drivetype, volumedirty, volumeserialnumber
		$Results = $Null
		ForEach($drive in $drives)
		{
			If($drive.caption -ne "A:" -and $drive.caption -ne "B:")
			{
				OutputDriveItem $drive
			}
		}
	}
	ElseIf(!$?)
	{
		Write-Verbose "$(Get-Date): Get-WmiObject Win32_LogicalDisk failed for $($RemoteComputerName)"
		Write-Warning "Get-WmiObject Win32_LogicalDisk failed for $($RemoteComputerName)"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "Get-WmiObject Win32_LogicalDisk failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteWordLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteWordLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteWordLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "Get-WmiObject Win32_LogicalDisk failed for $($RemoteComputerName)"
			Line 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository"
			Line 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may"
			Line 2 "need to rerun the script with Domain Admin credentials from the trusted Forest."
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "Get-WmiObject Win32_LogicalDisk failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): No results Returned for Drive information"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "No results Returned for Drive information" "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "No results Returned for Drive information"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "No results Returned for Drive information" "" $Null 0 $False $True
		}
	}
	

	#Get CPU's and stepping
	Write-Verbose "$(Get-Date): `t`t`tProcessor information"

	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Processor(s)"
	}
	ElseIf($Text)
	{
		Line 1 "Processor(s)"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Processor(s)"
	}

	[bool]$GotProcessors = $True
	
	Try
	{
		$Results = Get-WmiObject -computername $RemoteComputerName win32_Processor
	}
	
	Catch
	{
		$Results = $Null
	}

	If($? -and $Null -ne $Results)
	{
		$Processors = $Results | Select-Object availability, name, description, maxclockspeed, 
		l2cachesize, l3cachesize, numberofcores, numberoflogicalprocessors
		$Results = $Null
		ForEach($processor in $processors)
		{
			OutputProcessorItem $processor
		}
	}
	ElseIf(!$?)
	{
		Write-Verbose "$(Get-Date): Get-WmiObject win32_Processor failed for $($RemoteComputerName)"
		Write-Warning "Get-WmiObject win32_Processor failed for $($RemoteComputerName)"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "Get-WmiObject win32_Processor failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteWordLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteWordLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteWordLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "Get-WmiObject win32_Processor failed for $($RemoteComputerName)"
			Line 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository"
			Line 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may"
			Line 2 "need to rerun the script with Domain Admin credentials from the trusted Forest."
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "Get-WmiObject win32_Processor failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): No results Returned for Processor information"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "No results Returned for Processor information" "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "No results Returned for Processor information"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "No results Returned for Processor information" "" $Null 0 $False $True
		}
	}

	#Get Nics
	Write-Verbose "$(Get-Date): `t`t`tNIC information"

	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Network Interface(s)"
	}
	ElseIf($Text)
	{
		Line 1 "Network Interface(s)"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Network Interface(s)"
	}

	[bool]$GotNics = $True
	
	Try
	{
		$Results = Get-WmiObject -computername $RemoteComputerName win32_networkadapterconfiguration
	}
	
	Catch
	{
		$Results = $Null
	}

	If($? -and $Null -ne $Results)
	{
		$Nics = $Results | Where-Object {$Null -ne $_.ipaddress}
		$Results = $Null

		If($Nics -eq $Null ) 
		{ 
			$GotNics = $False 
		} 
		Else 
		{ 
			$GotNics = !($Nics.__PROPERTY_COUNT -eq 0) 
		} 
	
		If($GotNics)
		{
			ForEach($nic in $nics)
			{
				Try
				{
					$ThisNic = Get-WmiObject -computername $RemoteComputerName win32_networkadapter | Where-Object {$_.index -eq $nic.index}
				}
				
				Catch 
				{
					$ThisNic = $Null
				}
				
				If($? -and $Null -ne $ThisNic)
				{
					OutputNicItem $Nic $ThisNic
				}
				ElseIf(!$?)
				{
					Write-Warning "$(Get-Date): Error retrieving NIC information"
					Write-Verbose "$(Get-Date): Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
					Write-Warning "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
					If($MSWORD -or $PDF)
					{
						WriteWordLine 0 2 "Error retrieving NIC information" "" $Null 0 $False $True
						WriteWordLine 0 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)" "" $Null 0 $False $True
						WriteWordLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
						WriteWordLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
						WriteWordLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
					}
					ElseIf($Text)
					{
						Line 2 "Error retrieving NIC information"
						Line 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
						Line 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository"
						Line 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may"
						Line 2 "need to rerun the script with Domain Admin credentials from the trusted Forest."
					}
					ElseIf($HTML)
					{
						WriteHTMLLine 0 2 "Error retrieving NIC information" "" $Null 0 $False $True
						WriteHTMLLine 0 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)" "" $Null 0 $False $True
						WriteHTMLLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
						WriteHTMLLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
						WriteHTMLLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
					}
				}
				Else
				{
					Write-Verbose "$(Get-Date): No results Returned for NIC information"
					If($MSWORD -or $PDF)
					{
						WriteWordLine 0 2 "No results Returned for NIC information" "" $Null 0 $False $True
					}
					ElseIf($Text)
					{
						Line 2 "No results Returned for NIC information"
					}
					ElseIf($HTML)
					{
						WriteHTMLLine 0 2 "No results Returned for NIC information" "" $Null 0 $False $True
					}
				}
			}
		}	
	}
	ElseIf(!$?)
	{
		Write-Warning "$(Get-Date): Error retrieving NIC configuration information"
		Write-Verbose "$(Get-Date): Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
		Write-Warning "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "Error retrieving NIC configuration information" "" $Null 0 $False $True
			WriteWordLine 0 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteWordLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteWordLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteWordLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "Error retrieving NIC configuration information"
			Line 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)"
			Line 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository"
			Line 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may"
			Line 2 "need to rerun the script with Domain Admin credentials from the trusted Forest."
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "Error retrieving NIC configuration information" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "Get-WmiObject win32_networkadapterconfiguration failed for $($RemoteComputerName)" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "On $($RemoteComputerName) you may need to run winmgmt /verifyrepository" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "and winmgmt /salvagerepository.  If this is a trusted Forest, you may" "" $Null 0 $False $True
			WriteHTMLLine 0 2 "need to rerun the script with Domain Admin credentials from the trusted Forest." "" $Null 0 $False $True
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): No results Returned for NIC configuration information"
		If($MSWORD -or $PDF)
		{
			WriteWordLine 0 2 "No results Returned for NIC configuration information" "" $Null 0 $False $True
		}
		ElseIf($Text)
		{
			Line 2 "No results Returned for NIC configuration information"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 2 "No results Returned for NIC configuration information" "" $Null 0 $False $True
		}
	}
	
	If($MSWORD -or $PDF)
	{
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 0 0 ""
	}
}

Function OutputComputerItem
{
	Param([object]$Item, [string]$OS)
	# modified 2-Apr-2018 to add Operating System information
	
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $ItemInformation = @()
		$ItemInformation += @{ Data = "Manufacturer"; Value = $Item.manufacturer; }
		$ItemInformation += @{ Data = "Model"; Value = $Item.model; }
		$ItemInformation += @{ Data = "Domain"; Value = $Item.domain; }
		$ItemInformation += @{ Data = "Operating System"; Value = $OS; }
		$ItemInformation += @{ Data = "Total Ram"; Value = "$($Item.totalphysicalram) GB"; }
		$ItemInformation += @{ Data = "Physical Processors (sockets)"; Value = $Item.NumberOfProcessors; }
		$ItemInformation += @{ Data = "Logical Processors (cores w/HT)"; Value = $Item.NumberOfLogicalProcessors; }
		$Table = AddWordTable -Hashtable $ItemInformation `
		-Columns Data,Value `
		-List `
		-AutoFit $wdAutoFitFixed;

		## Set first column format
		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		## IB - set column widths without recursion
		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustNone)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 2 "Manufacturer`t`t`t: " $Item.manufacturer
		Line 2 "Model`t`t`t`t: " $Item.model
		Line 2 "Domain`t`t`t`t: " $Item.domain
		Line 2 "Operating System`t`t: " $OS
		Line 2 "Total Ram`t`t`t: $($Item.totalphysicalram) GB"
		Line 2 "Physical Processors (sockets)`t: " $Item.NumberOfProcessors
		Line 2 "Logical Processors (cores w/HT)`t: " $Item.NumberOfLogicalProcessors
		Line 2 ""
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		$columnHeaders = @("Manufacturer",($htmlsilver -bor $htmlbold),$Item.manufacturer,$htmlwhite)
		$rowdata += @(,('Model',($htmlsilver -bor $htmlbold),$Item.model,$htmlwhite))
		$rowdata += @(,('Domain',($htmlsilver -bor $htmlbold),$Item.domain,$htmlwhite))
		$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),$OS,$htmlwhite))
		$rowdata += @(,('Total Ram',($htmlsilver -bor $htmlbold),"$($Item.totalphysicalram) GB",$htmlwhite))
		$rowdata += @(,('Physical Processors (sockets)',($htmlsilver -bor $htmlbold),$Item.NumberOfProcessors,$htmlwhite))
		$rowdata += @(,('Logical Processors (cores w/HT)',($htmlsilver -bor $htmlbold),$Item.NumberOfLogicalProcessors,$htmlwhite))

		$msg = ""
		$columnWidths = @("150px","200px")
		FormatHTMLTable $msg -rowarray $rowdata -columnArray $columnheaders -fixedWidth $columnWidths
		WriteHTMLLine 0 0 ""
	}
}

Function OutputDriveItem
{
	Param([object]$Drive)
	
	$xDriveType = ""
	Switch ($drive.drivetype)
	{
		0		{$xDriveType = "Unknown"; Break}
		1		{$xDriveType = "No Root Directory"; Break}
		2		{$xDriveType = "Removable Disk"; Break}
		3		{$xDriveType = "Local Disk"; Break}
		4		{$xDriveType = "Network Drive"; Break}
		5		{$xDriveType = "Compact Disc"; Break}
		6		{$xDriveType = "RAM Disk"; Break}
		Default {$xDriveType = "Unknown"; Break}
	}
	
	$xVolumeDirty = ""
	If(![String]::IsNullOrEmpty($drive.volumedirty))
	{
		If($drive.volumedirty)
		{
			$xVolumeDirty = "Yes"
		}
		Else
		{
			$xVolumeDirty = "No"
		}
	}

	If($MSWORD -or $PDF)
	{
		[System.Collections.Hashtable[]] $DriveInformation = @()
		$DriveInformation += @{ Data = "Caption"; Value = $Drive.caption; }
		$DriveInformation += @{ Data = "Size"; Value = "$($drive.drivesize) GB"; }
		If(![String]::IsNullOrEmpty($drive.filesystem))
		{
			$DriveInformation += @{ Data = "File System"; Value = $Drive.filesystem; }
		}
		$DriveInformation += @{ Data = "Free Space"; Value = "$($drive.drivefreespace) GB"; }
		If(![String]::IsNullOrEmpty($drive.volumename))
		{
			$DriveInformation += @{ Data = "Volume Name"; Value = $Drive.volumename; }
		}
		If(![String]::IsNullOrEmpty($drive.volumedirty))
		{
			$DriveInformation += @{ Data = "Volume is Dirty"; Value = $xVolumeDirty; }
		}
		If(![String]::IsNullOrEmpty($drive.volumeserialnumber))
		{
			$DriveInformation += @{ Data = "Volume Serial Number"; Value = $Drive.volumeserialnumber; }
		}
		$DriveInformation += @{ Data = "Drive Type"; Value = $xDriveType; }
		$Table = AddWordTable -Hashtable $DriveInformation `
		-Columns Data,Value `
		-List `
		-AutoFit $wdAutoFitFixed;

		## Set first column format
		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells `
		-Bold `
		-BackgroundColor $wdColorGray15;

		## IB - set column widths without recursion
		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 2 ""
	}
	ElseIf($Text)
	{
		Line 2 "Caption`t`t: " $drive.caption
		Line 2 "Size`t`t: $($drive.drivesize) GB"
		If(![String]::IsNullOrEmpty($drive.filesystem))
		{
			Line 2 "File System`t: " $drive.filesystem
		}
		Line 2 "Free Space`t: $($drive.drivefreespace) GB"
		If(![String]::IsNullOrEmpty($drive.volumename))
		{
			Line 2 "Volume Name`t: " $drive.volumename
		}
		If(![String]::IsNullOrEmpty($drive.volumedirty))
		{
			Line 2 "Volume is Dirty`t: " $xVolumeDirty
		}
		If(![String]::IsNullOrEmpty($drive.volumeserialnumber))
		{
			Line 2 "Volume Serial #`t: " $drive.volumeserialnumber
		}
		Line 2 "Drive Type`t: " $xDriveType
		Line 2 ""
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		$columnHeaders = @("Caption",($htmlsilver -bor $htmlbold),$Drive.caption,$htmlwhite)
		$rowdata += @(,('Size',($htmlsilver -bor $htmlbold),"$($drive.drivesize) GB",$htmlwhite))

		If(![String]::IsNullOrEmpty($drive.filesystem))
		{
			$rowdata += @(,('File System',($htmlsilver -bor $htmlbold),$Drive.filesystem,$htmlwhite))
		}
		$rowdata += @(,('Free Space',($htmlsilver -bor $htmlbold),"$($drive.drivefreespace) GB",$htmlwhite))
		If(![String]::IsNullOrEmpty($drive.volumename))
		{
			$rowdata += @(,('Volume Name',($htmlsilver -bor $htmlbold),$Drive.volumename,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($drive.volumedirty))
		{
			$rowdata += @(,('Volume is Dirty',($htmlsilver -bor $htmlbold),$xVolumeDirty,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($drive.volumeserialnumber))
		{
			$rowdata += @(,('Volume Serial Number',($htmlsilver -bor $htmlbold),$Drive.volumeserialnumber,$htmlwhite))
		}
		$rowdata += @(,('Drive Type',($htmlsilver -bor $htmlbold),$xDriveType,$htmlwhite))

		$msg = ""
		$columnWidths = @("150px","200px")
		FormatHTMLTable $msg -rowarray $rowdata -columnArray $columnheaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputProcessorItem
{
	Param([object]$Processor)
	
	$xAvailability = ""
	Switch ($processor.availability)
	{
		1		{$xAvailability = "Other"; Break}
		2		{$xAvailability = "Unknown"; Break}
		3		{$xAvailability = "Running or Full Power"; Break}
		4		{$xAvailability = "Warning"; Break}
		5		{$xAvailability = "In Test"; Break}
		6		{$xAvailability = "Not Applicable"; Break}
		7		{$xAvailability = "Power Off"; Break}
		8		{$xAvailability = "Off Line"; Break}
		9		{$xAvailability = "Off Duty"; Break}
		10		{$xAvailability = "Degraded"; Break}
		11		{$xAvailability = "Not Installed"; Break}
		12		{$xAvailability = "Install Error"; Break}
		13		{$xAvailability = "Power Save - Unknown"; Break}
		14		{$xAvailability = "Power Save - Low Power Mode"; Break}
		15		{$xAvailability = "Power Save - Standby"; Break}
		16		{$xAvailability = "Power Cycle"; Break}
		17		{$xAvailability = "Power Save - Warning"; Break}
		Default	{$xAvailability = "Unknown"; Break}
	}

	If($MSWORD -or $PDF)
	{
		[System.Collections.Hashtable[]] $ProcessorInformation = @()
		$ProcessorInformation += @{ Data = "Name"; Value = $Processor.name; }
		$ProcessorInformation += @{ Data = "Description"; Value = $Processor.description; }
		$ProcessorInformation += @{ Data = "Max Clock Speed"; Value = "$($processor.maxclockspeed) MHz"; }
		If($processor.l2cachesize -gt 0)
		{
			$ProcessorInformation += @{ Data = "L2 Cache Size"; Value = "$($processor.l2cachesize) KB"; }
		}
		If($processor.l3cachesize -gt 0)
		{
			$ProcessorInformation += @{ Data = "L3 Cache Size"; Value = "$($processor.l3cachesize) KB"; }
		}
		If($processor.numberofcores -gt 0)
		{
			$ProcessorInformation += @{ Data = "Number of Cores"; Value = $Processor.numberofcores; }
		}
		If($processor.numberoflogicalprocessors -gt 0)
		{
			$ProcessorInformation += @{ Data = "Number of Logical Processors (cores w/HT)"; Value = $Processor.numberoflogicalprocessors; }
		}
		$ProcessorInformation += @{ Data = "Availability"; Value = $xAvailability; }
		$Table = AddWordTable -Hashtable $ProcessorInformation `
		-Columns Data,Value `
		-List `
		-AutoFit $wdAutoFitFixed;

		## Set first column format
		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		## IB - set column widths without recursion
		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 2 "Name`t`t`t`t: " $processor.name
		Line 2 "Description`t`t`t: " $processor.description
		Line 2 "Max Clock Speed`t`t`t: $($processor.maxclockspeed) MHz"
		If($processor.l2cachesize -gt 0)
		{
			Line 2 "L2 Cache Size`t`t`t: $($processor.l2cachesize) KB"
		}
		If($processor.l3cachesize -gt 0)
		{
			Line 2 "L3 Cache Size`t`t`t: $($processor.l3cachesize) KB"
		}
		If($processor.numberofcores -gt 0)
		{
			Line 2 "# of Cores`t`t`t: " $processor.numberofcores
		}
		If($processor.numberoflogicalprocessors -gt 0)
		{
			Line 2 "# of Logical Procs (cores w/HT)`t: " $processor.numberoflogicalprocessors
		}
		Line 2 "Availability`t`t`t: " $xAvailability
		Line 2 ""
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$Processor.name,$htmlwhite)
		$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Processor.description,$htmlwhite))

		$rowdata += @(,('Max Clock Speed',($htmlsilver -bor $htmlbold),"$($processor.maxclockspeed) MHz",$htmlwhite))
		If($processor.l2cachesize -gt 0)
		{
			$rowdata += @(,('L2 Cache Size',($htmlsilver -bor $htmlbold),"$($processor.l2cachesize) KB",$htmlwhite))
		}
		If($processor.l3cachesize -gt 0)
		{
			$rowdata += @(,('L3 Cache Size',($htmlsilver -bor $htmlbold),"$($processor.l3cachesize) KB",$htmlwhite))
		}
		If($processor.numberofcores -gt 0)
		{
			$rowdata += @(,('Number of Cores',($htmlsilver -bor $htmlbold),$Processor.numberofcores,$htmlwhite))
		}
		If($processor.numberoflogicalprocessors -gt 0)
		{
			$rowdata += @(,('Number of Logical Processors (cores w/HT)',($htmlsilver -bor $htmlbold),$Processor.numberoflogicalprocessors,$htmlwhite))
		}
		$rowdata += @(,('Availability',($htmlsilver -bor $htmlbold),$xAvailability,$htmlwhite))

		$msg = ""
		$columnWidths = @("150px","200px")
		FormatHTMLTable $msg -rowarray $rowdata -columnArray $columnheaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputNicItem
{
	Param([object]$Nic, [object]$ThisNic)
	
	$powerMgmt = Get-WmiObject MSPower_DeviceEnable -Namespace root\wmi | Where-Object {$_.InstanceName -match [regex]::Escape($ThisNic.PNPDeviceID)}

	If($? -and $Null -ne $powerMgmt)
	{
		If($powerMgmt.Enable -eq $True)
		{
			$PowerSaving = "Enabled"
		}
		Else
		{
			$PowerSaving = "Disabled"
		}
	}
	Else
	{
        $PowerSaving = "N/A"
	}
	
	$xAvailability = ""
	Switch ($processor.availability)
	{
		1		{$xAvailability = "Other"; Break}
		2		{$xAvailability = "Unknown"; Break}
		3		{$xAvailability = "Running or Full Power"; Break}
		4		{$xAvailability = "Warning"; Break}
		5		{$xAvailability = "In Test"; Break}
		6		{$xAvailability = "Not Applicable"; Break}
		7		{$xAvailability = "Power Off"; Break}
		8		{$xAvailability = "Off Line"; Break}
		9		{$xAvailability = "Off Duty"; Break}
		10		{$xAvailability = "Degraded"; Break}
		11		{$xAvailability = "Not Installed"; Break}
		12		{$xAvailability = "Install Error"; Break}
		13		{$xAvailability = "Power Save - Unknown"; Break}
		14		{$xAvailability = "Power Save - Low Power Mode"; Break}
		15		{$xAvailability = "Power Save - Standby"; Break}
		16		{$xAvailability = "Power Cycle"; Break}
		17		{$xAvailability = "Power Save - Warning"; Break}
		Default	{$xAvailability = "Unknown"; Break}
	}

	$xIPAddress = @()
	ForEach($IPAddress in $Nic.ipaddress)
	{
		$xIPAddress += "$($IPAddress)"
	}

	$xIPSubnet = @()
	ForEach($IPSubnet in $Nic.ipsubnet)
	{
		$xIPSubnet += "$($IPSubnet)"
	}

	If($Null -ne $nic.dnsdomainsuffixsearchorder -and $nic.dnsdomainsuffixsearchorder.length -gt 0)
	{
		$nicdnsdomainsuffixsearchorder = $nic.dnsdomainsuffixsearchorder
		$xnicdnsdomainsuffixsearchorder = @()
		ForEach($DNSDomain in $nicdnsdomainsuffixsearchorder)
		{
			$xnicdnsdomainsuffixsearchorder += "$($DNSDomain)"
		}
	}
	
	If($Null -ne $nic.dnsserversearchorder -and $nic.dnsserversearchorder.length -gt 0)
	{
		$nicdnsserversearchorder = $nic.dnsserversearchorder
		$xnicdnsserversearchorder = @()
		ForEach($DNSServer in $nicdnsserversearchorder)
		{
			$xnicdnsserversearchorder += "$($DNSServer)"
		}
	}

	$xdnsenabledforwinsresolution = ""
	If($nic.dnsenabledforwinsresolution)
	{
		$xdnsenabledforwinsresolution = "Yes"
	}
	Else
	{
		$xdnsenabledforwinsresolution = "No"
	}
	
	$xTcpipNetbiosOptions = ""
	Switch ($nic.TcpipNetbiosOptions)
	{
		0		{$xTcpipNetbiosOptions = "Use NetBIOS setting from DHCP Server"; Break}
		1		{$xTcpipNetbiosOptions = "Enable NetBIOS"; Break}
		2		{$xTcpipNetbiosOptions = "Disable NetBIOS"; Break}
		Default	{$xTcpipNetbiosOptions = "Unknown"; Break}
	}
	
	$xwinsenablelmhostslookup = ""
	If($nic.winsenablelmhostslookup)
	{
		$xwinsenablelmhostslookup = "Yes"
	}
	Else
	{
		$xwinsenablelmhostslookup = "No"
	}

	If($MSWORD -or $PDF)
	{
		[System.Collections.Hashtable[]] $NicInformation = @()
		$NicInformation += @{ Data = "Name"; Value = $ThisNic.Name; }
		If($ThisNic.Name -ne $nic.description)
		{
			$NicInformation += @{ Data = "Description"; Value = $Nic.description; }
		}
		$NicInformation += @{ Data = "Connection ID"; Value = $ThisNic.NetConnectionID; }
		If(validObject $Nic Manufacturer)
		{
			$NicInformation += @{ Data = "Manufacturer"; Value = $Nic.manufacturer; }
		}
		$NicInformation += @{ Data = "Availability"; Value = $xAvailability; }
		$NicInformation += @{ Data = "Allow the computer to turn off this device to save power"; Value = $PowerSaving; }
		$NicInformation += @{ Data = "Physical Address"; Value = $Nic.macaddress; }
		If($xIPAddress.Count -gt 1)
		{
			$NicInformation += @{ Data = "IP Address"; Value = $xIPAddress[0]; }
			$NicInformation += @{ Data = "Default Gateway"; Value = $Nic.Defaultipgateway; }
			$NicInformation += @{ Data = "Subnet Mask"; Value = $xIPSubnet[0]; }
			$cnt = -1
			ForEach($tmp in $xIPAddress)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$NicInformation += @{ Data = "IP Address"; Value = $tmp; }
					$NicInformation += @{ Data = "Subnet Mask"; Value = $xIPSubnet[$cnt]; }
				}
			}
		}
		Else
		{
			$NicInformation += @{ Data = "IP Address"; Value = $xIPAddress; }
			$NicInformation += @{ Data = "Default Gateway"; Value = $Nic.Defaultipgateway; }
			$NicInformation += @{ Data = "Subnet Mask"; Value = $xIPSubnet; }
		}
		If($nic.dhcpenabled)
		{
			$DHCPLeaseObtainedDate = $nic.ConvertToDateTime($nic.dhcpleaseobtained)
			$DHCPLeaseExpiresDate = $nic.ConvertToDateTime($nic.dhcpleaseexpires)
			$NicInformation += @{ Data = "DHCP Enabled"; Value = $Nic.dhcpenabled; }
			$NicInformation += @{ Data = "DHCP Lease Obtained"; Value = $dhcpleaseobtaineddate; }
			$NicInformation += @{ Data = "DHCP Lease Expires"; Value = $dhcpleaseexpiresdate; }
			$NicInformation += @{ Data = "DHCP Server"; Value = $Nic.dhcpserver; }
		}
		If(![String]::IsNullOrEmpty($nic.dnsdomain))
		{
			$NicInformation += @{ Data = "DNS Domain"; Value = $Nic.dnsdomain; }
		}
		If($Null -ne $nic.dnsdomainsuffixsearchorder -and $nic.dnsdomainsuffixsearchorder.length -gt 0)
		{
			$NicInformation += @{ Data = "DNS Search Suffixes"; Value = $xnicdnsdomainsuffixsearchorder[0]; }
			$cnt = -1
			ForEach($tmp in $xnicdnsdomainsuffixsearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$NicInformation += @{ Data = ""; Value = $tmp; }
				}
			}
		}
		$NicInformation += @{ Data = "DNS WINS Enabled"; Value = $xdnsenabledforwinsresolution; }
		If($Null -ne $nic.dnsserversearchorder -and $nic.dnsserversearchorder.length -gt 0)
		{
			$NicInformation += @{ Data = "DNS Servers"; Value = $xnicdnsserversearchorder[0]; }
			$cnt = -1
			ForEach($tmp in $xnicdnsserversearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$NicInformation += @{ Data = ""; Value = $tmp; }
				}
			}
		}
		$NicInformation += @{ Data = "NetBIOS Setting"; Value = $xTcpipNetbiosOptions; }
		$NicInformation += @{ Data = "WINS: Enabled LMHosts"; Value = $xwinsenablelmhostslookup; }
		If(![String]::IsNullOrEmpty($nic.winshostlookupfile))
		{
			$NicInformation += @{ Data = "Host Lookup File"; Value = $Nic.winshostlookupfile; }
		}
		If(![String]::IsNullOrEmpty($nic.winsprimaryserver))
		{
			$NicInformation += @{ Data = "Primary Server"; Value = $Nic.winsprimaryserver; }
		}
		If(![String]::IsNullOrEmpty($nic.winssecondaryserver))
		{
			$NicInformation += @{ Data = "Secondary Server"; Value = $Nic.winssecondaryserver; }
		}
		If(![String]::IsNullOrEmpty($nic.winsscopeid))
		{
			$NicInformation += @{ Data = "Scope ID"; Value = $Nic.winsscopeid; }
		}
		$Table = AddWordTable -Hashtable $NicInformation -Columns Data,Value -List -AutoFit $wdAutoFitFixed;

		## Set first column format
		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		## IB - set column widths without recursion
		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 2 "Name`t`t`t: " $ThisNic.Name
		If($ThisNic.Name -ne $nic.description)
		{
			Line 2 "Description`t`t: " $nic.description
		}
		Line 2 "Connection ID`t`t: " $ThisNic.NetConnectionID
		If(validObject $Nic Manufacturer)
		{
			Line 2 "Manufacturer`t`t: " $Nic.manufacturer
		}
		Line 2 "Availability`t`t: " $xAvailability
		Line 2 "Allow computer to turn "
		Line 2 "off device to save power: " $PowerSaving
		Line 2 "Physical Address`t: " $nic.macaddress
		Line 2 "IP Address`t`t: " $xIPAddress[0]
		$cnt = -1
		ForEach($tmp in $xIPAddress)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $tmp
			}
		}
		Line 2 "Default Gateway`t`t: " $Nic.Defaultipgateway
		Line 2 "Subnet Mask`t`t: " $xIPSubnet[0]
		$cnt = -1
		ForEach($tmp in $xIPSubnet)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $tmp
			}
		}
		If($nic.dhcpenabled)
		{
			$DHCPLeaseObtainedDate = $nic.ConvertToDateTime($nic.dhcpleaseobtained)
			$DHCPLeaseExpiresDate = $nic.ConvertToDateTime($nic.dhcpleaseexpires)
			Line 2 "DHCP Enabled`t`t: " $nic.dhcpenabled
			Line 2 "DHCP Lease Obtained`t: " $dhcpleaseobtaineddate
			Line 2 "DHCP Lease Expires`t: " $dhcpleaseexpiresdate
			Line 2 "DHCP Server`t`t:" $nic.dhcpserver
		}
		If(![String]::IsNullOrEmpty($nic.dnsdomain))
		{
			Line 2 "DNS Domain`t`t: " $nic.dnsdomain
		}
		If($Null -ne $nic.dnsdomainsuffixsearchorder -and $nic.dnsdomainsuffixsearchorder.length -gt 0)
		{
			[int]$x = 1
			Line 2 "DNS Search Suffixes`t: " $xnicdnsdomainsuffixsearchorder[0]
			$cnt = -1
			ForEach($tmp in $xnicdnsdomainsuffixsearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					Line 5 "  " $tmp
				}
			}
		}
		Line 2 "DNS WINS Enabled`t: " $xdnsenabledforwinsresolution
		If($Null -ne $nic.dnsserversearchorder -and $nic.dnsserversearchorder.length -gt 0)
		{
			[int]$x = 1
			Line 2 "DNS Servers`t`t: " $xnicdnsserversearchorder[0]
			$cnt = -1
			ForEach($tmp in $xnicdnsserversearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					Line 5 "  " $tmp
				}
			}
		}
		Line 2 "NetBIOS Setting`t`t: " $xTcpipNetbiosOptions
		Line 2 "WINS:"
		Line 3 "Enabled LMHosts`t: " $xwinsenablelmhostslookup
		If(![String]::IsNullOrEmpty($nic.winshostlookupfile))
		{
			Line 3 "Host Lookup File`t: " $nic.winshostlookupfile
		}
		If(![String]::IsNullOrEmpty($nic.winsprimaryserver))
		{
			Line 3 "Primary Server`t: " $nic.winsprimaryserver
		}
		If(![String]::IsNullOrEmpty($nic.winssecondaryserver))
		{
			Line 3 "Secondary Server`t: " $nic.winssecondaryserver
		}
		If(![String]::IsNullOrEmpty($nic.winsscopeid))
		{
			Line 3 "Scope ID`t`t: " $nic.winsscopeid
		}
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$ThisNic.Name,$htmlwhite)
		If($ThisNic.Name -ne $nic.description)
		{
			$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Nic.description,$htmlwhite))
		}
		$rowdata += @(,('Connection ID',($htmlsilver -bor $htmlbold),$ThisNic.NetConnectionID,$htmlwhite))
		If(validObject $Nic Manufacturer)
		{
			$rowdata += @(,('Manufacturer',($htmlsilver -bor $htmlbold),$Nic.manufacturer,$htmlwhite))
		}
		$rowdata += @(,('Availability',($htmlsilver -bor $htmlbold),$xAvailability,$htmlwhite))
		$rowdata += @(,('Allow the computer to turn off this device to save power',($htmlsilver -bor $htmlbold),$PowerSaving,$htmlwhite))
		$rowdata += @(,('Physical Address',($htmlsilver -bor $htmlbold),$Nic.macaddress,$htmlwhite))
		$rowdata += @(,('IP Address',($htmlsilver -bor $htmlbold),$xIPAddress[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xIPAddress)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('IP Address',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Default Gateway',($htmlsilver -bor $htmlbold),$Nic.Defaultipgateway[0],$htmlwhite))
		$rowdata += @(,('Subnet Mask',($htmlsilver -bor $htmlbold),$xIPSubnet[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xIPSubnet)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('Subnet Mask',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		If($nic.dhcpenabled)
		{
			$DHCPLeaseObtainedDate = $nic.ConvertToDateTime($nic.dhcpleaseobtained)
			$DHCPLeaseExpiresDate = $nic.ConvertToDateTime($nic.dhcpleaseexpires)
			$rowdata += @(,('DHCP Enabled',($htmlsilver -bor $htmlbold),$Nic.dhcpenabled,$htmlwhite))
			$rowdata += @(,('DHCP Lease Obtained',($htmlsilver -bor $htmlbold),$dhcpleaseobtaineddate,$htmlwhite))
			$rowdata += @(,('DHCP Lease Expires',($htmlsilver -bor $htmlbold),$dhcpleaseexpiresdate,$htmlwhite))
			$rowdata += @(,('DHCP Server',($htmlsilver -bor $htmlbold),$Nic.dhcpserver,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($nic.dnsdomain))
		{
			$rowdata += @(,('DNS Domain',($htmlsilver -bor $htmlbold),$Nic.dnsdomain,$htmlwhite))
		}
		If($Null -ne $nic.dnsdomainsuffixsearchorder -and $nic.dnsdomainsuffixsearchorder.length -gt 0)
		{
			$rowdata += @(,('DNS Search Suffixes',($htmlsilver -bor $htmlbold),$xnicdnsdomainsuffixsearchorder[0],$htmlwhite))
			$cnt = -1
			ForEach($tmp in $xnicdnsdomainsuffixsearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				}
			}
		}
		$rowdata += @(,('DNS WINS Enabled',($htmlsilver -bor $htmlbold),$xdnsenabledforwinsresolution,$htmlwhite))
		If($Null -ne $nic.dnsserversearchorder -and $nic.dnsserversearchorder.length -gt 0)
		{
			$rowdata += @(,('DNS Servers',($htmlsilver -bor $htmlbold),$xnicdnsserversearchorder[0],$htmlwhite))
			$cnt = -1
			ForEach($tmp in $xnicdnsserversearchorder)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				}
			}
		}
		$rowdata += @(,('NetBIOS Setting',($htmlsilver -bor $htmlbold),$xTcpipNetbiosOptions,$htmlwhite))
		$rowdata += @(,('WINS: Enabled LMHosts',($htmlsilver -bor $htmlbold),$xwinsenablelmhostslookup,$htmlwhite))
		If(![String]::IsNullOrEmpty($nic.winshostlookupfile))
		{
			$rowdata += @(,('Host Lookup File',($htmlsilver -bor $htmlbold),$Nic.winshostlookupfile,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($nic.winsprimaryserver))
		{
			$rowdata += @(,('Primary Server',($htmlsilver -bor $htmlbold),$Nic.winsprimaryserver,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($nic.winssecondaryserver))
		{
			$rowdata += @(,('Secondary Server',($htmlsilver -bor $htmlbold),$Nic.winssecondaryserver,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($nic.winsscopeid))
		{
			$rowdata += @(,('Scope ID',($htmlsilver -bor $htmlbold),$Nic.winsscopeid,$htmlwhite))
		}

		$msg = ""
		$columnWidths = @("150px","200px")
		FormatHTMLTable $msg -rowarray $rowdata -columnArray $columnheaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region word specific functions
Function SetWordHashTable
{
	Param([string]$CultureCode)

	#optimized by Michael B. Smith
	
	# DE and FR translations for Word 2010 by Vladimir Radojevic
	# Vladimir.Radojevic@Commerzreal.com

	# DA translations for Word 2010 by Thomas Daugaard
	# Citrix Infrastructure Specialist at edgemo A/S

	# CA translations by Javier Sanchez 
	# CEO & Founder 101 Consulting

	#ca - Catalan
	#da - Danish
	#de - German
	#en - English
	#es - Spanish
	#fi - Finnish
	#fr - French
	#nb - Norwegian
	#nl - Dutch
	#pt - Portuguese
	#sv - Swedish
	#zh - Chinese
	
	[string]$toc = $(
		Switch ($CultureCode)
		{
			'ca-'	{ 'Taula automática 2'; Break }
			'da-'	{ 'Automatisk tabel 2'; Break }
			'de-'	{ 'Automatische Tabelle 2'; Break }
			'en-'	{ 'Automatic Table 2'; Break }
			'es-'	{ 'Tabla automática 2'; Break }
			'fi-'	{ 'Automaattinen taulukko 2'; Break }
			'fr-'	{ 'Table automatique 2'; Break } #changed 13-feb-2017 david roquier and samuel legrand
			'nb-'	{ 'Automatisk tabell 2'; Break }
			'nl-'	{ 'Automatische inhoudsopgave 2'; Break }
			'pt-'	{ 'Sumário Automático 2'; Break }
			'sv-'	{ 'Automatisk innehållsförteckning2'; Break }
			'zh-'	{ '自动目录 2'; Break }
		}
	)

	$Script:myHash                      = @{}
	$Script:myHash.Word_TableOfContents = $toc
	$Script:myHash.Word_NoSpacing       = $wdStyleNoSpacing
	$Script:myHash.Word_Heading1        = $wdStyleheading1
	$Script:myHash.Word_Heading2        = $wdStyleheading2
	$Script:myHash.Word_Heading3        = $wdStyleheading3
	$Script:myHash.Word_Heading4        = $wdStyleheading4
	$Script:myHash.Word_TableGrid       = $wdTableGrid
}

Function GetCulture
{
	Param([int]$WordValue)
	
	#codes obtained from http://support.microsoft.com/kb/221435
	#http://msdn.microsoft.com/en-us/library/bb213877(v=office.12).aspx
	$CatalanArray = 1027
	$ChineseArray = 2052,3076,5124,4100
	$DanishArray = 1030
	$DutchArray = 2067, 1043
	$EnglishArray = 3081, 10249, 4105, 9225, 6153, 8201, 5129, 13321, 7177, 11273, 2057, 1033, 12297
	$FinnishArray = 1035
	$FrenchArray = 2060, 1036, 11276, 3084, 12300, 5132, 13324, 6156, 8204, 10252, 7180, 9228, 4108
	$GermanArray = 1031, 3079, 5127, 4103, 2055
	$NorwegianArray = 1044, 2068
	$PortugueseArray = 1046, 2070
	$SpanishArray = 1034, 11274, 16394, 13322, 9226, 5130, 7178, 12298, 17418, 4106, 18442, 19466, 6154, 15370, 10250, 20490, 3082, 14346, 8202
	$SwedishArray = 1053, 2077

	#ca - Catalan
	#da - Danish
	#de - German
	#en - English
	#es - Spanish
	#fi - Finnish
	#fr - French
	#nb - Norwegian
	#nl - Dutch
	#pt - Portuguese
	#sv - Swedish
	#zh - Chinese

	Switch ($WordValue)
	{
		{$CatalanArray -contains $_} {$CultureCode = "ca-"}
		{$ChineseArray -contains $_} {$CultureCode = "zh-"}
		{$DanishArray -contains $_} {$CultureCode = "da-"}
		{$DutchArray -contains $_} {$CultureCode = "nl-"}
		{$EnglishArray -contains $_} {$CultureCode = "en-"}
		{$FinnishArray -contains $_} {$CultureCode = "fi-"}
		{$FrenchArray -contains $_} {$CultureCode = "fr-"}
		{$GermanArray -contains $_} {$CultureCode = "de-"}
		{$NorwegianArray -contains $_} {$CultureCode = "nb-"}
		{$PortugueseArray -contains $_} {$CultureCode = "pt-"}
		{$SpanishArray -contains $_} {$CultureCode = "es-"}
		{$SwedishArray -contains $_} {$CultureCode = "sv-"}
		Default {$CultureCode = "en-"}
	}
	
	Return $CultureCode
}

Function ValidateCoverPage
{
	Param([int]$xWordVersion, [string]$xCP, [string]$CultureCode)
	
	$xArray = ""
	
	Switch ($CultureCode)
	{
		'ca-'	{
				If($xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "En bandes", "Faceta", "Filigrana",
					"Integral", "Ió (clar)", "Ió (fosc)", "Línia lateral",
					"Moviment", "Quadrícula", "Retrospectiu", "Sector (clar)",
					"Sector (fosc)", "Semàfor", "Visualització principal", "Whisp")
				}
				ElseIf($xWordVersion -eq $wdWord2013)
				{
					$xArray = ("Austin", "En bandes", "Faceta", "Filigrana",
					"Integral", "Ió (clar)", "Ió (fosc)", "Línia lateral",
					"Moviment", "Quadrícula", "Retrospectiu", "Sector (clar)",
					"Sector (fosc)", "Semàfor", "Visualització", "Whisp")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alfabet", "Anual", "Austin", "Conservador",
					"Contrast", "Cubicles", "Diplomàtic", "Exposició",
					"Línia lateral", "Mod", "Mosiac", "Moviment", "Paper de diari",
					"Perspectiva", "Piles", "Quadrícula", "Sobri",
					"Transcendir", "Trencaclosques")
				}
			}

		'da-'	{
				If($xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "BevægElse", "Brusen", "Facet", "Filigran", 
					"Gitter", "Integral", "Ion (lys)", "Ion (mørk)", 
					"Retro", "Semafor", "Sidelinje", "Stribet", 
					"Udsnit (lys)", "Udsnit (mørk)", "Visningsmaster")
				}
				ElseIf($xWordVersion -eq $wdWord2013)
				{
					$xArray = ("BevægElse", "Brusen", "Ion (lys)", "Filigran",
					"Retro", "Semafor", "Visningsmaster", "Integral",
					"Facet", "Gitter", "Stribet", "Sidelinje", "Udsnit (lys)",
					"Udsnit (mørk)", "Ion (mørk)", "Austin")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("BevægElse", "Moderat", "Perspektiv", "Firkanter",
					"Overskrid", "Alfabet", "Kontrast", "Stakke", "Fliser", "Gåde",
					"Gitter", "Austin", "Eksponering", "Sidelinje", "Enkel",
					"Nålestribet", "Årlig", "Avispapir", "Tradionel")
				}
			}

		'de-'	{
				If($xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "Bewegung", "Facette", "Filigran", 
					"Gebändert", "Integral", "Ion (dunkel)", "Ion (hell)", 
					"Pfiff", "Randlinie", "Raster", "Rückblick", 
					"Segment (dunkel)", "Segment (hell)", "Semaphor", 
					"ViewMaster")
				}
				ElseIf($xWordVersion -eq $wdWord2013)
				{
					$xArray = ("Semaphor", "Segment (hell)", "Ion (hell)",
					"Raster", "Ion (dunkel)", "Filigran", "Rückblick", "Pfiff",
					"ViewMaster", "Segment (dunkel)", "Verbunden", "Bewegung",
					"Randlinie", "Austin", "Integral", "Facette")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alphabet", "Austin", "Bewegung", "Durchscheinend",
					"Herausgestellt", "Jährlich", "Kacheln", "Kontrast", "Kubistisch",
					"Modern", "Nadelstreifen", "Perspektive", "Puzzle", "Randlinie",
					"Raster", "Schlicht", "Stapel", "Traditionell", "Zeitungspapier")
				}
			}

		'en-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "Banded", "Facet", "Filigree", "Grid",
					"Integral", "Ion (Dark)", "Ion (Light)", "Motion", "Retrospect",
					"Semaphore", "Sideline", "Slice (Dark)", "Slice (Light)", "ViewMaster",
					"Whisp")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alphabet", "Annual", "Austere", "Austin", "Conservative",
					"Contrast", "Cubicles", "Exposure", "Grid", "Mod", "Motion", "Newsprint",
					"Perspective", "Pinstripes", "Puzzle", "Sideline", "Stacks", "Tiles", "Transcend")
				}
			}

		'es-'	{
				If($xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "Con bandas", "Cortar (oscuro)", "Cuadrícula", 
					"Whisp", "Faceta", "Filigrana", "Integral", "Ion (claro)", 
					"Ion (oscuro)", "Línea lateral", "Movimiento", "Retrospectiva", 
					"Semáforo", "Slice (luz)", "Vista principal", "Whisp")
				}
				ElseIf($xWordVersion -eq $wdWord2013)
				{
					$xArray = ("Whisp", "Vista principal", "Filigrana", "Austin",
					"Slice (luz)", "Faceta", "Semáforo", "Retrospectiva", "Cuadrícula",
					"Movimiento", "Cortar (oscuro)", "Línea lateral", "Ion (oscuro)",
					"Ion (claro)", "Integral", "Con bandas")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alfabeto", "Anual", "Austero", "Austin", "Conservador",
					"Contraste", "Cuadrícula", "Cubículos", "Exposición", "Línea lateral",
					"Moderno", "Mosaicos", "Movimiento", "Papel periódico",
					"Perspectiva", "Pilas", "Puzzle", "Rayas", "Sobrepasar")
				}
			}

		'fi-'	{
				If($xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Filigraani", "Integraali", "Ioni (tumma)",
					"Ioni (vaalea)", "Opastin", "Pinta", "Retro", "Sektori (tumma)",
					"Sektori (vaalea)", "Vaihtuvavärinen", "ViewMaster", "Austin",
					"Kuiskaus", "Liike", "Ruudukko", "Sivussa")
				}
				ElseIf($xWordVersion -eq $wdWord2013)
				{
					$xArray = ("Filigraani", "Integraali", "Ioni (tumma)",
					"Ioni (vaalea)", "Opastin", "Pinta", "Retro", "Sektori (tumma)",
					"Sektori (vaalea)", "Vaihtuvavärinen", "ViewMaster", "Austin",
					"Kiehkura", "Liike", "Ruudukko", "Sivussa")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Aakkoset", "Askeettinen", "Austin", "Kontrasti",
					"Laatikot", "Liike", "Liituraita", "Mod", "Osittain peitossa",
					"Palapeli", "Perinteinen", "Perspektiivi", "Pinot", "Ruudukko",
					"Ruudut", "Sanomalehtipaperi", "Sivussa", "Vuotuinen", "Ylitys")
				}
			}

		'fr-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("À bandes", "Austin", "Facette", "Filigrane", 
					"Guide", "Intégrale", "Ion (clair)", "Ion (foncé)", 
					"Lignes latérales", "Quadrillage", "Rétrospective", "Secteur (clair)", 
					"Secteur (foncé)", "Sémaphore", "ViewMaster", "Whisp")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alphabet", "Annuel", "Austère", "Austin", 
					"Blocs empilés", "Classique", "Contraste", "Emplacements de bureau", 
					"Exposition", "Guide", "Ligne latérale", "Moderne", 
					"Mosaïques", "Mots croisés", "Papier journal", "Perspective",
					"Quadrillage", "Rayures fines", "Transcendant")
				}
			}

		'nb-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "BevegElse", "Dempet", "Fasett", "Filigran",
					"Integral", "Ion (lys)", "Ion (mørk)", "Retrospekt", "Rutenett",
					"Sektor (lys)", "Sektor (mørk)", "Semafor", "Sidelinje", "Stripet",
					"ViewMaster")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alfabet", "Årlig", "Avistrykk", "Austin", "Avlukker",
					"BevegElse", "Engasjement", "Enkel", "Fliser", "Konservativ",
					"Kontrast", "Mod", "Perspektiv", "Puslespill", "Rutenett", "Sidelinje",
					"Smale striper", "Stabler", "Transcenderende")
				}
			}

		'nl-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "Beweging", "Facet", "Filigraan", "Gestreept",
					"Integraal", "Ion (donker)", "Ion (licht)", "Raster",
					"Segment (Light)", "Semafoor", "Slice (donker)", "Spriet",
					"Terugblik", "Terzijde", "ViewMaster")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Aantrekkelijk", "Alfabet", "Austin", "Bescheiden",
					"Beweging", "Blikvanger", "Contrast", "Eenvoudig", "Jaarlijks",
					"Krantenpapier", "Krijtstreep", "Kubussen", "Mod", "Perspectief",
					"Puzzel", "Raster", "Stapels",
					"Tegels", "Terzijde")
				}
			}

		'pt-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Animação", "Austin", "Em Tiras", "Exibição Mestra",
					"Faceta", "Fatia (Clara)", "Fatia (Escura)", "Filete", "Filigrana", 
					"Grade", "Integral", "Íon (Claro)", "Íon (Escuro)", "Linha Lateral",
					"Retrospectiva", "Semáforo")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alfabeto", "Animação", "Anual", "Austero", "Austin", "Baias",
					"Conservador", "Contraste", "Exposição", "Grade", "Ladrilhos",
					"Linha Lateral", "Listras", "Mod", "Papel Jornal", "Perspectiva", "Pilhas",
					"Quebra-cabeça", "Transcend")
				}
			}

		'sv-'	{
				If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ("Austin", "Band", "Fasett", "Filigran", "Integrerad", "Jon (ljust)",
					"Jon (mörkt)", "Knippe", "Rutnät", "RörElse", "Sektor (ljus)", "Sektor (mörk)",
					"Semafor", "Sidlinje", "VisaHuvudsida", "Återblick")
				}
				ElseIf($xWordVersion -eq $wdWord2010)
				{
					$xArray = ("Alfabetmönster", "Austin", "Enkelt", "Exponering", "Konservativt",
					"Kontrast", "Kritstreck", "Kuber", "Perspektiv", "Plattor", "Pussel", "Rutnät",
					"RörElse", "Sidlinje", "Sobert", "Staplat", "Tidningspapper", "Årligt",
					"Övergående")
				}
			}

		'zh-'	{
				If($xWordVersion -eq $wdWord2010 -or $xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
				{
					$xArray = ('奥斯汀', '边线型', '花丝', '怀旧', '积分',
					'离子(浅色)', '离子(深色)', '母版型', '平面', '切片(浅色)',
					'切片(深色)', '丝状', '网格', '镶边', '信号灯',
					'运动型')
				}
			}

		Default	{
					If($xWordVersion -eq $wdWord2013 -or $xWordVersion -eq $wdWord2016)
					{
						$xArray = ("Austin", "Banded", "Facet", "Filigree", "Grid",
						"Integral", "Ion (Dark)", "Ion (Light)", "Motion", "Retrospect",
						"Semaphore", "Sideline", "Slice (Dark)", "Slice (Light)", "ViewMaster",
						"Whisp")
					}
					ElseIf($xWordVersion -eq $wdWord2010)
					{
						$xArray = ("Alphabet", "Annual", "Austere", "Austin", "Conservative",
						"Contrast", "Cubicles", "Exposure", "Grid", "Mod", "Motion", "Newsprint",
						"Perspective", "Pinstripes", "Puzzle", "Sideline", "Stacks", "Tiles", "Transcend")
					}
				}
	}
	
	If($xArray -contains $xCP)
	{
		$xArray = $Null
		Return $True
	}
	Else
	{
		$xArray = $Null
		Return $False
	}
}

Function CheckWordPrereq
{
	If((Test-Path  REGISTRY::HKEY_CLASSES_ROOT\Word.Application) -eq $False)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Host "`n`n`t`tThis script directly outputs to Microsoft Word, please install Microsoft Word`n`n"
		Exit
	}

	#find out our session (usually "1" except on TS/RDC or Citrix)
	$SessionID = (Get-Process -PID $PID).SessionId
	
	#Find out if winword is running in our session
	[bool]$wordrunning = ((Get-Process 'WinWord' -ea 0)| Where-Object {$_.SessionId -eq $SessionID}) -ne $Null
	If($wordrunning)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Host "`n`n`tPlease close all instances of Microsoft Word before running this report.`n`n"
		Exit
	}
}

Function ValidateCompanyName
{
	[bool]$xResult = Test-RegistryValue "HKCU:\Software\Microsoft\Office\Common\UserInfo" "CompanyName"
	If($xResult)
	{
		Return Get-RegistryValue "HKCU:\Software\Microsoft\Office\Common\UserInfo" "CompanyName"
	}
	Else
	{
		$xResult = Test-RegistryValue "HKCU:\Software\Microsoft\Office\Common\UserInfo" "Company"
		If($xResult)
		{
			Return Get-RegistryValue "HKCU:\Software\Microsoft\Office\Common\UserInfo" "Company"
		}
		Else
		{
			Return ""
		}
	}
}

Function Set-DocumentProperty {
    <#
	.SYNOPSIS
	Function to set the Title Page document properties in MS Word
	.DESCRIPTION
	Long description
	.PARAMETER Document
	Current Document Object
	.PARAMETER DocProperty
	Parameter description
	.PARAMETER Value
	Parameter description
	.EXAMPLE
	Set-DocumentProperty -Document $Script:Doc -DocProperty Title -Value 'MyTitle'
	.EXAMPLE
	Set-DocumentProperty -Document $Script:Doc -DocProperty Company -Value 'MyCompany'
	.EXAMPLE
	Set-DocumentProperty -Document $Script:Doc -DocProperty Author -Value 'Jim Moyle'
	.EXAMPLE
	Set-DocumentProperty -Document $Script:Doc -DocProperty Subject -Value 'MySubjectTitle'
	.NOTES
	Function Created by Jim Moyle June 2017
	Twitter : @JimMoyle
	#>
    param (
        [object]$Document,
        [String]$DocProperty,
        [string]$Value
    )
    try {
        $binding = "System.Reflection.BindingFlags" -as [type]
        $builtInProperties = $Document.BuiltInDocumentProperties
        $property = [System.__ComObject].invokemember("item", $binding::GetProperty, $null, $BuiltinProperties, $DocProperty)
        [System.__ComObject].invokemember("value", $binding::SetProperty, $null, $property, $Value)
    }
    catch {
        Write-Warning "Failed to set $DocProperty to $Value"
    }
}

Function FindWordDocumentEnd
{
	#Return focus to main document    
	$Script:Doc.ActiveWindow.ActivePane.view.SeekView = $wdSeekMainDocument
	#move to the end of the current document
	$Script:Selection.EndKey($wdStory,$wdMove) | Out-Null
}

Function SetupWord
{
	Write-Verbose "$(Get-Date): Setting up Word"
    
	# Setup word for output
	Write-Verbose "$(Get-Date): Create Word comObject."
	$Script:Word = New-Object -comobject "Word.Application" -EA 0 4>$Null
	
	If(!$? -or $Null -eq $Script:Word)
	{
		Write-Warning "The Word object could not be created.  You may need to repair your Word installation."
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tThe Word object could not be created.  You may need to repair your Word installation.`n`n`t`tScript cannot continue.`n`n"
		Exit
	}

	Write-Verbose "$(Get-Date): Determine Word language value"
	If( ( validStateProp $Script:Word Language Value__ ) )
	{
		[int]$Script:WordLanguageValue = [int]$Script:Word.Language.Value__
	}
	Else
	{
		[int]$Script:WordLanguageValue = [int]$Script:Word.Language
	}

	If(!($Script:WordLanguageValue -gt -1))
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tUnable to determine the Word language value.`n`n`t`tScript cannot continue.`n`n"
		AbortScript
	}
	Write-Verbose "$(Get-Date): Word language value is $($Script:WordLanguageValue)"
	
	$Script:WordCultureCode = GetCulture $Script:WordLanguageValue
	
	SetWordHashTable $Script:WordCultureCode
	
	[int]$Script:WordVersion = [int]$Script:Word.Version
	If($Script:WordVersion -eq $wdWord2016)
	{
		$Script:WordProduct = "Word 2016"
	}
	ElseIf($Script:WordVersion -eq $wdWord2013)
	{
		$Script:WordProduct = "Word 2013"
	}
	ElseIf($Script:WordVersion -eq $wdWord2010)
	{
		$Script:WordProduct = "Word 2010"
	}
	ElseIf($Script:WordVersion -eq $wdWord2007)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tMicrosoft Word 2007 is no longer supported.`n`n`t`tScript will end.`n`n"
		AbortScript
	}
	Else
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tYou are running an untested or unsupported version of Microsoft Word.`n`n`t`tScript will end.`n`n`t`tPlease send info on your version of Word to webster@carlwebster.com`n`n"
		AbortScript
	}

	#only validate CompanyName if the field is blank
	If([String]::IsNullOrEmpty($Script:CoName))
	{
		Write-Verbose "$(Get-Date): Company name is blank.  Retrieve company name from registry."
		$TmpName = ValidateCompanyName
		
		If([String]::IsNullOrEmpty($TmpName))
		{
			Write-Warning "`n`n`t`tCompany Name is blank so Cover Page will not show a Company Name."
			Write-Warning "`n`t`tCheck HKCU:\Software\Microsoft\Office\Common\UserInfo for Company or CompanyName value."
			Write-Warning "`n`t`tYou may want to use the -CompanyName parameter if you need a Company Name on the cover page.`n`n"
		}
		Else
		{
			$Script:CoName = $TmpName
			Write-Verbose "$(Get-Date): Updated company name to $($Script:CoName)"
		}
	}

	If($Script:WordCultureCode -ne "en-")
	{
		Write-Verbose "$(Get-Date): Check Default Cover Page for $($WordCultureCode)"
		[bool]$CPChanged = $False
		Switch ($Script:WordCultureCode)
		{
			'ca-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Línia lateral"
						$CPChanged = $True
					}
				}

			'da-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Sidelinje"
						$CPChanged = $True
					}
				}

			'de-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Randlinie"
						$CPChanged = $True
					}
				}

			'es-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Línea lateral"
						$CPChanged = $True
					}
				}

			'fi-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Sivussa"
						$CPChanged = $True
					}
				}

			'fr-'	{
					If($CoverPage -eq "Sideline")
					{
						If($Script:WordVersion -eq $wdWord2013 -or $Script:WordVersion -eq $wdWord2016)
						{
							$CoverPage = "Lignes latérales"
							$CPChanged = $True
						}
						Else
						{
							$CoverPage = "Ligne latérale"
							$CPChanged = $True
						}
					}
				}

			'nb-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Sidelinje"
						$CPChanged = $True
					}
				}

			'nl-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Terzijde"
						$CPChanged = $True
					}
				}

			'pt-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Linha Lateral"
						$CPChanged = $True
					}
				}

			'sv-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "Sidlinje"
						$CPChanged = $True
					}
				}

			'zh-'	{
					If($CoverPage -eq "Sideline")
					{
						$CoverPage = "边线型"
						$CPChanged = $True
					}
				}
		}

		If($CPChanged)
		{
			Write-Verbose "$(Get-Date): Changed Default Cover Page from Sideline to $($CoverPage)"
		}
	}

	Write-Verbose "$(Get-Date): Validate cover page $($CoverPage) for culture code $($Script:WordCultureCode)"
	[bool]$ValidCP = $False
	
	$ValidCP = ValidateCoverPage $Script:WordVersion $CoverPage $Script:WordCultureCode
	
	If(!$ValidCP)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Verbose "$(Get-Date): Word language value $($Script:WordLanguageValue)"
		Write-Verbose "$(Get-Date): Culture code $($Script:WordCultureCode)"
		Write-Error "`n`n`t`tFor $($Script:WordProduct), $($CoverPage) is not a valid Cover Page option.`n`n`t`tScript cannot continue.`n`n"
		AbortScript
	}

	ShowScriptOptions

	$Script:Word.Visible = $False

	#http://jdhitsolutions.com/blog/2012/05/san-diego-2012-powershell-deep-dive-slides-and-demos/
	#using Jeff's Demo-WordReport.ps1 file for examples
	Write-Verbose "$(Get-Date): Load Word Templates"

	[bool]$Script:CoverPagesExist = $False
	[bool]$BuildingBlocksExist = $False

	$Script:Word.Templates.LoadBuildingBlocks()
	#word 2010/2013/2016
	$BuildingBlocksCollection = $Script:Word.Templates | Where-Object {$_.name -eq "Built-In Building Blocks.dotx"}

	Write-Verbose "$(Get-Date): Attempt to load cover page $($CoverPage)"
	$part = $Null

	$BuildingBlocksCollection | 
	ForEach-Object {
		If ($_.BuildingBlockEntries.Item($CoverPage).Name -eq $CoverPage) 
		{
			$BuildingBlocks = $_
		}
	}        

	If($Null -ne $BuildingBlocks)
	{
		$BuildingBlocksExist = $True

		Try 
		{
			$part = $BuildingBlocks.BuildingBlockEntries.Item($CoverPage)
		}

		Catch
		{
			$part = $Null
		}

		If($Null -ne $part)
		{
			$Script:CoverPagesExist = $True
		}
	}

	If(!$Script:CoverPagesExist)
	{
		Write-Verbose "$(Get-Date): Cover Pages are not installed or the Cover Page $($CoverPage) does not exist."
		Write-Warning "Cover Pages are not installed or the Cover Page $($CoverPage) does not exist."
		Write-Warning "This report will not have a Cover Page."
	}

	Write-Verbose "$(Get-Date): Create empty word doc"
	$Script:Doc = $Script:Word.Documents.Add()
	If($Null -eq $Script:Doc)
	{
		Write-Verbose "$(Get-Date): "
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tAn empty Word document could not be created.`n`n`t`tScript cannot continue.`n`n"
		AbortScript
	}

	$Script:Selection = $Script:Word.Selection
	If($Null -eq $Script:Selection)
	{
		Write-Verbose "$(Get-Date): "
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`n`n`t`tAn unknown error happened selecting the entire Word document for default formatting options.`n`n`t`tScript cannot continue.`n`n"
		AbortScript
	}

	#set Default tab stops to 1/2 inch (this line is not from Jeff Hicks)
	#36 = .50"
	$Script:Word.ActiveDocument.DefaultTabStop = 36

	#Disable Spell and Grammar Check to resolve issue and improve performance (from Pat Coughlin)
	Write-Verbose "$(Get-Date): Disable grammar and spell checking"
	#bug reported 1-Apr-2014 by Tim Mangan
	#save current options first before turning them off
	$Script:CurrentGrammarOption = $Script:Word.Options.CheckGrammarAsYouType
	$Script:CurrentSpellingOption = $Script:Word.Options.CheckSpellingAsYouType
	$Script:Word.Options.CheckGrammarAsYouType = $False
	$Script:Word.Options.CheckSpellingAsYouType = $False

	If($BuildingBlocksExist)
	{
		#insert new page, getting ready for table of contents
		Write-Verbose "$(Get-Date): Insert new page, getting ready for table of contents"
		$part.Insert($Script:Selection.Range,$True) | Out-Null
		$Script:Selection.InsertNewPage()

		#table of contents
		Write-Verbose "$(Get-Date): Table of Contents - $($Script:MyHash.Word_TableOfContents)"
		$toc = $BuildingBlocks.BuildingBlockEntries.Item($Script:MyHash.Word_TableOfContents)
		If($Null -eq $toc)
		{
			Write-Verbose "$(Get-Date): "
			Write-Verbose "$(Get-Date): Table of Content - $($Script:MyHash.Word_TableOfContents) could not be retrieved."
			Write-Warning "This report will not have a Table of Contents."
		}
		Else
		{
			$toc.insert($Script:Selection.Range,$True) | Out-Null
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): Table of Contents are not installed."
		Write-Warning "Table of Contents are not installed so this report will not have a Table of Contents."
	}

	#set the footer
	Write-Verbose "$(Get-Date): Set the footer"
	[string]$footertext = "Report created by $username"

	#get the footer
	Write-Verbose "$(Get-Date): Get the footer and format font"
	$Script:Doc.ActiveWindow.ActivePane.view.SeekView = $wdSeekPrimaryFooter
	#get the footer and format font
	$footers = $Script:Doc.Sections.Last.Footers
	ForEach ($footer in $footers) 
	{
		If($footer.exists) 
		{
			$footer.range.Font.name = "Calibri"
			$footer.range.Font.size = 8
			$footer.range.Font.Italic = $True
			$footer.range.Font.Bold = $True
		}
	} #end ForEach
	Write-Verbose "$(Get-Date): Footer text"
	$Script:Selection.HeaderFooter.Range.Text = $footerText

	#add page numbering
	Write-Verbose "$(Get-Date): Add page numbering"
	$Script:Selection.HeaderFooter.PageNumbers.Add($wdAlignPageNumberRight) | Out-Null

	FindWordDocumentEnd
	Write-Verbose "$(Get-Date):"
	#end of Jeff Hicks 
}

Function UpdateDocumentProperties
{
	Param([string]$AbstractTitle, [string]$SubjectTitle)
	#updated 8-Jun-2017 with additional cover page fields
	#Update document properties
	If($MSWORD -or $PDF)
	{
		If($Script:CoverPagesExist)
		{
			Write-Verbose "$(Get-Date): Set Cover Page Properties"
			#8-Jun-2017 put these 4 items in alpha order
            Set-DocumentProperty -Document $Script:Doc -DocProperty Author -Value $UserName
            Set-DocumentProperty -Document $Script:Doc -DocProperty Company -Value $Script:CoName
            Set-DocumentProperty -Document $Script:Doc -DocProperty Subject -Value $SubjectTitle
            Set-DocumentProperty -Document $Script:Doc -DocProperty Title -Value $Script:title

			#Get the Coverpage XML part
			$cp = $Script:Doc.CustomXMLParts | Where-Object {$_.NamespaceURI -match "coverPageProps$"}

			#get the abstract XML part
			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "Abstract"}
			#set the text
			If([String]::IsNullOrEmpty($Script:CoName))
			{
				[string]$abstract = $AbstractTitle
			}
			Else
			{
				[string]$abstract = "$($AbstractTitle) for $($Script:CoName)"
			}
			$ab.Text = $abstract

			#added 8-Jun-2017
			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "CompanyAddress"}
			#set the text
			[string]$abstract = $CompanyAddress
			$ab.Text = $abstract

			#added 8-Jun-2017
			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "CompanyEmail"}
			#set the text
			[string]$abstract = $CompanyEmail
			$ab.Text = $abstract

			#added 8-Jun-2017
			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "CompanyFax"}
			#set the text
			[string]$abstract = $CompanyFax
			$ab.Text = $abstract

			#added 8-Jun-2017
			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "CompanyPhone"}
			#set the text
			[string]$abstract = $CompanyPhone
			$ab.Text = $abstract

			$ab = $cp.documentelement.ChildNodes | Where-Object {$_.basename -eq "PublishDate"}
			#set the text
			[string]$abstract = (Get-Date -Format d).ToString()
			$ab.Text = $abstract

			Write-Verbose "$(Get-Date): Update the Table of Contents"
			#update the Table of Contents
			$Script:Doc.TablesOfContents.item(1).Update()
			$cp = $Null
			$ab = $Null
			$abstract = $Null
		}
	}
}
#endregion

#region registry functions
#http://stackoverflow.com/questions/5648931/test-if-registry-value-exists
# This Function just gets $True or $False
Function Test-RegistryValue($path, $name)
{
	$key = Get-Item -LiteralPath $path -EA 0
	$key -and $Null -ne $key.GetValue($name, $Null)
}

# Gets the specified registry value or $Null if it is missing
Function Get-RegistryValue($path, $name)
{
	$key = Get-Item -LiteralPath $path -EA 0
	If($key)
	{
		$key.GetValue($name, $Null)
	}
	Else
	{
		$Null
	}
}
#endregion

#region Word, text and HTML line output functions
Function line
#function created by Michael B. Smith, Exchange MVP
#@essentialexchange on Twitter
#http://TheEssentialExchange.com
#for creating the formatted text report
#created March 2011
#updated March 2014
{
	Param( [int]$tabs = 0, [string]$name = '', [string]$value = '', [string]$newline = "`r`n", [switch]$nonewline )
	While( $tabs -gt 0 ) { $Script:Output += "`t"; $tabs--; }
	If( $nonewline )
	{
		$Script:Output += $name + $value
	}
	Else
	{
		$Script:Output += $name + $value + $newline
	}
}
	
Function WriteWordLine
#Function created by Ryan Revord
#@rsrevord on Twitter
#Function created to make output to Word easy in this script
#updated 27-Mar-2014 to include font name, font size, italics and bold options
{
	Param([int]$style=0, 
	[int]$tabs = 0, 
	[string]$name = '', 
	[string]$value = '', 
	[string]$fontName=$Null,
	[int]$fontSize=0,
	[bool]$italics=$False,
	[bool]$boldface=$False,
	[Switch]$nonewline)
	
	#Build output style
	[string]$output = ""
	Switch ($style)
	{
		0 {$Script:Selection.Style = $Script:MyHash.Word_NoSpacing}
		1 {$Script:Selection.Style = $Script:MyHash.Word_Heading1}
		2 {$Script:Selection.Style = $Script:MyHash.Word_Heading2}
		3 {$Script:Selection.Style = $Script:MyHash.Word_Heading3}
		4 {$Script:Selection.Style = $Script:MyHash.Word_Heading4}
		Default {$Script:Selection.Style = $Script:MyHash.Word_NoSpacing}
	}
	
	#build # of tabs
	While($tabs -gt 0)
	{ 
		$output += "`t"; $tabs--; 
	}
 
	If(![String]::IsNullOrEmpty($fontName)) 
	{
		$Script:Selection.Font.name = $fontName
	} 

	If($fontSize -ne 0) 
	{
		$Script:Selection.Font.size = $fontSize
	} 
 
	If($italics -eq $True) 
	{
		$Script:Selection.Font.Italic = $True
	} 
 
	If($boldface -eq $True) 
	{
		$Script:Selection.Font.Bold = $True
	} 

	#output the rest of the parameters.
	$output += $name + $value
	$Script:Selection.TypeText($output)
 
	#test for new WriteWordLine 0.
	If($nonewline)
	{
		# Do nothing.
	} 
	Else 
	{
		$Script:Selection.TypeParagraph()
	}
}

#***********************************************************************************************************
# WriteHTMLLine
#***********************************************************************************************************

<#
.Synopsis
	Writes a line of output for HTML output
.DESCRIPTION
	This function formats an HTML line
.USAGE
	WriteHTMLLine <Style> <Tabs> <Name> <Value> <Font Name> <Font Size> <Options>

	0 for Font Size denotes using the default font size of 2 or 10 point

.EXAMPLE
	WriteHTMLLine 0 0 " "

	Writes a blank line with no style or tab stops, obviously none needed.

.EXAMPLE
	WriteHTMLLine 0 1 "This is a regular line of text indented 1 tab stops"

	Writes a line with 1 tab stop.

.EXAMPLE
	WriteHTMLLine 0 0 "This is a regular line of text in the default font in italics" "" $Null 0 $htmlitalics

	Writes a line omitting font and font size and setting the italics attribute

.EXAMPLE
	WriteHTMLLine 0 0 "This is a regular line of text in the default font in bold" "" $Null 0 $htmlbold

	Writes a line omitting font and font size and setting the bold attribute

.EXAMPLE
	WriteHTMLLine 0 0 "This is a regular line of text in the default font in bold italics" "" $Null 0 ($htmlbold -bor $htmlitalics)

	Writes a line omitting font and font size and setting both italics and bold options

.EXAMPLE	
	WriteHTMLLine 0 0 "This is a regular line of text in the default font in 10 point" "" $Null 2  # 10 point font

	Writes a line using 10 point font

.EXAMPLE
	WriteHTMLLine 0 0 "This is a regular line of text in Courier New font" "" "Courier New" 0 

	Writes a line using Courier New Font and 0 font point size (default = 2 if set to 0)

.EXAMPLE	
	WriteHTMLLine 0 0 "This is a regular line of RED text indented 0 tab stops with the computer name as data in 10 point Courier New bold italics: " $env:computername "Courier New" 2 ($htmlbold -bor $htmlred -bor $htmlitalics)

	Writes a line using Courier New Font with first and second string values to be used, also uses 10 point font with bold, italics and red color options set.

.NOTES

	Font Size - Unlike word, there is a limited set of font sizes that can be used in HTML.  They are:
		0 - default which actually gives it a 2 or 10 point.
		1 - 7.5 point font size
		2 - 10 point
		3 - 13.5 point
		4 - 15 point
		5 - 18 point
		6 - 24 point
		7 - 36 point
	Any number larger than 7 defaults to 7

	Style - Refers to the headers that are used with output and resemble the headers in word, HTML supports headers h1-h6 and h1-h4 are more commonly used.  Unlike word, H1 will not give you
	a blue colored font, you will have to set that yourself.

	Colors and Bold/Italics Flags are:

		htmlbold       
		htmlitalics    
		htmlred        
		htmlcyan        
		htmlblue       
		htmldarkblue   
		htmllightblue   
		htmlpurple      
		htmlyellow      
		htmllime       
		htmlmagenta     
		htmlwhite       
		htmlsilver      
		htmlgray       
		htmlolive       
		htmlorange      
		htmlmaroon      
		htmlgreen       
		htmlblack       
#>

Function WriteHTMLLine
#Function created by Ken Avram
#Function created to make output to HTML easy in this script
#headings fixed 12-Oct-2016 by Webster
#errors with $HTMLStyle fixed 7-Dec-2017 by Webster
{
	Param([int]$style=0, 
	[int]$tabs = 0, 
	[string]$name = '', 
	[string]$value = '', 
	[string]$fontName="Calibri",
	[int]$fontSize=1,
	[int]$options=$htmlblack)


	#Build output style
	[string]$output = ""

	If([String]::IsNullOrEmpty($Name))	
	{
		$HTMLBody = "<p></p>"
	}
	Else
	{
		$color = CheckHTMLColor $options

		#build # of tabs

		While($tabs -gt 0)
		{ 
			$output += "&nbsp;&nbsp;&nbsp;&nbsp;"; $tabs--; 
		}

		$HTMLFontName = $fontName		

		$HTMLBody = ""

		If($options -band $htmlitalics) 
		{
			$HTMLBody += "<i>"
		} 

		If($options -band $htmlbold) 
		{
			$HTMLBody += "<b>"
		} 

		#output the rest of the parameters.
		$output += $name + $value

		Switch ($style)
		{
			1 {$HTMLStyle = "<h1>"; Break}
			2 {$HTMLStyle = "<h2>"; Break}
			3 {$HTMLStyle = "<h3>"; Break}
			4 {$HTMLStyle = "<h4>"; Break}
			Default {$HTMLStyle = ""; Break}
		}

		$HTMLBody += $HTMLStyle + $output

		Switch ($style)
		{
			1 {$HTMLStyle = "</h1>"; Break}
			2 {$HTMLStyle = "</h2>"; Break}
			3 {$HTMLStyle = "</h3>"; Break}
			4 {$HTMLStyle = "</h4>"; Break}
			Default {$HTMLStyle = ""; Break}
		}

		#added by webster 12-oct-2016
		#if a heading, don't add the <br>
		#moved to after the two switch statements on 7-Dec-2017 to fix $HTMLStyle has not been set error
		If($HTMLStyle -eq "")
		{
			$HTMLBody += "<br><font face='" + $HTMLFontName + "' " + "color='" + $color + "' size='"  + $fontsize + "'>"
		}
		Else
		{
			$HTMLBody += "<font face='" + $HTMLFontName + "' " + "color='" + $color + "' size='"  + $fontsize + "'>"
		}
		
		$HTMLBody += $HTMLStyle +  "</font>"

		If($options -band $htmlitalics) 
		{
			$HTMLBody += "</i>"
		} 

		If($options -band $htmlbold) 
		{
			$HTMLBody += "</b>"
		} 

		#added by webster 12-oct-2016
		#if a heading, don't add the <br />
		#moved to inside the Else statement on 7-Dec-2017 to fix $HTMLStyle has not been set error
		If($HTMLStyle -eq "")
		{
			$HTMLBody += "<br />"
		}
	}

	out-file -FilePath $Script:FileName1 -Append -InputObject $HTMLBody 4>$Null
}
#endregion

#region HTML table functions
#***********************************************************************************************************
# AddHTMLTable - Called from FormatHTMLTable function
# Created by Ken Avram
# modified by Jake Rutski
#***********************************************************************************************************
Function AddHTMLTable
{
	Param([string]$fontName="Calibri",
	[int]$fontSize=2,
	[int]$colCount=0,
	[int]$rowCount=0,
	[object[]]$rowInfo=@(),
	[object[]]$fixedInfo=@())

	For($rowidx = $RowIndex;$rowidx -le $rowCount;$rowidx++)
	{
		$rd = @($rowInfo[$rowidx - 2])
		$htmlbody = $htmlbody + "<tr>"
		For($columnIndex = 0; $columnIndex -lt $colCount; $columnindex+=2)
		{
			$tmp = CheckHTMLColor $rd[$columnIndex+1]

			If($fixedInfo.Length -eq 0)
			{
				$htmlbody += "<td style=""background-color:$($tmp)""><font face='$($fontName)' size='$($fontSize)'>"
			}
			Else
			{
				$htmlbody += "<td style=""width:$($fixedInfo[$columnIndex/2]); background-color:$($tmp)""><font face='$($fontName)' size='$($fontSize)'>"
			}

			If($rd[$columnIndex+1] -band $htmlbold)
			{
				$htmlbody += "<b>"
			}
			If($rd[$columnIndex+1] -band $htmlitalics)
			{
				$htmlbody += "<i>"
			}
			If($Null -ne $rd[$columnIndex])
			{
				$cell = $rd[$columnIndex].tostring()
				If($cell -eq " " -or $cell.length -eq 0)
				{
					$htmlbody += "&nbsp;&nbsp;&nbsp;"
				}
				Else
				{
					For($i=0;$i -lt $cell.length;$i++)
					{
						If($cell[$i] -eq " ")
						{
							$htmlbody += "&nbsp;"
						}
						If($cell[$i] -ne " ")
						{
							Break
						}
					}
					$htmlbody += $cell
				}
			}
			Else
			{
				$htmlbody += "&nbsp;&nbsp;&nbsp;"
			}
			If($rd[$columnIndex+1] -band $htmlbold)
			{
				$htmlbody += "</b>"
			}
			If($rd[$columnIndex+1] -band $htmlitalics)
			{
				$htmlbody += "</i>"
			}
			$htmlbody += "</font></td>"
		}
		$htmlbody += "</tr>"
	}
	out-file -FilePath $Script:FileName1 -Append -InputObject $HTMLBody 4>$Null 
}

#***********************************************************************************************************
# FormatHTMLTable 
# Created by Ken Avram
# modified by Jake Rutski
#***********************************************************************************************************

<#
.Synopsis
	Format table for HTML output document
.DESCRIPTION
	This function formats a table for HTML from an array of strings
.PARAMETER noBorder
	If set to $true, a table will be generated without a border (border='0')
.PARAMETER noHeadCols
	This parameter should be used when generating tables without column headers
	Set this parameter equal to the number of columns in the table
.PARAMETER rowArray
	This parameter contains the row data array for the table
.PARAMETER columnArray
	This parameter contains column header data for the table
.PARAMETER fixedWidth
	This parameter contains widths for columns in pixel format ("100px") to override auto column widths
	The variable should contain a width for each column you wish to override the auto-size setting
	For example: $columnWidths = @("100px","110px","120px","130px","140px")

.USAGE
	FormatHTMLTable <Table Header> <Table Format> <Font Name> <Font Size>

.EXAMPLE
	FormatHTMLTable "Table Heading" "auto" "Calibri" 3

	This example formats a table and writes it out into an html file.  All of the parameters are optional
	defaults are used if not supplied.

	for <Table format>, the default is auto which will autofit the text into the columns and adjust to the longest text in that column.  You can also use percentage i.e. 25%
	which will take only 25% of the line and will auto word wrap the text to the next line in the column.  Also, instead of using a percentage, you can use pixels i.e. 400px.

	FormatHTMLTable "Table Heading" "auto" -rowArray $rowData -columnArray $columnData

	This example creates an HTML table with a heading of 'Table Heading', auto column spacing, column header data from $columnData and row data from $rowData

	FormatHTMLTable "Table Heading" -rowArray $rowData -noHeadCols 3

	This example creates an HTML table with a heading of 'Table Heading', auto column spacing, no header, and row data from $rowData

	FormatHTMLTable "Table Heading" -rowArray $rowData -fixedWidth $fixedColumns

	This example creates an HTML table with a heading of 'Table Heading, no header, row data from $rowData, and fixed columns defined by $fixedColumns

.NOTES
	In order to use the formatted table it first has to be loaded with data.  Examples below will show how to load the table:

	First, initialize the table array

	$rowdata = @()

	Then Load the array.  If you are using column headers then load those into the column headers array, otherwise the first line of the table goes into the column headers array
	and the second and subsequent lines go into the $rowdata table as shown below:

	$columnHeaders = @('Display Name',($htmlsilver -bor $htmlbold),'Status',($htmlsilver -bor $htmlbold),'Startup Type',($htmlsilver -bor $htmlbold))

	The first column is the actual name to display, the second are the attributes of the column i.e. color anded with bold or italics.  For the anding, parens are required or it will
	not format correctly.

	This is following by adding rowdata as shown below.  As more columns are added the columns will auto adjust to fit the size of the page.

	$rowdata = @()
	$columnHeaders = @("User Name",($htmlsilver -bor $htmlbold),$UserName,$htmlwhite)
	$rowdata += @(,('Save as PDF',($htmlsilver -bor $htmlbold),$PDF.ToString(),$htmlwhite))
	$rowdata += @(,('Save as TEXT',($htmlsilver -bor $htmlbold),$TEXT.ToString(),$htmlwhite))
	$rowdata += @(,('Save as WORD',($htmlsilver -bor $htmlbold),$MSWORD.ToString(),$htmlwhite))
	$rowdata += @(,('Save as HTML',($htmlsilver -bor $htmlbold),$HTML.ToString(),$htmlwhite))
	$rowdata += @(,('Add DateTime',($htmlsilver -bor $htmlbold),$AddDateTime.ToString(),$htmlwhite))
	$rowdata += @(,('Hardware Inventory',($htmlsilver -bor $htmlbold),$Hardware.ToString(),$htmlwhite))
	$rowdata += @(,('Computer Name',($htmlsilver -bor $htmlbold),$ComputerName,$htmlwhite))
	$rowdata += @(,('Filename1',($htmlsilver -bor $htmlbold),$Script:FileName1,$htmlwhite))
	$rowdata += @(,('OS Detected',($htmlsilver -bor $htmlbold),$Script:RunningOS,$htmlwhite))
	$rowdata += @(,('PSUICulture',($htmlsilver -bor $htmlbold),$PSCulture,$htmlwhite))
	$rowdata += @(,('PoSH version',($htmlsilver -bor $htmlbold),$Host.Version.ToString(),$htmlwhite))
	FormatHTMLTable "Example of Horizontal AutoFitContents HTML Table" -rowArray $rowdata

	The 'rowArray' paramater is mandatory to build the table, but it is not set as such in the function - if nothing is passed, the table will be empty.

	Colors and Bold/Italics Flags are shown below:

		htmlbold       
		htmlitalics    
		htmlred        
		htmlcyan        
		htmlblue       
		htmldarkblue   
		htmllightblue   
		htmlpurple      
		htmlyellow      
		htmllime       
		htmlmagenta     
		htmlwhite       
		htmlsilver      
		htmlgray       
		htmlolive       
		htmlorange      
		htmlmaroon      
		htmlgreen       
		htmlblack     

#>

Function FormatHTMLTable
{
	Param([string]$tableheader,
	[string]$tablewidth="auto",
	[string]$fontName="Calibri",
	[int]$fontSize=2,
	[switch]$noBorder=$false,
	[int]$noHeadCols=1,
	[object[]]$rowArray=@(),
	[object[]]$fixedWidth=@(),
	[object[]]$columnArray=@())

	$HTMLBody = "<b><font face='" + $fontname + "' size='" + ($fontsize + 1) + "'>" + $tableheader + "</font></b>"

	If($columnArray.Length -eq 0)
	{
		$NumCols = $noHeadCols + 1
	}  # means we have no column headers, just a table
	Else
	{
		$NumCols = $columnArray.Length
	}  # need to add one for the color attrib

	If($Null -ne $rowArray)
	{
		$NumRows = $rowArray.length + 1
	}
	Else
	{
		$NumRows = 1
	}

	If($noBorder)
	{
		$htmlbody += "<table border='0' width='" + $tablewidth + "'>"
	}
	Else
	{
		$htmlbody += "<table border='1' width='" + $tablewidth + "'>"
	}

	If(!($columnArray.Length -eq 0))
	{
		$htmlbody += "<tr>"

		For($columnIndex = 0; $columnIndex -lt $NumCols; $columnindex+=2)
		{
			$tmp = CheckHTMLColor $columnArray[$columnIndex+1]
			If($fixedWidth.Length -eq 0)
			{
				$htmlbody += "<td style=""background-color:$($tmp)""><font face='$($fontName)' size='$($fontSize)'>"
			}
			Else
			{
				$htmlbody += "<td style=""width:$($fixedWidth[$columnIndex/2]); background-color:$($tmp)""><font face='$($fontName)' size='$($fontSize)'>"
			}

			If($columnArray[$columnIndex+1] -band $htmlbold)
			{
				$htmlbody += "<b>"
			}
			If($columnArray[$columnIndex+1] -band $htmlitalics)
			{
				$htmlbody += "<i>"
			}
			If($Null -ne $columnArray[$columnIndex])
			{
				#If($columnArray[$columnIndex] -eq " " -or $columnArray[$columnIndex].length -eq 0)
				If($columnArray[$columnIndex] -eq " " -or (!$columnArray[$columnIndex] -is [array]))
				{
					$htmlbody += "&nbsp;&nbsp;&nbsp;"
				}
				Else
				{
					For($i=0;$i -lt $columnArray[$columnIndex].length;$i+=2)
					{
						If($columnArray[$columnIndex][$i] -eq " ")
						{
							$htmlbody += "&nbsp;"
						}
						If($columnArray[$columnIndex][$i] -ne " ")
						{
							Break
						}
					}
					$htmlbody += $columnArray[$columnIndex]
				}
			}
			Else
			{
				$htmlbody += "&nbsp;&nbsp;&nbsp;"
			}
			If($columnArray[$columnIndex+1] -band $htmlbold)
			{
				$htmlbody += "</b>"
			}
			If($columnArray[$columnIndex+1] -band $htmlitalics)
			{
				$htmlbody += "</i>"
			}
			$htmlbody += "</font></td>"
		}
		$htmlbody += "</tr>"
	}
	$rowindex = 2
	If($Null -ne $rowArray)
	{
		AddHTMLTable $fontName $fontSize -colCount $numCols -rowCount $NumRows -rowInfo $rowArray -fixedInfo $fixedWidth
		$rowArray = @()
		$htmlbody = "</table>"
	}
	Else
	{
		$HTMLBody += "</table>"
	}	
	out-file -FilePath $Script:FileName1 -Append -InputObject $HTMLBody 4>$Null 
}
#endregion

#region other HTML functions
#***********************************************************************************************************
# CheckHTMLColor - Called from AddHTMLTable WriteHTMLLine and FormatHTMLTable
#***********************************************************************************************************
Function CheckHTMLColor
{
	Param($hash)

	If($hash -band $htmlwhite)
	{
		Return $htmlwhitemask
	}
	If($hash -band $htmlred)
	{
		Return $htmlredmask
	}
	If($hash -band $htmlcyan)
	{
		Return $htmlcyanmask
	}
	If($hash -band $htmlblue)
	{
		Return $htmlbluemask
	}
	If($hash -band $htmldarkblue)
	{
		Return $htmldarkbluemask
	}
	If($hash -band $htmllightblue)
	{
		Return $htmllightbluemask
	}
	If($hash -band $htmlpurple)
	{
		Return $htmlpurplemask
	}
	If($hash -band $htmlyellow)
	{
		Return $htmlyellowmask
	}
	If($hash -band $htmllime)
	{
		Return $htmllimemask
	}
	If($hash -band $htmlmagenta)
	{
		Return $htmlmagentamask
	}
	If($hash -band $htmlsilver)
	{
		Return $htmlsilvermask
	}
	If($hash -band $htmlgray)
	{
		Return $htmlgraymask
	}
	If($hash -band $htmlblack)
	{
		Return $htmlblackmask
	}
	If($hash -band $htmlorange)
	{
		Return $htmlorangemask
	}
	If($hash -band $htmlmaroon)
	{
		Return $htmlmaroonmask
	}
	If($hash -band $htmlgreen)
	{
		Return $htmlgreenmask
	}
	If($hash -band $htmlolive)
	{
		Return $htmlolivemask
	}
}

Function SetupHTML
{
	Write-Verbose "$(Get-Date): Setting up HTML"
	If(!$AddDateTime)
	{
		[string]$Script:FileName1 = "$($pwdpath)\$($OutputFileName).html"
	}
	ElseIf($AddDateTime)
	{
		[string]$Script:FileName1 = "$($pwdpath)\$($OutputFileName)_$(Get-Date -f yyyy-MM-dd_HHmm).html"
	}

	$htmlhead = "<html><head><meta http-equiv='Content-Language' content='da'><title>" + $Script:Title + "</title></head><body>"
	out-file -FilePath $Script:Filename1 -Force -InputObject $HTMLHead 4>$Null
}
#endregion

#region Iain's Word table functions

<#
.Synopsis
	Add a table to a Microsoft Word document
.DESCRIPTION
	This function adds a table to a Microsoft Word document from either an array of
	Hashtables or an array of PSCustomObjects.

	Using this function is quicker than setting each table cell individually but can
	only utilise the built-in MS Word table autoformats. Individual tables cells can
	be altered after the table has been appended to the document (a table reference
	is Returned).
.EXAMPLE
	AddWordTable -Hashtable $HashtableArray

	This example adds table to the MS Word document, utilising all key/value pairs in
	the array of hashtables. Column headers will display the key names as defined.
	Note: the columns might not be displayed in the order that they were defined. To
	ensure columns are displayed in the required order utilise the -Columns parameter.
.EXAMPLE
	AddWordTable -Hashtable $HashtableArray -List

	This example adds table to the MS Word document, utilising all key/value pairs in
	the array of hashtables. No column headers will be added, in a ListView format.
	Note: the columns might not be displayed in the order that they were defined. To
	ensure columns are displayed in the required order utilise the -Columns parameter.
.EXAMPLE
	AddWordTable -CustomObject $PSCustomObjectArray

	This example adds table to the MS Word document, utilising all note property names
	the array of PSCustomObjects. Column headers will display the note property names.
	Note: the columns might not be displayed in the order that they were defined. To
	ensure columns are displayed in the required order utilise the -Columns parameter.
.EXAMPLE
	AddWordTable -Hashtable $HashtableArray -Columns FirstName,LastName,EmailAddress

	This example adds a table to the MS Word document, but only using the specified
	key names: FirstName, LastName and EmailAddress. If other keys are present in the
	array of Hashtables they will be ignored.
.EXAMPLE
	AddWordTable -CustomObject $PSCustomObjectArray -Columns FirstName,LastName,EmailAddress -Headers "First Name","Last Name","Email Address"

	This example adds a table to the MS Word document, but only using the specified
	PSCustomObject note properties: FirstName, LastName and EmailAddress. If other note
	properties are present in the array of PSCustomObjects they will be ignored. The
	display names for each specified column header has been overridden to display a
	custom header. Note: the order of the header names must match the specified columns.
#>

Function AddWordTable
{
	[CmdletBinding()]
	Param
	(
		# Array of Hashtable (including table headers)
		[Parameter(Mandatory=$True, ValueFromPipelineByPropertyName=$True, ParameterSetName='Hashtable', Position=0)]
		[ValidateNotNullOrEmpty()] [System.Collections.Hashtable[]] $Hashtable,
		# Array of PSCustomObjects
		[Parameter(Mandatory=$True, ValueFromPipelineByPropertyName=$True, ParameterSetName='CustomObject', Position=0)]
		[ValidateNotNullOrEmpty()] [PSCustomObject[]] $CustomObject,
		# Array of Hashtable key names or PSCustomObject property names to include, in display order.
		# If not supplied then all Hashtable keys or all PSCustomObject properties will be displayed.
		[Parameter(ValueFromPipelineByPropertyName=$True)] [AllowNull()] [string[]] $Columns = $Null,
		# Array of custom table header strings in display order.
		[Parameter(ValueFromPipelineByPropertyName=$True)] [AllowNull()] [string[]] $Headers = $Null,
		# AutoFit table behavior.
		[Parameter(ValueFromPipelineByPropertyName=$True)] [AllowNull()] [int] $AutoFit = -1,
		# List view (no headers)
		[Switch] $List,
		# Grid lines
		[Switch] $NoGridLines,
		[Switch] $NoInternalGridLines,
		# Built-in Word table formatting style constant
		# Would recommend only $wdTableFormatContempory for normal usage (possibly $wdTableFormatList5 for List view)
		[Parameter(ValueFromPipelineByPropertyName=$True)] [int] $Format = 0
	)

	Begin 
	{
		Write-Debug ("Using parameter set '{0}'" -f $PSCmdlet.ParameterSetName);
		## Check if -Columns wasn't specified but -Headers were (saves some additional parameter sets!)
		If(($Null -eq $Columns) -and ($Null -eq $Headers)) 
		{
			Write-Warning "No columns specified and therefore, specified headers will be ignored.";
			$Columns = $Null;
		}
		ElseIf(($Null -ne $Columns) -and ($Null -ne $Headers)) 
		{
			## Check if number of specified -Columns matches number of specified -Headers
			If($Columns.Length -ne $Headers.Length) 
			{
				Write-Error "The specified number of columns does not match the specified number of headers.";
			}
		} ## end elseif
	} ## end Begin

	Process
	{
		## Build the Word table data string to be converted to a range and then a table later.
		[System.Text.StringBuilder] $WordRangeString = New-Object System.Text.StringBuilder;

		Switch ($PSCmdlet.ParameterSetName) 
		{
			'CustomObject' 
			{
				If($Null -eq $Columns) 
				{
					## Build the available columns from all availble PSCustomObject note properties
					[string[]] $Columns = @();
					## Add each NoteProperty name to the array
					ForEach($Property in ($CustomObject | Get-Member -MemberType NoteProperty)) 
					{ 
						$Columns += $Property.Name; 
					}
				}

				## Add the table headers from -Headers or -Columns (except when in -List(view)
				If(-not $List) 
				{
					Write-Debug ("$(Get-Date): `t`tBuilding table headers");
					If($Null -ne $Headers) 
					{
                        [ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $Headers));
					}
					Else 
					{ 
                        [ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $Columns));
					}
				}

				## Iterate through each PSCustomObject
				Write-Debug ("$(Get-Date): `t`tBuilding table rows");
				ForEach($Object in $CustomObject) 
				{
					$OrderedValues = @();
					## Add each row item in the specified order
					ForEach($Column in $Columns) 
					{ 
						$OrderedValues += $Object.$Column; 
					}
					## Use the ordered list to add each column in specified order
					[ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $OrderedValues));
				} ## end ForEach
				Write-Debug ("$(Get-Date): `t`t`tAdded '{0}' table rows" -f ($CustomObject.Count));
			} ## end CustomObject

			Default 
			{   ## Hashtable
				If($Null -eq $Columns) 
				{
					## Build the available columns from all available hashtable keys. Hopefully
					## all Hashtables have the same keys (they should for a table).
					$Columns = $Hashtable[0].Keys;
				}

				## Add the table headers from -Headers or -Columns (except when in -List(view)
				If(-not $List) 
				{
					Write-Debug ("$(Get-Date): `t`tBuilding table headers");
					If($Null -ne $Headers) 
					{ 
						[ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $Headers));
					}
					Else 
					{
						[ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $Columns));
					}
				}
                
				## Iterate through each Hashtable
				Write-Debug ("$(Get-Date): `t`tBuilding table rows");
				ForEach($Hash in $Hashtable) 
				{
					$OrderedValues = @();
					## Add each row item in the specified order
					ForEach($Column in $Columns) 
					{ 
						$OrderedValues += $Hash.$Column; 
					}
					## Use the ordered list to add each column in specified order
					[ref] $Null = $WordRangeString.AppendFormat("{0}`n", [string]::Join("`t", $OrderedValues));
				} ## end ForEach

				Write-Debug ("$(Get-Date): `t`t`tAdded '{0}' table rows" -f $Hashtable.Count);
			} ## end default
		} ## end switch

		## Create a MS Word range and set its text to our tab-delimited, concatenated string
		Write-Debug ("$(Get-Date): `t`tBuilding table range");
		$WordRange = $Script:Doc.Application.Selection.Range;
		$WordRange.Text = $WordRangeString.ToString();

		## Create hash table of named arguments to pass to the ConvertToTable method
		$ConvertToTableArguments = @{ Separator = [Microsoft.Office.Interop.Word.WdTableFieldSeparator]::wdSeparateByTabs; }

		## Negative built-in styles are not supported by the ConvertToTable method
		If($Format -ge 0) 
		{
			$ConvertToTableArguments.Add("Format", $Format);
			$ConvertToTableArguments.Add("ApplyBorders", $True);
			$ConvertToTableArguments.Add("ApplyShading", $True);
			$ConvertToTableArguments.Add("ApplyFont", $True);
			$ConvertToTableArguments.Add("ApplyColor", $True);
			If(!$List) 
			{ 
				$ConvertToTableArguments.Add("ApplyHeadingRows", $True); 
			}
			$ConvertToTableArguments.Add("ApplyLastRow", $True);
			$ConvertToTableArguments.Add("ApplyFirstColumn", $True);
			$ConvertToTableArguments.Add("ApplyLastColumn", $True);
		}

		## Invoke ConvertToTable method - with named arguments - to convert Word range to a table
		## See http://msdn.microsoft.com/en-us/library/office/aa171893(v=office.11).aspx
		Write-Debug ("$(Get-Date): `t`tConverting range to table");
		## Store the table reference just in case we need to set alternate row coloring
		$WordTable = $WordRange.GetType().InvokeMember(
			"ConvertToTable",                               # Method name
			[System.Reflection.BindingFlags]::InvokeMethod, # Flags
			$Null,                                          # Binder
			$WordRange,                                     # Target (self!)
			([Object[]]($ConvertToTableArguments.Values)),  ## Named argument values
			$Null,                                          # Modifiers
			$Null,                                          # Culture
			([String[]]($ConvertToTableArguments.Keys))     ## Named argument names
		);

		## Implement grid lines (will wipe out any existing formatting
		If($Format -lt 0) 
		{
			Write-Debug ("$(Get-Date): `t`tSetting table format");
			$WordTable.Style = $Format;
		}

		## Set the table autofit behavior
		If($AutoFit -ne -1) 
		{ 
			$WordTable.AutoFitBehavior($AutoFit); 
		}

		If(!$List)
		{
			#the next line causes the heading row to flow across page breaks
			$WordTable.Rows.First.Headingformat = $wdHeadingFormatTrue;
		}

		If(!$NoGridLines) 
		{
			$WordTable.Borders.InsideLineStyle = $wdLineStyleSingle;
			$WordTable.Borders.OutsideLineStyle = $wdLineStyleSingle;
		}
		If($NoGridLines) 
		{
			$WordTable.Borders.InsideLineStyle = $wdLineStyleNone;
			$WordTable.Borders.OutsideLineStyle = $wdLineStyleNone;
		}
		If($NoInternalGridLines) 
		{
			$WordTable.Borders.InsideLineStyle = $wdLineStyleNone;
			$WordTable.Borders.OutsideLineStyle = $wdLineStyleSingle;
		}

		Return $WordTable;

	} ## end Process
}

<#
.Synopsis
	Sets the format of one or more Word table cells
.DESCRIPTION
	This function sets the format of one or more table cells, either from a collection
	of Word COM object cell references, an individual Word COM object cell reference or
	a hashtable containing Row and Column information.

	The font name, font size, bold, italic , underline and shading values can be used.
.EXAMPLE
	SetWordCellFormat -Hashtable $Coordinates -Table $TableReference -Bold

	This example sets all text to bold that is contained within the $TableReference
	Word table, using an array of hashtables. Each hashtable contain a pair of co-
	ordinates that is used to select the required cells. Note: the hashtable must
	contain the .Row and .Column key names. For example:
	@ { Row = 7; Column = 3 } to set the cell at row 7 and column 3 to bold.
.EXAMPLE
	$RowCollection = $Table.Rows.First.Cells
	SetWordCellFormat -Collection $RowCollection -Bold -Size 10

	This example sets all text to size 8 and bold for all cells that are contained
	within the first row of the table.
	Note: the $Table.Rows.First.Cells Returns a collection of Word COM cells objects
	that are in the first table row.
.EXAMPLE
	$ColumnCollection = $Table.Columns.Item(2).Cells
	SetWordCellFormat -Collection $ColumnCollection -BackgroundColor 255

	This example sets the background (shading) of all cells in the table's second
	column to red.
	Note: the $Table.Columns.Item(2).Cells Returns a collection of Word COM cells objects
	that are in the table's second column.
.EXAMPLE
	SetWordCellFormat -Cell $Table.Cell(17,3) -Font "Tahoma" -Color 16711680

	This example sets the font to Tahoma and the text color to blue for the cell located
	in the table's 17th row and 3rd column.
	Note: the $Table.Cell(17,3) Returns a single Word COM cells object.
#>

Function SetWordCellFormat 
{
	[CmdletBinding(DefaultParameterSetName='Collection')]
	Param (
		# Word COM object cell collection reference
		[Parameter(Mandatory=$True, ValueFromPipeline=$True, ParameterSetName='Collection', Position=0)] [ValidateNotNullOrEmpty()] $Collection,
		# Word COM object individual cell reference
		[Parameter(Mandatory=$True, ParameterSetName='Cell', Position=0)] [ValidateNotNullOrEmpty()] $Cell,
		# Hashtable of cell co-ordinates
		[Parameter(Mandatory=$True, ParameterSetName='Hashtable', Position=0)] [ValidateNotNullOrEmpty()] [System.Collections.Hashtable[]] $Coordinates,
		# Word COM object table reference
		[Parameter(Mandatory=$True, ParameterSetName='Hashtable', Position=1)] [ValidateNotNullOrEmpty()] $Table,
		# Font name
		[Parameter()] [AllowNull()] [string] $Font = $Null,
		# Font color
		[Parameter()] [AllowNull()] $Color = $Null,
		# Font size
		[Parameter()] [ValidateNotNullOrEmpty()] [int] $Size = 0,
		# Cell background color
		[Parameter()] [AllowNull()] $BackgroundColor = $Null,
		# Force solid background color
		[Switch] $Solid,
		[Switch] $Bold,
		[Switch] $Italic,
		[Switch] $Underline
	)

	Begin 
	{
		Write-Debug ("Using parameter set '{0}'." -f $PSCmdlet.ParameterSetName);
	}

	Process 
	{
		Switch ($PSCmdlet.ParameterSetName) 
		{
			'Collection' {
				ForEach($Cell in $Collection) 
				{
					If($Null -ne $BackgroundColor) { $Cell.Shading.BackgroundPatternColor = $BackgroundColor; }
					If($Bold) { $Cell.Range.Font.Bold = $True; }
					If($Italic) { $Cell.Range.Font.Italic = $True; }
					If($Underline) { $Cell.Range.Font.Underline = 1; }
					If($Null -ne $Font) { $Cell.Range.Font.Name = $Font; }
					If($Null -ne $Color) { $Cell.Range.Font.Color = $Color; }
					If($Size -ne 0) { $Cell.Range.Font.Size = $Size; }
					If($Solid) { $Cell.Shading.Texture = 0; } ## wdTextureNone
				} # end ForEach
			} # end Collection
			'Cell' 
			{
				If($Bold) { $Cell.Range.Font.Bold = $True; }
				If($Italic) { $Cell.Range.Font.Italic = $True; }
				If($Underline) { $Cell.Range.Font.Underline = 1; }
				If($Null -ne $Font) { $Cell.Range.Font.Name = $Font; }
				If($Null -ne $Color) { $Cell.Range.Font.Color = $Color; }
				If($Size -ne 0) { $Cell.Range.Font.Size = $Size; }
				If($Null -ne $BackgroundColor) { $Cell.Shading.BackgroundPatternColor = $BackgroundColor; }
				If($Solid) { $Cell.Shading.Texture = 0; } ## wdTextureNone
			} # end Cell
			'Hashtable' 
			{
				ForEach($Coordinate in $Coordinates) 
				{
					$Cell = $Table.Cell($Coordinate.Row, $Coordinate.Column);
					If($Bold) { $Cell.Range.Font.Bold = $True; }
					If($Italic) { $Cell.Range.Font.Italic = $True; }
					If($Underline) { $Cell.Range.Font.Underline = 1; }
					If($Null -ne $Font) { $Cell.Range.Font.Name = $Font; }
					If($Null -ne $Color) { $Cell.Range.Font.Color = $Color; }
					If($Size -ne 0) { $Cell.Range.Font.Size = $Size; }
					If($Null -ne $BackgroundColor) { $Cell.Shading.BackgroundPatternColor = $BackgroundColor; }
					If($Solid) { $Cell.Shading.Texture = 0; } ## wdTextureNone
				}
			} # end Hashtable
		} # end switch
	} # end process
}

<#
.Synopsis
	Sets alternate row colors in a Word table
.DESCRIPTION
	This function sets the format of alternate rows within a Word table using the
	specified $BackgroundColor. This function is expensive (in performance terms) as
	it recursively sets the format on alternate rows. It would be better to pick one
	of the predefined table formats (if one exists)? Obviously the more rows, the
	longer it takes :'(

	Note: this function is called by the AddWordTable function if an alternate row
	format is specified.
.EXAMPLE
	SetWordTableAlternateRowColor -Table $TableReference -BackgroundColor 255

	This example sets every-other table (starting with the first) row and sets the
	background color to red (wdColorRed).
.EXAMPLE
	SetWordTableAlternateRowColor -Table $TableReference -BackgroundColor 39423 -Seed Second

	This example sets every other table (starting with the second) row and sets the
	background color to light orange (weColorLightOrange).
#>

Function SetWordTableAlternateRowColor 
{
	[CmdletBinding()]
	Param (
		# Word COM object table reference
		[Parameter(Mandatory=$True, ValueFromPipeline=$True, Position=0)] [ValidateNotNullOrEmpty()] $Table,
		# Alternate row background color
		[Parameter(Mandatory=$True, Position=1)] [ValidateNotNull()] [int] $BackgroundColor,
		# Alternate row starting seed
		[Parameter(ValueFromPipelineByPropertyName=$True, Position=2)] [ValidateSet('First','Second')] [string] $Seed = 'First'
	)

	Process 
	{
		$StartDateTime = Get-Date;
		Write-Debug ("{0}: `t`tSetting alternate table row colors.." -f $StartDateTime);

		## Determine the row seed (only really need to check for 'Second' and default to 'First' otherwise
		If($Seed.ToLower() -eq 'second') 
		{ 
			$StartRowIndex = 2; 
		}
		Else 
		{ 
			$StartRowIndex = 1; 
		}

		For($AlternateRowIndex = $StartRowIndex; $AlternateRowIndex -lt $Table.Rows.Count; $AlternateRowIndex += 2) 
		{ 
			$Table.Rows.Item($AlternateRowIndex).Shading.BackgroundPatternColor = $BackgroundColor;
		}

		## I've put verbose calls in here we can see how expensive this functionality actually is.
		$EndDateTime = Get-Date;
		$ExecutionTime = New-TimeSpan -Start $StartDateTime -End $EndDateTime;
		Write-Debug ("{0}: `t`tDone setting alternate row style color in '{1}' seconds" -f $EndDateTime, $ExecutionTime.TotalSeconds);
	}
}
#endregion

#region general script functions
Function CheckExcelPrereq
{
	If((Test-Path  REGISTRY::HKEY_CLASSES_ROOT\Excel.Application) -eq $False)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Host "`n`n`t`tFor the Delivery Groups Utilization option, this script directly outputs to Microsoft Excel, `n`t`tplease install Microsoft Excel or do not use the DeliveryGroupsUtilization (DGU) switch`n`n"
		Exit
	}

	#find out our session (usually "1" except on TS/RDC or Citrix)
	$SessionID = (Get-Process -PID $PID).SessionId
	
	#Find out if excel is running in our session
	[bool]$excelrunning = ((Get-Process 'Excel' -ea 0) | Where-Object {$_.SessionId -eq $SessionID}) -ne $Null
	If($excelrunning)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Host "`n`n`tPlease close all instances of Microsoft Excel before running this report.`n`n"
		Exit
	}
}

Function Check-LoadedModule
#Function created by Jeff Wouters
#@JeffWouters on Twitter
#modified by Michael B. Smith to handle when the module doesn't exist on server
#modified by @andyjmorgan
#bug fixed by @schose
#bug fixed by Peter Bosen
#This Function handles all three scenarios:
#
# 1. Module is already imported into current session
# 2. Module is not already imported into current session, it does exists on the server and is imported
# 3. Module does not exist on the server

{
	Param([parameter(Mandatory = $True)][alias("Module")][string]$ModuleName)
	#$LoadedModules = Get-Module | Select-Object Name
	#following line changed at the recommendation of @andyjmorgan
	$LoadedModules = Get-Module | ForEach-Object { $_.Name.ToString() }
	#bug reported on 21-JAN-2013 by @schose 
	#the following line did not work if the citrix.grouppolicy.commands.psm1 module
	#was manually loaded from a non Default folder
	#$ModuleFound = (!$LoadedModules -like "*$ModuleName*")
	
	#11-Jun-2017 change from [bool] to ][string]
	[string]$ModuleFound = ($LoadedModules -like "*$ModuleName*")
	If($ModuleFound -ne $ModuleName) 
	{
		$module = Import-Module -Name $ModuleName -PassThru -EA 0 4>$Null
		If($module -and $?)
		{
			# module imported properly
			Return $True
		}
		Else
		{
			# module import failed
			Return $False
		}
	}
	Else
	{
		#module already imported into current session
		Return $True
	}
}

Function Check-NeededPSSnapins
{
	Param([parameter(Mandatory = $True)][alias("Snapin")][string[]]$Snapins)

	#Function specifics
	$MissingSnapins = @()
	[bool]$FoundMissingSnapin = $False
	$LoadedSnapins = @()
	$RegisteredSnapins = @()

	#Creates arrays of strings, rather than objects, we're passing strings so this will be more robust.
	$loadedSnapins += get-pssnapin | ForEach-Object {$_.name}
	$registeredSnapins += get-pssnapin -Registered | ForEach-Object {$_.name}

	ForEach($Snapin in $Snapins)
	{
		#check if the snapin is loaded
		If(!($LoadedSnapins -like $snapin))
		{
			#Check if the snapin is missing
			If(!($RegisteredSnapins -like $Snapin))
			{
				#set the flag if it's not already
				If(!($FoundMissingSnapin))
				{
					$FoundMissingSnapin = $True
				}
				#add the entry to the list
				$MissingSnapins += $Snapin
			}
			Else
			{
				#Snapin is registered, but not loaded, loading it now:
				Add-PSSnapin -Name $snapin -EA 0 *>$Null
			}
		}
	}

	If($FoundMissingSnapin)
	{
		Write-Warning "Missing Windows PowerShell snap-ins Detected:"
		$missingSnapins | ForEach-Object {Write-Warning "($_)"}
		Return $False
	}
	Else
	{
		Return $True
	}
}

Function SaveandCloseDocumentandShutdownWord
{
	#bug fix 1-Apr-2014
	#reset Grammar and Spelling options back to their original settings
	$Script:Word.Options.CheckGrammarAsYouType = $Script:CurrentGrammarOption
	$Script:Word.Options.CheckSpellingAsYouType = $Script:CurrentSpellingOption

	Write-Verbose "$(Get-Date): Save and Close document and Shutdown Word"
	If($Script:WordVersion -eq $wdWord2010)
	{
		#the $saveFormat below passes StrictMode 2
		#I found this at the following two links
		#http://blogs.technet.com/b/bshukla/archive/2011/09/27/3347395.aspx
		#http://msdn.microsoft.com/en-us/library/microsoft.office.interop.word.wdsaveformat(v=office.14).aspx
		If($PDF)
		{
			Write-Verbose "$(Get-Date): Saving as DOCX file first before saving to PDF"
		}
		Else
		{
			Write-Verbose "$(Get-Date): Saving DOCX file"
		}
		If($AddDateTime)
		{
			$Script:FileName1 += "_$(Get-Date -f yyyy-MM-dd_HHmm).docx"
			If($PDF)
			{
				$Script:FileName2 += "_$(Get-Date -f yyyy-MM-dd_HHmm).pdf"
			}
		}
		Write-Verbose "$(Get-Date): Running $($Script:WordProduct) and detected operating system $($Script:RunningOS)"
		$saveFormat = [Enum]::Parse([Microsoft.Office.Interop.Word.WdSaveFormat], "wdFormatDocumentDefault")
		$Script:Doc.SaveAs([REF]$Script:FileName1, [ref]$SaveFormat)
		If($PDF)
		{
			Write-Verbose "$(Get-Date): Now saving as PDF"
			$saveFormat = [Enum]::Parse([Microsoft.Office.Interop.Word.WdSaveFormat], "wdFormatPDF")
			$Script:Doc.SaveAs([REF]$Script:FileName2, [ref]$saveFormat)
		}
	}
	ElseIf($Script:WordVersion -eq $wdWord2013 -or $Script:WordVersion -eq $wdWord2016)
	{
		If($PDF)
		{
			Write-Verbose "$(Get-Date): Saving as DOCX file first before saving to PDF"
		}
		Else
		{
			Write-Verbose "$(Get-Date): Saving DOCX file"
		}
		If($AddDateTime)
		{
			$Script:FileName1 += "_$(Get-Date -f yyyy-MM-dd_HHmm).docx"
			If($PDF)
			{
				$Script:FileName2 += "_$(Get-Date -f yyyy-MM-dd_HHmm).pdf"
			}
		}
		Write-Verbose "$(Get-Date): Running $($Script:WordProduct) and detected operating system $($Script:RunningOS)"
		$Script:Doc.SaveAs2([ref]$Script:FileName1, [ref]$wdFormatDocumentDefault)
		If($PDF)
		{
			Write-Verbose "$(Get-Date): Now saving as PDF"
			$Script:Doc.SaveAs([ref]$Script:FileName2, [ref]$wdFormatPDF)
		}
	}

	Write-Verbose "$(Get-Date): Closing Word"
	$Script:Doc.Close()
	$Script:Word.Quit()
	If($PDF)
	{
		[int]$cnt = 0
		While(Test-Path $Script:FileName1)
		{
			$cnt++
			If($cnt -gt 1)
			{
				Write-Verbose "$(Get-Date): Waiting another 10 seconds to allow Word to fully close (try # $($cnt))"
				Start-Sleep -Seconds 10
				$Script:Word.Quit()
				If($cnt -gt 2)
				{
					#kill the winword process

					#find out our session (usually "1" except on TS/RDC or Citrix)
					$SessionID = (Get-Process -PID $PID).SessionId
					
					#Find out if winword is running in our session
					$wordprocess = ((Get-Process 'WinWord' -ea 0) | Where-Object {$_.SessionId -eq $SessionID}).Id
					If($wordprocess -gt 0)
					{
						Write-Verbose "$(Get-Date): Attempting to stop WinWord process # $($wordprocess)"
						Stop-Process $wordprocess -EA 0
					}
				}
			}
			Write-Verbose "$(Get-Date): Attempting to delete $($Script:FileName1) since only $($Script:FileName2) is needed (try # $($cnt))"
			Remove-Item $Script:FileName1 -EA 0 4>$Null
		}
	}
	Write-Verbose "$(Get-Date): System Cleanup"
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Script:Word) | Out-Null
	If(Test-Path variable:global:word)
	{
		Remove-Variable -Name word -Scope Global 4>$Null
	}
	$SaveFormat = $Null
	[gc]::collect() 
	[gc]::WaitForPendingFinalizers()
	
	#is the winword process still running? kill it

	#find out our session (usually "1" except on TS/RDC or Citrix)
	$SessionID = (Get-Process -PID $PID).SessionId

	#Find out if winword is running in our session
	$wordprocess = $Null
	$wordprocess = ((Get-Process 'WinWord' -ea 0) | Where-Object {$_.SessionId -eq $SessionID}).Id
	If($null -ne $wordprocess -and $wordprocess -gt 0)
	{
		Write-Verbose "$(Get-Date): WinWord process is still running. Attempting to stop WinWord process # $($wordprocess)"
		Stop-Process $wordprocess -EA 0
	}
}

Function SaveandCloseTextDocument
{
	If($AddDateTime)
	{
		$Script:FileName1 += "_$(Get-Date -f yyyy-MM-dd_HHmm).txt"
	}

	Write-Output $Script:Output | Out-File $Script:Filename1 4>$Null
}

Function SaveandCloseHTMLDocument
{
	Out-File -FilePath $Script:FileName1 -Append -InputObject "<p></p></body></html>" 4>$Null
}

Function SetFileName1andFileName2
{
	Param([string]$OutputFileName)
	
	If($Folder -eq "")
	{
		$pwdpath = $pwd.Path
	}
	Else
	{
		$pwdpath = $Folder
	}

	If($pwdpath.EndsWith("\"))
	{
		#remove the trailing \
		$pwdpath = $pwdpath.SubString(0, ($pwdpath.Length - 1))
	}

	#set $Script:Filename1 and $Script:Filename2 with no file extension
	If($AddDateTime)
	{
		[string]$Script:FileName1 = "$($pwdpath)\$($OutputFileName)"
		If($PDF)
		{
			[string]$Script:FileName2 = "$($pwdpath)\$($OutputFileName)"
		}
	}

	If($MSWord -or $PDF)
	{
		CheckWordPreReq
		
		If($DeliveryGroupsUtilization)
		{
			CheckExcelPreReq
		}

		If(!$AddDateTime)
		{
			[string]$Script:FileName1 = "$($pwdpath)\$($OutputFileName).docx"
			If($PDF)
			{
				[string]$Script:FileName2 = "$($pwdpath)\$($OutputFileName).pdf"
			}
		}

		SetupWord
	}
	ElseIf($Text)
	{
		If(!$AddDateTime)
		{
			[string]$Script:FileName1 = "$($pwdpath)\$($OutputFileName).txt"
		}
		ShowScriptOptions
	}
	ElseIf($HTML)
	{
		SetupHTML
		ShowScriptOptions
	}
}

Function ProcessDocumentOutput
{
	If($MSWORD -or $PDF)
	{
		SaveandCloseDocumentandShutdownWord
	}
	ElseIf($Text)
	{
		SaveandCloseTextDocument
	}
	ElseIf($HTML)
	{
		SaveandCloseHTMLDocument
	}

	$GotFile = $False

	If($PDF)
	{
		If(Test-Path "$($Script:FileName2)")
		{
			Write-Verbose "$(Get-Date): $($Script:FileName2) is ready for use"
			$GotFile = $True
		}
		Else
		{
			Write-Warning "$(Get-Date): Unable to save the output file, $($Script:FileName2)"
			Write-Error "Unable to save the output file, $($Script:FileName2)"
		}
	}
	Else
	{
		If(Test-Path "$($Script:FileName1)")
		{
			Write-Verbose "$(Get-Date): $($Script:FileName1) is ready for use"
			$GotFile = $True
		}
		Else
		{
			Write-Warning "$(Get-Date): Unable to save the output file, $($Script:FileName1)"
			Write-Error "Unable to save the output file, $($Script:FileName1)"
		}
	}
	
	#email output file if requested
	If($GotFile -and ![System.String]::IsNullOrEmpty( $SmtpServer ))
	{
		If($PDF)
		{
			$emailAttachment = $Script:FileName2
		}
		Else
		{
			$emailAttachment = $Script:FileName1
		}
		SendEmail $emailAttachment
	}
}

Function ShowScriptOptions
{
	Write-Verbose "$(Get-Date): "
	Write-Verbose "$(Get-Date): "
	Write-Verbose "$(Get-Date): AddDateTime     : $($AddDateTime)"
	Write-Verbose "$(Get-Date): AdminAddress    : $($AdminAddress)"
	Write-Verbose "$(Get-Date): Administrators  : $($Administrators)"
	Write-Verbose "$(Get-Date): Applications    : $($Applications)"
	If($MSWORD -or $PDF)
	{
		Write-Verbose "$(Get-Date): Company Name    : $($Script:CoName)"
		Write-Verbose "$(Get-Date): Company Address : $($CompanyAddress)"
		Write-Verbose "$(Get-Date): Company Email   : $($CompanyEmail)"
		Write-Verbose "$(Get-Date): Company Fax     : $($CompanyFax)"
		Write-Verbose "$(Get-Date): Company Phone   : $($CompanyPhone)"
		Write-Verbose "$(Get-Date): Cover Page      : $($CoverPage)"
	}
	Write-Verbose "$(Get-Date): DeliveryGroups  : $($DeliveryGroups)"
	Write-Verbose "$(Get-Date): Dev             : $($Dev)"
	If($Dev)
	{
		Write-Verbose "$(Get-Date): DevErrorFile    : $($Script:DevErrorFile)"
	}
	Write-Verbose "$(Get-Date): DGUtilization   : $($DeliveryGroupsUtilization)"
	Write-Verbose "$(Get-Date): Filename1       : $($Script:Filename1)"
	If($PDF)
	{
		Write-Verbose "$(Get-Date): Filename2       : $($Script:Filename2)"
	}
	Write-Verbose "$(Get-Date): Folder          : $($Folder)"
	Write-Verbose "$(Get-Date): From            : $($From)"
	Write-Verbose "$(Get-Date): Hosting         : $($Hosting)"
	Write-Verbose "$(Get-Date): HW Inventory    : $($Hardware)"
	Write-Verbose "$(Get-Date): Log             : $($Log)"
	Write-Verbose "$(Get-Date): Logging         : $($Logging)"
	If($Logging)
	{
		Write-Verbose "$(Get-Date):    Start Date   : $($StartDate)"
		Write-Verbose "$(Get-Date):    End Date     : $($EndDate)"
	}
	Write-Verbose "$(Get-Date): MachineCatalogs : $($MachineCatalogs)"
	Write-Verbose "$(Get-Date): MaxDetails      : $($MaxDetails)"
	Write-Verbose "$(Get-Date): NoADPolicies    : $($NoADPolicies)"
	Write-Verbose "$(Get-Date): NoPolicies      : $($NoPolicies)"
	Write-Verbose "$(Get-Date): Policies        : $($Policies)"
	Write-Verbose "$(Get-Date): Save As HTML    : $($HTML)"
	Write-Verbose "$(Get-Date): Save As PDF     : $($PDF)"
	Write-Verbose "$(Get-Date): Save As TEXT    : $($TEXT)"
	Write-Verbose "$(Get-Date): Save As WORD    : $($MSWORD)"
	Write-Verbose "$(Get-Date): Section         : $($Section)"
	Write-Verbose "$(Get-Date): ScriptInfo      : $($ScriptInfo)"
	Write-Verbose "$(Get-Date): Site Name       : $($XDSiteName)"
	Write-Verbose "$(Get-Date): Smtp Port       : $($SmtpPort)"
	Write-Verbose "$(Get-Date): Smtp Server     : $($SmtpServer)"
	Write-Verbose "$(Get-Date): StoreFront      : $($StoreFront)"
	Write-Verbose "$(Get-Date): Title           : $($Script:Title)"
	Write-Verbose "$(Get-Date): To              : $($To)"
	Write-Verbose "$(Get-Date): Use SSL         : $($UseSSL)"
	If($MSWORD -or $PDF)
	{
		Write-Verbose "$(Get-Date): User Name       : $($UserName)"
	}
	Write-Verbose "$(Get-Date): XA/XD Version   : $($Script:XDSiteVersion)"
	Write-Verbose "$(Get-Date): "
	Write-Verbose "$(Get-Date): OS Detected     : $($Script:RunningOS)"
	Write-Verbose "$(Get-Date): PoSH version    : $($Host.Version)"
	Write-Verbose "$(Get-Date): PSCulture       : $($PSCulture)"
	Write-Verbose "$(Get-Date): PSUICulture     : $($PSUICulture)"
	If($MSWORD -or $PDF)
	{
		Write-Verbose "$(Get-Date): Word language   : $($Script:WordLanguageValue)"
		Write-Verbose "$(Get-Date): Word version    : $($Script:WordProduct)"
	}
	Write-Verbose "$(Get-Date): "
	Write-Verbose "$(Get-Date): Script start    : $($Script:StartTime)"
	Write-Verbose "$(Get-Date): "
	Write-Verbose "$(Get-Date): "
	
	
}

Function AbortScript
{
	If($MSWord -or $PDF)
	{
		$Script:Word.quit()
		Write-Verbose "$(Get-Date): System Cleanup"
		[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Script:Word) | Out-Null
		If(Test-Path variable:global:word)
		{
			Remove-Variable -Name word -Scope Global 4>$Null
		}
	}
	[gc]::collect() 
	[gc]::WaitForPendingFinalizers()
	Write-Verbose "$(Get-Date): Script has been aborted"
	$ErrorActionPreference = $SaveEAPreference
	Exit
}

Function OutputWarning
{
	Param([string] $txt)
	Write-Warning $txt
	If($MSWord -or $PDF)
	{
		WriteWordLine 0 1 $txt
		WriteWordLIne 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 $txt
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 0 1 $txt
		WriteHTMLLine 0 0 " "
	}
}

Function OutputAdminsForDetails
{
	Param([object] $Admins)
	
	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Administrators"
		## Create an array of hashtables to store our admins
		[System.Collections.Hashtable[]] $AdminsWordTable = @();
		## Seed the row index from the second row
	}
	ElseIf($Text)
	{
		Line 0 "Administrators"
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Administrators"
		$rowdata = @()
	}
	
	ForEach($Admin in $Admins)
	{
		$Tmp = ""
		If($Admin.Enabled -eq $True)
		{
			$Tmp = "Enabled"
		}
		Else
		{
			$Tmp = "Disabled"
		}
		
		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{ 
			AdminName = $Admin.Name;
			Role = $Admin.Rights[0].RoleName;
			Status = $Tmp;
			}
			$AdminsWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "Administrator Name`t: " $Admin.Name
			Line 1 "Role`t`t`t: " $Admin.Rights[0].RoleName
			Line 1 "Status`t`t`t: " $tmp
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Admin.Name,$htmlwhite,
			$Admin.Rights[0].RoleName,$htmlwhite,
			$tmp,$htmlwhite))
		}
	}
	
	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $AdminsWordTable `
		-Columns AdminName, Role, Status `
		-Headers "Administrator Name", "Role", "Status" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 225;
		$Table.Columns.Item(2).Width = 200;
		$Table.Columns.Item(3).Width = 60;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Administrator Name',($htmlsilver -bor $htmlbold),
		'Role',($htmlsilver -bor $htmlbold),
		'Status',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("225","200","60")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "485"
		WriteHTMLLine 0 0 " "
	}
}

Function TranscriptLogging
{
	If($Log) 
	{
		try 
		{
			If($Script:StartLog -eq $false)
			{
				Start-Transcript -Path $Script:LogPath -Force -Verbose:$false | Out-Null
			}
			Else
			{
				Start-Transcript -Path $Script:LogPath -Append -Verbose:$false | Out-Null
			}
			Write-Verbose "$(Get-Date): Transcript/log started at $Script:LogPath"
			$Script:StartLog = $true
		} 
		catch 
		{
			Write-Verbose "$(Get-Date): Transcript/log failed at $Script:LogPath"
			$Script:StartLog = $false
		}
	}
}
#endregion

#region email function
Function SendEmail
{
	Param([string]$Attachments)
	Write-Verbose "$(Get-Date): Prepare to email"
	
	$emailAttachment = $Attachments
	$emailSubject = $Script:Title
	$emailBody = @"
Hello, <br />
<br />
$Script:Title is attached.
"@ 

	If($Dev)
	{
		Out-File -FilePath $Script:DevErrorFile -InputObject $error 4>$Null
	}

	$error.Clear()

	If($UseSSL)
	{
		Write-Verbose "$(Get-Date): Trying to send email using current user's credentials with SSL"
		Send-MailMessage -Attachments $emailAttachment -Body $emailBody -BodyAsHtml -From $From `
		-Port $SmtpPort -SmtpServer $SmtpServer -Subject $emailSubject -To $To `
		-UseSSL *>$Null
	}
	Else
	{
		Write-Verbose  "$(Get-Date): Trying to send email using current user's credentials without SSL"
		Send-MailMessage -Attachments $emailAttachment -Body $emailBody -BodyAsHtml -From $From `
		-Port $SmtpPort -SmtpServer $SmtpServer -Subject $emailSubject -To $To *>$Null
	}

	$e = $error[0]

	If($e.Exception.ToString().Contains("5.7.57"))
	{
		#The server response was: 5.7.57 SMTP; Client was not authenticated to send anonymous mail during MAIL FROM
		Write-Verbose "$(Get-Date): Current user's credentials failed. Ask for usable credentials."

		If($Dev)
		{
			Out-File -FilePath $Script:DevErrorFile -InputObject $error -Append 4>$Null
		}

		$error.Clear()

		$emailCredentials = Get-Credential -Message "Enter the email account and password to send email"

		If($UseSSL)
		{
			Send-MailMessage -Attachments $emailAttachment -Body $emailBody -BodyAsHtml -From $From `
			-Port $SmtpPort -SmtpServer $SmtpServer -Subject $emailSubject -To $To `
			-UseSSL -credential $emailCredentials *>$Null 
		}
		Else
		{
			Send-MailMessage -Attachments $emailAttachment -Body $emailBody -BodyAsHtml -From $From `
			-Port $SmtpPort -SmtpServer $SmtpServer -Subject $emailSubject -To $To `
			-credential $emailCredentials *>$Null 
		}

		$e = $error[0]

		If($? -and $Null -eq $e)
		{
			Write-Verbose "$(Get-Date): Email successfully sent using new credentials"
		}
		Else
		{
			Write-Verbose "$(Get-Date): Email was not sent:"
			Write-Warning "$(Get-Date): Exception: $e.Exception" 
		}
	}
	Else
	{
		Write-Verbose "$(Get-Date): Email was not sent:"
		Write-Warning "$(Get-Date): Exception: $e.Exception" 
	}
}
#endregion

#region getadmins function from Citrix
Function GetAdmins
{
	Param([string]$xType="", [string]$xName="")
	
	Switch ($xType)
	{
		"Catalog" {
			$scopes = (Get-BrokerCatalog -Name $xName @XDParams2).Scopes | `
			Select-Object -ExpandProperty ScopeId
			$permissions = Get-AdminPermission @XDParams2 | Where-Object { $_.MetadataMap["Citrix_ObjectType"] -eq "Catalog" } | `
			Select-Object -ExpandProperty Id
			$roles = Get-AdminRole @XDParams2 | `
			Where-Object {$_.Permissions | Where-Object { $permissions -contains $_ }} | `
			Select-Object -ExpandProperty Id
			$Admins = Get-AdminAdministrator @XDParams2 | `
			Where-Object {$_.Rights | Where-Object {($_.ScopeId -eq [guid]::Empty -or $scopes -contains $_.ScopeId) -and $roles -contains $_.RoleId}}
		}
		"DesktopGroup" {
			$scopes = (Get-BrokerDesktopGroup -Name $xName @XDParams2).Scopes | `
			Select-Object -ExpandProperty ScopeId
			$permissions = Get-AdminPermission @XDParams2 | `
			Where-Object { $_.MetadataMap["Citrix_ObjectType"] -eq "DesktopGroup" } | `
			Select-Object -ExpandProperty Id
			$roles = Get-AdminRole @XDParams2 | `
			Where-Object {$_.Permissions | Where-Object { $permissions -contains $_ }} | `
			Select-Object -ExpandProperty Id
			$Admins = Get-AdminAdministrator @XDParams2 | `
			Where-Object {$_.Rights | Where-Object {($_.ScopeId -eq [guid]::Empty -or $scopes -contains $_.ScopeId) -and $roles -contains $_.RoleId}}
		}
		"Host" {
			$scopes = (Get-hypscopedobject -ObjectName $xName @XDParams2).ScopeId
			$permissions = Get-AdminPermission @XDParams2 | `
			Where-Object { $_.MetadataMap["Citrix_ObjectType"] -eq "Connection" -or `
			$_.MetadataMap["Citrix_ObjectType"] -eq "Host"} | `
			Select-Object -ExpandProperty Id		
			$roles = Get-AdminRole @XDParams2 | `
			Where-Object {$_.Permissions | Where-Object { $permissions -contains $_ }} | `
			Select-Object -ExpandProperty Id
			$Admins = Get-AdminAdministrator @XDParams2 | `
			Where-Object {$_.Rights | Where-Object {($_.ScopeId -eq [guid]::Empty -or `
			$scopes -contains $_.ScopeId) -and $roles -contains $_.RoleId}}
		}
		"Storefront" {
			$scopes = $Null
			$permissions = Get-AdminPermission @XDParams2 | `
			Where-Object { $_.MetadataMap["Citrix_ObjectType"] -eq "Storefront" } | `
			Select-Object -ExpandProperty Id
			$roles = Get-AdminRole @XDParams2 | `
			Where-Object {$_.Permissions | Where-Object { $permissions -contains $_ }} | `
			Select-Object -ExpandProperty Id
			#this is an unscoped object type as $admins is done differently than the others
			$Admins = Get-AdminAdministrator @XDParams2 | `
			Where-Object {$_.Rights | Where-Object {$roles -contains $_.RoleId}}
		}
	}
	
	# $scopes = (Get-BrokerCatalog -Name "XenApp 75" -adminaddress xd75 ).Scopes | Select-Object -ExpandProperty ScopeId

	# First, get all the permissions which are relevant to this object type
	# Change "Catalog" here as appropriate for the object type you're interested in
	# $permissions = Get-AdminPermission @XDParams2 | Where-Object { $_.MetadataMap["Citrix_ObjectType"] -eq "Catalog" } | Select-Object -ExpandProperty Id

	# Now, get all the roles which include at least one of those permissions
	# $roles = Get-AdminRole @XDParams2 | Where-Object {$_.Permissions | Where-Object { $permissions -contains $_ }} | Select-Object -ExpandProperty Id

	# Finally, get all administrators which have a scope/role pair which matches
	#$Admins = Get-AdminAdministrator @XDParams2 | Where-Object {
	#	$_.Rights | Where-Object {
	#		# [guid]::Empty is the GUID for the All scope
	#		# Remove the next line if you're dealing with an unscoped object type
	#		($_.ScopeId -eq [guid]::Empty -or $scopes -contains $_.ScopeId) -and
	#		$roles -contains $_.RoleId
	#	}
	#}
	#$Admins = Get-AdminAdministrator @XDParams2 | Where-Object {$_.Rights | Where-Object {($_.ScopeId -eq [guid]::Empty -or $scopes -contains $_.ScopeId) -and	$roles -contains $_.RoleId}}

	$Admins = $Admins | Sort-Object Name
	Return ,$Admins
}
#endregion

#region Machine Catalog functions
Function ProcessMachineCatalogs
{
	Write-Verbose "$(Get-Date): Retrieving Machine Catalogs"

	$txt = "Machine Catalogs"
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 $txt
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 $txt
	}

	$Script:TotalServerOSCatalogs = 0
	$Script:TotalDesktopOSCatalogs = 0
	$Script:TotalRemotePCCatalogs = 0

	$AllMachineCatalogs = Get-BrokerCatalog @XDParams2 -SortBy Name 

	If($? -and $Null -ne $AllMachineCatalogs)
	{
		OutputMachines $AllMachineCatalogs
	}
	ElseIf($? -and ($Null -eq $AllMachineCatalogs))
	{
		$txt = "There are no Machine Catalogs"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Machine Catalogs"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputMachines
{
	Param([object]$Catalogs)
	
	Write-Verbose "$(Get-Date): `tProcessing Machine Catalogs"

	#add 16-jun-2015, summary table of catalogs to match what is shown in Studio
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $WordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}

	ForEach($Catalog in $Catalogs)
	{
		$xType = ""
		$xCatalogType = ""
		$xAllocationType = ""
		$xPersistType = ""
		$xProvisioningType = ""
		
		If($Catalog.MachinesArePhysical -eq $True -and $Catalog.IsRemotePC -eq $False)
		{
			$xType = "Physical"
		}
		ElseIf($Catalog.MachinesArePhysical -eq $False -and $Catalog.IsRemotePC -eq $False)
		{
			$xType = "Virtual"
		}
		ElseIf($Catalog.MachinesArePhysical -eq $True -and $Catalog.IsRemotePC -eq $True)
		{
			$xType = "Remote PC Access"
			$Script:TotalRemotePCCatalogs++
		}
		
		If($Catalog.SessionSupport -eq "SingleSession")
		{
			$xCatalogType = "Windows Desktop OS ($xType)"
			$Script:TotalDesktopOSCatalogs++
		}
		Else
		{
			$xCatalogType = "Windows Server OS ($xType)"
			$Script:TotalServerOSCatalogs++
		}

		Switch ($Catalog.AllocationType)
		{
			"Static"	{$xAllocationType = "Permanent"; Break}
			"Permanent"	{$xAllocationType = "Permanent"; Break}
			"Random"	{$xAllocationType = "Random"; Break}
			Default	{$xAllocationType = "Allocation type could not be determined: $($Catalog.AllocationType)"; Break}
		}
		Switch ($Catalog.PersistUserChanges)
		{
			"OnLocal" {$xPersistType = "On local disk"; Break}
			"Discard" {$xPersistType = "Discard"; Break}
			"OnPvd"   {$xPersistType = "On Personal vDisk"; Break}
			Default   {$xPersistType = "User data could not be determined: $($Catalog.PersistUserChanges)"; Break}
		}
		Switch ($Catalog.ProvisioningType)
		{
			"Manual" {$xProvisioningType = "No provisioning"; Break}
			"PVS"    {$xProvisioningType = "Provisioning Services"; Break}
			"MCS"    {$xProvisioningType = "Machine creation services"; Break}
			Default  {$xProvisioningType = "Provisioning method could not be determined: $($Catalog.ProvisioningType)"; Break}
		}

		$Machines = Get-BrokerMachine @XDParams2 -CatalogName $Catalog.Name -SortBy DNSName 
		If($? -and ($Null -ne $Machines))
		{
		
			If($Machines -is [array])
			{
				$NumberOfMachines = $Machines.Count
			}
			Else
			{
				$NumberOfMachines = 1
			}
		}
		
		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{
			MachineCatalogName = $Catalog.Name; 
			MachineType = $xCatalogType; 
			NoOfMachines = $NumberOfMachines;
			AllocatedMachines = $Catalog.UsedCount; 
			AllocationType = $xAllocationType;
			UserData = $xPersistType;
			ProvisioningMethod = $xProvisioningType;
			}
			$WordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 0 "Machine Catalog`t`t: " $Catalog.Name
			Line 0 "Machine type`t`t: " $xCatalogType
			Line 0 "No. of machines`t`t: " $NumberOfMachines
			Line 0 "Allocated machines`t: " $Catalog.UsedCount
			Line 0 "Allocation type`t`t: " $xAllocationType
			Line 0 "User data`t`t: " $xPersistType
			Line 0 "Provisioning method`t: " $xProvisioningType
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Catalog.Name,$htmlwhite,
			$xCatalogType,$htmlwhite,
			$NumberOfMachines,$htmlwhite,
			$Catalog.UsedCount,$htmlwhite,
			$xAllocationType,$htmlwhite,
			$xPersistType,$htmlwhite,
			$xProvisioningType,$htmlwhite))
		}
	}

	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $WordTable `
		-Columns  MachineCatalogName, MachineType, NoOfMachines, AllocatedMachines, AllocationType, UserData, ProvisioningMethod `
		-Headers  "Machine Catalog", "Machine type", "No. of machines", "Allocated machines", "Allocation Type", "User data", "Provisioning method" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table -Size 9
		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 105;
		$Table.Columns.Item(2).Width = 100;
		$Table.Columns.Item(3).Width = 75;
		$Table.Columns.Item(4).Width = 50;
		$Table.Columns.Item(5).Width = 55;
		$Table.Columns.Item(6).Width = 50;
		$Table.Columns.Item(7).Width = 65;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Machine Catalog',($htmlsilver -bor $htmlbold),
		'Machine type',($htmlsilver -bor $htmlbold),
		'No. of machines',($htmlsilver -bor $htmlbold),
		'Allocated machines',($htmlsilver -bor $htmlbold),
		'Allocation Type',($htmlsilver -bor $htmlbold),
		'User data',($htmlsilver -bor $htmlbold),
		'Provisioning method',($htmlsilver -bor $htmlbold)
		)

		$columnWidths = @("105","100","75","50","55","50","65")
		$msg = ""
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		WriteHTMLLine 0 0 " "
	}
	
	ForEach($Catalog in $Catalogs)
	{
		Write-Verbose "$(Get-Date): `t`tAdding Catalog $($Catalog.Name)"
		$xType = ""
		$xCatalogType = ""
		$xAllocationType = ""
		$xPersistType = ""
		$xProvisioningType = ""
		$xVDAVersion = ""
		
		If($Catalog.MachinesArePhysical -eq $True -and $Catalog.IsRemotePC -eq $False)
		{
			$xType = "Physical"
		}
		ElseIf($Catalog.MachinesArePhysical -eq $False -and $Catalog.IsRemotePC -eq $False)
		{
			$xType = "Virtual"
		}
		ElseIf($Catalog.MachinesArePhysical -eq $True -and $Catalog.IsRemotePC -eq $True)
		{
			$xType = "Remote PC Access"
		}
		
		If($Catalog.SessionSupport -eq "SingleSession")
		{
			$xCatalogType = "Windows Desktop OS ($xType)"
		}
		Else
		{
			$xCatalogType = "Windows Server OS ($xType)"
		}

		Switch ($Catalog.AllocationType)
		{
			"Static"	{$xAllocationType = "Permanent"; Break}
			"Permanent"	{$xAllocationType = "Permanent"; Break}
			"Random"	{$xAllocationType = "Random"; Break}
			Default	{$xAllocationType = "Allocation type could not be determined: $($Catalog.AllocationType)"; Break}
		}
		Switch ($Catalog.PersistUserChanges)
		{
			"OnLocal" {$xPersistType = "On local disk"; Break}
			"Discard" {$xPersistType = "Discard"; Break}
			"OnPvd"   {$xPersistType = "On Personal vDisk"; Break}
			Default   {$xPersistType = "User data could not be determined: $($Catalog.PersistUserChanges)"; Break}
		}
		Switch ($Catalog.ProvisioningType)
		{
			"Manual" {$xProvisioningType = "No provisioning"; Break}
			"PVS"    {$xProvisioningType = "Provisioning Services"; Break}
			"MCS"    {$xProvisioningType = "Machine creation services"; Break}
			Default  {$xProvisioningType = "Provisioning method could not be determined: $($Catalog.ProvisioningType)"; Break}
		}
		Switch ($Catalog.MinimumFunctionalLevel)
		{
			"L5" 	{$xVDAVersion = "5.6 FP1 (Windows XP and Windows Vista)"; Break}
			"L7"	{$xVDAVersion = "7.0 (or newer)"; Break}
			"L7_6"	{$xVDAVersion = "7.6 (or newer)"; Break}
			"L7_7"	{$xVDAVersion = "7.7 (recommended, to access the latest features)"; Break}
			Default {"Unable to determine VDA version: $($Catalog.MinimumFunctionalLevel)"; Break}
		}

		If($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -eq $True)
		{
			$Results = Get-BrokerRemotePCAccount @XDParams2 -CatalogUid $Catalog.Uid
			
			If($? -and $Null -ne $Results)
			{
				$RemotePCOU = $Results.OU
				$RemotePCSubOU = $Results.AllowSubfolderMatches.ToString()
			}
			ElseIf($? -and $Null -eq $Results)
			{
				$RemotePCOU = "No RemotePC OU configured"
				$RemotePCSubOU = ""
			}
			Else
			{
				$RemotePCOU = "Unable to retrieve"
				$RemotePCSubOU = ""
			}
		}
		
		$MachineData = $Null
		$Machines = Get-BrokerMachine @XDParams2 -CatalogName $Catalog.Name -SortBy DNSName 
		If($? -and ($Null -ne $Machines))
		{
		
			If($Machines -is [array])
			{
				$NumberOfMachines = $Machines.Count
			}
			Else
			{
				$NumberOfMachines = 1
			}
			
			If($Null -ne $Catalog.ProvisioningSchemeId)
			{
				$MachineData = Get-ProvScheme -ProvisioningSchemeUid $Catalog.ProvisioningSchemeId @XDParams1
			}
			Else
			{
				$MachineData = $Null
			}
			
			If($? -and $Null -ne $MachineData)
			{
				$tmp1 = $MachineData.MasterImageVM.Split("\")
				$tmp2 = $tmp1[$tmp1.count -1]
				$tmp3 = $tmp2.Split(".")
				$xDiskImage = $tmp3[0]
			}
			Else
			{
				$xDiskImage = "Unable to retrieve details"
			}
		}
		Else
		{
			Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
		}
		
		If($MSWord -or $PDF)
		{

			$Selection.InsertNewPage()
			WriteWordLine 2 0 "Machine Catalog: $($Catalog.Name)"
			[System.Collections.Hashtable[]] $CatalogInformation = @()
			
			If($Catalog.ProvisioningType -eq "MCS")
			{
				$CatalogInformation += @{ Data = "Description"; Value = $Catalog.Description; }
				$CatalogInformation += @{ Data = "Machine type"; Value = $xCatalogType; }
				$CatalogInformation += @{ Data = "No. of machines"; Value = $NumberOfMachines; }
				$CatalogInformation += @{ Data = "Allocated machines"; Value = $Catalog.UsedCount; }
				$CatalogInformation += @{ Data = "Allocation type"; Value = $xAllocationType; }
				$CatalogInformation += @{ Data = "User data"; Value = $xPersistType; }
				$CatalogInformation += @{ Data = "Provisioning method"; Value = $xProvisioningType; }
				$CatalogInformation += @{ Data = "Set to VDA version"; Value = $xVDAVersion; }
				If($Null -ne $MachineData)
				{
					$CatalogInformation += @{ Data = "Resources"; Value = $MachineData.HostingUnitName; }
				}
				ElseIf($Null -eq $MachineData)
				{
					$CatalogInformation += @{ Data = "Resources"; Value = "Unable to retrieve details"; }
				}
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$CatalogInformation += @{ Data = "Zone"; Value = $Catalog.ZoneName; }
				}

				If($Null -ne $MachineData)
				{
					$CatalogInformation += @{ Data = "Disk Image"; Value = $xDiskImage; }
					$CatalogInformation += @{ Data = "Virtual CPUs"; Value = $MachineData.CpuCount; }
					$CatalogInformation += @{ Data = "Memory"; Value = $MachineData.MemoryMB; }
					$CatalogInformation += @{ Data = "Hard disk"; Value = "$($MachineData.DiskSize) GB"; }
				}
				ElseIf($Null -eq $MachineData)
				{
					$CatalogInformation += @{ Data = "Disk Image"; Value = $xDiskImage; }
					$CatalogInformation += @{ Data = "Virtual CPUs"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Memory"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Hard disk"; Value = "Unable to retrieve details"; }
				}
			
				If($Null -ne $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = $Machines[0].AgentVersion; }
					$CatalogInformation += @{ Data = "Operating System"; Value = $Machines[0].OSType; }
				}
				ElseIf($Null -eq $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Operating System"; Value = "Unable to retrieve details"; }
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "PVS")
			{
				$CatalogInformation += @{ Data = "Description"; Value = $Catalog.Description; }
				$CatalogInformation += @{ Data = "Machine type"; Value = $xCatalogType; }
				$CatalogInformation += @{ Data = "Provisioning method"; Value = $xProvisioningType; }
				$CatalogInformation += @{ Data = "PVS address"; Value = $Catalog.PvsAddress; }
				$CatalogInformation += @{ Data = "Allocation type"; Value = $xAllocationType; }
				$CatalogInformation += @{ Data = "Set to VDA version"; Value = $xVDAVersion; }
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$CatalogInformation += @{ Data = "Zone"; Value = $Catalog.ZoneName; }
				}
			
				If($Null -ne $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = $Machines[0].AgentVersion; }
					$CatalogInformation += @{ Data = "Operating System"; Value = $Machines[0].OSType; }
				}
				ElseIf($Null -eq $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Operating System"; Value = "Unable to retrieve details"; }
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -eq $True)
			{
				$CatalogInformation += @{ Data = "Description"; Value = $Catalog.Description; }
				$CatalogInformation += @{ Data = "Organizational Units"; Value = $RemotePCOU; }
				$CatalogInformation += @{ Data = "Allow subfolder matches"; Value = $RemotePCSubOU; }
				$CatalogInformation += @{ Data = "No. of machines"; Value = $NumberOfMachines; }
				$CatalogInformation += @{ Data = "Allocated machines"; Value = $Catalog.UsedCount; }
				$CatalogInformation += @{ Data = "Machine type"; Value = $xCatalogType; }
				$CatalogInformation += @{ Data = "Set to VDA version"; Value = $xVDAVersion; }
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$CatalogInformation += @{ Data = "Zone"; Value = $Catalog.ZoneName; }
				}

				If($Null -ne $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = $Machines[0].AgentVersion; }
					$CatalogInformation += @{ Data = "Operating System"; Value = $Machines[0].OSType; }
				}
				ElseIf($Null -eq $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Operating System"; Value = "Unable to retrieve details"; }
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -ne $True)
			{
				#(added 29-feb-2016 thanks to Michael Foster)
				$CatalogInformation += @{ Data = "Description"; Value = $Catalog.Description; }
				$CatalogInformation += @{ Data = "No. of machines"; Value = $NumberOfMachines; }
				$CatalogInformation += @{ Data = "Allocated machines"; Value = $Catalog.UsedCount; }
				$CatalogInformation += @{ Data = "Allocation type"; Value = $xAllocationType; }
				$CatalogInformation += @{ Data = "User data"; Value = $xPersistType; }
				$CatalogInformation += @{ Data = "Provisioning method"; Value = $xProvisioningType; }
				$CatalogInformation += @{ Data = "Set to VDA version"; Value = $xVDAVersion; }
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$CatalogInformation += @{ Data = "Zone"; Value = $Catalog.ZoneName; }
				}
				
				If($Null -ne $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = $Machines[0].AgentVersion; }
					$CatalogInformation += @{ Data = "Operating System"; Value = $Machines[0].OSType; }
				}
				ElseIf($Null -eq $Machines)
				{
					$CatalogInformation += @{ Data = "Installed VDA version"; Value = "Unable to retrieve details"; }
					$CatalogInformation += @{ Data = "Operating System"; Value = "Unable to retrieve details"; }
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			
			$Table = AddWordTable -Hashtable $CatalogInformation `
			-Columns Data,Value `
			-List `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 225;
			$Table.Columns.Item(2).Width = 200;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
		ElseIf($Text)
		{
			Line 0 "Machine Catalog: $($Catalog.Name)"
			If($Catalog.ProvisioningType -eq "MCS")
			{
				Line 1 "Description`t`t`t: " $Catalog.Description
				Line 1 "Machine type`t`t: " $xCatalogType
				Line 1 "No. of machines`t`t: " $NumberOfMachines
				Line 1 "Allocated machines`t: " $Catalog.UsedCount
				Line 1 "Allocation type`t`t: " $xAllocationType
				Line 1 "User data`t`t: " $xPersistType
				Line 1 "Provisioning method`t: " $xProvisioningType
				Line 1 "Set to VDA version`t: " $xVDAVersion
				If($Null -ne $MachineData)
				{
					Line 1 "Resources`t`t: " $MachineData.HostingUnitName
				}
				ElseIf($Null -eq $MachineData)
				{
					Line 1 "Resources`t`t: " "Unable to retrieve details"
				}
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					Line 1 "Zone`t`t`t: " $Catalog.ZoneName
				}
				
				If($Null -ne $MachineData)
				{
					Line 1 "Disk Image`t`t: " $xDiskImage
					Line 1 "Virtual CPUs`t`t: " $MachineData.CpuCount
					Line 1 "Memory`t`t`t: " $MachineData.MemoryMB
					Line 1 "Hard disk`t`t: " "$($MachineData.DiskSize) GB"
				}
				ElseIf($Null -eq $MachineData)
				{
					Line 1 "Disk Image: " $xDiskImage
					Line 1 "Virtual CPUs: " "Unable to retrieve details"
					Line 1 "Memory: " "Unable to retrieve details"
					Line 1 "Hard disk: " "Unable to retrieve details"
				}
				
				If($Null -ne $Machines)
				{
					Line 1 "Installed VDA version`t: " $Machines[0].AgentVersion
					Line 1 "Operating System`t: " $Machines[0].OSType
				}
				ElseIf($Null -eq $Machines)
				{
					Line 1 "Installed VDA version`t`t: " "Unable to retrieve details"
					Line 1 "Operating System`t: " "Unable to retrieve details"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "PVS")
			{
				Line 1 "Description`t`t`t: " $Catalog.Description
				Line 1 "Machine type`t`t: " $xCatalogType
				Line 1 "Provisioning method`t: " $xProvisioningType
				Line 1 "PVS address`t`t: " $Catalog.PvsAddress
				Line 1 "Allocation type`t`t: " $xAllocationType
				Line 1 "Set to VDA version`t: " $xVDAVersion
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					Line 1 "Zone`t`t`t: " $Catalog.ZoneName
				}
				
				If($Null -ne $Machines)
				{
					Line 1 "Installed VDA version`t: " $Machines[0].AgentVersion
					Line 1 "Operating System`t: " $Machines[0].OSType
				}
				ElseIf($Null -eq $Machines)
				{
					Line 1 "Installed VDA version`t`t: " "Unable to retrieve details"
					Line 1 "Operating System`t: " "Unable to retrieve details"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -eq $True)
			{
				Line 1 "Description`t`t`t: " $Catalog.Description
				Line 1 "No. of machines`t`t: " $NumberOfMachines
				Line 1 "Allocated machines`t: " $Catalog.UsedCount
				Line 1 "Machine type`t`t: " $xCatalogType
				Line 1 "Set to VDA version`t: " $xVDAVersion
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					Line 1 "Zone`t`t`t: " $Catalog.ZoneName
				}
				
				If($Null -ne $Machines)
				{
					Line 1 "Installed VDA version`t: " $Machines[0].AgentVersion
					Line 1 "Operating System`t: " $Machines[0].OSType
				}
				ElseIf($Null -eq $Machines)
				{
					Line 1 "Installed VDA version`t`t: " "Unable to retrieve details"
					Line 1 "Operating System`t: " "Unable to retrieve details"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -ne $True)
			{
				#(added 29-feb-2016 thanks to Michael Foster)
				Line 1 "Description`t`t`t: " $Catalog.Description
				Line 1 "Organizational Units`t`t: " $RemotePCOU
				Line 1 "Allow subfolder matches`t`t: " $RemotePCSubOU
				Line 1 "No. of machines`t`t: " $NumberOfMachines
				Line 1 "Allocated machines`t: " $Catalog.UsedCount
				Line 1 "Allocation type`t`t: " $xAllocationType
				Line 1 "User data`t`t: " $xPersistType
				Line 1 "Provisioning method`t: " $xProvisioningType
				Line 1 "Set to VDA version`t: " $xVDAVersion
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					Line 1 "Zone`t`t`t: " $Catalog.ZoneName
				}
				
				If($Null -ne $Machines)
				{
					Line 1 "Installed VDA version`t: " $Machines[0].AgentVersion
					Line 1 "Operating System`t: " $Machines[0].OSType
				}
				ElseIf($Null -eq $Machines)
				{
					Line 1 "Installed VDA version`t: " "Unable to retrieve details"
					Line 1 "Operating System`t: " "Unable to retrieve details"
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			Line 0 ""
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 2 0 "Machine Catalog: $($Catalog.Name)"
			$rowdata = @()
			$columnHeaders = @("Machine type",($htmlsilver -bor $htmlbold),$xCatalogType,$htmlwhite)
			If($Catalog.ProvisioningType -eq "MCS")
			{
				$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Catalog.Description,$htmlwhite))
				$rowdata += @(,('No. of machines',($htmlsilver -bor $htmlbold),$NumberOfMachines,$htmlwhite))
				$rowdata += @(,('Allocated machines',($htmlsilver -bor $htmlbold),$Catalog.UsedCount,$htmlwhite))
				$rowdata += @(,('Allocation type',($htmlsilver -bor $htmlbold),$xAllocationType,$htmlwhite))
				$rowdata += @(,('User data',($htmlsilver -bor $htmlbold),$xPersistType,$htmlwhite))
				$rowdata += @(,('Provisioning method',($htmlsilver -bor $htmlbold),$xProvisioningType,$htmlwhite))
				$rowdata += @(,('Set to VDA version',($htmlsilver -bor $htmlbold),$xVDAVersion,$htmlwhite))
				If($Null -ne $MachineData)
				{
					$rowdata += @(,('Resources',($htmlsilver -bor $htmlbold),$MachineData.HostingUnitName,$htmlwhite))
				}
				ElseIf($Null -eq $MachineData)
				{
					$rowdata += @(,('Resources',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
				}
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$rowdata += @(,('Zone',($htmlsilver -bor $htmlbold),$Catalog.ZoneName,$htmlwhite))
				}
				
				If($Null -ne $MachineData)
				{
					$rowdata += @(,('Disk Image',($htmlsilver -bor $htmlbold),$xDiskImage,$htmlwhite))
					$rowdata += @(,('Virtual CPUs',($htmlsilver -bor $htmlbold),$MachineData.CpuCount,$htmlwhite))
					$rowdata += @(,('Memory',($htmlsilver -bor $htmlbold),$MachineData.MemoryMB,$htmlwhite))
					$rowdata += @(,('Hard disk',($htmlsilver -bor $htmlbold),"$($MachineData.DiskSize) GB",$htmlwhite))
				}
				ElseIf($Null -eq $MachineData)
				{
					$rowdata += @(,('Disk Image',($htmlsilver -bor $htmlbold),$xDiskImage,$htmlwhite))
					$rowdata += @(,('Virtual CPUs',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Memory',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Hard disk',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
				}
				
				If($Null -ne $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),$Machines[0].AgentVersion,$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),$Machines[0].OSType,$htmlwhite))
				}
				ElseIf($Null -eq $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "PVS")
			{
				$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Catalog.Description,$htmlwhite))
				$rowdata += @(,('Machine type',($htmlsilver -bor $htmlbold),$xCatalogType,$htmlwhite))
				$rowdata += @(,('Provisioning method',($htmlsilver -bor $htmlbold),$xProvisioningType,$htmlwhite))
				$rowdata += @(,('PVS address',($htmlsilver -bor $htmlbold),$Catalog.PvsAddress,$htmlwhite))
				$rowdata += @(,('Allocation type',($htmlsilver -bor $htmlbold),$xAllocationType,$htmlwhite))
				$rowdata += @(,('Set to VDA version',($htmlsilver -bor $htmlbold),$xVDAVersion,$htmlwhite))
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$rowdata += @(,('Zone',($htmlsilver -bor $htmlbold),$Catalog.ZoneName,$htmlwhite))
				}
				
				If($Null -ne $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),$Machines[0].AgentVersion,$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),$Machines[0].OSType,$htmlwhite))
				}
				ElseIf($Null -eq $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -eq $True)
			{
				$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Catalog.Description,$htmlwhite))
				$rowdata += @(,('No. of machines',($htmlsilver -bor $htmlbold),$NumberOfMachines,$htmlwhite))
				$rowdata += @(,('Allocated machines',($htmlsilver -bor $htmlbold),$Catalog.UsedCount,$htmlwhite))
				$rowdata += @(,('Machine type',($htmlsilver -bor $htmlbold),$xCatalogType,$htmlwhite))
				$rowdata += @(,('Set to VDA version',($htmlsilver -bor $htmlbold),$xVDAVersion,$htmlwhite))
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$rowdata += @(,('Zone',($htmlsilver -bor $htmlbold),$Catalog.ZoneName,$htmlwhite))
				}
				
				If($Null -ne $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),$Machines[0].AgentVersion,$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),$Machines[0].OSType,$htmlwhite))
				}
				ElseIf($Null -eq $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			ElseIf($Catalog.ProvisioningType -eq "Manual" -and $Catalog.IsRemotePC -ne $True)
			{
				$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Catalog.Description,$htmlwhite))
				$rowdata += @(,('Organizational Units',($htmlsilver -bor $htmlbold),$RemotePCOU,$htmlwhite))
				$rowdata += @(,('Allow subfolder matches',($htmlsilver -bor $htmlbold),$RemotePCSubOU,$htmlwhite))
				$rowdata += @(,('No. of machines',($htmlsilver -bor $htmlbold),$NumberOfMachines,$htmlwhite))
				$rowdata += @(,('Allocated machines',($htmlsilver -bor $htmlbold),$Catalog.UsedCount,$htmlwhite))
				$rowdata += @(,('Allocation type',($htmlsilver -bor $htmlbold),$xAllocationType,$htmlwhite))
				$rowdata += @(,('User data',($htmlsilver -bor $htmlbold),$xPersistType,$htmlwhite))
				$rowdata += @(,('Provisioning method',($htmlsilver -bor $htmlbold),$xProvisioningType,$htmlwhite))
				$rowdata += @(,('Set to VDA version',($htmlsilver -bor $htmlbold),$xVDAVersion,$htmlwhite))
				If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
				{
					$rowdata += @(,('Zone',($htmlsilver -bor $htmlbold),$Catalog.ZoneName,$htmlwhite))
				}
				
				If($Null -ne $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),$Machines[0].AgentVersion,$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),$Machines[0].OSType,$htmlwhite))
				}
				ElseIf($Null -eq $Machines)
				{
					$rowdata += @(,('Installed VDA version',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					$rowdata += @(,('Operating System',($htmlsilver -bor $htmlbold),"Unable to retrieve details",$htmlwhite))
					Write-Warning "Unable to retrieve details for Machine Catalog $($Catalog.Name)"
				}
			}
			
			$msg = ""
			$columnWidths = @("225px","200px")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "425"
			WriteHTMLLine 0 0 " "
		}
			
		#scopes
		$Scopes = (Get-BrokerCatalog -Name $Catalog.Name @XDParams2).Scopes
		
		If($? -and ($Null -eq $Scopes))
		{
			If($MSWord -or $PDF)
			{
				WriteWordLine 4 0 "Scopes"
				[System.Collections.Hashtable[]] $ScopesWordTable = @();

				$WordTableRowHash = @{ 
				Scope = "All";
				}

				$ScopesWordTable += $WordTableRowHash;

				$Table = AddWordTable -Hashtable $ScopesWordTable `
				-Columns Scope `
				-Headers  "Scopes" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 225;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
				WriteWordLine 0 0 ""
			}
			ElseIf($Text)
			{
				Line 1 "Scopes"
				Line 2 "All"
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 4 0 "Scopes"
				$rowdata = @()
				$rowdata += @(,("All",$htmlwhite))

				$columnHeaders = @(
				'Scopes',($htmlsilver -bor $htmlbold))

				$msg = ""
				$columnWidths = @("225")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "225"
				WriteHTMLLine 0 0 " "
			}
		}
		ElseIf($? -and ($Null -ne $Scopes))
		{
			If($MSWord -or $PDF)
			{
				WriteWordLine 4 0 "Scopes"
				[System.Collections.Hashtable[]] $ScopesWordTable = @();

				$WordTableRowHash = @{ 
				Scope = "All";
				}

				$ScopesWordTable += $WordTableRowHash;

				$CurrentServiceIndex++;
				
				ForEach($Scope in $Scopes)
				{
					$WordTableRowHash = @{ 
					Scope = $Scope.ScopeName;
					}

					$ScopesWordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $ScopesWordTable `
				-Columns Scope `
				-Headers  "Scopes" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 225;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
				WriteWordLine 0 0 ""
			}
			ElseIf($Text)
			{
				Line 1 "Scopes"
				Line 2 "All"

				ForEach($Scope in $Scopes)
				{
					Line 2 $Scope.ScopeName;
				}
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 4 0 "Scopes"
				$rowdata = @()
				$rowdata += @(,("All",$htmlwhite))

				ForEach($Scope in $Scopes)
				{
					$rowdata += @(,($Scope.ScopeName,$htmlwhite))
				}
				$columnHeaders = @(
				'Scopes',($htmlsilver -bor $htmlbold))

				$msg = ""
				$columnWidths = @("225")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "225"
				WriteHTMLLine 0 0 " "
			}
		}
		Else
		{
			$txt = "Unable to retrieve Scopes for Machine Catalog $($Catalog.Name)"
			OutputWarning $txt
			If($MSWord -or $PDF)
			{
				WriteWordLine 0 0 ""
			}
			ElseIf($Text)
			{
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 0 0 " "
			}
		}
		
		If($MachineCatalogs)
		{
			If($Null -ne $Machines)
			{
				Write-Verbose "$(Get-Date): `t`tProcessing Machines in $($Catalog.Name)"
				
				If($MSWord -or $PDF)
				{
					WriteWordLine 4 0 "Machines"
					[System.Collections.Hashtable[]] $MachinesWordTable = @();
				}
				ElseIf($Text)
				{
					Line 1 "Machines"
				}
				ElseIf($HTML)
				{
					WriteHTMLLine 4 0 "Machines"
					$rowdata = @()
				}
				
				ForEach($Machine in $Machines)
				{
					If($MSWord -or $PDF)
					{
						$WordTableRowHash = @{ MachineName = $Machine.MachineName;}
						$MachinesWordTable += $WordTableRowHash;
					}
					ElseIf($Text)
					{
						Line 1 $Machine.MachineName
					}
					ElseIf($HTML)
					{
						$rowdata += @(,($Machine.MachineName,$htmlwhite))
					}
				}
				
				If($MSWord -or $PDF)
				{
					$Table = AddWordTable -Hashtable $MachinesWordTable `
					-Columns MachineName `
					-Headers "Machine Names" `
					-Format $wdTableGrid `
					-AutoFit $wdAutoFitFixed;

					SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

					$Table.Columns.Item(1).Width = 225;

					$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

					FindWordDocumentEnd
					$Table = $Null
					WriteWordLine 0 0 ""
				}
				ElseIf($Text)
				{
					Line 0 ""
				}
				ElseIf($HTML)
				{
					$columnHeaders = @(
					'Machine Names',($htmlsilver -bor $htmlbold))

					$msg = ""
					$columnWidths = @("225")
					FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "225"
					WriteHTMLLine 0 0 " "
				}
				
				Write-Verbose "$(Get-Date): `t`tProcessing administrators for Machines in $($Catalog.Name)"
				$Admins = GetAdmins "Catalog" $Catalog.Name
				
				If($? -and ($Null -ne $Admins))
				{
					OutputAdminsForDetails $Admins
				}
				ElseIf($? -and ($Null -eq $Admins))
				{
					$txt = "There are no administrators for Machines in $($Catalog.Name)"
					OutputWarning $txt
				}
				Else
				{
					$txt = "Unable to retrieve administrators for Machines in $($Catalog.Name)"
					OutputWarning $txt
				}
				
				ForEach($Machine in $Machines)
				{
					If($Machine.SessionSupport -eq "MultiSession")
					{
						OutputServerMachineDetails $Machine
					}
					Else
					{
						OutputMachineDetails $Machine
					}
				}
			}
		}
	}
}
#endregion

#region function to output machine/desktop details
Function OutputMachineDetails
{
	Param([object] $Machine)
	
	Write-Verbose "$(Get-Date): `t`tOutput Desktop Machine $($Machine.HostedMachineName)"
	
	$xAssociatedUserFullNames = @()
	ForEach($Value in $Machine.AssociatedUserFullNames)
	{
		$xAssociatedUserFullNames += "$($Value)"
	}
		
	$xAssociatedUserNames = @()
	ForEach($Value in $Machine.AssociatedUserNames)
	{
		$xAssociatedUserNames += "$($Value)"
	}
	
	$xAssociatedUserUPNs = @()
	ForEach($Value in $Machine.AssociatedUserUPNs)
	{
		$xAssociatedUserUPNs += "$($Value)"
	}

	$xDesktopConditions = @()
	ForEach($Value in $Machine.DesktopConditions)
	{
		$xDesktopConditions += "$($Value)"
	}

	$xAllocationType = ""
	If($Machine.AllocationType -eq "Static")
	{
		$xAllocationType = "Private"
	}
	Else
	{
		$xAllocationType = $Machine.AllocationType
	}

	$xInMaintenanceMode = ""
	If($Machine.InMaintenanceMode)
	{
		$xInMaintenanceMode = "On"
	}
	Else
	{
		$xInMaintenanceMode ="Off"
	}

	$xIsPhysical = ""
	If($Machine.IsPhysical)
	{
		$xIsPhysical = "Physical"
	}
	Else
	{
		$xIsPhysical ="Virtual"
	}

	$xPvdStage = ""
	If($Machine.PvdStage -eq "None")
	{
		$xPvdStage = "Ready"
	}
	Else
	{
		$xPvdStage = $Machine.PvdStage
	}

	$xSummaryState = ""
	If($Machine.SummaryState -eq "InUse")
	{
		$xSummaryState = "In Use"
	}
	Else
	{
		$xSummaryState = $Machine.SummaryState
	}

	$xTags = @()
	ForEach($Value in $Machine.Tags)
	{
		$xTags += "$($Value)"
	}

	$xApplicationsInUse = @()
	ForEach($value in $Machine.ApplicationsInUse)
	{
		$xApplicationsInUse += "$($value)"
	}

	$xPublishedApplications = @()
	ForEach($value in $Machine.PublishedApplications)
	{
		$xPublishedApplications += "$($value)"
	}

	$xSessionSecureIcaActive = ""
	If($Machine.SessionSecureIcaActive)
	{
		$xSessionSecureIcaActive = "Yes"
	}
	Else
	{
		$xSessionSecureIcaActive = "No"
	}

	$xLastDeregistrationReason = ""
	Switch ($Machine.LastDeregistrationReason)
	{
		$Null									{$xLastDeregistrationReason = ""; Break}
		"AgentAddressResolutionFailed"			{$xLastDeregistrationReason = "Agent Address Resolution Failed"; Break}
		"AgentNotContactable"					{$xLastDeregistrationReason = "Agent Not Contactable"; Break}
		"AgentRejectedSettingsUpdate"			{$xLastDeregistrationReason = "Agent Rejected Settings Update"; Break}
		"AgentRequested"						{$xLastDeregistrationReason = "Agent Requested"; Break}
		"AgentShutdown"							{$xLastDeregistrationReason = "Agent Shutdown"; Break}
		"AgentSuspended"						{$xLastDeregistrationReason = "Agent Suspended"; Break}
		"AgentWrongActiveDirectoryOU"			{$xLastDeregistrationReason = "Agent Wrong Active Directory OU"; Break}
		"BrokerRegistrationLimitReached"		{$xLastDeregistrationReason = "Broker Registration Limit Reached"; Break}
		"ContactLost"							{$xLastDeregistrationReason = "Contact Lost"; Break}
		"DesktopRemoved"						{$xLastDeregistrationReason = "Desktop Removed"; Break}
		"DesktopRestart"						{$xLastDeregistrationReason = "Desktop Restart"; Break}
		"EmptyRegistrationRequest"				{$xLastDeregistrationReason = "Empty Registration Request"; Break}
		"FunctionalLevelTooLowForCatalog"		{$xLastDeregistrationReason = "Functional Level Too Low For Catalog"; Break}
		"FunctionalLevelTooLowForDesktopGroup"	{$xLastDeregistrationReason = "Functional Level Too Low For Desktop Group"; Break}
		"IncompatibleVersion"					{$xLastDeregistrationReason = "Incompatible Version"; Break}
		"InconsistentRegistrationCapabilities"	{$xLastDeregistrationReason = "Inconsistent Registration Capabilities"; Break}
		"InvalidRegistrationRequest"			{$xLastDeregistrationReason = "Invalid Registration Request"; Break}
		"MissingAgentVersion"					{$xLastDeregistrationReason = "Missing Agent Version"; Break}
		"MissingRegistrationCapabilities"		{$xLastDeregistrationReason = "Missing Registration Capabilities"; Break}
		"NotLicensedForFeature"					{$xLastDeregistrationReason = "Not Licensed For Feature"; Break}
		"PowerOff"								{$xLastDeregistrationReason = "Power Off"; Break}
		"SendSettingsFailure"					{$xLastDeregistrationReason = "Send Settings Failure"; Break}
		"SessionAuditFailure"					{$xLastDeregistrationReason = "Session Audit Failure"; Break}
		"SessionPrepareFailure"					{$xLastDeregistrationReason = "Session Prepare Failure"; Break}
		"SettingsCreationFailure"				{$xLastDeregistrationReason = "Settings Creation Failure"; Break}
		"SingleMultiSessionMismatch"			{$xLastDeregistrationReason = "Single Multi Session Mismatch"; Break}
		"UnknownError"							{$xLastDeregistrationReason = "Unknown Error"; Break}
		"UnsupportedCredentialSecurityVersion"	{$xLastDeregistrationReason = "Unsupported Credential Security Version"; Break} 
		Default {$xLastDeregistrationReason = "Unable to determine LastDeregistrationReason: $($Machine.LastDeregistrationReason)"; Break}
	}

	$xPersistUserChanges = ""
	Switch ($Machine.PersistUserChanges)
	{
		"OnLocal" {$xPersistUserChanges = "On Local"; Break}
		"Discard" {$xPersistUserChanges = "Discard"; Break}
		"OnPvD"   {$xPersistUserChanges = "On Personal vDisk"; Break}
		Default {$xPersistUserChanges = "Unable to determine the value of PersistUserChanges: $($Machine.PersistUserChanges)"; Break}
	}

	$xWillShutdownAfterUse = ""
	If($Machine.WillShutdownAfterUse)
	{
		$xWillShutdownAfterUse = "Yes"
	}
	Else
	{
		$xWillShutdownAfterUse = "No"
	}

	$xSessionSmartAccessTags = @()
	ForEach($value in $Machine.SessionSmartAccessTags)
	{
		$xSessionSmartAccessTags += "$($value)"
	}

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 3 0 $Machine.DNSName
		WriteWordLine 4 0 "Machine"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Name"; Value = $Machine.DNSName; }
		$ScriptInformation += @{ Data = "Machine Catalog"; Value = $Machine.CatalogName; }
		$ScriptInformation += @{ Data = "Delivery Group"; Value = $Machine.DesktopGroupName; }
		$ScriptInformation += @{ Data = "User Display Name"; Value = $xAssociatedUserFullNames[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "User"; Value = $xAssociatedUserNames[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "UPN"; Value = $xAssociatedUserUPNs[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Desktop Conditions"; Value = $xDesktopConditions[0]; }
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Allocation Type"; Value = $xAllocationType; }
		$ScriptInformation += @{ Data = "Maintenance Mode"; Value = $xInMaintenanceMode; }
		$ScriptInformation += @{ Data = "Is Assigned"; Value = $Machine.IsAssigned; }
		$ScriptInformation += @{ Data = "Is Physical"; Value = $xIsPhysical; }
		$ScriptInformation += @{ Data = "Provisioning Type"; Value = $Machine.ProvisioningType; }
		$ScriptInformation += @{ Data = "PvD State"; Value = $xPvdStage; }
		$ScriptInformation += @{ Data = "Scheduled Reboot"; Value = $Machine.ScheduledReboot; }
		$ScriptInformation += @{ Data = "Summary State"; Value = $xSummaryState; }
		$ScriptInformation += @{ Data = "Tags"; Value = $xTags[0]; }
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""

		WriteWordLine 4 0 "Machine Details"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Agent Version"; Value = $Machine.AgentVersion; }
		$ScriptInformation += @{ Data = "IP Address"; Value = $Machine.IPAddress; }
		$ScriptInformation += @{ Data = "OS Type"; Value = $Machine.OSType; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Applications"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		
		$ScriptInformation += @{ Data = "Applications In Use"; Value = $xApplicationsInUse[0]; }
		$cnt = -1
		ForEach($tmp in $xApplicationsInUse)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Published Applications"; Value = $xPublishedApplications[0]; }
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Connection"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Client (IP)"; Value = $Machine.SessionClientAddress; }
		$ScriptInformation += @{ Data = "Client"; Value = $Machine.SessionClientName; }
		$ScriptInformation += @{ Data = "Plug-in Version"; Value = $Machine.SessionClientVersion; }
		$ScriptInformation += @{ Data = "Connected Via"; Value = $Machine.SessionConnectedViaHostName; }
		$ScriptInformation += @{ Data = "Connected Via (IP)"; Value = $Machine.SessionConnectedViaIP; }
		$ScriptInformation += @{ Data = "Last Connection Time"; Value = $Machine.LastConnectionTime ; }
		$ScriptInformation += @{ Data = "Last Connection User"; Value = $Machine.LastConnectionUser; }
		$ScriptInformation += @{ Data = "Connection Type"; Value = $Machine.SessionProtocol; }
		$ScriptInformation += @{ Data = "Secure ICA Active"; Value = $xSessionSecureIcaActive ; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Registration"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Broker"; Value = $Machine.ControllerDNSName; }
		$ScriptInformation += @{ Data = "Last registration failure"; Value = $xLastDeregistrationReason; }
		$ScriptInformation += @{ Data = "Last registration failure time"; Value = $Machine.LastDeregistrationTime; }
		$ScriptInformation += @{ Data = "Registration State"; Value = $Machine.RegistrationState; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Hosting"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "VM"; Value = $Machine.HostedMachineName; }
		$ScriptInformation += @{ Data = "Hosting Server Name"; Value = $Machine.HostingServerName; }
		$ScriptInformation += @{ Data = "Connection"; Value = $Machine.HypervisorConnectionName ; }
		$ScriptInformation += @{ Data = "Pending Update"; Value = $Machine.ImageOutOfDate; }
		$ScriptInformation += @{ Data = "Persist User Changes"; Value = $xPersistUserChanges; }
		$ScriptInformation += @{ Data = "Power Action Pending"; Value = $Machine.PowerActionPending; }
		$ScriptInformation += @{ Data = "Power State"; Value = $Machine.PowerState; }
		$ScriptInformation += @{ Data = "Will Shutdown After Use"; Value = $xWillShutdownAfterUse; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Session Details"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Launched Via"; Value = $Machine.SessionLaunchedViaHostName; }
		$ScriptInformation += @{ Data = "Launched Via (IP)"; Value = $Machine.SessionLaunchedViaIP; }
		$ScriptInformation += @{ Data = "Session Change Time"; Value = $Machine.SessionStateChangeTime; }
		$ScriptInformation += @{ Data = "SmartAccess Filters"; Value = $xSessionSmartAccessTags[0]; }
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Session"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Session State"; Value = $Machine.SessionState; }
		$ScriptInformation += @{ Data = "Current User"; Value = $Machine.SessionUserName; }
		$ScriptInformation += @{ Data = "Start Time"; Value = $Machine.SessionStateChangeTIme; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Machine"
		Line 2 "Name`t`t`t`t: " $Machine.DNSName
		Line 2 "Machine Catalog`t`t`t: " $Machine.CatalogName
		Line 2 "Delivery Group`t`t`t: " $Machine.DesktopGroupName
		Line 2 "User Display Name`t`t: " $xAssociatedUserFullNames[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "User`t`t`t`t: " $xAssociatedUserNames[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "UPN`t`t`t`t: " $xAssociatedUserUPNs[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Desktop Conditions`t`t: " $xDesktopConditions[0]
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Allocation Type`t`t`t: " $xAllocationType
		Line 2 "Maintenance Mode`t`t: " $xInMaintenanceMode
		Line 2 "Is Assigned`t`t`t: " $Machine.IsAssigned
		Line 2 "Is Physical`t`t`t: " $xIsPhysical
		Line 2 "Provisioning Type`t`t: " $Machine.ProvisioningType
		Line 2 "PvD State`t`t`t: " $xPvdStage
		Line 2 "Scheduled Reboot`t`t: " $Machine.ScheduledReboot
		Line 2 "Summary State`t`t`t: " $xSummaryState
		Line 2 "Tags`t`t`t`t: " $xTags[0]
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 0 ""

		Line 1 "Machine Details"
		Line 2 "Agent Version`t`t`t: " $Machine.AgentVersion
		Line 2 "IP Address`t`t`t: " $Machine.IPAddress
		Line 2 "OS Type`t`t`t`t: " $Machine.OSType
		Line 0 ""
		
		Line 1 "Applications"
		Line 2 "Applications In Use`t`t: " $xApplicationsInUse[0]
		$cnt = -1
		ForEach($tmp in $xApplicationsInUse)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Published Applications`t`t: " $xPublishedApplications[0]
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 0 ""
		
		Line 1 "Connection"
		Line 2 "Client (IP)`t`t`t: " $Machine.SessionClientAddress
		Line 2 "Client`t`t`t`t: " $Machine.SessionClientName
		Line 2 "Plug-in Version`t`t`t: " $Machine.SessionClientVersion
		Line 2 "Connected Via`t`t`t: " $Machine.SessionConnectedViaHostName
		Line 2 "Connect Via (IP)`t`t: " $Machine.SessionConnectedViaIP
		Line 2 "Last Connection Time`t`t: " $Machine.LastConnectionTime 
		Line 2 "Last Connection User`t`t: " $Machine.LastConnectionUser
		Line 2 "Connection Type`t`t`t: " $Machine.SessionProtocol
		Line 2 "Secure ICA Active`t`t: " $xSessionSecureIcaActive 
		Line 0 ""
		
		Line 1 "Registration"
		Line 2 "Broker`t`t`t`t: " $Machine.ControllerDNSName
		Line 2 "Last registration failure`t: " $xLastDeregistrationReason
		Line 2 "Last registration failure time`t: " $Machine.LastDeregistrationTime
		Line 2 "Registration State`t`t: " $Machine.RegistrationState
		Line 0 ""
		
		Line 1 "Hosting"
		Line 2 "VM`t`t`t`t: " $Machine.HostedMachineName
		Line 2 "Hosting Server Name`t`t: " $Machine.HostingServerName
		Line 2 "Connection`t`t`t: " $Machine.HypervisorConnectionName 
		Line 2 "Pending Update`t`t`t: " $Machine.ImageOutOfDate
		Line 2 "Persist User Changes`t`t: " $xPersistUserChanges
		Line 2 "Power Action Pending`t`t: " $Machine.PowerActionPending
		Line 2 "Power State`t`t`t: " $Machine.PowerState
		Line 2 "Will Shutdown After Use`t`t: " $xWillShutdownAfterUse
		Line 0 ""
		
		Line 1 "Session Details"
		Line 2 "Launched Via`t`t`t: " $Machine.SessionLaunchedViaHostName
		Line 2 "Launched Via (IP)`t`t: " $Machine.SessionLaunchedViaIP
		Line 2 "Session Change Time`t`t: " $Machine.SessionStateChangeTime
		Line 2 "SmartAccess Filters`t`t: " $xSessionSmartAccessTags[0]
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $tmp
			}
		}
		Line 0 ""
		
		Line 1 "Session"
		Line 2 "Session State`t`t`t: " $Machine.SessionState
		Line 2 "Current User`t`t`t: " $Machine.SessionUserName
		Line 2 "Start Time`t`t`t: " $Machine.SessionUserName
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Machine"
		$rowdata = @()

		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$Machine.DNSName,$htmlwhite)
		$rowdata += @(,('Machine Catalog',($htmlsilver -bor $htmlbold),$Machine.CatalogName,$htmlwhite))
		$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$Machine.DesktopGroupName,$htmlwhite))
		$rowdata += @(,('User Display Name',($htmlsilver -bor $htmlbold),$xAssociatedUserFullNames[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$xAssociatedUserNames[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('UPN',($htmlsilver -bor $htmlbold),$xAssociatedUserUPNs[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Desktop Conditions',($htmlsilver -bor $htmlbold),$xDesktopConditions[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Allocation Type',($htmlsilver -bor $htmlbold),$xAllocationType,$htmlwhite))
		$rowdata += @(,('Maintenance Mode',($htmlsilver -bor $htmlbold),$xInMaintenanceMode,$htmlwhite))
		$rowdata += @(,('Is Assigned',($htmlsilver -bor $htmlbold),$Machine.IsAssigned,$htmlwhite))
		$rowdata += @(,('Is Physical',($htmlsilver -bor $htmlbold),$xIsPhysical,$htmlwhite))
		$rowdata += @(,('Provisioning Type',($htmlsilver -bor $htmlbold),$Machine.ProvisioningType,$htmlwhite))
		$rowdata += @(,('PvD State',($htmlsilver -bor $htmlbold),$xPvdStage,$htmlwhite))
		$rowdata += @(,('Scheduled Reboot',($htmlsilver -bor $htmlbold),$Machine.ScheduledReboot,$htmlwhite))
		$rowdata += @(,('Summary State',($htmlsilver -bor $htmlbold),$xSummaryState,$htmlwhite))
		$rowdata += @(,('Tags',($htmlsilver -bor $htmlbold),$xTags[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Machine Details"
		$rowdata = @()
		$columnHeaders = @("Agent Version",($htmlsilver -bor $htmlbold),$Machine.AgentVersion,$htmlwhite)
		$rowdata += @(,('IP Address',($htmlsilver -bor $htmlbold),$Machine.IPAddress,$htmlwhite))
		$rowdata += @(,('OS Type',($htmlsilver -bor $htmlbold),$Machine.OSType,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Applications"
		$rowdata = @()
		$columnHeaders = @("Applications In Use",($htmlsilver -bor $htmlbold),$xApplicationsInUse[0],$htmlwhite)
		$cnt = -1
		ForEach($tmp in $xApplicationsInUSe)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Published Applications',($htmlsilver -bor $htmlbold),$xPublishedApplications[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Connection"
		$rowdata = @()
		$columnHeaders = @("Client (IP)",($htmlsilver -bor $htmlbold),$Machine.SessionClientAddress,$htmlwhite)
		$rowdata += @(,('Client',($htmlsilver -bor $htmlbold),$Machine.SessionClientName,$htmlwhite))
		$rowdata += @(,('Plug-in Version',($htmlsilver -bor $htmlbold),$Machine.SessionClientVersion,$htmlwhite))
		$rowdata += @(,('Connected Via',($htmlsilver -bor $htmlbold),$Machine.SessionConnectedViaHostName,$htmlwhite))
		$rowdata += @(,('Connect Via (IP)',($htmlsilver -bor $htmlbold),$Machine.SessionConnectedViaIP,$htmlwhite))
		$rowdata += @(,('Last Connection Time',($htmlsilver -bor $htmlbold),$Machine.LastConnectionTime,$htmlwhite))
		$rowdata += @(,('Last Connection User',($htmlsilver -bor $htmlbold),$Machine.LastConnectionUser,$htmlwhite))
		$rowdata += @(,('Connection Type',($htmlsilver -bor $htmlbold),$Machine.SessionProtocol,$htmlwhite))
		$rowdata += @(,('Secure ICA Active',($htmlsilver -bor $htmlbold),$xSessionSecureIcaActive,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Registration"
		$rowdata = @()
		$columnHeaders = @("Broker",($htmlsilver -bor $htmlbold),$Machine.ControllerDNSName,$htmlwhite)
		$rowdata += @(,('Last registration failure',($htmlsilver -bor $htmlbold),$xLastDeregistrationReason,$htmlwhite))
		$rowdata += @(,('Last registration failure time',($htmlsilver -bor $htmlbold),$Machine.LastDeregistrationTime,$htmlwhite))
		$rowdata += @(,('Registration State',($htmlsilver -bor $htmlbold),$Machine.RegistrationState,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Hosting"
		$rowdata = @()
		$columnHeaders = @("VM",($htmlsilver -bor $htmlbold),$Machine.HostedMachineName,$htmlwhite)
		$rowdata += @(,('Hosting Server Name',($htmlsilver -bor $htmlbold),$Machine.HostingServerName,$htmlwhite))
		$rowdata += @(,('Connection',($htmlsilver -bor $htmlbold),$Machine.HypervisorConnectionName,$htmlwhite))
		$rowdata += @(,('Pending Update',($htmlsilver -bor $htmlbold),$Machine.ImageOutOfDate,$htmlwhite))
		$rowdata += @(,('Persist User Changes',($htmlsilver -bor $htmlbold),$xPersistUserChanges,$htmlwhite))
		$rowdata += @(,('Power Action Pending',($htmlsilver -bor $htmlbold),$Machine.PowerActionPending,$htmlwhite))
		$rowdata += @(,('Power State',($htmlsilver -bor $htmlbold),$Machine.PowerState,$htmlwhite))
		$rowdata += @(,('Will Shutdown After Use',($htmlsilver -bor $htmlbold),$xWillShutdownAfterUse,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Session Details"
		$rowdata = @()
		$columnHeaders = @("Launched Via",($htmlsilver -bor $htmlbold),$Machine.SessionLaunchedViaHostName,$htmlwhite)
		$rowdata += @(,('Launched Via (IP)',($htmlsilver -bor $htmlbold),$Machine.SessionLaunchedViaIP,$htmlwhite))
		$rowdata += @(,('Session Change Time',($htmlsilver -bor $htmlbold),$Machine.SessionStateChangeTime,$htmlwhite))
		$rowdata += @(,('SmartAccess Filters',($htmlsilver -bor $htmlbold),$xSessionSmartAccessTags[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Session"
		$rowdata = @()
		$columnHeaders = @("Session State",($htmlsilver -bor $htmlbold),$Machine.SessionState,$htmlwhite)
		$rowdata += @(,('Current User',($htmlsilver -bor $htmlbold),$Machine.SessionUserName,$htmlwhite))
		$rowdata += @(,('Start Time',($htmlsilver -bor $htmlbold),$Machine.SessionUserName,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputServerMachineDetails
{
	Param([object] $Machine)
	
	Write-Verbose "$(Get-Date): `t`tOutput Server Machine $($Machine.HostedMachineName)"
	
	$xAssociatedUserFullNames = @()
	ForEach($Value in $Machine.AssociatedUserFullNames)
	{
		$xAssociatedUserFullNames += "$($Value)"
	}
		
	$xAssociatedUserNames = @()
	ForEach($Value in $Machine.AssociatedUserNames)
	{
		$xAssociatedUserNames += "$($Value)"
	}
	
	$xAssociatedUserUPNs = @()
	ForEach($Value in $Machine.AssociatedUserUPNs)
	{
		$xAssociatedUserUPNs += "$($Value)"
	}

	$xDesktopConditions = @()
	ForEach($Value in $Machine.DesktopConditions)
	{
		$xDesktopConditions += "$($Value)"
	}

	$xAllocationType = ""
	If($Machine.AllocationType -eq "Static")
	{
		$xAllocationType = "Private"
	}
	Else
	{
		$xAllocationType = $Machine.AllocationType
	}

	$xInMaintenanceMode = ""
	If($Machine.InMaintenanceMode)
	{
		$xInMaintenanceMode = "On"
	}
	Else
	{
		$xInMaintenanceMode ="Off"
	}

	$xWindowsConnectionSetting = ""
	Switch ($Machine.WindowsConnectionSetting)
	{
		"LogonEnabled"			{$xWindowsConnectionSetting = "Logon enabled"; Break}
		"Draining"				{$xWindowsConnectionSetting = "Draining"; Break}
		"DrainingUntilRestart"	{$xWindowsConnectionSetting = "Draining until restart"; Break}
		"LogonDisabled"			{$xWindowsConnectionSetting = "Logon disabled"; Break}
		Default	{$xWindowsConnectionSetting = "Unable to determine WindowsConnectionString: $($Machine.WindowsConnectionSetting)"; Break}
	}

	$xIsPhysical = ""
	If($Machine.IsPhysical)
	{
		$xIsPhysical = "Physical"
	}
	Else
	{
		$xIsPhysical ="Virtual"
	}

	$xPvdStage = ""
	If($Machine.PvdStage -eq "None")
	{
		$xPvdStage = "Ready"
	}
	Else
	{
		$xPvdStage = $Machine.PvdStage
	}

	$xSummaryState = ""
	If($Machine.SummaryState -eq "InUse")
	{
		$xSummaryState = "In Use"
	}
	Else
	{
		$xSummaryState = $Machine.SummaryState
	}

	$xTags = @()
	ForEach($Value in $Machine.Tags)
	{
		$xTags += "$($Value)"
	}

	$xApplicationsInUse = @()
	ForEach($value in $Machine.ApplicationsInUse)
	{
		$xApplicationsInUse += "$($value)"
	}

	$xPublishedApplications = @()
	ForEach($value in $Machine.PublishedApplications)
	{
		$xPublishedApplications += "$($value)"
	}

	$xSessionSecureIcaActive = ""
	If($Machine.SessionSecureIcaActive)
	{
		$xSessionSecureIcaActive = "Yes"
	}
	Else
	{
		$xSessionSecureIcaActive = "No"
	}

	$xLastDeregistrationReason = ""
	Switch ($Machine.LastDeregistrationReason)
	{
		$Null									{$xLastDeregistrationReason = ""; Break}
		"AgentAddressResolutionFailed"			{$xLastDeregistrationReason = "Agent Address Resolution Failed"; Break}
		"AgentNotContactable"					{$xLastDeregistrationReason = "Agent Not Contactable"; Break}
		"AgentRejectedSettingsUpdate"			{$xLastDeregistrationReason = "Agent Rejected Settings Update"; Break}
		"AgentRequested"						{$xLastDeregistrationReason = "Agent Requested"; Break}
		"AgentShutdown"							{$xLastDeregistrationReason = "Agent Shutdown"; Break}
		"AgentSuspended"						{$xLastDeregistrationReason = "Agent Suspended"; Break}
		"AgentWrongActiveDirectoryOU"			{$xLastDeregistrationReason = "Agent Wrong Active Directory OU"; Break}
		"BrokerRegistrationLimitReached"		{$xLastDeregistrationReason = "Broker Registration Limit Reached"; Break}
		"ContactLost"							{$xLastDeregistrationReason = "Contact Lost"; Break}
		"DesktopRemoved"						{$xLastDeregistrationReason = "Desktop Removed"; Break}
		"DesktopRestart"						{$xLastDeregistrationReason = "Desktop Restart"; Break}
		"EmptyRegistrationRequest"				{$xLastDeregistrationReason = "Empty Registration Request"; Break}
		"FunctionalLevelTooLowForCatalog"		{$xLastDeregistrationReason = "Functional Level Too Low For Catalog"; Break}
		"FunctionalLevelTooLowForDesktopGroup"	{$xLastDeregistrationReason = "Functional Level Too Low For Desktop Group"; Break}
		"IncompatibleVersion"					{$xLastDeregistrationReason = "Incompatible Version"; Break}
		"InconsistentRegistrationCapabilities"	{$xLastDeregistrationReason = "Inconsistent Registration Capabilities"; Break}
		"InvalidRegistrationRequest"			{$xLastDeregistrationReason = "Invalid Registration Request"; Break}
		"MissingAgentVersion"					{$xLastDeregistrationReason = "Missing Agent Version"; Break}
		"MissingRegistrationCapabilities"		{$xLastDeregistrationReason = "Missing Registration Capabilities"; Break}
		"NotLicensedForFeature"					{$xLastDeregistrationReason = "Not Licensed For Feature"; Break}
		"PowerOff"								{$xLastDeregistrationReason = "Power Off"; Break}
		"SendSettingsFailure"					{$xLastDeregistrationReason = "Send Settings Failure"; Break}
		"SessionAuditFailure"					{$xLastDeregistrationReason = "Session Audit Failure"; Break}
		"SessionPrepareFailure"					{$xLastDeregistrationReason = "Session Prepare Failure"; Break}
		"SettingsCreationFailure"				{$xLastDeregistrationReason = "Settings Creation Failure"; Break}
		"SingleMultiSessionMismatch"			{$xLastDeregistrationReason = "Single Multi Session Mismatch"; Break}
		"UnknownError"							{$xLastDeregistrationReason = "Unknown Error"; Break}
		"UnsupportedCredentialSecurityVersion"	{$xLastDeregistrationReason = "Unsupported Credential Security Version"; Break} 
		Default {$xLastDeregistrationReason = "Unable to determine LastDeregistrationReason: $($Machine.LastDeregistrationReason)"; Break}
	}

	$xPersistUserChanges = ""
	Switch ($Machine.PersistUserChanges)
	{
		"OnLocal" {$xPersistUserChanges = "On Local"; Break}
		"Discard" {$xPersistUserChanges = "Discard"; Break}
		"OnPvD"   {$xPersistUserChanges = "On Personal vDisk"; Break}
		Default {$xPersistUserChanges = "Unable to determine the value of PersistUserChanges: $($Machine.PersistUserChanges)"; Break}
	}

	$xWillShutdownAfterUse = ""
	If($Machine.WillShutdownAfterUse)
	{
		$xWillShutdownAfterUse = "Yes"
	}
	Else
	{
		$xWillShutdownAfterUse = "No"
	}

	$xSessionSmartAccessTags = @()
	ForEach($value in $Machine.SessionSmartAccessTags)
	{
		$xSessionSmartAccessTags += "$($value)"
	}

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 3 0 $Machine.DNSName
		WriteWordLine 4 0 "Machine"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Name"; Value = $Machine.DNSName; }
		$ScriptInformation += @{ Data = "Machine Catalog"; Value = $Machine.CatalogName; }
		$ScriptInformation += @{ Data = "Delivery Group"; Value = $Machine.DesktopGroupName; }
		$ScriptInformation += @{ Data = "User Display Name"; Value = $xAssociatedUserFullNames[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "User"; Value = $xAssociatedUserNames[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "UPN"; Value = $xAssociatedUserUPNs[0]; }
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Desktop Conditions"; Value = $xDesktopConditions[0]; }
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Allocation Type"; Value = $xAllocationType; }
		$ScriptInformation += @{ Data = "Maintenance Mode"; Value = $xInMaintenanceMode; }
		$ScriptInformation += @{ Data = "Windows Connection Setting"; Value = $xWindowsConnectionSetting; }
		$ScriptInformation += @{ Data = "Is Assigned"; Value = $Machine.IsAssigned; }
		$ScriptInformation += @{ Data = "Is Physical"; Value = $xIsPhysical; }
		$ScriptInformation += @{ Data = "Provisioning Type"; Value = $Machine.ProvisioningType; }
		$ScriptInformation += @{ Data = "PvD State"; Value = $xPvdStage; }
		$ScriptInformation += @{ Data = "Scheduled Reboot"; Value = $Machine.ScheduledReboot; }
		$ScriptInformation += @{ Data = "Summary State"; Value = $xSummaryState; }
		$ScriptInformation += @{ Data = "Tags"; Value = $xTags[0]; }
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Load Index"; Value = $Machine.LoadIndex; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""

		WriteWordLine 4 0 "Machine Details"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Agent Version"; Value = $Machine.AgentVersion; }
		$ScriptInformation += @{ Data = "IP Address"; Value = $Machine.IPAddress; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Applications"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		
		$ScriptInformation += @{ Data = "Applications In Use"; Value = $xApplicationsInUse[0]; }
		$cnt = -1
		ForEach($tmp in $xApplicationsInUse)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Published Applications"; Value = $xPublishedApplications[0]; }
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Registration"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Broker"; Value = $Machine.ControllerDNSName; }
		$ScriptInformation += @{ Data = "Last registration failure"; Value = $xLastDeregistrationReason; }
		$ScriptInformation += @{ Data = "Last registration failure time"; Value = $Machine.LastDeregistrationTime; }
		$ScriptInformation += @{ Data = "Registration State"; Value = $Machine.RegistrationState; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Hosting"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "VM"; Value = $Machine.HostedMachineName; }
		$ScriptInformation += @{ Data = "Hosting Server Name"; Value = $Machine.HostingServerName; }
		$ScriptInformation += @{ Data = "Connection"; Value = $Machine.HypervisorConnectionName ; }
		$ScriptInformation += @{ Data = "Pending Update"; Value = $Machine.ImageOutOfDate; }
		$ScriptInformation += @{ Data = "Persist User Changes"; Value = $xPersistUserChanges; }
		$ScriptInformation += @{ Data = "Power Action Pending"; Value = $Machine.PowerActionPending; }
		$ScriptInformation += @{ Data = "Power State"; Value = $Machine.PowerState; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Connection"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Last Connection Time"; Value = $Machine.LastConnectionTime ; }
		$ScriptInformation += @{ Data = "Last Connection User"; Value = $Machine.LastConnectionUser; }
		$ScriptInformation += @{ Data = "Secure ICA Active"; Value = $xSessionSecureIcaActive ; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Session Details"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Launched Via"; Value = $Machine.SessionLaunchedViaHostName; }
		$ScriptInformation += @{ Data = "Launched Via (IP)"; Value = $Machine.SessionLaunchedViaIP; }
		$ScriptInformation += @{ Data = "SmartAccess Filters"; Value = $xSessionSmartAccessTags[0]; }
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		WriteWordLine 4 0 "Session"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Session Count"; Value = $Machine.SessionCount; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Machine"
		Line 2 "Name`t`t`t`t: " $Machine.DNSName
		Line 2 "Machine Catalog`t`t`t: " $Machine.CatalogName
		Line 2 "Delivery Group`t`t`t: " $Machine.DesktopGroupName
		Line 2 "User Display Name`t`t: " $xAssociatedUserFullNames[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "User`t`t`t`t: " $xAssociatedUserNames[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "UPN`t`t`t`t: " $xAssociatedUserUPNs[0]
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Desktop Conditions`t`t: " $xDesktopConditions[0]
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Allocation Type`t`t`t: " $xAllocationType
		Line 2 "Maintenance Mode`t`t: " $xInMaintenanceMode
		Line 2 "Windows Connection Setting`t: " $xWindowsConnectionSetting
		Line 2 "Is Assigned`t`t`t: " $Machine.IsAssigned
		Line 2 "Is Physical`t`t`t: " $xIsPhysical
		Line 2 "Provisioning Type`t`t: " $Machine.ProvisioningType
		Line 2 "PvD State`t`t`t: " $xPvdStage
		Line 2 "Scheduled Reboot`t`t: " $Machine.ScheduledReboot
		Line 2 "Summary State`t`t`t: " $xSummaryState
		Line 2 "Tags`t`t`t`t: " $xTags[0]
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Load Index`t`t`t: " $Machine.LoadIndex
		Line 0 ""

		Line 1 "Machine Details"
		Line 2 "Agent Version`t`t`t: " $Machine.AgentVersion
		Line 2 "IP Address`t`t`t: " $Machine.IPAddress
		Line 0 ""
		
		Line 1 "Applications"
		Line 2 "Applications In Use`t`t: " $xApplicationsInUse[0]
		$cnt = -1
		ForEach($tmp in $xApplicationsInUse)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 2 "Published Applications`t`t: " $xPublishedApplications[0]
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 6 "  " $tmp
			}
		}
		Line 0 ""
		
		Line 1 "Registration"
		Line 2 "Broker`t`t`t`t: " $Machine.ControllerDNSName
		Line 2 "Last registration failure`t: " $xLastDeregistrationReason
		Line 2 "Last registration failure time`t: " $Machine.LastDeregistrationTime
		Line 2 "Registration State`t`t: " $Machine.RegistrationState
		Line 0 ""
		
		Line 1 "Hosting"
		Line 2 "VM`t`t`t`t: " $Machine.HostedMachineName
		Line 2 "Hosting Server Name`t`t: " $Machine.HostingServerName
		Line 2 "Connection`t`t`t: " $Machine.HypervisorConnectionName 
		Line 2 "Pending Update`t`t`t: " $Machine.ImageOutOfDate
		Line 2 "Persist User Changes`t`t: " $xPersistUserChanges
		Line 2 "Power Action Pending`t`t: " $Machine.PowerActionPending
		Line 2 "Power State`t`t`t: " $Machine.PowerState
		Line 0 ""
		
		Line 1 "Connection"
		Line 2 "Last Connection Time`t`t: " $Machine.LastConnectionTime 
		Line 2 "Last Connection User`t`t: " $Machine.LastConnectionUser
		Line 2 "Secure ICA Active`t`t: " $xSessionSecureIcaActive 
		Line 0 ""
		
		Line 1 "Session Details"
		Line 2 "Launched Via`t`t`t: " $Machine.SessionLaunchedViaHostName
		Line 2 "Launched Via (IP)`t`t: " $Machine.SessionLaunchedViaIP
		Line 2 "SmartAccess Filters`t`t: " $xSessionSmartAccessTags[0]
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $tmp
			}
		}
		Line 0 ""
		
		Line 1 "Session"
		Line 2 "Session Count`t`t`t: " $Machine.SessionCount
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Machine"
		$rowdata = @()

		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$Machine.DNSName,$htmlwhite)
		$rowdata += @(,('Machine Catalog',($htmlsilver -bor $htmlbold),$Machine.CatalogName,$htmlwhite))
		$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$Machine.DesktopGroupName,$htmlwhite))
		$rowdata += @(,('User Display Name',($htmlsilver -bor $htmlbold),$xAssociatedUserFullNames[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserFullNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$xAssociatedUserNames[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserNames)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('UPN',($htmlsilver -bor $htmlbold),$xAssociatedUserUPNs[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAssociatedUserUPNs)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Desktop Conditions',($htmlsilver -bor $htmlbold),$xDesktopConditions[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xDesktopConditions)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Allocation Type',($htmlsilver -bor $htmlbold),$xAllocationType,$htmlwhite))
		$rowdata += @(,('Maintenance Mode',($htmlsilver -bor $htmlbold),$xInMaintenanceMode,$htmlwhite))
		$rowdata += @(,('Windows Connection Setting',($htmlsilver -bor $htmlbold),$xWindowsConnectionSetting,$htmlwhite))
		$rowdata += @(,('Is Assigned',($htmlsilver -bor $htmlbold),$Machine.IsAssigned,$htmlwhite))
		$rowdata += @(,('Is Physical',($htmlsilver -bor $htmlbold),$xIsPhysical,$htmlwhite))
		$rowdata += @(,('Provisioning Type',($htmlsilver -bor $htmlbold),$Machine.ProvisioningType,$htmlwhite))
		$rowdata += @(,('PvD State',($htmlsilver -bor $htmlbold),$xPvdStage,$htmlwhite))
		$rowdata += @(,('Scheduled Reboot',($htmlsilver -bor $htmlbold),$Machine.ScheduledReboot,$htmlwhite))
		$rowdata += @(,('Summary State',($htmlsilver -bor $htmlbold),$xSummaryState,$htmlwhite))
		$rowdata += @(,('Tags',($htmlsilver -bor $htmlbold),$xTags[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Load Index',($htmlsilver -bor $htmlbold),$Machine.LoadIndex,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Machine Details"
		$rowdata = @()
		$columnHeaders = @("Agent Version",($htmlsilver -bor $htmlbold),$Machine.AgentVersion,$htmlwhite)
		$rowdata += @(,('IP Address',($htmlsilver -bor $htmlbold),$Machine.IPAddress,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Applications"
		$rowdata = @()
		$columnHeaders = @("Applications In Use",($htmlsilver -bor $htmlbold),$xApplicationsInUse[0],$htmlwhite)
		$cnt = -1
		ForEach($tmp in $xApplicationsInUSe)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		$rowdata += @(,('Published Applications',($htmlsilver -bor $htmlbold),$xPublishedApplications[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xPublishedApplications)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Registration"
		$rowdata = @()
		$columnHeaders = @("Broker",($htmlsilver -bor $htmlbold),$Machine.ControllerDNSName,$htmlwhite)
		$rowdata += @(,('Last registration failure',($htmlsilver -bor $htmlbold),$xLastDeregistrationReason,$htmlwhite))
		$rowdata += @(,('Last registration failure time',($htmlsilver -bor $htmlbold),$Machine.LastDeregistrationTime,$htmlwhite))
		$rowdata += @(,('Registration State',($htmlsilver -bor $htmlbold),$Machine.RegistrationState,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Hosting"
		$rowdata = @()
		$columnHeaders = @("VM",($htmlsilver -bor $htmlbold),$Machine.HostedMachineName,$htmlwhite)
		$rowdata += @(,('Hosting Server Name',($htmlsilver -bor $htmlbold),$Machine.HostingServerName,$htmlwhite))
		$rowdata += @(,('Connection',($htmlsilver -bor $htmlbold),$Machine.HypervisorConnectionName,$htmlwhite))
		$rowdata += @(,('Pending Update',($htmlsilver -bor $htmlbold),$Machine.ImageOutOfDate,$htmlwhite))
		$rowdata += @(,('Persist User Changes',($htmlsilver -bor $htmlbold),$xPersistUserChanges,$htmlwhite))
		$rowdata += @(,('Power Action Pending',($htmlsilver -bor $htmlbold),$Machine.PowerActionPending,$htmlwhite))
		$rowdata += @(,('Power State',($htmlsilver -bor $htmlbold),$Machine.PowerState,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Connection"
		$rowdata = @()
		$columnHeaders = @("Last Connection Time",($htmlsilver -bor $htmlbold),$Machine.LastConnectionTime,$htmlwhite)
		$rowdata += @(,('Last Connection User',($htmlsilver -bor $htmlbold),$Machine.LastConnectionUser,$htmlwhite))
		$rowdata += @(,('Secure ICA Active',($htmlsilver -bor $htmlbold),$xSessionSecureIcaActive,$htmlwhite))

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Session Details"
		$rowdata = @()
		$columnHeaders = @("Launched Via",($htmlsilver -bor $htmlbold),$Machine.SessionLaunchedViaHostName,$htmlwhite)
		$rowdata += @(,('Launched Via (IP)',($htmlsilver -bor $htmlbold),$Machine.SessionLaunchedViaIP,$htmlwhite))
		$rowdata += @(,('SmartAccess Filters',($htmlsilver -bor $htmlbold),$xSessionSmartAccessTags[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xSessionSmartAccessTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 4 0 "Session"
		$rowdata = @()
		$columnHeaders = @("Session Count",($htmlsilver -bor $htmlbold),$Machine.SessionCount,$htmlwhite)

		$msg = ""
		$columnWidths = @("200px","250px")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region Delivery Group functions
Function ProcessDeliveryGroups
{
	Write-Verbose "$(Get-Date): Retrieving Delivery Groups"

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Delivery Groups"
	}
	ElseIf($Text)
	{
		Line 0 "Delivery Groups"
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Delivery Groups"
	}

	$Script:TotalApplicationGroups = 0
	$Script:TotalDesktopGroups = 0
	$Script:TotalAppsAndDesktopGroups = 0

	$AllDeliveryGroups = Get-BrokerDesktopGroup @XDParams2 -SortBy Name 

	If($? -and ($Null -ne $AllDeliveryGroups))
	{
		Write-Verbose "$(Get-Date): `tProcessing Delivery Groups"
		
		#add 16-jun-2015, summary table of delivery groups to match what is shown in Studio
		OutputDeliveryGroupTable $AllDeliveryGroups
		
		ForEach($Group in $AllDeliveryGroups)
		{
			OutputDeliveryGroup $Group
		}
	}
	ElseIf($? -and ($Null -eq $AllDeliveryGroups))
	{
		$txt = "There are no Delivery Groups"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Delivery Groups"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputDeliveryGroupTable 
{
	Param([object] $AllDeliveryGroups)
	
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $WordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}
	
	ForEach($Group in $AllDeliveryGroups)
	{
		$xSingleSession = ""
		$xState = ""
		If($Group.SessionSupport -eq "SingleSession")
		{
			$xSingleSession = "Windows Desktop OS"
		}
		Else
		{
			$xSingleSession = "Windows Server OS"
		}
		If($Group.InMaintenanceMode -eq $True)
		{
			$xState = "Maintenance mode"
		}
		Else
		{
			$xState = "Enabled"
		}

		Switch ($Group.DeliveryType)
		{
			"DesktopsOnly"		{$Script:TotalDesktopGroups++; Break}
			"AppsOnly"			{$Script:TotalApplicationGroups++; Break}
			"DesktopsAndApps"	{$Script:TotalAppsAndDesktopGroups++; Break}
			Default				{Break}
		}
		
		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{
			DeliveryGroupName = $Group.Name; 
			MachineType = $xSingleSession; 
			NoOfMachines = $Group.TotalDesktops; 
			SessionsInUse = $Group.Sessions; 
			NoOfApplications = $Group.TotalApplications; 
			State = $xState; 
			Unregistered = $Group.DesktopsUnregistered; 
			Disconnected = $Group.DesktopsDisconnected; 
			}
			$WordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "Delivery Group`t`t: " $Group.Name
			Line 1 "Machine type`t`t: " $xSingleSession
			Line 1 "No. of machines`t`t: " $Group.TotalDesktops
			Line 1 "Sessions in use`t`t: " $Group.Sessions
			Line 1 "No. of applications`t: " $Group.TotalApplications
			Line 1 "State`t`t`t: " $xState
			Line 1 "Unregistered`t`t: " $Group.DesktopsUnregistered
			Line 1 "Disconnected`t`t: " $Group.DesktopsDisconnected
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Group.Name,$htmlwhite,
			$xSingleSession,$htmlwhite,
			$Group.TotalDesktops,$htmlwhite,
			$Group.Sessions,$htmlwhite,
			$Group.TotalApplications,$htmlwhite,
			$xState,$htmlwhite,
			$Group.DesktopsUnregistered,$htmlwhite,
			$Group.DesktopsDisconnected,$htmlwhite))
		}
	}
	
	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $WordTable `
		-Columns  DeliveryGroupName, MachineType, NoOfMachines, SessionsInUse, NoOfApplications, State, Unregistered, Disconnected `
		-Headers  "Delivery Group", "Machine type", "No. of machines", "Sessions in use", "No. of applications", "State", "Unregistered", "Disconnected" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table -Size 9
		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 100;
		$Table.Columns.Item(2).Width = 75;
		$Table.Columns.Item(3).Width = 50;
		$Table.Columns.Item(4).Width = 45;
		$Table.Columns.Item(5).Width = 60;
		$Table.Columns.Item(6).Width = 45;
		$Table.Columns.Item(7).Width = 60;
		$Table.Columns.Item(8).Width = 65;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Delivery Group',($htmlsilver -bor $htmlbold),
		'Machine type',($htmlsilver -bor $htmlbold),
		'No. of machines',($htmlsilver -bor $htmlbold),
		'Sessions in use',($htmlsilver -bor $htmlbold),
		'No. of applications',($htmlsilver -bor $htmlbold),
		'State',($htmlsilver -bor $htmlbold),
		'Unregistered',($htmlsilver -bor $htmlbold),
		'Disconnected',($htmlsilver -bor $htmlbold)
		)

		$columnWidths = @("100","75","50","45","60","45","60","65")
		$msg = ""
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		WriteHTMLLine 0 0 " "
	}
	
}
Function OutputDeliveryGroup
{
	Param([object] $Group)
	
	Write-Verbose "$(Get-Date): `t`tAdding Delivery Group $($Group.Name)"
	$xSingleSession = ""
	$xState = ""
	If($Group.SessionSupport -eq "SingleSession")
	{
		$xSingleSession = "Windows Desktop OS"
	}
	Else
	{
		$xSingleSession = "Windows Server OS"
	}
	If($Group.Enabled -eq $True -and $Group.InMaintenanceMode -eq $True)
	{
		$xState = "Maintenance Mode"
	}
	ElseIf($Group.Enabled -eq $False -and $Group.InMaintenanceMode -eq $True)
	{
		$xState = "Maintenance Mode"
	}
	ElseIf($Group.Enabled -eq $True -and $Group.InMaintenanceMode -eq $False)
	{
		$xState = "Enabled"
	}
	ElseIf($Group.Enabled -eq $False -and $Group.InMaintenanceMode -eq $False)
	{
		$xState = "Disabled"
	}

	If($MSWord -or$PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 2 0 "Delivery Group: " $Group.Name
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Machine type"; Value = $xSingleSession; }
		$ScriptInformation += @{ Data = "Number of machines"; Value = $Group.TotalDesktops; }
		$ScriptInformation += @{ Data = "Sessions in use"; Value = $Group.Sessions; }
		$ScriptInformation += @{ Data = "Number of applications"; Value = $Group.TotalApplications; }
		$ScriptInformation += @{ Data = "State"; Value = $xState; }
		$ScriptInformation += @{ Data = "Unregistered"; Value = $Group.DesktopsUnregistered; }
		$ScriptInformation += @{ Data = "Disconnected"; Value = $Group.DesktopsDisconnected; }
		$ScriptInformation += @{ Data = "Available"; Value = $Group.DesktopsAvailable; }
		$ScriptInformation += @{ Data = "In Use"; Value = $Group.DesktopsInUse; }
		$ScriptInformation += @{ Data = "Never Registered"; Value = $Group.DesktopsNeverRegistered; }
		$ScriptInformation += @{ Data = "Preparing"; Value = $Group.DesktopsPreparing; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Delivery Group`t`t: " $Group.Name
		Line 1 "Machine type`t`t: " $xSingleSession
		Line 1 "No. of machines`t`t: " $Group.TotalDesktops
		Line 1 "Sessions in use`t`t: " $Group.Sessions
		Line 1 "No. of applications`t: " $Group.TotalApplications
		Line 1 "State`t`t`t: " $xState
		Line 1 "Unregistered`t`t: " $Group.DesktopsUnregistered
		Line 1 "Disconnected`t`t: " $Group.DesktopsDisconnected
		Line 1 "Available`t`t: " $Group.DesktopsAvailable
		Line 1 "In Use`t`t`t: " $Group.DesktopsInUse
		Line 1 "Never Registered`t: " $Group.DesktopsNeverRegistered
		Line 1 "Preparing`t`t: " $Group.DesktopsPreparing
		Line 0 ""
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		WriteHTMLLine 2 0 "Delivery Group: " $Group.Name
		$columnHeaders = @("Machine type",($htmlsilver -bor $htmlbold),$xSingleSession,$htmlwhite)
		$rowdata += @(,('No. of machines',($htmlsilver -bor $htmlbold),$Group.TotalDesktops,$htmlwhite))
		$rowdata += @(,('Sessions in use',($htmlsilver -bor $htmlbold),$Group.Sessions,$htmlwhite))
		$rowdata += @(,('No. of applications',($htmlsilver -bor $htmlbold),$Group.TotalApplications,$htmlwhite))
		$rowdata += @(,('State',($htmlsilver -bor $htmlbold),$xState,$htmlwhite))
		$rowdata += @(,('Unregistered',($htmlsilver -bor $htmlbold),$Group.DesktopsUnregistered,$htmlwhite))
		$rowdata += @(,('Disconnected',($htmlsilver -bor $htmlbold),$Group.DesktopsDisconnected,$htmlwhite))
		$rowdata += @(,('Available',($htmlsilver -bor $htmlbold),$Group.DesktopsAvailable,$htmlwhite))
		$rowdata += @(,('In Use',($htmlsilver -bor $htmlbold),$Group.DesktopsInUse,$htmlwhite))
		$rowdata += @(,('Never Registered',($htmlsilver -bor $htmlbold),$Group.DesktopsNeverRegistered,$htmlwhite))
		$rowdata += @(,('Preparing',($htmlsilver -bor $htmlbold),$Group.DesktopsPreparing,$htmlwhite))

		$msg = ""
		$columnWidths = @("200","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "400"
		WriteHTMLLine 0 0 " "
	}
	
	If($DeliveryGroups)
	{
		#retrieve machines in delivery group
		$Machines = Get-BrokerMachine -DesktopGroupName $Group.name @XDParams2 -SortBy DNSName
		If($? -and $Null -ne $Machines)
		{
			Write-Verbose "$(Get-Date): `t`tProcessing details"
			$txt = "Delivery Group Details: "
			If($MSWord -or $PDF)
			{
				WriteWordLine 2 0 $txt $Group.Name
			}
			ElseIf($text)
			{
				Line 0 $txt $Group.Name
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 2 0 $txt $Group.Name
			}
			OutputDeliveryGroupDetails $Group
			
			Write-Verbose "$(Get-Date): `t`tProcessing applications"
			OutputDeliveryGroupApplicationDetails $Group

			Write-Verbose "$(Get-Date): `t`tProcessing machine catalogs"
			OutputDeliveryGroupCatalogs $Group

			Write-Verbose "$(Get-Date): `t`tProcessing administrators"
			$Admins = GetAdmins "DesktopGroup" $Group.Name
			
			If($? -and ($Null -ne $Admins))
			{
				OutputAdminsForDetails $Admins
			}
			ElseIf($? -and ($Null -eq $Admins))
			{
				$txt = "There are no administrators for $($Group.Name)"
				OutputWarning $txt
			}
			Else
			{
				$txt = "Unable to retrieve administrators for $($Group.Name)"
				OutputWarning $txt
			}

			ForEach($Machine in $Machines)
			{
				If($Machine.SessionSupport -eq "MultiSession")
				{
					OutputServerMachineDetails $Machine
				}
				Else
				{
					OutputMachineDetails $Machine
				}
			}
		}
		ElseIf($? -and $Null -eq $Machines)
		{
			$txt = "There are no Machines for Delivery Group $($Group.name)"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve Machines for Delivery Group $($Group.name)"
			OutputWarning $txt
		}
	}
	
	If($DeliveryGroupsUtilization)
	{
		Write-Verbose "$(Get-Date): `t`t`tCreating Delivery Group Utilization report"
		OutputDeliveryGroupUtilization $Group
	}
}

Function OutputDeliveryGroupUtilization
{
	Param([object]$Group)

	#code contributed by Eduardo Molina
	#Twitter: @molikop
	#eduardo@molikop.com
	#www.molikop.com

	$txt = "Delivery Group Utilization Report"
	If($MSWord -or $PDF)
	{
		Write-Verbose "$(Get-Date): `t`t`tProcessing Utilization for $($Group.Name)"
		WriteWordLine 3 0 $txt
		WriteWordLine 4 0 "Desktop Group Name: " $Group.Name

		$xEnabled = ""
		If($Group.Enabled -eq $True -and $Group.InMaintenanceMode -eq $True)
		{
			$xEnabled = "Maintenance Mode"
		}
		ElseIf($Group.Enabled -eq $False -and $Group.InMaintenanceMode -eq $True)
		{
			$xEnabled = "Maintenance Mode"
		}
		ElseIf($Group.Enabled -eq $True -and $Group.InMaintenanceMode -eq $False)
		{
			$xEnabled = "Enabled"
		}
		ElseIf($Group.Enabled -eq $False -and $Group.InMaintenanceMode -eq $False)
		{
			$xEnabled = "Disabled"
		}

		$xColorDepth = ""
		If($Group.ColorDepth -eq "FourBit")
		{
			$xColorDepth = "4bit - 16 colors"
		}
		ElseIf($Group.ColorDepth -eq "EightBit")
		{
			$xColorDepth = "8bit - 256 colors"
		}
		ElseIf($Group.ColorDepth -eq "SixteenBit")
		{
			$xColorDepth = "16bit - High color"
		}
		ElseIf($Group.ColorDepth -eq "TwentyFourBit")
		{
			$xColorDepth = "24bit - True color"
		}

		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Description"; Value = $Group.Description; }
		$ScriptInformation += @{ Data = "User Icon Name"; Value = $Group.PublishedName; }
		$ScriptInformation += @{ Data = "Desktop Type"; Value = $Group.DesktopKind; }
		$ScriptInformation += @{ Data = "Status"; Value = $xEnabled; }
		$ScriptInformation += @{ Data = "Automatic reboots when user logs off"; Value = $Group.ShutdownDesktopsAfterUse; }
		$ScriptInformation += @{ Data = "Color Depth"; Value = $xColorDepth; }

		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
		
		Write-Verbose "$(Get-Date): `t`t`tInitializing utilization chart for $($Group.Name)"

		$TempFile =  "$($pwd)\emtempgraph_$(Get-Date -UFormat %Y%m%d_%H%M%S).csv"		
		Write-Verbose "$(Get-Date): `t`t`tGetting utilization data for $($Group.Name)"
		$Results = Get-BrokerDesktopUsage @XDParams2 -DesktopGroupName $Group.Name -SortBy Timestamp | Select-Object Timestamp, InUse

		If($? -and $Null -ne $Results)
		{
			$Results | Export-Csv $TempFile -NoTypeInformation *>$Null

			#Create excel COM object 
			$excel = New-Object -ComObject excel.application 4>$Null

			#Make not visible 
			$excel.Visible  = $False
			$excel.DisplayAlerts  = $False

			#Various Enumerations 
			$xlDirection = [Microsoft.Office.Interop.Excel.XLDirection] 
			$excelChart = [Microsoft.Office.Interop.Excel.XLChartType]
			$excelAxes = [Microsoft.Office.Interop.Excel.XlAxisType]
			$excelCategoryScale = [Microsoft.Office.Interop.Excel.XlCategoryType]
			$excelTickMark = [Microsoft.Office.Interop.Excel.XlTickMark]

			Write-Verbose "$(Get-Date): `t`t`tOpening Excel with temp file $($TempFile)"

			#Add CSV File into Excel Workbook 
			$Null = $excel.Workbooks.Open($TempFile)
			$worksheet = $excel.ActiveSheet
			$Null = $worksheet.UsedRange.EntireColumn.AutoFit()

			#Assumes that date is always on A column 
			$range = $worksheet.Range("A2")
			$selectionXL = $worksheet.Range($range,$range.end($xlDirection::xlDown))
			$Start = @($selectionXL)[0].Text
			$End = @($selectionXL)[-1].Text

			Write-Verbose "$(Get-Date): `t`t`tCreating chart for $($Group.Name)"
			$chart = $worksheet.Shapes.AddChart().Chart 

			$chart.chartType = $excelChart::xlXYScatterLines
			$chart.HasLegend = $false
			$chart.HasTitle = $true
			$chart.ChartTitle.Text = "$($Group.Name) utilization"

			#Work with the X axis for the Date Stamp 
			$xaxis = $chart.Axes($excelAxes::XlCategory)                                     
			$xaxis.HasTitle = $False
			$xaxis.CategoryType = $excelCategoryScale::xlCategoryScale
			$xaxis.MajorTickMark = $excelTickMark::xlTickMarkCross
			$xaxis.HasMajorGridLines = $true
			$xaxis.TickLabels.NumberFormat = "m/d/yyyy"
			$xaxis.TickLabels.Orientation = 48 #degrees to rotate text

			#Work with the Y axis for the number of desktops in use                                               
			$yaxis = $chart.Axes($excelAxes::XlValue)
			$yaxis.HasTitle = $true                                                       
			$yaxis.AxisTitle.Text = "Desktops in use"
			$yaxis.AxisTitle.Font.Size = 12

			$worksheet.ChartObjects().Item(1).copy()
			$word.Selection.PasteAndFormat(13)  #Pastes an Excel chart as a picture

			Write-Verbose "$(Get-Date): `t`t`tClosing excel for $($Group.Name)"
			#$excel.Workbooks.Close($false)
			$excel.Workbooks.Close()
			$excel.Quit()

			FindWordDocumentEnd
			WriteWordLine 0 0 ""
			
			While( [System.Runtime.Interopservices.Marshal]::ReleaseComObject($selectionXL)){}
			While( [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Range)){}
			#While( [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Chart)){}
			While( [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Worksheet)){}
			While( [System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)){}

			If(Test-Path variable:excel)
			{
				Remove-Variable -Name excel 4>$Null
			}

			#If the Excel.exe process is still running for the user's sessionID, kill it
			$SessionID = (Get-Process -PID $PID).SessionId
			(Get-Process 'Excel' -ea 0 | Where-Object {$_.sessionid -eq $Sessionid}) | Stop-Process 4>$Null
			
			Write-Verbose "$(Get-Date): `t`t`tDeleting temp file $($TempFile)"
			Remove-Item $TempFile *>$Null
			[int]$cnt = 0
			While(Test-Path $TempFile)
			{
				$cnt++
				If($cnt -gt 1)
				{
					Write-Verbose "$(Get-Date): `t`t`tWaiting another 10 seconds to allow Excel to fully close (try # $($cnt))"
					Start-Sleep -Seconds 10
					If($cnt -gt 2)
					{
						#kill the winword process

						#Find out if excel is running in our session
						$excelprocess = ((Get-Process 'Excel' -ea 0) | Where-Object {$_.SessionId -eq $SessionID}).Id
						If($excelprocess -gt 0)
						{
							Write-Verbose "$(Get-Date): `t`t`tAttempting to stop Excel process # $($excelprocess)"
							Stop-Process $excelprocess -EA 0
						}
					}
				}
				Write-Verbose "$(Get-Date): `t`t`tAttempting to delete $($TempFile) again - try # $($cnt))"
				Remove-Item $TempFile -EA 0 4>$Null
			}
		}
		ElseIf($? -and $Null -eq $Results)
		{
			$txt = "There is no Utilization data for $($Group.Name)"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve Utilization data for $($Group.name)"
			OutputWarning $txt
		}
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputDeliveryGroupDetails 
{
	Param([object] $Group)

	$xDGType = "Delivery Group Type cannot be determined: $($Group.DeliveryType) $($Group.DesktopKind)"
	If($Group.DeliveryType -eq "AppsOnly" -and $Group.DesktopKind -eq "Shared")
	{
		$xDGType = "Random Applications"
	}
	ElseIf($Group.DeliveryType -eq "DesktopsOnly" -and $Group.DesktopKind -eq "Shared")
	{
		$xDGType = "Random Desktops"
	}
	ElseIf($Group.DeliveryType -eq "DesktopsOnly" -and $Group.DesktopKind -eq "Private")
	{
		$xDGType = "Static Desktops"
	}
	ElseIf($Group.DeliveryType -eq "DesktopsAndApps" -and $Group.DesktopKind -eq "Shared")
	{
		$xDGType = "Random Desktops and applications"
	}
	
	$xDeliveryType = ""
	Switch ($Group.DeliveryType)
	{
		"DesktopsOnly"	{$xDeliveryType = "Desktops"; Break}
		"AppsOnly"		{$xDeliveryType = "Applications"; Break}
		"DesktopsAndApps"	{$xDeliveryType = "Desktops and applications"; Break}
		Default	{"Delivery Type could not be determined: $($Group.DeliveryType)"; Break}
	}
		
	$xVDAVersion = ""
	Switch ($Group.MinimumFunctionalLevel)
	{
		"L5" 	{$xVDAVersion = "5.6 FP1 (Windows XP and Windows Vista)"; Break}
		"L7"	{$xVDAVersion = "7.0 (or newer)"; Break}
		"L7_6"	{$xVDAVersion = "7.6 (or newer)"; Break}
		"L7_7"	{$xVDAVersion = "7.7 (recommended, to access the latest features)"; Break}
		Default {"Unable to determine VDA version: $($Group.MinimumFunctionalLevel)"; Break}
	}
	
	$xColorDepth = ""
	If($Group.ColorDepth -eq "FourBit")
	{
		$xColorDepth = "4bit - 16 colors"
	}
	ElseIf($Group.ColorDepth -eq "EightBit")
	{
		$xColorDepth = "8bit - 256 colors"
	}
	ElseIf($Group.ColorDepth -eq "SixteenBit")
	{
		$xColorDepth = "16bit - High color"
	}
	ElseIf($Group.ColorDepth -eq "TwentyFourBit")
	{
		$xColorDepth = "24bit - True color"
	}
	
	$xShutdownDesktopsAfterUse = "No"
	If($Group.ShutdownDesktopsAfterUse)
	{
		$xShutdownDesktopsAfterUse = "Yes"
	}
	
	$xTurnOnAddedMachine = "No"
	If($Group.TurnOnAddedMachine)
	{
		$xTurnOnAddedMachine = "Yes"
	}

	$DGIncludedUsers = @()
	$DGExcludedUsers = @()
	$PolicyRule = Get-BrokerAccessPolicyRule @XDParams1 -DesktopGroupUid $Group.Uid
	
	If($? -and $Null -ne $PolicyRule)
	{
		If($PolicyRule.IncludedUserFilterEnabled -eq $True)
		{
			ForEach($User in $PolicyRule.IncludedUsers)
			{
				$DGIncludedUsers += $User.Name
			}
			
			[array]$DGIncludedUsers = $DGIncludedUsers | Sort-Object -unique
		}
		
		If($PolicyRule.ExcludedUserFilterEnabled -eq $True)
		{
			ForEach($User in $PolicyRule.ExcludedUsers)
			{
				$DGExcludedUsers += $User.Name
			}

			[array]$DGExcludedUsers = $DGExcludedUsers | Sort-Object -unique
		}
	}
	
	$DGScopes = @()
	ForEach($Scope in $Group.Scopes)
	{
		$DGScopes += $Scope
	}
	$DGScopes += "All"
	
	$DGSFServers = @()
	ForEach($Server in $Group.MachineConfigurationNames)
	{
		$SFTmp = Get-BrokerMachineConfiguration -Name $Server
		If($? -and $Null -ne $SFTmp)
		{
			$SFByteArray = $SFTmp.Policy
			$SFServer = Get-SFStoreFrontAddress -ByteArray $SFByteArray 4>$Null
			If($? -and $Null -ne $SFServer)
			{
				$DGSFServers += $SFServer.Url
			}
		}
	}
	
	If($DGSFServers.Count -eq 0)
	{
		$DGSFServers += "-"
	}
	
	$xSessionPrelaunch = "Off"
	[int]$xSessionPrelaunchAvgLoad = 0
	[int]$xSessionPrelaunchAnyLoad = 0
	$xSessionLinger = "Off"
	[int]$xSessionLingerAvgLoad = 0
	[int]$xSessionLingerAnyLoad = 0
	$xEndPrelaunchSession = ""
	$xEndLinger = ""
	
	$Results = Get-BrokerSessionPreLaunch -DesktopGroupUid $Group.Uid @XDParams1
	If($? -and $Null -ne $Results)
	{
		If($Results.Enabled -and $Results.AssociatedUserFullNames.Count -eq 0)
		{
			$xSessionPrelaunch = "Prelaunch for any user"
		}
		ElseIf($Results.Enabled -and $Results.AssociatedUserFullNames.Count -gt 0)
		{
			$xSessionPrelaunch = "Prelaunch for specific users"
		}
		
		If($Results.MaxAverageLoadThreshold -gt 0)
		{
			$xSessionPrelaunchAvgLoad = ($Results.MaxAverageLoadThreshold/100)
		}
		If($Results.MaxLoadPerMachineThreshold -gt 0)
		{
			$xSessionPrelaunchAnyLoad = ($Results.MaxLoadPerMachineThreshold/100)
		}
		$Mins = $Results.MaxTimeBeforeTerminate.Minutes
		$Hours = $Results.MaxTimeBeforeTerminate.Hours
		$Days = $Results.MaxTimeBeforeTerminate.Days
		If($Mins -gt 0)
		{
			$xEndPrelaunchSession = "$($Mins) Minutes"
		}
		If($Hours -gt 0)
		{
			$xEndPrelaunchSession = "$($Hours) Hours"
		}
		ElseIf($Days -gt 0)
		{
			$xEndPrelaunchSession = "$($Days) Days"
		}
	}
	
	$Results = Get-BrokerSessionLinger -DesktopGroupUid $Group.Uid @XDParams1
	If($? -and $Null -ne $Results)
	{
		$xSessionLinger = "Keep session active"
		If($Results.MaxAverageLoadThreshold -gt 0)
		{
			$xSessionLingerAvgLoad = ($Results.MaxAverageLoadThreshold/100)
		}
		If($Results.MaxLoadPerMachineThreshold -gt 0)
		{
			$xSessionLingerAnyLoad = ($Results.MaxLoadPerMachineThreshold/100)
		}
		$Mins = $Results.MaxTimeBeforeTerminate.Minutes
		$Hours = $Results.MaxTimeBeforeTerminate.Hours
		$Days = $Results.MaxTimeBeforeTerminate.Days
		If($Mins -gt 0)
		{
			$xEndLinger = "$($Mins) Minutes"
		}
		If($Hours -gt 0)
		{
			$xEndLinger = "$($Hours) Hours"
		}
		ElseIf($Days -gt 0)
		{
			$xEndLinger = "$($Days) Days"
		}
	}

	$PwrMgmt1 = $False
	$PwrMgmt2 = $False
	$PwrMgmt3 = $False
	
	#get a desktop in an associated delivery group to get the catalog
	$Desktop = Get-BrokerDesktop @XDParams1 -DesktopGroupUid $Group.Uid -Property CatalogName
	
	If($? -and $Null -ne $Desktop)
	{
		$Catalog = Get-BrokerCatalog @XDParams1 -Name $Desktop[0].CatalogName
		
		If($? -and $Null -ne $Catalog)
		{
			If($Catalog.AllocationType -eq "Static" -and $Catalog.PersistUserChanges -eq "Discard" -and $Group.DesktopKind -eq "Private" -and $Group.SessionSupport -eq "SingleSession")
			{
				$PwrMgmt1 = $True
				$PwrMgmt2 = $False
				$PwrMgmt3 = $False
			}
			ElseIf($Catalog.AllocationType -eq "Static" -and $Catalog.PersistUserChanges -ne "Discard" -and $Group.DesktopKind -eq "Private" -and $Group.SessionSupport -eq "SingleSession")
			{
				$PwrMgmt1 = $False
				$PwrMgmt2 = $True
				$PwrMgmt3 = $False
			}
			ElseIf($Catalog.AllocationType -eq "Random" -and $Catalog.PersistUserChanges -eq "Discard" -and $Group.DesktopKind -eq "Shared" -and $Group.SessionSupport -eq "SingleSession")
			{
				$PwrMgmt1 = $False
				$PwrMgmt2 = $False
				$PwrMgmt3 = $True
			}
		}
	}

	If($PwrMgmt2 -or $PwrMgmt3)
	{
		$PwrMgmts = Get-BrokerPowerTimeScheme @XDParams1 -DesktopGroupUid $Group.Uid 
	}
	
	$xOffPeakBufferSizePercent = $Group.OffPeakBufferSizePercent
	$xOffPeakDisconnectTimeout = $Group.OffPeakDisconnectTimeout
	$xOffPeakExtendedDisconnectTimeout = $Group.OffPeakExtendedDisconnectTimeout
	$xOffPeakLogOffTimeout = $Group.OffPeakLogOffTimeout
	$xPeakBufferSizePercent = $Group.PeakBufferSizePercent
	$xPeakDisconnectTimeout = $Group.PeakDisconnectTimeout
	$xPeakExtendedDisconnectTimeout = $Group.PeakExtendedDisconnectTimeout
	$xPeakLogOffTimeout = $Group.PeakLogOffTimeout
	$xSettlementPeriodBeforeAutoShutdown = $Group.SettlementPeriodBeforeAutoShutdown
	
	$xOffPeakDisconnectAction = ""
	$xOffPeakExtendedDisconnectAction = ""
	$xOffPeakLogOffAction = ""
	$xPeakDisconnectAction = ""
	$xPeakExtendedDisconnectAction = ""
	$xPeakLogOffAction = ""

	Switch ($Group.OffPeakDisconnectAction)
	{
		"Nothing"	{ $xOffPeakDisconnectAction = "No action"; Break}
		"Suspend"	{ $xOffPeakDisconnectAction = "Suspend"; Break}
		"Shutdown"	{ $xOffPeakDisconnectAction = "Shut down"; Break}
		Default	{ $xOffPeakDisconnectAction = "Unable to determine the OffPeakDisconnectAction action: $($Group.OffPeakDisconnectAction)"; Break}
	}
	
	Switch ($Group.OffPeakExtendedDisconnectAction)
	{
		"Nothing"	{ $xOffPeakExtendedDisconnectAction = "No action"; Break}
		"Suspend"	{ $xOffPeakExtendedDisconnectAction = "Suspend"; Break}
		"Shutdown"	{ $xOffPeakExtendedDisconnectAction = "Shut down"; Break}
		Default	{ $xOffPeakExtendedDisconnectAction = "Unable to determine the OffPeakExtendedDisconnectAction action: $($Group.OffPeakExtendedDisconnectAction)"; Break}
	}
	
	Switch ($Group.OffPeakLogOffAction)
	{
		"Nothing"	{ $xOffPeakLogOffAction = "No action"; Break}
		"Suspend"	{ $xOffPeakLogOffAction = "Suspend"; Break}
		"Shutdown"	{ $xOffPeakLogOffAction = "Shut down"; Break}
		Default	{ $xOffPeakLogOffAction = "Unable to determine $xOffPeakLogOffAction action: $($Group.OffPeakLogOffAction)"; Break}
	}
	
	Switch ($Group.PeakDisconnectAction)
	{
		"Nothing"	{ $xPeakDisconnectAction = "No action"; Break}
		"Suspend"	{ $xPeakDisconnectAction = "Suspend"; Break}
		"Shutdown"	{ $xPeakDisconnectAction = "Shut down"; Break}
		Default	{ $xPeakDisconnectAction = "Unable to determine $xPeakDisconnectAction action: $($Group.PeakDisconnectAction)"; Break}
	}
	
	Switch ($Group.PeakExtendedDisconnectAction)
	{
		"Nothing"	{ $xPeakExtendedDisconnectAction = "No action"; Break}
		"Suspend"	{ $xPeakExtendedDisconnectAction = "Suspend"; Break}
		"Shutdown"	{ $xPeakExtendedDisconnectAction = "Shut down"; Break}
		Default	{ $xPeakExtendedDisconnectAction = "Unable to determine $xPeakExtendedDisconnectAction action: $($Group.PeakExtendedDisconnectAction)"; Break}
	}
	
	Switch ($Group.PeakLogOffAction)
	{
		"Nothing"	{ $xPeakLogOffAction = "No action"; Break}
		"Suspend"	{ $xPeakLogOffAction = "Suspend"; Break}
		"Shutdown"	{ $xPeakLogOffAction = "Shut down"; Break}
		Default	{ $xPeakLogOffAction = "Unable to determine PeakLogOffAction action: $($Group.PeakLogOffAction)"; Break}
	}

	$xEnabled = "Disabled"
	If($Group.Enabled -eq $True)
	{
		$xEnabled = "Enabled"
	}

	$xSecureICA = "Disabled"
	If($Group.SecureICARequired -eq $True)
	{
		$xSecureICA = "Enabled"
	}
	
	#added 17-jun-2015
	$xAutoPowerOnForAssigned = "Disabled"
	$xAutoPowerOnForAssignedDuringPeak = "Disabled"
	
	If($Group.AutomaticPowerOnForAssigned)
	{
		$xAutoPowerOnForAssigned = "Enabled"
	}
	If($Group.AutomaticPowerOnForAssignedDuringPeak)
	{
		$xAutoPowerOnForAssignedDuringPeak = "Enabled"
	}

	$Results = Get-BrokerAccessPolicyRule -DesktopGroupUid $Group.Uid @XDParams1
	If($? -and $Null -ne $Results)
	{
		ForEach($Result in $Results)
		{
			If($Result.Name -like '*_AG')
			{
				If($Result.AllowedConnections -eq "ViaAG" -and $Result.IncludedSmartAccessFilterEnabled -eq $False -and $Result.Enabled -eq $True)
				{
					$xAllConnections = "Enabled"
					$xNSConnection = "Disabled"
					$xAGFilters = @()
					$xAGFilters += "<N/A>"
				}
				ElseIf($Result.AllowedConnections -eq "ViaAG" -and $Result.IncludedSmartAccessFilterEnabled -eq $True -and $Result.Enabled -eq $True)
				{
					$xAllConnections = "Enabled"
					$xNSConnection = "Enabled"
					$xAGFilters = @()
					ForEach($AccessCondition in $Result.IncludedSmartAccessTags)
					{
						$xAGFilters += $AccessCondition
					}
					If($xAGFilters.Count -eq 0)
					{
						$xAGFilters += "<none>"
					}
				}
				ElseIf($Result.AllowedConnections -eq "ViaAG" -and $Result.IncludedSmartAccessFilterEnabled -eq $False -and $Result.Enabled -eq $False)
				{
					$xAllConnections = "Disabled"
					$xNSConnection = "Disabled"
					$xAGFilters = @()
					$xAGFilters += "<N/A>"
				}
			}
		}
	}
	
	#desktops per user for singlesession OS
	If($Group.SessionSupport -eq "SingleSession")
	{
		If($xDGType -eq "Static Desktops")
		{
			#static desktops have a maxdesktops count stored as a property
			$xMaxDesktops = 0
			$MaxDesktops = Get-BrokerAssignmentPolicyRule @XDParams1 -DesktopGroupUid $Group.Uid
			
			If($? -and $Null -ne $MaxDesktops)
			{
				$xMaxDesktops = $MaxDesktops.MaxDesktops
			}
		}
		ElseIf($xDGType -like "*Random*")
		{
			#random desktops are a count of the number of entitlement policy rules
			$xMaxDesktops = 0
			$MaxDesktops = Get-BrokerEntitlementPolicyRule @XDParams1 -DesktopGroupUid $Group.Uid
			
			If($? -and $Null -ne $MaxDesktops)
			{
				$xMaxDesktops = $MaxDesktops.Count
			}
		}
	}
	
	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Details: " $Group.Name
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Description"; Value = $Group.Description; }
		If(![String]::IsNullOrEmpty($Group.PublishedName))
		{
			$ScriptInformation += @{ Data = "Display Name"; Value = $Group.PublishedName; }
		}
		$ScriptInformation += @{ Data = "Type"; Value = $xDGType; }
		$ScriptInformation += @{ Data = "Set to VDA version"; Value = $xVDAVersion; }
		If($Group.SessionSupport -eq "SingleSession" -and ($xDGType -eq "Static Desktops" -or $xDGType -like "*Random*"))
		{
			$ScriptInformation += @{ Data = "Desktops per user"; Value = $xMaxDesktops; }
		}
		$ScriptInformation += @{ Data = "Time zone"; Value = $Group.TimeZone; }
		$ScriptInformation += @{ Data = "Enable Delivery Group"; Value = $xEnabled; }
		$ScriptInformation += @{ Data = "Enable Secure ICA"; Value = $xSecureICA; }
		$ScriptInformation += @{ Data = "Color Depth"; Value = $xColorDepth; }
		$ScriptInformation += @{ Data = "Shutdown Desktops After Use"; Value = $xShutdownDesktopsAfterUse; }
		$ScriptInformation += @{ Data = "Turn On Added Machine"; Value = $xTurnOnAddedMachine; }
		$ScriptInformation += @{ Data = "Included Users"; Value = $DGIncludedUsers[0]; }
		$cnt = -1
		ForEach($tmp in $DGIncludedUsers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		
		If($DGExcludedUsers.Count -gt 0)
		{
			$ScriptInformation += @{ Data = "Excluded Users"; Value = $DGExcludedUsers[0]; }
			$cnt = -1
			ForEach($tmp in $DGExcludedUsers)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$ScriptInformation += @{ Data = ""; Value = $tmp; }
				}
			}
		}

		$ScriptInformation += @{ Data = "Scopes"; Value = $DGScopes[0]; }
		$cnt = -1
		ForEach($tmp in $DGScopes)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		
		$ScriptInformation += @{ Data = "StoreFronts"; Value = $DGSFServers[0]; }
		$cnt = -1
		ForEach($tmp in $DGSFServers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		
		If($Group.SessionSupport -eq "MultiSession" -and $Group.DeliveryType -like '*Apps*')
		{
			$ScriptInformation += @{ Data = "Session prelaunch"; Value = $xSessionPrelaunch; }
			If($xSessionPrelaunch -ne "Off")
			{
				$ScriptInformation += @{ Data = "Prelaunched session will end in"; Value = $xEndPrelaunchSession; }
				
				If($xSessionPrelaunchAvgLoad -gt 0)
				{
					$ScriptInformation += @{ Data = "When avg load on all machines exceeds (%)"; Value = $xSessionPrelaunchAvgLoad; }
				}
				If($xSessionPrelaunchAnyLoad -gt 0)
				{
					$ScriptInformation += @{ Data = "When load on any machines exceeds (%)"; Value = $xSessionPrelaunchAnyLoad; }
				}
			}
			$ScriptInformation += @{ Data = "Session lingering"; Value = $xSessionLinger; }
			If($xSessionLinger -ne "Off")
			{
				$ScriptInformation += @{ Data = "Keep sessions active until after"; Value = $xEndLinger; }
				
				If($xSessionLingerAvgLoad -gt 0)
				{
					$ScriptInformation += @{ Data = "When avg load on all machines exceeds (%)"; Value = $xSessionPrelaunchAvgLoad; }
				}
				If($xSessionLingerAnyLoad -gt 0)
				{
					$ScriptInformation += @{ Data = "When load on any machines exceeds (%)"; Value = $xSessionPrelaunchAnyLoad; }
				}
			}
		}
		
		If($Group.SessionSupport -eq "MultiSession")
		{
			$RestartSchedule = Get-BrokerRebootSchedule @XDParams1 -DesktopGroupUid $Group.Uid
			
			If($? -and $Null -ne $RestartSchedule)
			{
				$ScriptInformation += @{ Data = "Restart machines automatically"; Value = "Yes"; }
				
				$tmp = ""
				If($RestartSchedule.Frequency -eq "Daily")
				{
					$tmp = "Daily"
				}
				ElseIf($RestartSchedule.Frequency -eq "Weekly")
				{
					$tmp = "Every $($RestartSchedule.Day)"
				}
				
				$ScriptInformation += @{ Data = "Restart machines"; Value = $tmp; }
				$ScriptInformation += @{ Data = "Restart first group at"; Value = "$($RestartSchedule.StartTime.Hours.ToString("00")):$($RestartSchedule.StartTime.Minutes.ToString("00"))"; }
				
				$xTime = 0
				$tmp = ""
				If($RestartSchedule.RebootDuration -eq 0)
				{
					$tmp = "Restart all machines at once"
				}
				ElseIf($RestartSchedule.RebootDuration -eq 30)
				{
					$tmp = "30 minutes"
				}
				Else
				{
					$xTime = $RestartSchedule.RebootDuration / 60
					$tmp = "$($xTime) hours"
				}
				$ScriptInformation += @{ Data = "Restart additional groups every"; Value = $tmp; }
				$xTime = $Null
				$tmp = $Null
				
				$tmp = ""
				If($RestartSchedule.WarningDuration -eq 0)
				{
					$tmp = "Do not send a notification"
					$ScriptInformation += @{ Data = "Send restart notification to user"; Value = $tmp; }
				}
				Else
				{
					$tmp = "$($RestartSchedule.WarningDuration) minutes before user is logged off"
					$ScriptInformation += @{ Data = "Send restart notification to user"; Value = $tmp; }
					$ScriptInformation += @{ Data = "Notification message"; Value = $RestartSchedule.WarningMessage; }
				}
				
			}
			Else
			{
				$ScriptInformation += @{ Data = "Restart machines automatically"; Value = "No"; }
			}
		}

		#added in V1.41
		#this data has been collected for a long time, I simple forgot to add it to the output
		$ScriptInformation += @{ Data = "Off Peak Buffer Size Percent"; Value = $xOffPeakBufferSizePercent; }
		$ScriptInformation += @{ Data = "Off Peak Disconnect Timeout (Minutes)"; Value = $xOffPeakDisconnectTimeout; }
		$ScriptInformation += @{ Data = "Off Peak Extended Disconnect Timeout (Minutes)"; Value = $xOffPeakExtendedDisconnectTimeout; }
		$ScriptInformation += @{ Data = "Off Peak LogOff Timeout (Minutes)"; Value = $xOffPeakLogOffTimeout; }
		$ScriptInformation += @{ Data = "Peak Buffer Size Percent"; Value = $xPeakBufferSizePercent; }
		$ScriptInformation += @{ Data = "Peak Disconnect Timeout (Minutes)"; Value = $xPeakDisconnectTimeout; }
		$ScriptInformation += @{ Data = "Peak Extended Disconnect Timeout (Minutes)"; Value = $xPeakExtendedDisconnectTimeout; }
		$ScriptInformation += @{ Data = "Peak LogOff Timeout (Minutes)"; Value = $xPeakLogOffTimeout; }
		$ScriptInformation += @{ Data = "Settlement Period Before Autoshutdown (HH:MM:SS)"; Value = $xSettlementPeriodBeforeAutoShutdown; }

		If($PwrMgmt1)
		{
			$ScriptInformation += @{ Data = "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins"; Value = $xPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins"; Value = $xPeakExtendedDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins"; Value = $xOffPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins"; Value = $xOffPeakExtendedDisconnectAction; }
		}
		If($PwrMgmt2)
		{
			$ScriptInformation += @{ Data = "Weekday Peak hours"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($i.ToString("00")):00"; }
						}
					}
				}
			}

			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}

			$ScriptInformation += @{ Data = "Weekend Peak hours"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($i.ToString("00")):00"; }
						}
					}
				}
			}

			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}

			$ScriptInformation += @{ Data = "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins"; Value = $xPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins"; Value = $xPeakExtendedDisconnectAction; }
			$ScriptInformation += @{ Data = "During peak hours, when logged off $($Group.PeakLogOffTimeout) mins"; Value = $xPeakLogOffAction; }
			$ScriptInformation += @{ Data = "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins"; Value = $xOffPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins"; Value = $xOffPeakExtendedDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak hours, when logged off $($Group.OffPeakLogOffTimeout) mins"; Value = $xOffPeakLogOffAction; }
		}
		If($PwrMgmt3)
		{
			$ScriptInformation += @{ Data = "Weekday number machines powered on, and when"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00"; }
						}
					}
				}
			}

			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}

			$ScriptInformation += @{ Data = "Weekend number machines powered on, and when"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00"; }
						}
					}
				}
			}
			
			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}
			
			$ScriptInformation += @{ Data = "Weekday Peak hours"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($i.ToString("00")):00"; }
						}
					}
				}
			}

			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}

			$ScriptInformation += @{ Data = "Weekend Peak hours"; Value = ""; }
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$ScriptInformation += @{ Data = ""; Value = "$($i.ToString("00")):00"; }
						}
					}
				}
			}

			If($val -eq 0)
			{
				$ScriptInformation += @{ Data = ""; Value = "<none>"; }
			}

			$ScriptInformation += @{ Data = "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins"; Value = $xPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins"; Value = $xPeakExtendedDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins"; Value = $xOffPeakDisconnectAction; }
			$ScriptInformation += @{ Data = "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins"; Value = $xOffPeakExtendedDisconnectAction; }
		}

		$ScriptInformation += @{ Data = "Automatic power on for assigned"; Value = $xAutoPowerOnForAssigned; }
		$ScriptInformation += @{ Data = "Automatic power on for assigned during peak"; Value = $xAutoPowerOnForAssignedDuringPeak; }
		
		$ScriptInformation += @{ Data = "All connections not through NetScaler Gateway"; Value = $xAllConnections; }
		$ScriptInformation += @{ Data = "Connections through NetScaler Gateway"; Value = $xNSConnection; }
		$ScriptInformation += @{ Data = "Connections meeting any of the following filters"; Value = $xAGFilters[0]; }
		$cnt = -1
		ForEach($tmp in $xAGFilters)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 0 "Details: " $Group.Name
		Line 1 "Description`t`t`t`t`t: " $Group.Description
		If(![String]::IsNullOrEmpty($Group.PublishedName))
		{
			Line 1 "Display Name`t`t`t`t`t: " $Group.PublishedName
		}
		Line 1 "Type`t`t`t`t`t`t: " $xDGType
		Line 1 "Set to VDA version`t`t`t`t: " $xVDAVersion
		If($Group.SessionSupport -eq "SingleSession" -and ($xDGType -eq "Static Desktops" -or $xDGType -like "*Random*"))
		{
			Line 1 "Desktops per user`t`t`t`t: " $xMaxDesktops
		}
		Line 1 "Time zone`t`t`t`t`t: " $Group.TimeZone
		Line 1 "Enable Delivery Group`t`t`t`t: " $xEnabled
		Line 1 "Enable Secure ICA`t`t`t`t: " $xSecureICA
		Line 1 "Color Depth`t`t`t`t`t: " $xColorDepth
		Line 1 "Shutdown Desktops After Use`t`t`t: " $xShutdownDesktopsAfterUse
		Line 1 "Turn On Added Machine`t`t`t`t: " $xTurnOnAddedMachine
		Line 1 "Included Users`t`t`t`t`t: " $DGIncludedUsers[0]
		$cnt = -1
		ForEach($tmp in $DGIncludedUsers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 7 "  " $tmp
			}
		}
		
		If($DGExcludedUsers.Count -gt 0)
		{
			Line 1 "Excluded Users`t`t`t`t`t: " $DGExcludedUsers[0]
			$cnt = -1
			ForEach($tmp in $DGExcludedUsers)
			{
				$cnt++
				If($cnt -gt 0)
				{
					Line 7 "  " $tmp
				}
			}
		}

		Line 1 "Scopes`t`t`t`t`t`t: " $DGScopes[0]
		$cnt = -1
		ForEach($tmp in $DGScopes)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 7 "  " $tmp
			}
		}
		
		Line 1 "StoreFronts`t`t`t`t`t: " $DGSFServers[0]
		$cnt = -1
		ForEach($tmp in $DGSFServers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 7 "  " $tmp
			}
		}
		
		If($Group.SessionSupport -eq "MultiSession" -and $Group.DeliveryType -like '*Apps*')
		{
			Line 1 "Session prelaunch`t`t`t`t: " $xSessionPrelaunch
			If($xSessionPrelaunch -ne "Off")
			{
				Line 1 "Prelaunched session will end in`t`t`t: " $xEndPrelaunchSession
				
				If($xSessionPrelaunchAvgLoad -gt 0)
				{
					Line 1 "When avg load on all machines exceeds (%)`t: " $xSessionPrelaunchAvgLoad
				}
				If($xSessionPrelaunchAnyLoad -gt 0)
				{
					Line 1 "When load on any machines exceeds (%)`t`t: " $xSessionPrelaunchAnyLoad
				}
			}
			Line 1 "Session lingering`t`t`t`t: " $xSessionLinger
			If($xSessionLinger -ne "Off")
			{
				Line 1 "Keep sessions active until after`t`t: " $xEndLinger
				
				If($xSessionLingerAvgLoad -gt 0)
				{
					Line 1 "When avg load on all machines exceeds (%)`t: " $xSessionPrelaunchAvgLoad
				}
				If($xSessionLingerAnyLoad -gt 0)
				{
					Line 1 "When load on any machines exceeds (%)`t`t: " $xSessionPrelaunchAnyLoad
				}
			}
		}
		
		If($Group.SessionSupport -eq "MultiSession")
		{
			$RestartSchedule = Get-BrokerRebootSchedule @XDParams1 -DesktopGroupUid $Group.Uid
			
			If($? -and $Null -ne $RestartSchedule)
			{
				Line 1 "Restart machines automatically`t`t`t: " "Yes"
				
				$tmp = ""
				If($RestartSchedule.Frequency -eq "Daily")
				{
					$tmp = "Daily"
				}
				ElseIf($RestartSchedule.Frequency -eq "Weekly")
				{
					$tmp = "Every $($RestartSchedule.Day)"
				}
				
				Line 1 "Restart machines`t`t`t`t: " $tmp
				Line 1 "Restart first group at`t`t`t`t: " "$($RestartSchedule.StartTime.Hours.ToString("00")):$($RestartSchedule.StartTime.Minutes.ToString("00"))"
				
				$xTime = 0
				$tmp = ""
				If($RestartSchedule.RebootDuration -eq 0)
				{
					$tmp = "Restart all machines at once"
				}
				ElseIf($RestartSchedule.RebootDuration -eq 30)
				{
					$tmp = "30 minutes"
				}
				Else
				{
					$xTime = $RestartSchedule.RebootDuration / 60
					$tmp = "$($xTime) hours"
				}
				Line 1 "Restart additional groups every`t`t`t: " $tmp
				$xTime = $Null
				$tmp = $Null
				
				$tmp = ""
				If($RestartSchedule.WarningDuration -eq 0)
				{
					$tmp = "Do not send a notification"
					Line 1 "Send restart notification to user`t`t: " $tmp
				}
				Else
				{
					$tmp = "$($RestartSchedule.WarningDuration) minutes before user is logged off"
					Line 1 "Send restart notification to user`t`t: " $tmp
					Line 1 "Notification message`t`t`t`t: " $RestartSchedule.WarningMessage
				}
				
			}
			Else
			{
				Line 1 "Restart machines automatically`t`t`t: " "No"
			}
		}
		
		#added in V1.41
		#this data has been collected for a long time, I simple forgot to add it to the output
		Line 1 "Off Peak Buffer Size Percent`t`t`t: " $xOffPeakBufferSizePercent
		Line 1 "Off Peak Disconnect Timeout (Minutes)`t`t: " $xOffPeakDisconnectTimeout
		Line 1 "Off Peak Extended Disconnect Timeout (Minutes)`t: " $xOffPeakExtendedDisconnectTimeout
		Line 1 "Off Peak LogOff Timeout (Minutes)`t`t: " $xOffPeakLogOffTimeout
		Line 1 "Peak Buffer Size Percent`t`t`t: " $xPeakBufferSizePercent
		Line 1 "Peak Disconnect Timeout (Minutes)`t`t: " $xPeakDisconnectTimeout
		Line 1 "Peak Extended Disconnect Timeout (Minutes)`t: " $xPeakExtendedDisconnectTimeout
		Line 1 "Peak LogOff Timeout (Minutes)`t`t`t: " $xPeakLogOffTimeout
		Line 1 "Settlement Period Before Autoshutdown (HH:MM:SS): " $xSettlementPeriodBeforeAutoShutdown
		
		If($PwrMgmt1)
		{
			Line 1 "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins`t: " $xPeakDisconnectAction
			Line 1 "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins`t: " $xPeakExtendedDisconnectAction
			Line 1 "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins: " $xOffPeakDisconnectAction
			Line 1 "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins: " $xOffPeakExtendedDisconnectAction
		}
		If($PwrMgmt2)
		{
			Line 1 "Weekday Peak hours`t`t`t`t:" ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							Line 7 "  " "$($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "Weekend Peak hours`t`t`t`t: " ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							Line 7 "  " "$($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins`t: " $xPeakDisconnectAction
			Line 1 "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins`t: " $xPeakExtendedDisconnectAction
			Line 1 "During peak hours, when logged off $($Group.PeakLogOffTimeout) mins`t: " $xPeakLogOffAction
			Line 1 "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins`t: " $xOffPeakDisconnectAction
			Line 1 "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins`t: " $xOffPeakExtendedDisconnectAction
			Line 1 "During off-peak hours, when logged off $($Group.OffPeakLogOffTimeout) mins`t: " $xOffPeakLogOffAction
		}
		If($PwrMgmt3)
		{
			Line 1 "Weekday number machines powered on, and when`t: " ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							Line 7 "  " "$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "Weekend number machines powered on, and when`t: " ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							Line 7 "  " "$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "Weekday Peak hours: " ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							Line 7 "  " "$($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "Weekend Peak hours: " ""
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							Line 7 "  " "$($i.ToString("00")):00"
						}
					}
				}
			}

			If($val -eq 0)
			{
				Line 7 "  "  "<none>"
			}

			Line 1 "During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins`t: " $xPeakDisconnectAction
			Line 1 "During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins`t: " $xPeakExtendedDisconnectAction
			Line 1 "During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins: " $xOffPeakDisconnectAction
			Line 1 "During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins: " $xOffPeakExtendedDisconnectAction
		}

		Line 1 "Automatic power on for assigned`t`t`t: " $xAutoPowerOnForAssigned
		Line 1 "Automatic power on for assigned during peak`t: " $xAutoPowerOnForAssignedDuringPeak
		
		Line 1 "All connections not through NetScaler Gateway`t: " $xAllConnections
		Line 1 "Connections through NetScaler Gateway`t`t: " $xNSConnection
		Line 1 "Connections meeting any of the following filters: " $xAGFilters[0]
		$cnt = -1
		ForEach($tmp in $xAGFilters)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 7 "  " $tmp
			}
		}
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Details: " $Group.Name
		$rowdata = @()
		$columnHeaders = @("Description",($htmlsilver -bor $htmlbold),$Group.Description,$htmlwhite)
		If(![String]::IsNullOrEmpty($Group.PublishedName))
		{
			$rowdata += @(,('Display Name',($htmlsilver -bor $htmlbold),$Group.PublishedName,$htmlwhite))
		}
		$rowdata += @(,('Type',($htmlsilver -bor $htmlbold),$xDGType,$htmlwhite))
		$rowdata += @(,('Set to VDA version',($htmlsilver -bor $htmlbold),$xVDAVersion,$htmlwhite))
		If($Group.SessionSupport -eq "SingleSession" -and ($xDGType -eq "Static Desktops" -or $xDGType -like "*Random*"))
		{
			$rowdata += @(,('Desktops per user',($htmlsilver -bor $htmlbold),$xMaxDesktops,$htmlwhite))
		}
		$rowdata += @(,('Time zone',($htmlsilver -bor $htmlbold),$Group.TimeZone,$htmlwhite))
		$rowdata += @(,('Enable Delivery Group',($htmlsilver -bor $htmlbold),$xEnabled,$htmlwhite))
		$rowdata += @(,('Enable Secure ICA',($htmlsilver -bor $htmlbold),$xSecureICA,$htmlwhite))
		$rowdata += @(,('Color Depth',($htmlsilver -bor $htmlbold),$xColorDepth,$htmlwhite))
		$rowdata += @(,("Shutdown Desktops After Use",($htmlsilver -bor $htmlbold),$xShutdownDesktopsAfterUse,$htmlwhite))
		$rowdata += @(,("Turn On Added Machine",($htmlsilver -bor $htmlbold),$xTurnOnAddedMachine,$htmlwhite))
		$rowdata += @(,('Included Users',($htmlsilver -bor $htmlbold),$DGIncludedUsers[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $DGIncludedUsers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		
		If($DGExcludedUsers.Count -gt 0)
		{
			$rowdata += @(,('Excluded Users',($htmlsilver -bor $htmlbold), $DGExcludedUsers[0],$htmlwhite))
			$cnt = -1
			ForEach($tmp in $DGExcludedUsers)
			{
				$cnt++
				If($cnt -gt 0)
				{
					$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				}
			}
		}

		$rowdata += @(,('Scopes',($htmlsilver -bor $htmlbold),$DGScopes[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $DGScopes)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		
		$rowdata += @(,('StoreFronts',($htmlsilver -bor $htmlbold),$DGSFServers[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $DGSFServers)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}
		
		If($Group.SessionSupport -eq "MultiSession" -and $Group.DeliveryType -like '*Apps*')
		{
			$rowdata += @(,('Session prelaunch',($htmlsilver -bor $htmlbold),$xSessionPrelaunch,$htmlwhite))
			If($xSessionPrelaunch -ne "Off")
			{
				$rowdata += @(,('Prelaunched session will end in',($htmlsilver -bor $htmlbold),$xEndPrelaunchSession,$htmlwhite))
				
				If($xSessionPrelaunchAvgLoad -gt 0)
				{
					$rowdata += @(,('When avg load on all machines exceeds (%)',($htmlsilver -bor $htmlbold),$xSessionPrelaunchAvgLoad,$htmlwhite))
				}
				If($xSessionPrelaunchAnyLoad -gt 0)
				{
					$rowdata += @(,('When load on any machines exceeds (%)',($htmlsilver -bor $htmlbold),$xSessionPrelaunchAnyLoad,$htmlwhite))
				}
			}
			$rowdata += @(,('Session lingering',($htmlsilver -bor $htmlbold),$xSessionLinger,$htmlwhite))
			If($xSessionLinger -ne "Off")
			{
				$rowdata += @(,('Keep sessions active until after',($htmlsilver -bor $htmlbold),$xEndLinger,$htmlwhite))
				
				If($xSessionLingerAvgLoad -gt 0)
				{
					$rowdata += @(,('When avg load on all machines exceeds (%)',($htmlsilver -bor $htmlbold),$xSessionPrelaunchAvgLoad,$htmlwhite))
				}
				If($xSessionLingerAnyLoad -gt 0)
				{
					$rowdata += @(,('When load on any machines exceeds (%)',($htmlsilver -bor $htmlbold),$xSessionPrelaunchAnyLoad,$htmlwhite))
				}
			}
		}

		If($Group.SessionSupport -eq "MultiSession")
		{
			$RestartSchedule = Get-BrokerRebootSchedule @XDParams1 -DesktopGroupUid $Group.Uid
			
			If($? -and $Null -ne $RestartSchedule)
			{
				$rowdata += @(,('Restart machines automatically',($htmlsilver -bor $htmlbold),"Yes",$htmlwhite))
				
				$tmp = ""
				If($RestartSchedule.Frequency -eq "Daily")
				{
					$tmp = "Daily"
				}
				ElseIf($RestartSchedule.Frequency -eq "Weekly")
				{
					$tmp = "Every $($RestartSchedule.Day)"
				}
				
				$rowdata += @(,('Restart machines',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				$rowdata += @(,('Restart first group at',($htmlsilver -bor $htmlbold),"$($RestartSchedule.StartTime.Hours.ToString("00")):$($RestartSchedule.StartTime.Minutes.ToString("00"))",$htmlwhite))
				
				$xTime = 0
				$tmp = ""
				If($RestartSchedule.RebootDuration -eq 0)
				{
					$tmp = "Restart all machines at once"
				}
				ElseIf($RestartSchedule.RebootDuration -eq 30)
				{
					$tmp = "30 minutes"
				}
				Else
				{
					$xTime = $RestartSchedule.RebootDuration / 60
					$tmp = "$($xTime) hours"
				}
				$rowdata += @(,('Restart additional groups every',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				$xTime = $Null
				$tmp = $Null
				
				$tmp = ""
				If($RestartSchedule.WarningDuration -eq 0)
				{
					$tmp = "Do not send a notification"
					$rowdata += @(,('Send restart notification to user',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
				}
				Else
				{
					$tmp = "$($RestartSchedule.WarningDuration) minutes before user is logged off"
					$rowdata += @(,('Send restart notification to user',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
					$rowdata += @(,('Notification message',($htmlsilver -bor $htmlbold),$RestartSchedule.WarningMessage,$htmlwhite))
				}
				
			}
			Else
			{
				$rowdata += @(,('Restart machines automatically',($htmlsilver -bor $htmlbold),"No",$htmlwhite))
			}
		}
		
		#added in V1.41
		#this data has been collected for a long time, I simple forgot to add it to the output
		$rowdata += @(,( "Off Peak Buffer Size Percent",($htmlsilver -bor $htmlbold),$xOffPeakBufferSizePercent,$htmlwhite))
		$rowdata += @(,( "Off Peak Disconnect Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xOffPeakDisconnectTimeout,$htmlwhite))
		$rowdata += @(,( "Off Peak Extended Disconnect Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xOffPeakExtendedDisconnectTimeout,$htmlwhite))
		$rowdata += @(,( "Off Peak LogOff Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xOffPeakLogOffTimeout,$htmlwhite))
		$rowdata += @(,( "Peak Buffer Size Percent",($htmlsilver -bor $htmlbold),$xPeakBufferSizePercent,$htmlwhite))
		$rowdata += @(,( "Peak Disconnect Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xPeakDisconnectTimeout,$htmlwhite))
		$rowdata += @(,( "Peak Extended Disconnect Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xPeakExtendedDisconnectTimeout,$htmlwhite))
		$rowdata += @(,( "Peak LogOff Timeout (Minutes)",($htmlsilver -bor $htmlbold),$xPeakLogOffTimeout,$htmlwhite))
		$rowdata += @(,( "Settlement Period Before Autoshutdown (HH:MM:SS)",($htmlsilver -bor $htmlbold),$xSettlementPeriodBeforeAutoShutdown,$htmlwhite))

		If($PwrMgmt1)
		{
			$rowdata += @(,("During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakExtendedDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakExtendedDisconnectAction,$htmlwhite))
		}
		If($PwrMgmt2)
		{
			$rowdata += @(,('Weekday Peak hours',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"none",$htmlwhite))
			}

			$rowdata += @(,('Weekend Peak hours',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"none",$htmlwhite))
			}

			$rowdata += @(,("During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakExtendedDisconnectAction,$htmlwhite))
			$rowdata += @(,("During peak hours, when logged off $($Group.PeakLogOffTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakLogOffAction,$htmlwhite))
			$rowdata += @(,("During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakExtendedDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak hours, when logged off $($Group.OffPeakLogOffTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakLogOffAction,$htmlwhite))
			$rowdata += @(,("During off-peak extended hours, when logged off $($Group.OffPeakExtendedLogOffTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakExtendedLogOffAction,$htmlwhite))
		}
		If($PwrMgmt3)
		{
			$rowdata += @(,('Weekday number machines powered on, and when',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"none",$htmlwhite))
			}

			$rowdata += @(,('Weekend number machines powered on, and when',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PoolSize[$i] -gt 0)
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($PwrMgmt.PoolSize[$i].ToString("####0")) - $($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"none",$htmlwhite))
			}

			$rowdata += @(,('Weekday Peak hours',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekdays")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"none",$htmlwhite))
			}

			$rowdata += @(,('Weekend Peak hours',($htmlsilver -bor $htmlbold),"",$htmlwhite))
			$val = 0
			ForEach($PwrMgmt in $PwrMgmts)
			{
				If($PwrMgmt.DaysOfWeek -eq "Weekend")
				{
					For($i=0;$i -le 24;$i++)
					{
						If($PwrMgmt.PeakHours[$i])
						{
							$val++
							$rowdata += @(,('',($htmlsilver -bor $htmlbold),"$($i.ToString("00")):00",$htmlwhite))
						}
					}
				}
			}

			If($val -eq 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),"None",$htmlwhite))
			}

			$rowdata += @(,("During peak hours, when disconnected $($Group.PeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During peak extended hours, when disconnected $($Group.PeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xPeakExtendedDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak hours, when disconnected $($Group.OffPeakDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakDisconnectAction,$htmlwhite))
			$rowdata += @(,("During off-peak extended hours, when disconnected $($Group.OffPeakExtendedDisconnectTimeout) mins",($htmlsilver -bor $htmlbold),$xOffPeakExtendedDisconnectAction,$htmlwhite))
		}
		
		$rowdata += @(,("Automatic power on for assigned",($htmlsilver -bor $htmlbold), $xAutoPowerOnForAssigned,$htmlwhite))
		$rowdata += @(,("Automatic power on for assigned during peak",($htmlsilver -bor $htmlbold), $xAutoPowerOnForAssignedDuringPeak,$htmlwhite))

		$rowdata += @(,('All connections not through NetScaler Gateway',($htmlsilver -bor $htmlbold),$xAllConnections,$htmlwhite))
		$rowdata += @(,('Connections through NetScaler Gateway',($htmlsilver -bor $htmlbold),$xNSConnection,$htmlwhite))
		$rowdata += @(,('Connections meeting any of the following filters',($htmlsilver -bor $htmlbold),$xAGFilters[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xAGFilters)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		$msg = ""
		$columnWidths = @("200","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "400"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputDeliveryGroupApplicationDetails 
{
	Param([object] $Group)
	
	$AllApplications = Get-BrokerApplication -AssociatedDesktopGroupUid $Group.Uid
	
	If($? -and $Null -ne $AllApplications)
	{
		$txt = "Applications"
		If($MSWord -or $PDF)
		{
			WriteWordLine 4 0 $txt
		}
		ElseIf($Text)
		{
			Line 0 $txt
			Line 0 ""
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 4 0 $txt
		}

		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $AllApplicationsWordTable = @();
		}
		ElseIf($HTML)
		{
			$rowdata = @()
		}

		ForEach($Application in $AllApplications)
		{
			If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
			{
				Write-Verbose "$(Get-Date): `t`tAdding Application $($Application.ApplicationName)"
			}
			Else
			{
				Write-Verbose "$(Get-Date): `t`tAdding Application $($Application.Name)"
			}

			$xEnabled = "Enabled"
			If($Application.Enabled -eq $False)
			{
				$xEnabled = "Disabled"
			}
			
			$xLocation = "Master Image"
			If($Application.MetadataKeys.Count -gt 0)
			{
				$xLocation = "App-V"
			}
			
			If($MSWord -or $PDF)
			{
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					$WordTableRowHash = @{
					ApplicationName = $Application.ApplicationName; 
					Description = $Application.Description; 
					Location = $xLocation;
					Enabled = $xEnabled; 
					}
				}
				Else
				{
					$WordTableRowHash = @{
					ApplicationName = $Application.Name; 
					Description = $Application.Description; 
					Location = $xLocation;
					Enabled = $xEnabled; 
					}
				}
				$AllApplicationsWordTable += $WordTableRowHash;
			}
			ElseIf($Text)
			{
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					Line 1 "Name`t`t: " $Application.ApplicationName
					Line 1 "Description`t: " $Application.Description
					Line 1 "Location`t: " $xLocation
					Line 1 "State`t`t: " $xEnabled
					Line 0 ""
				}
				Else
				{
					Line 1 "Name`t`t: " $Application.Name
					Line 1 "Description`t: " $Application.Description
					Line 1 "Location`t: " $xLocation
					Line 1 "State`t`t: " $xEnabled
					Line 0 ""
				}
			}
			ElseIf($HTML)
			{
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					$rowdata += @(,(
					$Application.ApplicationName,$htmlwhite,
					$Application.Description,$htmlwhite,
					$xLocation,$htmlwhite,
					$xEnabled,$htmlwhite))
				}
				Else
				{
					$rowdata += @(,(
					$Application.Name,$htmlwhite,
					$Application.Description,$htmlwhite,
					$xLocation,$htmlwhite,
					$xEnabled,$htmlwhite))
				}
			}
		}

		If($MSWord -or $PDF)
		{
			$Table = AddWordTable -Hashtable $AllApplicationsWordTable `
			-Columns  ApplicationName,Description,Location,Enabled `
			-Headers  "Name","Description","Location","State" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 175;
			$Table.Columns.Item(2).Width = 170;
			$Table.Columns.Item(3).Width = 100;
			$Table.Columns.Item(4).Width = 55;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
		ElseIf($HTML)
		{
			$columnHeaders = @(
			'Name',($htmlsilver -bor $htmlbold),
			'Description',($htmlsilver -bor $htmlbold),
			'Location',($htmlsilver -bor $htmlbold),
			'State',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("175","170","100","55")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
			WriteHTMLLine 0 0 " "
		}
	}
}

Function OutputDeliveryGroupCatalogs 
{
	Param([object] $Group)
	
	$MCs = Get-BrokerDesktop @XDParams1 -DesktopGroupUid $Group.Uid -Property CatalogName
	
	If($? -and $Null -ne $MCs)
	{
		If($MCs -is [Array])
		{
			[array]$MCs = $MCs | Sort-Object -Unique
		}
		
		$txt = "Machine Catalogs"
		If($MSWord -or $PDF)
		{
			WriteWordLine 4 0 $txt
		}
		ElseIf($Text)
		{
			Line 0 $txt
			Line 0 ""
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 4 0 $txt
		}

		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $CatalogsWordTable = @();
		}
		ElseIf($HTML)
		{
			$rowdata = @()
		}

		ForEach($MC in $MCs)
		{
			Write-Verbose "$(Get-Date): `t`t`tAdding catalog $($MC.CatalogName)"

			$Catalog = Get-BrokerCatalog @XDParams1 -Name $MC.CatalogName
			If($? -and $Null -ne $Catalog)
			{
				Switch ($Catalog.AllocationType)
				{
					"Static"	{$xAllocationType = "Permanent"; Break}
					"Permanent"	{$xAllocationType = "Permanent"; Break}
					"Random"	{$xAllocationType = "Random"; Break}
					Default	{$xAllocationType = "Allocation type could not be determined: $($Catalog.AllocationType)"; Break}
				}
				
				If($MSWord -or $PDF)
				{
					$WordTableRowHash = @{
					Name = $Catalog.Name; 
					Type = $xAllocationType; 
					DesktopsTotal = $Catalog.AssignedCount;
					DesktopsFree = $Catalog.AvailableCount; 
					}
					$CatalogsWordTable += $WordTableRowHash;
				}
				ElseIf($Text)
				{
					Line 1 "Machine Catalog name`t: " $Catalog.Name
					Line 1 "Machine Catalog type`t: " $xAllocationType
					Line 1 "Desktops total`t`t: " $Catalog.AssignedCount
					Line 1 "Desktops free`t`t: " $Catalog.AvailableCount
					Line 0 ""
				}
				ElseIf($HTML)
				{
					$rowdata += @(,(
					$Catalog.Name,$htmlwhite,
					$xAllocationType,$htmlwhite,
					$Catalog.AssignedCount,$htmlwhite,
					$Catalog.AvailableCount,$htmlwhite))
				}
			}
		}

		If($MSWord -or $PDF)
		{
			$Table = AddWordTable -Hashtable $CatalogsWordTable `
			-Columns  Name,Type,DesktopsTotal,DesktopsFree `
			-Headers  "Machine Catalog name","Machine Catalog type","Desktops total","Desktops free" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 175;
			$Table.Columns.Item(2).Width = 150;
			$Table.Columns.Item(3).Width = 100;
			$Table.Columns.Item(4).Width = 75;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
		ElseIf($HTML)
		{
			$columnHeaders = @(
			'Machine Catalog name',($htmlsilver -bor $htmlbold),
			'Machine Catalog type',($htmlsilver -bor $htmlbold),
			'Desktops total',($htmlsilver -bor $htmlbold),
			'Desktops free',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("175","150","100","75")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
			WriteHTMLLine 0 0 " "
		}
	}
}
#endregion

#region process application functions
Function ProcessApplications
{
	Write-Verbose "$(Get-Date): Retrieving Applications"
	
	$txt = "Applications"
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 $txt
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 $txt
	}

	$Script:TotalPublishedApplications = 0
	$Script:TotalAppvApplications = 0
	
	If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
	{
		$AllApplications = Get-BrokerApplication @XDParams2 -SortBy "AdminFolderName,ApplicationName"
	}
	Else
	{
		$AllApplications = Get-BrokerApplication @XDParams2 -SortBy "Name"
	}
	
	If($? -and $Null -ne $AllApplications)
	{
		OutputApplications $AllApplications
	}
	ElseIf($? -and ($Null -eq $AllApplications))
	{
		$txt = "There are no Applications"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Applications"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputApplications
{
	Param([object]$AllApplications)
	
	Write-Verbose "$(Get-Date): `tProcessing Applications"

	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $AllApplicationsWordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}

	ForEach($Application in $AllApplications)
	{
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			Write-Verbose "$(Get-Date): `t`tAdding Application $($Application.ApplicationName)"
		}
		Else
		{
			Write-Verbose "$(Get-Date): `t`tAdding Application $($Application.Name)"
		}

		$xEnabled = "Enabled"
		If($Application.Enabled -eq $False)
		{
			$xEnabled = "Disabled"
		}
		
		$xLocation = "Master Image"
		If($Application.MetadataKeys.Count -gt 0)
		{
			$xLocation = "App-V"
		}

		If($xLocation -eq "Master Image")
		{
			$Script:TotalPublishedApplications++
		}
		Else
		{
			$Script:TotalAppvApplications++
		}
		
		If($MSWord -or $PDF)
		{
			If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
			{
				$WordTableRowHash = @{
				FolderName = $Application.AdminFolderName;
				ApplicationName = $Application.ApplicationName; 
				Description = $Application.Description; 
				Location = $xLocation;
				Enabled = $xEnabled; 
				}
			}
			Else
			{
				$WordTableRowHash = @{
				ApplicationName = $Application.Name; 
				Description = $Application.Description; 
				Location = $xLocation;
				Enabled = $xEnabled; 
				}
			}
			$AllApplicationsWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
			{
				Line 1 "Folder`t`t: " $Application.AdminFolderName
				Line 1 "Name`t`t: " $Application.ApplicationName
				Line 1 "Description`t: " $Application.Description
				Line 1 "Location`t: " $xLocation
				Line 1 "State`t`t: " $xEnabled
				Line 0 ""
			}
			Else
			{
				Line 1 "Name`t`t: " $Application.Name
				Line 1 "Description`t: " $Application.Description
				Line 1 "Location`t: " $xLocation
				Line 1 "State`t`t: " $xEnabled
				Line 0 ""
			}
		}
		ElseIf($HTML)
		{
			If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
			{
				$rowdata += @(,(
				$Application.AdminFolderName,$htmlwhite,
				$Application.ApplicationName,$htmlwhite,
				$Application.Description,$htmlwhite,
				$xLocation,$htmlwhite,
				$xEnabled,$htmlwhite))
			}
			Else
			{
				$rowdata += @(,(
				$Application.Name,$htmlwhite,
				$Application.Description,$htmlwhite,
				$xLocation,$htmlwhite,
				$xEnabled,$htmlwhite))
			}
		}
	}

	If($MSWord -or $PDF)
	{
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$Table = AddWordTable -Hashtable $AllApplicationsWordTable `
			-Columns  FolderName,ApplicationName,Description,Location,Enabled `
			-Headers  "Folder","Name","Description","Location","State" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 100;
			$Table.Columns.Item(2).Width = 145;
			$Table.Columns.Item(3).Width = 125;
			$Table.Columns.Item(4).Width = 80;
			$Table.Columns.Item(5).Width = 50;
		}
		Else
		{
			$Table = AddWordTable -Hashtable $AllApplicationsWordTable `
			-Columns  ApplicationName,Description,Location,Enabled `
			-Headers  "Name","Description","Location","State" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(2).Width = 145;
			$Table.Columns.Item(3).Width = 125;
			$Table.Columns.Item(4).Width = 80;
			$Table.Columns.Item(5).Width = 50;
		}

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($HTML)
	{
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$columnHeaders = @(
			'Folder',($htmlsilver -bor $htmlbold),
			'Name',($htmlsilver -bor $htmlbold),
			'Description',($htmlsilver -bor $htmlbold),
			'Location',($htmlsilver -bor $htmlbold),
			'State',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("100","145","125","80","50")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		}
		Else
		{
			$columnHeaders = @(
			'Name',($htmlsilver -bor $htmlbold),
			'Description',($htmlsilver -bor $htmlbold),
			'Location',($htmlsilver -bor $htmlbold),
			'State',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("145","125","80","50")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "400"
		}
		WriteHTMLLine 0 0 " "
	}

	If($Applications)
	{
		ForEach($Application in $AllApplications)
		{
			If($MSWord -or $PDF)
			{
				$Selection.InsertNewPage()
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					WriteWordLine 2 0 $Application.ApplicationName
				}
				Else
				{
					WriteWordLine 2 0 $Application.Name
				}
			}
			ElseIf($Text)
			{
				Line 0 ""
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					Line 0 $Application.ApplicationName
				}
				Else
				{
					Line 0 $Application.Name
				}
			}
			ElseIf($HTML)
			{
				If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
				{
					WriteHTMLLine 2 0 $Application.ApplicationName
				}
				Else
				{
					WriteHTMLLine 2 0 $Application.Name
				}
			}
			
			OutputApplicationDetails $Application
			OutputApplicationSessions $Application
			OutputApplicationAdministrators $Application
		}
	}
}

Function OutputApplicationDetails
{
	Param([object] $Application)
	
	If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
	{
		Write-Verbose "$(Get-Date): `t`tApplication details for $($Application.ApplicationName)"
	}
	Else
	{
		Write-Verbose "$(Get-Date): `t`tApplication details for $($Application.Name)"
	}
	
	$txt = "Details"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 $txt
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 $txt
	}

	$xTags = @()
	$tags = $($(get-brokerapplication -uid $Application.Uid).MetadataMap.GetEnumerator())
	foreach($tag in $tags)
	{
		If($tag.value -eq "Tag")
		{
			$xTags += "$($tag.key.substring(4))"
		}
	}
	
	#ForEach($Tag in $Application.Tags)
	#{
	#	$xTags += "$($Tag)"
	#}
	$xVisibility = @()
	If($Application.UserFilterEnabled -eq $True)
	{
		$cnt = -1
		ForEach($tmp in $Application.AssociatedUserFullNames)
		{
			$cnt++
			$xVisibility += "$($tmp) ($($Application.AssociatedUserNames[$cnt]))"
		}
		
	}
	Else
	{
		$xVisibility = {Users inherited from Delivery Group}
	}
	
	$DeliveryGroups = @()
	If($Application.AssociatedDesktopGroupUids.Count -gt 1)
	{
		$cnt = -1
		ForEach($DGUid in $Application.AssociatedDesktopGroupUids)
		{
			$cnt++
			$Results = Get-BrokerDesktopGroup -Uid $DGUid
			If($? -and $Null -ne $Results)
			{
				$DeliveryGroups += "$($Results.Name) Priority: $($Application.AssociatedDesktopGroupPriorities[$cnt])"
			}
		}
	}
	Else
	{
		ForEach($DGUid in $Application.AssociatedDesktopGroupUids)
		{
			$Results = Get-BrokerDesktopGroup -Uid $DGUid
			If($? -and $Null -ne $Results)
			{
				$DeliveryGroups += $Results.Name
			}
		}
	}
	
	$RedirectedFileTypes = @()
	$Results = Get-BrokerConfiguredFTA -ApplicationUid $Application.Uid
	If($? -and $Null -ne $Results)
	{
		ForEach($Result in $Results)
		{
			$RedirectedFileTypes += $Result.ExtensionName
		}
	}
	
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Name (for administrator)"; Value = $Application.Name; }
		$ScriptInformation += @{ Data = "Name (for user)"; Value = $Application.PublishedName; }
		$ScriptInformation += @{ Data = "Description"; Value = $Application.Description; }
		$ScriptInformation += @{ Data = "Delivery Group"; Value = $DeliveryGroups[0]; }
		$cnt = -1
		ForEach($Group in $DeliveryGroups)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $Group; }
			}
		}
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$ScriptInformation += @{ Data = "Folder (for administrators)"; Value = $Application.AdminFolderName; }
			$ScriptInformation += @{ Data = "Folder (for user)"; Value = $Application.ClientFolder; }
		}
		$ScriptInformation += @{ Data = "Visibility"; Value = $xVisibility[0]; }
		$cnt = -1
		ForEach($tmp in $xVisibility)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $xVisibility[$cnt]; }
			}
		}
		$ScriptInformation += @{ Data = "Application Path"; Value = $Application.CommandLineExecutable; }
		$ScriptInformation += @{ Data = "Command line arguments"; Value = $Application.CommandLineArguments; }
		$ScriptInformation += @{ Data = "Working directory"; Value = $Application.WorkingDirectory; }
		If($Null -eq $RedirectedFileTypes)
		{
			$ScriptInformation += @{ Data = "Redirected file types"; Value = ""; }
		}
		Else
		{
			$tmp1 = ""
			ForEach($tmp in $RedirectedFileTypes)
			{
				$tmp1 += "$($tmp); "
			}
			$ScriptInformation += @{ Data = "Redirected file types"; Value = $tmp1; }
			$tmp1 = $Null
		}
		$ScriptInformation += @{ Data = "Tags"; Value = $xTags[0]; }
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		
		If($Application.Visible -eq $False)
		{
			$ScriptInformation += @{ Data = "Hidden"; Value = "Application is hidden"; }
		}
		
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationUsageLimits")
		{
			
			$tmp = ""
			If($Application.MaxTotalInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxTotalInstances.ToString()
			}
			$ScriptInformation += @{ Data = "Maximum concurrent instances"; Value = $tmp; }
			
			$tmp = ""
			If($Application.MaxPerUserInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxPerUserInstances.ToString()
			}
			$ScriptInformation += @{ Data = "Maximum instances per user"; Value = $tmp; }
		}
		
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 175;
		$Table.Columns.Item(2).Width = 325;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Name (for administrator)`t: " $Application.Name
		Line 1 "Name (for user)`t`t`t: " $Application.PublishedName
		Line 1 "Description`t`t`t: " $Application.Description
		Line 1 "Delivery Group`t`t`t: " $DeliveryGroups[0]
		$cnt = -1
		ForEach($Group in $DeliveryGroups)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $Group
			}
		}
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			Line 1 "Folder (for administrators)`t: " $Application.AdminFolderName
			Line 1 "Folder (for user)`t`t: " $Application.ClientFolder
		}
		Line 1 "Visibility`t`t`t: " $xVisibility[0]
		$cnt = -1
		ForEach($tmp in $xVisibility)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $xVisibility[$cnt]
			}
		}
		Line 1 "Application Path`t`t: " $Application.CommandLineExecutable
		Line 1 "Command line arguments`t`t: " $Application.CommandLineArguments
		Line 1 "Working directory`t`t: " $Application.WorkingDirectory
		$tmp1 = ""
		ForEach($tmp in $RedirectedFileTypes)
		{
			$tmp1 += "$($tmp); "
		}
		Line 1 "Redirected file types`t`t: " $tmp1
		$tmp1 = $Null
		Line 1 "Tags`t`t`t`t: " $xTags[0]
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				Line 5 "  " $tmp
			}
		}

		If($Application.Visible -eq $False)
		{
			Line 1 "Hidden`t`t`t`t: Application is hidden" ""
		}
		
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationUsageLimits")
		{
			
			$tmp = ""
			If($Application.MaxTotalInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxTotalInstances.ToString()
			}
			Line 1 "Maximum concurrent instances`t: " $tmp
			
			$tmp = ""
			If($Application.MaxPerUserInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxPerUserInstances.ToString()
			}
			Line 1 "Maximum instances per user`t: " $tmp
		}
		Line 0 ""
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		$columnHeaders = @("Name (for administrator)",($htmlsilver -bor $htmlbold),$Application.Name,$htmlwhite)
		$rowdata += @(,('Name (for user)',($htmlsilver -bor $htmlbold),$Application.PublishedName,$htmlwhite))
		$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$Application.Description,$htmlwhite))
		$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$DeliveryGroups[0],$htmlwhite))
		$cnt = -1
		ForEach($Group in $DeliveryGroups)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$Group,$htmlwhite))
			}
		}
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$rowdata += @(,('Folder (for administrators)',($htmlsilver -bor $htmlbold),$Application.AdminFolderName,$htmlwhite))
			$rowdata += @(,('Folder (for user)',($htmlsilver -bor $htmlbold),$Application.ClientFolder,$htmlwhite))
		}
		$rowdata += @(,('Visibility',($htmlsilver -bor $htmlbold),$xVisibility[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xVisibility)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$xVisibility[$cnt],$htmlwhite))
			}
		}
		$rowdata += @(,('Application Path',($htmlsilver -bor $htmlbold),$Application.CommandLineExecutable,$htmlwhite))
		$rowdata += @(,('Command Line arguments',($htmlsilver -bor $htmlbold),$Application.CommandLineArguments,$htmlwhite))
		$rowdata += @(,('Working directory',($htmlsilver -bor $htmlbold),$Application.WorkingDirectory,$htmlwhite))
		$tmp1 = ""
		ForEach($tmp in $RedirectedFileTypes)
		{
			$tmp1 += "$($tmp); "
		}
		$rowdata += @(,('Redirected file types',($htmlsilver -bor $htmlbold),$tmp1,$htmlwhite))
		$tmp1 = $Null
		$rowdata += @(,('Tags',($htmlsilver -bor $htmlbold),$xTags[0],$htmlwhite))
		$cnt = -1
		ForEach($tmp in $xTags)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			}
		}

		If($Application.Visible -eq $False)
		{
			$rowdata += @(,('Hidden',($htmlsilver -bor $htmlbold),"Application is hidden",$htmlwhite))
		}

		If((Get-BrokerServiceAddedCapability) -contains "ApplicationUsageLimits")
		{
			$tmp = ""
			If($Application.MaxTotalInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxTotalInstances.ToString()
			}
			$rowdata += @(,('Maximum concurrent instances',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
			
			$tmp = ""
			If($Application.MaxPerUserInstances -eq 0)
			{
				$tmp = "Unlimited"
			}
			Else
			{
				$tmp = $Application.MaxPerUserInstances.ToString()
			}
			$rowdata += @(,('Maximum instances per user',($htmlsilver -bor $htmlbold),$tmp,$htmlwhite))
		}
		$msg = ""
		$columnWidths = @("175","325")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		WriteHTMLLine 0 0 " "
	}
	$tags = $Null
	$tag = $Null
}

Function OutputApplicationSessions
{
	Param([object] $Application)
	
	Write-Verbose "$(Get-Date): `t`tApplication sessions for $($Application.BrowserName)"
	$txt = "Sessions"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 $txt
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 $txt
	}

	$Sessions = Get-BrokerSession -ApplicationUid $Application.Uid @XDParams1 -SortBy UserName
	
	If($? -and $Null -ne $Sessions)
	{
		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $SessionsWordTable = @();
		}
		ElseIf($HTML)
		{
			$rowdata = @()
		}

		#now get the privateappdesktop for each desktopgroup uid
		ForEach($Session in $Sessions)
		{
			#get desktop by Session Uid
			$xMachineName = ""
			$Desktop = Get-BrokerDesktop -SessionUid $Session.Uid @XDParams1
			
			If($? -and $Null -ne $Desktop)
			{
				$xMachineName = $Desktop.MachineName
			}
			Else
			{
				$xMachineName = "Not Found"
			}
			
			If($MSWord -or $PDF)
			{
				$WordTableRowHash = @{
				UserName = $Session.UserName;
				ClientName= $Session.ClientName;
				MachineName = $xMachineName;
				State = $Session.SessionState;
				ApplicationState = $Session.AppState;
				Protocol = $Session.Protocol;
				}
				$SessionsWordTable += $WordTableRowHash;
			}
			ElseIf($Text)
			{
				Line 2 "User Name`t: " $Session.UserName
				Line 2 "Client Name`t: " $Session.ClientName
				Line 2 "Machine Name`t: " $xMachineName
				Line 2 "State`t`t: " $Session.SessionState
				Line 2 "Application State`t`t: " $Session.AppState
				Line 2 "Protocol`t: " $Session.Protocol
				Line 0 ""
			}
			ElseIf($HTML)
			{
				$rowdata += @(,(
				$Session.UserName,$htmlwhite,
				$Session.ClientName,$htmlwhite,
				$xMachineName,$htmlwhite,
				$Session.SessionState,$htmlwhite,
				$Session.AppState,$htmlwhite,
				$Session.Protocol,$htmlwhite))
			}
		}
		
		If($MSWord -or $PDF)
		{
			$Table = AddWordTable -Hashtable $SessionsWordTable `
			-Columns  UserName,ClientName,MachineName,State,ApplicationState,Protocol `
			-Headers  "User Name","Client Name","Machine Name","State","Application State","Protocol" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 135;
			$Table.Columns.Item(2).Width = 85;
			$Table.Columns.Item(3).Width = 135;
			$Table.Columns.Item(4).Width = 50;
			$Table.Columns.Item(5).Width = 50;
			$Table.Columns.Item(6).Width = 55;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
		}
		ElseIf($HTML)
		{
			$columnHeaders = @(
			'User Name',($htmlsilver -bor $htmlbold),
			'Client Name',($htmlsilver -bor $htmlbold),
			'Machine Name',($htmlsilver -bor $htmlbold),
			'State',($htmlsilver -bor $htmlbold),
			'Application State',($htmlsilver -bor $htmlbold),
			'Protocol',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("135","85","135","50","50","55")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "510"
			WriteHTMLLine 0 0 " "
		}
	}
	ElseIf($? -and $Null -eq $Sessions)
	{
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$txt = "There are no Sessions for Application $($Application.ApplicationName)"
		}
		Else
		{
			$txt = "There are no Sessions for Application $($Application.Name)"
		}
		OutputWarning $txt
	}
	Else
	{
		If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
		{
			$txt = "Unable to retrieve Sessions for Application $($Application.ApplicationName)"
		}
		Else
		{
			$txt = "Unable to retrieve Sessions for Application $($Application.Name)"
		}
		OutputWarning $txt
	}
}

Function OutputApplicationAdministrators
{
	Param([object] $Application)
	
	If((Get-BrokerServiceAddedCapability) -contains "ApplicationFolders")
	{
		Write-Verbose "$(Get-Date): `t`tApplication administrators for $($Application.ApplicationName)"
	}
	Else
	{
		Write-Verbose "$(Get-Date): `t`tApplication administrators for $($Application.Name)"
	}
	
	$txt = "Administrators"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 ""
		Line 0 $txt
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 $txt
	}

	#get all the delivery groups
	$DeliveryGroups = @()
	ForEach($DGUid in $Application.AssociatedDesktopGroupUids)
	{
		$Results = Get-BrokerDesktopGroup -Uid $DGUid
		If($? -and $Null -ne $Results)
		{
			$DeliveryGroups += $Results.Name
		}
	}
	
	#now get the administrators for each delivery group
	$Admins = @()
	ForEach($Group in $DeliveryGroups)
	{
		$Results = GetAdmins "DesktopGroup" $Group
		If($? -and $Null -ne $Results)
		{
			$Admins += $Results
		}
	}
	
	If($Null -ne $Admins)
	{
		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $AdminsWordTable = @();
		}
		ElseIf($HTML)
		{
			$rowdata = @()
		}
		
		ForEach($Admin in $Admins)
		{
			$Tmp = ""
			If($Admin.Enabled -eq $True)
			{
				$Tmp = "Enabled"
			}
			Else
			{
				$Tmp = "Disabled"
			}
			
			If($MSWord -or $PDF)
			{
				$WordTableRowHash = @{ 
				AdminName = $Admin.Name;
				Role = $Admin.Rights[0].RoleName;
				Status = $Tmp;
				}
				$AdminsWordTable += $WordTableRowHash;
			}
			ElseIf($Text)
			{
				Line 1 "Administrator Name`t: " $Admin.Name
				Line 1 "Role`t`t`t: " $Admin.Rights[0].RoleName
				Line 1 "Status`t`t`t: " $tmp
				Line 0 ""
			}
			ElseIf($HTML)
			{
				$rowdata += @(,(
				$Admin.Name,$htmlwhite,
				$Admin.Rights[0].RoleName,$htmlwhite,
				$tmp,$htmlwhite))
			}
		}
		
		If($MSWord -or $PDF)
		{
			$Table = AddWordTable -Hashtable $AdminsWordTable `
			-Columns AdminName, Role, Status `
			-Headers "Administrator Name", "Role", "Status" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 225;
			$Table.Columns.Item(2).Width = 200;
			$Table.Columns.Item(3).Width = 60;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
		}
		ElseIf($HTML)
		{
			$columnHeaders = @(
			'Administrator Name',($htmlsilver -bor $htmlbold),
			'Role',($htmlsilver -bor $htmlbold),
			'Status',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("225","200","60")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "485"
			WriteHTMLLine 0 0 " "
		}
	}
	ElseIf($? -and ($Null -eq $Admins))
	{
		$txt = "There are no administrators for $($Group.Name)"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve administrators for $($Group.Name)"
		OutputWarning $txt
	}
	
}
#endregion

#region policy functions
Function ProcessPolicies
{
	$txt = "Policies"
	$txt1 = "Policies in this report may not match the order shown in Studio."
	$txt2 = "See http://blogs.citrix.com/2013/07/15/merging-of-user-and-computer-policies-in-xendesktop-7-0/"
	If($MSWord -or $PDF)
	{
		$selection.InsertNewPage()
		WriteWordLine 1 0 $txt
		WriteWordLine 0 0 $txt1 "" $Null 8 $False $True	
		WriteWordLine 0 0 $txt2 "" $Null 8 $False $True	
	}
	ElseIf($Text)
	{
		Line 0 $txt
		Line 0 $txt1
		Line 0 $txt2
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 $txt
		WriteHTMLLine 0 0 $txt1
		WriteHTMLLine 0 0 $txt2
	}
	Write-Verbose "$(Get-Date): Processing XenDesktop Policies"
	
	ProcessPolicySummary 
	
	If($Policies)
	{
	
		Write-Verbose "$(Get-Date): `tDoes localfarmgpo PSDrive already exist?"
		If(Get-PSDrive localfarmgpo -EA 0)
		{
			Write-Verbose "$(Get-Date): `tRemoving the current localfarmgpo PSDrive"
			Remove-PSDrive localfarmgpo -EA 0 4>$Null
		}
		
		Write-Verbose "$(Get-Date): Creating localfarmgpo PSDrive for Computer policies"
		New-PSDrive localfarmgpo -psprovider citrixgrouppolicy -root \ -controller $AdminAddress -Scope Global *>$Null
		
		#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
		TranscriptLogging
		If(Get-PSDrive localfarmgpo -EA 0)
		{
			ProcessCitrixPolicies "localfarmgpo" "Computer"
			Write-Verbose "$(Get-Date): Finished Processing Citrix Site Computer Policies"
			Write-Verbose "$(Get-Date): "
		}
		Else
		{
			Write-Warning "Unable to create the LocalFarmGPO PSDrive on the XenDesktop Controller $($AdminAddress)"
		}

		Write-Verbose "$(Get-Date): Creating localfarmgpo PSDrive for User policies"
		New-PSDrive localfarmgpo -psprovider citrixgrouppolicy -root \ -controller $AdminAddress -Scope Global *>$Null
		
		#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
		TranscriptLogging
		If(Get-PSDrive localfarmgpo -EA 0)
		{
			ProcessCitrixPolicies "localfarmgpo" "User"
			Write-Verbose "$(Get-Date): Finished Processing Citrix Site User Policies"
			Write-Verbose "$(Get-Date): "
		}
		Else
		{
			Write-Warning "Unable to create the LocalFarmGPO PSDrive on the XenDesktop Controller $($AdminAddress)"
		}
		
		If($NoADPolicies)
		{
			#don't process AD policies
		}
		Else
		{
			#thanks to the Citrix Engineering Team for helping me solve processing Citrix AD based Policies
			Write-Verbose "$(Get-Date): "
			Write-Verbose "$(Get-Date): `tSee if there are any Citrix AD based policies to process"
			$CtxGPOArray = @()
			$CtxGPOArray = GetCtxGPOsInAD
			If($CtxGPOArray -is [Array] -and $CtxGPOArray.Count -gt 0)
			{
				Write-Verbose "$(Get-Date): "
				Write-Verbose "$(Get-Date): `tThere are $($CtxGPOArray.Count) Citrix AD based policies to process"
				Write-Verbose "$(Get-Date): "

				[array]$CtxGPOArray = $CtxGPOArray | Sort-Object -unique
				
				ForEach($CtxGPO in $CtxGPOArray)
				{
					Write-Verbose "$(Get-Date): `tCreating ADGpoDrv PSDrive for Computer Policies"
					New-PSDrive -Name ADGpoDrv -PSProvider CitrixGroupPolicy -Root \ -DomainGpo $($CtxGPO) -Scope Global *>$Null
		
					#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
					TranscriptLogging
					If(Get-PSDrive ADGpoDrv -EA 0)
					{
						Write-Verbose "$(Get-Date): `tProcessing Citrix AD Policy $($CtxGPO)"
					
						Write-Verbose "$(Get-Date): `tRetrieving AD Policy $($CtxGPO)"
						ProcessCitrixPolicies "ADGpoDrv" "Computer"
						Write-Verbose "$(Get-Date): Finished Processing Citrix AD Computer Policy $($CtxGPO)"
						Write-Verbose "$(Get-Date): "
					}
					Else
					{
						Write-Warning "$($CtxGPO) is not readable by this XenDesktop Controller"
						Write-Warning "$($CtxGPO) was probably created by an updated Citrix Group Policy Provider"
					}

					Write-Verbose "$(Get-Date): `tCreating ADGpoDrv PSDrive for UserPolicies"
					New-PSDrive -Name ADGpoDrv -PSProvider CitrixGroupPolicy -Root \ -DomainGpo $($CtxGPO) -Scope Global *>$Null
		
					#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
					TranscriptLogging
					If(Get-PSDrive ADGpoDrv -EA 0)
					{
						Write-Verbose "$(Get-Date): `tProcessing Citrix AD Policy $($CtxGPO)"
					
						Write-Verbose "$(Get-Date): `tRetrieving AD Policy $($CtxGPO)"
						ProcessCitrixPolicies "ADGpoDrv" "User"
						Write-Verbose "$(Get-Date): Finished Processing Citrix AD User Policy $($CtxGPO)"
						Write-Verbose "$(Get-Date): "
					}
					Else
					{
						Write-Warning "$($CtxGPO) is not readable by this XenDesktop Controller"
						Write-Warning "$($CtxGPO) was probably created by an updated Citrix Group Policy Provider"
					}
				}
				Write-Verbose "$(Get-Date): Finished Processing Citrix AD Policies"
				Write-Verbose "$(Get-Date): "
			}
			Else
			{
				Write-Verbose "$(Get-Date): There are no Citrix AD based policies to process"
				Write-Verbose "$(Get-Date): "
			}
		}
	}
	Write-Verbose "$(Get-Date): Finished Processing Citrix Policies"
	Write-Verbose "$(Get-Date): "
}

Function ProcessPolicySummary
{
	Write-Verbose "$(Get-Date): `tDoes localfarmgpo PSDrive already exist?"
	If(Get-PSDrive localfarmgpo -EA 0)
	{
		Write-Verbose "$(Get-Date): `tRemoving the current localfarmgpo PSDrive"
		Remove-PSDrive localfarmgpo -EA 0 4>$Null
	}
	Write-Verbose "$(Get-Date): `tRetrieving Site Policies"
	Write-Verbose "$(Get-Date): `t`tCreating localfarmgpo PSDrive"
	New-PSDrive localfarmgpo -psprovider citrixgrouppolicy -root \ -controller $AdminAddress -Scope Global *>$Null
		
	#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
	TranscriptLogging

	If(Get-PSDrive localfarmgpo -EA 0)
	{
		$HDXPolicies = Get-CtxGroupPolicy -DriveName localfarmgpo -EA 0 `
		| Select-Object PolicyName, Type, Description, Enabled, Priority `
		| Sort-Object Type, Priority
		
		OutputSummaryPolicyTable $HDXPolicies "localfarmgpo"
	}
	Else
	{
		Write-Warning "Unable to create the LocalFarmGPO PSDrive on the XenDesktop Controller $($AdminAddress)"
	}
	
	If($NoADPolicies)
	{
		#don't process AD policies
	}
	Else
	{
		Write-Verbose "$(Get-Date): "
		Write-Verbose "$(Get-Date): See if there are any Citrix AD based policies to process"
		$CtxGPOArray = @()
		$CtxGPOArray = GetCtxGPOsInAD
		If($CtxGPOArray -is [Array] -and $CtxGPOArray.Count -gt 0)
		{
			[array]$CtxGPOArray = $CtxGPOArray | Sort-Object -unique
			Write-Verbose "$(Get-Date): "
			Write-Verbose "$(Get-Date): `tThere are $($CtxGPOArray.Count) Citrix AD based policies to process"
			Write-Verbose "$(Get-Date): "
			
			ForEach($CtxGPO in $CtxGPOArray)
			{
				Write-Verbose "$(Get-Date): `tCreating ADGpoDrv PSDrive"
				New-PSDrive -Name ADGpoDrv -PSProvider CitrixGroupPolicy -Root \ -DomainGpo $($CtxGPO) -Scope "Global" *>$Null
		
				#V1.40 using Citrix policy stuff and new-psdrive breaks transcript logging so restart transcript logging
				TranscriptLogging
				If(Get-PSDrive ADGpoDrv -EA 0)
				{
					Write-Verbose "$(Get-Date): `tProcessing Citrix AD Policy $($CtxGPO)"
				
					Write-Verbose "$(Get-Date): `tRetrieving AD Policy $($CtxGPO)"
					$HDXPolicies = Get-CtxGroupPolicy -DriveName ADGpoDrv -EA 0 `
					| Select-Object PolicyName, Type, Description, Enabled, Priority `
					| Sort-Object Type, Priority
			
					OutputSummaryPolicyTable $HDXPolicies "AD" $CtxGPO
					
					Write-Verbose "$(Get-Date): Finished Processing Citrix AD Policy $($CtxGPO)"
					Write-Verbose "$(Get-Date): "
				}
				Else
				{
					Write-Warning "$($CtxGPO) is not readable by this XenDesktop Controller"
					Write-Warning "$($CtxGPO) was probably created by an updated Citrix Group Policy Provider"
				}
				Remove-PSDrive ADGpoDrv -EA 0 4>$Null
			}
			Write-Verbose "$(Get-Date): Finished Processing Citrix AD Policies"
			Write-Verbose "$(Get-Date): "
		}
		Else
		{
			Write-Verbose "$(Get-Date): There are no Citrix AD based policies to process"
			Write-Verbose "$(Get-Date): "
		}
	}
}

Function OutputSummaryPolicyTable
{
	Param([object] $HDXPolicies, [string] $xLocation, [string] $ADGPOName = "")
	
	If($xLocation -eq "localfarmgpo")
	{
		$txt = "Site Policies"
		If($MSWord -or $PDF)
		{
			WriteWordLine 3 0 $txt
		}
		ElseIf($Text)
		{
			Line 0 $txt
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 3 0 $txt
		}
	}
	ElseIf($xLocation -eq "AD")
	{
		$txt = "Active Directory Policies ($($ADGpoName))"
		If($MSWord -or $PDF)
		{
			WriteWordLine 3 0 $txt
		}
		ElseIf($Text)
		{
			Line 0 $txt
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 3 0 $txt
		}
	}

	If($Null -ne $HDXPolicies)
	{
		Write-Verbose "$(Get-Date): `t`t`tPolicies"
		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $PoliciesWordTable = @();
		}
		ElseIf($HTML)
		{
			$rowdata = @()
		}

		ForEach($Policy in $HDXPolicies)
		{
			If($MSWord -or $PDF)
			{
				$WordTableRowHash = @{
				Name = $Policy.PolicyName;
				Description = $Policy.Description;
				Enabled = $Policy.Enabled;
				Type = $Policy.Type;
				Priority = $Policy.Priority;
				}
				$PoliciesWordTable += $WordTableRowHash;
			}
			ElseIf($Text)
			{
				Line 2 "Name`t`t: " $Policy.PolicyName
				Line 2 "Description`t: " $Policy.Description
				Line 2 "Enabled`t`t: " $Policy.Enabled
				Line 2 "Type`t`t: " $Policy.Type
				Line 2 "Priority`t: " $Policy.Priority
				Line 0 ""
			}
			ElseIf($HTML)
			{
				$rowdata += @(,(
				$Policy.PolicyName,$htmlwhite,
				$Policy.Description,$htmlwhite,
				$Policy.Enabled,$htmlwhite,
				$Policy.Type,$htmlwhite,
				$Policy.Priority,$htmlwhite))
			}
		}
		
		If($MSWord -or $PDF)
		{
			$Table = AddWordTable -Hashtable $PoliciesWordTable `
			-Columns  Name,Description,Enabled,Type,Priority `
			-Headers  "Name","Description","Enabled","Type","Priority" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 155
			$Table.Columns.Item(2).Width = 185
			$Table.Columns.Item(3).Width = 55;
			$Table.Columns.Item(4).Width = 60;
			$Table.Columns.Item(5).Width = 45;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
		}
		ElseIf($HTML)
		{
			$columnHeaders = @(
			'Name',($htmlsilver -bor $htmlbold),
			'Description',($htmlsilver -bor $htmlbold),
			'Enabled',($htmlsilver -bor $htmlbold),
			'Type',($htmlsilver -bor $htmlbold),
			'Priority',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("155","185","55","60","45")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
			WriteHTMLLine 0 0 " "
		}
	}
	ElseIf($Null -eq $HDXPolicies)
	{
		$txt = "There are no Policies"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Policies"
		OutputWarning $txt
	}
}

Function validStateProp( [object] $object, [string] $topLevel, [string] $secondLevel )
{
	#function created 8-jan-2014 by Michael B. Smith
	If( $object )
	{
		If((Get-Member -Name $topLevel -InputObject $object))
		{
			If((Get-Member -Name $secondLevel -InputObject $object.$topLevel))
			{
				Return $True
			}
		}
	}
	Return $False
}

Function validObject( [object] $object, [string] $topLevel )
{
	#function created 8-jan-2014 by Michael B. Smith
	If( $object )
	{
		If((Get-Member -Name $topLevel -InputObject $object))
		{
			Return $True
		}
	}
	Return $False
}

Function ProcessCitrixPolicies
{
	Param([string]$xDriveName, [string]$xPolicyType)

	Write-Verbose "$(Get-Date): `tRetrieving all $($xPolicyType) policy names"

	$Script:TotalComputerPolicies = 0
	$Script:TotalUserPolicies = 0
	$Script:TotalSitePolicies = 0
	$Script:TotalADPolicies = 0
	$Script:TotalADPoliciesNotProcessed = 0
	$Script:TotalPolicies = 0
	
	If($xDriveName -eq "localfarmgpo")
	{
		If($MSWord -or $PDF)
		{
			WriteWordLine 0 0 ""
			WriteWordLine 0 0 "Site Policies"
		}
		ElseIf($Text)
		{
			Line 0 ""
			Line 0 "Site Policies"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 0 ""
			WriteHTMLLine 0 0 "Site Policies"
		}
	}
	Else
	{
		If($MSWord -or $PDF)
		{
			WriteWordLine 0 0 ""
			WriteWordLine 0 0 "Active Directory Policies"
		}
		ElseIf($Text)
		{
			Line 0 ""
			Line 0 "Active Directory Policies"
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 0 0 ""
			WriteHTMLLine 0 0 "Active Directory Policies"
		}
	}
	
	$Policies = Get-CtxGroupPolicy -Type $xPolicyType `
	-DriveName $xDriveName -EA 0 `
	| Select-Object PolicyName, Type, Description, Enabled, Priority `
	| Sort-Object Priority

	If($? -and $Null -ne $Policies)
	{
		ForEach($Policy in $Policies)
		{
			Write-Verbose "$(Get-Date): `tStarted $($Policy.PolicyName) "
			
			If($xDriveName -eq "localfarmgpo")
			{
				$Script:TotalSitePolicies++
			}
			Else
			{
				$Script:TotalADPolicies++
			}
			If($Policy.Type -eq "Computer")
			{
				$Script:TotalComputerPolicies++
			}
			Else
			{
				$Script:TotalUserPolicies++
			}
			$Script:TotalPolicies++

			If($MSWord -or $PDF)
			{
				$selection.InsertNewPage()
				If($xDriveName -eq "localfarmgpo")
				{
					WriteWordLine 2 0 "$($Policy.PolicyName) (Site, $($xPolicyType))"
				}
				Else
				{
					WriteWordLine 2 0 "$($Policy.PolicyName) (AD, $($xPolicyType))"
				}
				[System.Collections.Hashtable[]] $ScriptInformation = @()
			
				$ScriptInformation += @{ Data = "Description"; Value = $Policy.Description; }
				$ScriptInformation += @{ Data = "Enabled"; Value = $Policy.Enabled.ToString(); }
				$ScriptInformation += @{ Data = "Type"; Value = $Policy.Type; }
				$ScriptInformation += @{ Data = "Priority"; Value = $Policy.Priority; }
				
				$Table = AddWordTable -Hashtable $ScriptInformation `
				-Columns Data,Value `
				-List `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 90;
				$Table.Columns.Item(2).Width = 200;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
			}
			ElseIf($Text)
			{
				If($xDriveName -eq "localfarmgpo")
				{
					Line 0 "$($Policy.PolicyName) (Site, $($xPolicyType))"
				}
				Else
				{
					Line 0 "$($Policy.PolicyName) (AD, $($xPolicyType))"
				}
				If(![String]::IsNullOrEmpty($Policy.Description))
				{
					Line 1 "Description`t: " $Policy.Description
				}
				Line 1 "Enabled`t`t: " $Policy.Enabled.ToString()
				Line 1 "Type`t`t: " $Policy.Type
				Line 1 "Priority`t: " $Policy.Priority
			}
			ElseIf($HTML)
			{
				If($xDriveName -eq "localfarmgpo")
				{
					WriteHTMLLine 2 0 "$($Policy.PolicyName) (Site, $($xPolicyType))"
				}
				Else
				{
					WriteHTMLLine 2 0 "$($Policy.PolicyName) (AD, $($xPolicyType))"
				}
				$rowdata = @()
				$columnHeaders = @("Description",($htmlsilver -bor $htmlbold),$Policy.Description,$htmlwhite)
				$rowdata += @(,('Enabled',($htmlsilver -bor $htmlbold),$Policy.Enabled.ToString(),$htmlwhite))
				$rowdata += @(,('Type',($htmlsilver -bor $htmlbold),$Policy.Type,$htmlwhite))
				$rowdata += @(,('Priority',($htmlsilver -bor $htmlbold),$Policy.Priority,$htmlwhite))

				$msg = ""
				$columnWidths = @("90","200")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "290"
				WriteHTMLLine 0 0 " "
			}
				

			Write-Verbose "$(Get-Date): `t`tRetrieving all filters"
			$filters = Get-CtxGroupPolicyFilter -PolicyName $Policy.PolicyName `
			-Type $xPolicyType `
			-DriveName $xDriveName -EA 0 `
			| Sort-Object FilterType, FilterName -Unique

			If($? -and $Null -ne $Filters)
			{
				If(![String]::IsNullOrEmpty($filters))
				{
					Write-Verbose "$(Get-Date): `t`tProcessing all filters"
					$txt = "Assigned to"
					If($MSWord -or $PDF)
					{
						WriteWordLine 3 0 $txt
					}
					ElseIf($Text)
					{
						Line 0 $txt
					}
					ElseIf($HTML)
					{
						WriteHTMLLine 3 0 $txt
					}
					
					If($MSWord -or $PDF)
					{
						[System.Collections.Hashtable[]] $FiltersWordTable = @();
					}
					ElseIf($HTML)
					{
						$rowdata = @()
					}
					
					ForEach($Filter in $Filters)
					{
						$tmp = ""
						#14-Jun-2017 add back the WorkerGroup filter for xenapp 6.x
						Switch($filter.FilterType)
						{
							"AccessControl"  {$tmp = "Access Control"; Break}
							"BranchRepeater" {$tmp = "Citrix CloudBridge"; Break}
							"ClientIP"       {$tmp = "Client IP Address"; Break}
							"ClientName"     {$tmp = "Client Name"; Break}
							"DesktopGroup"   {$tmp = "Delivery Group"; Break}
							"DesktopKind"    {$tmp = "Delivery GroupType"; Break}
							"DesktopTag"     {$tmp = "Tag"; Break}
							"OU"             {$tmp = "Organizational Unit (OU)"; Break}
							"User"           {$tmp = "User or group"; Break}
							"WorkerGroup"    {$tmp = "Worker Group"; Break}
							Default {$tmp = "Policy Filter Type could not be determined: $($filter.FilterType)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Name = $filter.FilterName;
							Type= $tmp;
							Enabled = $filter.Enabled;
							Mode = $filter.Mode;
							Value = $filter.FilterValue;
							}
							$FiltersWordTable += $WordTableRowHash;
						}
						ElseIf($Text)
						{
							Line 2 "Name`t: " $filter.FilterName
							Line 2 "Type`t: " $tmp
							Line 2 "Enabled`t: " $filter.Enabled
							Line 2 "Mode`t: " $filter.Mode
							Line 2 "Value`t: " $filter.FilterValue
							Line 2 ""
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$filter.FilterName,$htmlwhite,
							$tmp,$htmlwhite,
							$filter.Enabled,$htmlwhite,
							$filter.Mode,$htmlwhite,
							$filter.FilterValue,$htmlwhite))
						}
					}
					$tmp = $Null
					If($MSWord -or $PDF)
					{
						$Table = AddWordTable -Hashtable $FiltersWordTable `
						-Columns  Name,Type,Enabled,Mode,Value `
						-Headers  "Name","Type","Enabled","Mode","Value" `
						-Format $wdTableGrid `
						-AutoFit $wdAutoFitFixed;

						SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

						$Table.Columns.Item(1).Width = 115;
						$Table.Columns.Item(2).Width = 125;
						$Table.Columns.Item(3).Width = 50;
						$Table.Columns.Item(4).Width = 40;
						$Table.Columns.Item(5).Width = 170;

						$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

						FindWordDocumentEnd
						$Table = $Null
					}
					ElseIf($HTML)
					{
						$columnHeaders = @(
						'Name',($htmlsilver -bor $htmlbold),
						'Type',($htmlsilver -bor $htmlbold),
						'Enabled',($htmlsilver -bor $htmlbold),
						'Mode',($htmlsilver -bor $htmlbold),
						'Value',($htmlsilver -bor $htmlbold))

						$msg = ""
						$columnWidths = @("115","125","50","40","170")
						FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
						WriteHTMLLine 0 0 " "
					}
				}
				Else
				{
					If($MSWord -or $PDF)
					{
						WriteWordLine 0 1 "Assigned to: None"
					}
					ElseIf($Text)
					{
						Line 1 "Assigned to`t`t: None"
					}
					ElseIf($HTML)
					{
						WriteHTMLLine 0 1 "Assigned to: None"
					}
				}
			}
			ElseIf($? -and $Null -eq $Filters)
			{
				$txt = "$($Policy.PolicyName) policy applies to all objects in the Site"
				If($MSWord -or $PDF)
				{
					WriteWordLine 3 0 "Assigned to"
					WriteWordLine 0 1 $txt
				}
				ElseIf($Text)
				{
					Line 0 "Assigned to"
					Line 1 $txt
				}
				ElseIf($HTML)
				{
					WriteHTMLLine 3 0 "Assigned to"
					WriteHTMLLine 0 1 $txt
				}
			}
			ElseIf($? -and $Policy.PolicyName -eq "Unfiltered")
			{
				$txt = "Unfiltered policy applies to all objects in the Site"
				If($MSWord -or $PDF)
				{
					WriteWordLine 3 0 "Assigned to"
					WriteWordLine 0 1 $txt
				}
				ElseIf($Text)
				{
					Line 0 "Assigned to"
					Line 1 $txt
				}
				ElseIf($HTML)
				{
					WriteHTMLLine 3 0 "Assigned to"
					WriteHTMLLine 0 1 $txt
				}
			}
			Else
			{
				$txt = "Unable to retrieve Filter settings"
				If($MSWord -or $PDF)
				{
					WriteWordLine 0 1 $txt
				}
				ElseIf($Text)
				{
					Line 1 $txt
				}
				ElseIf($HTML)
				{
					WriteHTMLLine 0 1 $txt
				}
			}
			
			Write-Verbose "$(Get-Date): `t`tRetrieving all policy settings"
			$Settings = Get-CtxGroupPolicyConfiguration -PolicyName $Policy.PolicyName `
			-Type $Policy.Type `
			-DriveName $xDriveName -EA 0
				
			If($? -and $Null -ne $Settings)
			{
				If($MSWord -or $PDF)
				{
					[System.Collections.Hashtable[]] $SettingsWordTable = @();
				}
				ElseIf($HTML)
				{
					$rowdata = @()
				}
				
				$First = $True
				ForEach($Setting in $Settings)
				{
					If($First)
					{
						$txt = "Policy settings"
						If($MSWord -or $PDF)
						{
							WriteWordLine 3 0 $txt
						}
						ElseIf($Text)
						{
							Line 1 $txt
						}	
						ElseIf($HTML)
						{
							WriteHTMLLine 3 0 $txt
						}
					}
					$First = $False
					
					Write-Verbose "$(Get-Date): `t`tPolicy settings"
					Write-Verbose "$(Get-Date): `t`t`tConnector for Configuration Manager 2012"
					If((validStateProp $Setting AdvanceWarningFrequency State ) -and ($Setting.AdvanceWarningFrequency.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Advance warning frequency interval"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AdvanceWarningFrequency.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AdvanceWarningFrequency.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AdvanceWarningFrequency.Value
						}
					}
					If((validStateProp $Setting AdvanceWarningMessageBody State ) -and ($Setting.AdvanceWarningMessageBody.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Advance warning message box body text"
						$tmpArray = $Setting.AdvanceWarningMessageBody.Value.Split("`n")
						$tmp = ""
						$cnt = 0
						ForEach($Thing in $TmpArray)
						{
							If($Null -eq $Thing)
							{
								$Thing = ''
							}
							$cnt++
							$tmp = "$($Thing) "
							If($cnt -eq 1)
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
							Else
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
							}
							$txt = ""
						}
						$TmpArray = $Null
						$tmp = $Null
					}
					If((validStateProp $Setting AdvanceWarningMessageTitle State ) -and ($Setting.AdvanceWarningMessageTitle.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Advance warning message box title"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AdvanceWarningMessageTitle.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AdvanceWarningMessageTitle.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AdvanceWarningMessageTitle.Value
						}
					}
					If((validStateProp $Setting AdvanceWarningPeriod State ) -and ($Setting.AdvanceWarningPeriod.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Advance warning time period"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AdvanceWarningPeriod.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AdvanceWarningPeriod.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AdvanceWarningPeriod.Value 
						}
					}
					If((validStateProp $Setting FinalForceLogoffMessageBody State ) -and ($Setting.FinalForceLogoffMessageBody.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Final force logoff message box body text"
						$tmpArray = $Setting.FinalForceLogoffMessageBody.Value.Split("`n")
						$tmp = ""
						$cnt = 0
						ForEach($Thing in $TmpArray)
						{
							If($Null -eq $Thing)
							{
								$Thing = ''
							}
							$cnt++
							$tmp = "$($Thing) "
							If($cnt -eq 1)
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
							Else
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
							}
						}
						$TmpArray = $Null
						$tmp = $Null
					}
					If((validStateProp $Setting FinalForceLogoffMessageTitle State ) -and ($Setting.FinalForceLogoffMessageTitle.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Final force logoff message box title"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FinalForceLogoffMessageTitle.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FinalForceLogoffMessageTitle.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FinalForceLogoffMessageTitle.Value 
						}
					}
					If((validStateProp $Setting ForceLogoffGracePeriod State ) -and ($Setting.ForceLogoffGracePeriod.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Force logoff grace period"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ForceLogoffGracePeriod.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ForceLogoffGracePeriod.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ForceLogoffGracePeriod.Value 
						}
					}
					If((validStateProp $Setting ForceLogoffMessageBody State ) -and ($Setting.ForceLogoffMessageBody.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Force logoff message box body text"
						$tmpArray = $Setting.ForceLogoffMessageBody.Value.Split("`n")
						$tmp = ""
						$cnt = 0
						ForEach($Thing in $TmpArray)
						{
							If($Null -eq $Thing)
							{
								$Thing = ''
							}
							$cnt++
							$tmp = "$($Thing) "
							If($cnt -eq 1)
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
							Else
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
							}
							$txt = ""
						}
						$TmpArray = $Null
						$tmp = $Null
					}
					If((validStateProp $Setting ForceLogoffMessageTitle State ) -and ($Setting.ForceLogoffMessageTitle.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Force logoff message box title"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ForceLogoffMessageTitle.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ForceLogoffMessageTitle.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ForceLogoffMessageTitle.Value 
						}
					}
					If((validStateProp $Setting ImageProviderIntegrationEnabled State ) -and ($Setting.ImageProviderIntegrationEnabled.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Image-managed mode"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ImageProviderIntegrationEnabled.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ImageProviderIntegrationEnabled.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ImageProviderIntegrationEnabled.State 
						}
					}
					If((validStateProp $Setting RebootMessageBody State ) -and ($Setting.RebootMessageBody.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Reboot message box body text"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.RebootMessageBody.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.RebootMessageBody.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.RebootMessageBody.Value 
						}
					}
					If((validStateProp $Setting AgentTaskInterval State ) -and ($Setting.AgentTaskInterval.State -ne "NotConfigured"))
					{
						$txt = "Connector for Configuration Manager 2012\Regular time interval at which the agent task is to run"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AgentTaskInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AgentTaskInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AgentTaskInterval.Value 
						}
					}
					
					Write-Verbose "$(Get-Date): `t`t`tICA"
					If((validStateProp $Setting ClipboardRedirection State ) -and ($Setting.ClipboardRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Client clipboard redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClipboardRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClipboardRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClipboardRedirection.State 
						}
					}
					If((validStateProp $Setting ClientClipboardWriteAllowedFormats State ) -and ($Setting.ClientClipboardWriteAllowedFormats.State -ne "NotConfigured"))
					{
						$txt = "ICA\Client clipboard write allowed formats"
						If(validStateProp $Setting ClientClipboardWriteAllowedFormats Values )
						{
							$tmpArray = $Setting.ClientClipboardWriteAllowedFormats.Values
							$tmp = ""
							$cnt = 0
							ForEach($Thing in $TmpArray)
							{
								If($Null -eq $Thing)
								{
									$Thing = ''
								}
								$cnt++
								$tmp = "$($Thing) "
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
								$txt = ""
							}
							$TmpArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Client clipboard write allowed formats were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}
					If((validStateProp $Setting DesktopLaunchForNonAdmins State ) -and ($Setting.DesktopLaunchForNonAdmins.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop launches"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DesktopLaunchForNonAdmins.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DesktopLaunchForNonAdmins.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DesktopLaunchForNonAdmins.State 
						}
					}
					If((validStateProp $Setting IcaListenerTimeout State ) -and ($Setting.IcaListenerTimeout.State -ne "NotConfigured"))
					{
						$txt = "ICA\ICA listener connection timeout (milliseconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaListenerTimeout.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaListenerTimeout.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaListenerTimeout.Value 
						}
					}
					If((validStateProp $Setting IcaListenerPortNumber State ) -and ($Setting.IcaListenerPortNumber.State -ne "NotConfigured"))
					{
						$txt = "ICA\ICA listener port number"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaListenerPortNumber.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaListenerPortNumber.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaListenerPortNumber.Value 
						}
					}
					If((validStateProp $Setting NonPublishedProgramLaunching State ) -and ($Setting.NonPublishedProgramLaunching.State -ne "NotConfigured"))
					{
						$txt = "ICA\Launching of non-published programs during client connection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.NonPublishedProgramLaunching.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.NonPublishedProgramLaunching.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.NonPublishedProgramLaunching.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Adobe Flash Delivery\Flash Redirection"
					If((validStateProp $Setting FlashAcceleration State ) -and ($Setting.FlashAcceleration.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash acceleration"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FlashAcceleration.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FlashAcceleration.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FlashAcceleration.State 
						}
					}
					If((validStateProp $Setting FlashUrlColorList State ) -and ($Setting.FlashUrlColorList.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash background color list"
						If(validStateProp $Setting FlashUrlColorList Values )
						{
							$Values = $Setting.FlashUrlColorList.Values
							$tmp = ""
							$cnt = 0
							ForEach($Value in $Values)
							{
								If($Null -eq $Value)
								{
									$Value = ''
								}
								$cnt++
								$tmp = "$($Value)"
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp 
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$tmp = $Null
							$Values = $Null
						}
						Else
						{
							$tmp = "No Flash background color list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}
						}
					}
					If((validStateProp $Setting FlashBackwardsCompatibility State ) -and ($Setting.FlashBackwardsCompatibility.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash backwards compatibility"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FlashBackwardsCompatibility.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FlashBackwardsCompatibility.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FlashBackwardsCompatibility.State 
						}
					}
					If((validStateProp $Setting FlashDefaultBehavior State ) -and ($Setting.FlashDefaultBehavior.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash Default behavior"
						$tmp = ""
						Switch ($Setting.FlashDefaultBehavior.Value)
						{
							"Block"   {$tmp = "Block Flash player"; Break}
							"Disable" {$tmp = "Disable Flash acceleration"; Break}
							"Enable"  {$tmp = "Enable Flash acceleration"; Break}
							Default {$tmp = "Flash Default behavior could not be determined: $($Setting.FlashDefaultBehavior.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting FlashEventLogging State ) -and ($Setting.FlashEventLogging.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash event logging"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FlashEventLogging.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FlashEventLogging.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FlashEventLogging.State 
						}
					}
					If((validStateProp $Setting FlashIntelligentFallback State ) -and ($Setting.FlashIntelligentFallback.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash intelligent fallback"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FlashIntelligentFallback.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FlashIntelligentFallback.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FlashIntelligentFallback.State 
						}
					}
					If((validStateProp $Setting FlashLatencyThreshold State ) -and ($Setting.FlashLatencyThreshold.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash latency threshold (milliseconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FlashLatencyThreshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FlashLatencyThreshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FlashLatencyThreshold.Value 
						}
					}
					If((validStateProp $Setting FlashServerSideContentFetchingWhitelist State ) -and ($Setting.FlashServerSideContentFetchingWhitelist.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash server-side content fetching URL list"
						If(validStateProp $Setting FlashServerSideContentFetchingWhitelist Values )
						{
							$Values = $Setting.FlashServerSideContentFetchingWhitelist.Values
							$tmp = ""
							$cnt = 0
							ForEach($Value in $Values)
							{
								If($Null -eq $Value)
								{
									$Value = ''
								}
								$cnt++
								$tmp = "$($Value)"
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp 
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$tmp = $Null
							$Values = $Null
						}
						Else
						{
							$tmp = "No Flash server-side content fetching URL list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}
						}
					}
					If((validStateProp $Setting FlashUrlCompatibilityList State ) -and ($Setting.FlashUrlCompatibilityList.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash URL compatibility list"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = "";
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							"",$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt
						}
						If(validStateProp $Setting FlashUrlCompatibilityList Values )
						{
							$Values = $Setting.FlashUrlCompatibilityList.Values
							$tmp = ""
							ForEach($Value in $Values)
							{
								$Items = $Value.Split(' ')
								$Action = $Items[0]
								If($Action -eq "CLIENT")
								{
									$Action = "Render On Client"
								}
								ElseIf($Action -eq "SERVER")
								{
									$Action = "Render On Server"
								}
								ElseIf($Action -eq "BLOCK")
								{
									$Action = "BLOCK           "
								}
								$Url = $Items[1]
								If($Items.Count -eq 3)
								{
									$FlashInstance = $Items[2]
								}
								Else
								{
									$FlashInstance = "Any"
								}
								$tmp = "Action: $($Action)"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
								$tmp = "URL Pattern: $($Url)"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
								$tmp = "Flash Instance: $($FlashInstance)"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
							}
							$Values = $Null
							$Action = $Null
							$Url = $Null
							$FlashInstance = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Flash URL compatibility list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = "";
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								"",$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting "" $tmp
							}
						}
					}
					If((validStateProp $Setting HDXFlashLoadManagement State ) -and ($Setting.HDXFlashLoadManagement.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash video fallback prevention"
						$tmp = ""
						Switch ($Setting.HDXFlashLoadManagement.Value)
						{
							"Small"   {$tmp = "Only small content"; Break}
							"SmallContentWRedirection" {$tmp = "Only small content with a supported client"; Break}
							"NoServerSide"  {$tmp = "No server side content"; Break}
							Default {$tmp = "Flash video fallback prevention could not be determined: $($Setting.HDXFlashLoadManagement.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting HDXFlashLoadManagementErrorSwf State ) -and ($Setting.HDXFlashLoadManagementErrorSwf.State -ne "NotConfigured"))
					{
						$txt = "ICA\Adobe Flash Delivery\Flash Redirection\Flash video fallback prevention error *.swf"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.HDXFlashLoadManagementErrorSwf.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.HDXFlashLoadManagementErrorSwf.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.HDXFlashLoadManagementErrorSwf.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Audio"
					If((validStateProp $Setting AllowRtpAudio State ) -and ($Setting.AllowRtpAudio.State -ne "NotConfigured"))
					{
						$txt = "ICA\Audio\Audio over UDP Real-time Transport"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowRtpAudio.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowRtpAudio.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowRtpAudio.State 
						}
					}
					If((validStateProp $Setting AudioPlugNPlay State ) -and ($Setting.AudioPlugNPlay.State -ne "NotConfigured"))
					{
						$txt = "ICA\Audio\Audio Plug N Play"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AudioPlugNPlay.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AudioPlugNPlay.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AudioPlugNPlay.State 
						}
					}
					If((validStateProp $Setting AudioQuality State ) -and ($Setting.AudioQuality.State -ne "NotConfigured"))
					{
						$txt = "ICA\Audio\Audio quality"
						$tmp = ""
						Switch ($Setting.AudioQuality.Value)
						{
							"Low"    {$tmp = "Low - for low-speed connections"; Break}
							"Medium" {$tmp = "Medium - optimized for speech"; Break}
							"High"   {$tmp = "High - high definition audio"; Break}
							Default {$tmp = "Audio quality could not be determined: $($Setting.AudioQuality.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting ClientAudioRedirection State ) -and ($Setting.ClientAudioRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Audio\Client audio redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientAudioRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientAudioRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientAudioRedirection.State 
						}
					}
					If((validStateProp $Setting MicrophoneRedirection State ) -and ($Setting.MicrophoneRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Audio\Client microphone redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MicrophoneRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MicrophoneRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MicrophoneRedirection.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Auto Client Reconnect"
					If((validStateProp $Setting AutoClientReconnect State ) -and ($Setting.AutoClientReconnect.State -ne "NotConfigured"))
					{
						$txt = "ICA\Auto Client Reconnect\Auto client reconnect"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AutoClientReconnect.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AutoClientReconnect.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AutoClientReconnect.State 
						}
					}
					If((validStateProp $Setting AutoClientReconnectAuthenticationRequired  State ) -and ($Setting.AutoClientReconnectAuthenticationRequired.State -ne "NotConfigured"))
					{
						$txt = "ICA\Auto Client Reconnect\Auto client reconnect authentication"
						$tmp = ""
						Switch ($Setting.AutoClientReconnectAuthenticationRequired.Value)
						{
							"DoNotRequireAuthentication" {$tmp = "Do not require authentication"; Break}
							"RequireAuthentication"      {$tmp = "Require authentication"; Break}
							Default {$tmp = "Auto client reconnect authentication could not be determined: $($Setting.AutoClientReconnectAuthenticationRequired.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting AutoClientReconnectLogging State ) -and ($Setting.AutoClientReconnectLogging.State -ne "NotConfigured"))
					{
						$txt = "ICA\Auto Client Reconnect\Auto client reconnect logging"
						$tmp = ""
						Switch ($Setting.AutoClientReconnectLogging.Value)
						{
							"DoNotLogAutoReconnectEvents" {$tmp = "Do Not Log auto-reconnect events"; Break}
							"LogAutoReconnectEvents"      {$tmp = "Log auto-reconnect events"; Break}
							Default {$tmp = "Auto client reconnect logging could not be determined: $($Setting.AutoClientReconnectLogging.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					
					Write-Verbose "$(Get-Date): `t`t`tICA\Bandwidth"
					If((validStateProp $Setting AudioBandwidthLimit State ) -and ($Setting.AudioBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Audio redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AudioBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AudioBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AudioBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting AudioBandwidthPercent State ) -and ($Setting.AudioBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Audio redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AudioBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AudioBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AudioBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting USBBandwidthLimit State ) -and ($Setting.USBBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Client USB device redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.USBBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.USBBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.USBBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting USBBandwidthPercent State ) -and ($Setting.USBBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Client USB device redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.USBBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.USBBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.USBBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting ClipboardBandwidthLimit State ) -and ($Setting.ClipboardBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Clipboard redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClipboardBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClipboardBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClipboardBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting ClipboardBandwidthPercent State ) -and ($Setting.ClipboardBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Clipboard redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClipboardBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClipboardBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClipboardBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting ComPortBandwidthLimit State ) -and ($Setting.ComPortBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\COM port redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ComPortBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ComPortBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ComPortBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting ComPortBandwidthPercent State ) -and ($Setting.ComPortBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\COM port redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ComPortBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ComPortBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ComPortBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting FileRedirectionBandwidthLimit State ) -and ($Setting.FileRedirectionBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\File redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FileRedirectionBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FileRedirectionBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FileRedirectionBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting FileRedirectionBandwidthPercent State ) -and ($Setting.FileRedirectionBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\File redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FileRedirectionBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FileRedirectionBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FileRedirectionBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting HDXMultimediaBandwidthLimit State ) -and ($Setting.HDXMultimediaBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\HDX MediaStream Multimedia Acceleration bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.HDXMultimediaBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.HDXMultimediaBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.HDXMultimediaBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting HDXMultimediaBandwidthPercent State ) -and ($Setting.HDXMultimediaBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\HDX MediaStream Multimedia Acceleration bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.HDXMultimediaBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.HDXMultimediaBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.HDXMultimediaBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting LptBandwidthLimit State ) -and ($Setting.LptBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\LPT port redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LptBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LptBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LptBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting LptBandwidthLimitPercent State ) -and ($Setting.LptBandwidthLimitPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\LPT port redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LptBandwidthLimitPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LptBandwidthLimitPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LptBandwidthLimitPercent.Value 
						}
					}
					If((validStateProp $Setting OverallBandwidthLimit State ) -and ($Setting.OverallBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Overall session bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.OverallBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.OverallBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.OverallBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting PrinterBandwidthLimit State ) -and ($Setting.PrinterBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Printer redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PrinterBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PrinterBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PrinterBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting PrinterBandwidthPercent State ) -and ($Setting.PrinterBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\Printer redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PrinterBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PrinterBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PrinterBandwidthPercent.Value 
						}
					}
					If((validStateProp $Setting TwainBandwidthLimit State ) -and ($Setting.TwainBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\TWAIN device redirection bandwidth limit (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TwainBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TwainBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TwainBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting TwainBandwidthPercent State ) -and ($Setting.TwainBandwidthPercent.State -ne "NotConfigured"))
					{
						$txt = "ICA\Bandwidth\TWAIN device redirection bandwidth limit %"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TwainBandwidthPercent.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TwainBandwidthPercent.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TwainBandwidthPercent.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Client Sensors\Location"
					If((validStateProp $Setting AllowLocationServices State ) -and ($Setting.AllowLocationServices.State -ne "NotConfigured"))
					{
						$txt = "ICA\Client Sensors\Location\Allow applications to use the physical location of the client device"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowLocationServices.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowLocationServices.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowLocationServices.State 
						}
					}
					
					Write-Verbose "$(Get-Date): `t`t`tICA\Desktop UI"
					If((validStateProp $Setting AeroRedirection State ) -and ($Setting.AeroRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop UI\Aero Redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AeroRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AeroRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AeroRedirection.State 
						}
					}
					If((validStateProp $Setting GraphicsQuality State ) -and ($Setting.GraphicsQuality.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop UI\Aero Redirection Graphics Quality"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.GraphicsQuality.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.GraphicsQuality.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.GraphicsQuality.Value 
						}
					}
					If((validStateProp $Setting DesktopWallpaper State ) -and ($Setting.DesktopWallpaper.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop UI\Desktop wallpaper"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DesktopWallpaper.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DesktopWallpaper.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DesktopWallpaper.State 
						}
					}
					If((validStateProp $Setting MenuAnimation State ) -and ($Setting.MenuAnimation.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop UI\Menu animation"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MenuAnimation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MenuAnimation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MenuAnimation.State 
						}
					}
					If((validStateProp $Setting WindowContentsVisibleWhileDragging State ) -and ($Setting.WindowContentsVisibleWhileDragging.State -ne "NotConfigured"))
					{
						$txt = "ICA\Desktop UI\View window contents while dragging"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.WindowContentsVisibleWhileDragging.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.WindowContentsVisibleWhileDragging.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.WindowContentsVisibleWhileDragging.State 
						}
					}
			
					Write-Verbose "$(Get-Date): `t`t`tICA\End User Monitoring"
					If((validStateProp $Setting IcaRoundTripCalculation State ) -and ($Setting.IcaRoundTripCalculation.State -ne "NotConfigured"))
					{
						$txt = "ICA\End User Monitoring\ICA round trip calculation"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaRoundTripCalculation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaRoundTripCalculation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaRoundTripCalculation.State 
						}
					}
					If((validStateProp $Setting IcaRoundTripCalculationInterval State ) -and ($Setting.IcaRoundTripCalculationInterval.State -ne "NotConfigured"))
					{
						$txt = "ICA\End User Monitoring\ICA round trip calculation interval (seconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaRoundTripCalculationInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaRoundTripCalculationInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaRoundTripCalculationInterval.Value 
						}	
					}
					If((validStateProp $Setting IcaRoundTripCalculationWhenIdle State ) -and ($Setting.IcaRoundTripCalculationWhenIdle.State -ne "NotConfigured"))
					{
						$txt = "ICA\End User Monitoring\ICA round trip calculations for idle connections"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaRoundTripCalculationWhenIdle.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaRoundTripCalculationWhenIdle.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaRoundTripCalculationWhenIdle.State 
						}	
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Enhanced Desktop Experience"
					If((validStateProp $Setting EnhancedDesktopExperience State ) -and ($Setting.EnhancedDesktopExperience.State -ne "NotConfigured"))
					{
						$txt = "ICA\Enhanced Desktop Experience\Enhanced Desktop Experience"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.EnhancedDesktopExperience.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.EnhancedDesktopExperience.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.EnhancedDesktopExperience.State 
						}	
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\File Redirection"
					If((validStateProp $Setting AllowFileTransfer State ) -and ($Setting.AllowFileTransfer.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Allow file transfer between desktop and client"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowFileTransfer.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowFileTransfer.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowFileTransfer.State 
						}
					}
					If((validStateProp $Setting AutoConnectDrives State ) -and ($Setting.AutoConnectDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Auto connect client drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AutoConnectDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AutoConnectDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AutoConnectDrives.State 
						}
					}
					If((validStateProp $Setting ClientDriveRedirection State ) -and ($Setting.ClientDriveRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client drive redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientDriveRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientDriveRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientDriveRedirection.State 
						}
					}
					If((validStateProp $Setting ClientFixedDrives State ) -and ($Setting.ClientFixedDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client fixed drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientFixedDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientFixedDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientFixedDrives.State 
						}
					}
					If((validStateProp $Setting ClientFloppyDrives State ) -and ($Setting.ClientFloppyDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client floppy drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientFloppyDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientFloppyDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientFloppyDrives.State 
						}
					}
					If((validStateProp $Setting ClientNetworkDrives State ) -and ($Setting.ClientNetworkDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client network drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientNetworkDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientNetworkDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientNetworkDrives.State 
						}
					}
					If((validStateProp $Setting ClientOpticalDrives State ) -and ($Setting.ClientOpticalDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client optical drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientOpticalDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientOpticalDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientOpticalDrives.State 
						}
					}
					If((validStateProp $Setting ClientRemoveableDrives State ) -and ($Setting.ClientRemoveableDrives.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Client removable drives"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientRemoveableDrives.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientRemoveableDrives.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientRemoveableDrives.State 
						}
					}
					If((validStateProp $Setting AllowFileDownload State ) -and ($Setting.AllowFileDownload.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Download file from desktop"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowFileDownload.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowFileDownload.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowFileDownload.State 
						}
					}
					If((validStateProp $Setting HostToClientRedirection State ) -and ($Setting.HostToClientRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Host to client redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.HostToClientRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.HostToClientRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.HostToClientRedirection.State 
						}
					}
					If((validStateProp $Setting ClientDriveLetterPreservation State ) -and ($Setting.ClientDriveLetterPreservation.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Preserve client drive letters"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientDriveLetterPreservation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientDriveLetterPreservation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientDriveLetterPreservation.State 
						}
					}
					If((validStateProp $Setting ReadOnlyMappedDrive State ) -and ($Setting.ReadOnlyMappedDrive.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Read-only client drive access"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ReadOnlyMappedDrive.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ReadOnlyMappedDrive.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ReadOnlyMappedDrive.State 
						}
					}
					If((validStateProp $Setting SpecialFolderRedirection State ) -and ($Setting.SpecialFolderRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Special folder redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SpecialFolderRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SpecialFolderRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SpecialFolderRedirection.State 
						}
					}
					If((validStateProp $Setting AllowFileUpload State ) -and ($Setting.AllowFileUpload.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Upload file to desktop"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowFileUpload.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowFileUpload.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowFileUpload.State 
						}
					}
					If((validStateProp $Setting AsynchronousWrites State ) -and ($Setting.AsynchronousWrites.State -ne "NotConfigured"))
					{
						$txt = "ICA\File Redirection\Use asynchronous writes"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AsynchronousWrites.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AsynchronousWrites.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AsynchronousWrites.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Graphics"
					If((validStateProp $Setting AllowVisuallyLosslessCompression State ) -and ($Setting.AllowVisuallyLosslessCompression.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Allow visually lossless compression"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowVisuallyLosslessCompression.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowVisuallyLosslessCompression.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowVisuallyLosslessCompression.State 
						}
					}
					If((validStateProp $Setting DisplayMemoryLimit State ) -and ($Setting.DisplayMemoryLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Display memory limit (KB)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DisplayMemoryLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DisplayMemoryLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DisplayMemoryLimit.Value 
						}	
					}
					If((validStateProp $Setting DisplayDegradePreference State ) -and ($Setting.DisplayDegradePreference.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Display mode degrade preference"
						$tmp = ""
						Switch ($Setting.DisplayDegradePreference.Value)
						{
							"ColorDepth" {$tmp = "Degrade color depth first"; Break}
							"Resolution" {$tmp = "Degrade resolution first"; Break}
							Default {$tmp = "Display mode degrade preference could not be determined: $($Setting.DisplayDegradePreference.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}	
						$tmp = $Null
					}
					If((validStateProp $Setting DynamicPreview State ) -and ($Setting.DynamicPreview.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Dynamic Windows Preview"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DynamicPreview.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DynamicPreview.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DynamicPreview.State 
						}	
					}
					If((validStateProp $Setting ImageCaching State ) -and ($Setting.ImageCaching.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Image caching"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ImageCaching.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ImageCaching.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ImageCaching.State 
						}	
					}
					If((validStateProp $Setting LegacyGraphicsMode State ) -and ($Setting.LegacyGraphicsMode.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Legacy graphics mode"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LegacyGraphicsMode.State;
						}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LegacyGraphicsMode.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LegacyGraphicsMode.State 
						}
					}
					If((validStateProp $Setting MaximumColorDepth State ) -and ($Setting.MaximumColorDepth.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Maximum allowed color depth"
						$tmp = ""
						Switch ($Setting.MaximumColorDepth.Value)
						{
							"BitsPerPixel24"	{$tmp = "24 Bits Per Pixel"; Break}
							"BitsPerPixel32"	{$tmp = "32 Bits Per Pixel"; Break}
							"BitsPerPixel16"	{$tmp = "16 Bits Per Pixel"; Break}
							"BitsPerPixel15"	{$tmp = "15 Bits Per Pixel"; Break}
							"BitsPerPixel8"		{$tmp = "8 Bits Per Pixel"; Break}
							Default				{$tmp = "Maximum allowed color depth could not be determined: $($Setting.MaximumColorDepth.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}	
						$tmp = $Null
					}
					If((validStateProp $Setting DisplayDegradeUserNotification State ) -and ($Setting.DisplayDegradeUserNotification.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Notify user when display mode is degraded"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DisplayDegradeUserNotification.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DisplayDegradeUserNotification.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DisplayDegradeUserNotification.State 
						}	
					}
					If((validStateProp $Setting QueueingAndTossing State ) -and ($Setting.QueueingAndTossing.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Queueing and tossing"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.QueueingAndTossing.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.QueueingAndTossing.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.QueueingAndTossing.State 
						}	
					}
					If((validStateProp $Setting UseVideoCodecForCompression State ) -and ($Setting.UseVideoCodecForCompression.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Use video codec for compression"
						$tmp = ""
						Switch ($Setting.UseVideoCodecForCompression.Value)
						{
							"UseVideoCodecIfAvailable"	{$tmp = "For the entire screen"; Break}
							"DoNotUseVideoCodec"		{$tmp = "Do not use video codec"; Break}
							"UseVideoCodecIfPreferred"	{$tmp = "Use when preferred"; Break}
							"ActivelyChangingRegions"	{$tmp = "For actively changing regions"; Break}
							Default {$tmp = "Use video codec for compression could not be determined: $($Setting.UseVideoCodecForCompression.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}	
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Graphics\Caching"
					If((validStateProp $Setting PersistentCache State ) -and ($Setting.PersistentCache.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Caching\Persistent cache threshold (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PersistentCache.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PersistentCache.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PersistentCache.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Graphics\Framehawk"
					If((validStateProp $Setting EnableFramehawkDisplayChannel State ) -and ($Setting.EnableFramehawkDisplayChannel.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Framehawk\Framehawk display channel"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.EnableFramehawkDisplayChannel.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.EnableFramehawkDisplayChannel.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.EnableFramehawkDisplayChannel.State 
						}
					}
					If((validStateProp $Setting FramehawkDisplayChannelPortRange State ) -and ($Setting.FramehawkDisplayChannelPortRange.State -ne "NotConfigured"))
					{
						$txt = "ICA\Graphics\Framehawk\Framehawk display channel port range"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FramehawkDisplayChannelPortRange.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FramehawkDisplayChannelPortRange.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FramehawkDisplayChannelPortRange.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Keep Alive"
					If((validStateProp $Setting IcaKeepAliveTimeout State ) -and ($Setting.IcaKeepAliveTimeout.State -ne "NotConfigured"))
					{
						$txt = "ICA\Keep Alive\ICA keep alive timeout (seconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IcaKeepAliveTimeout.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IcaKeepAliveTimeout.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IcaKeepAliveTimeout.Value 
						}
					}
					If((validStateProp $Setting IcaKeepAlives State ) -and ($Setting.IcaKeepAlives.State -ne "NotConfigured"))
					{
						$txt = "ICA\Keep Alive\ICA keep alives"
						$tmp = ""
						Switch ($Setting.IcaKeepAlives.Value)
						{
							"DoNotSendKeepAlives" {$tmp = "Do not send ICA keep alive messages"; Break}
							"SendKeepAlives"      {$tmp = "Send ICA keep alive messages"; Break}
							Default {$tmp = "ICA keep alives could not be determined: $($Setting.IcaKeepAlives.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Local App Access"
					If((validStateProp $Setting AllowLocalAppAccess State ) -and ($Setting.AllowLocalAppAccess.State -ne "NotConfigured"))
					{
						$txt = "ICA\Local App Access\Allow local app access"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AllowLocalAppAccess.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AllowLocalAppAccess.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AllowLocalAppAccess.State 
						}
					}
					If((validStateProp $Setting URLRedirectionBlackList State ) -and ($Setting.URLRedirectionBlackList.State -ne "NotConfigured"))
					{
						$txt = "ICA\Local App Access\URL redirection blacklist"
						If(validStateProp $Setting URLRedirectionBlackList Values )
						{
							$tmpArray = $Setting.URLRedirectionBlackList.Values
							$tmp = ""
							$cnt = 0
							ForEach($Thing in $TmpArray)
							{
								If($Null -eq $Thing)
								{
									$Thing = ''
								}
								$cnt++
								$tmp = "$($Thing) "
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$TmpArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No URL redirection blacklist were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}
					If((validStateProp $Setting URLRedirectionWhiteList State ) -and ($Setting.URLRedirectionWhiteList.State -ne "NotConfigured"))
					{
						$txt = "ICA\Local App Access\URL redirection white list"
						If(validStateProp $Setting URLRedirectionWhiteList Values )
						{
							$tmpArray = $Setting.URLRedirectionWhiteList.Values
							$tmp = ""
							$cnt = 0
							ForEach($Thing in $TmpArray)
							{
								If($Null -eq $Thing)
								{
									$Thing = ''
								}
								$cnt++
								$tmp = "$($Thing) "
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$TmpArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No URL redirection white list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Mobile Experience"
					If((validStateProp $Setting AutoKeyboardPopUp State ) -and ($Setting.AutoKeyboardPopUp.State -ne "NotConfigured"))
					{
						$txt = "ICA\Mobile Experience\Automatic keyboard display"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AutoKeyboardPopUp.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AutoKeyboardPopUp.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AutoKeyboardPopUp.State 
						}
					}
					If((validStateProp $Setting MobileDesktop State ) -and ($Setting.MobileDesktop.State -ne "NotConfigured"))
					{
						$txt = "ICA\Mobile Experience\Launch touch-optimized desktop"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MobileDesktop.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MobileDesktop.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MobileDesktop.State 
						}
					}
					If((validStateProp $Setting ComboboxRemoting State ) -and ($Setting.ComboboxRemoting.State -ne "NotConfigured"))
					{
						$txt = "ICA\Mobile Experience\Remote the combo box"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ComboboxRemoting.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ComboboxRemoting.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ComboboxRemoting.State 
						}
					}
					
					Write-Verbose "$(Get-Date): `t`t`tICA\Multimedia"
					If((validStateProp $Setting VideoQuality State ) -and ($Setting.VideoQuality.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Limit video quality"
						$tmp = ""
						Switch ($Setting.VideoQuality.Value)
						{
							"P1080"			{$tmp = "Maximum Video Quality 1080p/8.5mbps"; Break}
							"P720"			{$tmp = "Maximum Video Quality 720p/4.0mbps"; Break}
							"P480"			{$tmp = "Maximum Video Quality 480p/720kbps"; Break}
							"P380"			{$tmp = "Maximum Video Quality 380p/400kbps"; Break}
							"P240"			{$tmp = "Maximum Video Quality 240p/200kbps"; Break}
							"Unconfigured"	{$tmp = "Not Configured"; Break}
							Default			{$tmp = "Limit video quality could not be determined: $($Setting.VideoQuality.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting MultimediaConferencing State ) -and ($Setting.MultimediaConferencing.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Multimedia conferencing"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaConferencing.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaConferencing.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaConferencing.State 
						}
					}
					If((validStateProp $Setting MultimediaOptimization State ) -and ($Setting.MultimediaOptimization.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Optimization for Windows Media multimedia redirection over WAN"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaOptimization.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaOptimization.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaOptimization.State 
						}
					}
					If((validStateProp $Setting UseGPUForMultimediaOptimization State ) -and ($Setting.UseGPUForMultimediaOptimization.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Use GPU for optimizing Windows Media multimedia redirection over WAN"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UseGPUForMultimediaOptimization.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UseGPUForMultimediaOptimization.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UseGPUForMultimediaOptimization.State 
						}
					}
					If((validStateProp $Setting MultimediaAccelerationEnableCSF State ) -and ($Setting.MultimediaAccelerationEnableCSF.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Windows Media client-side content fetching"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaAccelerationEnableCSF.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaAccelerationEnableCSF.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaAccelerationEnableCSF.State 
						}
					}
					If((validStateProp $Setting VideoLoadManagement State ) -and ($Setting.VideoLoadManagement.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Windows media fallback prevention"
						$tmp = ""
						Switch ($Setting.VideoLoadManagement.Value)
						{
							"SFSR" {$tmp = "Play all content"; Break}
							"SFCR" {$tmp = "Play all content only on client"; Break}
							"CFCR" {$tmp = "Play only client-accessible content on client"; Break}
							Default {$tmp = "Windows media fallback prevention could not be determined: $($Setting.VideoLoadManagement.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting MultimediaAcceleration State ) -and ($Setting.MultimediaAcceleration.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Windows Media Redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaAcceleration.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaAcceleration.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaAcceleration.State 
						}
					}
					If((validStateProp $Setting MultimediaAccelerationDefaultBufferSize State ) -and ($Setting.MultimediaAccelerationDefaultBufferSize.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Windows Media Redirection Buffer Size (seconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaAccelerationDefaultBufferSize.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaAccelerationDefaultBufferSize.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaAccelerationDefaultBufferSize.Value 
						}
					}
					If((validStateProp $Setting MultimediaAccelerationUseDefaultBufferSize State ) -and ($Setting.MultimediaAccelerationUseDefaultBufferSize.State -ne "NotConfigured"))
					{
						$txt = "ICA\Multimedia\Windows Media Redirection Buffer Size Use"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultimediaAccelerationUseDefaultBufferSize.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultimediaAccelerationUseDefaultBufferSize.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultimediaAccelerationUseDefaultBufferSize.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Multi-Stream Connections"
					If((validStateProp $Setting RtpAudioPortRange State ) -and ($Setting.RtpAudioPortRange.State -ne "NotConfigured"))
					{
						$txt = "ICA\MultiStream Connections\Audio UDP Port Range"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.RtpAudioPortRange.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.RtpAudioPortRange.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.RtpAudioPortRange.Value 
						}
					}
					If((validStateProp $Setting MultiPortPolicy State ) -and ($Setting.MultiPortPolicy.State -ne "NotConfigured"))
					{
						$txt1 = "ICA\MultiStream Connections\Multi-Port Policy\CGP default port"
						$txt2 = "ICA\MultiStream Connections\Multi-Port Policy\CGP default port priority"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt1;
							Value = "Default Port";
							}
							$SettingsWordTable += $WordTableRowHash;

							$WordTableRowHash = @{
							Text = $txt2;
							Value = "High";
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt1,$htmlbold,
							"Default Port",$htmlwhite))

							$rowdata += @(,(
							$txt2,$htmlbold,
							"High",$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt1 "Default Port"
							OutputPolicySetting $txt2 "High"
						}
						$txt1 = $Null
						$txt2 = $Null
						[string]$Tmp = $Setting.MultiPortPolicy.Value
						If($Tmp.Length -gt 0)
						{
							$Port1Priority = ""
							$Port2Priority = ""
							$Port3Priority = ""
							[string]$cgpport1 = $Tmp.substring(0, $Tmp.indexof(";"))
							[string]$cgpport2 = $Tmp.substring($cgpport1.length + 1 , $Tmp.indexof(";"))
							[string]$cgpport3 = $Tmp.substring((($cgpport1.length + 1)+($cgpport2.length + 1)) , $Tmp.indexof(";"))
							[string]$cgpport1priority = $cgpport1.substring($cgpport1.length -1, 1)
							[string]$cgpport2priority = $cgpport2.substring($cgpport2.length -1, 1)
							[string]$cgpport3priority = $cgpport3.substring($cgpport3.length -1, 1)
							$cgpport1 = $cgpport1.substring(0, $cgpport1.indexof(","))
							$cgpport2 = $cgpport2.substring(0, $cgpport2.indexof(","))
							$cgpport3 = $cgpport3.substring(0, $cgpport3.indexof(","))
							Switch ($cgpport1priority)
							{
								"0"	{$Port1Priority = "Very High"; Break}
								"2"	{$Port1Priority = "Medium"; Break}
								"3"	{$Port1Priority = "Low"; Break}
								Default	{$Port1Priority = "Unknown"; Break}
							}
							Switch ($cgpport2priority)
							{
								"0"	{$Port2Priority = "Very High"; Break}
								"2"	{$Port2Priority = "Medium"; Break}
								"3"	{$Port2Priority = "Low"; Break}
								Default	{$Port2Priority = "Unknown"; Break}
							}
							Switch ($cgpport3priority)
							{
								"0"	{$Port3Priority = "Very High"; Break}
								"2"	{$Port3Priority = "Medium"; Break}
								"3"	{$Port3Priority = "Low"; Break}
								Default	{$Port3Priority = "Unknown"; Break}
							}
							$txt1 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port1"
							$txt2 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port1 priority"
							$txt3 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port2"
							$txt4 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port2 priority"
							$txt5 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port3"
							$txt6 = "ICA\MultiStream Connections\Multi-Port Policy\CGP port3 priority"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt1;
								Value = $cgpport1;
								}
								$SettingsWordTable += $WordTableRowHash;

								$WordTableRowHash = @{
								Text = $txt2;
								Value = $port1priority;
								}
								$SettingsWordTable += $WordTableRowHash;

								$WordTableRowHash = @{
								Text = $txt3;
								Value = $cgpport2;
								}
								$SettingsWordTable += $WordTableRowHash;

								$WordTableRowHash = @{
								Text = $txt4;
								Value = $port2priority;
								}
								$SettingsWordTable += $WordTableRowHash;

								$WordTableRowHash = @{
								Text = $txt5;
								Value = $cgpport3;
								}
								$SettingsWordTable += $WordTableRowHash;

								$WordTableRowHash = @{
								Text = $txt6;
								Value = $port3priority;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt1,$htmlbold,
								$cgpport1,$htmlwhite))
								
								$rowdata += @(,(
								$txt2,$htmlbold,
								$port1priority,$htmlwhite))
								
								$rowdata += @(,(
								$txt3,$htmlbold,
								$cgpport2,$htmlwhite))
								
								$rowdata += @(,(
								$txt4,$htmlbold,
								$port2priority,$htmlwhite))
								
								$rowdata += @(,(
								$txt5,$htmlbold,
								$cgpport3,$htmlwhite))
								
								$rowdata += @(,(
								$txt6,$htmlbold,
								$port3priority,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt1 $cgpport1
								OutputPolicySetting $txt2 $port1priority
								OutputPolicySetting $txt3 $cgpport2
								OutputPolicySetting $txt4 $port2priority
								OutputPolicySetting $txt5 $cgpport3
								OutputPolicySetting $txt6 $port3priority
							}	
						}
						$Tmp = $Null
						$cgpport1 = $Null
						$cgpport2 = $Null
						$cgpport3 = $Null
						$cgpport1priority = $Null
						$cgpport2priority = $Null
						$cgpport3priority = $Null
						$Port1Priority = $Null
						$Port2Priority = $Null
						$Port3Priority = $Null
						$txt1 = $Null
						$txt2 = $Null
						$txt3 = $Null
						$txt4 = $Null
						$txt5 = $Null
						$txt6 = $Null
					}
					If((validStateProp $Setting MultiStreamPolicy State ) -and ($Setting.MultiStreamPolicy.State -ne "NotConfigured"))
					{
						$txt = "ICA\MultiStream Connections\Multi-Stream computer setting"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultiStreamPolicy.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultiStreamPolicy.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultiStreamPolicy.State 
						}
					}
					If((validStateProp $Setting MultiStream State ) -and ($Setting.MultiStream.State -ne "NotConfigured"))
					{
						$txt = "ICA\MultiStream Connections\Multi-Stream user setting"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MultiStream.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MultiStream.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MultiStream.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Port Redirection"
					If((validStateProp $Setting ClientComPortsAutoConnection State ) -and ($Setting.ClientComPortsAutoConnection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Port Redirection\Auto connect client COM ports"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientComPortsAutoConnection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientComPortsAutoConnection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientComPortsAutoConnection.State 
						}
					}
					If((validStateProp $Setting ClientLptPortsAutoConnection State ) -and ($Setting.ClientLptPortsAutoConnection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Port Redirection\Auto connect client LPT ports"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientLptPortsAutoConnection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientLptPortsAutoConnection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientLptPortsAutoConnection.State 
						}
					}
					If((validStateProp $Setting ClientComPortRedirection State ) -and ($Setting.ClientComPortRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Port Redirection\Client COM port redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientComPortRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientComPortRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientComPortRedirection.State 
						}
					}
					If((validStateProp $Setting ClientLptPortRedirection State ) -and ($Setting.ClientLptPortRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Port Redirection\Client LPT port redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientLptPortRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientLptPortRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientLptPortRedirection.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Printing"
					If((validStateProp $Setting ClientPrinterRedirection State ) -and ($Setting.ClientPrinterRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client printer redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ClientPrinterRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ClientPrinterRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ClientPrinterRedirection.State 
						}
					}
					If((validStateProp $Setting DefaultClientPrinter State ) -and ($Setting.DefaultClientPrinter.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Default printer - Choose client's Default printer"
						$tmp = ""
						Switch ($Setting.DefaultClientPrinter.Value)
						{
							"ClientDefault" {$tmp = "Set Default printer to the client's main printer"; Break}
							"DoNotAdjust"   {$tmp = "Do not adjust the user's Default printer"; Break}
							Default {$tmp = "Default printer could not be determined: $($Setting.DefaultClientPrinter.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp
						}
						$tmp = $Null
					}
					If((validStateProp $Setting PrinterAssignments State ) -and ($Setting.PrinterAssignments.State -ne "NotConfigured"))
					{
						If($Setting.PrinterAssignments.State -eq "Enabled")
						{
							$txt = "ICA\Printing\Printer assignments"
							$PrinterAssign = Get-ChildItem -path "$($xDriveName):\User\$($Policy.PolicyName)\Settings\ICA\Printing\PrinterAssignments" 4>$Null
							If($? -and $Null -ne $PrinterAssign)
							{
								$PrinterAssignments = $PrinterAssign.Contents
								ForEach($PrinterAssignment in $PrinterAssignments)
								{
									$Client = @()
									$DefaultPrinter = ""
									$SessionPrinters = @()
									$tmp1 = ""
									$tmp2 = ""
									$tmp3 = ""
									
									ForEach($Filter in $PrinterAssignment.Filters)
									{
										$Client += "$($Filter); "
									}
									
									Switch ($PrinterAssignment.DefaultPrinterOption)
									{
										"ClientDefault"		{$DefaultPrinter = "Client main printer"; Break}
										"NotConfigured"		{$DefaultPrinter = "<Not set>"; Break}
										"DoNotAdjust"		{$DefaultPrinter = "Do not adjust"; Break}
										"SpecificPrinter"	{$DefaultPrinter = $PrinterAssignment.SpecificDefaultPrinter; Break}
										Default				{$DefaultPrinter = "<Not set>"; Break}
									}
									
									ForEach($SessionPrinter in $PrinterAssignment.SessionPrinters)
									{
										$SessionPrinters += $SessionPrinter
									}
									
									$tmp1 = "Client Names/IP's: $($Client)"
									$tmp2 = "Default Printer  : $($DefaultPrinter)"
									$tmp3 = "Session Printers : $($SessionPrinters)"
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp1;
										}
										$SettingsWordTable += $WordTableRowHash;
										
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp2;
										}
										$SettingsWordTable += $WordTableRowHash;
										
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp3;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp1,$htmlwhite))
										
										$rowdata += @(,(
										"",$htmlbold,
										$tmp2,$htmlwhite))
										
										$rowdata += @(,(
										"",$htmlbold,
										$tmp3,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp1
										OutputPolicySetting "`t`t`t`t" $tmp2
										OutputPolicySetting "`t`t`t`t" $tmp3
									}
									$tmp1 = $Null
									$tmp2 = $Null
									$tmp3 = $Null
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.PrinterAssignments.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.PrinterAssignments.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.PrinterAssignments.State 
							}
						}
					}
					If((validStateProp $Setting AutoCreationEventLogPreference State ) -and ($Setting.AutoCreationEventLogPreference.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Printer auto-creation event log preference"
						$tmp = ""
						Switch ($Setting.AutoCreationEventLogPreference.Value)
						{
							"LogErrorsOnly"        {$tmp = "Log errors only"; Break}
							"LogErrorsAndWarnings" {$tmp = "Log errors and warnings"; Break}
							"DoNotLog"             {$tmp = "Do not log errors or warnings"; Break}
							Default {$tmp = "Printer auto-creation event log preference could not be determined: $($Setting.AutoCreationEventLogPreference.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp
						}
						$tmp = $Null
					}
					If((validStateProp $Setting SessionPrinters State ) -and ($Setting.SessionPrinters.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Session printers"
						If(validStateProp $Setting SessionPrinters Values )
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = "";
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								"",$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt ""
							}
							$valArray = $Setting.SessionPrinters.Values
							$tmp = ""
							ForEach($printer in $valArray)
							{
								$prArray = $printer.Split(',')
								ForEach($element in $prArray)
								{
									If($element.SubString(0, 2) -eq "\\")
									{
										$index = $element.SubString(2).IndexOf('\')
										If($index -ge 0)
										{
											$server = $element.SubString(0, $index + 2)
											$share  = $element.SubString($index + 3)
											$tmp = "Server: $($server)"
											If($MSWord -or $PDF)
											{
												$WordTableRowHash = @{
												Text = "";
												Value = $tmp;
												}
												$SettingsWordTable += $WordTableRowHash;
											}
											ElseIf($HTML)
											{
												$rowdata += @(,(
												"",$htmlbold,
												$tmp,$htmlwhite))
											}
											ElseIf($Text)
											{
												OutputPolicySetting "" $tmp
											}
											$tmp = "Shared Name: $($share)"
											If($MSWord -or $PDF)
											{
												$WordTableRowHash = @{
												Text = "";
												Value = $tmp;
												}
												$SettingsWordTable += $WordTableRowHash;
											}
											ElseIf($HTML)
											{
												$rowdata += @(,(
												"",$htmlbold,
												$tmp,$htmlwhite))
											}
											ElseIf($Text)
											{
												OutputPolicySetting "" $tmp
											}
										}
										$index = $Null
									}
									Else
									{
										$tmp1 = $element.SubString(0, 4)
										$tmp = Get-PrinterModifiedSettings $tmp1 $element
										If(![String]::IsNullOrEmpty($tmp))
										{
											If($MSWord -or $PDF)
											{
												$WordTableRowHash = @{
												Text = "";
												Value = $tmp;
												}
												$SettingsWordTable += $WordTableRowHash;
											}
											ElseIf($HTML)
											{
												$rowdata += @(,(
												"",$htmlbold,
												$tmp,$htmlwhite))
											}
											ElseIf($Text)
											{
												OutputPolicySetting "" $tmp
											}
										}
										$tmp1 = $Null
										$tmp = $Null
									}
								}
							}

							$valArray = $Null
							$prArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Session printers were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}
					If((validStateProp $Setting WaitForPrintersToBeCreated State ) -and ($Setting.WaitForPrintersToBeCreated.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Wait for printers to be created (desktop)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.WaitForPrintersToBeCreated.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.WaitForPrintersToBeCreated.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.WaitForPrintersToBeCreated.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Printing\Client Printers"
					If((validStateProp $Setting ClientPrinterAutoCreation State ) -and ($Setting.ClientPrinterAutoCreation.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Auto-create client printers"
						$tmp = ""
						Switch ($Setting.ClientPrinterAutoCreation.Value)
						{
							"DoNotAutoCreate"    {$tmp = "Do not auto-create client printers"; Break}
							"DefaultPrinterOnly" {$tmp = "Auto-create the client's Default printer only"; Break}
							"LocalPrintersOnly"  {$tmp = "Auto-create local (non-network) client printers only"; Break}
							"AllPrinters"        {$tmp = "Auto-create all client printers"; Break}
							Default {$tmp = "Auto-create client printers could not be determined: $($Setting.ClientPrinterAutoCreation.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp
						}
						$tmp = $Null
					}
					If((validStateProp $Setting GenericUniversalPrinterAutoCreation State ) -and ($Setting.GenericUniversalPrinterAutoCreation.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Auto-create generic universal printer"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.GenericUniversalPrinterAutoCreation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.GenericUniversalPrinterAutoCreation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.GenericUniversalPrinterAutoCreation.State 
						}
					}
					If((validStateProp $Setting AutoCreatePDFPrinter State ) -and ($Setting.AutoCreatePDFPrinter.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Auto-create PDF Universal Printer"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AutoCreatePDFPrinter.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AutoCreatePDFPrinter.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AutoCreatePDFPrinter.State 
						}
					}
					If((validStateProp $Setting ClientPrinterNames State ) -and ($Setting.ClientPrinterNames.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Client printer names"
						$tmp = ""
						Switch ($Setting.ClientPrinterNames.Value)
						{
							"StandardPrinterNames" {$tmp = "Standard printer names"; Break}
							"LegacyPrinterNames"   {$tmp = "Legacy printer names"; Break}
							Default {$tmp = "Client printer names could not be determined: $($Setting.ClientPrinterNames.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting DirectConnectionsToPrintServers State ) -and ($Setting.DirectConnectionsToPrintServers.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Direct connections to print servers"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DirectConnectionsToPrintServers.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DirectConnectionsToPrintServers.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DirectConnectionsToPrintServers.State 
						}
					}
					If((validStateProp $Setting PrinterDriverMappings State ) -and ($Setting.PrinterDriverMappings.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Printer driver mapping and compatibility"
						If(validStateProp $Setting PrinterDriverMappings Values )
						{
							$array = $Setting.PrinterDriverMappings.Values
							$tmp = $array[0]
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
							
							$cnt = -1
							ForEach($element in $array)
							{
								$cnt++
								
								If($cnt -ne 0)
								{
									$Items = $element.Split(',')
									$DriverName = $Items[0]
									$Action = $Items[1]
									If($Action -match 'Replace=')
									{
										$ServerDriver = $Action.substring($Action.indexof("=")+1)
										$Action = "Replace "
									}
									Else
									{
										$ServerDriver = ""
										If($Action -eq "Allow")
										{
											$Action = "Allow "
										}
										ElseIf($Action -eq "Deny")
										{
											$Action = "Do not create "
										}
										ElseIf($Action -eq "UPD_Only")
										{
											$Action = "Create with universal driver "
										}
									}
									$tmp = "Driver Name: $($DriverName)"
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
									}
									$tmp = "Action: $($Action)"
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
									}
									$tmp = "Settings: "
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
									}
									If($Items.count -gt 2)
									{
										[int]$BeginAt = 2
										[int]$EndAt = $Items.count
										for ($i=$BeginAt;$i -lt $EndAt; $i++) 
										{
											$tmp2 = $Items[$i].SubString(0, 4)
											$tmp = Get-PrinterModifiedSettings $tmp2 $Items[$i]
											If(![String]::IsNullOrEmpty($tmp))
											{
												If($MSWord -or $PDF)
												{
													$WordTableRowHash = @{
													Text = "";
													Value = $tmp;
													}
													$SettingsWordTable += $WordTableRowHash;
												}
												ElseIf($HTML)
												{
													$rowdata += @(,(
													"",$htmlbold,
													$tmp,$htmlwhite))
												}
												ElseIf($Text)
												{
													OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
												}
											}
										}
									}
									Else
									{
										$tmp = "Unmodified "
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
										}
									}

									If(![String]::IsNullOrEmpty($ServerDriver))
									{
										$tmp = "Server Driver: $($ServerDriver)"
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "`t`t`t`t`t`t`t`t     " $tmp
										}
									}
									$tmp = $Null
								}
							}
						}
						Else
						{
							$tmp = "No Printer driver mapping and compatibility were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}
					If((validStateProp $Setting PrinterPropertiesRetention State ) -and ($Setting.PrinterPropertiesRetention.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Printer properties retention"
						$tmp = ""
						Switch ($Setting.PrinterPropertiesRetention.Value)
						{
							"SavedOnClientDevice"   {$tmp = "Saved on the client device only"; Break}
							"RetainedInUserProfile" {$tmp = "Retained in user profile only"; Break}
							"FallbackToProfile"     {$tmp = "Held in profile only if not saved on client"; Break}
							"DoNotRetain"           {$tmp = "Do not retain printer properties"; Break}
							Default {$tmp = "Printer properties retention could not be determined: $($Setting.PrinterPropertiesRetention.Value)"; Break}
						}

						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting RetainedAndRestoredClientPrinters State ) -and ($Setting.RetainedAndRestoredClientPrinters.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Client Printers\Retained and restored client printers"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.RetainedAndRestoredClientPrinters.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.RetainedAndRestoredClientPrinters.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.RetainedAndRestoredClientPrinters.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Printing\Drivers"
					If((validStateProp $Setting InboxDriverAutoInstallation State ) -and ($Setting.InboxDriverAutoInstallation.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Drivers\Automatic installation of in-box printer drivers"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.InboxDriverAutoInstallation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.InboxDriverAutoInstallation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.InboxDriverAutoInstallation.State 
						}
					}
					If((validStateProp $Setting UniversalDriverPriority State ) -and ($Setting.UniversalDriverPriority.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Drivers\Universal driver preference"
						$Values = $Setting.UniversalDriverPriority.Value.Split(';')
						$tmp = ""
						$cnt = 0
						ForEach($Value in $Values)
						{
							If($Null -eq $Value)
							{
								$Value = ''
							}
							$cnt++
							$tmp = "$($Value)"
							If($cnt -eq 1)
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp 
								}
							}
							Else
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "`t`t`t`t`t`t" $tmp
								}
							}
						}
						$tmp = $Null
						$Values = $Null
					}
					If((validStateProp $Setting UniversalPrintDriverUsage State ) -and ($Setting.UniversalPrintDriverUsage.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Drivers\Universal print driver usage"
						$tmp = ""
						Switch ($Setting.UniversalPrintDriverUsage.Value)
						{
							"SpecificOnly"       {$tmp = "Use only printer model specific drivers"; Break}
							"UpdOnly"            {$tmp = "Use universal printing only"; Break}
							"FallbackToUpd"      {$tmp = "Use universal printing only if requested driver is unavailable"; Break}
							"FallbackToSpecific" {$tmp = "Use printer model specific drivers only if universal printing is unavailable"; Break}
							Default {$tmp = "Universal print driver usage could not be determined: $($Setting.UniversalPrintDriverUsage.Value)"; Break}
						}

						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Printing\Universal Print Server"
					If((validStateProp $Setting UpsEnable State ) -and ($Setting.UpsEnable.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Print Server\Universal Print Server enable"
						If($Setting.UpsEnable.State)
						{
							$tmp = ""
						}
						Else
						{
							$tmp = "Disabled"
						}
						Switch ($Setting.UpsEnable.Value)
						{
							"UpsEnabledWithFallback"	{$tmp = "Enabled with fallback to Windows' native remote printing"; Break}
							"UpsOnlyEnabled"			{$tmp = "Enabled with no fallback to Windows' native remote printing"; Break}
							Default						{$tmp = "Universal Print Server enable value could not be determined: $($Setting.UpsEnable.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting UpsCgpPort State ) -and ($Setting.UpsCgpPort.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Print Server\Universal Print Server print data stream (CGP) port"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UpsCgpPort.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UpsCgpPort.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UpsCgpPort.Value 
						}
					}
					If((validStateProp $Setting UpsPrintStreamInputBandwidthLimit State ) -and ($Setting.UpsPrintStreamInputBandwidthLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Print Server\Universal Print Server print stream input bandwidth limit (kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UpsPrintStreamInputBandwidthLimit.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UpsPrintStreamInputBandwidthLimit.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UpsPrintStreamInputBandwidthLimit.Value 
						}
					}
					If((validStateProp $Setting UpsHttpPort State ) -and ($Setting.UpsHttpPort.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Print Server\Universal Print Server web service (HTTP/SOAP) port"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UpsHttpPort.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UpsHttpPort.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UpsHttpPort.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Printing\Universal Printing"
					If((validStateProp $Setting EMFProcessingMode State ) -and ($Setting.EMFProcessingMode.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Printing\Universal printing EMF processing mode"
						$tmp = ""
						Switch ($Setting.EMFProcessingMode.Value)
						{
							"ReprocessEMFsForPrinter" {$tmp = "Reprocess EMFs for printer"; Break}
							"SpoolDirectlyToPrinter"  {$tmp = "Spool directly to printer"; Break}
							Default {$tmp = "Universal printing EMF processing mode could not be determined: $($Setting.EMFProcessingMode.Value)"; Break}
						}
						 
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting ImageCompressionLimit State ) -and ($Setting.ImageCompressionLimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Printing\Universal printing image compression limit"
						$tmp = ""
						Switch ($Setting.ImageCompressionLimit.Value)
						{
							"NoCompression"       {$tmp = "No compression"; Break}
							"LosslessCompression" {$tmp = "Best quality (lossless compression)"; Break}
							"MinimumCompression"  {$tmp = "High quality"; Break}
							"MediumCompression"   {$tmp = "Standard quality"; Break}
							"MaximumCompression"  {$tmp = "Reduced quality (maximum compression)"; Break}
							Default {$tmp = "Universal printing image compression limit could not be determined: $($Setting.ImageCompressionLimit.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting UPDCompressionDefaults State ) -and ($Setting.UPDCompressionDefaults.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Printing\Universal printing optimization defaults"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = "";
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							"",$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt "" 
						}
						
						$TmpArray = $Setting.UPDCompressionDefaults.Value.Split(',')
						$tmp = ""
						ForEach($Thing in $TmpArray)
						{
							$TestLabel = $Thing.substring(0, $Thing.indexof("="))
							$TestSetting = $Thing.substring($Thing.indexof("=")+1)
							$TxtLabel = ""
							$TxtSetting = ""
							Switch($TestLabel)
							{
								"ImageCompression"
								{
									$TxtLabel = "Desired image quality:"
									Switch($TestSetting)
									{
										"StandardQuality"	{$TxtSetting = "Standard quality"}
										"BestQuality"	{$TxtSetting = "Best quality (lossless compression)"}
										"HighQuality"	{$TxtSetting = "High quality"}
										"ReducedQuality"	{$TxtSetting = "Reduced quality (maximum compression)"}
									}
								}
								"HeavyweightCompression"
								{
									$TxtLabel = "Enable heavyweight compression:"
									If($TestSetting -eq "True")
									{
										$TxtSetting = "Yes"
									}
									Else
									{
										$TxtSetting = "No"
									}
								}
								"ImageCaching"
								{
									$TxtLabel = "Allow caching of embedded images:"
									If($TestSetting -eq "True")
									{
										$TxtSetting = "Yes"
									}
									Else
									{
										$TxtSetting = "No"
									}
								}
								"FontCaching"
								{
									$TxtLabel = "Allow caching of embedded fonts:"
									If($TestSetting -eq "True")
									{
										$TxtSetting = "Yes"
									}
									Else
									{
										$TxtSetting = "No"
									}
								}
								"AllowNonAdminsToModify"
								{
									$TxtLabel = "Allow non-administrators to modify these settings:"
									If($TestSetting -eq "True")
									{
										$TxtSetting = "Yes"
									}
									Else
									{
										$TxtSetting = "No"
									}
								}
							}
							$tmp = "$($TxtLabel) $TxtSetting "
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = "";
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting "" $tmp
							}
						}
						$tmp = " "
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = "";
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting "" $tmp
						}
						$TmpArray = $Null
						$tmp = $Null
						$TestLabel = $Null
						$TestSetting = $Null
						$TxtLabel = $Null
						$TxtSetting = $Null
					}
					If((validStateProp $Setting UniversalPrintingPreviewPreference State ) -and ($Setting.UniversalPrintingPreviewPreference.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Printing\Universal printing preview preference"
						$tmp = ""
						Switch ($Setting.UniversalPrintingPreviewPreference.Value)
						{
							"NoPrintPreview"        {$tmp = "Do not use print preview for auto-created or generic universal printers"; Break}
							"AutoCreatedOnly"       {$tmp = "Use print preview for auto-created printers only"; Break}
							"GenericOnly"           {$tmp = "Use print preview for generic universal printers only"; Break}
							"AutoCreatedAndGeneric" {$tmp = "Use print preview for both auto-created and generic universal printers"; Break}
							Default {$tmp = "Universal printing preview preference could not be determined: $($Setting.UniversalPrintingPreviewPreference.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting DPILimit State ) -and ($Setting.DPILimit.State -ne "NotConfigured"))
					{
						$txt = "ICA\Printing\Universal Printing\Universal printing print quality limit"
						$tmp = ""
						Switch ($Setting.DPILimit.Value)
						{
							"Draft"            {$tmp = "Draft (150 DPI)"; Break}
							"LowResolution"    {$tmp = "Low Resolution (300 DPI)"; Break}
							"MediumResolution" {$tmp = "Medium Resolution (600 DPI)"; Break}
							"HighResolution"   {$tmp = "High Resolution (1200 DPI)"; Break}
							"Unlimited"       {$tmp = "No Limit"; Break}
							Default {$tmp = "Universal printing print quality limit could not be determined: $($Setting.DPILimit.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Security"
					If((validStateProp $Setting MinimumEncryptionLevel State ) -and ($Setting.MinimumEncryptionLevel.State -ne "NotConfigured"))
					{
						$txt = "ICA\Security\SecureICA minimum encryption level" 
						$tmp = ""
						Switch ($Setting.MinimumEncryptionLevel.Value)
						{
							"Unknown" {$tmp = "Unknown encryption"; Break}
							"Basic"   {$tmp = "Basic"; Break}
							"LogOn"   {$tmp = "RC5 (128 bit) logon only"; Break}
							"Bits40"  {$tmp = "RC5 (40 bit)"; Break}
							"Bits56"  {$tmp = "RC5 (56 bit)"; Break}
							"Bits128" {$tmp = "RC5 (128 bit)"; Break}
							Default {$tmp = "SecureICA minimum encryption level could not be determined: $($Setting.MinimumEncryptionLevel.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Server Limits"
					If((validStateProp $Setting IdleTimerInterval State ) -and ($Setting.IdleTimerInterval.State -ne "NotConfigured"))
					{
						$txt = "ICA\Server Limits\Server idle timer interval (milliseconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.IdleTimerInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.IdleTimerInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.IdleTimerInterval.Value 
						}
					}
					
					Write-Verbose "$(Get-Date): `t`t`tICA\Session Limits"
					If((validStateProp $Setting SessionDisconnectTimer State ) -and ($Setting.SessionDisconnectTimer.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Disconnected session timer"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionDisconnectTimer.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionDisconnectTimer.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionDisconnectTimer.State 
						}
					}
					If((validStateProp $Setting SessionDisconnectTimerInterval State ) -and ($Setting.SessionDisconnectTimerInterval.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Disconnected session timer interval (minutes)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionDisconnectTimerInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionDisconnectTimerInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionDisconnectTimerInterval.Value 
						}
					}
					If((validStateProp $Setting SessionConnectionTimer State ) -and ($Setting.SessionConnectionTimer.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Session connection timer"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionConnectionTimer.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionConnectionTimer.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionConnectionTimer.State 
						}
					}
					If((validStateProp $Setting SessionConnectionTimerInterval State ) -and ($Setting.SessionConnectionTimerInterval.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Session connection timer interval (minutes)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionConnectionTimerInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionConnectionTimerInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionConnectionTimerInterval.Value 
						}
					}
					If((validStateProp $Setting SessionIdleTimer State ) -and ($Setting.SessionIdleTimer.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Session idle timer"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionIdleTimer.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionIdleTimer.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionIdleTimer.State 
						}
					}
					If((validStateProp $Setting SessionIdleTimerInterval State ) -and ($Setting.SessionIdleTimerInterval.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Limits\Session idle timer interval (minutes)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionIdleTimerInterval.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionIdleTimerInterval.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionIdleTimerInterval.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Session Reliability"
					If((validStateProp $Setting SessionReliabilityConnections State ) -and ($Setting.SessionReliabilityConnections.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Reliability\Session reliability connections"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionReliabilityConnections.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionReliabilityConnections.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionReliabilityConnections.State 
						}
					}
					If((validStateProp $Setting SessionReliabilityPort State ) -and ($Setting.SessionReliabilityPort.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Reliability\Session reliability port number"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionReliabilityPort.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionReliabilityPort.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionReliabilityPort.Value 
						}
					}
					If((validStateProp $Setting SessionReliabilityTimeout State ) -and ($Setting.SessionReliabilityTimeout.State -ne "NotConfigured"))
					{
						$txt = "ICA\Session Reliability\Session reliability timeout (seconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SessionReliabilityTimeout.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SessionReliabilityTimeout.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SessionReliabilityTimeout.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Time Zone Control"
					If((validStateProp $Setting LocalTimeEstimation State ) -and ($Setting.LocalTimeEstimation.State -ne "NotConfigured"))
					{
						$txt = "ICA\Time Zone Control\Estimate local time for legacy clients"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LocalTimeEstimation.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LocalTimeEstimation.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LocalTimeEstimation.State 
						}
					}
					If((validStateProp $Setting SessionTimeZone State ) -and ($Setting.SessionTimeZone.State -ne "NotConfigured"))
					{
						$txt = "ICA\Time Zone Control\Use local time of client"
						$tmp = ""
						Switch ($Setting.SessionTimeZone.Value)
						{
							"UseServerTimeZone" {$tmp = "Use server time zone"; Break}
							"UseClientTimeZone" {$tmp = "Use client time zone"; Break}
							Default {$tmp = "Use local time of client could not be determined: $($Setting.SessionTimeZone.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\TWAIN Devices"
					If((validStateProp $Setting TwainRedirection State ) -and ($Setting.TwainRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\TWAIN devices\Client TWAIN device redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TwainRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TwainRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TwainRedirection.State 
						}
					}
					If((validStateProp $Setting TwainCompressionLevel State ) -and ($Setting.TwainCompressionLevel.State -ne "NotConfigured"))
					{
						$txt = "ICA\TWAIN devices\TWAIN compression level"
						Switch ($Setting.TwainCompressionLevel.Value)
						{
							"None"   {$tmp = "None"; Break}
							"Low"    {$tmp = "Low"; Break}
							"Medium" {$tmp = "Medium"; Break}
							"High"   {$tmp = "High"; Break}
							Default {$tmp = "TWAIN compression level could not be determined: $($Setting.TwainCompressionLevel.Value)"; Break}
						}

						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\USB Devices"
					If((validStateProp $Setting ClientUsbDeviceOptimizationRules State ) -and ($Setting.ClientUsbDeviceOptimizationRules.State -ne "NotConfigured"))
					{
						$txt = "ICA\USB devices\Client USB device optimization rules"
						If(validStateProp $Setting ClientUsbDeviceOptimizationRules Values )
						{
							$array = $Setting.ClientUsbDeviceOptimizationRules.Values
							$tmp = $array[0]
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}

							$txt = ""
							$cnt = -1
							ForEach($element in $array)
							{
								$cnt++
								
								If($cnt -ne 0)
								{
									$tmp = "$($element) "
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$array = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Client USB device optimization rules were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}
						}
					}
					If((validStateProp $Setting UsbDeviceRedirection State ) -and ($Setting.UsbDeviceRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\USB devices\Client USB device redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UsbDeviceRedirection.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UsbDeviceRedirection.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UsbDeviceRedirection.State 
						}
					}
					If((validStateProp $Setting UsbDeviceRedirectionRules State ) -and ($Setting.UsbDeviceRedirectionRules.State -ne "NotConfigured"))
					{
						$txt = "ICA\USB devices\Client USB device redirection rules"
						If(validStateProp $Setting UsbDeviceRedirectionRules Values )
						{
							$array = $Setting.UsbDeviceRedirectionRules.Values
							$tmp = $array[0]
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}

							$txt = ""
							$cnt = -1
							ForEach($element in $array)
							{
								$cnt++
								
								If($cnt -ne 0)
								{
									$tmp = "$($element) "
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$array = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Client USB device redirections rules were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}
						}
					}
					If((validStateProp $Setting UsbPlugAndPlayRedirection State ) -and ($Setting.UsbPlugAndPlayRedirection.State -ne "NotConfigured"))
					{
						$txt = "ICA\USB devices\Client USB Plug and Play device redirection"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.UsbPlugAndPlayRedirection.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.UsbPlugAndPlayRedirection.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.UsbPlugAndPlayRedirection.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Visual Display"
					If((validStateProp $Setting PreferredColorDepthForSimpleGraphics State ) -and ($Setting.PreferredColorDepthForSimpleGraphics.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Preferred color depth for simple graphics"
						$tmp = ""
						Switch ($Setting.PreferredColorDepthForSimpleGraphics.Value)
						{
							"ColorDepth24Bit"	{$tmp = "24 bits per pixel"; Break}
							"ColorDepth16Bit"	{$tmp = "16 bits per pixel"; Break}
							"ColorDepth8Bit"	{$tmp = "8 bits per pixel"; Break}
							"Default" {$tmp = "Preferred color depth for simple graphics could not be determined: $($Setting.PreferredColorDepthForSimpleGraphics.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting FramesPerSecond State ) -and ($Setting.FramesPerSecond.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Target frame rate (fps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FramesPerSecond.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FramesPerSecond.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FramesPerSecond.Value 
						}
					}
					If((validStateProp $Setting VisualQuality State ) -and ($Setting.VisualQuality.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Visual quality"
						$tmp = ""
						Switch ($Setting.VisualQuality.Value)
						{
							"BuildToLossless"	{$tmp = "Build to Lossless"; Break}
							"AlwaysLossless"	{$tmp = "Always Lossless"; Break}
							"High"				{$tmp = "High"; Break}
							"Medium"			{$tmp = "Medium"; Break}
							"Low"				{$tmp = "Low"; Break}
							"Default" {$tmp = "Visual quality could not be determined: $($Setting.VisualQuality.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Visual Display\Moving Images"
					If((validStateProp $Setting MinimumAdaptiveDisplayJpegQuality State ) -and ($Setting.MinimumAdaptiveDisplayJpegQuality.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Moving Images\Minimum image quality"
						$tmp = ""
						Switch ($Setting.MinimumAdaptiveDisplayJpegQuality.Value)
						{
							"UltraHigh" {$tmp = "Ultra high"; Break}
							"VeryHigh"  {$tmp = "Very high"; Break}
							"High"      {$tmp = "High"; Break}
							"Normal"    {$tmp = "Normal"; Break}
							"Low"       {$tmp = "Low"; Break}
							Default {$tmp = "Minimum image quality could not be determined: $($Setting.MinimumAdaptiveDisplayJpegQuality.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting MovingImageCompressionConfiguration State ) -and ($Setting.MovingImageCompressionConfiguration.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Moving Images\Moving Image Compression"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MovingImageCompressionConfiguration.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MovingImageCompressionConfiguration.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MovingImageCompressionConfiguration.State 
						}
					}
					If((validStateProp $Setting ProgressiveCompressionLevel State ) -and ($Setting.ProgressiveCompressionLevel.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Moving Images\Progressive compression level"
						$tmp = ""
						Switch ($Setting.ProgressiveCompressionLevel.Value)
						{
							"UltraHigh" {$tmp = "Ultra high"; Break}
							"VeryHigh"  {$tmp = "Very high"; Break}
							"High"      {$tmp = "High"; Break}
							"Normal"    {$tmp = "Normal"; Break}
							"Low"       {$tmp = "Low"; Break}
							"None"      {$tmp = "None"; Break}
							Default {$tmp = "Progressive compression level could not be determined: $($Setting.ProgressiveCompressionLevel.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting ProgressiveCompressionThreshold State ) -and ($Setting.ProgressiveCompressionThreshold.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Moving Images\Progressive compression threshold value (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProgressiveCompressionThreshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProgressiveCompressionThreshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProgressiveCompressionThreshold.Value 
						}
					}
					If((validStateProp $Setting TargetedMinimumFramesPerSecond State ) -and ($Setting.TargetedMinimumFramesPerSecond.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Moving Images\Target Minimum Frame Rate (fps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TargetedMinimumFramesPerSecond.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TargetedMinimumFramesPerSecond.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TargetedMinimumFramesPerSecond.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\Visual Display\Still Images"
					If((validStateProp $Setting ExtraColorCompression State ) -and ($Setting.ExtraColorCompression.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Still Images\Extra Color Compression"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ExtraColorCompression.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ExtraColorCompression.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ExtraColorCompression.State 
						}
					}
					If((validStateProp $Setting ExtraColorCompressionThreshold State ) -and ($Setting.ExtraColorCompressionThreshold.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Still Images\Extra Color Compression Threshold (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ExtraColorCompressionThreshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ExtraColorCompressionThreshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ExtraColorCompressionThreshold.Value 
						}
					}
					If((validStateProp $Setting ProgressiveHeavyweightCompression State ) -and ($Setting.ProgressiveHeavyweightCompression.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Still Images\Heavyweight compression"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProgressiveHeavyweightCompression.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProgressiveHeavyweightCompression.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProgressiveHeavyweightCompression.State 
						}
					}
					If((validStateProp $Setting LossyCompressionLevel State ) -and ($Setting.LossyCompressionLevel.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Still Images\Lossy compression level"
						$tmp = ""
						Switch ($Setting.LossyCompressionLevel.Value)
						{
							"None"   {$tmp = "None"; Break}
							"Low"    {$tmp = "Low"; Break}
							"Medium" {$tmp = "Medium"; Break}
							"High"   {$tmp = "High"; Break}
							Default {$tmp = "Lossy compression level could not be determined: $($Setting.LossyCompressionLevel.Value)"; Break}
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}
					If((validStateProp $Setting LossyCompressionThreshold State ) -and ($Setting.LossyCompressionThreshold.State -ne "NotConfigured"))
					{
						$txt = "ICA\Visual Display\Still Images\Lossy compression threshold value (Kbps)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LossyCompressionThreshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LossyCompressionThreshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LossyCompressionThreshold.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tICA\WebSockets"
					If((validStateProp $Setting AcceptWebSocketsConnections State ) -and ($Setting.AcceptWebSocketsConnections.State -ne "NotConfigured"))
					{
						$txt = "ICA\WebSockets\WebSocket connections"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.AcceptWebSocketsConnections.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.AcceptWebSocketsConnections.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.AcceptWebSocketsConnections.State 
						}
					}
					If((validStateProp $Setting WebSocketsPort State ) -and ($Setting.WebSocketsPort.State -ne "NotConfigured"))
					{
						$txt = "ICA\WebSockets\WebSockets port number"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.WebSocketsPort.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.WebSocketsPort.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.WebSocketsPort.Value 
						}
					}
					If((validStateProp $Setting WSTrustedOriginServerList State ) -and ($Setting.WSTrustedOriginServerList.State -ne "NotConfigured"))
					{
						$txt = "ICA\WebSockets\WebSockets trusted origin server list"
						$tmpArray = $Setting.WSTrustedOriginServerList.Value.Split(",")
						$tmp = ""
						$cnt = 0
						ForEach($Thing in $tmpArray)
						{
							$cnt++
							$tmp = "$($Thing)"
							If($cnt -eq 1)
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
							Else
							{
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
							}
						}
						$tmp = " "
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = "";
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting "" $tmp
						}
						$tmpArray = $Null
						$tmp = $Null
					}
					
					Write-Verbose "$(Get-Date): `t`t`tLoad Management"
					If((validStateProp $Setting ConcurrentLogonsTolerance State ) -and ($Setting.ConcurrentLogonsTolerance.State -ne "NotConfigured"))
					{
						$txt = "Load Management\Concurrent logons tolerance"
						If($Setting.ConcurrentLogonsTolerance.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ConcurrentLogonsTolerance.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ConcurrentLogonsTolerance.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ConcurrentLogonsTolerance.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ConcurrentLogonsTolerance.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ConcurrentLogonsTolerance.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ConcurrentLogonsTolerance.State 
							}
						}
					}
					If((validStateProp $Setting CPUUsage State ) -and ($Setting.CPUUsage.State -ne "NotConfigured"))
					{
						$txt = "Load Management\CPU usage"
						$tmp = ""
						If($Setting.CPUUsage.State -eq "Enabled")
						{
							If($Setting.CPUUsage.Value -eq -1)
							{
								$tmp = "Disabled"
							}
							Else
							{
								$tmp = "Report full load $($Setting.CPUUsage.Value)(%)"
							}
						}
						Else
						{
							$tmp = "Disabled"
						}
						If($MSWord -or $PDF)
						{
							If($Setting.CPUUsage.State -eq "Enabled")
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
							}
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp
						}
					}
					If((validStateProp $Setting CPUUsageExcludedProcessPriority State ) -and ($Setting.CPUUsageExcludedProcessPriority.State -ne "NotConfigured"))
					{
						$txt = "Load Management\CPU usage excluded process priority"
						If($Setting.CPUUsageExcludedProcessPriority.State -eq "Enabled")
						{
							$tmp = ""
							Switch ($Setting.CPUUsageExcludedProcessPriority.Value)
							{
								"BelowNormalOrLow"	{$tmp = "Below Normal or Low"; Break}
								"Low"				{$tmp = "Low"; Break}
								Default {$tmp = "CPU usage excluded process priority could not be determined: $($Setting.CPUUsageExcludedProcessPriority.Value)"; Break}
							}
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPUUsageExcludedProcessPriority.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPUUsageExcludedProcessPriority.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPUUsageExcludedProcessPriority.State 
							}
						}
					}
					If((validStateProp $Setting DiskUsage State ) -and ($Setting.DiskUsage.State -ne "NotConfigured"))
					{
						$txt = "Load Management\Disk usage"
						$tmp = ""
						If($Setting.DiskUsage.State -eq "Enabled")
						{
							If($Setting.DiskUsage.Value -eq -1)
							{
								$tmp = "Disabled"
							}
							Else
							{
								$tmp = "Report 75% load (disk queue length): $($Setting.DiskUsage.Value)"
							}
						}
						Else
						{
							$tmp = "Disabled"
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting MaximumNumberOfSessions State ) -and ($Setting.MaximumNumberOfSessions.State -ne "NotConfigured"))
					{
						If($Setting.MaximumNumberOfSessions.State -eq "Enabled")
						{
							$txt = "Load Management\Maximum number of sessions - Limit"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.MaximumNumberOfSessions.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.MaximumNumberOfSessions.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.MaximumNumberOfSessions.Value 
							}
						}
						Else
						{
							$txt = "Load Management\Maximum number of sessions"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.MaximumNumberOfSessions.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.MaximumNumberOfSessions.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.MaximumNumberOfSessions.Value 
							}
						}
					}
					If((validStateProp $Setting MemoryUsage State ) -and ($Setting.MemoryUsage.State -ne "NotConfigured"))
					{
						$txt = "Load Management\Memory usage"
						$tmp = ""
						If($Setting.MemoryUsage.State -eq "Enabled")
						{
							If($Setting.MemoryUsage.Value -eq -1)
							{
								$tmp = "Disabled"
							}
							Else
							{
								$tmp = "Report full load (%): $($Setting.MemoryUsage.Value)"
							}
						}
						Else
						{
							$tmp = "Disabled"
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting MemoryUsageBaseLoad State ) -and ($Setting.MemoryUsageBaseLoad.State -ne "NotConfigured"))
					{
						$txt = "Load Management\Memory usage base load"
						$tmp = ""
						If($Setting.MemoryUsageBaseLoad.State -eq "Enabled")
						{
							$tmp = "Report zero load (MBs): $($Setting.MemoryUsageBaseLoad.Value)"
						}
						Else
						{
							$tmp = "Disabled"
						}
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management"
					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Advanced settings"
					If((validStateProp $Setting DisableDynamicConfig State ) -and ($Setting.DisableDynamicConfig.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Advanced settings\Disable automatic configuration"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DisableDynamicConfig.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DisableDynamicConfig.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DisableDynamicConfig.State
						}
					}
					If((validStateProp $Setting LogoffRatherThanTempProfile State ) -and ($Setting.LogoffRatherThanTempProfile.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Advanced settings\Log off user if a problem is encountered"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogoffRatherThanTempProfile.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogoffRatherThanTempProfile.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogoffRatherThanTempProfile.State
						}
					}
					If((validStateProp $Setting LoadRetries_Part State ) -and ($Setting.LoadRetries_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Advanced settings\Number of retries when accessing locked files"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LoadRetries_Part.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LoadRetries_Part.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LoadRetries_Part.Value 
						}
					}
					If((validStateProp $Setting ProcessCookieFiles State ) -and ($Setting.ProcessCookieFiles.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Advanced settings\Process Internet cookie files on logoff"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProcessCookieFiles.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProcessCookieFiles.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProcessCookieFiles.State
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Basic settings"
					If((validStateProp $Setting PSMidSessionWriteBack State ) -and ($Setting.PSMidSessionWriteBack.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Active write back"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PSMidSessionWriteBack.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PSMidSessionWriteBack.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PSMidSessionWriteBack.State
						}
					}
					If((validStateProp $Setting ServiceActive State ) -and ($Setting.ServiceActive.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Enable Profile management"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ServiceActive.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ServiceActive.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ServiceActive.State
						}
					}
					If((validStateProp $Setting ExcludedGroups_Part State ) -and ($Setting.ExcludedGroups_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Excluded groups"
						If($Setting.ExcludedGroups_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting ExcludedGroups_Part Values )
							{
								$tmpArray = $Setting.ExcludedGroups_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Excluded groups were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ExcludedGroups_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ExcludedGroups_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ExcludedGroups_Part.State
							}
						}
					}
					If((validStateProp $Setting OfflineSupport State ) -and ($Setting.OfflineSupport.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Offline profile support"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.OfflineSupport.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.OfflineSupport.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.OfflineSupport.State
						}
					}
					If((validStateProp $Setting DATPath_Part State ) -and ($Setting.DATPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Path to user store"
						If($Setting.DATPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.DATPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.DATPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.DATPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.DATPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.DATPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.DATPath_Part.State
							}
						}
					}
					If((validStateProp $Setting ProcessAdmins State ) -and ($Setting.ProcessAdmins.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Process logons of local administrators"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProcessAdmins.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProcessAdmins.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProcessAdmins.State
						}
					}
					If((validStateProp $Setting ProcessedGroups_Part State ) -and ($Setting.ProcessedGroups_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Basic settings\Processed groups"
						If($Setting.ProcessedGroups_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting ProcessedGroups_Part Values )
							{
								$tmpArray = $Setting.ProcessedGroups_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Processed groups were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}	
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ProcessedGroups_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ProcessedGroups_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ProcessedGroups_Part.State
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Cross-Platform settings"
					If((validStateProp $Setting CPUserGroups_Part State ) -and ($Setting.CPUserGroups_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Cross-Platform settings\Cross-platform settings user groups"
						If($Setting.CPUserGroups_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting CPUserGroups_Part Values )
							{
								$tmpArray = $Setting.CPUserGroups_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Cross-platform settings user groups were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPUserGroups_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPUserGroups_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPUserGroups_Part.State
							}
						}
					}
					If((validStateProp $Setting CPEnable State ) -and ($Setting.CPEnable.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Cross-Platform settings\Enable cross-platform settings"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.CPEnable.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.CPEnable.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.CPEnable.State
						}
					}
					If((validStateProp $Setting CPSchemaPathData State ) -and ($Setting.CPSchemaPathData.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Cross-Platform settings\Path to cross-platform definitions"
						If($Setting.CPSchemaPathData.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPSchemaPathData.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPSchemaPathData.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPSchemaPathData.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPSchemaPathData.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPSchemaPathData.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPSchemaPathData.State
							}
						}
					}
					If((validStateProp $Setting CPPathData State ) -and ($Setting.CPPathData.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Cross-Platform settings\Path to cross-platform settings store"
						If($Setting.CPPathData.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPPathData.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPPathData.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPPathData.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.CPPathData.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.CPPathData.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.CPPathData.State
							}
						}
					}
					If((validStateProp $Setting CPMigrationFromBaseProfileToCPStore State ) -and ($Setting.CPMigrationFromBaseProfileToCPStore.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Cross-Platform settings\Source for creating cross-platform settings"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.CPMigrationFromBaseProfileToCPStore.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.CPMigrationFromBaseProfileToCPStore.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.CPMigrationFromBaseProfileToCPStore.State
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\File system"
					Write-Verbose "$(Get-Date): `t`t`tProfile Management\File system\Exclusions"
					If((validStateProp $Setting ExclusionListSyncDir_Part State ) -and ($Setting.ExclusionListSyncDir_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\File system\Exclusions\Exclusion list - directories"
						If($Setting.ExclusionListSyncDir_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting ExclusionListSyncDir_Part Values )
							{
								$tmpArray = $Setting.ExclusionListSyncDir_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Exclusion list - directories were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ExclusionListSyncDir_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ExclusionListSyncDir_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ExclusionListSyncDir_Part.State
							}
						}
					}
					If((validStateProp $Setting ExclusionListSyncFiles_Part State ) -and ($Setting.ExclusionListSyncFiles_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\File system\Exclusions\Exclusion list - files"
						If($Setting.ExclusionListSyncFiles_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting ExclusionListSyncFiles_Part Values )
							{
								$tmpArray = $Setting.ExclusionListSyncFiles_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Exclusion list - files were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ExclusionListSyncFiles_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ExclusionListSyncFiles_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ExclusionListSyncFiles_Part.State
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\File system\Synchronization"
					If((validStateProp $Setting SyncDirList_Part State ) -and ($Setting.SyncDirList_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\File system\Synchronization\Directories to synchronize"
						If($Setting.SyncDirList_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting SyncDirList_Part Values )
							{
								$tmpArray = $Setting.SyncDirList_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Directories to synchronize were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.SyncDirList_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.SyncDirList_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.SyncDirList_Part.State
							}
						}
					}
					If((validStateProp $Setting SyncFileList_Part State ) -and ($Setting.SyncFileList_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\File system\Synchronization\Files to synchronize"
						If($Setting.SyncFileList_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting SyncFileList_Part Values )
							{
								$tmpArray = $Setting.SyncFileList_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Files to synchronize were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.SyncFileList_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.SyncFileList_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.SyncFileList_Part.State
							}
						}
					}
					If((validStateProp $Setting MirrorFoldersList_Part State ) -and ($Setting.MirrorFoldersList_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\File system\Synchronization\Folders to mirror"
						If($Setting.MirrorFoldersList_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting MirrorFoldersList_Part Values )
							{
								$tmpArray = $Setting.MirrorFoldersList_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Folders to mirror were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.MirrorFoldersList_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.MirrorFoldersList_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.MirrorFoldersList_Part.State
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection"
					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\AppData(Roaming)"
					If((validStateProp $Setting FRAppDataPath_Part State ) -and ($Setting.FRAppDataPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\AppData(Roaming)\AppData(Roaming) path"
						If($Setting.FRAppDataPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRAppDataPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRAppDataPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRAppDataPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRAppDataPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRAppDataPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRAppDataPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRAppData_Part State ) -and ($Setting.FRAppData_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\AppData(Roaming)\Redirection settings for AppData(Roaming)"
						$tmp = ""
						Switch ($Setting.FRAppData_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRAppData_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Common settings"
					If((validStateProp $Setting FRAdminAccess_Part State ) -and ($Setting.FRAdminAccess_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Common settings\Grant administrator access"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FRAdminAccess_Part.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FRAdminAccess_Part.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FRAdminAccess_Part.State
						}
					}
					If((validStateProp $Setting FRIncDomainName_Part State ) -and ($Setting.FRIncDomainName_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Common settings\Include domain name"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.FRIncDomainName_Part.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.FRIncDomainName_Part.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.FRIncDomainName_Part.State
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Contacts"
					If((validStateProp $Setting FRContactsPath_Part State ) -and ($Setting.FRContactsPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Contacts\Contacts path"
						If($Setting.FRContactsPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRContactsPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRContactsPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRContactsPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRContactsPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRContactsPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRContactsPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRContacts_Part State ) -and ($Setting.FRContacts_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Contacts\Redirection settings for Contacts"
						$tmp = ""
						Switch ($Setting.FRContacts_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRContacts_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Desktop"
					If((validStateProp $Setting FRDesktopPath_Part State ) -and ($Setting.FRDesktopPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Desktop\Desktop path"
						If($Setting.FRDesktopPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDesktopPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDesktopPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDesktopPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDesktopPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDesktopPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDesktopPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRDesktop_Part State ) -and ($Setting.FRDesktop_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Desktop\Redirection settings for Desktop"
						$tmp = ""
						Switch ($Setting.FRDesktop_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRDesktop_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Documents"
					If((validStateProp $Setting FRDocumentsPath_Part State ) -and ($Setting.FRDocumentsPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Documents\Documents path"
						If($Setting.FRDocumentsPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDocumentsPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDocumentsPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDocumentsPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDocumentsPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDocumentsPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDocumentsPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRDocuments_Part State ) -and ($Setting.FRDocuments_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Documents\Redirection settings for Documents"
						$tmp = ""
						Switch ($Setting.FRDocuments_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRDocuments_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Downloads"
					If((validStateProp $Setting FRDownloadsPath_Part State ) -and ($Setting.FRDownloadsPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Downloads\Downloads path"
						If($Setting.FRDownloadsPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDownloadsPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDownloadsPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDownloadsPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRDownloadsPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRDownloadsPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRDownloadsPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRDownloads_Part State ) -and ($Setting.FRDownloads_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Downloads\Redirection settings for Downloads"
						$tmp = ""
						Switch ($Setting.FRDownloads_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRDownloads_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Favorites"
					If((validStateProp $Setting FRFavoritesPath_Part State ) -and ($Setting.FRFavoritesPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Favorites\Favorites path"
						If($Setting.FRFavoritesPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRFavoritesPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRFavoritesPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRFavoritesPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRFavoritesPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRFavoritesPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRFavoritesPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRFavorites_Part State ) -and ($Setting.FRFavorites_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Favorites\Redirection settings for Favorites"
						$tmp = ""
						Switch ($Setting.FRFavorites_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRFavorites_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Links"
					If((validStateProp $Setting FRLinksPath_Part State ) -and ($Setting.FRLinksPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Links\Links path"
						If($Setting.FRLinksPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRLinksPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRLinksPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRLinksPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRLinksPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRLinksPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRLinksPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRLinks_Part State ) -and ($Setting.FRLinks_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Links\Redirection settings for Links"
						$tmp = ""
						Switch ($Setting.FRLinks_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRLinks_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Music"
					If((validStateProp $Setting FRMusicPath_Part State ) -and ($Setting.FRMusicPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Music\Music path"
						If($Setting.FRMusicPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRMusicPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRMusicPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRMusicPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRMusicPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRMusicPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRMusicPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRMusic_Part State ) -and ($Setting.FRMusic_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Music\Redirection settings for Music"
						$tmp = ""
						Switch ($Setting.FRMusic_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRMusic_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Pictures"
					If((validStateProp $Setting FRPicturesPath_Part State ) -and ($Setting.FRPicturesPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Pictures\Pictures path"
						If($Setting.FRPicturesPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRPicturesPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRPicturesPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRPicturesPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRPicturesPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRPicturesPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRPicturesPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRPictures_Part State ) -and ($Setting.FRPictures_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Pictures\Redirection settings for Pictures"
						$tmp = ""
						Switch ($Setting.FRPictures_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRPictures_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Saved Games"
					If((validStateProp $Setting FRSavedGamesPath_Part State ) -and ($Setting.FRSavedGamesPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Saved Games\Saved Games path"
						If($Setting.FRSavedGamesPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRSavedGamesPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRSavedGamesPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRSavedGamesPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRSavedGamesPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRSavedGamesPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRSavedGamesPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRSavedGames_Part State ) -and ($Setting.FRSavedGames_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Saved Games\Redirection settings for Saved Games"
						$tmp = ""
						Switch ($Setting.FRSavedGames_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRSavedGames_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Searches"
					If((validStateProp $Setting FRSearchesPath_Part State ) -and ($Setting.FRSearchesPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Searches\Searches path"
						If($Setting.FRSearchesPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRSearchesPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRSearchesPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRSearchesPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRSearchesPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRSearchesPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRSearchesPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRSearches_Part State ) -and ($Setting.FRSearches_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Searches\Redirection settings for Searches"
						$tmp = ""
						Switch ($Setting.FRSearches_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRSearches_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Start Menu"
					If((validStateProp $Setting FRStartMenuPath_Part State ) -and ($Setting.FRStartMenuPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Start Menu\Start Menu path"
						If($Setting.FRStartMenuPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRStartMenuPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRStartMenuPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRStartMenuPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRStartMenuPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRStartMenuPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRStartMenuPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRStartMenu_Part State ) -and ($Setting.FRStartMenu_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Start Menu\Redirection settings for Start Menu"
						$tmp = ""
						Switch ($Setting.FRStartMenu_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRStartMenu_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Folder Redirection\Videos"
					If((validStateProp $Setting FRVideosPath_Part State ) -and ($Setting.FRVideosPath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Videos\Videos path"
						If($Setting.FRVideosPath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRVideosPath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRVideosPath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRVideosPath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.FRVideosPath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.FRVideosPath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.FRVideosPath_Part.State
							}
						}
					}
					If((validStateProp $Setting FRVideos_Part State ) -and ($Setting.FRVideos_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Folder Redirection\Videos\Redirection settings for Videos"
						$tmp = ""
						Switch ($Setting.FRVideos_Part.Value)
						{
							"RedirectUncPath"			{$tmp = "Redirect to the following UNC path"; Break}
							"RedirectRelativeDocuments" {$tmp = "Redirect relative to Documents folder"; Break}
							Default {$tmp = "AppData(Roaming) path cannot be determined: $($Setting.FRVideos_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Log settings"
					If((validStateProp $Setting LogLevel_ActiveDirectoryActions State ) -and ($Setting.LogLevel_ActiveDirectoryActions.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Active Directory actions"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_ActiveDirectoryActions.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_ActiveDirectoryActions.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_ActiveDirectoryActions.State
						}
					}
					If((validStateProp $Setting LogLevel_Information State ) -and ($Setting.LogLevel_Information.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Common information"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_Information.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_Information.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_Information.State
						}
					}
					If((validStateProp $Setting LogLevel_Warnings State ) -and ($Setting.LogLevel_Warnings.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Common warnings"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_Warnings.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_Warnings.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_Warnings.State
						}
					}
					If((validStateProp $Setting DebugMode State ) -and ($Setting.DebugMode.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Enable logging"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DebugMode.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DebugMode.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DebugMode.State
						}
					}
					If((validStateProp $Setting LogLevel_FileSystemActions State ) -and ($Setting.LogLevel_FileSystemActions.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\File system actions"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_FileSystemActions.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_FileSystemActions.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_FileSystemActions.State
						}
					}
					If((validStateProp $Setting LogLevel_FileSystemNotification State ) -and ($Setting.LogLevel_FileSystemNotification.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\File system notifications"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_FileSystemNotification.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_FileSystemNotification.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_FileSystemNotification.State
						}
					}
					If((validStateProp $Setting LogLevel_Logoff State ) -and ($Setting.LogLevel_Logoff.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Logoff"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_Logoff.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_Logoff.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_Logoff.State
						}
					}
					If((validStateProp $Setting LogLevel_Logon State ) -and ($Setting.LogLevel_Logon.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Logon"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_Logon.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_Logon.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_Logon.State
						}
					}
					If((validStateProp $Setting MaxLogSize_Part State ) -and ($Setting.MaxLogSize_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Maximum size of the log file (bytes)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.MaxLogSize_Part.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.MaxLogSize_Part.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.MaxLogSize_Part.Value 
						}
					}
					If((validStateProp $Setting DebugFilePath_Part State ) -and ($Setting.DebugFilePath_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Path to log file"
						If($Setting.DebugFilePath_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.DebugFilePath_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.DebugFilePath_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.DebugFilePath_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.DebugFilePath_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.DebugFilePath_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.DebugFilePath_Part.State
							}
						}
					}
					If((validStateProp $Setting LogLevel_UserName State ) -and ($Setting.LogLevel_UserName.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Personalized user information"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_UserName.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_UserName.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_UserName.State
						}
					}
					If((validStateProp $Setting LogLevel_PolicyUserLogon State ) -and ($Setting.LogLevel_PolicyUserLogon.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Policy values at logon and logoff"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_PolicyUserLogon.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_PolicyUserLogon.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_PolicyUserLogon.State
						}
					}
					If((validStateProp $Setting LogLevel_RegistryActions State ) -and ($Setting.LogLevel_RegistryActions.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Registry actions"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_RegistryActions.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_RegistryActions.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_RegistryActions.State
						}
					}
					If((validStateProp $Setting LogLevel_RegistryDifference State ) -and ($Setting.LogLevel_RegistryDifference.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Log settings\Registry differences at logoff"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.LogLevel_RegistryDifference.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.LogLevel_RegistryDifference.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.LogLevel_RegistryDifference.State
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Profile handling"
					If((validStateProp $Setting ProfileDeleteDelay_Part State ) -and ($Setting.ProfileDeleteDelay_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Delay before deleting cached profiles"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProfileDeleteDelay_Part.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProfileDeleteDelay_Part.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProfileDeleteDelay_Part.Value 
						}
					}
					If((validStateProp $Setting DeleteCachedProfilesOnLogoff State ) -and ($Setting.DeleteCachedProfilesOnLogoff.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Delete locally cached profiles on logoff"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.DeleteCachedProfilesOnLogoff.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.DeleteCachedProfilesOnLogoff.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.DeleteCachedProfilesOnLogoff.State
						}
					}
					If((validStateProp $Setting LocalProfileConflictHandling_Part State ) -and ($Setting.LocalProfileConflictHandling_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Local profile conflict handling"
						$tmp = ""
						Switch ($Setting.LocalProfileConflictHandling_Part.Value)
						{
							"Use"		{$tmp = "Use local profile"; Break}
							"Delete"	{$tmp = "Delete local profile"; Break}
							"Rename"	{$tmp = "Rename local profile"; Break}
							Default	{$tmp = "Local profile conflict handling could not be determined: $($Setting.LocalProfileConflictHandling_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting MigrateWindowsProfilesToUserStore_Part State ) -and ($Setting.MigrateWindowsProfilesToUserStore_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Migration of existing profiles"
						$tmp = ""
						Switch ($Setting.MigrateWindowsProfilesToUserStore_Part.Value)
						{
							"All"		{$tmp = "Local and Roaming"; Break}
							"Local"		{$tmp = "Local"; Break}
							"Roaming"	{$tmp = "Roaming"; Break}
							"None"		{$tmp = "None"; Break}
							Default	{$tmp = "Migration of existing profiles could not be determined: $($Setting.MigrateWindowsProfilesToUserStore_Part.Value)"; Break}
						}
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
					}
					If((validStateProp $Setting TemplateProfilePath State ) -and ($Setting.TemplateProfilePath.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Path to the template profile"
						If($Setting.TemplateProfilePath.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.TemplateProfilePath.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.TemplateProfilePath.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.TemplateProfilePath.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.TemplateProfilePath.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.TemplateProfilePath.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.TemplateProfilePath.State
							}
						}
					}
					If((validStateProp $Setting TemplateProfileOverridesLocalProfile State ) -and ($Setting.TemplateProfileOverridesLocalProfile.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Template profile overrides local profile"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TemplateProfileOverridesLocalProfile.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TemplateProfileOverridesLocalProfile.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TemplateProfileOverridesLocalProfile.State
						}
					}
					If((validStateProp $Setting TemplateProfileOverridesRoamingProfile State ) -and ($Setting.TemplateProfileOverridesRoamingProfile.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Template profile overrides roaming profile"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TemplateProfileOverridesRoamingProfile.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TemplateProfileOverridesRoamingProfile.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TemplateProfileOverridesRoamingProfile.State
						}
					}
					If((validStateProp $Setting TemplateProfileIsMandatory State ) -and ($Setting.TemplateProfileIsMandatory.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Profile handling\Template profile used as a Citrix mandatory profile for all logons"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.TemplateProfileIsMandatory.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.TemplateProfileIsMandatory.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.TemplateProfileIsMandatory.State 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Registry"
					If((validStateProp $Setting ExclusionList_Part State ) -and ($Setting.ExclusionList_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Registry\Exclusion list"
						If($Setting.ExclusionList_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting ExclusionList_Part Values )
							{
								$tmpArray = $Setting.ExclusionList_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Exclusion list were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.ExclusionList_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.ExclusionList_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.ExclusionList_Part.State
							}
						}
					}
					If((validStateProp $Setting IncludeListRegistry_Part State ) -and ($Setting.IncludeListRegistry_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Registry\Inclusion list"
						If($Setting.IncludeListRegistry_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting IncludeListRegistry_Part Values )
							{
								$tmpArray = $Setting.IncludeListRegistry_Part.Values
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Inclusion list were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.IncludeList_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.IncludeList_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.IncludeList_Part.State
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tProfile Management\Streamed user profiles"
					If((validStateProp $Setting PSAlwaysCache State ) -and ($Setting.PSAlwaysCache.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Streamed user profiles\Always cache"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PSAlwaysCache.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PSAlwaysCache.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PSAlwaysCache.State 
						}
					}
					If((validStateProp $Setting PSAlwaysCache_Part State ) -and ($Setting.PSAlwaysCache_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Streamed user profiles\Always cache size (MB)"
						If($Setting.PSAlwaysCache_Part.State -eq "Enabled")
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.PSAlwaysCache_Part.Value;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.PSAlwaysCache_Part.Value,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.PSAlwaysCache_Part.Value 
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.PSAlwaysCache_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.PSAlwaysCache_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.PSAlwaysCache_Part.State 
							}
						}
					}
					If((validStateProp $Setting PSEnabled State ) -and ($Setting.PSEnabled.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Streamed user profiles\Profile streaming"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PSEnabled.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PSEnabled.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PSEnabled.State 
						}
					}
					If((validStateProp $Setting PSUserGroups_Part State ) -and ($Setting.PSUserGroups_Part.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Streamed user profiles\Streamed user profile groups"
						If($Setting.PSUserGroups_Part.State -eq "Enabled")
						{
							If(validStateProp $Setting PSUserGroups_Part Values )
							{
								$tmpArray = $Setting.PSUserGroups_Part.Values.Split(",")
								$tmp = ""
								$cnt = 0
								ForEach($Thing in $tmpArray)
								{
									$cnt++
									$tmp = "$($Thing)"
									If($cnt -eq 1)
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = $txt;
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											$txt,$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting $txt $tmp
										}
									}
									Else
									{
										If($MSWord -or $PDF)
										{
											$WordTableRowHash = @{
											Text = "";
											Value = $tmp;
											}
											$SettingsWordTable += $WordTableRowHash;
										}
										ElseIf($HTML)
										{
											$rowdata += @(,(
											"",$htmlbold,
											$tmp,$htmlwhite))
										}
										ElseIf($Text)
										{
											OutputPolicySetting "" $tmp
										}
									}
								}
								$tmpArray = $Null
								$tmp = $Null
							}
							Else
							{
								$tmp = "No Streamed user profile groups were found"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp
								}
							}
						}
						Else
						{
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $Setting.PSUserGroups_Part.State;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$Setting.PSUserGroups_Part.State,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $Setting.PSUserGroups_Part.State 
							}
						}
					}
					If((validStateProp $Setting PSPendingLockTimeout State ) -and ($Setting.PSPendingLockTimeout.State -ne "NotConfigured"))
					{
						$txt = "Profile Management\Streamed user profiles\Timeout for pending area lock files (days)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.PSPendingLockTimeout.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.PSPendingLockTimeout.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.PSPendingLockTimeout.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tReceiver"
					If((validStateProp $Setting StorefrontAccountsList State ) -and ($Setting.StorefrontAccountsList.State -ne "NotConfigured"))
					{
						$txt = "Receiver\Storefront accounts list"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = "";
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							"",$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt ""
						}
						$txt = ""
						If(validStateProp $Setting StorefrontAccountsList Values )
						{
							$tmpArray = $Setting.StorefrontAccountsList.Values
							ForEach($Thing in $TmpArray)
							{
								$cnt++
								$xxx = """$($Thing)"""
								[array]$tmp = $xxx.Split(";").replace('"','')
								$tmp1 = "Name: $($tmp[0])"
								$tmp2 = "URL: $($tmp[1])"
								$tmp3 = "State: $($tmp[2])"
								$tmp4 = "Desc: $($tmp[3])"
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp1;
									}
									$SettingsWordTable += $WordTableRowHash
									
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp2;
									}
									$SettingsWordTable += $WordTableRowHash
									
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp3;
									}
									$SettingsWordTable += $WordTableRowHash
									
									$WordTableRowHash = @{
									Text = $txt;
									Value = $tmp4;
									}
									$SettingsWordTable += $WordTableRowHash
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp1,$htmlwhite))
									
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp2,$htmlwhite))
									
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp3,$htmlwhite))
									
									$rowdata += @(,(
									$txt,$htmlbold,
									$tmp4,$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting $txt $tmp1
									OutputPolicySetting $txt $tmp2
									OutputPolicySetting $txt $tmp3
									OutputPolicySetting $txt $tmp4
								}
								$tmp = " "
								If($MSWord -or $PDF)
								{
									$WordTableRowHash = @{
									Text = "";
									Value = $tmp;
									}
									$SettingsWordTable += $WordTableRowHash;
								}
								ElseIf($HTML)
								{
									$rowdata += @(,(
									"",$htmlbold,
									"",$htmlwhite))
								}
								ElseIf($Text)
								{
									OutputPolicySetting "" $tmp
								}
								$xxx = $Null
								$tmp = $Null
								$tmp1 = $Null
								$tmp2 = $Null
								$tmp3 = $Null
								$tmp4 = $Null
							}
							$TmpArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Storefront accounts list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = "";
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								"",$htmlbold,
								"",$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting "" $tmp
							}
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tVirtual Delivery Agent Settings"
					If((validStateProp $Setting ControllerRegistrationPort State ) -and ($Setting.ControllerRegistrationPort.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Controller Registration Port"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ControllerRegistrationPort.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ControllerRegistrationPort.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ControllerRegistrationPort.Value 
						}
					}
					If((validStateProp $Setting ControllerSIDs State ) -and ($Setting.ControllerSIDs.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Controller SIDs"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ControllerSIDs.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ControllerSIDs.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ControllerSIDs.Value 
						}
					}
					If((validStateProp $Setting Controllers State ) -and ($Setting.Controllers.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Controllers"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.Controllers.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.Controllers.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.Controllers.Value 
						}
					}
					If((validStateProp $Setting SiteGUID State ) -and ($Setting.SiteGUID.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Site GUID"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.SiteGUID.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.SiteGUID.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.SiteGUID.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tVirtual Delivery Agent Settings\CPU Usage Monitoring"
					If((validStateProp $Setting CPUUsageMonitoring_Enable State ) -and ($Setting.CPUUsageMonitoring_Enable.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\CPU Usage Monitoring\Enable Monitoring"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.CPUUsageMonitoring_Enable.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.CPUUsageMonitoring_Enable.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.CPUUsageMonitoring_Enable.State 
						}
					}
					If((validStateProp $Setting CPUUsageMonitoring_Period State ) -and ($Setting.CPUUsageMonitoring_Period.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\CPU Usage Monitoring\Monitoring Period (seconds)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.CPUUsageMonitoring_Period.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.CPUUsageMonitoring_Period.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.CPUUsageMonitoring_Period.Value 
						}
					}
					If((validStateProp $Setting CPUUsageMonitoring_Threshold State ) -and ($Setting.CPUUsageMonitoring_Threshold.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\CPU Usage Monitoring\Threshold (percent)"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.CPUUsageMonitoring_Threshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.CPUUsageMonitoring_Threshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.CPUUsageMonitoring_Threshold.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tVirtual Delivery Agent Settings\HDX3DPro"
					If((validStateProp $Setting EnableLossless State ) -and ($Setting.EnableLossless.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\HDX3DPro\EnableLossless"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.EnableLossless.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.EnableLossless.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.EnableLossless.State 
						}
					}
					If((validStateProp $Setting ProGraphicsObj State ) -and ($Setting.ProGraphicsObj.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\HDX3DPro\HDX3DPro Quality Settings"
						$tmp = ""
						$xMin = [math]::floor($Setting.ProGraphicsObj.Value%65536).ToString()
						$xMax = [math]::floor($Setting.ProGraphicsObj.Value/65536).ToString()
						$tmp = "Minimum: $($xMin) Maximum: $($xMax)"
						
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $tmp;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$tmp,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $tmp 
						}
						$tmp = $Null
					}

					Write-Verbose "$(Get-Date): `t`t`tVirtual Delivery Agent Settings\ICA Latency Monitoring"
					If((validStateProp $Setting ICALatencyMonitoring_Enable State ) -and ($Setting.ICALatencyMonitoring_Enable.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\ICA Latency Monitoring\Enable Monitoring"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ICALatencyMonitoring_Enable.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ICALatencyMonitoring_Enable.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ICALatencyMonitoring_Enable.State 
						}
					}
					If((validStateProp $Setting ICALatencyMonitoring_Period State ) -and ($Setting.ICALatencyMonitoring_Period.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\ICA Latency Monitoring\Monitoring Period seconds"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ICALatencyMonitoring_Period.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ICALatencyMonitoring_Period.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ICALatencyMonitoring_Period.Value 
						}
					}
					If((validStateProp $Setting ICALatencyMonitoring_Threshold State ) -and ($Setting.ICALatencyMonitoring_Threshold.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\ICA Latency Monitoring\Threshold milliseconds"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ICALatencyMonitoring_Threshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ICALatencyMonitoring_Threshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ICALatencyMonitoring_Threshold.Value 
						}
					}

					Write-Verbose "$(Get-Date): `t`t`tVirtual Delivery Agent Settings\Profile Load Time Monitoring"
					If((validStateProp $Setting ProfileLoadTimeMonitoring_Enable State ) -and ($Setting.ProfileLoadTimeMonitoring_Enable.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Profile Load Time Monitoring\Enable Monitoring"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProfileLoadTimeMonitoring_Enable.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProfileLoadTimeMonitoring_Enable.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProfileLoadTimeMonitoring_Enable.State 
						}
					}
					If((validStateProp $Setting ProfileLoadTimeMonitoring_Threshold State ) -and ($Setting.ProfileLoadTimeMonitoring_Threshold.State -ne "NotConfigured"))
					{
						$txt = "Virtual Delivery Agent Settings\Profile Load Time Monitoring\Threshold seconds"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.ProfileLoadTimeMonitoring_Threshold.Value;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.ProfileLoadTimeMonitoring_Threshold.Value,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.ProfileLoadTimeMonitoring_Threshold.Value 
						}
					}
					
					Write-Verbose "$(Get-Date): `t`t`tVirtual IP"
					If((validStateProp $Setting VirtualLoopbackSupport State ) -and ($Setting.VirtualLoopbackSupport.State -ne "NotConfigured"))
					{
						$txt = "Virtual IP\Virtual IP loopback support"
						If($MSWord -or $PDF)
						{
							$WordTableRowHash = @{
							Text = $txt;
							Value = $Setting.VirtualLoopbackSupport.State;
							}
							$SettingsWordTable += $WordTableRowHash;
						}
						ElseIf($HTML)
						{
							$rowdata += @(,(
							$txt,$htmlbold,
							$Setting.VirtualLoopbackSupport.State,$htmlwhite))
						}
						ElseIf($Text)
						{
							OutputPolicySetting $txt $Setting.VirtualLoopbackSupport.State 
						}
					}
					If((validStateProp $Setting VirtualLoopbackPrograms State ) -and ($Setting.VirtualLoopbackPrograms.State -ne "NotConfigured"))
					{
						$txt = "Virtual IP\Virtual IP virtual loopback programs list"
						If((validStateProp $Setting VirtualLoopbackPrograms State ) -and ($Setting.VirtualLoopbackPrograms.State -ne "NotConfigured"))
						{
							$tmpArray = $Setting.VirtualLoopbackPrograms.Values
							$array = $Null
							$tmp = ""
							$cnt = 0
							ForEach($Thing in $TmpArray)
							{
								If($Null -eq $Thing)
								{
									$Thing = ''
								}
								$cnt++
								$tmp = "$($Thing) "
								If($cnt -eq 1)
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = $txt;
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										$txt,$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting $txt $tmp
									}
								}
								Else
								{
									If($MSWord -or $PDF)
									{
										$WordTableRowHash = @{
										Text = "";
										Value = $tmp;
										}
										$SettingsWordTable += $WordTableRowHash;
									}
									ElseIf($HTML)
									{
										$rowdata += @(,(
										"",$htmlbold,
										$tmp,$htmlwhite))
									}
									ElseIf($Text)
									{
										OutputPolicySetting "" $tmp
									}
								}
							}
							$TmpArray = $Null
							$tmp = $Null
						}
						Else
						{
							$tmp = "No Virtual IP virtual loopback programs list were found"
							If($MSWord -or $PDF)
							{
								$WordTableRowHash = @{
								Text = $txt;
								Value = $tmp;
								}
								$SettingsWordTable += $WordTableRowHash;
							}
							ElseIf($HTML)
							{
								$rowdata += @(,(
								$txt,$htmlbold,
								$tmp,$htmlwhite))
							}
							ElseIf($Text)
							{
								OutputPolicySetting $txt $tmp
							}
						}
					}
				}
				If($MSWord -or $PDF)
				{
					$Table = AddWordTable -Hashtable $SettingsWordTable `
					-Columns  Text,Value `
					-Headers  "Setting Key","Value"`
					-Format $wdTableLightListAccent3 `
					-NoInternalGridLines `
					-AutoFit $wdAutoFitFixed;

					SetWordCellFormat -Collection $Table -Size 9
					
					SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

					$Table.Columns.Item(1).Width = 300;
					$Table.Columns.Item(2).Width = 200;

					$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

					FindWordDocumentEnd
					$Table = $Null
				}
				ElseIf($Text)
				{
					Line 0 ""
				}
				ElseIf($HTML)
				{
					If($rowdata.count -gt 0)
					{
						$columnHeaders = @(
						'Setting Key',($htmlsilver -bor $htmlbold),
						'Value',($htmlsilver -bor $htmlbold))

						$msg = ""
						$columnWidths = @("400","300")
						FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "700"
						WriteHTMLLine 0 0 " "
					}
				}
			}
			Else
			{
				$txt = "Unable to retrieve settings"
				If($MSWord -or $PDF)
				{
					WriteWordLine 0 1 $txt
				}
				ElseIf($Text)
				{
					Line 2 $txt
				}
				ElseIf($HTML)
				{
					WriteHTMLLine 0 1 $txt
				}
			}
			$Filter = $Null
			$Settings = $Null
			Write-Verbose "$(Get-Date): `t`tFinished $($Policy.PolicyName)"
			Write-Verbose "$(Get-Date): "
		}
	}
	ElseIf(!$?)
	{
		Write-Warning "Citrix Policy information could not be retrieved"
	}
	Else
	{
		Write-Warning "No results Returned for Citrix Policy information"
	}
	
	$Policies = $Null
	Write-Verbose "$(Get-Date): `tRemoving $($xDriveName) PSDrive"
	Remove-PSDrive $xDriveName -EA 0 4>$Null
	Write-Verbose "$(Get-Date): "
}

Function OutputPolicySetting
{
	Param([string] $outputText, [string] $outputData)

	If($outputText -ne "")
	{
		$xLength = $outputText.Length
		If($outputText.Substring($xLength-2,2) -ne ": ")
		{
			$outputText += ": "
		}
	}
	Line 2 $outputText $outputData
}

Function Get-PrinterModifiedSettings
{
	Param([string]$Value, [string]$xelement)
	
	[string]$ReturnStr = ""

	Switch ($Value)
	{
		"copi" 
		{
			$txt="Copies: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				$ReturnStr = "$txt $tmp2"
			}
		}
		"coll"
		{
			$txt="Collate: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				$ReturnStr = "$txt $tmp2"
			}
		}
		"scal"
		{
			$txt="Scale (%): "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				$ReturnStr = "$txt $tmp2"
			}
		}
		"colo"
		{
			$txt="Color: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					1 {$tmp2 = "Monochrome"; Break}
					2 {$tmp2 = "Color"; Break}
					Default {$tmp2 = "Color could not be determined: $($xelement) "; Break}
				}
				$ReturnStr = "$txt $tmp2"
			}
		}
		"prin"
		{
			$txt="Print Quality: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					-1 {$tmp2 = "150 dpi"; Break}
					-2 {$tmp2 = "300 dpi"; Break}
					-3 {$tmp2 = "600 dpi"; Break}
					-4 {$tmp2 = "1200 dpi"; Break}
					Default {$tmp2 = "Custom...X resolution: $tmp1"; Break}
				}
				$ReturnStr = "$txt $tmp2"
			}
		}
		"yres"
		{
			$txt="Y resolution: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				$ReturnStr = "$txt $tmp2"
			}
		}
		"orie"
		{
			$txt="Orientation: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					"portrait"  {$tmp2 = "Portrait"; Break}
					"landscape" {$tmp2 = "Landscape"; Break}
					Default {$tmp2 = "Orientation could not be determined: $($xelement) "; Break}
				}
				$ReturnStr = "$txt $tmp2"
			}
		}
		"dupl"
		{
			$txt="Duplex: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					1 {$tmp2 = "Simplex"; Break}
					2 {$tmp2 = "Vertical"; Break}
					3 {$tmp2 = "Horizontal"; Break}
					Default {$tmp2 = "Duplex could not be determined: $($xelement) "; Break}
				}
				$ReturnStr = "$txt $tmp2"
			}
		}
		"pape"
		{
			$txt="Paper Size: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					1   {$tmp2 = "Letter"; Break}
					2   {$tmp2 = "Letter Small"; Break}
					3   {$tmp2 = "Tabloid"; Break}
					4   {$tmp2 = "Ledger"; Break}
					5   {$tmp2 = "Legal"; Break}
					6   {$tmp2 = "Statement"; Break}
					7   {$tmp2 = "Executive"; Break}
					8   {$tmp2 = "A3"; Break}
					9   {$tmp2 = "A4"; Break}
					10  {$tmp2 = "A4 Small"; Break}
					11  {$tmp2 = "A5"; Break}
					12  {$tmp2 = "B4 (JIS)"; Break}
					13  {$tmp2 = "B5 (JIS)"; Break}
					14  {$tmp2 = "Folio"; Break}
					15  {$tmp2 = "Quarto"; Break}
					16  {$tmp2 = "10X14"; Break}
					17  {$tmp2 = "11X17"; Break}
					18  {$tmp2 = "Note"; Break}
					19  {$tmp2 = "Envelope #9"; Break}
					20  {$tmp2 = "Envelope #10"; Break}
					21  {$tmp2 = "Envelope #11"; Break}
					22  {$tmp2 = "Envelope #12"; Break}
					23  {$tmp2 = "Envelope #14"; Break}
					24  {$tmp2 = "C Size Sheet"; Break}
					25  {$tmp2 = "D Size Sheet"; Break}
					26  {$tmp2 = "E Size Sheet"; Break}
					27  {$tmp2 = "Envelope DL"; Break}
					28  {$tmp2 = "Envelope C5"; Break}
					29  {$tmp2 = "Envelope C3"; Break}
					30  {$tmp2 = "Envelope C4"; Break}
					31  {$tmp2 = "Envelope C6"; Break}
					32  {$tmp2 = "Envelope C65"; Break}
					33  {$tmp2 = "Envelope B4"; Break}
					34  {$tmp2 = "Envelope B5"; Break}
					35  {$tmp2 = "Envelope B6"; Break}
					36  {$tmp2 = "Envelope Italy"; Break}
					37  {$tmp2 = "Envelope Monarch"; Break}
					38  {$tmp2 = "Envelope Personal"; Break}
					39  {$tmp2 = "US Std Fanfold"; Break}
					40  {$tmp2 = "German Std Fanfold"; Break}
					41  {$tmp2 = "German Legal Fanfold"; Break}
					42  {$tmp2 = "B4 (ISO)"; Break}
					43  {$tmp2 = "Japanese Postcard"; Break}
					44  {$tmp2 = "9X11"; Break}
					45  {$tmp2 = "10X11"; Break}
					46  {$tmp2 = "15X11"; Break}
					47  {$tmp2 = "Envelope Invite"; Break}
					48  {$tmp2 = "Reserved - DO NOT USE"; Break}
					49  {$tmp2 = "Reserved - DO NOT USE"; Break}
					50  {$tmp2 = "Letter Extra"; Break}
					51  {$tmp2 = "Legal Extra"; Break}
					52  {$tmp2 = "Tabloid Extra"; Break}
					53  {$tmp2 = "A4 Extra"; Break}
					54  {$tmp2 = "Letter Transverse"; Break}
					55  {$tmp2 = "A4 Transverse"; Break}
					56  {$tmp2 = "Letter Extra Transverse"; Break}
					57  {$tmp2 = "A Plus"; Break}
					58  {$tmp2 = "B Plus"; Break}
					59  {$tmp2 = "Letter Plus"; Break}
					60  {$tmp2 = "A4 Plus"; Break}
					61  {$tmp2 = "A5 Transverse"; Break}
					62  {$tmp2 = "B5 (JIS) Transverse"; Break}
					63  {$tmp2 = "A3 Extra"; Break}
					64  {$tmp2 = "A5 Extra"; Break}
					65  {$tmp2 = "B5 (ISO) Extra"; Break}
					66  {$tmp2 = "A2"; Break}
					67  {$tmp2 = "A3 Transverse"; Break}
					68  {$tmp2 = "A3 Extra Transverse"; Break}
					69  {$tmp2 = "Japanese Double Postcard"; Break}
					70  {$tmp2 = "A6"; Break}
					71  {$tmp2 = "Japanese Envelope Kaku #2"; Break}
					72  {$tmp2 = "Japanese Envelope Kaku #3"; Break}
					73  {$tmp2 = "Japanese Envelope Chou #3"; Break}
					74  {$tmp2 = "Japanese Envelope Chou #4"; Break}
					75  {$tmp2 = "Letter Rotated"; Break}
					76  {$tmp2 = "A3 Rotated"; Break}
					77  {$tmp2 = "A4 Rotated"; Break}
					78  {$tmp2 = "A5 Rotated"; Break}
					79  {$tmp2 = "B4 (JIS) Rotated"; Break}
					80  {$tmp2 = "B5 (JIS) Rotated"; Break}
					81  {$tmp2 = "Japanese Postcard Rotated"; Break}
					82  {$tmp2 = "Double Japanese Postcard Rotated"; Break}
					83  {$tmp2 = "A6 Rotated"; Break}
					84  {$tmp2 = "Japanese Envelope Kaku #2 Rotated"; Break}
					85  {$tmp2 = "Japanese Envelope Kaku #3 Rotated"; Break}
					86  {$tmp2 = "Japanese Envelope Chou #3 Rotated"; Break}
					87  {$tmp2 = "Japanese Envelope Chou #4 Rotated"; Break}
					88  {$tmp2 = "B6 (JIS)"; Break}
					89  {$tmp2 = "B6 (JIS) Rotated"; Break}
					90  {$tmp2 = "12X11"; Break}
					91  {$tmp2 = "Japanese Envelope You #4"; Break}
					92  {$tmp2 = "Japanese Envelope You #4 Rotated"; Break}
					93  {$tmp2 = "PRC 16K"; Break}
					94  {$tmp2 = "PRC 32K"; Break}
					95  {$tmp2 = "PRC 32K(Big)"; Break}
					96  {$tmp2 = "PRC Envelope #1"; Break}
					97  {$tmp2 = "PRC Envelope #2"; Break}
					98  {$tmp2 = "PRC Envelope #3"; Break}
					99  {$tmp2 = "PRC Envelope #4"; Break}
					100 {$tmp2 = "PRC Envelope #5"; Break}
					101 {$tmp2 = "PRC Envelope #6"; Break}
					102 {$tmp2 = "PRC Envelope #7"; Break}
					103 {$tmp2 = "PRC Envelope #8"; Break}
					104 {$tmp2 = "PRC Envelope #9"; Break}
					105 {$tmp2 = "PRC Envelope #10"; Break}
					106 {$tmp2 = "PRC 16K Rotated"; Break}
					107 {$tmp2 = "PRC 32K Rotated"; Break}
					108 {$tmp2 = "PRC 32K(Big) Rotated"; Break}
					109 {$tmp2 = "PRC Envelope #1 Rotated"; Break}
					110 {$tmp2 = "PRC Envelope #2 Rotated"; Break}
					111 {$tmp2 = "PRC Envelope #3 Rotated"; Break}
					112 {$tmp2 = "PRC Envelope #4 Rotated"; Break}
					113 {$tmp2 = "PRC Envelope #5 Rotated"; Break}
					114 {$tmp2 = "PRC Envelope #6 Rotated"; Break}
					115 {$tmp2 = "PRC Envelope #7 Rotated"; Break}
					116 {$tmp2 = "PRC Envelope #8 Rotated"; Break}
					117 {$tmp2 = "PRC Envelope #9 Rotated"; Break}
					Default {$tmp2 = "Paper Size could not be determined: $($xelement) "; Break}
				}
				$ReturnStr = "$txt $tmp2"
			}
		}
		"form"
		{
			$txt="Form Name: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				If($tmp2.length -gt 0)
				{
					$ReturnStr = "$txt $tmp2"
				}
			}
		}
		"true"
		{
			$txt="TrueType: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp1 = $xelement.SubString($index + 1)
				Switch ($tmp1)
				{
					1 {$tmp2 = "Bitmap"; Break}
					2 {$tmp2 = "Download"; Break}
					3 {$tmp2 = "Substitute"; Break}
					4 {$tmp2 = "Outline"; Break}
					Default {$tmp2 = "TrueType could not be determined: $($xelement) "; Break}
				}
			}
			$ReturnStr = "$txt $tmp2"
		}
		"mode" 
		{
			$txt="Printer Model: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				$ReturnStr = "$txt $tmp2"
			}
		}
		"loca" 
		{
			$txt="Location: "
			$index = $xelement.SubString(0).IndexOf('=')
			If($index -ge 0)
			{
				$tmp2 = $xelement.SubString($index + 1)
				If($tmp2.length -gt 0)
				{
					$ReturnStr = "$txt $tmp2"
				}
			}
		}
		Default {$ReturnStr = "Session printer setting could not be determined: $($xelement) "}
	}
	Return $ReturnStr
}

Function GetCtxGPOsInAD
{
	#thanks to the Citrix Engineering Team for pointers and for Michael B. Smith for creating the function
	#updated 07-Nov-13 to work in a Windows Workgroup environment
	Write-Verbose "$(Get-Date): Testing for an Active Directory environment"
	$root = [ADSI]"LDAP://RootDSE"
	If([String]::IsNullOrEmpty($root.PSBase.Name))
	{
		Write-Verbose "$(Get-Date): `tNot in an Active Directory environment"
		$root = $Null
		$xArray = @()
	}
	Else
	{
		Write-Verbose "$(Get-Date): `tIn an Active Directory environment"
		$domainNC = $root.defaultNamingContext.ToString()
		$root = $Null
		$xArray = @()

		$domain = $domainNC.Replace( 'DC=', '' ).Replace( ',', '.' )
		Write-Verbose "$(Get-Date): `tSearching \\$($domain)\sysvol\$($domain)\Policies"
		$sysvolFiles = @()
		$sysvolFiles = Get-ChildItem -Recurse ( '\\' + $domain  + '\sysvol\' + $domain + '\Policies' ) -EA 0
		If($sysvolFiles.Count -eq 0)
		{
			Write-Verbose "$(Get-Date): `tSearch timed out.  Retrying.  Searching \\ + $($domain)\sysvol\$($domain)\Policies a second time."
			$sysvolFiles = Get-ChildItem -Recurse ( '\\' + $domain  + '\sysvol\' + $domain + '\Policies' ) -EA 0
		}
		ForEach( $file in $sysvolFiles )
		{
			If( -not $file.PSIsContainer )
			{
				#$file.FullName  ### name of the policy file
				If( $file.FullName -like "*\Citrix\GroupPolicy\Policies.gpf" )
				{
					#"have match " + $file.FullName ### name of the Citrix policies file
					$array = $file.FullName.Split( '\' )
					If( $array.Length -gt 7 )
					{
						$gp = $array[ 6 ].ToString()
						$gpObject = [ADSI]( "LDAP://" + "CN=" + $gp + ",CN=Policies,CN=System," + $domainNC )
						If(!$xArray.Contains($gpObject.DisplayName))
						{
							$xArray += $gpObject.DisplayName	### name of the group policy object
						}
					}
				}
			}
		}
	}
	Return ,$xArray
}
#endregion

#region Configuration Logging functions
Function ProcessConfigLogging
{
	#do not show config logging if not Details AND
	# if XenDesktop must be Platinum or Enterprise OR
	# if XenApp must be Platinum or Enterprise

	If($Logging)
	{
		If(($Script:XDSite2.ProductCode -eq "XDT" -and ($Script:XDSite2.ProductEdition -eq "PLT" -or $Script:XDSite2.ProductEdition -eq "ENT")) -or `
		($Script:XDSite2.ProductCode -eq "MPS" -and ($Script:XDSite2.ProductEdition -eq "PLT" -or $Script:XDSite2.ProductEdition -eq "ENT")))
		{
			Write-Verbose "$(Get-Date): Processing Configuration Logging"
			$txt1 = "Logging"
			If($MSword -or $PDF)
			{
				$Selection.InsertNewPage()
				WriteWordLine 1 0 $txt1
			}
			ElseIf($Text)
			{
				Line 0 $txt1
				Line 0 "For date range $($StartDate) through $($EndDate)"
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 1 0 $txt1
			}
			
			#preferences
			Write-Verbose "$(Get-Date): `tConfiguration Logging Preferences"
			$results = Get-XDLogging @XDParams1
			
			If($? -and $Null -ne $results)
			{
				OutputConfigLogPreferences $results
			}
			Else
			{
				$txt = "Configuration Logging Preferences could not be retrieved."
				OutputWarning $txt
			}
			
			Write-Verbose "$(Get-Date): `tConfiguration Logging Details"
			$ConfigLogItems = Get-LogHighLevelOperation @XDParams2 -Filter {StartTime -ge $StartDate -and EndTime -le $EndDate} -SortBy "-StartTime"
			If($? -and $Null -ne $ConfigLogItems)
			{
				OutputConfigLog $ConfigLogItems
			}
			ElseIf($? -and ($Null -eq $ConfigLogItems))
			{
				$txt = "There are no Configuration Logging actions recorded for $($StartDate) through $($EndDate)."
				OutputWarning $txt
			}
			Else
			{
				$txt = "Configuration Logging information could not be retrieved."
				OutputWarning $txt
			}
			Write-Verbose "$(Get-Date): "
		}
		Else
		{
			$txt = "Not licensed for Configuration Logging"
			OutputWarning $txt
			Write-Verbose "$(Get-Date): "
		}
	}
}

Function OutputConfigLogPreferences 
{
	#2-Mar-2017 Fix bug reported by P. Ewing

	Param([object] $Preferences)
	
	Write-Verbose "$(Get-Date): `t`tOutput Configuration Logging Preferences"
	
	$LogSQLServerPrincipalName = ""
	$LogSQLServerMirrorName = ""
	$LogDatabaseName = ""
	[string]$dbsize = "Unable to determine database size"
	$LogDBs = Get-LogDataStore @XDParams1

	If($? -and ($Null -ne $LogDBs))
	{
		ForEach($LogDB in $LogDBs)
		{
			If($LogDB.DataStore -eq "Logging")
			{
				$tmp = $LogDB.ConnectionString
				$csitems = $tmp.Split(';')
				ForEach($csitem in $csitems)
				{
					$Pair = $csitem.split('=').trimstart()
					Switch ($Pair[0])
					{
						"Server"					{$LogSQLServerPrincipalName = $Pair[1]; Break}
						"Failover Partner"			{$LogSQLServerMirrorName = $Pair[1]; Break}
						"MultiSubnetFailover"		{$LogSQLServerMirrorName = ""; Break}
						"Database"					{$LogDatabaseName = $Pair[1]; Break}
						"Initial Catalog"			{$LogDatabaseName = $Pair[1]; Break}
					}
				}
			}
		}
	}
	Else
	{
		Write-Warning "Unable to retrieve Configuration Logging Database settings"
	}

	#get database size
	
	If($Script:SQLServerLoaded)
	{
		$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($LogSQLServerPrincipalName)")
		$db = New-Object Microsoft.SqlServer.Management.Smo.Database
		$db = $SQLsrv.Databases.Item("$($LogDatabaseName)")
		[string]$dbsize = "Unable to determine" -f $db.size
		If($Null -ne $db.size)
		{
			[string]$dbsize = "{0:F2} MB" -f $db.size
		}
		ElseIf($Null -eq $db.size -and $LogSQLServerMirrorName -ne "Not Configured")
		{
			$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($LogSQLServerMirrorName)")
			$db = New-Object Microsoft.SqlServer.Management.Smo.Database
			$db = $SQLsrv.Databases.Item("$($LogDatabaseName)")
			If($Null -ne $db.size)
			{
				[string]$dbsize = "{0:F2} MB" -f $db.size
			}
		}
	}
	
	If($Preferences.Enabled -eq "Enabled" -or $Preferences.Enabled -eq "Mandatory")
	{
		$PrefEnabled = "Enabled"
	}
	Else
	{
		$PrefEnabled = "Disabled"
	}
	
	If($Preferences.AllowDisconnectedDatabase -eq $True)
	{
		$PrefSecurity = "Selected"
	}
	Else
	{
		$PrefSecurity = "Not Selected"
	}
	
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $ItemsWordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}

	If($MSWord -or $PDF)
	{
		WriteWordLine 2 0 "Configuration Logging settings"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{Data = $PrefEnabled; Value = ""; }
		$ScriptInformation += @{Data = "   Logging database"; Value = ""; }
		$ScriptInformation += @{Data = "      Database size"; Value = $dbsize; }
		$ScriptInformation += @{Data = "      Server location"; Value = $LogSQLServerPrincipalName; }
		$ScriptInformation += @{Data = "      Database name"; Value = $LogDatabaseName; }
		$ScriptInformation += @{Data = "   Security"; Value = ""; }
		$ScriptInformation += @{Data = "      Allow changes when the database is disconnected"; Value = $PrefSecurity; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Configuration Logging settings"
		Line 1 $PrefEnabled
		Line 2 "Logging database"
		Line 3 "Database size`t: " $dbsize
		Line 3 "Server location`t: " $LogSQLServerPrincipalName
		Line 3 "Database name`t: " $LogDatabaseName
		Line 3 "Security"
		Line 4 "Allow changes when the database is disconnected: " $PrefSecurity
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 2 0 "Configuration Logging settings"
		$rowdata = @()
		$columnHeaders = @($PrefEnabled,($htmlsilver -bor $htmlbold),"",$htmlwhite)
		$rowdata += @(,('   Logging database',($htmlsilver -bor $htmlbold),"",$htmlwhite))
		$rowdata += @(,('      Database size',($htmlsilver -bor $htmlbold),$dbsize,$htmlwhite))
		$rowdata += @(,('      Server location',($htmlsilver -bor $htmlbold),$LogSQLServerPrincipalName,$htmlwhite))
		$rowdata += @(,('      Database name',($htmlsilver -bor $htmlbold),$LogDatabaseName,$htmlwhite))
		$rowdata += @(,('   Security',($htmlsilver -bor $htmlbold),"",$htmlwhite))
		$rowdata += @(,('      Allow changes when the database is disconnected',($htmlsilver -bor $htmlbold),$PrefSecurity,$htmlwhite))
		
		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
}

Function OutputConfigLog
{
	Param([object] $ConfigLogItems)
	
	Write-Verbose "$(Get-Date): `tOutput Configuration Logging"
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $ItemsWordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}
	
	ForEach($Item in $ConfigLogItems)
	{
		$Tmp = $Null
		If($Item.IsSuccessful)
		{
			$Tmp = "Success"
		}
		Else
		{
			$Tmp = "Failed"
		}
		
		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{ 
			Administrator = $Item.User;
			MainTask = $Item.Text;
			Start = $Item.StartTime;
			End = $Item.EndTime;
			Status = $tmp;
			}

			$ItemsWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "Administrator`t: " $Item.User
			Line 1 "Main task`t: " $Item.Text
			Line 1 "Start`t`t: " $Item.StartTime
			Line 1 "End`t`t: " $Item.EndTime
			Line 1 "Status`t`t: " $Tmp
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Item.User,$htmlwhite,
			$Item.Text,$htmlwhite,
			$Item.StartTime,$htmlwhite,
			$Item.EndTime,$htmlwhite,
			$Tmp,$htmlwhite
			))
		}
	}

	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $ItemsWordTable `
		-Columns Administrator, MainTask, Start, End, Status `
		-Headers  "Administrator", "Main task", "Start", "End", "Status" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table -Size 9

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 120;
		$Table.Columns.Item(2).Width = 210;
		$Table.Columns.Item(3).Width = 60;
		$Table.Columns.Item(4).Width = 60;
		$Table.Columns.Item(5).Width = 50;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Administrator',($htmlsilver -bor $htmlbold),
		'Main task',($htmlsilver -bor $htmlbold),
		'Start',($htmlsilver -bor $htmlbold),
		'End',($htmlsilver -bor $htmlbold),
		'Status',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("125","300","150","150","50")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "775"
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region site configuration functions
Function ProcessConfiguration
{
	Write-Verbose "$(Get-Date): Process Configuration Settings"
	OutputSiteSettings
	OutputCEIPSetting
	OutputDatastores
	Write-Verbose "$(Get-Date): "
}

Function OutputSiteSettings
{
	Write-Verbose "$(Get-Date): `tSee if StoreFront is installed on the Controller(s)"
	$DefaultStoreFrontAddress = ""
	If(Get-SFIsStoreFrontInstalled @XDParams1)
	{
		$tmp = Get-SFCluster @XDParams1
		If($? -and ($Null -ne $tmp))
		{
			$DefaultStoreFrontAddress = $tmp.Url
		}
		Else
		{
			Write-Warning "Unable to retrieve StoreFront Cluster information"
		}	
	}

	Write-Verbose "$(Get-Date): `tOutput Site Settings"
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Configuration"
		WriteWordLine 2 0 "Site Settings"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Site name"; Value = $XDSiteName; }
		$ScriptInformation += @{ Data = "Default StoreFront address"; Value = $DefaultStoreFrontAddress; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 0 "Configuration"
		Line 0 ""
		Line 0 "Site Settings"
		Line 0 ""
		Line 1 "Site name: " $XDSiteName
		Line 1 "Default StoreFront address: " $DefaultStoreFrontAddress
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Configuration"
		WriteHTMLLine 2 0 "Site Settings"
		$rowdata = @()
		$columnHeaders = @("Site name",($htmlsilver -bor $htmlbold),$XDSiteName,$htmlwhite)
		$rowdata += @(,('Default StoreFront address',($htmlsilver -bor $htmlbold),$DefaultStoreFrontAddress,$htmlwhite))
		
		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
}

Function OutputCEIPSetting
{
	If($Script:CanDoAnalytics)
	{
		Write-Verbose "$(Get-Date): `tProcessing Customer Experience Improvement Program"
		$Results = Get-AnalyticsSite @XDParams1
		If($? -and ($Null -ne $Results))
		{
			If($Results.Enabled -eq $True)
			{
				$CEIP = "You are currently participating in the Customer Experience Improvement Program"
			}
			Else
			{
				$CEIP = "You are not currently participating in the Customer Experience Improvement Program"
			}
		}
		Else
		{
			Write-Warning "Unable to retrieve CEIP information"
		}	

		If($MSWord -or $PDF)
		{
			WriteWordLine 2 0 "Product Support"
			[System.Collections.Hashtable[]] $CEIPWordTable = @();
			$WordTableRowHash = @{ 
			CEIP = $CEIP;
			}
			$CEIPWordTable += $WordTableRowHash;
			
			$Table = AddWordTable -Hashtable $CEIPWordTable `
			-Columns CEIP `
			-Headers "Citrix Customer Experience Improvement Program" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitContent;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null

			WriteWordLine 0 0 ""
		}
		ElseIf($Text)
		{
			Line 0 "Product Support"
			Line 0 ""
			Line 1 "Citrix Customer Experience Improvement Program: " $CEIP
			Line 0 ""
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 2 0 "Product Support"
			$rowdata = @()
			$rowdata += @(,(
			$CEIP,$htmlwhite))

			$columnHeaders = @(
			'Citrix Customer Experience Improvement Program',($htmlsilver -bor $htmlbold))

			$msg = ""
			FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
			WriteHTMLLine 0 0 " "
		}
	}
}

Function GetSQLVersion
{
	Param([object]$SQLsrv)

	#V1.40 add SQL 2017
	#V1.40 add more info to the Default message
	$Major = $SQLsrv.VersionMajor
	$Minor = $SQLsrv.VersionMinor
	$SQLVer = ""
	$SQLEdition = $SQLsrv.EngineEdition
	Switch ($Major)
	{
		8                          {$SQLVer = "SQL Server 2000"; Break}
		9                          {$SQLVer = "SQL Server 2005"; Break}
		{10 -and $Minor -eq 0}     {$SQLVer = "SQL Server 2008"} #can't do break here
		{10 -and $Minor -eq 50}    {$SQLVer = "SQL Server 2008 R2"} #can't do break here #V1.40.1 fix from 5 to 50
		11                         {$SQLVer = "SQL Server 2012"; Break}
		12                         {$SQLVer = "SQL Server 2014"; Break}
		13                         {$SQLVer = "SQL Server 2016"; Break}
		14                         {$SQLVer = "SQL Server 2017"; Break}
		Default                    {$SQLVer = "Unable to determine SQL Server version. Major: $($Major) Minor: $($Minor) Edition: $($SQLEdition)"; Break}
	}

	Return "$($SQLVer) $($SQLEdition)"
}

Function GetDBCompatibilityLevel
{
	Param([string]$DBCompat)

	#Added in version V1.40
	<#
		https://www.spiria.com/en/blog/web-applications/understanding-sql-server-compatibility-levels
		
		Database Compatibility Level	Description
		140								SQL Server 2017
		130								SQL Server 2016	
		120								SQL Server 2014	
		110								SQL Server 2012	
		100								SQL Server 2008 
		90								SQL Server 2005	
		80								SQL Server 2000	
	#>

	$tmp = ""
	Switch($DBCompat)
	{
		"140"			{$tmp = "SQL Server 2017"}
		"130"			{$tmp = "SQL Server 2016"}
		"120"			{$tmp = "SQL Server 2014"}
		"110"			{$tmp = "SQL Server 2012"}
		"100"			{$tmp = "SQL Server 2008"}
		"90"			{$tmp = "SQL Server 2005"}
		"80"			{$tmp = "SQL Server 2000"}
		"Version140"	{$tmp = "SQL Server 2017"}
		"Version130"	{$tmp = "SQL Server 2016"}
		"Version120"	{$tmp = "SQL Server 2014"}
		"Version110"	{$tmp = "SQL Server 2012"}
		"Version100"	{$tmp = "SQL Server 2008"}
		"Version90"		{$tmp = "SQL Server 2005"}
		"Version80"		{$tmp = "SQL Server 2000"}
		Default			{$tmp = "Unable to determine Database Compatibility Level: $DBCompat"}
	}
	
	Return $tmp
}

Function OutputDatastores
{
	#2-Mar-2017 Fix bug reported by P. Ewing
	
	#V2.11 add additional database details and change from a horizontal table to a vertical table
	
	#line starts with server=SQLServerName;
	#only need what is between the = and ;
	
	#24-Jun-2017 add Database Size to the output
	#25-Jun-2017 add checking if the SQL Server assembly loaded before calculating the database size
	Write-Verbose "$(Get-Date): `tRetrieving database connection data"
	Write-Verbose "$(Get-Date): `t`tConfiguration database"
	$ConfigSQLServerPrincipalName = ""
	$ConfigSQLServerMirrorName = "Not Configured"
	$ConfigDatabaseName = ""
	[string]$ConfigDBSize = "Unable to determine"
	[string]$ConfigDBReadCommittedSnapshot = "Unable to determine"
	[string]$ConfigDBSQLVersion = "Unable to determine"
	$ConfigDBs = Get-ConfigDBConnection @XDParams1

	If($? -and ($Null -ne $ConfigDBs))
	{
		$tmp = $ConfigDBs
		$csitems = $tmp.Split(';')
		ForEach($csitem in $csitems)
		{
			$Pair = $csitem.split('=').trimstart()
			Switch ($Pair[0])
			{
				"Server"					{$ConfigSQLServerPrincipalName = $Pair[1]; Break}
				"Failover Partner"			{$ConfigSQLServerMirrorName = $Pair[1]; Break}
				"MultiSubnetFailover"		{$ConfigSQLServerMirrorName = ""; Break}
				"Database"					{$ConfigDatabaseName = $Pair[1]; Break}
				"Initial Catalog"			{$ConfigDatabaseName = $Pair[1]; Break}
			}
		}

		If($Script:SQLServerLoaded)
		{
			$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($ConfigSQLServerPrincipalName)")
			$Configdb = New-Object Microsoft.SqlServer.Management.Smo.Database
			$Configdb = $SQLsrv.Databases.Item("$($ConfigDatabaseName)")
			[string]$Configdbsize = "Unable to determine" -f $Configdb.size
			If($Null -ne $Configdb.size)
			{
				[string]$Configdbsize = "{0:F2} MB" -f $Configdb.size
			}
			ElseIf($Null -eq $Configdb.size -and $ConfigSQLServerMirrorName -ne "Not Configured")
			{
				$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($ConfigSQLServerMirrorName)")
				$Configdb = New-Object Microsoft.SqlServer.Management.Smo.Database
				$Configdb = $SQLsrv.Databases.Item("$($ConfigDatabaseName)")
				If($Null -ne $Configdb.size)
				{
					[string]$Configdbsize = "{0:F2} MB" -f $Configdb.size
				}
			}
			
			$ConfigDBParent 									= $Configdb.Parent
			$ConfigDBCollation 									= $Configdb.Collation
			$ConfigDBSQLVersion 								= GetSQLVersion $SQLsrv
			$ConfigDBCompatibilityLevel 						= GetDBCompatibilityLevel $Configdb.CompatibilityLevel
			$ConfigDBCreateDate 								= $Configdb.CreateDate.ToString()

			If($Configdb.IsReadCommittedSnapshotOn)
			{
				$ConfigDBReadCommittedSnapshot = "Enabled"
			}
			Else
			{
				$ConfigDBReadCommittedSnapshot = "Disabled"
			}

			$ConfigDBLastBackupDate 	= $Configdb.LastBackupDate.ToString()
			$ConfigDBLastLogBackupDate 	= $Configdb.LastLogBackupDate.ToString()
			$ConfigDBRecoveryModel 		= $Configdb.RecoveryModel

			If(![String]::IsNullOrEmpty($Configdb.AvailabilityGroupName))
			{
				$ConfigDBAvailabilityGroupName 						= $Configdb.AvailabilityGroupName
				$ConfigDBAvailabilityDatabaseSynchronizationState 	= $Configdb.AvailabilityDatabaseSynchronizationState
			}
			Else
			{
				$ConfigDBAvailabilityGroupName 						= "-"
				$ConfigDBAvailabilityDatabaseSynchronizationState 	= "-"
			}
			
			If($Configdb.IsMirroringEnabled)
			{
				$ConfigDBMirroringPartner			= $Configdb.MirroringPartner
				$ConfigDBMirroringPartnerInstance	= $Configdb.MirroringPartnerInstance
				$ConfigDBMirroringSafetyLevel		= $Configdb.MirroringSafetyLevel
				$ConfigDBMirroringStatus			= $Configdb.MirroringStatus
				$ConfigDBMirroringWitness			= $Configdb.MirroringWitness
				$ConfigDBMirroringWitnessStatus		= $Configdb.MirroringWitnessStatus
			}
			Else
			{
				$ConfigDBMirroringPartner			= "-"
				$ConfigDBMirroringPartnerInstance	= "-"
				$ConfigDBMirroringSafetyLevel		= "-"
				$ConfigDBMirroringStatus			= "-"
				$ConfigDBMirroringWitness			= "-"
				$ConfigDBMirroringWitnessStatus		= "-"
			}
			
			#check for log backup status
			If($ConfigDBRecoveryModel -eq "Simple")
			{
				If($ConfigDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$ConfigDBLastLogBackupDate = "Log backup not needed for Simple Recovery Model"
				}
			}
			ElseIf($ConfigDBRecoveryModel -eq "Full")
			{
				If($ConfigDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$ConfigDBLastLogBackupDate = "Log backup not detected for Full Recovery Model"
				}
			}
			
			#check for database backup
			If($ConfigDBLastBackupDate -eq "1/1/0001 12:00:00 AM")
			{
				$ConfigDBLastBackupDate = "Database backup not detected"
			}
		}
	}
	Else
	{
		Write-Warning "Unable to retrieve Configuration Database settings"
	}

	Write-Verbose "$(Get-Date): `t`tConfiguration Logging database"
	$LogSQLServerPrincipalName = ""
	$LogSQLServerMirrorName = "Not Configured"
	$LogDatabaseName = ""
	[string]$LogDBSize = "Unable to determine"
	[string]$LogDBReadCommittedSnapshot = "Unable to determine"
	[string]$LogDBSQLVersion = "Unable to determine"
	$LogDBs = Get-LogDataStore @XDParams1

	If($? -and ($Null -ne $LogDBs))
	{
		ForEach($LogDB in $LogDBs)
		{
			If($LogDB.DataStore -eq "Logging")
			{
				$tmp = $LogDB.ConnectionString
				$csitems = $tmp.Split(';')
				ForEach($csitem in $csitems)
				{
					$Pair = $csitem.split('=').trimstart()
					Switch ($Pair[0])
					{
						"Server"					{$LogSQLServerPrincipalName = $Pair[1]; Break}
						"Failover Partner"			{$LogSQLServerMirrorName = $Pair[1]; Break}
						"MultiSubnetFailover"		{$LogSQLServerMirrorName = ""; Break}
						"Database"					{$LogDatabaseName = $Pair[1]; Break}
						"Initial Catalog"			{$LogDatabaseName = $Pair[1]; Break}
					}
				}
			}
		}

		If($Script:SQLServerLoaded)
		{
			$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($LogSQLServerPrincipalName)")
			$Logdb = New-Object Microsoft.SqlServer.Management.Smo.Database
			$Logdb = $SQLsrv.Databases.Item("$($LogDatabaseName)")
			[string]$Logdbsize = "Unable to determine" -f $Logdb.size
			If($Null -ne $Logdb.size)
			{
				[string]$Logdbsize = "{0:F2} MB" -f $Logdb.size
			}
			ElseIf($Null -eq $Logdb.size -and $LogSQLServerMirrorName -ne "Not Configured")
			{
				$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($LogSQLServerMirrorName)")
				$Logdb = New-Object Microsoft.SqlServer.Management.Smo.Database
				$Logdb = $SQLsrv.Databases.Item("$($LogDatabaseName)")
				If($Null -ne $Logdb.size)
				{
					[string]$Logdbsize = "{0:F2} MB" -f $Logdb.size
				}
			}

			$LogDBParent 									= $LogDB.Parent
			$LogDBCollation 								= $LogDB.Collation
			$LogDBSQLVersion 								= GetSQLVersion $SQLsrv
			$LogDBCompatibilityLevel 						= GetDBCompatibilityLevel $LogDB.CompatibilityLevel
			$LogDBCreateDate 								= $LogDB.CreateDate.ToString()

			If($LogDB.IsReadCommittedSnapshotOn)
			{
				$LogDBReadCommittedSnapshot = "Enabled"
			}
			Else
			{
				$LogDBReadCommittedSnapshot = "Disabled"
			}

			$LogDBLastBackupDate 	= $LogDB.LastBackupDate.ToString()
			$LogDBLastLogBackupDate	= $LogDB.LastLogBackupDate.ToString()
			$LogDBRecoveryModel 	= $LogDB.RecoveryModel

			If(![String]::IsNullOrEmpty($LogDB.AvailabilityGroupName))
			{
				$LogDBAvailabilityGroupName 					= $LogDB.AvailabilityGroupName
				$LogDBAvailabilityDatabaseSynchronizationState 	= $LogDB.AvailabilityDatabaseSynchronizationState
			}
			Else
			{
				$LogDBAvailabilityGroupName 					= "-"
				$LogDBAvailabilityDatabaseSynchronizationState 	= "-"
			}
			
			If($LogDB.IsMirroringEnabled)
			{
				$LogDBMirroringPartner			= $LogDB.MirroringPartner
				$LogDBMirroringPartnerInstance	= $LogDB.MirroringPartnerInstance
				$LogDBMirroringSafetyLevel		= $LogDB.MirroringSafetyLevel
				$LogDBMirroringStatus			= $LogDB.MirroringStatus
				$LogDBMirroringWitness			= $LogDB.MirroringWitness
				$LogDBMirroringWitnessStatus	= $LogDB.MirroringWitnessStatus
			}
			Else
			{
				$LogDBMirroringPartner			= "-"
				$LogDBMirroringPartnerInstance	= "-"
				$LogDBMirroringSafetyLevel		= "-"
				$LogDBMirroringStatus			= "-"
				$LogDBMirroringWitness			= "-"
				$LogDBMirroringWitnessStatus	= "-"
			}

			#check for log backup status
			If($LogDBRecoveryModel -eq "Simple")
			{
				If($LogDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$LogDBLastLogBackupDate = "Log backup not needed for Simple Recovery Model"
				}
			}
			ElseIf($LogDBRecoveryModel -eq "Full")
			{
				If($LogDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$LogDBLastLogBackupDate = "Log backup not detected for Full Recovery Model"
				}
			}
			
			#check for database backup
			If($LogDBLastBackupDate -eq "1/1/0001 12:00:00 AM")
			{
				$LogDBLastBackupDate = "Database backup not detected"
			}
		}
	}
	Else
	{
		Write-Warning "Unable to retrieve Configuration Logging Database settings"
	}

	Write-Verbose "$(Get-Date): `t`tMonitoring database"
	$MonitorSQLServerPrincipalName = ""
	$MonitorSQLServerMirrorName = "Not Configured"
	$MonitorDatabaseName = ""
	[string]$MonitorDBSize = "Unable to determine"
	[string]$MonitorDBReadCommittedSnapshot = "Unable to determine"
	[string]$MonitorDBSQLVersion = "Unable to determine"
	$MonitorCollectHotfix = "Disabled"
	$MonitorDataCollection = "Disabled"
	$MonitorDetailedSQL = "Disabled"
	
	$MonitorDBs = Get-MonitorDataStore @XDParams1

	If($? -and ($Null -ne $MonitorDBs))
	{
		ForEach($MonitorDB in $MonitorDBs)
		{
			If($MonitorDB.DataStore -eq "Monitor")
			{
				$tmp = $MonitorDB.ConnectionString
				$csitems = $tmp.Split(';')
				ForEach($csitem in $csitems)
				{
					$Pair = $csitem.split('=').trimstart()
					Switch ($Pair[0])
					{
						"Server"					{$MonitorSQLServerPrincipalName = $Pair[1]; Break}
						"Failover Partner"			{$MonitorSQLServerMirrorName = $Pair[1]; Break}
						"MultiSubnetFailover"		{$MonitorSQLServerMirrorName = ""; Break}
						"Database"					{$MonitorDatabaseName = $Pair[1]; Break}
						"Initial Catalog"			{$MonitorDatabaseName = $Pair[1]; Break}
					}
				}
			}
		}

		If($Script:SQLServerLoaded)
		{
			$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($MonitorSQLServerPrincipalName)")
			$Monitordb = New-Object Microsoft.SqlServer.Management.Smo.Database
			$Monitordb = $SQLsrv.Databases.Item("$($MonitorDatabaseName)")
			[string]$Monitordbsize = "Unable to determine" -f $Monitordb.size
			If($Null -ne $Monitordb.size)
			{
				[string]$Monitordbsize = "{0:F2} MB" -f $Monitordb.size
			}
			ElseIf($Null -eq $Monitordb.size -and $MonitorSQLServerMirrorName -ne "Not Configured")
			{
				$SQLsrv = new-Object Microsoft.SqlServer.Management.Smo.Server("$($MonitorSQLServerMirrorName)")
				$Monitordb = New-Object Microsoft.SqlServer.Management.Smo.Database
				$Monitordb = $SQLsrv.Databases.Item("$($MonitorDatabaseName)")
				If($Null -ne $Monitordb.size)
				{
					[string]$Monitordbsize = "{0:F2} MB" -f $Monitordb.size
				}
			}

			$MonitorDBParent 				= $MonitorDB.Parent
			$MonitorDBCollation 			= $MonitorDB.Collation
			$MonitorDBSQLVersion 			= GetSQLVersion $SQLsrv
			$MonitorDBCompatibilityLevel	= GetDBCompatibilityLevel $MonitorDB.CompatibilityLevel
			$MonitorDBCreateDate 			= $MonitorDB.CreateDate.ToString()

			If($MonitorDB.IsReadCommittedSnapshotOn)
			{
				$MonitorDBReadCommittedSnapshot = "Enabled"
			}
			Else
			{
				$MonitorDBReadCommittedSnapshot = "Disabled"
			}

			$MonitorDBLastBackupDate 	= $MonitorDB.LastBackupDate.ToString()
			$MonitorDBLastLogBackupDate	= $MonitorDB.LastLogBackupDate.ToString()
			$MonitorDBRecoveryModel 	= $MonitorDB.RecoveryModel

			If(![String]::IsNullOrEmpty($MonitorDB.AvailabilityGroupName))
			{
				$MonitorDBAvailabilityGroupName 					= $MonitorDB.AvailabilityGroupName
				$MonitorDBAvailabilityDatabaseSynchronizationState 	= $MonitorDB.AvailabilityDatabaseSynchronizationState
			}
			Else
			{
				$MonitorDBAvailabilityGroupName 					= "-"
				$MonitorDBAvailabilityDatabaseSynchronizationState 	= "-"
			}
			
			If($MonitorDB.IsMirroringEnabled)
			{
				$MonitorDBMirroringPartner			= $MonitorDB.MirroringPartner
				$MonitorDBMirroringPartnerInstance	= $MonitorDB.MirroringPartnerInstance
				$MonitorDBMirroringSafetyLevel		= $MonitorDB.MirroringSafetyLevel
				$MonitorDBMirroringStatus			= $MonitorDB.MirroringStatus
				$MonitorDBMirroringWitness			= $MonitorDB.MirroringWitness
				$MonitorDBMirroringWitnessStatus	= $MonitorDB.MirroringWitnessStatus
			}
			Else
			{
				$MonitorDBMirroringPartner			= "-"
				$MonitorDBMirroringPartnerInstance	= "-"
				$MonitorDBMirroringSafetyLevel		= "-"
				$MonitorDBMirroringStatus			= "-"
				$MonitorDBMirroringWitness			= "-"
				$MonitorDBMirroringWitnessStatus	= "-"
			}

			#check for log backup status
			If($MonitorDBRecoveryModel -eq "Simple")
			{
				If($MonitorDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$MonitorDBLastLogBackupDate = "Log backup not needed for Simple Recovery Model"
				}
			}
			ElseIf($MonitorDBRecoveryModel -eq "Full")
			{
				If($MonitorDBLastLogBackupDate -eq "1/1/0001 12:00:00 AM")
				{
					$MonitorDBLastLogBackupDate = "Log backup not detected for Full Recovery Model"
				}
			}
			
			#check for database backup
			If($MonitorDBLastBackupDate -eq "1/1/0001 12:00:00 AM")
			{
				$MonitorDBLastBackupDate = "Database backup not detected"
			}
		}
		
		$MonitorConfig = $Null
		$MonitorConfig = Get-MonitorConfiguration @XDParams1
		
		If($? -and $Null -ne $MonitorConfig)
		{
			If($MonitorConfig.CollectHotfixDataEnabled)
			{
				$MonitorCollectHotfix = "Enabled"
			}
			Else
			{
				$MonitorCollectHotfix = "Disabled"
			}

			If($MonitorConfig.DataCollectionEnabled)
			{
				$MonitorDataCollection = "Enabled"
			}
			Else
			{
				$MonitorDataCollection = "Disabled"
			}

			If($MonitorConfig.DetailedSqlOutputEnabled)
			{
				$MonitorDetailedSQL = "Enabled"
			}
			Else
			{
				$MonitorDetailedSQL = "Disabled"
			}
		}
	}
	Else
	{
		Write-Warning "Unable to retrieve Monitoring Database settings"
	}

	Write-Verbose "$(Get-Date): `tOutput Datastores"
	If($MSWord -or $PDF)
	{
		WriteWordLine 2 0 "Datastores"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{Data = "Datastore"; Value = "Site"; }
		$ScriptInformation += @{Data = "Database Name"; Value = $ConfigDatabaseName; }
		$ScriptInformation += @{Data = "Availability Database Synchronization State"; Value = $ConfigDBAvailabilityDatabaseSynchronizationState; }
		$ScriptInformation += @{Data = "Availability Group Name"; Value = $ConfigDBAvailabilityGroupName; }
		$ScriptInformation += @{Data = "Collation"; Value = $ConfigDBCollation; }
		$ScriptInformation += @{Data = "Compatibility Level"; Value = $ConfigDBCompatibilityLevel; }
		$ScriptInformation += @{Data = "Create Date"; Value = $ConfigDBCreateDate; }
		$ScriptInformation += @{Data = "Database Size"; Value = $ConfigDBSize; }
		$ScriptInformation += @{Data = "Last Backup Date"; Value = $ConfigDBLastBackupDate; }
		$ScriptInformation += @{Data = "Last Log Backup Date"; Value = $ConfigDBLastLogBackupDate; }
		$ScriptInformation += @{Data = "Mirror Server Address"; Value = $ConfigSQLServerMirrorName; }
		$ScriptInformation += @{Data = "Mirroring Partner"; Value = $ConfigDBMirroringPartner; }
		$ScriptInformation += @{Data = "Mirroring Partner Instance"; Value = $ConfigDBMirroringPartnerInstance; }
		$ScriptInformation += @{Data = "Mirroring Safety Level"; Value = $ConfigDBMirroringSafetyLevel; }
		$ScriptInformation += @{Data = "Mirroring Status"; Value = $ConfigDBMirroringStatus; }
		$ScriptInformation += @{Data = "Mirroring Witness"; Value = $ConfigDBMirroringWitness; }
		$ScriptInformation += @{Data = "Mirroring Witness Status"; Value = $ConfigDBMirroringWitnessStatus; }
		$ScriptInformation += @{Data = "Parent"; Value = $ConfigDBParent; }
		$ScriptInformation += @{Data = "Read-Committed Snapshot"; Value = $ConfigDBReadCommittedSnapshot; }
		$ScriptInformation += @{Data = "Recovery Model"; Value = $ConfigDBRecoveryModel; }
		$ScriptInformation += @{Data = "Server Address"; Value = $ConfigSQLServerPrincipalName; }
		$ScriptInformation += @{Data = "SQL Server Version"; Value = $ConfigDBSQLVersion; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 250;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""

		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{Data = "Datastore"; Value = "Logging"; }
		$ScriptInformation += @{Data = "Database Name"; Value = $LogDatabaseName; }
		$ScriptInformation += @{Data = "Availability Database Synchronization State"; Value = $LogDBAvailabilityDatabaseSynchronizationState; }
		$ScriptInformation += @{Data = "Availability Group Name"; Value = $LogDBAvailabilityGroupName; }
		$ScriptInformation += @{Data = "Collation"; Value = $LogDBCollation; }
		$ScriptInformation += @{Data = "Compatibility Level"; Value = $LogDBCompatibilityLevel; }
		$ScriptInformation += @{Data = "Create Date"; Value = $LogDBCreateDate; }
		$ScriptInformation += @{Data = "Database Size"; Value = $LogDBSize; }
		$ScriptInformation += @{Data = "Last Backup Date"; Value = $LogDBLastBackupDate; }
		$ScriptInformation += @{Data = "Last Log Backup Date"; Value = $LogDBLastLogBackupDate; }
		$ScriptInformation += @{Data = "Mirror Server Address"; Value = $ConfigSQLServerMirrorName; }
		$ScriptInformation += @{Data = "Mirroring Partner"; Value = $LogDBMirroringPartner; }
		$ScriptInformation += @{Data = "Mirroring Partner Instance"; Value = $LogDBMirroringPartnerInstance; }
		$ScriptInformation += @{Data = "Mirroring Safety Level"; Value = $LogDBMirroringSafetyLevel; }
		$ScriptInformation += @{Data = "Mirroring Status"; Value = $LogDBMirroringStatus; }
		$ScriptInformation += @{Data = "Mirroring Witness"; Value = $LogDBMirroringWitness; }
		$ScriptInformation += @{Data = "Mirroring Witness Status"; Value = $LogDBMirroringWitnessStatus; }
		$ScriptInformation += @{Data = "Parent"; Value = $LogDBParent; }
		$ScriptInformation += @{Data = "Read-Committed Snapshot"; Value = $LogDBReadCommittedSnapshot; }
		$ScriptInformation += @{Data = "Recovery Model"; Value = $LogDBRecoveryModel; }
		$ScriptInformation += @{Data = "Server Address"; Value = $LogSQLServerPrincipalName; }
		$ScriptInformation += @{Data = "SQL Server Version"; Value = $LogDBSQLVersion; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 250;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""

		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{Data = "Datastore"; Value = "Monitoring"; }
		$ScriptInformation += @{Data = "Database Name"; Value = $MonitorDatabaseName; }
		$ScriptInformation += @{Data = "Availability Database Synchronization State"; Value = $MonitorDBAvailabilityDatabaseSynchronizationState; }
		$ScriptInformation += @{Data = "Availability Group Name"; Value = $MonitorDBAvailabilityGroupName; }
		$ScriptInformation += @{Data = "Collation"; Value = $MonitorDBCollation; }
		$ScriptInformation += @{Data = "Compatibility Level"; Value = $MonitorDBCompatibilityLevel; }
		$ScriptInformation += @{Data = "Create Date"; Value = $MonitorDBCreateDate; }
		$ScriptInformation += @{Data = "Database Size"; Value = $MonitorDBSize; }
		$ScriptInformation += @{Data = "Last Backup Date"; Value = $MonitorDBLastBackupDate; }
		$ScriptInformation += @{Data = "Last Log Backup Date"; Value = $MonitorDBLastLogBackupDate; }
		$ScriptInformation += @{Data = "Mirror Server Address"; Value = $ConfigSQLServerMirrorName; }
		$ScriptInformation += @{Data = "Mirroring Partner"; Value = $MonitorDBMirroringPartner; }
		$ScriptInformation += @{Data = "Mirroring Partner Instance"; Value = $MonitorDBMirroringPartnerInstance; }
		$ScriptInformation += @{Data = "Mirroring Safety Level"; Value = $MonitorDBMirroringSafetyLevel; }
		$ScriptInformation += @{Data = "Mirroring Status"; Value = $MonitorDBMirroringStatus; }
		$ScriptInformation += @{Data = "Mirroring Witness"; Value = $MonitorDBMirroringWitness; }
		$ScriptInformation += @{Data = "Mirroring Witness Status"; Value = $MonitorDBMirroringWitnessStatus; }
		$ScriptInformation += @{Data = "Parent"; Value = $MonitorDBParent; }
		$ScriptInformation += @{Data = "Read-Committed Snapshot"; Value = $MonitorDBReadCommittedSnapshot; }
		$ScriptInformation += @{Data = "Recovery Model"; Value = $MonitorDBRecoveryModel; }
		$ScriptInformation += @{Data = "Server Address"; Value = $MonitorSQLServerPrincipalName; }
		$ScriptInformation += @{Data = "SQL Server Version"; Value = $MonitorDBSQLVersion; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 250;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""

		WriteWordLine 3 0 "Monitoring Database Details"
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{Data = "Collect Hotfix Data"; Value = $MonitorCollectHotfix; }
		$ScriptInformation += @{Data = "Data Collection"; Value = $MonitorDataCollection; }
		$ScriptInformation += @{Data = "Detail SQL Output"; Value = $MonitorDetailedSQL; }
		If($MonitorConfig.ContainsKey("EnableDayLevelGranularityProcessUtilization"))
		{
			$ScriptInformation += @{Data = "Enable Day Level Granularity"; Value = $MonitorConfig.EnableDayLevelGranularityProcessUtilization; }
		}
		If($MonitorConfig.ContainsKey("EnableHourLevelGranularityProcessUtilization"))
		{
			$ScriptInformation += @{Data = "Enable Hour Level Granularity"; Value = $MonitorConfig.EnableHourLevelGranularityProcessUtilization; }
		}
		If($MonitorConfig.ContainsKey("EnableMinLevelGranularityProcessUtilization"))
		{
			$ScriptInformation += @{Data = "Enable Minute Level Granularity"; Value = $MonitorConfig.EnableMinLevelGranularityProcessUtilization; }
		}
		$ScriptInformation += @{Data = "Full Poll Start Hour"; Value = $MonitorConfig.FullPollStartHour; }
		If($MonitorConfig.ContainsKey("MonitorQueryTimeoutSeconds"))
		{
			$ScriptInformation += @{Data = "Monitor Query Timeout Seconds"; Value = $MonitorConfig.MonitorQueryTimeoutSeconds; }
		}
		$ScriptInformation += @{Data = "Resolution Poll Time Hours"; Value = $MonitorConfig.FullPollStartHour; }
		$ScriptInformation += @{Data = "Sync Poll Time Hours"; Value = $MonitorConfig.SyncPollTimeHours; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 50;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 3 0 "Groom Retention Settings in Days"
		[System.Collections.Hashtable[]] $ScriptInformation = @()

		If($MonitorConfig.ContainsKey("GroomApplicationErrorsRetentionDays"))
		{
			$ScriptInformation += @{Data = "Application Errors"; Value = $MonitorConfig.GroomApplicationErrorsRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomApplicationFaultsRetentionDays"))
		{
			$ScriptInformation += @{Data = "Application Faults"; Value = $MonitorConfig.GroomApplicationFaultsRetentionDays; }
		}
		$ScriptInformation += @{Data = "Application Instance"; Value = $MonitorConfig.GroomApplicationInstanceRetentionDays; }
		$ScriptInformation += @{Data = "Deleted"; Value = $MonitorConfig.GroomDeletedRetentionDays; }
		$ScriptInformation += @{Data = "Failures"; Value = $MonitorConfig.GroomFailuresRetentionDays; }
		If($MonitorConfig.ContainsKey("GroomHourlyRetentionDays"))
		{
			$ScriptInformation += @{Data = "Hourly Retention"; Value = $MonitorConfig.GroomHourlyRetentionDays; }
		}
		$ScriptInformation += @{Data = "Load Indexes"; Value = $MonitorConfig.GroomLoadIndexesRetentionDays; }
		$ScriptInformation += @{Data = "Machine Hotfix Log"; Value = $MonitorConfig.GroomMachineHotfixLogRetentionDays; }
		If($MonitorConfig.ContainsKey("GroomMachineMetricDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Machine Metric Data"; Value = $MonitorConfig.GroomMachineMetricDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomMachineMetricDaySummaryDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Machine Metric Day Summary"; Value = $MonitorConfig.GroomMachineMetricDaySummaryDataRetentionDays; }
		}
		$ScriptInformation += @{Data = "Minute"; Value = $MonitorConfig.GroomMinuteRetentionDays; }
		If($MonitorConfig.ContainsKey("GroomNotificationLogRetentionDays"))
		{
			$ScriptInformation += @{Data = "Notification"; Value = $MonitorConfig.GroomNotificationLogRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageDayDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Process Usage Day Data"; Value = $MonitorConfig.GroomProcessUsageDayDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageHourDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Process Usage Hour Data"; Value = $MonitorConfig.GroomProcessUsageHourDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageMinuteDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Process Usage Minute Data"; Value = $MonitorConfig.GroomProcessUsageMinuteDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageRawDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Process Usage Raw Data"; Value = $MonitorConfig.GroomProcessUsageRawDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageDayDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Resource Usage Day Data"; Value = $MonitorConfig.GroomResourceUsageDayDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageHourDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Resource Usage Hour Data"; Value = $MonitorConfig.GroomResourceUsageHourDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageMinuteDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Resource Usage Minute Data"; Value = $MonitorConfig.GroomResourceUsageMinuteDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageRawDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Resource Usage Raw Data"; Value = $MonitorConfig.GroomResourceUsageRawDataRetentionDays; }
		}
		If($MonitorConfig.ContainsKey("GroomSessionMetricsDataRetentionDays"))
		{
			$ScriptInformation += @{Data = "Session Metrics"; Value = $MonitorConfig.GroomSessionMetricsDataRetentionDays; }
		}
		$ScriptInformation += @{Data = "Sessions"; Value = $MonitorConfig.GroomSessionsRetentionDays; }
		$ScriptInformation += @{Data = "Summaries"; Value = $MonitorConfig.GroomSummariesRetentionDays; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 200;
		$Table.Columns.Item(2).Width = 50;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 0 "Datastores"
		Line 0 ""
		Line 1 "Datastore: Site"
		Line 2 "Database Name`t`t`t`t`t: " $ConfigDatabaseName
		Line 2 "Availability Database Synchronization State`t: " $ConfigDBAvailabilityDatabaseSynchronizationState
		Line 2 "Availability Group Name`t`t`t`t: " $ConfigDBAvailabilityGroupName
		Line 2 "Collation`t`t`t`t`t: " $ConfigDBCollation
		Line 2 "Compatibility Level`t`t`t`t: " $ConfigDBCompatibilityLevel
		Line 2 "Create Date`t`t`t`t`t: " $ConfigDBCreateDate
		Line 2 "Database Size`t`t`t`t`t: " $ConfigDBSize
		Line 2 "Last Backup Date`t`t`t`t: " $ConfigDBLastBackupDate
		Line 2 "Last Log Backup Date`t`t`t`t: " $ConfigDBLastLogBackupDate
		Line 2 "Mirror Server Address`t`t`t`t: " $ConfigSQLServerMirrorName
		Line 2 "Mirroring Partner`t`t`t`t: " $ConfigDBMirroringPartner
		Line 2 "Mirroring Partner Instance`t`t`t: " $ConfigDBMirroringPartnerInstance
		Line 2 "Mirroring Safety Level`t`t`t`t: " $ConfigDBMirroringSafetyLevel
		Line 2 "Mirroring Status`t`t`t`t: " $ConfigDBMirroringStatus
		Line 2 "Mirroring Witness`t`t`t`t: " $ConfigDBMirroringWitness
		Line 2 "Mirroring Witness Status`t`t`t: " $ConfigDBMirroringWitnessStatus
		Line 2 "Parent`t`t`t`t`t`t: " $ConfigDBParent
		Line 2 "Read-Committed Snapshot`t`t`t`t: " $ConfigDBReadCommittedSnapshot
		Line 2 "Recovery Model`t`t`t`t`t: " $ConfigDBRecoveryModel
		Line 2 "Server Address`t`t`t`t`t: " $ConfigSQLServerPrincipalName
		Line 2 "SQL Server Version`t`t`t`t: " $ConfigDBSQLVersion
		Line 0 ""
		Line 1 "Datastore: Logging"
		Line 2 "Database Name`t`t`t`t`t: " $LogDatabaseName
		Line 2 "Availability Database Synchronization State`t: " $LogDBAvailabilityDatabaseSynchronizationState
		Line 2 "Availability Group Name`t`t`t`t: " $LogDBAvailabilityGroupName
		Line 2 "Collation`t`t`t`t`t: " $LogDBCollation
		Line 2 "Compatibility Level`t`t`t`t: " $LogDBCompatibilityLevel
		Line 2 "Create Date`t`t`t`t`t: " $LogDBCreateDate
		Line 2 "Database Size`t`t`t`t`t: " $LogDBSize
		Line 2 "Last Backup Date`t`t`t`t: " $LogDBLastBackupDate
		Line 2 "Last Log Backup Date`t`t`t`t: " $LogDBLastLogBackupDate
		Line 2 "Mirror Server Address`t`t`t`t: " $LogSQLServerMirrorName
		Line 2 "Mirroring Partner`t`t`t`t: " $LogDBMirroringPartner
		Line 2 "Mirroring Partner Instance`t`t`t: " $LogDBMirroringPartnerInstance
		Line 2 "Mirroring Safety Level`t`t`t`t: " $LogDBMirroringSafetyLevel
		Line 2 "Mirroring Status`t`t`t`t: " $LogDBMirroringStatus
		Line 2 "Mirroring Witness`t`t`t`t: " $LogDBMirroringWitness
		Line 2 "Mirroring Witness Status`t`t`t: " $LogDBMirroringWitnessStatus
		Line 2 "Parent`t`t`t`t`t`t: " $LogDBParent
		Line 2 "Read-Committed Snapshot`t`t`t`t: " $LogDBReadCommittedSnapshot
		Line 2 "Recovery Model`t`t`t`t`t: " $LogDBRecoveryModel
		Line 2 "Server Address`t`t`t`t`t: " $LogSQLServerPrincipalName
		Line 2 "SQL Server Version`t`t`t`t: " $LogDBSQLVersion
		Line 0 ""
		Line 1 "Datastore: Monitoring"
		Line 2 "Database Name`t`t`t`t`t: " $MonitorDatabaseName
		Line 2 "Availability Database Synchronization State`t: " $MonitorDBAvailabilityDatabaseSynchronizationState
		Line 2 "Availability Group Name`t`t`t`t: " $MonitorDBAvailabilityGroupName
		Line 2 "Collation`t`t`t`t`t: " $MonitorDBCollation
		Line 2 "Compatibility Level`t`t`t`t: " $MonitorDBCompatibilityLevel
		Line 2 "Create Date`t`t`t`t`t: " $MonitorDBCreateDate
		Line 2 "Database Size`t`t`t`t`t: " $MonitorDBSize
		Line 2 "Last Backup Date`t`t`t`t: " $MonitorDBLastBackupDate
		Line 2 "Last Log Backup Date`t`t`t`t: " $MonitorDBLastLogBackupDate
		Line 2 "Mirror Server Address`t`t`t`t: " $MonitorSQLServerMirrorName
		Line 2 "Mirroring Partner`t`t`t`t: " $MonitorDBMirroringPartner
		Line 2 "Mirroring Partner Instance`t`t`t: " $MonitorDBMirroringPartnerInstance
		Line 2 "Mirroring Safety Level`t`t`t`t: " $MonitorDBMirroringSafetyLevel
		Line 2 "Mirroring Status`t`t`t`t: " $MonitorDBMirroringStatus
		Line 2 "Mirroring Witness`t`t`t`t: " $MonitorDBMirroringWitness
		Line 2 "Mirroring Witness Status`t`t`t: " $MonitorDBMirroringWitnessStatus
		Line 2 "Parent`t`t`t`t`t`t: " $MonitorDBParent
		Line 2 "Read-Committed Snapshot`t`t`t`t: " $MonitorDBReadCommittedSnapshot
		Line 2 "Recovery Model`t`t`t`t`t: " $MonitorDBRecoveryModel
		Line 2 "Server Address`t`t`t`t`t: " $MonitorSQLServerPrincipalName
		Line 2 "SQL Server Version`t`t`t`t: " $MonitorDBSQLVersion
		Line 0 ""

		Line 1 "Monitoring Database Details"
		Line 2 "Collect Hotfix Data`t`t: " $MonitorCollectHotfix
		Line 2 "Data Collection`t`t`t: " $MonitorDataCollection
		Line 2 "Detail SQL Output`t`t: " $MonitorDetailedSQL
		If($MonitorConfig.ContainsKey("EnableDayLevelGranularityProcessUtilization"))
		{
			Line 2 "Enable Day Level Granularity`t: " $MonitorConfig.EnableDayLevelGranularityProcessUtilization
		}
		If($MonitorConfig.ContainsKey("EnableHourLevelGranularityProcessUtilization"))
		{
			Line 2 "Enable Hour Level Granularity`t: " $MonitorConfig.EnableHourLevelGranularityProcessUtilization
		}
		If($MonitorConfig.ContainsKey("EnableMinLevelGranularityProcessUtilization"))
		{
			Line 2 "Enable Minute Level Granularity`t: " $MonitorConfig.EnableMinLevelGranularityProcessUtilization
		}
		Line 2 "Full Poll Start Hour`t`t: " $MonitorConfig.FullPollStartHour
		If($MonitorConfig.ContainsKey("MonitorQueryTimeoutSeconds"))
		{
			Line 2 "Monitor Query Timeout Seconds`t: " $MonitorConfig.MonitorQueryTimeoutSeconds
		}
		Line 2 "Resolution Poll Time Hours`t: " $MonitorConfig.FullPollStartHour
		Line 2 "Sync Poll Time Hours`t`t: " $MonitorConfig.SyncPollTimeHours
		Line 0 ""
		Line 1 "Groom Retention Settings in Days" 
		If($MonitorConfig.ContainsKey("GroomApplicationErrorsRetentionDays"))
		{
			Line 2 "Application Errors`t`t: " $MonitorConfig.GroomApplicationErrorsRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomApplicationFaultsRetentionDays"))
		{
			Line 2 "Application Faults`t`t: " $MonitorConfig.GroomApplicationFaultsRetentionDays
		}
		Line 2 "Application Instance`t`t: " $MonitorConfig.GroomApplicationInstanceRetentionDays
		Line 2 "Deleted`t`t`t`t: " $MonitorConfig.GroomDeletedRetentionDays
		Line 2 "Failures`t`t`t: " $MonitorConfig.GroomFailuresRetentionDays
		If($MonitorConfig.ContainsKey("GroomHourlyRetentionDays"))
		{
			Line 2 "Hourly Retention`t`t: " $MonitorConfig.GroomHourlyRetentionDays
		}
		Line 2 "Load Indexes`t`t`t: " $MonitorConfig.GroomLoadIndexesRetentionDays
		Line 2 "Machine Hotfix Log`t`t: " $MonitorConfig.GroomMachineHotfixLogRetentionDays
		If($MonitorConfig.ContainsKey("GroomMachineMetricDataRetentionDays"))
		{
			Line 2 "Machine Metric Data`t`t: " $MonitorConfig.GroomMachineMetricDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomMachineMetricDaySummaryDataRetentionDays"))
		{
			Line 2 "Machine Metric Day Summary`t: " $MonitorConfig.GroomMachineMetricDaySummaryDataRetentionDays
		}
		Line 2 "Minute`t`t`t`t: " $MonitorConfig.GroomMinuteRetentionDays
		If($MonitorConfig.ContainsKey("GroomNotificationLogRetentionDays"))
		{
			Line 2 "Notification`t`t`t: " $MonitorConfig.GroomNotificationLogRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageDayDataRetentionDays"))
		{
			Line 2 "Process Usage Day Data`t`t: " $MonitorConfig.GroomProcessUsageDayDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageHourDataRetentionDays"))
		{
			Line 2 "Process Usage Hour Data`t`t: " $MonitorConfig.GroomProcessUsageHourDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageMinuteDataRetentionDays"))
		{
			Line 2 "Process Usage Minute Data`t: " $MonitorConfig.GroomProcessUsageMinuteDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageRawDataRetentionDays"))
		{
			Line 2 "Process Usage Raw Data`t`t: " $MonitorConfig.GroomProcessUsageRawDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageDayDataRetentionDays"))
		{
			Line 2 "Resource Usage Day Data`t`t: " $MonitorConfig.GroomResourceUsageDayDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageHourDataRetentionDays"))
		{
			Line 2 "Resource Usage Hour Data`t: " $MonitorConfig.GroomResourceUsageHourDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageMinuteDataRetentionDays"))
		{
			Line 2 "Resource Usage Minute Data`t: " $MonitorConfig.GroomResourceUsageMinuteDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageRawDataRetentionDays"))
		{
			Line 2 "Resource Usage Raw Data`t`t: " $MonitorConfig.GroomResourceUsageRawDataRetentionDays
		}
		If($MonitorConfig.ContainsKey("GroomSessionMetricsDataRetentionDays"))
		{
			Line 2 "Session Metrics`t`t`t: " $MonitorConfig.GroomSessionMetricsDataRetentionDays
		}
		Line 2 "Sessions`t`t`t: " $MonitorConfig.GroomSessionsRetentionDays
		Line 2 "Summaries`t`t`t: " $MonitorConfig.GroomSummariesRetentionDays
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 2 0 "Datastores"
		
		$rowdata = @()
		$columnHeaders = @("Datastore",($htmlsilver -bor $htmlbold),"Site",$htmlwhite)
		$rowdata += @(,("Database Name",($htmlsilver -bor $htmlbold),$ConfigDatabaseName,$htmlwhite))
		$rowdata += @(,("Availability Database Synchronization State",($htmlsilver -bor $htmlbold),$ConfigDBAvailabilityDatabaseSynchronizationState,$htmlwhite))
		$rowdata += @(,("Availability Group Name",($htmlsilver -bor $htmlbold),$ConfigDBAvailabilityGroupName,$htmlwhite))
		$rowdata += @(,("Collation",($htmlsilver -bor $htmlbold),$ConfigDBCollation,$htmlwhite))
		$rowdata += @(,("Compatibility Level",($htmlsilver -bor $htmlbold),$ConfigDBCompatibilityLevel,$htmlwhite))
		$rowdata += @(,("Create Date",($htmlsilver -bor $htmlbold),$ConfigDBCreateDate,$htmlwhite))
		$rowdata += @(,("Database Size",($htmlsilver -bor $htmlbold),$ConfigDBSize,$htmlwhite))
		$rowdata += @(,("Last Backup Date",($htmlsilver -bor $htmlbold),$ConfigDBLastBackupDate,$htmlwhite))
		$rowdata += @(,("Last Log Backup Date",($htmlsilver -bor $htmlbold),$ConfigDBLastLogBackupDate,$htmlwhite))
		$rowdata += @(,("Mirror Server Address",($htmlsilver -bor $htmlbold),$ConfigSQLServerMirrorName,$htmlwhite))
		$rowdata += @(,("Mirroring Partner",($htmlsilver -bor $htmlbold),$ConfigDBMirroringPartner,$htmlwhite))
		$rowdata += @(,("Mirroring Partner Instance",($htmlsilver -bor $htmlbold),$ConfigDBMirroringPartnerInstance,$htmlwhite))
		$rowdata += @(,("Mirroring Safety Level",($htmlsilver -bor $htmlbold),$ConfigDBMirroringSafetyLevel,$htmlwhite))
		$rowdata += @(,("Mirroring Status",($htmlsilver -bor $htmlbold),$ConfigDBMirroringStatus,$htmlwhite))
		$rowdata += @(,("Mirroring Witness",($htmlsilver -bor $htmlbold),$ConfigDBMirroringWitness,$htmlwhite))
		$rowdata += @(,("Mirroring Witness Status",($htmlsilver -bor $htmlbold),$ConfigDBMirroringWitnessStatus,$htmlwhite))
		$rowdata += @(,("Parent",($htmlsilver -bor $htmlbold),$ConfigDBParent,$htmlwhite))
		$rowdata += @(,("Read-Committed Snapshot",($htmlsilver -bor $htmlbold),$ConfigDBReadCommittedSnapshot,$htmlwhite))
		$rowdata += @(,("Recovery Model",($htmlsilver -bor $htmlbold),$ConfigDBRecoveryModel,$htmlwhite))
		$rowdata += @(,("Server Address",($htmlsilver -bor $htmlbold),$ConfigSQLServerPrincipalName,$htmlwhite))
		$rowdata += @(,("SQL Server Version",($htmlsilver -bor $htmlbold),$ConfigDBSQLVersion,$htmlwhite))
		$msg = ""
		$columnWidths = @("250","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 ""

		$rowdata = @()
		$columnHeaders = @("Datastore",($htmlsilver -bor $htmlbold),"Logging",$htmlwhite)
		$rowdata += @(,("Database Name",($htmlsilver -bor $htmlbold),$LogDatabaseName,$htmlwhite))
		$rowdata += @(,("Availability Database Synchronization State",($htmlsilver -bor $htmlbold),$LogDBAvailabilityDatabaseSynchronizationState,$htmlwhite))
		$rowdata += @(,("Availability Group Name",($htmlsilver -bor $htmlbold),$LogDBAvailabilityGroupName,$htmlwhite))
		$rowdata += @(,("Collation",($htmlsilver -bor $htmlbold),$LogDBCollation,$htmlwhite))
		$rowdata += @(,("Compatibility Level",($htmlsilver -bor $htmlbold),$LogDBCompatibilityLevel,$htmlwhite))
		$rowdata += @(,("Create Date",($htmlsilver -bor $htmlbold),$LogDBCreateDate,$htmlwhite))
		$rowdata += @(,("Database Size",($htmlsilver -bor $htmlbold),$LogDBSize,$htmlwhite))
		$rowdata += @(,("Last Backup Date",($htmlsilver -bor $htmlbold),$LogDBLastBackupDate,$htmlwhite))
		$rowdata += @(,("Last Log Backup Date",($htmlsilver -bor $htmlbold),$LogDBLastLogBackupDate,$htmlwhite))
		$rowdata += @(,("Mirror Server Address",($htmlsilver -bor $htmlbold),$ConfigSQLServerMirrorName,$htmlwhite))
		$rowdata += @(,("Mirroring Partner",($htmlsilver -bor $htmlbold),$LogDBMirroringPartner,$htmlwhite))
		$rowdata += @(,("Mirroring Partner Instance",($htmlsilver -bor $htmlbold),$LogDBMirroringPartnerInstance,$htmlwhite))
		$rowdata += @(,("Mirroring Safety Level",($htmlsilver -bor $htmlbold),$LogDBMirroringSafetyLevel,$htmlwhite))
		$rowdata += @(,("Mirroring Status",($htmlsilver -bor $htmlbold),$LogDBMirroringStatus,$htmlwhite))
		$rowdata += @(,("Mirroring Witness",($htmlsilver -bor $htmlbold),$LogDBMirroringWitness,$htmlwhite))
		$rowdata += @(,("Mirroring Witness Status",($htmlsilver -bor $htmlbold),$LogDBMirroringWitnessStatus,$htmlwhite))
		$rowdata += @(,("Parent",($htmlsilver -bor $htmlbold),$LogDBParent,$htmlwhite))
		$rowdata += @(,("Read-Committed Snapshot",($htmlsilver -bor $htmlbold),$LogDBReadCommittedSnapshot,$htmlwhite))
		$rowdata += @(,("Recovery Model",($htmlsilver -bor $htmlbold),$LogDBRecoveryModel,$htmlwhite))
		$rowdata += @(,("Server Address",($htmlsilver -bor $htmlbold),$LogSQLServerPrincipalName,$htmlwhite))
		$rowdata += @(,("SQL Server Version",($htmlsilver -bor $htmlbold),$LogDBSQLVersion,$htmlwhite))
		$msg = ""
		$columnWidths = @("250","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 ""

		$rowdata = @()
		$columnHeaders = @("Datastore",($htmlsilver -bor $htmlbold),"Monitoring",$htmlwhite)
		$rowdata += @(,("Database Name",($htmlsilver -bor $htmlbold),$MonitorDatabaseName,$htmlwhite))
		$rowdata += @(,("Availability Database Synchronization State",($htmlsilver -bor $htmlbold),$MonitorDBAvailabilityDatabaseSynchronizationState,$htmlwhite))
		$rowdata += @(,("Availability Group Name",($htmlsilver -bor $htmlbold),$MonitorDBAvailabilityGroupName,$htmlwhite))
		$rowdata += @(,("Collation",($htmlsilver -bor $htmlbold),$MonitorDBCollation,$htmlwhite))
		$rowdata += @(,("Compatibility Level",($htmlsilver -bor $htmlbold),$MonitorDBCompatibilityLevel,$htmlwhite))
		$rowdata += @(,("Create Date",($htmlsilver -bor $htmlbold),$MonitorDBCreateDate,$htmlwhite))
		$rowdata += @(,("Database Size",($htmlsilver -bor $htmlbold),$MonitorDBSize,$htmlwhite))
		$rowdata += @(,("Last Backup Date",($htmlsilver -bor $htmlbold),$MonitorDBLastBackupDate,$htmlwhite))
		$rowdata += @(,("Last Log Backup Date",($htmlsilver -bor $htmlbold),$MonitorDBLastLogBackupDate,$htmlwhite))
		$rowdata += @(,("Mirror Server Address",($htmlsilver -bor $htmlbold),$ConfigSQLServerMirrorName,$htmlwhite))
		$rowdata += @(,("Mirroring Partner",($htmlsilver -bor $htmlbold),$MonitorDBMirroringPartner,$htmlwhite))
		$rowdata += @(,("Mirroring Partner Instance",($htmlsilver -bor $htmlbold),$MonitorDBMirroringPartnerInstance,$htmlwhite))
		$rowdata += @(,("Mirroring Safety Level",($htmlsilver -bor $htmlbold),$MonitorDBMirroringSafetyLevel,$htmlwhite))
		$rowdata += @(,("Mirroring Status",($htmlsilver -bor $htmlbold),$MonitorDBMirroringStatus,$htmlwhite))
		$rowdata += @(,("Mirroring Witness",($htmlsilver -bor $htmlbold),$MonitorDBMirroringWitness,$htmlwhite))
		$rowdata += @(,("Mirroring Witness Status",($htmlsilver -bor $htmlbold),$MonitorDBMirroringWitnessStatus,$htmlwhite))
		$rowdata += @(,("Parent",($htmlsilver -bor $htmlbold),$MonitorDBParent,$htmlwhite))
		$rowdata += @(,("Read-Committed Snapshot",($htmlsilver -bor $htmlbold),$MonitorDBReadCommittedSnapshot,$htmlwhite))
		$rowdata += @(,("Recovery Model",($htmlsilver -bor $htmlbold),$MonitorDBRecoveryModel,$htmlwhite))
		$rowdata += @(,("Server Address",($htmlsilver -bor $htmlbold),$MonitorSQLServerPrincipalName,$htmlwhite))
		$rowdata += @(,("SQL Server Version",($htmlsilver -bor $htmlbold),$MonitorDBSQLVersion,$htmlwhite))
		$msg = ""
		$columnWidths = @("250","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "

		WriteHTMLLine 3 0 "Monitoring Database Details"
		$rowdata = @()
		$columnHeaders = @("Collect Hotfix Data",($htmlsilver -bor $htmlbold),$MonitorCollectHotfix,$htmlwhite)
		$rowdata += @(,('Data Collection',($htmlsilver -bor $htmlbold),$MonitorDataCollection,$htmlwhite))
		$rowdata += @(,('Detail SQL Output',($htmlsilver -bor $htmlbold),$MonitorDetailedSQL,$htmlwhite))
		If($MonitorConfig.ContainsKey("EnableDayLevelGranularityProcessUtilization"))
		{
			$rowdata += @(,('Enable Day Level Granularity',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("EnableHourLevelGranularityProcessUtilization"))
		{
			$rowdata += @(,('Enable Hour Level Granularity',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("EnableMinLevelGranularityProcessUtilization"))
		{
			$rowdata += @(,('Enable Minute Level Granularity',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		}
		$rowdata += @(,('Full Poll Start Hour',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		If($MonitorConfig.ContainsKey("MonitorQueryTimeoutSeconds"))
		{
			$rowdata += @(,('Monitor Query Timeout Seconds',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		}
		$rowdata += @(,('Resolution Poll Time Hours',($htmlsilver -bor $htmlbold),$MonitorConfig.FullPollStartHour,$htmlwhite))
		$rowdata += @(,('Sync Poll Time Hours',($htmlsilver -bor $htmlbold),$MonitorConfig.SyncPollTimeHours,$htmlwhite))

		$msg = ""
		$columnWidths = @("200","50")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "250"
		WriteHTMLLine 0 0 " "
		
		WriteHTMLLine 3 0 "Groom Retention Settings in Days"
		$rowdata = @()
		$columnHeaders = @("",($htmlsilver -bor $htmlbold),"",$htmlwhite)
		If($MonitorConfig.ContainsKey("GroomApplicationErrorsRetentionDays"))
		{
			$rowdata += @(,('Application Errors',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomApplicationErrorsRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomApplicationFaultsRetentionDays"))
		{
			$rowdata += @(,('Application Faults',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomApplicationFaultsRetentionDays,$htmlwhite))
		}
		$rowdata += @(,('Application Instance',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomApplicationInstanceRetentionDays,$htmlwhite))
		$rowdata += @(,('Deleted',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomDeletedRetentionDays,$htmlwhite))
		$rowdata += @(,('Failures',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomFailuresRetentionDays,$htmlwhite))
		If($MonitorConfig.ContainsKey("GroomHourlyRetentionDays"))
		{
			$rowdata += @(,('Hourly Retention',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomHourlyRetentionDays,$htmlwhite))
		}
		$rowdata += @(,('Load Indexes',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomLoadIndexesRetentionDays,$htmlwhite))
		$rowdata += @(,('Machine Hotfix Log',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomMachineHotfixLogRetentionDays,$htmlwhite))
		If($MonitorConfig.ContainsKey("GroomMachineMetricDataRetentionDays"))
		{
			$rowdata += @(,('Machine Metric Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomMachineMetricDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomMachineMetricDaySummaryDataRetentionDays"))
		{
			$rowdata += @(,('Machine Metric Day Summary',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomMachineMetricDaySummaryDataRetentionDays,$htmlwhite))
		}
		$rowdata += @(,('Minute',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomMinuteRetentionDays,$htmlwhite))
		If($MonitorConfig.ContainsKey("GroomNotificationLogRetentionDays"))
		{
			$rowdata += @(,('Notification',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomNotificationLogRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageDayDataRetentionDays"))
		{
			$rowdata += @(,('Process Usage Day Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomProcessUsageDayDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageHourDataRetentionDays"))
		{
			$rowdata += @(,('Process Usage Hour Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomProcessUsageHourDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageMinuteDataRetentionDays"))
		{
			$rowdata += @(,('Process Usage Minute Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomProcessUsageMinuteDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomProcessUsageRawDataRetentionDays"))
		{
			$rowdata += @(,('Process Usage Raw Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomProcessUsageRawDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageDayDataRetentionDays"))
		{
			$rowdata += @(,('Resource Usage Day Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomResourceUsageDayDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageHourDataRetentionDays"))
		{
			$rowdata += @(,('Resource Usage Hour Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomResourceUsageHourDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageMinuteDataRetentionDays"))
		{
			$rowdata += @(,('Resource Usage Minute Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomResourceUsageMinuteDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomResourceUsageRawDataRetentionDays"))
		{
			$rowdata += @(,('Resource Usage Raw Data',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomResourceUsageRawDataRetentionDays,$htmlwhite))
		}
		If($MonitorConfig.ContainsKey("GroomSessionMetricsDataRetentionDays"))
		{
			$rowdata += @(,('Session Metrics',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomSessionMetricsDataRetentionDays,$htmlwhite))
		}
		$rowdata += @(,('Sessions',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomSessionsRetentionDays,$htmlwhite))
		$rowdata += @(,('Summaries',($htmlsilver -bor $htmlbold),$MonitorConfig.GroomSummariesRetentionDays,$htmlwhite))

		$msg = ""
		$columnWidths = @("200","50")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "250"
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region Administrator, Scope and Roles functions
Function ProcessAdministrators
{
	Write-Verbose "$(Get-Date): Processing Administrators"
	Write-Verbose "$(Get-Date): `tRetrieving Administrator data"
	
	$Script:TotalDeliveryGroupAdmins = 0
	$Script:TotalFullAdmins = 0
	$Script:TotalHelpDeskAdmins = 0
	$Script:TotalHostAdmins = 0
	$Script:TotalMachineCatalogAdmins = 0
	$Script:TotalReadOnlyAdmins = 0
	$Script:TotalCustomAdmins = 0
	
	$Admins = Get-AdminAdministrator @XDParams2 | Sort-Object Name

	If($? -and ($Null -ne $Admins))
	{
		OutputAdministrators $Admins
	}
	ElseIf($? -and ($Null -eq $Admins))
	{
		$txt = "There are no Administrators"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Administrators"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputAdministrators
{
	Param([object] $Admins)
	
	Write-Verbose "$(Get-Date): `tOutput Administrator data"
	
	ForEach($Admin in $Admins)
	{
		Switch ($Admin.Rights.RoleName)
		{
			"Delivery Group Administrator"	{$Script:TotalDeliveryGroupAdmins++; Break}
			"Full Administrator"			{$Script:TotalFullAdmins++; Break}
			"Help Desk Administrator"		{$Script:TotalHelpDeskAdmins++; Break}
			"Host Administrator"			{$Script:TotalHostAdmins++; Break}
			"Machine Catalog Administrator"	{$Script:TotalMachineCatalogAdmins++; Break}
			"Read Only Administrator"		{$Script:TotalReadOnlyAdmins++; Break}
			Default							{$Script:TotalCustomAdmins++; Break}
		}
	}
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Administrators"
		[System.Collections.Hashtable[]] $AdminsWordTable = @();
		ForEach($Admin in $Admins)
		{
			$Tmp = $Null
			If($Admin.Enabled -eq $True)
			{
				$Tmp = "Enabled"
			}
			Else
			{
				$Tmp = "Disabled"
			}
			$WordTableRowHash = @{Name = $Admin.Name; Scope = $Admin.Rights.ScopeName; Role = $Admin.Rights.RoleName; Status = $Tmp;}

			$AdminsWordTable += $WordTableRowHash;
		}
		$Table = AddWordTable -Hashtable $AdminsWordTable `
		-Columns Name, Scope, Role, Status `
		-Headers "Name", "Scope", "Role", "Status" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Administrators"
		Line 0 ""
		ForEach($Admin in $Admins)
		{
			Line 1 "Name`t: " $Admin.Name
			Line 1 "Scope`t: " $Admin.Rights.ScopeName
			Line 1 "Role`t: " $Admin.Rights.RoleName
			Line 1 "Status`t: " -NoNewLine
			If($Admin.Enabled -eq $True)
			{
				Line 0 "Enabled"
			}
			Else
			{
				Line 0 "Disabled"
			}
			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		WriteHTMLLine 1 0 "Administrators"
		ForEach($Admin in $Admins)
		{
			$xType = ""
			If($Admin.Enabled -eq $True)
			{
				$xType = "Enabled"
			}
			Else
			{
				$xType = "Disabled"
			}
			$rowdata += @(,(
			$Admin.Name,$htmlwhite,
			$Admin.Rights.ScopeName,$htmlwhite,
			$Admin.Rights.RoleName,$htmlwhite,
			$xType,$htmlwhite))
		}
		$columnHeaders = @(
		'Name',($htmlsilver -bor $htmlbold),
		'Scope',($htmlsilver -bor $htmlbold),
		'Role',($htmlsilver -bor $htmlbold),
		'Status',($htmlsilver -bor $htmlbold))

		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
}

Function ProcessScopes
{
	Write-Verbose "$(Get-Date): Processing Administrator Scopes"
	$Scopes = Get-AdminScope @XDParams2 -SortBy Name
	
	If($? -and ($Null -ne $Scopes))
	{
		OutputScopes $Scopes
		If($Administrators)
		{
			OutputScopeObjects $Scopes
			OutputScopeAdministrators $Scopes
		}
	}
	ElseIf($? -and ($Null -eq $Scopes))
	{
		$txt = "There are no Administrator Scopes"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Administrator Scopes"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputScopes
{
	Param([object] $Scopes)
	
	Write-Verbose "$(Get-Date): `tOutput Scopes"
	If($MSWord -or $PDF)
	{
		WriteWordLine 2 0 "Administrative Scopes"
		[System.Collections.Hashtable[]] $ScopesWordTable = @();
		ForEach($Scope in $Scopes)
		{
			$WordTableRowHash = @{ Name = $Scope.Name; Description = $Scope.Description;}

			$ScopesWordTable += $WordTableRowHash;
		}
		$Table = AddWordTable -Hashtable $ScopesWordTable `
		-Columns Name, Description `
		-Headers "Name", "Description" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Administrative Scopes"
		Line 0 ""
		ForEach($Scope in $Scopes)
		{
			Line 1 "Name`t`t: " $Scope.Name
			Line 1 "Description`t: " $Scope.Description
			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		WriteHTMLLine 2 0 "Administrative Scopes"
		ForEach($Scope in $Scopes)
		{
			$rowdata += @(,(
			$Scope.Name,$htmlwhite,
			$Scope.Description,$htmlwhite))
		}
		$columnHeaders = @(
		'Name',($htmlsilver -bor $htmlbold),
		'Description',($htmlsilver -bor $htmlbold))

		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
}

Function OutputScopeObjects
{
	Param([object] $Scopes)
	
	Write-Verbose "$(Get-Date): `t`tOutput Scope Objects"

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		
		ForEach($Scope in $Scopes)
		{
			WriteWordLine 3 0 "Scope Objects for $($Scope.Name)"

			$Results = GetScopeDG $Scope
			
			If($Results.Count -gt 0)
			{
				[System.Collections.Hashtable[]] $WordTable = @();

				WriteWordLine 4 0 "Delivery Groups"
				
				ForEach($Result in $Results)
				{
					$WordTableRowHash = @{ 
					GroupName = $Result.Name; 
					GroupDesc = $Result.Description; 
					}

					$WordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $WordTable `
				-Columns GroupName, GroupDesc `
				-Headers "Name", "Description" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 250;
				$Table.Columns.Item(2).Width = 250;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
			}

			$Results = GetScopeMC $Scope

			If($Results.Count -gt 0)
			{
				[System.Collections.Hashtable[]] $WordTable = @();

				WriteWordLine 4 0 "Machine Catalogs"
				ForEach($Result in $Results)
				{
					$WordTableRowHash = @{ 
					CatalogName = $Result.Name; 
					CatalogDesc = $Result.Description; 
					}

					$WordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $WordTable `
				-Columns CatalogName, CatalogDesc `
				-Headers "Name", "Description" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 250;
				$Table.Columns.Item(2).Width = 250;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
			}

			$Results = GetScopeHyp $Scope

			If($Results.Count -gt 0)
			{
				[System.Collections.Hashtable[]] $WordTable = @();

				WriteWordLine 4 0 "Hosting"
				ForEach($Result in $Results)
				{
					$WordTableRowHash = @{ 
					HypName = $Result.Name; 
					HypDesc = $Result.Description; 
					}

					$WordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $WordTable `
				-Columns HypName, HypDesc `
				-Headers "Name", "Description" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 250;
				$Table.Columns.Item(2).Width = 250;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
			}

			WriteWordLine 0 0 ""
		}
	}
	ElseIf($Text)
	{
		ForEach($Scope in $Scopes)
		{
			Line 0 "Scope Objects for $($Scope.Name)"

			$Results = GetScopeDG $Scope
			
			If($Results.Count -gt 0)
			{
				Line 0 "Delivery Groups"
				
				ForEach($Result in $Results)
				{
					Line 1 "Name: " $Result.Name
					Line 1 "Description: " $Result.Description
					Line 0 ""
				}
			}

			$Results = GetScopeMC $Scope

			If($Results.Count -gt 0)
			{
				Line 0 "Machine Catalogs"
				ForEach($Result in $Results)
				{
					Line 1 "Name: " $Result.Name
					Line 1 "Description: " $Result.Description
					Line 0 ""
				}
			}

			$Results = GetScopeHyp $Scope

			If($Results.Count -gt 0)
			{
				Line 0 "Hosting"
				ForEach($Result in $Results)
				{
					Line 1 "Name: " $Result.Name
					Line 1 "Description: " $Result.Description
					Line 0 ""
				}
			}

			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		ForEach($Scope in $Scopes)
		{
			WriteHTMLLine 3 0 "Scope Objects for $($Scope.Name)"

			$Results = GetScopeDG $Scope
			
			If($Results.Count -gt 0)
			{
				WriteHTMLLine 4 0 "Delivery Groups"
				$rowdata = @()

				ForEach($Result in $Results)
				{
					$rowdata += @(,(
					$Result.Name,$htmlwhite,
					$Result.Description,$htmlwhite))
				}
				$columnHeaders = @(
				'Name',($htmlsilver -bor $htmlbold),
				'Description',($htmlsilver -bor $htmlbold))
				$msg = ""
				$ColumnWidths = @("250","250")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $ColumnWidths -tablewidth "500"
				WriteHTMLLine 0 0 " "
			}

			$Results = GetScopeMC $Scope

			If($Results.Count -gt 0)
			{
				WriteHTMLLine 4 0 "Machine Catalogs"
				$rowdata = @()

				ForEach($Result in $Results)
				{
					$rowdata += @(,(
					$Result.Name,$htmlwhite,
					$Result.Description,$htmlwhite))
				}
				$columnHeaders = @(
				'Name',($htmlsilver -bor $htmlbold),
				'Description',($htmlsilver -bor $htmlbold))
				$msg = ""
				$ColumnWidths = @("250","250")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $ColumnWidths -tablewidth "500"
				WriteHTMLLine 0 0 " "
			}

			$Results = GetScopeHyp $Scope

			If($Results.Count -gt 0)
			{
				WriteHTMLLine 4 0 "Hosting"
				$rowdata = @()

				ForEach($Result in $Results)
				{
					$rowdata += @(,(
					$Result.Name,$htmlwhite,
					$Result.Description,$htmlwhite))
				}
				$columnHeaders = @(
				'Name',($htmlsilver -bor $htmlbold),
				'Description',($htmlsilver -bor $htmlbold))
				$msg = ""
				$ColumnWidths = @("250","250")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $ColumnWidths -tablewidth "500"
				WriteHTMLLine 0 0 " "
			}

			WriteHTMLLine 0 0 " "
		}
	}
}

Function GetScopeDG
{
	Param([object] $Scope)
	
	$DG = @()
	#get delivery groups
	If($Scope.Name -eq "All")
	{
		$Results = Get-BrokerDesktopGroup @XDParams2 | `
		Select-Object Name, Description, Scopes | `
		Sort-Object Name -unique
	}
	Else
	{
		$Results = Get-BrokerDesktopGroup @XDParams2 | `
		Select-Object Name, Description, Scopes | `
		WHere-Object {$_.Scopes -like $Scope.Name} | `
		Sort-Object Name -unique
	}
	
	If($? -and $Null -ne $Results)
	{
		ForEach($Result in $Results)
		{
			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name        -Value $Result.Name
			$obj | Add-Member -MemberType NoteProperty -Name Description -Value $Result.Description
			
			$DG += $obj
		}
	}

	Return ,$DG
}

Function GetScopeMC
{
	Param([object] $Scope)
	
	#get machine catalogs
	$MC = @()
	
	If($Scope.Name -eq "All")
	{
		$Results = Get-BrokerCatalog @XDParams2 | `
		Select-Object Name, Description, Scopes | `
		Sort-Object Name -unique
	}
	Else
	{
		$Results = Get-BrokerCatalog @XDParams2 | `
		Select-Object Name, Description, Scopes | `
		Where-Object {$_.Scopes -like $Scope.Name} | `
		Sort-Object Name -unique
	}

	If($? -and $Null -ne $Results)
	{
		ForEach($Result in $Results)
		{
			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name        -Value $Result.Name
			$obj | Add-Member -MemberType NoteProperty -Name Description -Value $Result.Description
			
			$MC += $obj
		}
	}

	Return ,$MC
}

Function GetScopeHyp
{
	Param([object] $Scope)
	
	#get hypervisor connections
	$Hyp = @()
	
	If($Scope.Name -eq "All")
	{
		$Results = Get-HypScopedObject @XDParams2 | `
		Select-Object ObjectName, Description, ScopeName | `
		Sort-Object ObjectName -unique
	}
	Else
	{
		$Results = Get-HypScopedObject @XDParams2 | `
		Select-Object ObjectName, Description, ScopeName | `
		Where-Object {$_.ScopeName -like $Scope.Name} | `
		Sort-Object ObjectName -unique
	}

	If($? -and $Null -ne $Results)
	{
		ForEach($Result in $Results)
		{
			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name Name        -Value $Result.ObjectName
			$obj | Add-Member -MemberType NoteProperty -Name Description -Value $Result.Description
			
			$Hyp += $obj
		}
	}

	Return ,$Hyp
}

Function OutputScopeAdministrators 
{
	Param([object] $Scopes)
	Write-Verbose "$(Get-Date): `t`tOutput Scope Administrators"
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		
		ForEach($Scope in $Scopes)
		{
			[System.Collections.Hashtable[]] $WordTable = @();
			WriteWordLine 3 0 "Administrators for Scope: $($Scope.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.ScopeName -Contains $Scope.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xRoleName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.ScopeName -eq $Scope.Name -or $Right.ScopeName -eq "All")
						{
							$xRoleName = $Right.RoleName
						}
					}
					
					$WordTableRowHash = @{ 
					AdminName = $Admin.Name; 
					Role = $xRoleName; 
					Type = $xEnabled;
					}

					$WordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $WordTable `
				-Columns AdminName, Role, Type `
				-Headers "Administrator Name", "Role", "Status" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 220;
				$Table.Columns.Item(2).Width = 225;
				$Table.Columns.Item(3).Width = 55;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
				WriteWordLine 0 0 ""
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				WriteWordLine 0 0 "No administrators defined"
				WriteWordLine 0 0 ""
			}
			Else
			{
				WriteWordLine 0 0 "Unable to retrieve administrators"
				WriteWordLine 0 0 ""
			}
		}
	}
	ElseIf($Text)
	{
		ForEach($Scope in $Scopes)
		{
			Line 1 "Administrators for Scope: $($Scope.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.ScopeName -Contains $Scope.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xRoleName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.ScopeName -eq $Scope.Name -or $Right.ScopeName -eq "All")
						{
							$xRoleName = $Right.RoleName
						}
					}
					
					Line 2 "Administrator Name`t: " $Admin.Name
					Line 2 "Role`t`t`t: " $xRoleName
					Line 2 "Status`t`t`t: " $xEnabled
					Line 0 ""
				}
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				Line 2 "No administrators defined"
				Line 0 ""
			}
			Else
			{
				Line 2 "Unable to retrieve administrators"
				Line 0 ""
			}
		}
	}
	ElseIf($HTML)
	{
		ForEach($Scope in $Scopes)
		{
			$rowdata = @()
			WriteHTMLLine 3 0 "Administrators for Scope: $($Scope.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.ScopeName -Contains $Scope.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xRoleName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.ScopeName -eq $Scope.Name -or $Right.ScopeName -eq "All")
						{
							$xRoleName = $Right.RoleName
						}
					}
					
					$rowdata += @(,(
					$Admin.Name,$htmlwhite,
					$xRoleName,$htmlwhite,
					$xEnabled,$htmlwhite))
				}
				$columnHeaders = @(
				'Administrator Name',($htmlsilver -bor $htmlbold),
				'Role',($htmlsilver -bor $htmlbold),
				'Status',($htmlsilver -bor $htmlbold))

				$msg = ""
				$columnWidths = @("220","225","55")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
				WriteHTMLLine 0 0 " "
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				WriteHTMLLine 0 0 "No administrators defined"
				WriteHTMLLine 0 0 " "
			}
			Else
			{
				WriteHTMLLine 0 0 "Unable to retrieve administrators"
				WriteHTMLLine 0 0 " "
			}
		}
	}
}

Function ProcessRoles
{
	Write-Verbose "$(Get-Date): Processing Administrator Roles"
	$Roles = Get-AdminRole @XDParams2 -SortBy Name

	If($? -and ($Null -ne $Roles))
	{
		OutputRoles $Roles
		If($Administrators)
		{
			OutputRoleDefinitions $Roles
			OutputRoleAdministrators $Roles
		}
	}
	ElseIf($? -and ($Null -eq $Roles))
	{
		$txt = "There are no Administrator Roles"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Administrator Roles"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputRoles
{
	Param([object] $Roles)
	
	Write-Verbose "$(Get-Date): `tOutput Roles"
	If($MSWord -or $PDF)
	{
		If($Administrators)
		{
			$Selection.InsertNewPage()
		}
		WriteWordLine 2 0 "Administrative Roles"
		[System.Collections.Hashtable[]] $RolesWordTable = @();
		ForEach($Role in $Roles)
		{
			$Tmp = $Null
			If($Role.BuiltIn)
			{
				$Tmp = "Built In"
			}
			Else
			{
				$Tmp = "Custom"
			}
			$WordTableRowHash = @{ Role = $Role.Name; Description = $Role.Description; Type = $Tmp;}

			$RolesWordTable += $WordTableRowHash;
		}
		$Table = AddWordTable -Hashtable $RolesWordTable `
		-Columns Role, Description, Type `
		-Headers "Role", "Description", "Type" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 300;
		$Table.Columns.Item(3).Width = 50;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Administrative Roles"
		Line 0 ""
		ForEach($Role in $Roles)
		{
			Line 1 "Role`t`t: " $Role.Name
			Line 1 "Description`t: " $Role.Description
			Line 1 "Type`t`t: " -NoNewLine
			If($Role.BuiltIn)
			{
				Line 0 "Built In"
			}
			Else
			{
				Line 0 "Custom"
			}
			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		$rowdata = @()
		WriteHTMLLine 2 0 "Administrative Roles"
		ForEach($Role in $Roles)
		{
			$xType = ""
			If($Role.BuiltIn)
			{
				$xType = "Built In"
			}
			Else
			{
				$xType = "Custom"
			}
			$rowdata += @(,(
			$Role.Name,$htmlwhite,
			$Role.Description,$htmlwhite,
			$xType,$htmlwhite))
		}
		$columnHeaders = @(
		'Role',($htmlsilver -bor $htmlbold),
		'Description',($htmlsilver -bor $htmlbold),
		'Type',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("150","300","50")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputRoleDefinitions
{
	Param([object] $Roles)
	Write-Verbose "$(Get-Date): `t`tOutput Role Definitions"
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		
		ForEach($Role in $Roles)
		{
			[System.Collections.Hashtable[]] $WordTable = @();
			WriteWordLine 3 0 "Role definition for $($Role.Name)"
			WriteWordLine 0 0 "Details - " $Role.Name
			WriteWordLine 0 0 $Role.Description
			$Permissions = $Role.Permissions
			$Results = GetRolePermissions $Permissions

			$comp = ""
			$x = 0
			ForEach($Result in $Results)
			{
				If($x -eq 0)
				{
					$comp = $Result.Value
					$WordTableRowHash = @{ 
					FolderName = $Result.Value; 
					Permission = $Result.Name; 
					}

					$WordTable += $WordTableRowHash;
				}
				Else
				{
					If($comp -eq $Result.value)
					{
						$WordTableRowHash = @{ 
						FolderName = ""; 
						Permission = $Result.Name; 
						}

						$WordTable += $WordTableRowHash;
					}
					Else
					{
						$comp = $Result.Value
						$WordTableRowHash = @{ 
						FolderName = $Result.Value; 
						Permission = $Result.Name; 
						}

						$WordTable += $WordTableRowHash;
					}
				}
				$x++
			}

			$Table = AddWordTable -Hashtable $WordTable `
			-Columns FolderName, Permission `
			-Headers "Folder Name", "Permissions" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 100;
			$Table.Columns.Item(2).Width = 400;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
	}
	ElseIf($Text)
	{
		ForEach($Role in $Roles)
		{
			Line 0 "Role definition for $($Role.Name)"
			Line 0 "Details - " $Role.Name
			Line 0 $Role.Description
			Line 0 ""
			$Permissions = $Role.Permissions
			$Results = GetRolePermissions $Permissions

			ForEach($Result in $Results)
			{
				Line 1 "Folder Name`t: " $Result.Value
				Line 1 "Permission`t: " $Result.Name
				Line 0 ""
			}

			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		ForEach($Role in $Roles)
		{
			$rowdata = @()
			WriteHTMLLine 3 0 "Role definition for $($Role.Name)"
			WriteHTMLLine 0 0 "Details - " $Role.Name
			WriteHTMLLine 0 0 $Role.Description
			$Permissions = $Role.Permissions
			$Results = GetRolePermissions $Permissions

			$comp = ""
			$x = 0
			ForEach($Result in $Results)
			{
				If($x -eq 0)
				{
					$comp = $Result.Value
					$rowdata += @(,(
					$Result.Value,$htmlwhite,
					$Result.Name,$htmlwhite))
				}
				Else
				{
					If($comp -eq $Result.value)
					{
						$rowdata += @(,(
						"",$htmlwhite,
						$Result.Name,$htmlwhite))
					}
					Else
					{
						$comp = $Result.Value
						$rowdata += @(,(
						$Result.Value,$htmlwhite,
						$Result.Name,$htmlwhite))
					}
				}
				$x++
			}

			$columnHeaders = @(
			'Folder Name',($htmlsilver -bor $htmlbold),
			'Permissions',($htmlsilver -bor $htmlbold))

			$msg = ""
			$ColumnWidths = @("100","400")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders	-fixedWidth $columnWidths -tablewidth "500"
			WriteHTMLLine 0 0 " "
		}
	}
}

Function GetRolePermissions
{
	Param([object] $Permissions)
	
	$Results = @{}
	
	ForEach($Permission in $Permissions)
	{
		Switch ($Permission)
		{
			"Admin_FullControl"											{$Results.Add("Manage Administrators", "Administrators"); Break}
			"Admin_Read"												{$Results.Add("View Administrators", "Administrators"); Break}
			"Applications_AttachClientHostedApplicationToDesktopGroup"	{$Results.Add("Attach Local Access Application to Delivery Group", "Delivery Groups"); Break}
			"Applications_ChangeMaintenanceMode"						{$Results.Add("Enable/disable maintenance mode of an Application", "Delivery Groups"); Break}
			"Applications_ChangeTags"									{$Results.Add("Edit Application tags", "Delivery Groups"); Break}
			"Applications_ChangeUserAssignment"							{$Results.Add("Change users assigned to an application", "Delivery Groups"); Break}
			"Applications_Create"										{$Results.Add("Create Application", "Delivery Groups"); Break}
			"Applications_CreateFolder"									{$Results.Add("Create Application Folder", "Delivery Groups"); Break}
			"Applications_Delete"										{$Results.Add("Delete Application", "Delivery Groups"); Break}
			"Applications_DetachClientHostedApplicationToDesktopGroup"	{$Results.Add("Detach Local Access Application from Delivery Group", "Delivery Groups"); Break}
			"Applications_EditFolder"									{$Results.Add("Edit Application Folder", "Delivery Groups"); Break}
			"Applications_EditProperties"								{$Results.Add("Edit Application Properties", "Delivery Groups"); Break}
			"Applications_MoveFolder"									{$Results.Add("Move Application Folder", "Delivery Groups"); Break}
			"Applications_Read"											{$Results.Add("View Applications", "Delivery Groups"); Break}
			"Applications_RemoveFolder"									{$Results.Add("Remove Application Folder", "Delivery Groups"); Break}
			"AppV_AddServer"											{$Results.Add("Add App-V publishing server", "App-V"); Break}
			"AppV_DeleteServer"											{$Results.Add("Delete App-V publishing server", "App-V"); Break}
			"AppV_Read"													{$Results.Add("Read App-V servers", "App-V"); Break}
			"Catalog_AddMachines"										{$Results.Add("Add Machines to Machine Catalog", "Machine Catalogs"); Break}
			"Catalog_AddScope"											{$Results.Add("Add Machine Catalog to Scope", "Machine Catalogs"); Break}
			"Catalog_CancelProvTask"									{$Results.Add("Cancel Provisioning Task", "Machine Catalogs"); Break}
			"Catalog_ChangeMachineMaintenanceMode"						{$Results.Add("Enable/disable maintenance mode of a machine via Machine Catalog membership", "Machine Catalogs"); Break}
			"Catalog_ChangeMaintenanceMode"								{$Results.Add("Enable/disable maintenance mode on Desktop via Machine Catalog membership", "Machine Catalogs"); Break}
			"Catalog_ChangeUserAssignment"								{$Results.Add("Change users assigned to a machine", "Machine Catalogs"); Break}
			"Catalog_ConsumeMachines"									{$Results.Add("Allow machines to be consumed by a Delivery Group", "Machine Catalogs"); Break}
			"Catalog_Create"											{$Results.Add("Create Machine Catalog", "Machine Catalogs"); Break}
			"Catalog_Delete"											{$Results.Add("Delete Machine Catalog", "Machine Catalogs"); Break}
			"Catalog_EditProperties"									{$Results.Add("Edit Machine Catalog Properties", "Machine Catalogs"); Break}
			"Catalog_ManageAccounts"									{$Results.Add("Manage Active Directory Accounts", "Machine Catalogs"); Break}
			"Catalog_PowerOperations_RDS"								{$Results.Add("Perform power operations on Windows Server machines via Machine Catalog membership", "Machine Catalogs"); Break}
			"Catalog_PowerOperations_VDI"								{$Results.Add("Perform power operations on Windows Desktop machines via Machine Catalog membership", "Machine Catalogs"); Break}
			"Catalog_Read"												{$Results.Add("View Machine Catalogs", "Machine Catalogs"); Break}
			"Catalog_RemoveMachine"										{$Results.Add("Remove Machines from Machine Catalog", "Machine Catalogs"); Break}
			"Catalog_RemoveScope"										{$Results.Add("Remove Machine Catalog from Scope", "Machine Catalogs"); Break}
			"Catalog_SessionManagement"									{$Results.Add("Perform session management on machines via Machine Catalog membership", "Machine Catalogs"); Break}
			"Catalog_UpdateMasterImage"									{$Results.Add("Perform Machine update", "Machine Catalogs"); Break}
			"Configuration_Read"										{$Results.Add("Read Site Configuration (Configuration_Read)", "Other permissions"); Break}
			"Configuration_Write"										{$Results.Add("Update Site Configuration (Configuration_Write)", "Other permissions"); Break}
			"Controllers_Remove"										{$Results.Add("Remove Delivery Controller", "Controllers"); Break}
			"DesktopGroup_AddApplication"								{$Results.Add("Add Application to Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_AddMachines"									{$Results.Add("Add Machines to Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_AddScope"										{$Results.Add("Add Delivery Group to Scope", "Delivery Groups"); Break}
			"DesktopGroup_ChangeMachineMaintenanceMode"					{$Results.Add("Enable/disable maintenance mode of a machine via Delivery Group membership", "Delivery Groups"); Break}
			"DesktopGroup_ChangeMaintenanceMode"						{$Results.Add("Enable/disable maintenance mode of a Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_ChangeTags"									{$Results.Add("Edit Delivery Group tags", "Delivery Groups"); Break}
			"DesktopGroup_ChangeUserAssignment"							{$Results.Add("Change users assigned to a desktop", "Delivery Groups"); Break}
			"DesktopGroup_Create"										{$Results.Add("Create Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_Delete"										{$Results.Add("Delete Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_EditProperties"								{$Results.Add("Edit Delivery Group Properties", "Delivery Groups"); Break}
			"DesktopGroup_PowerOperations_RDS"							{$Results.Add("Perform power operations on Windows Server machines via Delivery Group membership", "Delivery Groups"); Break}
			"DesktopGroup_PowerOperations_VDI"							{$Results.Add("Perform power operations on Windows Desktop machines via Delivery Group membership", "Delivery Groups"); Break}
			"DesktopGroup_Read"											{$Results.Add("View Delivery Groups", "Delivery Groups"); Break}
			"DesktopGroup_RemoveApplication"							{$Results.Add("Remove Application from Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_RemoveDesktop"								{$Results.Add("Remove Desktop from Delivery Group", "Delivery Groups"); Break}
			"DesktopGroup_RemoveScope"									{$Results.Add("Remove Delivery Group from Scope", "Delivery Groups"); Break}
			"DesktopGroup_SessionManagement"							{$Results.Add("Perform session management on machines via Delivery Group membership", "Delivery Groups"); Break}
			"Director_ClientDetails_Read"								{$Results.Add("View Client Details page", "Director"); Break}
			"Director_ClientHelpDesk_Read"								{$Results.Add("View Client Activity Manager page", "Director"); Break}
			"Director_Dashboard_Read"									{$Results.Add("View Dashboard page", "Director"); Break}
			"Director_DesktopHardwareInformation_Edit"					{$Results.Add("Edit Machine Hardware related Broker machine command properties", "Director"); Break}
			"Director_HDXInformation_Edit"								{$Results.Add("Edit HDX related Broker machine command properties", "Director"); Break}
			"Director_HelpDesk_Read"									{$Results.Add("View Activity Manager page", "Director"); Break}
			"Director_KillApplication"									{$Results.Add("Perform Kill Application running on a machine", "Director"); Break}
			"Director_KillApplication_Edit"								{$Results.Add("Edit Kill Application related Broker machine command properties", "Director"); Break}
			"Director_KillProcess"										{$Results.Add("Perform Kill Process running on a machine", "Director"); Break}
			"Director_KillProcess_Edit"									{$Results.Add("Edit Kill Process related Broker machine command properties", "Director"); Break}
			"Director_LatencyInformation_Edit"							{$Results.Add("Edit Latency related Broker machine command properties", "Director"); Break}
			"Director_MachineDetails_Read"								{$Results.Add("View Machine Details page", "Director"); Break}
			"Director_MachineMetricValues_Edit"							{$Results.Add("Edit Machine metric related Broker machine command properties", "Director"); Break}
			"Director_PersonalizationInformation_Edit"					{$Results.Add("Edit Personalization related Broker machine command properties", "Director"); Break}
			"Director_PoliciesInformation_Edit"							{$Results.Add("Edit Policies related Broker machine command properties", "Director"); Break}
			"Director_ResetVDisk"										{$Results.Add("Perform Reset VDisk operation", "Director"); Break}
			"Director_ResetVDisk_Edit"									{$Results.Add("Edit Reset VDisk related Broker machine command properties", "Director"); Break}
			"Director_RoundTripInformation_Edit"						{$Results.Add("Edit Roundtrip Time related Broker machine command properties", "Director"); Break}
			"Director_ShadowSession"									{$Results.Add("Perform Remote Assistance on a machine", "Director"); Break}
			"Director_ShadowSession_Edit"								{$Results.Add("Edit Remote Assistance related Broker machine command properties", "Director"); Break}
			"Director_SliceAndDice_Read"								{$Results.Add("View Filters page", "Director"); Break}
			"Director_TaskManagerInformation_Edit"						{$Results.Add("Edit Task Manager related Broker machine command properties", "Director"); Break}
			"Director_Trends_Read"										{$Results.Add("View Trends page", "Director"); Break}
			"Director_UserDetails_Read"									{$Results.Add("View User Details page", "Director"); Break}
			"Director_WindowsSessionId_Edit"							{$Results.Add("Edit Windows Sessionid related Broker machine command properties", "Director"); Break}
			"EnvTest"													{$Results.Add("Run environment tests", "Other permissions"); Break}
			"Global_Read"												{$Results.Add("Read Site Configuration (Global_Read)", "Other permissions"); Break}
			"Global_Write"												{$Results.Add("Update Site Configuration (Global_Write)", "Other permissions"); Break}
			"Hosts_AddScope"											{$Results.Add("Add Host Connection to Scope", "Hosts"); Break}
			"Hosts_AddStorage"											{$Results.Add("Add storage to Resources", "Hosts"); Break}
			"Hosts_ChangeMaintenanceMode"								{$Results.Add("Enable/disable maintenance mode of a Host Connection", "Hosts"); Break}
			"Hosts_Consume"												{$Results.Add("Use Host Connection or Resources to Create Catalog", "Hosts"); Break}
			"Hosts_CreateHost"											{$Results.Add("Add Host Connection or Resources", "Hosts"); Break}
			"Hosts_DeleteConnection"									{$Results.Add("Delete Host Connection", "Hosts"); Break}
			"Hosts_DeleteHost"											{$Results.Add("Delete Resources", "Hosts"); Break}
			"Hosts_EditConnectionProperties"							{$Results.Add("Edit Host Connection properties", "Hosts"); Break}
			"Hosts_EditHostProperties"									{$Results.Add("Edit Resources", "Hosts"); Break}
			"Hosts_Read"												{$Results.Add("View Host Connections and Resources", "Hosts"); Break}
			"Hosts_RemoveScope"											{$Results.Add("Remove Host Connection from Scope", "Hosts"); Break}
			"Licensing_ChangeLicenseServer"								{$Results.Add("Change licensing server", "Licensing"); Break}
			"Licensing_EditLicensingProperties"							{$Results.Add("Edit product edition", "Licensing"); Break}
			"Licensing_Read"											{$Results.Add("View Licensing", "Licensing"); Break}
			"Logging_Delete"											{$Results.Add("Delete Configuration Logs", "Logging"); Break}
			"Logging_EditPreferences"									{$Results.Add("Edit Logging Preferences", "Logging"); Break}
			"Logging_Read"												{$Results.Add("View Configuration Logs", "Logging"); Break}
			"PerformUpgrade"											{$Results.Add("Perform upgrade", "Other permissions"); Break}
			"Policies_Manage"											{$Results.Add("Manage Policies", "Policies"); Break}
			"Policies_Read"												{$Results.Add("View Policies", "Policies"); Break}
			"Storefront_Create"											{$Results.Add("Create a new StoreFront definition", "StoreFronts"); Break}
			"Storefront_Delete"											{$Results.Add("Delete a StoreFront definition", "StoreFronts"); Break}
			"Storefront_Read"											{$Results.Add("Read StoreFront definitions", "StoreFronts"); Break}
			"Storefront_Update"											{$Results.Add("Update a StoreFront definition", "StoreFronts"); Break}
			"UPM_Reset_Profiles"										{$Results.Add("Reset user profiles", "Director"); Break}
			"UPM_Reset_Profiles_Edit"									{$Results.Add("Edit Reset User Profiles related Broker machine command properties", "Director"); Break}
		}
	}

	$Results = $Results.GetEnumerator() | Sort-Object Value
	Return $Results
}

Function OutputRoleAdministrators 
{
	Param([object] $Roles)
	Write-Verbose "$(Get-Date): `t`tOutput Role Administrators"
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		
		ForEach($Role in $Roles)
		{
			[System.Collections.Hashtable[]] $WordTable = @();
			WriteWordLine 3 0 "Administrators for Role: $($Role.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.RoleName -Contains $Role.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xScopeName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.RoleName -eq $Role.Name)
						{
							$xScopeName = $Right.ScopeName
						}
					}
					
					$WordTableRowHash = @{ 
					AdminName = $Admin.Name; 
					Scope = $xScopeName; 
					Type = $xEnabled;
					}

					$WordTable += $WordTableRowHash;
				}
				$Table = AddWordTable -Hashtable $WordTable `
				-Columns AdminName, Scope, Type `
				-Headers "Administrator Name", "Scope", "Status" `
				-Format $wdTableGrid `
				-AutoFit $wdAutoFitFixed;

				SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

				$Table.Columns.Item(1).Width = 220;
				$Table.Columns.Item(2).Width = 225;
				$Table.Columns.Item(3).Width = 55;

				$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

				FindWordDocumentEnd
				$Table = $Null
				WriteWordLine 0 0 ""
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				WriteWordLine 0 0 "No administrators defined"
				WriteWordLine 0 0 ""
			}
			Else
			{
				WriteWordLine 0 0 "Unable to retrieve administrators"
				WriteWordLine 0 0 ""
			}
		}
	}
	ElseIf($Text)
	{
		ForEach($Role in $Roles)
		{
			Line 1 "Administrators for Role: $($Role.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.RoleName -Contains $Role.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xScopeName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.RoleName -eq $Role.Name)
						{
							$xScopeName = $Right.ScopeName
						}
					}
					
					Line 2 "Administrator Name`t: " $Admin.Name
					Line 2 "Scope`t`t`t: " $xScopeName
					Line 2 "Status`t`t`t: " $xEnabled
					Line 0 ""
				}
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				Line 2 "No administrators defined"
				Line 0 ""
			}
			Else
			{
				Line 2 "Unable to retrieve administrators"
				Line 0 ""
			}
		}
	}
	ElseIf($HTML)
	{
		ForEach($Role in $Roles)
		{
			$rowdata = @()
			WriteHTMLLine 3 0 "Administrators for Role: $($Role.Name)"
			$Admins = Get-AdminAdministrator @XDParams1 | Where-Object {$_.Rights.RoleName -Contains $Role.Name}
			
			If($? -and $Null -ne $Admins)
			{
				ForEach($Admin in $Admins)
				{
					$xEnabled = "Disabled"
					If($Admin.Enabled -eq $True)
					{
						$xEnabled = "Enabled"
					}

					$xScopeName = ""
					ForEach($Right in $Admin.Rights)
					{
						If($Right.RoleName -eq $Role.Name)
						{
							$xScopeName = $Right.ScopeName
						}
					}
					
					$rowdata += @(,(
					$Admin.Name,$htmlwhite,
					$xScopeName,$htmlwhite,
					$xEnabled,$htmlwhite))
				}
				$columnHeaders = @(
				'Administrator Name',($htmlsilver -bor $htmlbold),
				'Scope',($htmlsilver -bor $htmlbold),
				'Status',($htmlsilver -bor $htmlbold))

				$msg = ""
				$columnWidths = @("220","225","55")
				FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
				WriteHTMLLine 0 0 " "
			}
			ElseIf($? -and $Null -eq $Admins)
			{
				WriteHTMLLine 0 0 "No administrators defined"
				WriteHTMLLine 0 0 " "
			}
			Else
			{
				WriteHTMLLine 0 0 "Unable to retrieve administrators"
				WriteHTMLLine 0 0 " "
			}
		}
	}
}
#endregion

#region Controllers functions
Function ProcessControllers
{
	Write-Verbose "$(Get-Date): Processing Controllers"
	Write-Verbose "$(Get-Date): `tRetrieving Controller data"
	
	$Script:TotalControllers = 0
	
	$Controllers = Get-BrokerController @XDParams2 -SortBy DNSName

	If($? -and ($Null -ne $Controllers))
	{
		OutputControllers $Controllers
	}
	ElseIf($? -and ($Null -eq $Controllers))
	{
		$txt = "There are no Controllers"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Controllers"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputControllers
{
	Param([object]$Controllers)
	
	Write-Verbose "$(Get-Date): `tOutput Controllers"
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Controllers"
		[System.Collections.Hashtable[]] $ControllersWordTable = @();
	}
	ElseIf($Text)
	{
		Line 0 "Controllers"
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Controllers"
		$rowdata = @()
	}
	
	ForEach($Controller in $Controllers)
	{
		$Script:TotalControllers++

		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{ 
			Name = $Controller.DNSName; 
			LastUpdated = $Controller.LastActivityTime; 
			RegisteredDesktops = $Controller.DesktopsRegistered;
			}

			$ControllersWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "Name`t`t`t: " $Controller.DNSName
			Line 1 "Last updated`t`t: " $Controller.LastActivityTime
			Line 1 "Registered desktops`t: " $Controller.DesktopsRegistered
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Controller.DNSName,$htmlwhite,
			$Controller.LastActivityTime,$htmlwhite,
			$Controller.DesktopsRegistered,$htmlwhite))
		}
	}

	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $ControllersWordTable `
		-Columns Name, LastUpdated, RegisteredDesktops `
		-Headers "Name", "Last updated", "Registered desktops" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Name',($htmlsilver -bor $htmlbold),
		'Last updated',($htmlsilver -bor $htmlbold),
		'Registered desktops',($htmlsilver -bor $htmlbold))

		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
	
	If($Hardware)
	{
		ForEach($Controller in $Controllers)
		{
			If($MSWORD -or $PDF)
			{
				$Script:Selection.InsertNewPage()
			}
			GetComputerWMIInfo $Controller.DNSName
		}
	}
}
#endregion

#region Hosting functions
Function ProcessHosting
{
	#original work on the Hosting was done by Kenny Baldwin
	Write-Verbose "$(Get-Date): Processing Hosting"

	$Script:TotalHostingConnections = 0

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Hosting"
	}
	ElseIf($Text)
	{
		Line 0 "Hosting"
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Hosting"
	}

	$vmstorage = @()
	$pvdstorage = @()
	$vmnetwork = @()

	Write-Verbose "$(Get-Date): `tProcessing Hosting Units"
	$HostingUnits = Get-ChildItem @XDParams1 -path 'xdhyp:\hostingunits' 4>$Null
	If($? -and $Null -ne $HostingUnits)
	{
		ForEach($item in $HostingUnits)
		{	
			$Script:TotalHostingConnections++
			ForEach($storage in $item.Storage)
			{	
				$vmstorage += $storage.StoragePath
			}
			ForEach($storage in $item.PersonalvDiskStorage)
			{	
				$pvdstorage += $storage.StoragePath
			}
			ForEach($network in $item.NetworkPath)
			{	
				$vmnetwork += $network
			}
		}
	}
	ElseIf($? -and $Null -eq $HostingUnits)
	{
		$txt = "No Hosting Units found"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Hosting Units"
		OutputWarning $txt
	}

	Write-Verbose "$(Get-Date): `tProcessing Hypervisors"
	$Hypervisors = Get-BrokerHypervisorConnection @XDParams1
	If($? -and $Null -ne $Hypervisors)
	{
		ForEach($Hypervisor in $Hypervisors)
		{
			$hypvmstorage = @()
			$hyppvdstorage = @()
			$hypnetwork = @()
			$capabilities = $Hypervisor.Capabilities -join ', '	
			ForEach($storage in $vmstorage)
			{
				If($storage.Contains($Hypervisor.Name))
				{		
					$hypvmstorage += $storage		
				}
			}
			ForEach($storage in $pvdstorage)
			{
				If($storage.Contains($Hypervisor.Name))
				{
					$hyppvdstorage += $storage		
				}
			}
			ForEach($network in $vmnetwork)
			{
				If($network.Contains($Hypervisor.Name))
				{
					$hypnetwork += $network
				}
			}
			$xStorageName = ""
			ForEach($Unit in $HostingUnits)
			{
				If($Unit.HypervisorConnection.HypervisorConnectionName -eq $Hypervisor.Name)
				{
					$xStorageName = $Unit.HostingUnitName
				}
			}
			$xAddress = ""
			$xHAAddress = @()
			$xUserName = ""
			$xScopes = ""
			$xMaintMode = $False
			$xConnectionType = ""
			$xState = ""
			$xZoneName = ""
			$xPowerActions = @()
			Write-Verbose "$(Get-Date): `tProcessing Hosting Connections"
			$Connections = Get-ChildItem @XDParams1 -path 'xdhyp:\connections' 4>$Null
			
			If($? -and $Null -ne $Connections)
			{
				ForEach($Connection in $Connections)
				{
					If($Connection.HypervisorConnectionName -eq $Hypervisor.Name)
					{
						$xAddress = $Connection.HypervisorAddress[0]
						ForEach($tmpaddress in $Connection.HypervisorAddress)
						{
							$xHAAddress += $tmpaddress
						}
						$xUserName = $Connection.UserName
						ForEach($Scope in $Connection.Scopes)
						{
							$xScopes += $Scope.ScopeName + "; "
						}
						$xScopes += "All"
						$xMaintMode = $Connection.MaintenanceMode
						$xConnectionType = $Connection.ConnectionType
						$xState = $Hypervisor.State
						If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
						{
							$xZoneName = $Connection.ZoneName
						}
						$xPowerActions = $Connection.metadata
					}
				}
			}
			ElseIf($? -and $Null -eq $Connections)
			{
				$txt = "No Hosting Connections found"
				OutputWarning $txt
			}
			Else
			{
				$txt = "Unable to retrieve Hosting Connections"
				OutputWarning $txt
			}
			OutputHosting $Hypervisor $xConnectionType $xAddress $xState $xUserName $xMaintMode $xStorageName $xHAAddress $xPowerActions $xScopes $xZoneName
		}
	}
	ElseIf($? -and $Null -eq $Hypervisors)
	{
		$txt = "No Hypervisors found"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve Hypervisors"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date):"
}

Function OutputHosting
{
	Param([object] $Hypervisor, [string] $xConnectionType, [string] $xAddress, [string] $xState, [string] $xUserName, [bool] $xMaintMode, [string] $xStorageName, [array] $xHAAddress, [array]$xPowerActions, [string] $xScopes, [string] $xZoneName)

	$xHAAddress = $xHAAddress | Sort-Object
	
	$xxConnectionType = ""
	Switch ($xConnectionType)
	{
		"XenServer" {$xxConnectionType = "XenServer"; Break}
		"SCVMM"     {$xxConnectionType = "Microsoft System Center Virtual Machine Manager"; Break}
		"vCenter"   {$xxConnectionType = "VMware virtualization"; Break}
		"Custom"    {$xxConnectionType = "Custom"; Break}
		Default     {$xxConnectionType = "Hypervisor Type could not be determined: $($xConnectionType)"; Break}
	}

	$xxState = ""
	If($xState -eq "On")
	{
		$xxState = "Enabled"
	}
	Else
	{
		$xxState = "Disabled"
	}

	$xxMaintMode = ""
	If($xMaintMode)
	{
		$xxMaintMode = "On"
	}
	Else
	{
		$xxMaintMode = "Off"
	}
	
	Write-Verbose "$(Get-Date): `t`t`tOutput $($Hypervisor.Name)"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 $Hypervisor.Name
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Connection Name"; Value = $Hypervisor.Name; }
		$ScriptInformation += @{ Data = "Type"; Value = $xxConnectionType; }
		$ScriptInformation += @{ Data = "Address"; Value = $xAddress; }
		$ScriptInformation += @{ Data = "State"; Value = $xxState; }
		$ScriptInformation += @{ Data = "Username"; Value = $xUserName; }
		$ScriptInformation += @{ Data = "Scopes"; Value = $xScopes; }
		$ScriptInformation += @{ Data = "Maintenance Mode"; Value = $xxMaintMode; }
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			$ScriptInformation += @{ Data = "Zone"; Value = $xZoneName; }
		}
		$ScriptInformation += @{ Data = "Storage resource name"; Value = $xStorageName; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		
		WriteWordLine 4 0 "Advanced"
		$HAtmp = @()
		ForEach($tmpaddress in $xHAAddress)
		{
			$HAtmp += "$($tmpaddress)"
		}
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "High Availability Servers"; Value = $HAtmp[0]; }
		$cnt = -1
		ForEach($tmp in $HATmp)
		{
			$cnt++
			If($cnt -gt 0)
			{
				$ScriptInformation += @{ Data = ""; Value = $tmp; }
			}
		}
		$ScriptInformation += @{ Data = "Simultaneous actions (all types) [Absolute]"; Value = $xPowerActions[0].Value; }
		$ScriptInformation += @{ Data = "Simultaneous actions (all types) [Percentage]"; Value = $xPowerActions[2].Value; }
		$ScriptInformation += @{ Data = "Simultaneous Personal vDisk inventory updates [Absolute]"; Value = $xPowerActions[4].Value; }
		$ScriptInformation += @{ Data = "Simultaneous Personal vDisk inventory updates [Percentage]"; Value = $xPowerActions[3].Value; }
		$ScriptInformation += @{ Data = "Maximum new actions per minute"; Value = $xPowerActions[1].Value; }
		If($xPowerActions.Count -gt 5)
		{
			$ScriptInformation += @{ Data = "Connection options"; Value = $xPowerActions[5].Value; }
		}
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 300;
		$Table.Columns.Item(2).Width = 150;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 $Hypervisor.Name
		Line 0 ""
		Line 1 "Connection Name`t`t: " $Hypervisor.Name
		Line 1 "Type`t`t`t: " $xxConnectionType
		Line 1 "Address`t`t`t: " $xAddress
		Line 1 "State`t`t`t: " $xxState
		Line 1 "Username`t`t: " $xUserName
		Line 1 "Scopes`t`t`t: " $xScopes
		Line 1 "Maintenance Mode`t: " $xxMaintMode
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			Line 1 "Zone`t`t`t: " $xZoneName
		}
		Line 1 "Storage resource name`t: " $xStorageName
		Line 0 ""
		
		Line 1 "Advanced"
		Line 2 "High Availability Servers`t`t`t: " $xHAAddress[0]
		$cnt = 0
		ForEach($tmpaddress in $xHAAddress)
		{
			If($cnt -gt 0)
			{
				Line 8 "  " $tmpaddress
			}
			$cnt++
		}
		Line 2 "Simultaneous actions (all types) [Absolute]`t: " $xPowerActions[0].Value
		Line 2 "Simultaneous actions (all types) [Percentage]`t: " $xPowerActions[2].Value
		Line 2 "Simultaneous PvD inventory updates [Absolute]`t: " $xPowerActions[4].Value
		Line 2 "Simultaneous PvD inventory updates [Percentage]`t: " $xPowerActions[3].Value
		Line 2 "Maximum new actions per minute`t`t`t: " $xPowerActions[1].Value
		If($xPowerActions.Count -gt 5)
		{
			Line 2 "Connection options`t`t`t`t: " $xPowerActions[5].Value
		}
		Line 0 ""
		
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 $Hypervisor.Name
		$rowdata = @()
		$columnHeaders = @("Connection Name",($htmlsilver -bor $htmlbold),$Hypervisor.Name,$htmlwhite)
		$rowdata += @(,('Type',($htmlsilver -bor $htmlbold),$xxConnectionType,$htmlwhite))
		$rowdata += @(,('Address',($htmlsilver -bor $htmlbold),$xAddress,$htmlwhite))
		$rowdata += @(,('State',($htmlsilver -bor $htmlbold),$xxState,$htmlwhite))
		$rowdata += @(,('Username',($htmlsilver -bor $htmlbold),$xUserName,$htmlwhite))
		$rowdata += @(,('Scopes',($htmlsilver -bor $htmlbold),$xScopes,$htmlwhite))
		$rowdata += @(,('Maintenance Mode',($htmlsilver -bor $htmlbold),$xxMaintMode,$htmlwhite))
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			$rowdata += @(,('Zone',($htmlsilver -bor $htmlbold),$xZoneName,$htmlwhite))
		}
		$rowdata += @(,('Storage resource name',($htmlsilver -bor $htmlbold),$xStorageName,$htmlwhite))

		$msg = ""
		$columnWidths = @("150","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
		
		WriteHTMLLine 4 0 "Advanced"
		$rowdata = @()
		$columnHeaders = @("High Availability Servers",($htmlsilver -bor $htmlbold),$xHAAddress[0],$htmlwhite)
		$cnt = 0
		ForEach($tmpaddress in $xHAAddress)
		{
			If($cnt -gt 0)
			{
				$rowdata += @(,('',($htmlsilver -bor $htmlbold),$tmpaddress,$htmlwhite))
			}
			$cnt++
		}
		$rowdata += @(,('Simultaneous actions (all types) [Absolute]',($htmlsilver -bor $htmlbold),$xPowerActions[0].Value,$htmlwhite))
		$rowdata += @(,('Simultaneous actions (all types) [Percentage]',($htmlsilver -bor $htmlbold),$xPowerActions[2].Value,$htmlwhite))
		$rowdata += @(,('Simultaneous Personal vDisk inventory updates [Absolute]',($htmlsilver -bor $htmlbold),$xPowerActions[4].Value,$htmlwhite))
		$rowdata += @(,('Simultaneous Personal vDisk inventory updates [Percentage]',($htmlsilver -bor $htmlbold),$xPowerActions[3].Value,$htmlwhite))
		$rowdata += @(,('Maximum new actions per minute',($htmlsilver -bor $htmlbold),$xPowerActions[1].Value,$htmlwhite))
		If($xPowerActions.Count -gt 5)
		{
			$rowdata += @(,('Connection options',($htmlsilver -bor $htmlbold),$xPowerActions[5].Value,$htmlwhite))
		}

		$msg = ""
		$columnWidths = @("300","150")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "450"
		WriteHTMLLine 0 0 " "
	}
	
	If($Hosting)
	{	
		Write-Verbose "$(Get-Date): `tProcessing Host Administrators"
		$Admins = GetAdmins "Host" $Hypervisor.Name
		
		If($? -and ($Null -ne $Admins))
		{
			OutputAdminsForDetails $Admins
		}
		ElseIf($? -and ($Null -eq $Admins))
		{
			$txt = "There are no administrators for Host $($Hypervisor.Name)"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve administrators for Host $($Hypervisor.Name)"
			OutputWarning $txt
		}

		Write-Verbose "$(Get-Date): `tProcessing Desktop OS Data"
		$DesktopOSMachines = Get-BrokerMachine @XDParams2 -hypervisorconnectionname $Hypervisor.Name -sessionsupport "SingleSession"

		If($? -and ($Null -ne $DesktopOSMachines))
		{
			[int]$cnt = 0
			If($DesktopOSMachines -is [array])
			{
				$cnt = $DesktopOSMachines.Count
			}
			Else
			{
				If(![String]::IsNullOrEmpty($DesktopOSMachines))
				{
					$cnt = 1
				}
				Else
				{
					$cnt = 0
				}
			}
			
			If($MSWord -or $PDF)
			{
				$Selection.InsertNewPage()
				WriteWordLine 4 0 "Desktop OS Machines ($($cnt))"
			}
			ElseIf($Text)
			{
				Line 0 "Desktop OS Machines ($($cnt))"
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 4 0 "Desktop OS Machines ($($cnt))"
			}

			ForEach($Desktop in $DesktopOSMachines)
			{
				OutputDesktopOSMachine $Desktop
			}
		}
		ElseIf($? -and ($Null -eq $DesktopOSMachines))
		{
			$txt = "There are no Desktop OS Machines"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve Desktop OS Machines"
			OutputWarning $txt
		}

		Write-Verbose "$(Get-Date): `tProcessing Server OS Data"
		$ServerOSMachines = Get-BrokerMachine @XDParams2 -hypervisorconnectionname $Hypervisor.Name -sessionsupport "MultiSession"
		
		If($? -and ($Null -ne $ServerOSMachines))
		{
			If($ServerOSMachines -is [array])
			{
				$cnt = $ServerOSMachines.Count
			}
			Else
			{
				If(![String]::IsNullOrEmpty($ServerOSMachines))
				{
					$cnt = 1
				}
				Else
				{
					$cnt = 0
				}
			}

			If($MSWord -or $PDF)
			{
				$Selection.InsertNewPage()
				WriteWordLine 4 0 "Server OS Machines ($($cnt))"
			}
			ElseIf($Text)
			{
				Line 0 ""
				Line 0 "Server OS Machines ($($cnt))"
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 4 0 "Server OS Machines ($($cnt))"
			}
			
			ForEach($Server in $ServerOSMachines)
			{
				OutputServerOSMachine $Server
			}
		}
		ElseIf($? -and ($Null -eq $ServerOSMachines))
		{
			$txt = "There are no Server OS Machines"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve Server OS Machines"
			OutputWarning $txt
		}

		Write-Verbose "$(Get-Date): `tProcessing Sessions Data"
		$Sessions = Get-BrokerSession @XDParams1 -hypervisorconnectionname $Hypervisor.Name -SortBy UserName
		If($? -and ($Null -ne $Sessions))
		{
			If($Sessions -is [array])
			{
				$cnt = $Sessions.Count
			}
			Else
			{
				If(![String]::IsNullOrEmpty($Sessions))
				{
					$cnt = 1
				}
				Else
				{
					$cnt = 0
				}
			}

			If($MSWord -or $PDF)
			{
				$Selection.InsertNewPage()
				WriteWordLine 4 0 "Sessions ($($cnt))"
			}
			ElseIf($Text)
			{
				Line 0 ""
				Line 0 "Sessions ($($cnt))"
				Line 0 ""
			}
			ElseIf($HTML)
			{
				WriteHTMLLine 4 0 "Sessions ($($cnt))"
			}
			
			OutputHostingSessions $Sessions
		}
		ElseIf($? -and ($Null -eq $Sessions))
		{
			$txt = "There are no Sessions"
			OutputWarning $txt
		}
		Else
		{
			$txt = "Unable to retrieve Sessions"
			OutputWarning $txt
		}
	}
}

Function OutputDesktopOSMachine 
{
	Param([object]$Desktop)

	$xName = ""
	$xMaintMode = ""
	$xUserChanges = ""
	
	Write-Verbose "$(Get-Date): `t`t`tOutput desktop $($Desktop.DNSName)"
	If($MSWord -or $PDF)
	{
		If(![String]::IsNullOrEmpty($Desktop.AssociatedUserNames))
		{
			ForEach($AssociatedUserName in $Desktop.AssociatedUserNames)
			{
				$xName += $AssociatedUserName
			}
		}
		If($xName -eq "")
		{
			$xName = "Not assigned"
		}
		If($Desktop.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Switch($Desktop.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Desktop.PersistUserChanges)"}
		}
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Name"; Value = $Desktop.DNSName; }
		$ScriptInformation += @{ Data = "Machine Catalog"; Value = $Desktop.CatalogName; }
		$ScriptInformation += @{ Data = "Delivery Group"; Value = $Desktop.DesktopGroupName; }
		$ScriptInformation += @{ Data = "User"; Value = $xName; }
		$ScriptInformation += @{ Data = "Maintenance Mode"; Value = $xMaintMode; }
		$ScriptInformation += @{ Data = "Persist User Changes"; Value = $xUserChanges; }
		$ScriptInformation += @{ Data = "Power State"; Value = $Desktop.PowerState; }
		$ScriptInformation += @{ Data = "Registration State"; Value = $Desktop.RegistrationState; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Name`t`t`t: " $Desktop.DNSName
		Line 1 "Machine Catalog`t`t: " $Desktop.CatalogName
		If(![String]::IsNullOrEmpty($Desktop.DesktopGroupName))
		{
			Line 1 "Delivery Group`t`t: " $Desktop.DesktopGroupName
		}
		If(![String]::IsNullOrEmpty($Desktop.AssociatedUserNames))
		{
			ForEach($AssociatedUserName in $Desktop.AssociatedUserNames)
			{
				$xName += $AssociatedUserName
			}
			Line 1 "User`t`t`t: " $xName
		}
		If($Desktop.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Line 1 "Maintenance Mode`t: " $xMaintMode
		Switch($Desktop.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Desktop.PersistUserChanges)"}
		}
		Line 1 "Persist User Changes`t: " $xUserChanges
		Line 1 "Power State`t`t: " $Desktop.PowerState
		Line 1 "Registration State`t: " $Desktop.RegistrationState
		Line 0 ""
	}
	ElseIf($HTML)
	{
		If($Desktop.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Switch($Desktop.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Desktop.PersistUserChanges)"}
		}

		$rowdata = @()
		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$Desktop.DNSName,$htmlwhite)
		$rowdata += @(,('Machine Catalog',($htmlsilver -bor $htmlbold),$Desktop.CatalogName,$htmlwhite))
		If(![String]::IsNullOrEmpty($Desktop.DesktopGroupName))
		{
			$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$Desktop.DesktopGroupName,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($Desktop.AssociatedUserNames))
		{
			$cnt = -1
			ForEach($AssociatedUserName in $Desktop.AssociatedUserNames)
			{
				If($cnt -eq 0)
				{
					$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$AssociatedUserName,$htmlwhite))
				}
				Else
				{
					$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$AssociatedUserName,$htmlwhite))
				}
			}
		}
		$rowdata += @(,('Maintenance Mode',($htmlsilver -bor $htmlbold),$xMaintMode,$htmlwhite))
		$rowdata += @(,('Persist User Changes',($htmlsilver -bor $htmlbold),$xUserChanges,$htmlwhite))
		$rowdata += @(,('Power State',($htmlsilver -bor $htmlbold),$Desktop.PowerState,$htmlwhite))
		$rowdata += @(,('Registration State',($htmlsilver -bor $htmlbold),$Desktop.RegistrationState,$htmlwhite))

		$msg = ""
		$columnWidths = @("150","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputServerOSMachine 
{
	Param([object]$Server)
	
	Write-Verbose "$(Get-Date): `t`t`tOutput server $($Server.DNSName)"
	$xName = ""
	$xMaintMode = ""
	$xUserChanges = ""

	If($MSWord -or $PDF)
	{
		If(![String]::IsNullOrEmpty($Server.AssociatedUserNames))
		{
			ForEach($AssociatedUserName in $Server.AssociatedUserNames)
			{
				$xName += $AssociatedUserName + "`n"
			}
		}
		If($xName -eq "")
		{
			$xName = "Not assigned"
		}
		If($Server.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Switch($Server.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Server.PersistUserChanges)"}
		}
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Name"; Value = $Server.DNSName; }
		$ScriptInformation += @{ Data = "Machine Catalog"; Value = $Server.CatalogName; }
		$ScriptInformation += @{ Data = "Delivery Group"; Value = $Server.DesktopGroupName; }
		$ScriptInformation += @{ Data = "User"; Value = $xName; }
		$ScriptInformation += @{ Data = "Maintenance Mode"; Value = $xMaintMode; }
		$ScriptInformation += @{ Data = "Persist User Changes"; Value = $xUserChanges; }
		$ScriptInformation += @{ Data = "Power State"; Value = $Server.PowerState; }
		$ScriptInformation += @{ Data = "Registration State"; Value = $Server.RegistrationState; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 200;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 1 "Name`t`t`t: " $Server.DNSName
		Line 1 "Machine Catalog`t`t: " $Server.CatalogName
		If(![String]::IsNullOrEmpty($Server.DesktopGroupName))
		{
			Line 1 "Delivery Group`t`t: " $Server.DesktopGroupName
		}
		If(![String]::IsNullOrEmpty($Server.AssociatedUserNames))
		{
			ForEach($AssociatedUserName in $Server.AssociatedUserNames)
			{
				$xName += $AssociatedUserName + "`n"
			}
			Line 1 "User`t`t`t: " $xName
		}
		If($Server.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Line 1 "Maintenance Mode`t: " $xMaintMode
		Switch($Server.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Server.PersistUserChanges)"}
		}
		Line 1 "Persist User Changes`t: " $xUserChanges
		Line 1 "Power State`t`t: " $Server.PowerState
		Line 1 "Registration State`t: " $Server.RegistrationState
		Line 0 ""
	}
	ElseIf($HTML)
	{
		If($Server.InMaintenanceMode)
		{
			$xMaintMode = "On"
		}
		Else
		{
			$xMaintMode = "Off"
		}
		Switch($Server.PersistUserChanges)
		{
			"OnLocal" {$xUserChanges = "On Local"}
			"Discard" {$xUserChanges = "Discard"}
			"OnPvd"   {$xUserChanges = "Personal vDisk"}
			Default   {$xUserChanges = "Unknown: $($Server.PersistUserChanges)"}
		}

		$rowdata = @()
		$columnHeaders = @("Name",($htmlsilver -bor $htmlbold),$Server.DNSName,$htmlwhite)
		$rowdata += @(,('Machine Catalog',($htmlsilver -bor $htmlbold),$Server.CatalogName,$htmlwhite))
		If(![String]::IsNullOrEmpty($Server.DesktopGroupName))
		{
			$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$Server.DesktopGroupName,$htmlwhite))
		}
		If(![String]::IsNullOrEmpty($Server.AssociatedUserNames))
		{
			$cnt = -1
			ForEach($AssociatedUserName in $Server.AssociatedUserNames)
			{
				If($cnt -eq 0)
				{
					$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$AssociatedUserName,$htmlwhite))
				}
				Else
				{
					$rowdata += @(,('User',($htmlsilver -bor $htmlbold),$AssociatedUserName,$htmlwhite))
				}
			}
		}
		$rowdata += @(,('Maintenance Mode',($htmlsilver -bor $htmlbold),$xMaintMode,$htmlwhite))
		$rowdata += @(,('Persist User Changes',($htmlsilver -bor $htmlbold),$xUserChanges,$htmlwhite))
		$rowdata += @(,('Power State',($htmlsilver -bor $htmlbold),$Server.PowerState,$htmlwhite))
		$rowdata += @(,('Registration State',($htmlsilver -bor $htmlbold),$Server.RegistrationState,$htmlwhite))

		$msg = ""
		$columnWidths = @("150","200")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "350"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputHostingSessions 
{
	Param([object] $Sessions)
	
	ForEach($Session in $Sessions)
	{
		Write-Verbose "$(Get-Date): `t`t`tOutput session $($Session.UserName)"
		#get the private desktop
		#get desktop by Session Uid
		$xMachineName = ""
		$Desktop = Get-BrokerDesktop -SessionUid $Session.Uid @XDParams1
		
		If($? -and $Null -ne $Desktop)
		{
			$xMachineName = $Desktop.MachineName
		}
		Else
		{
			$xMachineName = "Not Found"
		}

		If($Session.SessionSupport -eq "SingleSession")
		{
			$xSessionType = "Single"
		}
		Else
		{
			$xSessionType = "Multi"
		}
		
		If($MSWord -or $PDF)
		{
			[System.Collections.Hashtable[]] $ScriptInformation = @()
			$ScriptInformation += @{ Data = "Current User"; Value = $Session.UserName; }
			$ScriptInformation += @{ Data = "Name"; Value = $Session.ClientName; }
			$ScriptInformation += @{ Data = "Delivery Group"; Value = $Session.DesktopGroupName; }
			$ScriptInformation += @{ Data = "Machine Catalog"; Value = $Session.CatalogName; }
			$ScriptInformation += @{ Data = "Brokering Time"; Value = $Session.BrokeringTime; }
			$ScriptInformation += @{ Data = "Session State"; Value = $Session.SessionState; }
			$ScriptInformation += @{ Data = "Application State"; Value = $Session.AppState; }
			$ScriptInformation += @{ Data = "Session Support"; Value = $xSessionType; }
			$Table = AddWordTable -Hashtable $ScriptInformation `
			-Columns Data,Value `
			-List `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 150;
			$Table.Columns.Item(2).Width = 200;

			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
		ElseIf($Text)
		{
			Line 1 "Current User`t`t: " $Session.UserName
			Line 1 "Name`t`t`t: " $Session.ClientName
			Line 1 "Delivery Group`t`t: " $Session.DesktopGroupName
			Line 1 "Machine Catalog`t`t: " $Session.CatalogName
			Line 1 "Brokering Time`t`t: " $Session.BrokeringTime
			Line 1 "Session State`t`t: " $Session.SessionState
			Line 1 "Application State`t: " $Session.AppState
			Line 1 "Session Support`t`t: " $xSessionType
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata = @()
			$columnHeaders = @("Current User",($htmlsilver -bor $htmlbold),$Session.UserName,$htmlwhite)
			$rowdata += @(,('Name',($htmlsilver -bor $htmlbold),$Session.ClientName,$htmlwhite))
			$rowdata += @(,('Delivery Group',($htmlsilver -bor $htmlbold),$Session.DesktopGroupName,$htmlwhite))
			$rowdata += @(,('Machine Catalog',($htmlsilver -bor $htmlbold),$Session.CatalogName,$htmlwhite))
			$rowdata += @(,('Brokering Time',($htmlsilver -bor $htmlbold),$Session.BrokeringTime,$htmlwhite))
			$rowdata += @(,('Session State',($htmlsilver -bor $htmlbold),$Session.SessionState,$htmlwhite))
			$rowdata += @(,('Application State',($htmlsilver -bor $htmlbold),$Session.AppState,$htmlwhite))
			$rowdata += @(,('Session Support',($htmlsilver -bor $htmlbold),$xSessionType,$htmlwhite))

			$msg = ""
			$columnWidths = @("150","200")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "350"
			WriteHTMLLine 0 0 " "
		}
	}
}
#endregion

#region Licensing functions
Function ProcessLicensing
{
	Write-Verbose "$(Get-Date): Processing Licensing"
	
	$Script:Licenses = @()
	OutputLicensingOverview
	
	#get product license info
	Write-Verbose "$(Get-Date): `tRetrieving Licensing data"
	$LSAdminAddress = Get-LicLocation -LicenseServerAddress $Script:XDSite1.LicenseServerName -EA 0 4>$Null
	If($? -and ($Null -ne $LSAdminAddress))
	{
		$LSCertificate = Get-LicCertificate -AdminAddress $LSAdminAddress -EA 0 4>$Null
		If($? -and ($Null -ne $LSCertificate))
		{
			$LicenseAdmins = Get-LicAdministrator -AdminAddress $LSAdminAddress -CertHash $LSCertificate.CertHash -EA 0 4>$Null
			If($? -and ($Null -ne $LicenseAdmins))
			{
				OutputLicenseAdmins $LicenseAdmins
			}
			Else
			{
				$txt = "Unable to retrieve License Administrators"
				OutputWarning $txt
			}

			$ProductLicenses = Get-LicInventory -AdminAddress $LSAdminAddress -CertHash $LSCertificate.CertHash -EA 0 4>$Null
			If($? -and ($Null -ne $ProductLicenses))
			{
				OutputXendesktopLicenses $LSAdminAddress $LSCertificate $ProductLicenses
			}
			Else
			{
				$txt = "Unable to retrieve Product Licenses"
				OutputWarning $txt
			}
			
		}
		Else
		{
			$txt = "Unable to retrieve License Server Certificate"
			OutputWarning $txt
		}
	}
	Else
	{
		$txt = "Unable to retrieve License Server Admin Address"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputLicensingOverview
{
	Write-Verbose "$(Get-Date): `tOutput Licensing Overview"
	$LicenseEditionType = ""
	$LicenseModelType = ""

	If($Script:XDSite2.ProductCode -eq "XDT")
	{
		Switch ($Script:XDSite2.ProductEdition)
		{
			"PLT" {$LicenseEditionType = "Platinum Edition"; Break}
			"ENT" {$LicenseEditionType = "Enterprise Edition"; Break}
			"APP" {$LicenseEditionType = "App Edition"; Break}
			"STD" {$LicenseEditionType = "VDI Edition"; Break}
			Default {$LicenseEditionType = "License edition could not be determined: $($Script:XDSite2.ProductEdition)"; Break}
		}
	}
	ElseIf($Script:XDSite2.ProductCode -eq "MPS")
	{
		Switch ($Script:XDSite2.ProductEdition)
		{
			"PLT" {$LicenseEditionType = "Platinum Edition"; Break}
			"ENT" {$LicenseEditionType = "Enterprise Edition"; Break}
			"ADV" {$LicenseEditionType = "Advanced Edition"; Break}
			Default {$LicenseEditionType = "License edition could not be determined: $($Script:XDSite2.ProductEdition)"; Break}
		}
	}

	If($Script:XDSite1.LicenseModel -eq "UserDevice")
	{
		$LicenseModelType = "User/Device"
	}
	Else
	{
		$LicenseModelType = $Script:XDSite1.LicenseModel
	}
	$tmpdate = '{0:yyyy\.MMdd}' -f $Script:XDSite1.LicensingBurnInDate
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Licensing"
		WriteWordLine 2 0 "Licensing Overview"

		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "Site"; Value = $Script:XDSite1.Name; }
		$ScriptInformation += @{ Data = "Server"; Value = $Script:XDSite1.LicenseServerName; }
		$ScriptInformation += @{ Data = "Port"; Value = $Script:XDSite1.LicenseServerPort; }
		$ScriptInformation += @{ Data = "Edition"; Value = $LicenseEditionType; }
		$ScriptInformation += @{ Data = "License model"; Value = $LicenseModelType; }
		$ScriptInformation += @{ Data = "Required SA date"; Value = $tmpdate; }
		$ScriptInformation += @{ Data = "XenDesktop license use"; Value = $Script:XDSite1.LicensedSessionsActive; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 125;
		$Table.Columns.Item(2).Width = 125;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Licensing"
		Line 0 "Licensing Overview"
		Line 0 ""
		Line 0 "Site`t`t`t: " $Script:XDSite1.Name
		Line 0 "Server`t`t`t: " $Script:XDSite1.LicenseServerName
		Line 0 "Port`t`t`t: " $Script:XDSite1.LicenseServerPort
		Line 0 "Edition`t`t`t: " $LicenseEditionType
		Line 0 "License model`t`t: " $LicenseModelType
		Line 0 "Required SA date`t: " $tmpdate
		Line 0 "XenDesktop license use`t: " $Script:XDSite1.LicensedSessionsActive
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Licensing"
		WriteHTMLLine 2 0 "Licensing Overview"
		$rowdata = @()
		$columnHeaders = @("Site",($htmlsilver -bor $htmlbold),$Script:XDSite1.Name,$htmlwhite)
		$rowdata += @(,('Server',($htmlsilver -bor $htmlbold),$Script:XDSite1.LicenseServerName,$htmlwhite))
		$rowdata += @(,('Port',($htmlsilver -bor $htmlbold),$Script:XDSite1.LicenseServerPort,$htmlwhite))
		$rowdata += @(,('Edition',($htmlsilver -bor $htmlbold),$LicenseEditionType,$htmlwhite))
		$rowdata += @(,('License model',($htmlsilver -bor $htmlbold),$LicenseModelType,$htmlwhite))
		$rowdata += @(,('Required SA date',($htmlsilver -bor $htmlbold),$tmpdate,$htmlwhite))
		$rowdata += @(,('XenDesktop license use',($htmlsilver -bor $htmlbold),$Script:XDSite1.LicensedSessionsActive,$htmlwhite))

		$msg = ""
		$columnWidths = @("150","125")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "275"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputXenDesktopLicenses
{
	Param([object]$LSAdminAddress, [object]$LSCertificate, [object]$ProductLicenses)
	
	Write-Verbose "$(Get-Date): `tOutput Licenses"
	
	ForEach($Product in $ProductLicenses)
	{
		$LicModel = ""
		If($Product.LicenseProductName -eq $Script:XDSite2.ProductCode)
		{
			If($Product.LicenseModel -eq "UD")
			{
				$LicModel = "U/D"
			}
			Else
			{
				$LicModel = $Product.LicenseModel
			}
			$obj = New-Object -TypeName PSObject
			$obj | Add-Member -MemberType NoteProperty -Name LicenseProduct	-Value $Product.LicenseProductName
			$obj | Add-Member -MemberType NoteProperty -Name LicenseType	-Value $Product.LicenseEdition
			$obj | Add-Member -MemberType NoteProperty -Name LicenseModel	-Value $LicModel
			$obj | Add-Member -MemberType NoteProperty -Name LicenseCount	-Value $Product.LicensesAvailable
			$Script:Licenses += $obj
		}
	}
	
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 "XenDesktop Licenses"
		[System.Collections.Hashtable[]] $LicensesWordTable = @();
		ForEach($Product in $ProductLicenses)
		{
			If($Product.LicenseProductName -eq $Script:XDSite2.ProductCode)
			{
				$tmpdate1 = '{0:d}' -f $Product.LicenseExpirationDate
				$tmpdate2 = '{0:yyyy\.MMdd}' -f $Product.LicenseSubscriptionAdvantageDate
				$WordTableRowHash = @{ 
				Product = $Product.LocalizedLicenseProductName;
				Mode = $Product.LocalizedLicenseModel;
				ExpirationDate = $tmpdate1;
				SubscriptionAdvantageDate = $tmpdate2;
				Type = $Product.LocalizedLicenseType;
				Quantity = $Product.LicensesAvailable;
				}

				$LicensesWordTable += $WordTableRowHash;
			}
		}
		$Table = AddWordTable -Hashtable $LicensesWordTable `
		-Columns Product, Mode, ExpirationDate, SubscriptionAdvantageDate, Type, Quantity `
		-Headers "Product", "Mode", "Expiration Date", "Subscription Advantage Date", "Type", "Quantity" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 140;
		$Table.Columns.Item(2).Width = 70;
		$Table.Columns.Item(3).Width = 65;
		$Table.Columns.Item(4).Width = 90;
		$Table.Columns.Item(5).Width = 80;
		$Table.Columns.Item(6).Width = 55;
		
		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "XenDesktop Licenses"
		Line 0 ""
		ForEach($Product in $ProductLicenses)
		{
			If($Product.LicenseProductName -eq "XDT")
			{
				$tmpdate1 = '{0:d}' -f $Product.LicenseExpirationDate
				$tmpdate2 = '{0:yyyy\.MMdd}' -f $Product.LicenseSubscriptionAdvantageDate
				Line 0 "Product`t`t`t`t: " $Product.LocalizedLicenseProductName
				Line 0 "Mode`t`t`t`t: " $Product.LocalizedLicenseModel
				Line 0 "Expiration Date`t`t`t: " $tmpdate1
				Line 0 "Subscription Advantage Date`t: " $tmpdate2
				Line 0 "Type`t`t`t`t: " $Product.LocalizedLicenseType
				Line 0 "Quantity`t`t`t: " $Product.LicensesAvailable
				Line 0 ""
			}
		}
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 "XenDesktop Licenses"
		$rowdata = @()
		ForEach($Product in $ProductLicenses)
		{
			If($Product.LicenseProductName -eq "XDT")
			{
				$tmpdate1 = '{0:d}' -f $Product.LicenseExpirationDate
				$tmpdate2 = '{0:yyyy\.MMdd}' -f $Product.LicenseSubscriptionAdvantageDate
				$rowdata += @(,(
				$Product.LocalizedLicenseProductName,$htmlwhite,
				$Product.LocalizedLicenseModel,$htmlwhite,
				$tmpdate1,$htmlwhite,
				$tmpdate2,$htmlwhite,
				$Product.LocalizedLicenseType,$htmlwhite,
				$Product.LicensesAvailable,$htmlwhite))
			}
		}
		$columnHeaders = @(
		'Product',($htmlsilver -bor $htmlbold),
		'Mode',($htmlsilver -bor $htmlbold),
		'Expiration Date',($htmlsilver -bor $htmlbold),
		'Subscription Advantage Date',($htmlsilver -bor $htmlbold),
		'Type',($htmlsilver -bor $htmlbold),
		'Quantity',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("150","125","65","90","80","55")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "565"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputLicenseAdmins
{
	Param([object]$LicenseAdmins)
	
	Write-Verbose "$(Get-Date): `tProcessing License Administrators"

	$txt = "License Administrators"
	If($MSWord -or $PDF)
	{
		WriteWordLine 3 0 $txt
	}
	ElseIf($Text)
	{
		Line 0 $txt
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 3 0 $txt
	}

	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $AdminsWordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}

	ForEach($Admin in $LicenseAdmins)
	{
		Write-Verbose "$(Get-Date): `t`tAdding Administrator $($Admin.Account)"

		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{
			AdminName = $Admin.Account; 
			Permissions = $Admin.Permissions; 
			}
			$AdminsWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "Name`t`t: " $Admin.Account
			Line 1 "Permissions`t: " $Admin.Permissions
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$Admin.Account,$htmlwhite,
			$Admin.Permissions,$htmlwhite))
		}
	}

	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $AdminsWordTable `
		-Columns  AdminName,Permissions `
		-Headers  "Name","Permissions" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'Name',($htmlsilver -bor $htmlbold),
		'Permissions',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("150","125")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "275"
		WriteHTMLLine 0 0 " "
	}
}

#endregion

#region StoreFront functions
Function ProcessStoreFront
{
	Write-Verbose "$(Get-Date): Processing StoreFront"
	
	$Script:TotalStoreFrontServers = 0
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "StoreFront"
	}
	ElseIf($Text)
	{
		Line 0 "StoreFront"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "StoreFront"
	}
	
	Write-Verbose "$(Get-Date): `tRetrieving StoreFront information"
	$SFInfos = Get-BrokerMachineConfiguration @XDParams1 -Name rs* -SortBy LeafName
	If($? -and ($Null -ne $SFInfos))
	{
		$First = $True
		ForEach($SFInfo in $SFInfos)
		{
			$Script:TotalStoreFrontServers++

			$SFByteArray = $SFInfo.Policy
			Write-Verbose "$(Get-Date): `t`tRetrieving StoreFront server information for $($SFInfo.LeafName)"
			$SFServer = Get-SFStoreFrontAddress -ByteArray $SFByteArray 4>$Null
			If($? -and ($Null -ne $SFServer))
			{
				If($MSWord -or $PDF)
				{
					If(!$First)
					{
						$Selection.InsertNewPage()
					}
					$First = $False
				}
				OutputStoreFront $SFServer $SFInfo
				If($StoreFront)
				{
					If($SFInfo.DesktopGroupUids.Count -gt 0)
					{
						OutputStoreFrontDeliveryGroups $SFInfo
					}
					
					Write-Verbose "$(Get-Date): `t`tProcessing administrators for StoreFront server $($SFServer.Name)"
					$Admins = GetAdmins "Storefront"
					
					If($? -and ($Null -ne $Admins))
					{
						OutputAdminsForDetails $Admins
					}
					ElseIf($? -and ($Null -eq $Admins))
					{
						$txt = "There are no administrators for StoreFront server $($SFServer.Name)"
						OutputWarning $txt
					}
					Else
					{
						$txt = "Unable to retrieve administrators for StoreFront server $($SFServer.Name)"
						OutputWarning $txt
					}
				}
			}
			ElseIf($? -and ($Null -eq $SFServer))
			{
				$txt = "There was no StoreFront Server found for $($SFInfo.LeafName)"
				OutputWarning $txt
			}
			Else
			{
				$txt = "Unable to retrieve StoreFront Server for $($SFInfo.LeafName)"
				OutputWarning $txt
			}
		}
	}
	ElseIf($? -and ($Null -eq $SFInfos))
	{
		$txt = "StoreFront is not configured for this Site"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve StoreFront configuration"
		OutputWarning $txt
	}
	
	Write-Verbose "$(Get-Date): "
}

Function OutputStoreFront
{
	Param([object]$SFServer, [object] $SFInfo)
	
	$DGCnt = $SFInfo.DesktopGroupUids.Count
	
	Write-Verbose "$(Get-Date): `t`t`tOutput StoreFront server $($SFServer.Name)"
	If($MSWord -or $PDF)
	{
		WriteWordLine 2 0 "Server: " $SFServer.Name
		[System.Collections.Hashtable[]] $ScriptInformation = @()
		$ScriptInformation += @{ Data = "StoreFront Server"; Value = $SFServer.Name; }
		$ScriptInformation += @{ Data = "Used by # Delivery Groups"; Value = $DGCnt; }
		$ScriptInformation += @{ Data = "URL"; Value = $SFServer.Url; }
		$ScriptInformation += @{ Data = "Description"; Value = $SFServer.Description; }
		$Table = AddWordTable -Hashtable $ScriptInformation `
		-Columns Data,Value `
		-List `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Columns.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 150;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($Text)
	{
		Line 0 "Server"
		Line 0 "StoreFront Server`t`t: " $SFServer.Name
		Line 0 "Used by # Delivery Groups`t: " $DGCnt
		Line 0 "URL`t`t`t`t: " $SFServer.Url
		Line 0 "Description`t`t`t: " $SFServer.Description
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 2 0 "Server: " $SFServer.Name
		$rowdata = @()
		$columnHeaders = @("StoreFront Server",($htmlsilver -bor $htmlbold),$SFServer.Name,$htmlwhite)
		$rowdata += @(,('Used by # Delivery Groups',($htmlsilver -bor $htmlbold),$DGCnt,$htmlwhite))
		$rowdata += @(,('URL',($htmlsilver -bor $htmlbold),$SFServer.Url,$htmlwhite))
		$rowdata += @(,('Description',($htmlsilver -bor $htmlbold),$SFServer.Description,$htmlwhite))

		$msg = ""
		$columnWidths = @("150","250")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "400"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputStoreFrontDeliveryGroups
{
	Param([object] $SFInfo)
	
	$DeliveryGroups = @()
	ForEach($DGUid in $SFInfo.DesktopGroupUids)
	{
		$Results = Get-BrokerDesktopGroup -Uid $DGUid
		If($? -and $Null -ne $Results)
		{
			$DeliveryGroups += $Results.Name
		}
	}

	[array]$DeliveryGroups = $DeliveryGroups | Sort-Object
	
	If($MSWord -or $PDF)
	{
		WriteWordLine 4 0 "Delivery Groups"
		[System.Collections.Hashtable[]] $DGWordTable = @();
		ForEach($Group in $DeliveryGroups)
		{
			$WordTableRowHash = @{ 
			DGName = $Group;
			}

			$DGWordTable += $WordTableRowHash;
		}
		$Table = AddWordTable -Hashtable $DGWordTable `
		-Columns DGName `
		-Headers "Delivery Group" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitContent;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Delivery Groups"
		Line 0 ""
		$cnt = -1
		ForEach($Group in $DeliveryGroups)
		{
			$cnt++
			If($cnt -eq 0)
			{
				Line 1 "Delivery Group: " $Group
			}
			Else
			{
				Line 3 "" $Group
			}
		}
		Line 0 ""
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 4 0 "Delivery Groups"
		$rowdata = @()
		ForEach($Group in $DeliveryGroups)
		{
			$rowdata += @(,(
			$Group,$htmlwhite))
		}

		$columnHeaders = @(
		'Delivery Group',($htmlsilver -bor $htmlbold))

		$msg = ""
		FormatHTMLTable $msg "auto" -rowArray $rowdata -columnArray $columnHeaders
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region AppV functions
Function ProcessAppV
{
	Write-Verbose "$(Get-Date): Processing App-V"
	
	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "App-V Publishing"
	}
	ElseIf($Text)
	{
		Line 0 "App-V Publishing"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "App-V Publishing"
	}
	
	Write-Verbose "$(Get-Date): `tRetrieving App-V configuration"
	$AppVConfigs = Get-BrokerMachineConfiguration @XDParams1 -Name appv* 4>$Null
	
	If($? -and $Null -ne $AppVConfigs)
	{
		Write-Verbose "$(Get-Date): `t`tRetrieving App-V server information"
		
		$AppVs = @()
		ForEach($AppVConfig in $AppVConfigs)
		{
			$AppV = Get-CtxAppVServer -ByteArray $AppVConfig.Policy -EA 0 4>$Null
			If($? -and ($Null -ne $AppV))
			{
				$obj = New-Object -TypeName PSObject
				$obj | Add-Member -MemberType NoteProperty -Name MgmtServer	-Value $AppV.ManagementServer
				$obj | Add-Member -MemberType NoteProperty -Name PubServer	-Value $AppV.PublishingServer
				$AppVs += $obj
			}
			ElseIf($? -and ($Null -eq $AppV))
			{
				$txt = "There was no App-V server information found for $($AppVConfig.Policy)"
				OutputWarning $txt
			}
			Else
			{
				$txt = "Unable to retrieve App-V information for $($AppVConfig.Policy)"
				OutputWarning $txt
			}
		}
		
		$AppVs = $AppVs | Sort-Object MgmtServer
		
		OutputAppV $AppVs
	}
	ElseIf($? -and $Null -eq $AppVConfigs)
	{
		$txt = "App-V is not configured for this Site"
		OutputWarning $txt
	}
	Else
	{
		$txt = "Unable to retrieve App-V configuration"
		OutputWarning $txt
	}
	Write-Verbose "$(Get-Date): "
}

Function OutputAppV
{
	Param([object]$AppVs)
	
	Write-Verbose "$(Get-Date): `t`t`tOutput App-V server information"
	If($MSWord -or $PDF)
	{
		[System.Collections.Hashtable[]] $AppVWordTable = @();
	}
	ElseIf($HTML)
	{
		$rowdata = @()
	}
	
	ForEach($AppV in $AppVs)
	{
		Write-Verbose "$(Get-Date): `t`t`tAdding AppV Server $($AppV.MgmtServer)"

		If($MSWord -or $PDF)
		{
			$WordTableRowHash = @{
			MgmtServer = $AppV.MgmtServer; 
			PubServer = $AppV.PubServer; 
			}
			$AppVWordTable += $WordTableRowHash;
		}
		ElseIf($Text)
		{
			Line 1 "App-V management server`t: " $AppV.MgmtServer
			Line 1 "App-V publishing server`t: " $AppV.PubServer
			Line 0 ""
		}
		ElseIf($HTML)
		{
			$rowdata += @(,(
			$AppV.MgmtServer,$htmlwhite,
			$AppV.PubServer,$htmlwhite))
		}
	}

	If($MSWord -or $PDF)
	{
		$Table = AddWordTable -Hashtable $AppVWordTable `
		-Columns  MgmtServer,PubServer `
		-Headers  "App-V management server","App-V publishing server" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 250;
		$Table.Columns.Item(2).Width = 250;

		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
		WriteWordLine 0 0 ""
	}
	ElseIf($HTML)
	{
		$columnHeaders = @(
		'App-V management server',($htmlsilver -bor $htmlbold),
		'App-V publishing server',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("250","250")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
		WriteHTMLLine 0 0 " "
	}
}
#endregion

#region zones
Function ProcessZones
{
	Write-Verbose "$(Get-Date): Processing Zones"

	$Script:TotalZones = 0

	If($MSWord -or $PDF)
	{
		$Selection.InsertNewPage()
		WriteWordLine 1 0 "Zones"
	}
	ElseIf($Text)
	{
		Line 0 "Zones"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "Zones"
	}
	
	#get all zone names
	Write-Verbose "$(Get-Date): `tRetrieving All Zones"
	$Zones = Get-ConfigZone @XDParams1 | Sort-Object Name
	$ZoneMembers = @()
	
	ForEach($Zone in $Zones)
	{
		$Script:TotalZones++
		Write-Verbose "$(Get-Date): `t`tRetrieving Machine Catalogs for Zone $($Zone.Name)"
		$ZoneCatalogs = Get-BrokerCatalog @XDParams2 -ZoneUid $Zone.Uid
		ForEach($ZoneCatalog in $ZoneCatalogs)
		{
			$obj = New-Object -TypeName PSObject
	
			$obj | Add-Member -MemberType NoteProperty -Name MemName -Value $ZoneCatalog.Name
			$obj | Add-Member -MemberType NoteProperty -Name MemDesc -Value $ZoneCatalog.Description
			$obj | Add-Member -MemberType NoteProperty -Name MemType -Value "Machine Catalog"
			$obj | Add-Member -MemberType NoteProperty -Name MemZone -Value $Zone.Name
			
			$ZoneMembers += $obj
		}
		
		Write-Verbose "$(Get-Date): `t`tRetrieving Delivery Controllers for Zone $($Zone.Name)"
		$ZoneControllers = $Zone.ControllerNames
		ForEach($ZoneController in $ZoneControllers)
		{
			$Results = Get-BrokerController -EA 0 | Where-Object {$_.MachineName -Like "*$($ZoneController)"}
			
			If($? -and $Null -ne $Results)
			{
				$obj = New-Object -TypeName PSObject
	
				$obj | Add-Member -MemberType NoteProperty -Name MemName -Value $ZoneController
				$obj | Add-Member -MemberType NoteProperty -Name MemDesc -Value $Results.DNSName
				$obj | Add-Member -MemberType NoteProperty -Name MemType -Value "Delivery Controller"
				$obj | Add-Member -MemberType NoteProperty -Name MemZone -Value $Zone.Name
			
				$ZoneMembers += $obj
			}
		}

		Write-Verbose "$(Get-Date): `t`tRetrieving Host Connections for Zone $($Zone.Name)"
		$ZoneHosts = Get-ChildItem @XDParams1 -path 'xdhyp:\connections' 4>$Null | Where-Object {$_.ZoneUid -eq $Zone.Uid}
		ForEach($ZoneHost in $ZoneHosts)
		{
			$obj = New-Object -TypeName PSObject
			
			$obj | Add-Member -MemberType NoteProperty -Name MemName -Value $ZoneHost.HypervisorConnectionName
			$obj | Add-Member -MemberType NoteProperty -Name MemDesc -Value ""
			$obj | Add-Member -MemberType NoteProperty -Name MemType -Value "Host Connection"
			$obj | Add-Member -MemberType NoteProperty -Name MemZone -Value $Zone.Name
			
			$ZoneMembers += $obj
		}
	}
	
	OutputZoneSiteView $ZoneMembers
	
	OutputPerZoneView $ZoneMembers $Zones
}

Function OutputZoneSiteView
{
	Param([array]$ZoneMembers)
	
	Write-Verbose "$(Get-Date): `tOutput Zone Site View"
	$ZoneMembers = $ZoneMembers | Sort-Object MemName
	
	If($MSWord -or $PDF)
	{
		WriteWordLine 2 0 "Site View"
		[System.Collections.Hashtable[]] $ZoneWordTable = @();

		ForEach($ZoneMember in $ZoneMembers)
		{
			$WordTableRowHash = @{ 
			xName = $ZoneMember.MemName;
			xDesc = $ZoneMember.MemDesc;
			xType = $ZoneMember.MemType;
			xZone = $ZoneMember.MemZone;
			}

			$ZoneWordTable += $WordTableRowHash;
		}

		$Table = AddWordTable -Hashtable $ZoneWordTable `
		-Columns xName, xDesc, xType, xZone `
		-Headers "Name", "Description", "Type", "Zone" `
		-Format $wdTableGrid `
		-AutoFit $wdAutoFitFixed;

		SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

		$Table.Columns.Item(1).Width = 125;
		$Table.Columns.Item(2).Width = 175;
		$Table.Columns.Item(3).Width = 100;
		$Table.Columns.Item(4).Width = 100;
		
		$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

		FindWordDocumentEnd
		$Table = $Null
	}
	ElseIf($Text)
	{
		Line 0 "Site View"
		Line 0 ""
		ForEach($ZoneMember in $ZoneMembers)
		{
			Line 1 "Name`t`t: " $ZoneMember.MemName
			Line 1 "Description`t: " $ZoneMember.MemDesc
			Line 1 "Type`t`t: " $ZoneMember.MemType
			Line 1 "Zone`t`t: " $ZoneMember.MemZone
			Line 0 ""
		}
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 2 0 "Site View"
		$rowdata = @()
		ForEach($ZoneMember in $ZoneMembers)
		{
			$rowdata += @(,(
			$ZoneMember.MemName,$htmlwhite,
			$ZoneMember.MemDesc,$htmlwhite,
			$ZoneMember.MemType,$htmlwhite,
			$ZoneMember.MemZone,$htmlwhite))
		}
		
		$columnHeaders = @(
		'Name',($htmlsilver -bor $htmlbold),
		'Description',($htmlsilver -bor $htmlbold),
		'Type',($htmlsilver -bor $htmlbold),
		'Zone',($htmlsilver -bor $htmlbold))

		$msg = ""
		$columnWidths = @("150","200","150","150")
		FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "650"
		WriteHTMLLine 0 0 " "
	}
}

Function OutputPerZoneView
{
	Param([array]$ZoneMembers, [object]$Zones)
	
	Write-Verbose "$(Get-Date): `tOutput Per Zone View"
	$ZoneMembers = $ZoneMembers | Sort-Object MemZone, MemName

	ForEach($Zone in $Zones)
	{
		$TmpZoneMembers = $ZoneMembers | Where-Object {$_.MemZone -eq $Zone.Name}
		
		If($MSWord -or $PDF)
		{
			WriteWordLine 2 0 $Zone.Name
			[System.Collections.Hashtable[]] $ZoneWordTable = @();

			ForEach($ZoneMember in $TmpZoneMembers)
			{
				$WordTableRowHash = @{ 
				xName = $ZoneMember.MemName;
				xDesc = $ZoneMember.MemDesc;
				xType = $ZoneMember.MemType;
				}

				$ZoneWordTable += $WordTableRowHash;
			}

			$Table = AddWordTable -Hashtable $ZoneWordTable `
			-Columns xName, xDesc, xType `
			-Headers "Name", "Description", "Type" `
			-Format $wdTableGrid `
			-AutoFit $wdAutoFitFixed;

			SetWordCellFormat -Collection $Table.Rows.Item(1).Cells -Bold -BackgroundColor $wdColorGray15;

			$Table.Columns.Item(1).Width = 125;
			$Table.Columns.Item(2).Width = 175;
			$Table.Columns.Item(3).Width = 100;
			
			$Table.Rows.SetLeftIndent($Indent0TabStops,$wdAdjustProportional)

			FindWordDocumentEnd
			$Table = $Null
			WriteWordLine 0 0 ""
		}
		ElseIf($Text)
		{
			Line 0 $Zone.Name
			Line 0 ""
			ForEach($ZoneMember in $TmpZoneMembers)
			{
				Line 1 "Name`t`t: " $ZoneMember.MemName
				Line 1 "Description`t: " $ZoneMember.MemDesc
				Line 1 "Type`t`t: " $ZoneMember.MemType
				Line 0 ""
			}
		}
		ElseIf($HTML)
		{
			WriteHTMLLine 2 0 $Zone.Name
			$rowdata = @()
			ForEach($ZoneMember in $TmpZoneMembers)
			{
				$rowdata += @(,(
				$ZoneMember.MemName,$htmlwhite,
				$ZoneMember.MemDesc,$htmlwhite,
				$ZoneMember.MemType,$htmlwhite))
			}
			
			$columnHeaders = @(
			'Name',($htmlsilver -bor $htmlbold),
			'Description',($htmlsilver -bor $htmlbold),
			'Type',($htmlsilver -bor $htmlbold),
			'Zone',($htmlsilver -bor $htmlbold))

			$msg = ""
			$columnWidths = @("150","200","150")
			FormatHTMLTable $msg -rowArray $rowdata -columnArray $columnHeaders -fixedWidth $columnWidths -tablewidth "500"
			WriteHTMLLine 0 0 " "
		}
	}
}

#endregion

#region summary page
Function ProcessSummaryPage
{
	#summary page
	Write-Verbose "$(Get-Date): Create Summary Page"
	
	If($MSWord -or $PDF)
	{
		$selection.InsertNewPage()
		WriteWordLine 1 0 "XenDesktop $($Script:XDSiteVersion) $($XDSiteName) Summary Page"
	}
	ElseIf($Text)
	{
		Line 0 ""
		Line 0 "XenDesktop $($Script:XDSiteVersion) $($XDSiteName) Summary Page"
	}
	ElseIf($HTML)
	{
		WriteHTMLLine 1 0 "XenDesktop $($Script:XDSiteVersion) $($XDSiteName) Summary Page"
	}

	Write-Verbose "$(Get-Date): `tAdd administrator summary info"
	If($MSWord -or $PDF)
	{
		Write-Verbose "$(Get-Date): `tAdd Machine Catalog summary info"
		WriteWordLine 0 0 "Machine Catalogs"
		WriteWordLine 0 1 "Total Server OS Catalogs`t: " $Script:TotalServerOSCatalogs
		WriteWordLine 0 1 "Total Desktop OS Catalogs`t: " $Script:TotalDesktopOSCatalogs
		WriteWordLine 0 1 "Total RemotePC Catalogs`t: " $Script:TotalRemotePCCatalogs
		WriteWordLine 0 2 "Total Machine Catalogs`t: " ($Script:TotalServerOSCatalogs+$Script:TotalDesktopOSCatalogs+$Script:TotalRemotePCCatalogs)
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd Delivery Group summary info"
		WriteWordLine 0 0 "Delivery Groups"
		WriteWordLine 0 1 "Total Application Groups`t: " $Script:TotalApplicationGroups
		WriteWordLine 0 1 "Total Desktop Groups`t`t: " $Script:TotalDesktopGroups
		WriteWordLine 0 1 "Total Apps & Desktop Groups`t: " $Script:TotalAppsAndDesktopGroups
		WriteWordLine 0 2 "Total Delivery Groups`t: " ($Script:TotalApplicationGroups+$Script:TotalDesktopGroups+$Script:TotalAppsAndDesktopGroups)
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd Application summary info"
		WriteWordLine 0 0 "Applications"
		WriteWordLine 0 1 "Total Published Applications`t: " $Script:TotalPublishedApplications
		WriteWordLine 0 1 "Total App-V Applications`t: " $Script:TotalAppvApplications
		WriteWordLine 0 2 "Total Applications`t: " ($Script:TotalPublishedApplications + $Script:TotalAppvApplications)
		WriteWordLine 0 0 ""
		
		If($Policies -eq $True)
		{
			Write-Verbose "$(Get-Date): `tAdd Policy summary info"
			WriteWordLine 0 0 "Policies"
			WriteWordLine 0 1 "Total Computer Policies`t`t: " $Script:TotalComputerPolicies
			WriteWordLine 0 1 "Total User Policies`t`t: " $Script:TotalUserPolicies
			WriteWordLine 0 2 "Total Policies`t`t: " ($Script:TotalComputerPolicies + $Script:TotalUserPolicies)
			WriteWordLine 0 0 ""
			WriteWordLine 0 1 "Site Policies`t`t`t: " $Script:TotalSitePolicies
			
			If($NoADPolicies -eq $False)
			{
				WriteWordLine 0 1 "Citrix AD Policies Processed`t: $($Script:TotalADPolicies)`t(AD Policies can contain multiple Citrix policies)"
				WriteWordLine 0 1 "Citrix AD Policies not Processed`t: " $Script:TotalADPoliciesNotProcessed
			}
			WriteWordLine 0 0 ""
		}
		
		WriteWordLine 0 0 "Administrators"
		WriteWordLine 0 1 "Total Delivery Group Admins`t: " $Script:TotalDeliveryGroupAdmins
		WriteWordLine 0 1 "Total Full Admins`t`t: " $Script:TotalFullAdmins
		WriteWordLine 0 1 "Total Help Desk Admins`t`t: " $Script:TotalHelpDeskAdmins
		WriteWordLine 0 1 "Total Host Admins`t`t: " $Script:TotalHostAdmins
		WriteWordLine 0 1 "Total Machine Catalog Admins`t: " $Script:TotalMachineCatalogAdmins
		WriteWordLine 0 1 "Total Read Only Admins`t`t: " $Script:TotalReadOnlyAdmins
		WriteWordLine 0 1 "Total Custom Admins`t`t: " $Script:TotalCustomAdmins
		WriteWordLine 0 2 "Total Administrators`t: " ($Script:TotalDeliveryGroupAdmins+$Script:TotalFullAdmins+$Script:TotalHelpDeskAdmins+$Script:TotalHostAdmins+$Script:TotalMachineCatalogAdmins+$Script:TotalReadOnlyAdmins+$Script:TotalCustomAdmins)
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd Controller summary info"
		WriteWordLine 0 0 "Controllers"
		WriteWordLine 0 1 "Total Controllers`t`t: " $Script:TotalControllers
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd Hosting Connection summary info"
		WriteWordLine 0 0 "Hosting Connections"
		WriteWordLine 0 1 "Total Hosting Connections`t: " $Script:TotalHostingConnections
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd Licensing summary info"
		WriteWordLine 0 0 "Licensing"
		$TotalLicenses = 0
		ForEach($License in $Script:Licenses)
		{
			WriteWordLine 0 1 "$($License.LicenseProduct) $($License.LicenseType) $($License.LicenseModel)`t`t`t: $($License.LicenseCount)"
			$TotalLicenses += $License.LicenseCount
		}
		WriteWordLine 0 2 "Total Licenses`t`t: " $TotalLicenses
		WriteWordLine 0 0 ""
		Write-Verbose "$(Get-Date): `tAdd StoreFront summary info"
		WriteWordLine 0 0 "StoreFront"
		WriteWordLine 0 1 "Total StoreFront Servers`t: " $Script:TotalStoreFrontServers
		WriteWordLine 0 0 ""
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			Write-Verbose "$(Get-Date): `tAdd Zone summary info"
			WriteWordLine 0 0 "Zones"
			WriteWordLine 0 1 "Total Zones`t`t`t: " $Script:TotalZones
		}
	}
	ElseIf($Text)
	{
		Write-Verbose "$(Get-Date): `tAdd Machine Catalog summary info"
		Line 0 "Machine Catalogs"
		Line 1 "Total Server OS Catalogs`t: " $Script:TotalServerOSCatalogs
		Line 1 "Total Desktop OS Catalogs`t: " $Script:TotalDesktopOSCatalogs
		Line 1 "Total RemotePC Catalogs`t`t: " $Script:TotalRemotePCCatalogs
		Line 2 "Total Machine Catalogs`t: " ($Script:TotalServerOSCatalogs+$Script:TotalDesktopOSCatalogs+$Script:TotalRemotePCCatalogs)
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd Delivery Group summary info"
		Line 0 "Delivery Groups"
		Line 1 "Total Application Groups`t: " $Script:TotalApplicationGroups
		Line 1 "Total Desktop Groups`t`t: " $Script:TotalDesktopGroups
		Line 1 "Total Apps & Desktop Groups`t: " $Script:TotalAppsAndDesktopGroups
		Line 2 "Total Delivery Groups`t: " ($Script:TotalApplicationGroups+$Script:TotalDesktopGroups+$Script:TotalAppsAndDesktopGroups)
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd Application summary info"
		Line 0 "Applications"
		Line 1 "Total Published Applications`t: " $Script:TotalPublishedApplications
		Line 1 "Total App-V Applications`t: " $Script:TotalAppvApplications
		Line 2 "Total Applications`t: " ($Script:TotalPublishedApplications + $Script:TotalAppvApplications)
		Line 0 ""
		
		If($Policies -eq $True)
		{
			Write-Verbose "$(Get-Date): `tAdd Policy summary info"
			Line 0 "Policies"
			Line 1 "Total Computer Policies`t`t: " $Script:TotalComputerPolicies
			Line 1 "Total User Policies`t`t: " $Script:TotalUserPolicies
			Line 2 "Total Policies`t`t: " ($Script:TotalComputerPolicies + $Script:TotalUserPolicies)
			Line 0 ""
			Line 1 "Site Policies`t`t`t: " $Script:TotalSitePolicies
			
			If($NoADPolicies -eq $False)
			{
				Line 1 "Citrix AD Policies Processed`t: $($Script:TotalADPolicies)`t(AD Policies can contain multiple Citrix policies)"
				Line 1 "Citrix AD Policies not Processed: " $Script:TotalADPoliciesNotProcessed
			}
			Line 0 ""
		}
		
		Line 0 "Administrators"
		Line 1 "Total Delivery Group Admins`t: " $Script:TotalDeliveryGroupAdmins
		Line 1 "Total Full Admins`t`t: " $Script:TotalFullAdmins
		Line 1 "Total Help Desk Admins`t`t: " $Script:TotalHelpDeskAdmins
		Line 1 "Total Host Admins`t`t: " $Script:TotalHostAdmins
		Line 1 "Total Machine Catalog Admins`t: " $Script:TotalMachineCatalogAdmins
		Line 1 "Total Read Only Admins`t`t: " $Script:TotalReadOnlyAdmins
		Line 1 "Total Custom Admins`t`t: " $Script:TotalCustomAdmins
		Line 2 "Total Administrators`t: " ($Script:TotalDeliveryGroupAdmins+$Script:TotalFullAdmins+$Script:TotalHelpDeskAdmins+$Script:TotalHostAdmins+$Script:TotalMachineCatalogAdmins+$Script:TotalReadOnlyAdmins+$Script:TotalCustomAdmins)
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd Controller summary info"
		Line 0 "Controllers"
		Line 1 "Total Controllers`t`t: " $Script:TotalControllers
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd Hosting Connection summary info"
		Line 0 "Hosting Connections"
		Line 1 "Total Hosting Connections`t: " $Script:TotalHostingConnections
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd Licensing summary info"
		Line 0 "Licensing"
		$TotalLicenses = 0
		ForEach($License in $Script:Licenses)
		{
			Line 1 "$($License.LicenseProduct) $($License.LicenseType) $($License.LicenseModel)`t`t`t: $($License.LicenseCount)"
			$TotalLicenses += $License.LicenseCount
		}
		Line 2 "Total Licenses`t`t: " $TotalLicenses
		Line 0 ""
		Write-Verbose "$(Get-Date): `tAdd StoreFront summary info"
		Line 0 "StoreFront"
		Line 1 "Total StoreFront Servers`t: " $Script:TotalStoreFrontServers
		Line 0 ""
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			Write-Verbose "$(Get-Date): `tAdd Zone summary info"
			Line 0 "Zones"
			Line 1 "Total Zones`t`t`t: " $Script:TotalZones
		}
	}
	ElseIf($HTML)
	{
		Write-Verbose "$(Get-Date): `tAdd Machine Catalog summary info"
		WriteHTMLLine 0 0 "Machine Catalogs"
		WriteHTMLLine 0 1 "Total Server OS Catalogs: " $Script:TotalServerOSCatalogs
		WriteHTMLLine 0 1 "Total Desktop OS Catalogs: " $Script:TotalDesktopOSCatalogs
		WriteHTMLLine 0 1 "Total RemotePC Catalogs: " $Script:TotalRemotePCCatalogs
		WriteHTMLLine 0 2 "Total Machine Catalogs: " ($Script:TotalServerOSCatalogs+$Script:TotalDesktopOSCatalogs+$Script:TotalRemotePCCatalogs)
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add Delivery Group summary info"
		WriteHTMLLine 0 0 "Delivery Groups"
		WriteHTMLLine 0 1 "Total Application Groups: " $Script:TotalApplicationGroups
		WriteHTMLLine 0 1 "Total Desktop Groups: " $Script:TotalDesktopGroups
		WriteHTMLLine 0 1 "Total Apps & Desktop Groups: " $Script:TotalAppsAndDesktopGroups
		WriteHTMLLine 0 2 "Total Delivery Groups: " ($Script:TotalApplicationGroups+$Script:TotalDesktopGroups+$Script:TotalAppsAndDesktopGroups)
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add Application summary info"
		WriteHTMLLine 0 0 "Applications"
		WriteHTMLLine 0 1 "Total Published Applications: " $Script:TotalPublishedApplications
		WriteHTMLLine 0 1 "Total App-V Applications: " $Script:TotalAppvApplications
		WriteHTMLLine 0 2 "Total Applications: " ($Script:TotalPublishedApplications + $Script:TotalAppvApplications)
		WriteHTMLLine 0 0 ""
		
		If($Policies -eq $True)
		{
			Write-Verbose "$(Get-Date): Add Policy summary info"
			WriteHTMLLine 0 0 "Policies"
			WriteHTMLLine 0 1 "Total Computer Policies: " $Script:TotalComputerPolicies
			WriteHTMLLine 0 1 "Total User Policies: " $Script:TotalUserPolicies
			WriteHTMLLine 0 2 "Total Policies: " ($Script:TotalComputerPolicies + $Script:TotalUserPolicies)
			WriteHTMLLine 0 0 ""
			WriteHTMLLine 0 1 "Site Policies: " $Script:TotalSitePolicies
			
			If($NoADPolicies -eq $False)
			{
				WriteHTMLLine 0 1 "Citrix AD Policies Processed: $($Script:TotalADPolicies)(AD Policies can contain multiple Citrix policies)"
				WriteHTMLLine 0 1 "Citrix AD Policies not Processed: " $Script:TotalADPoliciesNotProcessed
			}
			WriteHTMLLine 0 0 ""
		}
		
		WriteHTMLLine 0 0 "Administrators"
		WriteHTMLLine 0 1 "Total Delivery Group Admins: " $Script:TotalDeliveryGroupAdmins
		WriteHTMLLine 0 1 "Total Full Admins: " $Script:TotalFullAdmins
		WriteHTMLLine 0 1 "Total Help Desk Admins: " $Script:TotalHelpDeskAdmins
		WriteHTMLLine 0 1 "Total Host Admins: " $Script:TotalHostAdmins
		WriteHTMLLine 0 1 "Total Machine Catalog Admins: " $Script:TotalMachineCatalogAdmins
		WriteHTMLLine 0 1 "Total Read Only Admins: " $Script:TotalReadOnlyAdmins
		WriteHTMLLine 0 1 "Total Custom Admins: " $Script:TotalCustomAdmins
		WriteHTMLLine 0 2 "Total Administrators: " ($Script:TotalDeliveryGroupAdmins+$Script:TotalFullAdmins+$Script:TotalHelpDeskAdmins+$Script:TotalHostAdmins+$Script:TotalMachineCatalogAdmins+$Script:TotalReadOnlyAdmins+$Script:TotalCustomAdmins)
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add Controller summary info"
		WriteHTMLLine 0 0 "Controllers"
		WriteHTMLLine 0 1 "Total Controllers: " $Script:TotalControllers
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add Hosting Connection summary info"
		WriteHTMLLine 0 0 "Hosting Connections"
		WriteHTMLLine 0 1 "Total Hosting Connections: " $Script:TotalHostingConnections
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add Licensing summary info"
		WriteHTMLLine 0 0 "Licensing"
		$TotalLicenses = 0
		ForEach($License in $Script:Licenses)
		{
			WriteHTMLLine 0 1 "$($License.LicenseProduct) $($License.LicenseType) $($License.LicenseModel): $($License.LicenseCount)"
			$TotalLicenses += $License.LicenseCount
		}
		WriteHTMLLine 0 2 "Total Licenses: " $TotalLicenses
		WriteHTMLLine 0 0 ""
		Write-Verbose "$(Get-Date): Add StoreFront summary info"
		WriteHTMLLine 0 0 "StoreFront"
		WriteHTMLLine 0 1 "Total StoreFront Servers: " $Script:TotalStoreFrontServers
		WriteHTMLLine 0 0 ""
		If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
		{
			Write-Verbose "$(Get-Date): Add Zone summary info"
			WriteHTMLLine 0 0 "Zones"
			WriteHTMLLine 0 1 "Total Zones: " $Script:TotalZones
		}
	}

	Write-Verbose "$(Get-Date): Finished Create Summary Page"
	Write-Verbose "$(Get-Date): "
}
#endregion

#region script setup function
Function ProcessScriptSetup
{
	$script:startTime = Get-Date

	If(!(Check-NeededPSSnapins "Citrix.AdIdentity.Admin.V2",
	"Citrix.AppV.Admin.V1",
	"Citrix.Broker.Admin.V2",
	"Citrix.Common.Commands",
	"Citrix.Common.GroupPolicy",
	"Citrix.Configuration.Admin.V2",
	"Citrix.ConfigurationLogging.Admin.V1",
	"Citrix.DelegatedAdmin.Admin.V1",
	"Citrix.EnvTest.Admin.V1",
	"Citrix.Host.Admin.V2",
	"Citrix.Licensing.Admin.V1",
	"Citrix.MachineCreation.Admin.V2",
	"Citrix.Monitor.Admin.V1",
	"Citrix.Storefront.Admin.V1"))
	
	{
		#We're missing Citrix Snapins that we need
		$ErrorActionPreference = $SaveEAPreference
		Write-Error "`nMissing Citrix PowerShell Snap-ins Detected, check the console above for more information. 
		`nAre you sure you are running this script against a XenDesktop 7.x Controller? 
		`n`nIf you are running the script remotely, did you install Studio or the PowerShell snapins on $($env:computername)?
		`n`nPlease see the Prerequisites section in the ReadMe file (https://dl.dropboxusercontent.com/u/43555945/XD7_Inventory_V1_ReadMe.rtf).
		`n`nScript will now close."
		Exit
	}

	$Script:DoPolicies = $True
	If($NoPolicies)
	{
		Write-Verbose "$(Get-Date): NoPolicies was specified so do not search for Citrix.GroupPolicy.Commands.psm1"
		$Script:DoPolicies = $False
	}
	ElseIf(!(Check-LoadedModule "Citrix.GroupPolicy.Commands") -and $Policies -eq $False)
	{
		Write-Warning "The Citrix Group Policy module Citrix.GroupPolicy.Commands.psm1 could not be loaded `n
		Please see the Prerequisites section in the ReadMe file (https://dl.dropboxusercontent.com/u/43555945/XD7_Inventory_V1_ReadMe.rtf). 
		`nCitrix Policy documentation will not take place"
		Write-Verbose "$(Get-Date): "
		$Script:DoPolicies = $False
	}
	ElseIf(!(Check-LoadedModule "Citrix.GroupPolicy.Commands") -and $Policies -eq $True)
	{
		Write-Error "The Citrix Group Policy module Citrix.GroupPolicy.Commands.psm1 could not be loaded 
		`nPlease see the Prerequisites section in the ReadMe file (https://dl.dropboxusercontent.com/u/43555945/XD7_Inventory_V1_ReadMe.rtf). 
		`n
		`n
		`t`tBecause the Policies parameter was used the script will now close.
		`n
		`n"
		Write-Verbose "$(Get-Date): "
		Exit
	}
	
	If($Policies -eq $False -and $NoPolicies -eq $False -and $NoADPolicies -eq $False)
	{
		#script defaults, so don't process policies
		$Script:DoPolicies = $False
	}
	If($NoPolicies -eq $True)
	{
		#don't process policies
		$Script:DoPolicies = $False
	}
	
	#set value for MaxRecordCount
	$Script:MaxRecordCount = [int]::MaxValue 

	If([String]::IsNullOrEmpty($AdminAddress))
	{
		$AdminAddress = "LocalHost"
	}

	$Script:XDParams1 = @{
	adminaddress = $AdminAddress; 
	EA = 0;
	}

	$Script:XDParams2 = @{
	adminaddress = $AdminAddress; 
	EA = 0;
	MaxRecordCount = $Script:MaxRecordCount;
	}

	# Get Site information
	Write-Verbose "$(Get-Date): Gathering initial Site data"

	$Script:XDSite1 = Get-BrokerSite @XDParams1

	If( !($?) -or $Null -eq $Script:XDSite1)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Warning "XenDesktop Site1 information could not be retrieved.  Script cannot continue"
		Write-Error "cmdlet failed $($error[ 0 ].ToString())"
		AbortScript
	}

	$Script:XDSite2 = Get-ConfigSite @XDParams1

	If( !($?) -or $Null -eq $Script:XDSite2)
	{
		$ErrorActionPreference = $SaveEAPreference
		Write-Warning "XenDesktop Site2 information could not be retrieved.  Script cannot continue"
		Write-Error "cmdlet failed $($error[ 0 ].ToString())"
		AbortScript
	}
	
	#$Script:XDSiteVersion = (Get-RegistryValue "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Citrix Desktop Delivery Controller" "DisplayVersion").Substring(0,3)
	
	#changed 18-dec-2016 to allow 32-bit PoSH to get the data in the 64-bit registry location
	#initial idea from WC at Citrix and also from http://stackoverflow.com/questions/630382/how-to-access-the-64-bit-registry-from-a-32-bit-powershell-instance reply from SergVro
	$key = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64)
	$subKey =  $key.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Citrix Desktop Delivery Controller")

	#new test added 23-Jun-2017
	#if subkey is Null, then check the -AdminAddress computer for the key
	If($Null -eq $subkey)
	{
		Write-Verbose "$(Get-Date): Could not find the version information on $($env:ComputerName), testing $($AdminAddress) now"
		$key = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine', $AdminAddress)
		$subKey =  $key.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Citrix Desktop Delivery Controller")
		
		If($Null -eq $subkey)
		{
			#something is really wrong
			Write-Verbose "$(Get-Date): Could not find the version information on $($AdminAddress),`n`nScript cannot continue`n "
			AbortScript
		}
		
		$value = $subKey.GetValue("DisplayVersion")
		$Script:XDSiteVersion = $value.Substring(0,4)
		$tmp = $Script:XDSiteVersion.Split(".")
		[int]$MajorVersion = $tmp[0]
		[int]$MinorVersion = $tmp[1]
	}
	Else
	{
		Write-Verbose "$(Get-Date): Found the version information on $($env:ComputerName)"
	}

	$value = $subKey.GetValue("DisplayVersion")
	$Script:XDSiteVersion = $value.Substring(0,3)
	$tmp = $Script:XDSiteVersion.Split(".")
	[int]$MajorVersion = $tmp[0]
	[int]$MinorVersion = $tmp[1]
	
	Write-Verbose "$(Get-Date): You are running version $($value)"
	Write-Verbose "$(Get-Date): Major version $($MajorVersion)"
	Write-Verbose "$(Get-Date): Minor version $($MinorVersion)"

	#first check to make sure this is a Site between 7.0 and 7.7
	If($MajorVersion -eq 7)
	{
		#this is a XenDesktop 7.x Site, now test to make sure it is less than 7.8
		If($MinorVersion -ge 8)
		{
			Write-Warning "This script is designed for XenDesktop 7.7 and prior and should not be run on 7.8 and later.`n`nScript cannot continue`n"
			AbortScript
		}
	}
	ElseIf($MajorVersion -eq 0 -and $MinorVersion -eq 0)
	{
		#something is wrong, we shouldn't be here
		Write-Verbose "$(Get-Date): Something bad happened. We shouldn't be here. Could not find the version information.`n`nScript cannot continue`n"
		AbortScript
	}
	Else
	{
		#this is not a XenDesktop 7.x Site, script cannot proceed
		Write-Warning "This script is designed for XenDesktop 7.x and should not be run on other versions of XenDesktop.`n`nScript cannot continue`n"
		AbortScript
	}

	#if analytics is a registered service, then load the snapin
	$Script:CanDoAnalytics = $False
	If((Get-ConfigRegisteredServiceInstance | Where-Object {$_.ServiceType -eq "Analytics"}).Count -gt 0)
	{
		If(!(Check-NeededPSSnapins "Citrix.Analytics.Admin.V1"))
		{
			#We're missing Citrix Snapins that we need
			$ErrorActionPreference = $SaveEAPreference
			Write-Error "Missing Citrix PowerShell Analytics Snap-in Detected, check the console above for more information. `nCEIP will not be shown."
		}
		Else
		{
			$Script:CanDoAnalytics = $True
		}
	}
	
	[string]$Script:XDSiteName = $Script:XDSite2.SiteName
	Switch ($Section)
	{
		"Admins" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Administrators Only)"; Break}
		"Apps" 			{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Applications Only)"; Break}
		"AppV" 			{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (App-V Only"; Break}
		"Catalogs" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Machine Catalogs Only)"; Break}
		"Config" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Configuration Only)"; Break}
		"Controllers"	{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Controllers Only)"; Break}
		"Groups" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Delivery Groups Only)"; Break}
		"Hosting" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Hosting Only)"; Break}
		"Licensing" 	{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Licensing Only)"; Break}
		"Logging" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Configuration Logging Only"; Break}
		"Policies" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Policies Only)"; Break}
		"StoreFront" 	{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (StoreFront Only)"; Break}
		"Zones" 		{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site (Zones Only)"; Break}
		"All" 			{[string]$Script:Title = "Inventory Report for the $($Script:XDSiteName) Site"; Break}
	}
	Write-Verbose "$(Get-Date): Initial Site data has been gathered"
	
	#added 25-Jun-2017 with a lot of help from Michael B. Smith
	#make sure the SQL Server assembly is loaded, if not, later on don't bother calculating the various database sizes
	Write-Verbose "$(Get-Date): Loading SQL Server Assembly"
	[bool]$Script:SQLServerLoaded = $False
	
	$asm = [reflection.assembly]::loadwithpartialname('microsoft.sqlserver.smo')
	If( $null –eq $asm )
	{
		Write-Verbose "$(Get-Date): `tSQL Server Assembly could not be loaded"
		$Script:SQLServerLoaded = $False
	}
	Else
	{
		Write-Verbose "$(Get-Date): `tSQL Server Assembly successefully loaded"
		$Script:SQLServerLoaded = $True
	}
}
#endregion

#region script end
Function ProcessScriptEnd
{
	Write-Verbose "$(Get-Date): Script has completed"
	Write-Verbose "$(Get-Date): "

	#http://poshtips.com/measuring-elapsed-time-in-powershell/
	Write-Verbose "$(Get-Date): Script started: $($Script:StartTime)"
	Write-Verbose "$(Get-Date): Script ended: $(Get-Date)"
	$runtime = $(Get-Date) - $Script:StartTime
	$Str = [string]::format("{0} days, {1} hours, {2} minutes, {3}.{4} seconds", `
		$runtime.Days, `
		$runtime.Hours, `
		$runtime.Minutes, `
		$runtime.Seconds,
		$runtime.Milliseconds)
	Write-Verbose "$(Get-Date): Elapsed time: $($Str)"
	If($Dev)
	{
		If($SmtpServer -eq "")
		{
			Out-File -FilePath $Script:DevErrorFile -InputObject $error 4>$Null
		}
		Else
		{
			Out-File -FilePath $Script:DevErrorFile -InputObject $error -Append 4>$Null
		}
	}

	If($ScriptInfo)
	{
		$SIFile = "$($pwd.Path)\XAXD7V1InventoryScriptInfo_$(Get-Date -f yyyy-MM-dd_HHmm).txt"
		Out-File -FilePath $SIFile -InputObject "" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "AddDateTime     : $($AddDateTime)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "AdminAddress    : $($AdminAddress)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Administrators  : $($Administrators)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Applications    : $($Applications)" 4>$Null
		If($MSWORD -or $PDF)
		{
			Out-File -FilePath $SIFile -Append -InputObject "Company Name    : $($Script:CoName)" 4>$Null
			Out-File -FilePath $SIFile -Append -InputObject "Company Address : $($CompanyAddress)" 4>$Null		
			Out-File -FilePath $SIFile -Append -InputObject "Company Email   : $($CompanyEmail)" 4>$Null		
			Out-File -FilePath $SIFile -Append -InputObject "Company Fax     : $($CompanyFax)" 4>$Null		
			Out-File -FilePath $SIFile -Append -InputObject "Company Phone   : $($CompanyPhone)" 4>$Null		
			Out-File -FilePath $SIFile -Append -InputObject "Cover Page      : $($CoverPage)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "DeliveryGroups  : $($DeliveryGroups)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Dev             : $($Dev)" 4>$Null
		If($Dev)
		{
			Out-File -FilePath $SIFile -Append -InputObject "DevErrorFile    : $($Script:DevErrorFile)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "DGUtilization   : $($DeliveryGroupsUtilization)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Filename1       : $($Script:Filename1)" 4>$Null
		If($PDF)
		{
			Out-File -FilePath $SIFile -Append -InputObject "Filename2       : $($Script:Filename2)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "Folder          : $($Folder)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "From            : $($From)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Hosting         : $($Hosting)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "HW Inventory    : $($Hardware)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Log             : $($Log)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Logging         : $($Logging)" 4>$Null
		If($Logging)
		{
			Out-File -FilePath $SIFile -Append -InputObject "   Start Date   : $($StartDate)" 4>$Null
			Out-File -FilePath $SIFile -Append -InputObject "   End Date     : $($EndDate)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "MachineCatalogs : $($MachineCatalogs)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "MaxDetails      : $($MaxDetails)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "NoADPolicies    : $($NoADPolicies)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "NoPolicies      : $($NoPolicies)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Policies        : $($Policies)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Save As HTML    : $($HTML)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Save As PDF     : $($PDF)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Save As TEXT    : $($TEXT)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Save As WORD    : $($MSWORD)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Section         : $($Section)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "ScriptInfo      : $($ScriptInfo)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Site Name       : $($XDSiteName)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Smtp Port       : $($SmtpPort)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Smtp Server     : $($SmtpServer)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "StoreFront      : $($StoreFront)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Title           : $($Script:Title)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "To              : $($To)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Use SSL         : $($UseSSL)" 4>$Null
		If($MSWORD -or $PDF)
		{
			Out-File -FilePath $SIFile -Append -InputObject "User Name       : $($UserName)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "XA/XD Version   : $($Script:XDSiteVersion)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "OS Detected  : $($Script:RunningOS)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "PoSH version : $($Host.Version)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "PSCulture    : $($PSCulture)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "PSUICulture  : $($PSUICulture)" 4>$Null
		If($MSWORD -or $PDF)
		{
			Out-File -FilePath $SIFile -Append -InputObject "Word language: $($Script:WordLanguageValue)" 4>$Null
			Out-File -FilePath $SIFile -Append -InputObject "Word version : $($Script:WordProduct)" 4>$Null
		}
		Out-File -FilePath $SIFile -Append -InputObject "" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Script start : $($Script:StartTime)" 4>$Null
		Out-File -FilePath $SIFile -Append -InputObject "Elapsed time : $($Str)" 4>$Null
	}

	#V1.40 added
	#stop transcript logging
	If($Log -eq $True) 
	{
		If($Script:StartLog -eq $true) 
		{
			try 
			{
				Stop-Transcript | Out-Null
				Write-Verbose "$(Get-Date): $Script:LogPath is ready for use"
			} 
			catch 
			{
				Write-Verbose "$(Get-Date): Transcript/log stop failed"
			}
		}
	}
	$runtime = $Null
	$Str = $Null
	$ErrorActionPreference = $SaveEAPreference
	$Script:DoPolicies = $Null
}
#endregion

#region script core
#Script begins

ProcessScriptSetup

SetFileName1andFileName2 "$($Script:XDSiteName)"

If($Section -eq "All" -or $Section -eq "Catalogs")
{
	ProcessMachineCatalogs
}

If($Section -eq "All" -or $Section -eq "Groups")
{
	ProcessDeliveryGroups
}

If($Section -eq "All" -or $Section -eq "Apps")
{
	ProcessApplications
}

If($Section -eq "All" -or $Section -eq "Policies")
{
	If($NoPolicies -or $Script:DoPolicies -eq $False)
	{
		#don't process policies
	}
	Else
	{
		ProcessPolicies
	}
}

If($Section -eq "All" -or $Section -eq "Logging")
{
	ProcessConfigLogging
}

If($Section -eq "All" -or $Section -eq "Config")
{
	ProcessConfiguration
}

If($Section -eq "All" -or $Section -eq "Admins")
{
	ProcessAdministrators
	ProcessScopes
	ProcessRoles
}

If($Section -eq "All" -or $Section -eq "Controllers")
{
	ProcessControllers
}

If($Section -eq "All" -or $Section -eq "Hosting")
{
	ProcessHosting
}

If($Section -eq "All" -or $Section -eq "Licensing")
{
	ProcessLicensing
}

If($Section -eq "All" -or $Section -eq "StoreFront")
{
	ProcessStoreFront
}

If($Section -eq "All" -or $Section -eq "AppV")
{
	ProcessAppV
}

If($Section -eq "All" -or $Section -eq "Zones")
{
	If((Get-ConfigServiceAddedCapability @XDParams1) -contains "ZonesSupport")
	{
		ProcessZones
	}
}

If($Section -eq "All")
{
	ProcessSummaryPage
}

#endregion

#region finish script
Write-Verbose "$(Get-Date): Finishing up document"
#end of document processing

$AbstractTitle = "Citrix XenDesktop $($Script:XDSiteVersion) Inventory"
$SubjectTitle = "XenDesktop $($Script:XDSiteVersion) Site Inventory"
UpdateDocumentProperties $AbstractTitle $SubjectTitle

ProcessDocumentOutput

ProcessScriptEnd

#endregion
