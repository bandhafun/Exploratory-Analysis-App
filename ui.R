# This shiny web application is for probing chickWeight table in R 

library(shiny)

shinyUI(navbarPage("Exploratory Analysis",
                   tabPanel("Know your Data by plots",
                            fluidRow(
                              column(4),             
                              column(4,
                                     h3("Select Panels"),
                                     selectInput("pnl"," ",
                                                 c("Weight" = "weight",
                                                   "Chick" = "Chick",
                                                   "Time in days"="Time",
                                                   "Diet"="Diet",
                                                   "None"="NONE"
                                                 ),
                                                 selected = "Diet"
                                                 
                                     )
                                     
                              ),
                              
                              column(4,
                                     h3("Select Color"),
                                     selectInput("cl"," ",
                                                 c("Weight" = "weight",
                                                   "Chick" = "Chick",
                                                   "Time in days"="Time",
                                                   "Diet"="Diet",
                                                   "NONE" = "NONE"
                                                 ),
                                                 selected = "Chick"
                                                 
                                     )
                                     
                              ),
                              br()
                            ),
                            fluidRow(
                              column(2,
                                     selectInput("yaxis"," Y-Axis",
                                                 c("Weight" = "weight",
                                                   "Chick" = "Chick",
                                                   "Time in days"="Time",
                                                   "Diet"="Diet"
                                                 ),
                                                 selected = "weight"
                                                 
                                     ),
                                     checkboxGroupInput("id","Select Graph Types",
                                                        c("Point" = "p",
                                                          "Line" = "l",
                                                          "Regression"="r",
                                                          "Step"="s"
                                                          
                                                        ),
                                                        inline = FALSE , 
                                                        selected = "p"
                                     )
                              ),
                              column(10,plotOutput("plotit")),
                              br()
                            ),
                            fluidRow(
                              column(2),
                              column(4,
                                     sliderInput("d",
                                                 "Timeline in Days",
                                                 min = 0,
                                                 max = 21,
                                                 value = c(0,21))
                              ),
                              
                              column(6,
                                     selectInput("xaxis"," X-Axis",
                                                 c("Weight" = "weight",
                                                   "Chick" = "Chick",
                                                   "Time in days"="Time",
                                                   "Diet"="Diet"
                                                 ),
                                                 selected = "Time"
                                                 
                                     )
                                     
                                     
                              )
                              
                              
                            ),
                            
                            br(),
                            h4("* This app uses the ChickWeights data.It tracks the weight of 50 chicks on 4 different diets across their life span.")
                            
                            
                   ),
                   tabPanel("Know your Data by basic Tables",
                            fluidRow(
                              column(4,
                                     h3("Average Weight"),
                                     tableOutput("avgweight")
                                     
                              ),
                              column(4,
                                     h3("Head : Data"),
                                     tableOutput("ohead")       
                              ),
                              column(4,
                                     h3("Tail : Data"),
                                     tableOutput("otail")
                              )
                            ),
                            br(), 
                            fluidRow(
                              column(6,
                                h3("Data Structure "),
                                verbatimTextOutput("Str")   
                              ),
                              column(6,
                                     h3("Data Summary"),
                                     verbatimTextOutput("Summ")   
                              )
                              ),
                            
                            br(),
                            h4("* This app uses the ChickWeights data.It tracks the weight of 50 chicks on 4 different diets across their life span.")
                   ),
                   tabPanel("Know Your Data (more)",
                            sidebarLayout(
                              sidebarPanel(
                                h2( "Enter Command"),
                                textInput("cmd","",value = "head(ChickWeight)")
                              ),
                              mainPanel(
                                h2( "Output"),
                                verbatimTextOutput("result")
                                
                              )
                            
                            )
                     
                   )
                   
                   
))
