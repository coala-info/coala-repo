# Code example from 'VisualizeSumExp' vignette. See references/ for full tutorial.

## ----setup, eval=TRUE, include=FALSE------------------------------------------
library(epivizrChart)
library(shiny)
library(Homo.sapiens)

## -----------------------------------------------------------------------------
data(sumexp)

## -----------------------------------------------------------------------------
epivizEnv <- epivizEnv(interactive = TRUE)
scatterplot <- epivizEnv$plot(sumexp, datasource_name="sumExp", columns=c("cancer", "normal"))

## -----------------------------------------------------------------------------
epivizNav <- epivizNav(chr="chr11", start=118000000, end=121000000, parent=epivizEnv, interactive = TRUE)

genes_track <- epivizNav$add_genome(Homo.sapiens, datasource_name="genes")
# region_scatterplot <- epivizNav$plot(sumexp, datasource_name="sumExp", columns=c( "cancer", "normal"))
region_linetrack <- epivizNav$plot(sumexp, datasource_name="sumExp", columns=c( "cancer", "normal"), chart="LineTrack")

## ----eval=FALSE---------------------------------------------------------------
# 
# app <- shinyApp(
#   ui=fluidPage(
#     uiOutput("epivizChart")
#   ),
#   server=function(input, output, session) {
# 
#     output$epivizChart <- renderUI({
#       epivizEnv$render_component(shiny=TRUE)
#     })
# 
#     epivizEnv$register_shiny_handler(session)
#   }
# )
# 
# app
# 

