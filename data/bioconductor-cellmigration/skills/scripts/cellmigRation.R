# Code example from 'cellmigRation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>", echo = TRUE, include = TRUE, eval = TRUE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center", fig.keep = "last", fig.height = 5,
    fig.width = 9
)

Tim0 <- Sys.time()
library(ggplot2)
library(dplyr)
library(cellmigRation)
library(kableExtra)

## ----set-options, echo=FALSE, cache=FALSE----
options(width = 14)

## ----setting_seed----
set.seed(1234)

## ----installing_cellmigRation, eval=FALSE----
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("cellmigRation")

## -----------
library(cellmigRation)
library(dplyr)
library(ggplot2)
library(kableExtra)

## ----echo=TRUE, include=TRUE, eval=TRUE, results='markup'----
# load data
data(ThreeConditions)

# An S4 trackedCells object
ThreeConditions[[1]]

## ----echo=TRUE, include=TRUE, eval=TRUE, fig.height=7.8----
# Optimize parameters using 1 core
x1 <- OptimizeParams(
    ThreeConditions$ctrl01, threads = 1, lnoise_range = c(5, 12),
    diameter_range = c(16, 22), threshold_range = c(5, 15, 30),
    verbose = FALSE, plot = TRUE)

## ----echo=TRUE, include=TRUE, eval=TRUE----
# obtain optimized params
getOptimizedParams(x1)$auto_params

## ----echo=TRUE, include=TRUE, eval=TRUE, fig.keep='last'----
# Track cell movements using optimized params
x1 <- CellTracker(
    tc_obj = x1, min_frames_per_cell = 3, threads = 1, verbose = TRUE)

# Track cell movements using params from a different object
x2 <- CellTracker(
    ThreeConditions$ctrl02, import_optiParam_from = x1,
    min_frames_per_cell = 3, threads = 1)

## ----fig.height=4, fig.width=4, fig.align='center'----
# Track cell movements using CUSTOM params, show plots
x3 <- CellTracker(
    tc_obj = ThreeConditions$drug01,
    lnoise = 5, diameter = 22, threshold = 6,
    threads = 1, maxDisp = 10,
    show_plots = TRUE)

## ----echo=TRUE, include=TRUE, eval=TRUE, results='asis'----
# Get tracks and show header
trk1 <- cellmigRation::getTracks(x1)
head(trk1) %>% kable() %>% kable_styling(bootstrap_options = 'striped')

## ----echo=TRUE, include=TRUE, eval=TRUE----
# Basic migration stats can be computed similar to the fastTracks software
x1 <- ComputeTracksStats(
    x1, time_between_frames = 10, resolution_pixel_per_micron = 1.24)
x2 <- ComputeTracksStats(
    x2, time_between_frames = 10, resolution_pixel_per_micron = 1.24)
x3 <- ComputeTracksStats(
    x3, time_between_frames = 10, resolution_pixel_per_micron = 1.24)

# Fetch population stats and attach a column with a sample label
stats.x1 <- cellmigRation::getCellsStats(x1) %>%
    mutate(Condition = "CTRL1")
stats.x2 <- cellmigRation::getCellsStats(x2) %>%
    mutate(Condition = "CTRL2")
stats.x3 <- cellmigRation::getCellsStats(x3) %>%
    mutate(Condition = "DRUG1")

## ----echo=TRUE, include=TRUE, eval=TRUE, results='asis'----
stats.x1 %>%
    dplyr::select(
        c("Condition", "Cell_Number", "Speed", "Distance", "Frames")) %>%
    kable() %>% kable_styling(bootstrap_options = 'striped')

## ----fig.height=4.5, fig.width=4.9, fig.align='center'----
# Run a simple Speed test
sp.df <- rbind(
    stats.x1 %>% dplyr::select(c("Condition", "Speed")),
    stats.x2 %>% dplyr::select(c("Condition", "Speed")),
    stats.x3 %>% dplyr::select(c("Condition", "Speed"))
)

vp1 <- ggplot(sp.df, aes(x=Condition, y = Speed, fill = Condition)) +
    geom_violin(trim = FALSE) +
    scale_fill_manual(values = c("#b8e186", "#86e1b7", "#b54eb4")) +
    geom_boxplot(width = 0.12, fill = "#d9d9d9")

