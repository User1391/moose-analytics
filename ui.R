library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(scales)
library(tibble)
#library(plotly)


ui <- fluidPage(
  tags$link(rel = "stylesheet", type = "text/css", href = "www/main.css"),
  tags$h1("moose analytics"),

  textInput(
    inputId ="robot_numSearch", label = "Choose a team"),
  tabsetPanel(
    
    tabPanel("Team Summary",
      fluidRow(
        column(3,
          tags$h1(textOutput("robot_num"))
        )
      )
    ),
  ###################
## RAW NUM DATA TAB ##
 ###################
    
    tabPanel("Robot Raw Numerical Data",
      fluidRow(
        tags$h1("Misc."),
        column(4,
          tags$h2("ScoutName"),
          verbatimTextOutput("scoutName")

        ),
        column(4,
          tags$h2("Match Number Played:"),
          verbatimTextOutput("teamMatches")
        ),
        column(4,
          tags$h2("Starting Items:"),
          verbatimTextOutput("startingitem_Text")
        ),
        column(4,
          tags$h2("Defence Per 10 sec"),
          verbatimTextOutput("defence_Text")
        ),
        column(4,
          tags$h2("Ending Points:"),
          verbatimTextOutput("endpoint_Text")
        )
      ),

      fluidRow(
        tags$h1("Sandstorm:"),

        column(4,
          tags$h2("Cargo on CargoShip"),
          verbatimTextOutput("A_cargoShip_Cargo_Text")
        ),
        column(4,
          tags$h2("Hatches on CargoShip"),
          verbatimTextOutput("A_cargoShip_Hatch_Text")
        )
      ),

      fluidRow(
        tags$h1("Tele-op:"),

        column(5,
          tags$h2("Total Cargo in Rocket:"),
          verbatimTextOutput("rocket_Cargo_Text_total")
        ),

        column(5,
          tags$h2("Total Hatch in Rocket:"),
          verbatimTextOutput("rocket_Hatch_Text_total")
        ),
        column(5,
          tags$h2("Total Cargo in Cargoship:"),
          verbatimTextOutput("cargoship_Cargo_Text_total")
        ),
        column(5,
          tags$h2("Total Hatch in Cargoship:"),
          verbatimTextOutput("cargoship_Hatch_Text_total")
        )
      ),

      fluidRow(
        tags$h1("Cargo Pickup"),

        column(3,
          tags$h3("Depot"),
          verbatimTextOutput("depot_Cargo_Text")
        ),
        column(3,
          tags$h3("Ground"),
          verbatimTextOutput("ground_Cargo_Text")
        ),
        column(3,
          tags$h3("Loading Station"),
          verbatimTextOutput("LS_Cargo_Text")
        )
       ),
      fluidRow(
        tags$h1("Hatch Pickup"),

        column(3,
          tags$h3("Ground"),
          verbatimTextOutput("ground_Hatch_Text")
        ),

        column(3,
          tags$h3("Loading Station"),
          verbatimTextOutput("LS_Hatch_Text")
        )
      )


    ),

  ########################
## CHARTS AND GRAPHS TAB ##
  #######################

    tabPanel("Charts and Graphs",
      # GRAPHS FOR AUTONOMOUS ALL Are 3/12 columns wide and are 400x400px
        tags$h1("Sandstorm:"),
        fluidRow(
          column(4,
            tags$h3("CargoShip Hatch"),
            plotOutput("A_cargoShip_Hatch_Line", width = "400px", height = "400px")
          ),
          column(4,
            tags$h3("CargoShip Cargo"),
            plotOutput("A_cargoShip_Cargo_Line", width = "400px", height = "400px")
          )

        ),
        tags$h1("Tele-Op:"),
        fluidRow(
          column(6,
            tags$h3("Rocket Total Hatch"),
            plotOutput("rocket_Hatch_Plot_total", width = "400px", height = "400px")
          ),
          column(6,
            tags$h3("Rocket Total Cargo"),
            plotOutput("rocket_Cargo_Plot_total", width = "400px", height = "400px")
          ),
          column(6,
            tags$h3("CargoShip Total Hatch"),
            plotOutput("cargoship_Hatch_Plot_total", width = "400px", height = "400px")
          ),
          column(6,
            tags$h3("CargoShip Total Cargo"),
            plotOutput("cargoship_Cargo_Plot_total", width = "400px", height = "400px")
          )
        )

      ),
  ###################
##  FREQUENCIES TAB   ##
  ###################

      tabPanel("Frequencies",
        #Displaying frequencies for Hatch Panels vs

        fluidRow(
          column(4,
            tags$h1("Hatch Panels vs Total Times"),
            verbatimTextOutput("Hatch_over_total_freq")
          ),
          column(4,
            tags$h1("Cargo Ball vs Total Times"),
            verbatimTextOutput("Cargo_over_total_freq")
          )

        ),
        fluidRow(
          column(4,
            tags$h1("Starting Location"),
            textOutput("Start_Location")
          )
        )
      ),
      tabPanel("Event Summary",
        fluidRow(
          column(4,
            verbatimTextOutput("event_skill_summary")
          ),
          column(4,
            plotOutput("event_skill_summary_plot")
          )
        )
      ),
        tabPanel("Regression",
         fluidRow(
           splitLayout(
                  textInput(
                    inputId ="ahatch_1lvl_in", label = "Amount of Autonomous Rocket Level 1 Cargo", value = 0),
                  textInput(
                    inputId ="acargo_cs_in", label = "Amount of Autonomous Cargo Ship Cargo", value = 0),
                  textInput(
                    inputId ="ahatch_cs_in", label = "Amount of Autonomous Cargo Ship Hatch", value = 0),
                  textInput(
                    inputId ="cargo_1lvl_in", label = "Amount of Rocket Level 1 Cargo", value = 0),  
                  textInput(
                      inputId ="cargo_2lvl_in", label = "Amount of Rocket Level 2 Cargo", value = 0)
                  
                  
           ), 
           splitLayout(
                  textInput(
                    inputId ="cargo_3lvl_in", label = "Amount of Rocket Level 3 Cargo", value = 0),
                  textInput(
                    inputId ="hatch_1lvl_in", label = "Amount of Rocket Level 1 Hatch", value = 0),
                  textInput(
                    inputId ="hatch_2lvl_in", label = "Amount of Rocket Level 2 Hatch", value = 0),
                  textInput(
                    inputId ="hatch_3lvl_in", label = "Amount of Rocket Level 3 Hatch", value = 0),
                  textInput(
                    inputId ="cargo_cs_in", label = "Amount of Cargo Ship Cargo", value = 0),
                  textInput(
                    inputId ="hatch_cs_in", label = "Amount of Cargo Ship Hatch", value = 0),
                  textInput(
                    inputId ="defense_", label = "Defense", value = 0)
           )
                  
         ),
         fluidRow(
           column(12,
                  tags$h1("Linear Regression for Match Success"),
                  verbatimTextOutput("total_w_l_corr")
           )
           
           
           
           
         )
)
      
    )
  )

