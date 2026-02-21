# Code example from 'addingThirdPartyPlots' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)

## ----env, message = FALSE, warning = FALSE, echo = FALSE----------------------
library("omXplore")

## ----eval=FALSE---------------------------------------------------------------
# myFirstPlot <- function(obj, i) {
#     ui <- myFirstPlot_ui(id)
#     server <- myFirstPlot_server(id, obj, i)
#     app <- shinyApp(ui = ui, server = server)
# }

## ----eval=FALSE---------------------------------------------------------------
# myFirstPlot <- function(obj, i) {
#     ui <- function(id) {
#         ...
#     }
#     server <- function(id, obj, i) {
#         moduleServer(
#             id,
#             function(input, output, session) {
#                 ...
#             }
#         )
#     }
# 
#     app <- shinyApp(ui = ui, server = server)
# }

## ----eval=FALSE---------------------------------------------------------------
# myFirstPlot_ui <- function(id) {
#     ...
# }
# 
# 
# myFirstPlot_server <- function(id, obj, i) {
#     moduleServer(
#         id,
#         function(input, output, session) {
#             ...
#         }
#     )
# }
# 
# myFirstPlot <- function(obj, i) {
#     ui <- myFirstPlot_ui(id)
#     server <- myFirstPlot_server(id, obj, i)
#     app <- shinyApp(ui = ui, server = server)
# }

## ----eval = FALSE-------------------------------------------------------------
# addons <- list(
#     myPkgA = c("extFoo1", "extFoo2"),
#     myPkgB = c("extFoo1")
# )
# view_dataset(myData, addons)

## ----eval=FALSE---------------------------------------------------------------
# omXplore_mySecondPlot <- function(obj, i) {
#     ui <- omXplore_mySecondPlot_ui(id)
#     server <- omXplore_mySecondPlot_server(id, obj, i)
#     app <- shinyApp(ui = ui, server = server)
# }

## -----------------------------------------------------------------------------
sessionInfo()

