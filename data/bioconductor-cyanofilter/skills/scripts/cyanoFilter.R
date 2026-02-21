# Code example from 'cyanoFilter' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE, 
  message = FALSE,fig.width = 19,
  fig.height = 11
)

## ----packages-----------------------------------------------------------------
library(dplyr)
library(magrittr)
library(tidyr)
library(purrr)
library(flowCore)
library(flowDensity)
library(cyanoFilter)

## ----data_and_preprocessing---------------------------------------------------
metadata <- system.file("extdata", "2019-03-25_Rstarted.csv", 
  package = "cyanoFilter", 
  mustWork = TRUE)
metafile <- read.csv(metadata, skip = 7, stringsAsFactors = FALSE, 
  check.names = TRUE)
#columns containing dilution, $\mu l$ and id information
metafile <- metafile %>% 
  dplyr::select(Sample.Number, 
                Sample.ID,
                Number.of.Events,
                Dilution.Factor,
                Original.Volume,
                Cells.L)

## ----metafile1----------------------------------------------------------------
#extract the part of the Sample.ID that corresponds to BS4 or BS5
metafile <- metafile %>% dplyr::mutate(Sample.ID2 = 
                                         stringr::str_extract(metafile$Sample.ID, "BS*[4-5]")
                                       )
#clean up the Cells.muL column
names(metafile)[which(stringr::str_detect(names(metafile), "Cells."))] <- "CellspML"

## ----metafile2----------------------------------------------------------------
metafile <- metafile %>% mutate(Status = cyanoFilter::goodFcs(metafile = metafile, 
                                                              col_cpml = "CellspML", 
                                        mxd_cellpML = 1000, 
                                        mnd_cellpML = 50)
                                )
knitr::kable(metafile)

## ----metafile3----------------------------------------------------------------
broken <- metafile %>% group_by(Sample.ID2) %>% nest()
metafile$Retained <- unlist(map(broken$data, function(.x) {
  retain(meta_files = .x, make_decision = "maxi",
  Status = "Status",
  CellspML = "CellspML")
 })
)
knitr::kable(metafile)

## ----reading, cache=TRUE------------------------------------------------------
flowfile_path <- system.file("extdata", "B4_18_1.fcs", package = "cyanoFilter",
  mustWork = TRUE)
flowfile <- read.FCS(flowfile_path, alter.names = TRUE,
  transformation = FALSE, emptyValue = FALSE,
  dataset = 1)
flowfile

## ----remove_na, fig.cap="**Panel plot for all channels measured in flowfile_nona. A bivariate kernel smoothed color density is used to indicate the cell density.**"----
flowfile_nona <- noNA(x = flowfile)
ggpairsDens(flowfile_nona, notToPlot = "TIME")

## ----logtrans, cache=TRUE, fig.cap="Panel plot for log-transformed channels for flowfile_logtrans. A bivariate kernel smoothed color density is used to indicate the cell density."----

flowfile_noneg <- noNeg(x = flowfile_nona)
flowfile_logtrans <- lnTrans(x = flowfile_noneg, 
  notToTransform = c("SSC.W", "TIME"))
ggpairsDens(flowfile_logtrans, notToPlot = "TIME")

## ----marginEvents, cache=TRUE, fig.cap="Smoothed Scatterplot of measured width (SSC.W) and height (FSC.HLin). The red line is the estimated cut point by flowDensity, and every particle below the red line has their width properly measured."----
flowfile_marginout <- cellMargin(flowframe = flowfile_logtrans,
                                 Channel = 'SSC.W', type = 'estimate', 
                                 y_toplot = "FSC.HLin")
plot(flowfile_marginout)

summary(flowfile_marginout, 
       channels = c('FSC.HLin', 'SSC.HLin', 
                    'SSC.W'))

## ----Debris, fig.cap="Smoothed Scatterplot of measured chlorophyll *a* channel (RED.B.HLin) and phycoerythrin channel (YEL.B.HLin). The red lines are the estimated minimum intersection points between the detected peaks."----

cells_nodebris <-  debrisNc(flowframe = reducedFlowframe(flowfile_marginout), 
                             ch_chlorophyll = "RED.B.HLin", ch_p2 = "YEL.B.HLin",
                             ph = 0.05)
plot(cells_nodebris)

## ----kdapproach, fig.cap="Smoothed Scatterplot of all channels used in the gating process."----

bs4_gate1 <- phytoFilter(flowfile = reducedFlowframe(cells_nodebris),
               pig_channels = c("RED.B.HLin", "YEL.B.HLin", "RED.R.HLin"),
               com_channels = c("FSC.HLin", "SSC.HLin"))

plot(bs4_gate1)

