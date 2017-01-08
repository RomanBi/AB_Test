library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
      
      # Application title
      titlePanel("A/B Test - Sample Size Estimator"),
      
      # Sidebar with slider inputs for test settings 
      sidebarLayout(
            sidebarPanel(
                  sliderInput("p1",
                              "Base Proportion:",
                              min = 0.01,
                              max = 1,
                              value = 0.1),
                  sliderInput("p2",
                              "Expected Proportion:",
                              min = 0.01,
                              max = 1,
                              value = 0.11),
                  sliderInput("power",
                              "Power:",
                              min = 0.1,
                              max = 1,
                              value = 0.8),
                  sliderInput("sig.level",
                              "Significance Level:",
                              min = 0.01,
                              max = 1,
                              value = 0.05)
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                  verbatimTextOutput("sample_size")
            )
      )
)

# Define server logic required to estimtate sample size
server <- function(input, output) {
      
      output$sample_size <- renderText({
            paste("A sample size of", 
                  round(power.prop.test(p1 = input$p1, 
                                        p2 = input$p2, 
                                        power = input$power, 
                                        alternative = 'two.sided', 
                                        sig.level = input$sig.level)$n, 0),
                  "is needed."
            )
      })
}

# Run the application 
shinyApp(ui = ui, server = server)
