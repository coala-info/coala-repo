# Code example from 'shiny' vignette. See references/ for full tutorial.

### R code from vignette source 'shiny.Rnw'

###################################################
### code chunk number 1: run_edgeR (eval = FALSE)
###################################################
## library(shiny)
## myRunApp()


###################################################
### code chunk number 2: shiny.Rnw:59-65 (eval = FALSE)
###################################################
##     custHeaderPanel("ReportingTools", 
##                   js = list.files(system.file("extdata/jslib", package="ReportingTools"),
##                                   full.names=TRUE),
##                   css = list.files(system.file("extdata/csslib", package="ReportingTools"),
##                     pattern="bootstrap", full.names=TRUE),
##                   )


###################################################
### code chunk number 3: shiny.Rnw:74-78 (eval = FALSE)
###################################################
##    mainPanel(
##                verbatimTextOutput("summary"), 
##                htmlOutput("view2")
##                )


###################################################
### code chunk number 4: shiny.Rnw:87-89 (eval = FALSE)
###################################################
## myrep = HTMLReport(reportDirectory = "./",shortName="bigtest", 
##   handlers = shinyHandlers)


###################################################
### code chunk number 5: shiny.Rnw:99-103 (eval = FALSE)
###################################################
## ###use RT to display output
##   output$view2 <- renderRepTools({
##     publish(datasetInput(), htmlrep, .modifyDF = modifyInput())
##   })


