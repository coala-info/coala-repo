# Code example from 'CytoPipeline' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## -----------------------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CytoPipeline")

## ----scaleTransformQueueDisplay, results='markup', fig.cap="Scale transform processing queue", echo=FALSE, out.width='75%', fig.align='center', fig.wide = TRUE----
knitr::include_graphics("figs/scaleTransformQueue.png", error = FALSE)

## ----preProcessingQueueDisplay, results='markup', fig.cap="Pre-processing queue for two different pipeline settings", echo=FALSE, out.width='100%', fig.align='center', fig.wide = TRUE----
knitr::include_graphics("figs/preProcessingQueues.png", error = FALSE)

## ----pathsDef-----------------------------------------------------------------
library(CytoPipeline)

# raw data
rawDataDir <- system.file("extdata", package = "CytoPipeline")
# output files
workDir <- suppressMessages(base::tempdir())

## ----CytoPipelineSteps--------------------------------------------------------

# main parameters : sample files and output files

experimentName <- "OMIP021_PeacoQC"
sampleFiles <- file.path(rawDataDir, list.files(rawDataDir,
                                                pattern = "Donor"))

pipL_PeacoQC <- CytoPipeline(experimentName = experimentName,
                             sampleFiles = sampleFiles)

### SCALE TRANSFORMATION STEPS ###

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "scale transform",
        CytoProcessingStep(
            name = "flowframe_read",
            FUN = "readSampleFiles",
            ARGS = list(
                whichSamples = "all",
                truncate_max_range = FALSE,
                min.limit = NULL
            )
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "scale transform",
        CytoProcessingStep(
            name = "remove_margins",
            FUN = "removeMarginsPeacoQC",
            ARGS = list()
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "scale transform",
        CytoProcessingStep(
            name = "compensate",
            FUN = "compensateFromMatrix",
            ARGS = list(matrixSource = "fcs")
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "scale transform",
        CytoProcessingStep(
            name = "flowframe_aggregate",
            FUN = "aggregateAndSample",
            ARGS = list(
                nTotalEvents = 10000,
                seed = 0
            )
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "scale transform",
        CytoProcessingStep(
            name = "scale_transform_estimate",
            FUN = "estimateScaleTransforms",
            ARGS = list(
                fluoMethod = "estimateLogicle",
                scatterMethod = "linear",
                scatterRefMarker = "BV785 - CD3"
            )
        )
    )

### FLOW FRAME PRE-PROCESSING STEPS ###

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "flowframe_read",
            FUN = "readSampleFiles",
            ARGS = list(
                truncate_max_range = FALSE,
                min.limit = NULL
            )
        )
    )


pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "remove_margins",
            FUN = "removeMarginsPeacoQC",
            ARGS = list()
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "compensate",
            FUN = "compensateFromMatrix",
            ARGS = list(matrixSource = "fcs")
        )
    )

pipL_PeacoQC <-
    addProcessingStep(
        pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "perform_QC",
            FUN = "qualityControlPeacoQC",
            ARGS = list(
                preTransform = TRUE,
                min_cells = 150, # default
                max_bins = 500, # default
                step = 500, # default,
                MAD = 6, # default
                IT_limit = 0.55, # default
                force_IT = 150, # default
                peak_removal = 0.3333, # default
                min_nr_bins_peakdetection = 10 # default
            )
        )
    )

pipL_PeacoQC <-
    addProcessingStep(
        pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "remove_doublets",
            FUN = "removeDoubletsCytoPipeline",
            ARGS = list(
                areaChannels = c("FSC-A", "SSC-A"),
                heightChannels = c("FSC-H", "SSC-H"),
                nmads = c(3, 5))
            )
    )
                    

                
pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "remove_debris",
            FUN = "removeDebrisManualGate",
            ARGS = list(
                FSCChannel = "FSC-A",
                SSCChannel = "SSC-A",
                gateData =  c(73615, 110174, 213000, 201000, 126000,
                              47679, 260500, 260500, 113000, 35000)
            )
        )
    )

pipL_PeacoQC <-
    addProcessingStep(pipL_PeacoQC,
        whichQueue = "pre-processing",
        CytoProcessingStep(
            name = "remove_dead_cells",
            FUN = "removeDeadCellsManualGate",
            ARGS = list(
                FSCChannel = "FSC-A",
                LDMarker = "L/D Aqua - Viability",
                gateData = c(0, 0, 250000, 250000,
                             0, 650, 650, 0)
            )
        )
    )



## ----CytoPipelineJson---------------------------------------------------------

jsonDir <- rawDataDir

# creation on CytoPipeline object,
# using json file as input
pipL_flowAI <-
  CytoPipeline(file.path(jsonDir, "OMIP021_flowAI_pipeline.json"),
               experimentName = "OMIP021_flowAI",
               sampleFiles = sampleFiles)



## ----executePeacoQC-----------------------------------------------------------
# execute PeacoQC pipeline
execute(pipL_PeacoQC, path = workDir)

## ----executeFlowAI------------------------------------------------------------
# execute flowAI pipeline
execute(pipL_flowAI, path = workDir)

## ----plotWorkFlows1, fig.cap = "PeacoQC pipeline - scale transformList processing queue"----

