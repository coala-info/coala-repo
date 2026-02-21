# Code example from 'CytoPipelineGUI' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CytoPipelineGUI")


## ----pkg, include = FALSE-----------------------------------------------------
library(CytoPipeline)
library(CytoPipelineGUI)
library(patchwork)

## ----preparation, message=FALSE, warning=FALSE--------------------------------
# raw data
rawDataDir <- system.file("extdata", package = "CytoPipeline")
sampleFiles <- file.path(rawDataDir, list.files(rawDataDir,
                                                pattern = "Donor"))
# output files
workDir <- suppressMessages(base::tempdir())
# pipeline configuration files (in json)
jsonDir <- rawDataDir

# creation of CytoPipeline objects

pipL_PeacoQC <-
  CytoPipeline(file.path(jsonDir, "OMIP021_PeacoQC_pipeline.json"),
               experimentName = "OMIP021_PeacoQC",
               sampleFiles = sampleFiles)

pipL_flowAI <-
  CytoPipeline(file.path(jsonDir, "OMIP021_flowAI_pipeline.json"),
               experimentName = "OMIP021_flowAI",
               sampleFiles = sampleFiles)

# execute PeacoQC pipeline
suppressWarnings(execute(pipL_PeacoQC, rmCache = TRUE, path = workDir))

# execute flowAI pipeline
suppressWarnings(execute(pipL_flowAI, rmCache = TRUE, path = workDir))

## ----scaleTransformQueueDisplay, results='markup', fig.cap="Scale transform processing queue", echo=FALSE, out.width='75%', fig.align='center', fig.wide = TRUE----
knitr::include_graphics("figs/scaleTransformQueue.png", error = FALSE)

## ----preProcessingQueueDisplay, results='markup', fig.cap="Pre-processing queue for two different pipeline settings", echo=FALSE, out.width='100%', fig.align='center', fig.wide = TRUE----
knitr::include_graphics("figs/preProcessingQueues.png", error = FALSE)

## ----flowframe_viz------------------------------------------------------------
if (interactive()) {
    CytoPipelineGUI::CytoPipelineCheckApp(dir = workDir)    
}

## ----workflow_viz_prog, out.height=450, out.width=600, fig.height=4.5, fig.width=6, fig.align='center'----
# pre-processing workflow
expName <- "OMIP021_PeacoQC"
CytoPipelineGUI::plotSelectedWorkflow(
            experimentName = expName,
            whichQueue = "pre-processing",
            sampleFile = sampleFiles[1],
            path = workDir)

## ----flowframe_viz_prog, out.height=300, out.width=900, fig.height=6, fig.width=18, fig.align='center', message = FALSE----
expName1 <- "OMIP021_PeacoQC"
expName2 <- "OMIP021_flowAI"

p1 <- CytoPipelineGUI::plotSelectedFlowFrame(
    experimentName = expName1,
    whichQueue = "pre-processing",
    sampleFile = 2,
    flowFrameName = "perform_QC_obj",
    path = workDir,
    xChannelLabel = "Time : NA",
    yChannelLabel = "FSC-A : NA",
    useAllCells = TRUE,
    useFixedLinearRange = FALSE)

p2 <- CytoPipelineGUI::plotSelectedFlowFrame(
    experimentName = expName2,
    whichQueue = "pre-processing",
    sampleFile = 2, 
    flowFrameName = "perform_QC_obj",
    path = workDir,
    xChannelLabel = "Time : NA",
    yChannelLabel = "FSC-A : NA",
    useAllCells = TRUE,
    useFixedLinearRange = FALSE)

p3 <- CytoPipelineGUI::plotDiffFlowFrame(
    path = workDir,
    experimentNameFrom = expName1,
    whichQueueFrom = "pre-processing",
    sampleFileFrom = 2, 
    flowFrameNameFrom = "perform_QC_obj",
    xChannelLabelFrom = "Time : NA",
    yChannelLabelFrom = "FSC-A : NA",
    experimentNameTo = expName2,
    whichQueueTo = "pre-processing",
    sampleFileTo = 2,
    flowFrameNameTo = "perform_QC_obj",
    xChannelLabelTo = "Time : NA",
    yChannelLabelTo = "FSC-A : NA",
    useAllCells = TRUE,
    useFixedLinearRange = FALSE)

p1+p2+p3


## ----scale_transform_viz------------------------------------------------------
# 5. show scale transformations
if (interactive()){
    CytoPipelineGUI::ScaleTransformApp(dir = workDir)    
}

## ----scale_transform_viz_prog, out.height=300, out.width=600, fig.height=6, fig.width=12, fig.align='center', message = FALSE----
expName <- "OMIP021_PeacoQC"
pipL <- CytoPipeline::buildCytoPipelineFromCache(
    experimentName = expName,
    path = workDir
)

    ff <- CytoPipeline::getCytoPipelineFlowFrame(
        pipL,
        path = workDir,
        whichQueue = "scale transform",
        objectName = "flowframe_aggregate_obj"
    )
    
    p1 <- plotScaleTransformedChannel(
        ff,
        channel = "FSC-A",
        transfoType = "linear",
        linA = 0.0002,
        linB = -0.5)
    
    p2 <- plotScaleTransformedChannel(
        ff,
        channel = "CD3",
        applyTransform = "data",
        transfoType = "logicle",
        negDecades = 1,
        width = 0.5,
        posDecades = 4
    )
    
    p1+p2

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

