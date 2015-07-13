
shinyServer(function(input, output, session) {

  dat <- reactive({
	  inFile <- input$timesheet_dat
	  if (is.null(inFile))
	  return(NULL)

	  timesheet <- read.csv(inFile$datapath, header=TRUE)
	  timesheet$Date2 <- as.Date(as.character(timesheet$Date), format="%m/%d/%Y")
    
	  timesheet.period <- filter(timesheet, Date2>= input$start, Date2 <= input$end, WeekDay!="Sat", WeekDay!="Sun", Project!="")
	  timesheet.period$Mon <- format(timesheet.period$Date2, "%m")
	  timesheet.show <- select(timesheet.period, Date, WeekDay, Project, Hours)
	  
	  proj.h <- timesheet.period %>% filter(grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Project.Hours=sum(Hours))
	  ovhd.h <- timesheet.period %>% filter(!grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Overhead.Hours=sum(Hours))
	  tot.h  <- timesheet.period %>% filter(Hours!='NA') %>% summarise(Total.Hours=sum(Hours))
	  
      overview <- cbind(proj.h, ovhd.h, tot.h)
	  overview <- mutate(overview, Chargebility=Project.Hours/Total.Hours)
    
	  proj.by.mon <- timesheet.period %>%
	                  group_by(Mon, Project) %>%
	                  summarise(ProjHour=sum(Hours)) %>%
	                  filter(ProjHour!='NA')
	  proj.by.mon <- as.data.frame(proj.by.mon)
    
	  details <- timesheet.period %>%
	  		filter(Hours!='NA') %>%
	  		group_by(Project) %>%
	  	     summarise(Hours=sum(Hours))

	return(list(timesheet.show, overview, details, proj.by.mon))
  })

  #Tab1
  output$tableTimesheet <- renderDataTable({ dat()[[1]] }, options=list(orderClasses=TRUE))

  #Tab2
  output$tableTimeperiod <- renderPrint({ 
    cat(paste0(input$start," to ",input$end))
  })
  output$tableOverview <- renderTable({ dat()[[2]] })
  output$tableDetail <- renderTable({ dat()[[3]] })
  
  output$plotProjByMonth <- renderPlot({
    ggplot(data=dat()[[4]], aes(x=Mon, y=ProjHour, fill=Project)) +
      geom_bar(stat="identity", position=position_dodge()) + scale_fill_brewer(palette = "Set1") +
      xlab("Month") + ylab("Hours")
    
  })

  session$onSessionEnded(function(){ q() })
   
})



