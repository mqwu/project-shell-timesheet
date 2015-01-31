
shinyServer(function(input, output, session) {

  dat <- reactive({
	  inFile <- input$timesheet_dat
	  if (is.null(inFile))
	  return(NULL)

	  timesheet <- read.csv(inFile$datapath, header=TRUE)
	  timesheet$Date2 <- as.Date(as.character(timesheet$Date), format="%m/%d/%Y")
    
	  timesheet.period <- filter(timesheet, Date2>= input$start, Date2 <= input$end, WeekDay!="Sat", WeekDay!="Sun", Project!="")
	  timesheet.show <- select(timesheet.period, Date, WeekDay, Project, Hours)
	  proj.h <- timesheet.period %>% filter(grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Project.Hours=sum(Hours))
	  ovhd.h <- timesheet.period %>% filter(!grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Overhead.Hours=sum(Hours))
	  tot.h  <- timesheet.period %>% filter(Hours!='NA') %>% summarise(Total.Hours=sum(Hours))
	  overview <- cbind(proj.h, ovhd.h, tot.h)
	  overview <- mutate(overview, Chargebility=Project.Hours/Total.Hours)

	  details <- timesheet.period %>%
	  		filter(Hours!='NA') %>%
	  		group_by(Project) %>%
	  	     summarise(Hours=sum(Hours))

	return(list(timesheet.show, overview, details))
  })

  output$mytable1 <- renderDataTable({ dat()[[1]] }, options=list(orderClasses=TRUE))
  output$overview <- renderTable({ dat()[[2]] })
  output$detail <- renderTable({ dat()[[3]] })
  output$time_period <- renderPrint({ 
	cat(paste0(input$start," to ",input$end))
  })

  session$onSessionEnded(function(){ q() })
   
})



