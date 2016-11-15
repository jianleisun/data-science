library(shiny)

shinyUI(
    navbarPage("A Shiny Application to Visualize dataset - 'mtcars'",
               tabPanel("Model Analysis",
                        fluidPage(
                            titlePanel("The relationship between variants and mpg"),
                            sidebarLayout(
                                sidebarPanel(
                                    selectInput("variable", "Select the variables:",
                                                c("num of cylinders" = "cyl",
                                                  "displacement (cu.in.)" = "disp",
                                                  "gross horsepower" = "hp",
                                                  "rear axle ratio" = "drat",
                                                  "weight (lb/1000)" = "wt",
                                                  "1/4 mile time" = "qsec",
                                                  "V/S" = "vs",
                                                  "transmission" = "am",
                                                  "num of forward gears" = "gear",
                                                  "num of carburetors" = "carb"
                                                )),
                                    
                                    checkboxInput("outliers", "Display BoxPlot's outliers", FALSE)
                                ),
                                
                                mainPanel(
                                    h3(textOutput("caption")),
                                    
                                    tabsetPanel(type = "tabs", 
                                                tabPanel("Data Exploratory - BoxPlot", plotOutput("mpgBoxPlot")),
                                                tabPanel("Regression Model", 
                                                         plotOutput("mpgPlot"),
                                                         verbatimTextOutput("fit")
                                                )
                                    )
                                )
                            )
                        )
               ),
               tabPanel("Source Code",
                        h2("Please find source code from the following website link:"),
                        hr(),
                        a("https://github.com/jianleisun/data-science")
               ),
               tabPanel("Data Information",
                        h2("Motor Trend Car Road Tests - 'mtcars'"),
                        hr(),
                        h3("Description"),
                        helpText("The data was extracted from the 1974 Motor Trend US magazine,",
                                 " and comprises fuel consumption and 10 aspects of automobile design and performance",
                                 " for 32 automobiles (1973–74 models)."),
                        h3("Nomenclature"),
                        p("This dataset consists of 11 variables and 32 observations."),
                        
                        p("  mpg -   Miles/(US) gallon"),
                        p("  cyl -	 Number of cylinders"),
                        p("  disp -	 Displacement (cu.in.)"),
                        p("  hp - Gross horsepower"),
                        p("  drat - Rear axle ratio"),
                        p("  wt - Weight (lb/1000)"),
                        p("  qsec - 1/4 mile time"),
                        p("  vs - V/S"),
                        p("  am - Transmission (0 = automatic, 1 = manual)"),
                        p("  gear - Number of forward gears"),
                        p("  carb - Number of carburetors"),
                        
                        h3("Reference"),
                        
                        p("Henderson and Velleman (1981), Building multiple regression models interactively. Biometrics, 37, 391–411.")
               )
    )
)