#.libPaths(unique(c("../lib",.libPaths())))
 
library(shiny)
library(dplyr)

if (file.exists ("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")) {
	options(browser = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
} else {
	options(browser = "C:/Program Files/Google/Chrome/Application/chrome.exe")
}

runApp('C:/Apps/projects/TimeSheet/2015/src', launch.browser=TRUE)
 
