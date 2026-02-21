# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=TRUE----------------------------------------------------------------
    #Load the library
    library(phosphonormalizer)
  	#Enriched data overview
  	head(enriched.rd)
  	#Non-enriched data overview
  	head(non.enriched.rd)

## ----eval=FALSE---------------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("phosphonormalizer")

## ----eval=TRUE, fig.height = 4, fig.width = 6, fig.align = "center"-----------
    #Load the library
    library(phosphonormalizer)
    #Specify the column numbers of abundances in the original data.frame, 
    #from both enriched and non-enriched runs
    samplesCols <- data.frame(enriched=3:17, non.enriched=3:17)
    #Specify the column numbers of sequence and modification in the original data.frame, 
    #from both enriched and non-enriched runs
    modseqCols <- data.frame(enriched = 1:2, non.enriched = 1:2)
    #The samples and their technical replicates
    techRep <- factor(x = c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5))
    #If the paramter plot.fc set, the corresponding plots of Sample fold changes is produced
	#Here, for demonstration, the fold change distributions are shown for samples 3 vs 1
    plot.param <- list(control = c(1), samples = c(3))
    #Call the function
	norm <- normalizePhospho(enriched = enriched.rd, non.enriched = non.enriched.rd, 
	samplesCols = samplesCols, modseqCols = modseqCols, techRep = techRep, 
	plot.fc = plot.param)

