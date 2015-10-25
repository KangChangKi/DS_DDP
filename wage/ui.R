library(shiny)

shinyUI(navbarPage(
        "Wage Simulation",
        tabPanel("Introduction",
                 fluidRow(column(
                         12,
                         p(
                                 "It is a simulation of what variables influence to people's wages with Wage dataset in ISLR package."
                         ),
                         p(
                                 "The Wage dataset is about wage and other data for a group of 3000 workers in the Mid-Atlantic region."
                         ),
                         p("There are 12 variables on the dataset:"),
                         pre("
year
Year that wage information was recorded

age
Age of worker

sex
Gender

maritl
A factor with levels 1. Never Married 2. Married 3. Widowed 4. Divorced and 5. Separated indicating marital status

race
A factor with levels 1. White 2. Black 3. Asian and 4. Other indicating race

education
A factor with levels 1. < HS Grad 2. HS Grad 3. Some College 4. College Grad and 5. Advanced Degree indicating education level

region
Region of the country (mid-atlantic only)

jobclass
A factor with levels 1. Industrial and 2. Information indicating type of job

health
A factor with levels 1. <=Good and 2. >=Very Good indicating health level of worker

health_ins
A factor with levels 1. Yes and 2. No indicating whether worker has health insurance

logwage
Log of workers wage

wage
Workers raw wage
                                 "
                         ),
                         p(
                                 "However, I won't use 'sex', and 'region' variables, because there is only one value in the dataset. Also I will neglect 'logwage' variable."
                         ),
                         p("")
                         ))),
        tabPanel(
                "Simulation",
                fluidRow(column(
                        12,
                        p("You can adjust each variable's value and find out how variables influence the wage with the following steps:"),
                        p("1. Set all variable's values as you like."),
                        p("2. Check the 'Expected Wage' number."),
                        p("3. Adjust one or more variables and watch how the number changes."),
                        hr()
                )),
                fluidRow(
                        column(
                                4,
                                sliderInput(
                                        "year", label = h5("Year"),
                                        min = 2003, max = 2009, value = 2006
                                )
                        ),
                        column(4,
                               sliderInput(
                                       "age", label = h5("Age"),
                                       min = 18, max = 80, value = 40
                               )),
                        column(
                                4,
                                selectInput(
                                        "marriage", label = h5("Marriage"),
                                        choices = list(
                                                "1. Never Married", "2. Married", "3. Widowed", "4. Divorced", "5. Separated"
                                        ),
                                        selected = "1. Never Married"
                                )
                        )
                ),
                fluidRow(
                        column(
                                4,
                                selectInput(
                                        "race", label = h5("Race"),
                                        choices = list("1. White", "2. Black", "3. Asian", "4. Other"),
                                        selected = "1. White"
                                )
                        ),
                        column(
                                4,
                                selectInput(
                                        "education", label = h5("Education"),
                                        choices = list(
                                                "1. < HS Grad", "2. HS Grad", "3. Some College", "4. College Grad", "5. Advanced Degree"
                                        ),
                                        selected = "1. < HS Grad"
                                )
                        ),
                        column(
                                4,
                                selectInput(
                                        "jobclass", label = h5("Job Class"),
                                        choices = list("1. Industrial", "2. Information"),
                                        selected = "1. Industrial"
                                )
                        )
                ),
                fluidRow(column(
                        4,
                        selectInput(
                                "health", label = h5("Health"),
                                choices = list("1. <=Good", "2. >=Very Good"),
                                selected = "1. <=Good"
                        )
                ),
                column(
                        8,
                        selectInput(
                                "health_ins", label = h5("Health Insurance"),
                                choices = list("1. Yes", "2. No"),
                                selected = "1. Yes"
                        )
                )),
                hr(),
                fluidRow(column(
                        12,
                        h5("Expected Wage"),
                        verbatimTextOutput("expectedWage")
                ))
        ),
        tabPanel(
                "Distributions",
                fluidRow(column(
                        12,
                        p("Sometimes seeing distributions of data can help people to get true insights."),
                        p("You can divide the whole data into many data by particular variable's values with the following steps:"),
                        p("1. Select a varaible to divide the whole data by."),
                        p("2. Watch each distribution of divided data."),
                        hr()
                )),
                selectInput(
                        "densityKind", label = h5("Variable"),
                        choices = list(
                                "4. Marriage" = "marriage", "5. Race" = "race", "6. Education" = "education",
                                "8. Job Class" = "jobclass", "9. Health" = "health", "10. Health Insurance" = "health_ins"
                        ),
                        selected = "marriage"
                ),
                hr(),
                h5("Density Plot"),
                plotOutput("plotDensity")
        ),
        tabPanel(
                "Summary",
                fluidRow(column(
                        12,
                        p("The list of most influential variables on wage is like these:"),
                        plotOutput("varImp"),
                        verbatimTextOutput("varImp2"),
                        hr(),
                        p("Also notice that predicted results (x-axis) and actual wage numbers (y-axis) are quite well matched on the model."),
                        plotOutput("plotWage"),
                        p("")
                ))
        )
))
