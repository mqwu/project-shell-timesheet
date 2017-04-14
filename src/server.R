
shinyServer(function(input, output, session) {

  dat <- reactive({
	  inFile <- input$timesheet_dat
	  if (is.null(inFile))
	  return(NULL)

	  file.rename(inFile$datapath,
                  paste(inFile$datapath, ".xlsx", sep=""))

	  wbs <- read_excel(paste(inFile$datapath, ".xlsx", sep=""), sheet=2, col_names=TRUE, na="")
	  
	  timesheet <- read_excel(paste(inFile$datapath, ".xlsx", sep=""), sheet=1, col_names=TRUE, na="")
	  timesheet <- as.data.frame(timesheet)
	  
	  timesheet$Date2 <- as.Date(timesheet$Date, format="%m/%d/%Y")
	  timesheet.period <- filter(timesheet, Date2>= input$start, Date2 <= input$end, WeekDay!="Sat", WeekDay!="Sun", Project!="") 
	  timesheet.period$Mon <- format(timesheet.period$Date2, "%m")
	  
	  timesheet.show <- select(timesheet.period, Date, WeekDay, Project, Hours)
	  
	  proj.h <- timesheet.period %>% filter(grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Project.Hours=sum(Hours))
	  ovhd.h <- timesheet.period %>% filter(!grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Overhead.Hours=sum(Hours))
	  tot.h  <- timesheet.period %>% filter(Hours!='NA') %>% summarise(Total.Hours=sum(Hours))
	  
          overview <- cbind(proj.h, ovhd.h, tot.h)
	  overview <- mutate(overview, Chargebility=Project.Hours/Total.Hours)
    
	  # project hour summarized by month (for bar plot)
	  proj.by.mon <- timesheet.period %>%
	                  group_by(Mon, Project) %>%
	                  summarise(ProjHour=sum(Hours)) %>%
	                  filter(ProjHour!='NA')
	  proj.by.mon <- as.data.frame(proj.by.mon)
	  
	  details <- timesheet.period %>%
					filter(Hours!='NA') %>%
					group_by(Project) %>%
					summarise(Hours=sum(Hours))
	  details <- left_join(details, wbs, by="Project")
			 
	  # project hour summarized by weekday (for timesheet)
	  proj.by.week <- timesheet.period %>%
                        group_by(WeekDay, Project) %>%
                        summarise(ProjHour=sum(Hours)) 
						
	  proj.by.week$Project <- as.character(proj.by.week$Project)
      proj.by.week <- proj.by.week %>% 
						spread(WeekDay, ProjHour, drop=FALSE) %>% 
						select(Project, Mon, Tue, Wed, Thu, Fri)
	  proj.by.week <- as.data.frame(proj.by.week)

	return(list(timesheet.show, overview, details, proj.by.mon, proj.by.week))
  })

  # Tab1
  output$tableData <- renderDataTable({ dat()[[1]] }, options=list(orderClasses=TRUE))

  # Tab2
  output$tableTimeperiod <- renderPrint({ 
    cat(paste0(input$start," to ",input$end))
  })
  output$tableOverview <- renderTable({ dat()[[2]] }, digits=2)
  output$tableSumByProj <- renderTable({ dat()[[3]] }, digits=0)
  
  output$plotProjByMonth <- renderPlot({
    ggplot(data=dat()[[4]], aes(x=Mon, y=ProjHour, fill=Project)) +
      geom_bar(stat="identity", position=position_dodge()) + scale_fill_brewer(palette = "Set1") +
      xlab("Month") + ylab("Hours")
  })
  
  # Tab3
  output$tableTimesheet <- renderTable({ dat()[[5]] }, digits=0)

  # Quit
  session$onSessionEnded(function(){ q() })
   
})



