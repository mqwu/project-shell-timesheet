
tabPanel('Summary', 
		br(),
		strong(div("Time period", style="color:#535359")),
		verbatimTextOutput("time_period"), br(),
		strong(div("Overview", style="color:#535359")),
		tableOutput("overview"), 
		strong(div("Details", style="color:#535359")),
		tableOutput("detail")
	)

