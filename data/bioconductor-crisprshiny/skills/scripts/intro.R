# Code example from 'intro' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("crisprShiny", version="devel")

## -----------------------------------------------------------------------------
if (interactive()){
    library(crisprShiny)
    data("guideSetExample_basic", package="crisprShiny")
    app <- crisprShiny(guideSetExample_basic)
    shiny::runApp(app)
}

## -----------------------------------------------------------------------------
if (interactive()){
    gs <- guideSetExample_basic[1:50]
    
    ## add custom data columns
    library <- c("lib1", "lib2", "lib3", "lib4")
    set.seed(1000)
    values <- round(rnorm(length(gs)), 4)
    mcols(gs)[["values"]] <- values
    library <- sample(library, length(gs), replace=TRUE)
    mcols(gs)[["library"]] <- library
    
    ## create and run app
    app <- crisprShiny(gs, geneModel=txdb_kras)
    shiny::runApp(app)
}

## -----------------------------------------------------------------------------
if (interactive()){
    data("guideSetExample_kras", package="crisprShiny")
    app <- crisprShiny(guideSetExample_kras)
    shiny::runApp(app)
}

## -----------------------------------------------------------------------------
if (interactive()){
    library(shiny)
    
    ui <- function(id){
        fluidPage(
            sidebarLayout(
                sidebarPanel(
                    selectInput(
                        inputId="guideSet_select",
                        label="Select GuideSet",
                        choices=c("simple", "full")
                    )
                ),
                mainPanel(
                    crisprUI(id)
                )
            )
        )
    }
    
    server <- function(id){
        function(input, output, session){
            guideSet_list <- list("simple"=guideSetExample_basic,
                                  "full"=guideSetExample_kras[1:50])
            gs <- reactive({
                req(input$guideSet_select)
                guideSet_list[[input$guideSet_select]]
            })
            observeEvent(gs(), {
                crisprServer(
                    id,
                    guideSet=gs(),
                    geneModel=txdb_kras,
                    useFilterPresets=TRUE
                )
            })
        }
    }
    
    
    myApp <- function(){
        id <- "id"
        shinyApp(ui=ui(id), server=server(id))
    }
    
    myApp()
}

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

