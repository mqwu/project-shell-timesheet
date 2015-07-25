
mainPanel(
	tabsetPanel(
		source("external/tab1.R",local=T)$value,
		source("external/tab2.R",local=T)$value,
		source("external/tab3.R",local=T)$value,
		source("external/tabAbout.R",local=T)$value
	)  
)  

