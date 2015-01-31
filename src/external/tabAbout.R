
tabPanel("About", 
	br(),
	p("This web application provides basic analysis of the loaded timesheet in a selected time period."), br(),

	strong(div("Author", style="color:#535359")),
	p(strong("Mingqi Wu"), 
		"is a statistical consultant in the", 
		a(span("Statistics and Chemometrics ", style="color:blue"), 
			href="http://sww.wiki.shell.com/wiki/index.php/Statistics_and_Chemometrics",
			target="_blank"),
		" department within P&T at Shell."
	 ), br(),

	strong(div("Contact", style="color:#535359")),
	p("Email:", a(span("Mingqi.Wu@shell.com", style="color:blue"), href="mailto:Mingqi.Wu@shell.com"), br(), 
		"Tel: +1 (281) 544-6412 Office: M-1006B@STCH", br(), br(),
		"Shell Global Solutions (US) Inc.", br(),
		"Shell Technology Center Houston", br(),
		"3333 Highway 6 South, Houston, TX 77082-3101")
) 

