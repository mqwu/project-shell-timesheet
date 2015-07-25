
tabPanel('Summary', 
	br(),
	strong(div("Time period", style="color:#535359")),
		verbatimTextOutput("tableTimeperiod"), br(),
		
    strong(div("Overview", style="color:#535359")),
		tableOutput("tableOverview"), 
		
    strong(div("Summary by project", style="color:#535359")),
		tableOutput("tableSumByProj"), br(),
    
	strong(div("Plot", style="color:#535359")),
		plotOutput("plotProjByMonth", height="300px", width="1000px")
	)

