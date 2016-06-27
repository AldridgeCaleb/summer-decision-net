library(shiny);library(HydeNet);library(DiagrammeR);library(choroplethrZip);library(choroplethrMaps)#
#load("summer_policy_hopefully_final.RData")#load all the data and models from the summerPolicy4.R
#load("summer_policy_stoch.RData")
#load("summer_data_really_final.RData")#a combo of the first two
#load("summer_data_finally_final.RData")#the most recent version 
load("final_slim_data.RData")
#summer_nodes=colnames(df.net5[-c(14,15)])
read.csv("counties.csv",strip.white = T,stringsAsFactors = F)->counties.cap
read.csv("contactinfo.csv",strip.white = T,stringsAsFactors = F)->contact
