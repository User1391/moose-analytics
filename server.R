library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(scales)
library(tibble)


server <- function(input, output){
df <-read.csv(file = "2019_03_03_HatboroEvent.csv", header = TRUE)

##MAKING NEW COLUMNS IN THE DATAFRAME

  ##TOTAL HATCHES 32
  df$H_total <- df$H_on_3_Lev + df$H_on_2_Lev + df$H_on_1_Lev + df$CS_H
  #TOTAL CARGO 33
  df$C_total <- df$C_on_3_Lev + df$C_on_2_Lev + df$C_on_1_Lev + df$CS_C
  
  
  #Taking Means of Total Cargo
  summary_df <- aggregate(cbind(df$C_total, df$H_total,df$Defense), by=list(Category=df$Robot_Num), FUN=mean)
  names(summary_df) <- c("Team", "Cargo_Avg", "Hatch_Avg", "Defense_Avg")
 ################################
## MISC. INFORMATION ABOUT ROBOT ##
  ###############################

##Server-side for STARTING ITEM :: STARTING ITEM
  output$startingitem_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,31)]
  })

##Server-side for DEFENCE PER 10SEC
  output$defence_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,30)]
  })
##Server-side for ENDING POINT
  output$endpoint_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,29)]
  })



#Server-Side for Finding who scouted the robot and at what match number
  output$scoutName <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(1,3)]
  })
#Server-Side for Finding starting points and match number
  output$teamMatches <- renderPrint({
    row.names(df[grep(input$robot_numSearch, df$Robot_Num),c(3,5)]) <- NULL
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,5)]
  })


  ####################################
## SANDSTORM INFORMATION ABOUT ROBOT ##
 ####################################

#Server-Side for Sandstorm #Cargo# on CargoShip w/ match Number
  output$A_cargoShip_Cargo_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,13)]
  })
        #PLOT
        output$A_cargoShip_Cargo_Line <- renderPlot({
          A_cargoShip_Cargo_Line_data <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,13)]
          ggplot(data = A_cargoShip_Cargo_Line_data, aes(x=A_CS_C)) + geom_bar() + ylim(0,3)
        })
##Server-side for Sandstrom #Hatches# on CargoShip w/ match Number
  output$A_cargoShip_Hatch_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,14)]
  })
        #PLOT
        output$A_cargoShip_Hatch_Line <- renderPlot({
          plotdata <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,14)]
          ggplot(data = plotdata, aes(x=A_CS_H)) + geom_bar()  + ylim(0,3)
        })
  ##################################
## TELE-OP INFORMATION ABOUT ROBOT ##
  #################################

##Server-side for TOTAL ROCKET DATA w/ match Number
  #CARGO
  output$rocket_Cargo_Text_total <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,15,16,17,33)]
  })
        #PLOT
        output$rocket_Cargo_Plot_total <- renderPlot({
          plotdata <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,15,16,17,33)]
          ggplot(data = plotdata, aes(x=C_total)) + geom_bar() + ylim(0,6)
        })

  #HATCH
  output$rocket_Hatch_Text_total <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,18,19,20,32)]
  })
        #PLOT
        output$rocket_Hatch_Plot_total <- renderPlot({
          plotdata <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,18,19,20,32)]
          ggplot(data = plotdata, aes(x=H_total)) + geom_bar() + ylim(0,6)
        })

##Server-side for TOTAL CARGO SHIP DATA w/ match Number
  #HATCH 22
  output$cargoship_Hatch_Text_total <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,22)]
  })
      #PLOT
      output$cargoship_Hatch_Plot_total <- renderPlot({
        plotdata <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,22)]
        ggplot(data = plotdata, aes(x=CS_H)) + geom_bar() + ylim(0,6)
      })
  #CARGO 21
  output$cargoship_Cargo_Text_total <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,21)]
  })
      #PLOT
      output$cargoship_Cargo_Plot_total <- renderPlot({
        plotdata <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,21)]
        ggplot(data = plotdata, aes(x=CS_C)) + geom_bar() + ylim(0,6)
      })

##Server-side for PICKUPS AREAS
  ##CARGO FROM LOADING STATION
  output$LS_Cargo_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,23)]
  })
  ##CARGO FROM GROUND
  output$ground_Cargo_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,24)]
  })
  ##CARGP FROM DEPOT
  output$depot_Cargo_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,25)]
  })
  ##HATCH FROM LOADING STATION
  output$LS_Hatch_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,26)]
  })

  ##HATCH FROM GROUND
  output$ground_Hatch_Text <- renderPrint({
    df[grep(input$robot_numSearch, df$Robot_Num),c(3,27)]
  })

  #################
