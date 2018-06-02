library(tm)
library(plyr)
library(class)
libs=c("tm","plyr","class")
lapply(libs,require,character.only = T)
options(stringsAsFactors= F)
cat = c("Oneliner.csv","Sickness.csv","Complaint.csv","ATC.csv","Availabilty.csv","Oneliner.csv")
pathname = "C:/Users/s769346/Desktop/New folder"
