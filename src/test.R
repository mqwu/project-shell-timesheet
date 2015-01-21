
library(dplyr)

setwd("C:/Apps/projects/TimeSheet/2015")

timesheet <- read.csv("charge15.csv", header=TRUE)
timesheet$Date2 <- as.Date(as.character(timesheet$Date), format="%m/%d/%Y")
timesheet.period <- filter(timesheet, WeekDay!="Sat", WeekDay!="Sun", ProjectID!='NA')

timesheet.show <- select(timesheet.period, Project, Hours)


proj.h <- timesheet.period %>% filter(ProjectID>0, Hours!='NA') %>% summarise(Project.Hours=sum(Hours))
ovhd.h <- timesheet.period %>% filter(ProjectID<0, Hours!='NA') %>% summarise(Overhead.Hours=sum(Hours))
tot.h  <- timesheet.period %>% filter(Hours!='NA') %>% summarise(Total.Hours=sum(Hours))
overview <- cbind(proj.h, ovhd.h, tot.h)
mutate(overview, chargebility=round(Project.Hours/Total.Hours,3))

details <- timesheet.period %>%
            filter(Hours!='NA') %>%
            group_by(Project) %>%
          summarise(Hours=sum(Hours))
  


