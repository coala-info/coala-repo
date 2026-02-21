# Code example from 'clevRvis' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("clevRvis")

## ----loading------------------------------------------------------------------
library(clevRvis)

## ----inputs-------------------------------------------------------------------
##Example data
timepoints <- c(0,50,100)
parents <- c(0,1,1,3,0,5,6)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))
seaObject <- createSeaObject(fracTable, parents, timepoints,
                            timepointInterpolation = FALSE)

## ----seaObject----------------------------------------------------------------
##seaObject with enabled time point estimation
seaObject_tp <- createSeaObject(fracTable, parents, timepoints,
                                timepointInterpolation = TRUE)

## ----thpEff-------------------------------------------------------------------
##seaObject with enabled time point estimation and therapy effect 
##estimation between time point 50 and 100
seaObject_te <- createSeaObject(fracTable, parents, timepoints,
                            timepointInterpolation = TRUE,
                            therapyEffect = c(50,100))

## ----individualColors---------------------------------------------------------
##seaObject with manually defined colors
seaObject_col <- createSeaObject(fracTable, parents, timepoints,
                                timepointInterpolation = TRUE,
                                col = rainbow(7))

## ----shark--------------------------------------------------------------------
#Basic shark plot showing legend and title
sharkPlot(seaObject_tp, showLegend = TRUE, main = 'Example Shark plot')

## ----sharkIndivColors---------------------------------------------------------
#Basic shark plot showing legend and title with manually defined color coding
sharkPlot(seaObject_col, showLegend = TRUE, main = 'Example Shark plot')

## ----extShark-----------------------------------------------------------------
##extended shark plot, showing CCF as point size only for measured 
###time points, legend and title
extSharkPlot(seaObject_tp, timepoints = timepoints, showLegend = TRUE, 
            main = 'Example Extended Shark plot')

## ----splineDolph--------------------------------------------------------------
##Dolphin plot, with vertical lines showing all time points, custom y axis 
##label and triangles indicating the measured time points
dolphinPlot(seaObject_tp, showLegend = TRUE, 
            vlines = timepoints(seaObject), 
            vlab = timepoints(seaObject), vlabSize = 2, 
            ylab = 'Cancer cell fractions (CCFs)',
            markMeasuredTimepoints = timepoints)

## ----polyDolph----------------------------------------------------------------
##Dolphin plot polygon shape
dolphinPlot(seaObject_tp, showLegend = TRUE, vlines = timepoints,
            vlab = timepoints, vlabSize = 2, 
            ylab = 'Cancer cell fractions (CCFs)', shape = 'polygon')


## ----bottomDolph--------------------------------------------------------------
##Dolphin plot bottom layout and separated independent clones
dolphinPlot(seaObject_tp, showLegend = FALSE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 2, 
            ylab = 'Cancer cell fractions (CCFs)', 
            separateIndependentClones = TRUE, pos = 'bottom')

## ----annotsDolph--------------------------------------------------------------
##Dolphin plot with annotations
annotsTable <- data.frame(x = c(50,75), y = c(15,50), 
                            col = c('black', 'white'), 
                            lab = c('Annotation clone 5', 'Annotation clone 2'))
dolphinPlot(seaObject_tp, showLegend = TRUE, main = 'Example Dolphin Plot', 
            vlines = timepoints, vlab = timepoints, vlabSize = 2, 
            ylab = 'Cancer cell fraction', annotations = annotsTable, 
            pos = 'bottom', separateIndependentClones = TRUE)

## ----thpEffDolph--------------------------------------------------------------
##Dolphin plot with enabled therapy effect estimation
##vertical lines show all time points, customized y axis label,
##triangles indicate the measured time points
dolphinPlot(seaObject_te, showLegend = TRUE, 
            vlines = slot(seaObject,"timepoints"), 
            vlab = slot(seaObject,"timepoints"), vlabSize = 2, 
            ylab = 'Cancer cell fractions (CCFs)',
            markMeasuredTimepoints = timepoints)

