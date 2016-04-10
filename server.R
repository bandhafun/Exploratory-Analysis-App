#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

require(ggplot2)
require(lattice)
require(reshape2)
require(Rmisc)
require(plyr)

data("ChickWeight")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Data information
  output$Summ <-  renderPrint(summary(ChickWeight))
  output$Str <- renderPrint(str(ChickWeight))
  output$ohead <- renderTable(head(ChickWeight,12))
  output$otail <- renderTable(tail(ChickWeight,12))  
  output$avgweight <- renderTable({
    x <- ddply(ChickWeight,.(Diet,Time),summarize,"Average Wight"=round(mean(weight),2))
    x$Diet <- paste("Diet",x$Diet)
    dcast(x,Time~Diet,mean)
    
  })
  
  output$result <- renderPrint(eval(parse(text = input$cmd)))
  
  output$plotit<- renderPlot({
    chk <- ChickWeight$Time<=input$d[2] & ChickWeight$Time>=input$d[1]
    dataPoul <- ChickWeight[chk,]
    
    if(input$cl == "NONE")
      p<- ggplot(data = dataPoul,aes_string(x=input$xaxis,y=input$yaxis))
    else
      p<- ggplot(data = dataPoul,aes_string(x=input$xaxis,y=input$yaxis,color = input$cl))
    
    if(input$pnl != "NONE") p <- p+ facet_wrap(input$pnl) 
    
    if("p" %in% input$id)
      p <- p + geom_point(size = 2)
    if("l" %in% input$id)
      p <- p +geom_line(size = 1)
    if("s" %in% input$id)
      p<- p+geom_step(size = 1)
    if("r" %in% input$id)
      p <- p+geom_smooth(method = "lm" , colour = "red" , size =2)
    p <- p+theme(text=element_text(size=20),legend.position = "bottom")+ guides(colour=FALSE, size = FALSE)
    return(p)
    
  })
  
})
