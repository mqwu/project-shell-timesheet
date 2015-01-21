
 shinyUI(pageWithSidebar(

  headerPanel("Analysis of TimeSheet"),

    sidebarPanel(
     wellPanel(
       fileInput('timesheet_dat', strong("Please load timeSheet (.csv)"),
                 accept=c('.csv') )
     ),

     wellPanel(
	p(strong("Time Period of Analysis")),
	dateInput('start',
      	label = 'Start date:',
      	value = Sys.Date()
	),

	dateInput('end',
      	label = 'End date:',
      	value = Sys.Date() + 30
    	)
     )
    ),  # sidebarPanel end


    mainPanel(
      tabsetPanel(
        tabPanel('Timesheet', 
		 dataTableOutput('mytable1'), br(),
  		 h4("Overview"),
              	 tableOutput("overview"), br(),
  		 h4("Details"),
              	 tableOutput("detail")
		 ),

	tabPanel("About", 
		h4("About the Authors"), br(),

		p(strong("Mingqi Wu"), 
			"is a statistical consultant in the", 
			a(span("Statistics and Chemometrics ", style="color:blue"), 
				href="http://sww.wiki.shell.com/wiki/index.php/Statistics_and_Chemometrics",
				target="_blank"),
			" department within P&T at Shell."
		 ), br(),

		h4("Contact"), br(),
		p(strong("Mingqi Wu")),
		p("Email:", a(span("Mingqi.Wu@shell.com", style="color:blue"), href="mailto:Mingqi.Wu@shell.com"), br(), 
			"Tel: +1 (281) 544-6412 Office: M-1006B", br(), br(),
			"Shell Global Solutions (US) Inc.", br(),
			"Shell Technology Center Houston", br(),
			"3333 Highway 6 South, Houston, TX 77082-3101")
		) # About end
      )  # tabsetPanel end
    )  # mainPanel end

))

