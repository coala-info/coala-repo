# Code example from 'OGRE' vignette. See references/ for full tutorial.

## ----echo=FALSE, out.width='30%',fig.align='center'---------------------------
knitr::include_graphics('./logo.png')

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE)
vigDir=getwd()
if(dir.exists("../inst/extdata")){
  knitr::opts_knit$set(root.dir = "../inst/extdata")
}else{
  knitr::opts_knit$set(root.dir = "../extdata")
}

## ----message=FALSE, warning=FALSE,eval=FALSE----------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("OGRE")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(OGRE)


## ----InitializeOGRE, message=TRUE, echo=TRUE,warning=FALSE--------------------
myQueryFolder <- file.path(system.file('extdata', package = 'OGRE'),"query")
mySubjectFolder <- file.path(system.file('extdata', package = 'OGRE'),"subject")

myOGRE <- OGREDataSetFromDir(queryFolder=myQueryFolder,
                             subjectFolder=mySubjectFolder)

## ----checkMetadata, message=TRUE, echo=TRUE,warning=TRUE----------------------
metadata(myOGRE)

## ----loadAnnotations, message=TRUE, echo=TRUE,warning=TRUE--------------------
myOGRE <- loadAnnotations(myOGRE)

## ----checkDatasetNames, message=TRUE, echo=TRUE,warning=TRUE------------------
names(myOGRE)

## ----checkGRanges, message=TRUE, echo=TRUE,warning=TRUE-----------------------
myOGRE

## ----echo=FALSE, out.width='70%',fig.align='center'---------------------------
knitr::include_graphics(file.path(vigDir,'overlap.png'))

## ----fOverlaps, message=TRUE, echo=TRUE,warning=TRUE--------------------------
myOGRE <- fOverlaps(myOGRE)
head(metadata(myOGRE)$detailDT,n=2)

## ----sumPlot, echo=TRUE, message=TRUE, warning=TRUE,fig.dim = c(30/2.54, 20/2.54)----
 myOGRE <- sumPlot(myOGRE)
 metadata(myOGRE)$barplot_summary

## ----gvizPlot, message=TRUE, echo=TRUE,warning=FALSE--------------------------
 myOGRE <- gvizPlot(myOGRE,"ENSG00000142168",showPlot = TRUE,
                    trackRegionLabels = setNames(c("name","name"),c("genes","CGI")))

## ----summarizeOverlap, message=TRUE, echo=TRUE,warning=FALSE------------------
 myOGRE <- summarizeOverlap(myOGRE) 
 myOGRE <- plotHist(myOGRE)
 metadata(myOGRE)$summaryDT
 metadata(myOGRE)$hist$TFBS

## ----coveragePlot, message=TRUE, echo=TRUE,warning=FALSE----------------------
 myOGRE <- covPlot(myOGRE) 
 metadata(myOGRE)$covPlot$TFBS$plot

## ----datasetsFromAnnotationHub,eval=FALSE-------------------------------------
# myOGRE <- OGREDataSet()
# listPredefinedDataSets()
# myOGRE <- addDataSetFromHub(myOGRE,"protCodingGenes","query")
# myOGRE <- addDataSetFromHub(myOGRE,"CGI","subject")
# myOGRE <- addDataSetFromHub(myOGRE,"TFBS","subject")
# names(myOGRE)

## ----datasetsUserGRanges,eval=FALSE-------------------------------------------
# myOGRE <- OGREDataSet()
# myGRanges <- makeExampleGRanges()
# myOGRE <- addGRanges(myOGRE,myGRanges,"query")

## ----additionalAnnotationHub,eval=FALSE---------------------------------------
# aH <- AnnotationHub()
# aH[["AH5086"]]
# q <- query(aH, c("GRanges","Homo sapiens", "CpG"))

## ----addgff,eval=FALSE--------------------------------------------------------
# myOGRE <- OGREDataSetFromDir(queryFolder = "pathToQueryFolder",
#                              subjectFolder = "pathToSubjectFolder")
# myOGRE <- loadAnnotations(myOGRE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

