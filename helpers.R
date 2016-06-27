#HELPER CODE FOR DECISION_NET SHINY SITE.
#library(shiny)

#summer_nodes<-c("Activity","Admin.Costs","Convenience.Store","Family.Invested","Food.Costs","Grocery","Media","Menu.Appeal","Operational.Costs","Poverty","Public.Transport","SFSP.Kitchens","Site.Density")
summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                        + Family.Invested | Grocery*Convenience.Store*Year.Round*Poverty*Menu.Appeal
                        + Site.Density | Media*Activity*Sponsor.Availability*Meals.Served
                        + Sponsor.Availability | Findings*Operational.Costs*Admin.Costs*Food.Costs
                        + Menu.Appeal | Food.Costs
                        ,data=df.net2)
compute_util<-function(decision,utility){
  summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                          + Family.Invested | Grocery*Convenience.Store*Year.Round*Poverty*Menu.Appeal
                          + Site.Density | Media*Activity*Sponsor.Availability*Meals.Served
                          + Sponsor.Availability | Findings*Operational.Costs*Admin.Costs*Food.Costs
                          + Menu.Appeal | Food.Costs
                          ,data=df.net2)
  
  summer_net<-setUtilityNodes(summer_net,Total.Meals)
  summer_net<-setDecisionNodes(summer_net,Food.Costs, Family.Invested)
  #trackedVars <- input$decision_node
  trackedVars <- c(decision,utility)
  compiledNets <- compileDecisionModel(summer_net, policyMatrix = policyMatrix(summer_net))
  
  samples <- lapply(compiledNets,
                    HydePosterior,
                    variable.names = trackedVars,
                    n.iter=10000)
  #lapply(samples, function(l) mean(as.numeric(l$Total.Meals)))
  the_winner<-which.min(unlist(lapply(samples, function(l) mean(as.numeric(l$Total.Meals)))))
  return(the_winner)
}
new_net<-function(decision=c("Food.Costs","Family.Invested"),utility="Total.Meals"){
  #set the utility and decision nodes
  summer_net<-HydeNetwork(~ Total.Meals | Site.Density*Family.Invested*Public.Transport
                          + Family.Invested | Menu.Appeal*Poverty*Media*Activity
                          + Food.Costs | Grocery*Operational.Costs*Admin.Costs
                          + SFSP.Kitchens | Operational.Costs*Admin.Costs*Food.Costs*Grocery
                          + Menu.Appeal | Grocery*Convenience.Store*SFSP.Kitchens
                          + Site.Density | SFSP.Kitchens*Public.Transport,data=df.net)
  if(input$decision_node==summer_net$nodes[2]){summer_net<-setDecisionNodes(summer_net, Site.Density)}
  if(input$decision_node==summer_net$nodes[3]){summer_net<-setDecisionNodes(summer_net, Family.Invested)}
  if(input$decision_node==summer_net$nodes[4]){summer_net<-setDecisionNodes(summer_net, Public.Transport)}
  if(input$decision_node==summer_net$nodes[5]){summer_net<-setDecisionNodes(summer_net, Menu.Appeal)}
  if(input$decision_node==summer_net$nodes[6]){summer_net<-setDecisionNodes(summer_net, Poverty)}
  if(input$decision_node==summer_net$nodes[7]){summer_net<-setDecisionNodes(summer_net, Media)}
  if(input$decision_node==summer_net$nodes[8]){summer_net<-setDecisionNodes(summer_net, Activity)}
  if(input$decision_node==summer_net$nodes[9]){summer_net<-setDecisionNodes(summer_net, Food.Costs)}
  if(input$decision_node==summer_net$nodes[10]){summer_net<-setDecisionNodes(summer_net, Grocery)}
  if(input$decision_node==summer_net$nodes[11]){summer_net<-setDecisionNodes(summer_net, Operational.Costs)}
  if(input$decision_node==summer_net$nodes[12]){summer_net<-setDecisionNodes(summer_net, Admin.Costs)}
  if(input$decision_node==summer_net$nodes[13]){summer_net<-setDecisionNodes(summer_net, SFSP.Kitchens)}
  if(input$decision_node==summer_net$nodes[14]){summer_net<-setDecisionNodes(summer_net, Convenience.Store)}
  plot(summer_net)
}

#from SMP_MAPS county_helpers
library(choroplethrZip);library(choroplethrMaps)#;library(ggplot2);library(reshape);library(RColorBrewer);library(ggmap)
data(zip.regions)
colnames(zip.regions)
zip.regions.tx<-subset(zip.regions,zip.regions$state.name=="texas")

 #lez_options=colnames(master)[6:53]
# df.w.names<-df.w.names[!duplicated(df.w.names$zcta),] 
# df.zips<-merge(df.w.names,zip.regions.tx, by.x="zcta",by.y="region",all.y=T)
# df.zips$County<-tolower(df.zips$County)

# color_ze_county_map <- function(county="dallas", feature="Site.Density") {
#    i=which(colnames(df.w.names)==feature)
#    df.feature<-subset(df.zips,df.zips$county.name==county)
#    
#    df_county<-df.feature[!duplicated(df.feature$zcta),c(1,4,i)] 
#    colnames(df_county)[3]="value"
#    colnames(df_county)[1]="region"
#    df_county$region=as.character(df_county$region)
#    levels(df_county$value)<-c(levels(df_county$value),"Not Eligible")
#    df_county$value[which(is.na(df_county$value)==T)]<-"Not Eligible"
#    find.fips=zip.regions.tx$county.fips.numeric[which(zip.regions.tx$county.name==county)[1]]
#    zip_choropleth(df_county,county_zoom = find.fips,title= paste(county, feature,sep=" "), legend = feature)
#  }

