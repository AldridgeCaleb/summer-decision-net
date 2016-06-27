#setwd("/Users/hoban/Box Sync/RLW THI Projects/DBN/decisionNet/")
library(HydeNet);library(DiagrammeR);library(choroplethrZip);library(choroplethrMaps)#
#load("summer_policy_hopefully_final.RData")#load all the data and models from the summerPolicy4.R

net_choices=c("Admin.Costs","Operational.Costs","Food.Costs","Sponsor.Availability","Meals.Served","Activity","Media","Site.Density","Menu.Quality","Family.Invested","Public.Transport")
shinyServer(
  function(input, output) {
     output$picture<-renderGrViz({
       if(input$urban=="Urban"){
         summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                                 + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
                                 + Site.Density | Media*Sponsor.Availability*Meals.Served
                                 + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
                                 + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
                                 ,data=df_urban)}
       else{
         summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                                 + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
                                 + Site.Density | Media*Sponsor.Availability*Meals.Served
                                 + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
                                 + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
                                 ,data=df_rural)
       }
       if(net_choices[1] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Admin.Costs)}
       if(net_choices[2] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Operational.Costs)}
       if(net_choices[3] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Food.Costs)}
       if(net_choices[4] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Sponsor.Availability)}
       if(net_choices[5] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Meals.Served)}
       if(net_choices[6] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Activity)}
       if(net_choices[7] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Media)}
       if(net_choices[8] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Site.Density)}
       if(net_choices[9] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Menu.Quality)}
       if(net_choices[10] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Family.Invested)}
       if(net_choices[11] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Public.Transport)}
       summer_net<-setUtilityNodes(summer_net,Total.Meals)
       plot(summer_net)
     })
     
#      output$policies<-renderTable({
#        if(input$urban=="Urban"){
#          summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
#                                  + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
#                                  + Site.Density | Media*Sponsor.Availability*Meals.Served
#                                  + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
#                                  + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
#                                  ,data=df_urban)}
#        else{
#          summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
#                                  + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
#                                  + Site.Density | Media*Sponsor.Availability*Meals.Served
#                                  + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
#                                  + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
#                                  ,data=df_rural)
#        }
#        if(net_choices[1] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Admin.Costs)}
#        if(net_choices[2] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Operational.Costs)}
#        if(net_choices[3] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Food.Costs)}
#        if(net_choices[4] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Sponsor.Availability)}
#        if(net_choices[5] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Meals.Served)}
#        if(net_choices[6] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Activity)}
#        if(net_choices[7] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Media)}
#        if(net_choices[8] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Site.Density)}
#        if(net_choices[9] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Menu.Quality)}
#        if(net_choices[10] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Family.Invested)}
#        if(net_choices[11] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Public.Transport)}
#        summer_net<-setUtilityNodes(summer_net,Total.Meals)
#        policies=policyMatrix(summer_net)
#        policies_n=policies
#        for(i in 1:dim(policies)[2]){policies_n[,i]<-levels(df_urban[[colnames(policies)[i]]])[policies[,i]]}
#        policies_n
#      })
  
     output$Eutil<-renderTable({
       if(input$urban=="Urban"){
         summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                                 + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
                                 + Site.Density | Media*Sponsor.Availability*Meals.Served
                                 + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
                                 + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
                                 ,data=df_urban)}
       else{
         summer_net<-HydeNetwork(~ Total.Meals | Family.Invested*Site.Density*Public.Transport#*Activity
                                 + Family.Invested | Convenience.Store*Poverty*Menu.Quality*Activity
                                 + Site.Density | Media*Sponsor.Availability*Meals.Served
                                 + Sponsor.Availability | Operational.Costs*Admin.Costs*Food.Costs#*Findings
                                 + Menu.Quality | Food.Costs*Grocery*Sponsor.Availability
                                 ,data=df_rural)
       }
        #summer_net<-setUtilityNodes(summer_net,Total.Meals)
        #summer_net<-setDecisionNodes(summer_net,Food.Costs, Family.Invested)
       if(net_choices[1] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Admin.Costs)}
       if(net_choices[2] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Operational.Costs)}
       if(net_choices[3] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Food.Costs)}
       if(net_choices[4] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Sponsor.Availability)}
       if(net_choices[5] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Meals.Served)}
       if(net_choices[6] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Activity)}
       if(net_choices[7] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Media)}
       if(net_choices[8] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Site.Density)}
       if(net_choices[9] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Menu.Quality)}
       if(net_choices[10] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Family.Invested)}
       if(net_choices[11] %in% input$decision_node){summer_net<-setDecisionNodes(summer_net, Public.Transport)}
       summer_net<-setUtilityNodes(summer_net,Total.Meals)
        #trackedVars <- input$decision_node
        #trackedVars <- c(input$decision_node,input$utility_node)
        trackedVars <- "Total.Meals"
        policies=policyMatrix(summer_net)
        invisible(compiledNets <- compileDecisionModel(summer_net, policyMatrix = policies))
       
        
               policies_n=policies
               for(i in 1:dim(policies)[2]){policies_n[,i]<-levels(df_urban[[colnames(policies)[i]]])[policies[,i]]}
            #   policies_n
        samples <- lapply(compiledNets,
                          HydePosterior,
                          variable.names = trackedVars,
                          n.iter=10000, trace=F)
        #lapply(samples, function(l) mean(as.numeric(l$Total.Meals)))
        the_winner<-which.min(unlist(lapply(samples, function(l) mean(as.numeric(l$Total.Meals)))))
        policies_n[as.numeric(the_winner),]
        #paste("The scenario with the maximum expected utility is scenario", the_winner)
     }) 
       output$map<-renderPlot({
        i=which(colnames(df.w.names)==input$feature)
        df.feature<-subset(df.zips,df.zips$county.name==tolower(input$county))
        
        df_county<-df.feature[!duplicated(df.feature$zcta),c(1,4,i)] 
        colnames(df_county)[3]="value"
        colnames(df_county)[1]="region"
        df_county$region=as.character(df_county$region)
        levels(df_county$value)<-c(levels(df_county$value),"Not Eligible")
        df_county$value[which(is.na(df_county$value)==T)]<-"Not Eligible"
        find.fips=zip.regions.tx$county.fips.numeric[which(zip.regions.tx$county.name==tolower(input$county))[1]]
        zip_choropleth(df_county,county_zoom = find.fips,title= paste(input$county, input$feature,sep=" "), legend = input$feature)
      })
       
      output$contactinfo<-renderText({
        j<-which(contact$County==input$county)
        paste("Please contact your THI Child Hunger Outreach Specialist,", contact$CHOS.Full.Name[j], ", at ",
              contact$CHOS.Email[j],". Your ESC representatives are ", contact$ESC.Full.Name[j], ". They can be reached at ",
              contact$ESC.Staff.Email[j])
      })
  }
)

