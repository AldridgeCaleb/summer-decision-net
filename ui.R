shinyUI(fluidPage(tags$head(includeScript("google-analytics.js")),
  titlePanel("Decision Analysis for the Summer Meals Program"),
      navbarPage("",
#BACKGROUND PANEL#####
      
      
#MODELING PANEL####                
        tabPanel("The Model", 
                 h3("Step 1: Are you urban or rural?"),"This will adjust the environmental features to suit the demographics of your area.",
                 selectInput("urban",label="What area do you live in?",choices=c("Urban","Rural")),
#       h3("Step 1: Choose a utility measure"),
#       p("Utility features are the measure you would like to use to gauge program performance. 
#                                        Total ADP represents the demand for meals in a neighborhood.
#                                        Total Meals represents the supply of meals in a neighborhood. "),
#         strong("Disclaimer: Total Meals is the only one working at the moment...."),
#               
#       selectInput("utility_node", label="Choose a utility node",choices=c("Total.Meals","Total.ADP")),
      h3("Step 2: Select possible changes"),             
       h4("Possible Changes to Sponsor Operations"),("Sponsors have the authority to make these changes."),
                    tags$ul(
                      tags$li(strong("Admin.Costs"),("Check this box below if you can change your budget for administrative costs. These costs include: administrative personnel, benefits, office expense, facility and utility, transportation, audit and legal fees.
                        ")),
                     
                      tags$li(strong("Operational.Costs"),("Check this box below if you can change your budget for operational costs. These costs include: operational personnel, fringe benefits, facility and utility, equipment rental, and transportation.
                        ")),
                      
                      tags$li(strong("Food.Costs"),("Check this box below if you can change your budget for food costs.")),
                      tags$li(strong("Sponsor.Availability"),("Check this box below if you have the potential to organize an effort to bring more sponsors to the area."))#,
                #      tags$li(strong("Findings"),("Check this box below if you want to estimate the effect of prioritizing minimizing findings. "))
 
),

                 h4("Possible Changes to Site Operations"),("Sponsors have the authority to make these changes."),
tags$ul(tags$li(strong("Meals Served"),
      ("Check this box below if you are interested in changing the number of meals served. That is, either adding or removing breakfast, lunch, supper, morning, or afternoon snack. 
")),
      tags$li(strong("Activity"),("Check this box below if you want to explore the possibility of offering or reducing activities at sites in your area. ")),
      tags$li(strong("Media"),  ("Check this box below if you want to explore the effect of coordinating media efforts. This could include radio announcements, distributing flyers, phoning parents to let them know about the program.")),
      tags$li(strong("Site.Density"), ("Check this box below if you wish to explore the effect of operating a site in a high or low density site area.")),
      tags$li(strong("Menu.Appeal"),("Check this box below if you are looking to make substantial changes to your menu. The definition of a high and low quality menu will vary around the state according to cultural expectations. ")),
      tags$li(strong("Family.Invested"), (" Check this box below if you have the capacity to focus on family involvement."))),
                 
                    h4("Food Environment Characteristics"),("These features provide information to the model, but cannot be selected as possible changes."),

      tags$ul(tags$li(strong("Poverty"),
      ("Check this box below if you want to understand how high or low poverty rates affect the operations of the summer meals program.")),
   #   tags$li(strong("Benefits"),
  #    ("Check this box below if you want to understand how high or low benefit participation rates affect the operations of the summer meals program.")),
      tags$li(strong("Grocery"),
      ("Check this box below if you want to understand how access to a grocery store in a zipcode affect the operations of the summer meals program.")),
      tags$li(strong("Convenience Store"),               
      ("Check this box below if you want to understand how high or low number of convenience stores in a nearby area affect the operations of the summer meals program.")),
      tags$li(strong("Public Transport"),
      ("Check this box below if you want to understand how the availability of public transportation affect the operations of the summer meals program."))),
                    helpText("
Decision features are the program operations you could possibly change. 
                                       Below, please select the features that you could change.
To begin with, please only select 2-3 features at a time, 
                             as selecting more than that will increase the computational time needed to estimate the results."),
                 checkboxGroupInput("decision_node",
                                    label="Choose a set of decision node",
                                    #choices=colnames(df.net5)[-c(17,18)]
                                    choices=c("Admin.Costs","Operational.Costs","Food.Costs","Sponsor.Availability","Meals.Served","Activity","Media","Site.Density","Menu.Quality","Family.Invested","Public.Transport")
                                    ),
      h3("Step 3: Plot how all the possible program operations and environmental features are connected."),
                 h4("Now we put all of that data into the network below, which tell us about how all of the features are related."),
                  grVizOutput("picture"), 
                 h3("Step 4: Investigate all the possible scenarios"),
                 p("This table below shows all of the possible interventions we have here. You'll notice that as you add features,
                   the model complexity increases. You're just adding more possible combinations of interventions. Keep calm and carry on.
                   If you see an error message below, please select features above."),
                 # tableOutput("policies"), 
                 h4("Which scenario is the best one?"), 
                tableOutput("Eutil"),
                h3("Step 5: Make an action plan!"),
                ("Your optimal scenario shows different levels for each of the features. Below, we revisit each of the possible
                  changes in order to interpret the results."),
      
        h4("Suggested Changes to Sponsors Operations"),
tags$ul(tags$li(strong("Admin.Costs"),
      ("To alter your administrative costs, consider existing software packages that offer ways to check temperatures and collect paperwork in a more efficient manner. Consider incorporating the use of volunteers. Contact the THI research team for further consulting on what software is right for your organization. ")),
      tags$li(strong("Operational Costs"),
      ("To alter operational costs, examine possible software options, consider the use of volunteers, look for alternative sites, consider the return on investment of each of your sites counting up the transportation cost using the SOS summer calculator. ")),
      tags$li(strong("Food.Costs"),
      ("If low food costs is optimal, consider joining or starting a co-op, seek competitive vendor bids, or work with a menu planner to arrange compliant, but cheaper meals. 
If high food costs are optimal, consider conducting interviews among sites to see what areas of the menu are most in need of higher quality items. 
        ")),
      tags$li(strong("Sponsor.Availability"),
      ("Meet with THI’s Sponsor Councils to coordinate sponsor availability in your area. THI staff can also connect you with potential sponsors. If you are in an area where sponsor competition is high, please be alert that sponsor agreements are non-binding. 
"))#,
#       tags$li(strong("Findings"),
#       ("Maximizing compliance is of the utmost importance for all sponsors. To increase your awareness of program requirements, consider attending the Summer conference hosted by TDA in February. If you have questions about documentation or forms, please contact your local ESC representative. 
# "))
      ),
      h4("Suggested Changes to Site Operations"),

      tags$ul(tags$li(strong("Meals.Served"),
      ("Consider the reimbursement rates of each meal  as well as given sponsor constraints and add a meal.")),
      tags$li(strong("Activity"),
      (" Activity guides are available through our partners. Please contact your local THI representative to coordinate activities in your area. 
")),
      tags$li(strong("Media"),
      ("If media score is high in the optimal scenario, coordinate efforts to distribute more media. If media score is low in the optimal scenario, consider reallocating media funds on other efforts.")),
      tags$li(strong("Site.Density"),
      ("High and low density areas are featured on the map on the following tab. Look for the model-recommended zipcodes to optimize site placement. 
")),
      tags$li(strong("Menu.Appeal"),
      ("Low quality food is never acceptable. An indicator of low here may mean that the menu needs no further investment. If a high quality menu is suggested, consider serving hot meals, or surveying site attendees to see what meals are requested. Contact your THI representative to connect with resources about crafting high quality meals at a reasonable cost. 
")),
      tags$li(strong("Family.Invested"),
      ("If Family investment is High in the optimal scenario, consider reallocating resources to ensure that families are aware of and welcome at the program. Be mindful of the fact that meals to parents are not eligible for reimbursement from the state. For models of how to engage parents, contact your local THI representative.
")),
      tags$li(strong("Public.Transport"),
              ("Consider partnering with your local transportation agency to supply transportation to summer meal sites in the area. 
               "))
              )#,

      
         

                     
                 ),
tabPanel("FAQ", h2("Welcome!"), 
         #h3("We're so glad you're interested in Summer Meals Operations. Our website is still under construction. 
         #                 In the meantime, ",
         #a(href="https://tinyletter.com/rachwhatsit","please sign up for updates here!")),
         h4("Looking for Assistance Planning for Summer Meals?"), p("Are you a summer meals sponsor? A group of citizens who would like 
                                                                    to understand the operations of the federal Summer Meals Programs in your area? 
                                                                    Would you like to know what changes to program operations are most likely to increase the total number of meals you have served? "),
         h4("What is decision analysis?"),
         p("Operating summer meals puts sponsors at risk for financial loss. A key part of this risk stems from
           uncertainty: not knowing how many children or parents will show up on a given day, food waste that varies based on participation, 
           unexpected findings, a sudden shift in the vendors available in your area. Decision analysis helps quantify that 
           uncertainty and make accurate decisions about risk by creating a network which displays how the different facets of
           program interact. Each oval in the network is backed up by data that quantifies each feature for zipcodes in Texas. 
           Proceed to the Model tab to explore decision analysis further."),
         h4("How do I use the model?"),p("Decision analysis gives you a good way to test possible things you could change 
                                         about program operations. You have the option to test a number of interventions
                                         in either urban or rural areas:
                                         what happens if you increase the number of service days, add a meal in addition to lunch, focus on 
                                         outreach to families, or offer more activities? With the model you can select all the features 
                                         that you could possibly change, and then the model will predicted 
                                         which change leads to the highest increase in terms of the nuumber of total meals served"),
         h4("Why didn't you consider how X affects summer meals?"), p("The features on the graph were selected from many conversations
                                                                      with experts in the summer meals program: sponsors, state administrators,
                                                                      parents, and children. You can read about some of our preliminary findings
                                                                      in the Summer Meals Sponsor Surveys, and in our papers online. Some related features
                                                                      were combined into one feature. That said, if you feel
                                                                      like a really important feature of the program isn't accounted for in this model, 
                                                                      please send feedback to rachel_wilkerson@baylor.edu"),
         h4("What data did you use?"),
         p("Data about the operations of and participation in the Summer Meals Program were gathered from Public 
           Information Requests provided by the Texas Department of Agriculture. Additional information about program 
           operations was gathered through a series of annual sponsor surveys. Demographic information was pulled from 
           the American Community Survey 5 year estimates. The data is aggregated at the zipcode level."),                 
         h4("Other questions?"),("For details about the data cleaning, modeling 
                                 methodology, technical errors, or results, please contact rachel_wilkerson@baylor.edu"),
         h4("Acknowledgements"),
         p("Many thanks to the Walmart Foundation for their continued support of Summer Meals Research. 
           The United States Department of Agriculture and the Texas Department of Agriculture works tirelessly to manage the Summer Meals Program across Texas, 
           and their support and feedback was invaluable for this project. This model would not have been possible
           without the dedicated sponsors around the state of Texas and the nation who completed our sponsor surveys. 
           Thanks to Share our Strength for sharing the data and a passion for ending hunger in America. Thanks
           to Richard Armory and the North Texas Food Bank for GIS guidance, the Food Insecurity Group at Warwick for inspiration and
           methodology assistance, and the R community for Shiny troubleshooting help."),
         h4("Documentation"),
         p("This site is hosted on shinyapps.io, built in  R version 3.2.3, and uses the packages shiny, HydeNet, DiagrammeR, choroplethrZip, and choroplethrMaps. Viva open source software.")
         )
#MAPS PANEL######
        # tabPanel("Maps", p("This panel pulls up key statistics for your county, aggregated by zipcode. 
        #                    These program features should be taken as guide towards the big picture of Summer Meals.
        #                    To print the maps out, 
        #                    consider using a screen shot."),
        #          strong("Please wait 5-10 seconds in order for the map to retrieve the data. "),br(),
        #           selectInput("county", 
        #                       label = "Choose a Texas County  to display",
        #                       choices=unique(sort(counties.cap$County)[-255]),
        #                       selected=unique(sort(counties.cap$County))[2]
        #                      # choices = unique(sort(zip.regions.tx$county.name)),
        #                       #selected = unique(sort(zip.regions.tx$county.name))[1]
        #                       ),
        #           selectInput("feature", 
        #                       label = "Choose a program trait to display",
        #                       choices = (net_choices),
        #                       selected=1),plotOutput("map")
        #      #     choices = setNames(1:48,colnames(master[6:53]))) 
        #         
        #          
        #          ),
        #tabPanel("Contact Information", "Please select your county on the previous tab", textOutput("contactinfo")
        #  
        #)
  )
))

