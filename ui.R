# Load necessary libraries
library(shiny)
source("adultData.R") # this file contains data loading logic

# Define choices 
country_choi<-c(" United-States", " Canada", " Mexico", " Germany", " Philippines")
counti_var<-c("age","hours_per_week")
graph_choi<-c("histogram","boxplot")
categ_var<-c("education","workclass","sex")

# Define UI
shinyUI(fluidPage(style = "colorbackground-color: #EEE9E9;",
  titlePanel("Trends in Demographics and Income"),
  h5("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demogrphic information."),
  # first fluidRow: to select input for country
  fluidRow(
      column(width = 12,
       wellPanel(style = "background-color:#CD5B45;",
         selectInput("country","Country",choices = country_choi,selected ="United-States")))),
  
  # second fluidRow: to control how to plot the continuous variables
  fluidRow(
    column(width = 3,
           wellPanel(style = "background-color:#EEE9E9;",
                  p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
                  radioButtons("countinuous_var","countinuous",choices = counti_var),
                  radioButtons("graph_type","Graph",choices = graph_choi,selected = "histogram"))),
   column(width = 9,plotOutput("p1"))),
  
  # third fluidRow: to control how to plot the categorical variables
  fluidRow(
    column(width = 3,
           wellPanel(style = "background-color: #EEE9E9;",
             p("Select a categorical variable to view bar chart on the right.Use the check box to view a stacked bar chart to combine the income levels into one graph."),
                 radioButtons("categorical_var","categorical",choices = categ_var),
                 checkboxInput("isStacked","Stack bars",TRUE))),
    column(width = 9,plotOutput("p2")) )
))
