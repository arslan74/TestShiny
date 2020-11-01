#' vote information of parliament members
#' 
#' @name Shinypkg vote information
#' @description take the data from APILab and APIpkg and ploting vote frequency of the number of approve for each parties member.
#' @return ui. Sidebar with a slider input for approve votes
#' @usage shinyApp(ui = ui, server = server)
# @importFrom APIpkg
#' @export



library(shiny)
# library(devtools)
devtools::install_github("AqsaIftikhar25/APILab")
library(APIpkg)
#source("votesinfo.R")

dataContext <- vott() #calling API outside in order to download all required data

# Define UI for application that draws a histogram

ui <- fluidPage(
    
    # Application title
    titlePanel("Vote information based on Parties"),
    
    # Sidebar with a slider input for approve votes
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        label = "Choose frequency of approve votes",
                        min = 1,
                        max = 100,
                        value = 10)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("votout")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$votout <- renderPlot({
        # generate year based on input$year from ui.R
        #i <- 30
        #x    <- faithful[, 2] #seq(min(as.integer(dataContext[,1]), na.rm = TRUE), max(as.integer(dataContext[,1]), na.rm = TRUE),by = 10)
        x = as.numeric(as.character(dataContext[,2]))
        bins <- seq(min(as.numeric(as.character(dataContext[,2])), na.rm = TRUE), max(as.numeric(as.character(dataContext[,2])), na.rm = TRUE), length.out = input$bins+1)
        
        #x <- c(1:length(dataContext[,1]))
        # draw the histogram with the specified number of bins
        hist(x = x, breaks = bins ,type = "h", col = 'darkblue', border = 'white', main = paste("Histogram of votes"),xlab = "Votes approve", ylab = "Frequency of approve")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
