
sidebarPanel(
	wellPanel(
       		fileInput('timesheet_dat', strong("Please load timeSheet (.csv)"),accept=c('.csv') )
     	),

     	wellPanel(
		p(strong("Time Period of Analysis")),
		dateInput('start',label = 'Start date:',value = Sys.Date()),
		dateInput('end',label = 'End date:',value = Sys.Date()+30)
     	)
)


