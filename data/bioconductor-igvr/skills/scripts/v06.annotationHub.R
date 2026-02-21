# Code example from 'v06.annotationHub' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
options(width=120)
knitr::opts_chunk$set(
   collapse = TRUE,
   eval=interactive(),
   echo=TRUE,
   comment = "#>"
)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# library(igvR)
# library(AnnotationHub)
# 
# igv <- igvR()
# setBrowserWindowTitle(igv, "H3K27ac GATA2")
# setGenome(igv, "hg19")
# showGenomicRegion(igv, "GATA2")
# for(i in 1:4) zoomOut(igv)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/annotationHub-01.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# aHub <- AnnotationHub()
# query.terms <- c("H3K27Ac", "k562")
# length(query(aHub, query.terms))  # found 7
# h3k27ac.entries <- query(aHub, query.terms)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# x.broadPeak <- aHub[["AH23388"]]
# x.bigWig <- aHub[["AH32958"]]

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# roi <- getGenomicRegion(igv)
# gr.broadpeak <- x.broadPeak[seqnames(x.broadpeak)==roi$chrom &
#                             start(x.broadpeak) > roi$start &
#                             end(x.broadpeak) < roi$end]

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# names(mcols(gr.broadpeak))
#   #  "name"        "score"       "signalValue" "pValue"      "qValue"
# mcols(gr.broadpeak) <- gr.broadpeak$score
# track <- GRangesQuantitativeTrack("h3k27ac bp", gr.broadpeak, autoscale=TRUE, color="brown")
# displayTrack(igv, track)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# 
# file.bigWig <- resource(x.bigWig)[[1]]
# gr.roi <- with(roi, GRanges(seqnames=chrom, IRanges(start, end)))
# gr.bw <- import(file.bigWig, which=gr.roi, format="bigWig")
# track <- GRangesQuantitativeTrack("h3k27ac.bw", gr.bw, autoscale=TRUE, color="gray")
# displayTrack(igv, track)
# 

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/annotationHub-02.png")

## ----eval=TRUE--------------------------------------------------------------------------------------------------------
sessionInfo()

