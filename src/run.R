.libPaths(unique(c("../lib",.libPaths())))
 
packages <- c("shiny", "dplyr", "tidyr", "ggplot2", "readxl")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
 
library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readxl)

if (file.exists ("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")) {
	options(browser = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
} else {
	options(browser = "C:/Program Files/Google/Chrome/Application/chrome.exe")
}

runApp('C:/Apps/projects/TimeSheet/2015/src', launch.browser=TRUE)
 
