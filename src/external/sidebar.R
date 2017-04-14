
sidebarPanel(
	wellPanel(
		p(strong("Step 1:"), br(),
		  "Please follow the", 
		  a("Timesheet Template",style="color:blue", href="../../charge15.xlsx", target="_blank"),
		  "to record your time in excel.", br()
		  ),
		
		p(strong("Step 2:"), br(),
		  "Please load timeSheet (.xlsx)",
       	  fileInput('timesheet_dat', NULL, accept=c('.xlsx'), multiple=TRUE)
		 )		 
     	),

    wellPanel(
		p(strong("Please select time period for analysis")),
		dateInput('start',label = 'Start date:',value = Sys.Date()-30),
		dateInput('end',label = 'End date:',value = Sys.Date())
     	)
		
)