print(vp1)

## ----echo=TRUE, include=TRUE, eval=TRUE, results='markup'----
# Run a t-test:
sp.lst <- with( sp.df, split(Speed, f = Condition))
t.test(sp.lst$CTRL1, sp.lst$DRUG1, paired = FALSE, var.equal = FALSE)

## ----fig.height=4, fig.width=4, fig.align='center'----
# Visualize cells in a frame of interest
cellmigRation::VisualizeStackCentroids(x1, stack = 1)

## ----echo=TRUE, include=TRUE, eval=TRUE, fig.height=4.6----
# Visualize tracks of cells originating at a frame of interest
par(mfrow = c(1, 3))
cellmigRation::visualizeCellTracks(x1, stack = 1, main = "tracks from CTRL1")
cellmigRation::visualizeCellTracks(x2, stack = 1, main = "tracks from CTRL2")
cellmigRation::visualizeCellTracks(x3, stack = 1, main = "tracks from DRUG1")

## ----echo=TRUE, include=TRUE, eval=TRUE, results='asis'----
# aggregate tracks together
all.ctrl <- aggregateTrackedCells(x1, x2, meta_id_field = "tiff_file")

# Show header
all.ctrl[seq_len(10), seq_len(6)] %>%
    kable() %>% kable_styling(bootstrap_options = 'striped')

## ----eval = TRUE, echo=FALSE, results='markup', include=TRUE----
# Table tiff_filename vs. condition
with(all.ctrl, table(condition, tiff_file))

## ----eval = TRUE, echo = TRUE, results='markup', include=TRUE----
# Prepare second input of Module 2
all.drug <- getTracks(tc_obj = x3, attach_meta = TRUE)

## ----eval = TRUE, echo = TRUE, results='markup', include=TRUE----
rmTD <- CellMig(trajdata = all.ctrl)
rmTD <- setExpName(rmTD, "Control")

# Preprocessing the data
rmTD <- rmPreProcessing(rmTD, PixelSize=1.24, TimeInterval=10, FrameN=3)

## ----eval = TRUE, echo = TRUE, include=TRUE, fig.width=5----
# Plotting tracks (2D and 3D)
plotAllTracks(rmTD, Type="l", FixedField=FALSE, export=FALSE)

## ----eval = TRUE, echo = TRUE, include=TRUE, fig.keep='last', fig.width=5----
# Plotting the trajectory data of sample of cells (selected randomly)
# in one figure
plotSampleTracks(
    rmTD, Type="l", FixedField=FALSE, celNum=2, export = FALSE)

## ----echo=TRUE, include=TRUE, eval=TRUE----
## Directionality
srmTD <- DiRatio(rmTD, export=TRUE)
DiRatioPlot(srmTD, export=TRUE)

## ----echo=FALSE, out.width="50%", fig.cap="Controldirectionality"----
knitr::include_graphics(
    "Control-DR_Results/Controldirectionality ratio for all cells.jpg")

## ----echo=TRUE, include=TRUE, eval=TRUE----
rmTD<-MSD(object = rmTD, sLAG=0.5, ffLAG=0.5, export=TRUE)

## ----echo=TRUE, include=TRUE, results='asis', fig.keep='last', fig.width=5----
rmTD <- VeAutoCor(
    rmTD, TimeInterval=10, sLAG=0.5, sPLOT=TRUE,
    aPLOT=TRUE, export=FALSE)

## ----echo=TRUE, include=TRUE, eval=TRUE, message=FALSE, warning=FALSE----
rmTD <-FinRes(rmTD, ParCor=TRUE, export=FALSE)

## ----echo=FALSE, include=TRUE, results='asis'----
head(getCellMigSlot(rmTD, "results"), 5) %>%
    kable() %>% kable_styling(bootstrap_options = 'striped')

## ----include=FALSE----
Tim1 <- Sys.time()
TimDiff <- as.numeric(difftime(time1 = Tim1, time2 = Tim0, units = "mins"))
TimDiff <- format(round(TimDiff, digits = 2), nsmall = 2)

## ----echo=FALSE, eval=TRUE, results='markup'----
sessionInfo()

