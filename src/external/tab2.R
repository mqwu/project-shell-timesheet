
tabPanel('Summary', 
		br(),
		strong(div("Time period", style="color:#535359")),
		verbatimTextOutput("tableTimeperiod"), br(),
		
    strong(div("Overview", style="color:#535359")),
		tableOutput("tableOverview"), 
		
    strong(div("Details", style="color:#535359")),
		tableOutput("tableDetail"), br(),
    
	strong(div("Plot", style="color:#535359")),
		plotOutput("plotProjByMonth", height="300px", width="1000px")
	)

