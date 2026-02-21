# Code example from 'v00.basicIntro' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
options(width=120)
knitr::opts_chunk$set(
   collapse = TRUE,
   eval=interactive(),
   echo=TRUE,
   comment = "#>"
)

## ----eval=TRUE, echo=FALSE--------------------------------------------------------------------------------------------
knitr::include_graphics("igvR-basicDemo.png")

## ----loadLibraries,  results='hide'-----------------------------------------------------------------------------------
# library(igvR)

## ----createLoad, results='hide'---------------------------------------------------------------------------------------
# igv <- igvR()
# setBrowserWindowTitle(igv, "simple igvR demo")
# setGenome(igv, "hg38")

## ----genomes, echo=TRUE, results='asis'-------------------------------------------------------------------------------
# print(getSupportedGenomes(igv))

## ----initialDisplay,  results='hide'----------------------------------------------------------------------------------
# showGenomicRegion(igv, "MYC")

## ----simple data.frame,  results='hide'-------------------------------------------------------------------------------
# loc <- getGenomicRegion(igv)
# 
# tbl.bed <- data.frame(chrom=loc$chrom, start=loc$start + 2000, end=loc$end-2000,
#                       name="simple.example", stringsAsFactors=FALSE)
# 
# track <- DataFrameAnnotationTrack("simple bed", tbl.bed, color="random")
# displayTrack(igv, track)

## ----bedgraph-like data.frame,  results='hide'------------------------------------------------------------------------
# loc <- getGenomicRegion(igv)
# size <- with(loc, 1 + end - start)
# starts <- seq(loc$start, loc$end, by=5)
# ends   <- starts + 5
# values <- sample(1:100, size=length(starts), replace=TRUE)
# 
# tbl.bedGraph <- data.frame(chrom=rep("chr8", length(starts)), start=starts, end=ends,
#                            value=values, stringsAsFactors=FALSE)
# 
# track <- DataFrameQuantitativeTrack("bedGraph", tbl.bedGraph, color="red", autoscale=FALSE,
#                                     min=80, max=100)
# displayTrack(igv, track)
# 

## ----zoom out,  results='hide'----------------------------------------------------------------------------------------
# loc <- getGenomicRegion(igv)
# half.span <- round((loc$end-loc$start)/2)
# 
# new.region <- with(loc, sprintf("%s:%d-%d", chrom, start-half.span, end+half.span))
# showGenomicRegion(igv, new.region)

## ----zoom out new,  results='hide'------------------------------------------------------------------------------------
# 
# zoomOut(igv)
# zoomIn(igv)

## ----sessionInfo------------------------------------------------------------------------------------------------------
# sessionInfo()