# plot work flow graph - PeacoQC - scale transformList
plotCytoPipelineProcessingQueue(
  pipL_PeacoQC,
  whichQueue = "scale transform",
  path = workDir)


## ----plotWorkFlows2, fig.cap = "PeacoQC pipeline - file pre-processing queue"----

# plot work flow graph - PeacoQC - pre-processing
plotCytoPipelineProcessingQueue(
  pipL_PeacoQC,
  whichQueue = "pre-processing",
  sampleFile = 1,
  path = workDir)

## ----plotWorkFlows3, fig.cap = "flowAI pipeline - scale transformList processing queue"----

# plot work flow graph - flowAI - scale transformList
plotCytoPipelineProcessingQueue(
  pipL_flowAI,
  whichQueue = "scale transform",
  path = workDir)

## ----plotWorkFlows4, fig.cap = "flowAI pipeline - file pre-processing queue"----

# plot work flow graph - flowAI - pre-processing

plotCytoPipelineProcessingQueue(
  pipL_flowAI,
  whichQueue = "pre-processing",
  sampleFile = 1,
  path = workDir)

## ----gettingObjectInfos-------------------------------------------------------
getCytoPipelineObjectInfos(pipL_PeacoQC, 
                           path = workDir,
                           whichQueue = "scale transform")
                                  
getCytoPipelineObjectInfos(pipL_PeacoQC, 
                           path = workDir,
                           whichQueue = "pre-processing",
                           sampleFile = sampleFiles(pipL_PeacoQC)[1])

## ----gettingFlowFrames--------------------------------------------------------
# example of retrieving a flow frame
# at a given step
ff <- getCytoPipelineFlowFrame(
  pipL_PeacoQC,
  whichQueue = "pre-processing",
  sampleFile = 1,
  objectName = "remove_doublets_obj",
  path = workDir)

#
ff2 <- getCytoPipelineFlowFrame(
  pipL_PeacoQC,
  whichQueue = "pre-processing",
  sampleFile = 1,
  objectName = "remove_debris_obj",
  path = workDir)


## ----ggplotEvents1, fig.cap = "1-dimensional distribution plot (forward scatter channel)"----
ggplotEvents(ff, xChannel = "FSC-A")

## ----ggplotEvents2, fig.cap = "2-dimensional distribution plot (forward scatter vs. side scatter channels)"----
ggplotEvents(ff, xChannel = "FSC-A", yChannel = "SSC-A")

## ----ggplotEvents3, fig.cap = "2-dimensional difference plot between remove_doublets and remove_debris steps"----
ggplotFilterEvents(ff, ff2, xChannel = "FSC-A", yChannel = "SSC-A")

## ----cacheObjectRetrieve------------------------------------------------------
obj <- getCytoPipelineObjectFromCache(pipL_PeacoQC,
                                      path = workDir,
                                      whichQueue = "scale transform",
                                      objectName = "compensate_obj")
show(obj)

## ----getNbEvents--------------------------------------------------------------
ret <- CytoPipeline::collectNbOfRetainedEvents(
    experimentName = "OMIP021_PeacoQC",
    path = workDir
)
ret

## ----getRetainedProp----------------------------------------------------------
retainedProp <- 
    as.data.frame(t(apply(
        ret,
        MARGIN = 1,
        FUN = function(line) {
            if (length(line) == 0 || is.na(line[1])) {
                as.numeric(rep(NA, length(line)))
            } else {
                round(line/line[1], 3)
            }
        }
    )))

retainedProp <- retainedProp[-1]

retainedProp

## ----getStepRemovedProp-------------------------------------------------------
stepRemovedProp <- 
    as.data.frame(t(apply(
        ret,
        MARGIN = 1,
        FUN = function(line) {
            if (length(line) == 0) {
                as.numeric(rep(NA, length(line)))
            } else {
                round(1-line/dplyr::lag(line), 3)
            }
        }
    )))

stepRemovedProp <- stepRemovedProp[-1]

stepRemovedProp

## ----loadAddPackages----------------------------------------------------------
library("reshape2")
library("ggplot2")

## ----plotRetainedProp---------------------------------------------------------
myGGPlot <- function(DF, title){
    stepNames = colnames(DF)
    rowNames = rownames(DF)
    DFLongFmt <- reshape(DF,
                         direction = "long",
                         v.names = "proportion",
                         varying = stepNames,
                         timevar = "step",
                         time = stepNames,
                         ids = rowNames)
    
    DFLongFmt$step <- factor(DFLongFmt$step, levels = stepNames)
    
    
    ggplot(data = DFLongFmt,
                 mapping = aes(x = step, y = proportion, text = id)) +
        geom_point(col = "blue") + 
        ggtitle(title) +
        theme(axis.text.x = element_text(angle = 90))
    
}

p1 <- myGGPlot(DF = retainedProp, 
               title = "Retained event proportion at each step")
p1

## ----plotStepRemovedProp------------------------------------------------------
p2 <- myGGPlot(DF = stepRemovedProp,
               title = "Event proportion removed by each step")
p2

## ----launchShinyApp-----------------------------------------------------------
#devtools::install_github("https://github.com/UCLouvain-CBIO/CytoPipelineGUI")
#CytoPipelineGUI::CytoPipelineCheckApp(dir = workDir)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