## ----SharkDolph---------------------------------------------------------------
##Basic shark plot linked to dolphin plot
combinedPlot(seaObject_tp, showLegend = TRUE, vlines = timepoints,
            vlab = timepoints, vlabSize = 2, ylab = 'Cancer cell fraction',
            separateIndependentClones = TRUE)

## ----plaice-------------------------------------------------------------------
#Plaice plot when all genes have at least one healthy copy
plaicePlot(seaObject_tp, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE, 
            separateIndependentClones = TRUE)

## ----plaiceAnnots-------------------------------------------------------------
#Plaice plot showing biallelic events + annotations
annotsTable <- data.frame(x = c(24,55), y = c(-40,-5), 
                            col = c('black', 'white'), 
                            lab = c('TP53', 'UBA1'))
plaicePlot(seaObject_tp, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE, 
            separateIndependentClones = TRUE, clonesToFill = c(0,0,1,0,0,6,0),
            annotations = annotsTable)

## ----plaiceThpEff-------------------------------------------------------------
##Plaice plot with enabled therapy effect estimation, 
##all genes are assumed to have at least one healthy copy
plaicePlot(seaObject_te, showLegend = TRUE,  vlines = timepoints,
            vlab = timepoints, vlabSize = 4, ylab = TRUE, 
            separateIndependentClones = TRUE)

## ----exploreTrees-------------------------------------------------------------
##Alternative, valid parental relations are determined
timepoints <- c(0,30,75,150)
fracTable <- matrix(
            c( 100, 45, 00, 00,
                20, 00, 00, 00,
                30, 00, 20, 05,
                98, 00, 55, 40),
            ncol=length(timepoints))

trees <- exploreTrees(fracTable, timepoints)
trees

## ----example1,echo=FALSE------------------------------------------------------
library(knitr)
kable(data.frame(Clone=c("clone A","clone B","clone C","clone D"),
                Parent=c("normal cell","clone A","clone B","clone C")))

## ----example2,echo=FALSE------------------------------------------------------
library(knitr)
kable(data.frame(Clone=c("clone A","clone B","clone C","clone D","clone E"),
                Parent=c("normal cell","clone A","clone B","clone C",
                        "clone B")))

## ----example3-----------------------------------------------------------------
##Data used in a previous example
timepoints <- c(0,50,100)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))

##Define input for shiny-app
input<-data.frame(Clones=paste0("Clone ",LETTERS[1:nrow(fracTable)]),
                    as.data.frame(fracTable))
names(input)[2:ncol(input)]<-timepoints

##Export data.frame 'input', e.g. as csv-file
##write.table(input, "Example3.csv", sep = ",", row.names = FALSE,quote = FALSE)

## ----example3Parents,echo=FALSE-----------------------------------------------
library(knitr)
kable(data.frame(Clone=c("clone A","clone B","clone C","clone D","clone E",
                        "Clone F","Clone G"),
                Parent=c("normal cell","clone A","clone A","clone C",
                        "Normal cell","Clone E","Clone F")))

## ----example4-----------------------------------------------------------------
##Data used in a previous example
timepoints <- c(0,50,100)
parents <- c(0,1,1,3,0,5,6)
fracTable <- matrix(c(20,10,0,0,0,0,0,
                    40,20,15,0,30,10,0,
                    50,25,15,10,40,20,15),
                    ncol = length(timepoints))

##Define input for shiny-app
input<-data.frame(Clones=paste0("Clone ",LETTERS[1:nrow(fracTable)]),
                    as.data.frame(fracTable),parents=parents)
names(input)[2:(ncol(input)-1)]<-timepoints

##Export data.frame 'input', e.g. as csv-file
##write.table(input, "Example3_withParents.csv", sep = ",", row.names = FALSE,
##quote = FALSE)

## ----session------------------------------------------------------------------
sessionInfo()

