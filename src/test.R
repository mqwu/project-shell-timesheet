
library(dplyr)
library(ggplot2)
library(tidyr)

setwd("C:/Apps/projects/TimeSheet/2015")

timesheet <- read.csv("charge15.csv", header=TRUE)
timesheet$Date2 <- as.Date(as.character(timesheet$Date), format="%m/%d/%Y")
timesheet.period <- filter(timesheet, Date2>='2015-05-18'& Date2<='2015-05-22') %>% select(Date2,WeekDay, Project, Hours)

#timesheet.period$Mon <- format(timesheet.period$Date2, "%m")
timesheet.period <- filter(timesheet.period, WeekDay!="Sat", WeekDay!="Sun", Project!="")

#timesheet.period <- tbl_df(timesheet.period)
proj.by.week <- timesheet.period %>%
                        group_by(WeekDay, Project) %>%
                        summarise(ProjHour=sum(Hours)) %>%
                        filter(ProjHour!='NA')

timesheet3 <- proj.by.week %>% spread(WeekDay, ProjHour) %>% 
              select(Project, Mon, Tue, Wed, Thu, Fri)

  



proj.by.mon <- as.data.frame(proj.by.mon)
ggplot(data=proj.by.mon, aes(x=Mon, y=ProjHour, fill=Project)) +
  geom_bar(stat="identity", position=position_dodge()) + scale_fill_brewer(palette = "Set1") +
  xlab("Month") + ylab("Hours")

timesheet.show <- select(timesheet.period, Project, Hours)


proj.h <- timesheet.period %>% filter(grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Project.Hours=sum(Hours))
ovhd.h <- timesheet.period %>% filter(!grepl("^Proj|^proj", Project), Hours!='NA') %>% summarise(Overhead.Hours=sum(Hours))
tot.h  <- timesheet.period %>% filter(Hours!='NA') %>% summarise(Total.Hours=sum(Hours))
overview <- cbind(proj.h, ovhd.h, tot.h)
mutate(overview, chargebility=round(Project.Hours/Total.Hours,3))

details <- timesheet.period %>%
  filter(Hours!='NA') %>%
  group_by(Project) %>%
  summarise(Hours=sum(Hours))
