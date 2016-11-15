library(shiny)
library(datasets)

data <- mtcars
data$am <- factor(data$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {
    
    txt1 <- reactive({
        paste("mpg ~", "as.integer(", input$variable, ")")
    })
    
    fit <- reactive({
        lm(as.formula(txt1()), data=data)
    })
    
    txt <- reactive({
        paste("mpg ~", input$variable)
    })
    
    output$caption <- renderText({
        txt()
    })
    
    output$mpgBoxPlot <- renderPlot({
        boxplot(as.formula(txt()), 
                data = data,
                outline = input$outliers)
    })
    
    output$fit <- renderPrint({
        summary(fit())
    })
    
    output$mpgPlot <- renderPlot({
        with(data, {
            plot(as.formula(txt1()))
            abline(fit(), col=2)
        })
    })
    
})