## Frequencies TAB ###
  #################

#Frequencies for pickup CARGO over Total
  output$Cargo_over_total_freq <- renderPrint({
    newdf <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,23,24,25,26,27)]
    newdf$total_All <- rowSums(newdf[,c(2,3,4,5,6)])
    newdf$total_Cargo <- rowSums(newdf[,c(2,3,4)])
    newdf$frequency <- newdf$total_Cargo / newdf$total_All
    newdf$percentage <- with(newdf, round(newdf$frequency * 100, digits = 2))
    finaldata <- select (newdf, -c(2,3,4,5,6,7,8,9))
    finaldata
  })

#Frequenvies for pick HATCH over Total
  output$Hatch_over_total_freq <- renderPrint({
    newdf <- df[grep(input$robot_numSearch, df$Robot_Num),c(3,23,24,25,26,27)]
    newdf$total_All <- rowSums(newdf[,c(2,3,4,5,6)])
    newdf$total_Hatches <- rowSums(newdf[,c(5,6)])
    newdf$frequency <- newdf$total_Hatches / newdf$total_All
    newdf$percentage <- with(newdf, round(newdf$frequency * 100, digits = 2))
    finaldata <- select(newdf, -c(2,3,4,5,6,7,8,9))
    finaldata
  })

  output$Start_Location <- renderPrint ({
    tblofstrt <- df[grep(input$robot_numSearch, df$Robot_Num), c(3,5)]
    r1 <- length(which(tblofstrt == "1R"))
    c1 <- length(which(tblofstrt == "1C"))
    l1 <- length(which(tblofstrt == "1L"))
    l2 <- length(which(tblofstrt == "2L"))
    r2 <- length(which(tblofstrt == "2R"))
    matchesLen <- r1 + c1 + l1 + l2 + r2
    paste(c("L1: "), c(round((l1/matchesLen)*100, digits = 2)) , c("% || C1: ") , c(round((c1/matchesLen)*100, digits = 2)) , c("% || R1: ") , c(round((r1/matchesLen)*100, digits = 2)), c("% || L2: ") , c(round((l2/matchesLen)*100, digits = 2)) , c("% || R2: "), c(round((r2/matchesLen)*100, digits = 2)), c("%."), sep = "")
  })

  ###################
## ROBOT SUMMARY TAB ##
  ###################

  output$robot_num <- renderText({
    paste("Team", input$robot_numSearch)
  })

  ####################
## EVENT SUMMARY TAB ##
  ###################
  output$event_skill_summary <- renderPrint({
    summary_df
  })
  
  output$event_skill_summary_plot <- renderPlot({
    ggplot(summary_df, aes(x=Cargo_Avg, y=Hatch_Avg, label=Team)) + geom_point() +geom_text(aes(label=Team),hjust=0, vjust=0)
    
  })
  output$total_w_l_corr <- renderPrint ({
    
    mylogit <- glm(W_L ~ C_on_3_Lev + C_on_2_Lev + C_on_1_Lev + CS_C + CS_H + A_H_on_1_Lev + A_CS_H + H_on_3_Lev + H_on_2_Lev + H_on_1_Lev + Defense, data = df, family = "binomial")
    c3 <- as.integer(input$cargo_3lvl_in)
    c2 <- as.integer(input$cargo_2lvl_in)
    c1 <- as.integer(input$cargo_1lvl_in)
    x <- data.frame(C_on_3_Lev = c3, C_on_2_Lev = c2, C_on_1_Lev = c1, CS_C = as.integer(input$cargo_cs_in), CS_H = as.integer(input$hatch_cs_in), A_H_on_1_Lev = as.integer(input$ahatch_1lvl_in), A_CS_H = as.integer(input$ahatch_cs_in), H_on_3_Lev = as.integer(input$hatch_3lvl_in), H_on_2_Lev = as.integer(input$hatch_2lvl_in), H_on_1_Lev = as.integer(input$hatch_1lvl_in), Defense = as.integer(input$defense_) )
    p<- predict(mylogit,x)
    p
   # c(input$cargo_3lvl_in, input$cargo_2lvl_in, input$cargo_1lvl_in, input$cargo_cs_in, input$hatch_cs_in, input$ahatch_1lvl_in, input$ahatch_cs_in, input$hatch_3lvl_in, input$hatch_2lvl_in, input$hatch_1lvl_in, input$defense_)
  })
  
}
