# Load necessary libraries
library(shiny)
library(ggplot2)
source("adultData.R") # this file contains data loading logic

# Define server
shinyServer(function(input, output){
  # Reactive expression for filtered data based on selected country
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  
  # Render histogram plot or boxplot based on "graph_type"
    output$p1<- renderPlot({
      if(input$graph_type == "histogram"){
        ggplot(data=df_country(),aes_string(x=input$countinuous_var)) +
         geom_histogram(binwidth=5,fill= "#9AC0CD",color=I("#EEE9E9")) +
         labs(title =str_c("Trend of ",input$countinuous_var),y="Number of People") +
         facet_wrap(~prediction)+
         theme(plot.background = element_rect(fill="#EEE9E9",color="#EEE9E9"))
        
      }else{
        ggplot(data=df_country(),aes_string(y=input$countinuous_var)) +
          geom_boxplot(fill="#8B8378") + 
          coord_flip() + 
          labs(title =str_c("Trend of ",input$countinuous_var),y="Number of People") +
          facet_wrap(~prediction)+
          theme(plot.background = element_rect(fill="#EEE9E9",color="#EEE9E9"))
          }})
    
  # Render faceted bar chart or stacked bar chart based on "isStacked"
    output$p2<- renderPlot({
      if(input$isStacked){
        ggplot(data=df_country(),aes_string(x=input$categorical_var,fill="prediction")) +
          geom_bar(position = "stack") +
          labs(title =str_c("Trend of ",input$categorical_var),y="Number of People") +
          theme(axis.text.x = element_text(angle = 45),
                legend.position="bottom",
                plot.background = element_rect(fill="#EEE9E9",color="#EEE9E9"))+
          scale_fill_manual(values = c("salmon3","#B4CDCD")) 
        
       }else{
        ggplot(data=df_country(),aes_string(x=input$categorical_var,fill=input$categorical_var)) +
          geom_bar() +
          labs(title =str_c("Trend of ",input$categorical_var),y="Number of People") +
          facet_wrap(~prediction) + 
          theme(axis.text.x = element_text(angle = 45),
                legend.position="bottom",
                plot.background = element_rect(fill="#EEE9E9",color="#EEE9E9"))+
          scale_fill_manual(values = c("#B4CDCD","#CDC5BF","#68838B","#FF7256","coral3","salmon1" ,"bisque","salmon"
                                        ,"salmon3","salmon4", "#9AC0CD","#8B8378","#CD4F39"
                                        ,"bisque2","bisque3", "coral")) 
    }
      })
  })
