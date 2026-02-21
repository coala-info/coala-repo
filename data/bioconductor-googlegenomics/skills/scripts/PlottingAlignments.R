# Code example from 'PlottingAlignments' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown()

## ---- echo=FALSE, results="hide"-------------------------------------------
# Ensure that any errors cause the Vignette build to fail.
library(knitr)
opts_chunk$set(error=FALSE)

## ---- echo = FALSE---------------------------------------------------------
apiKey <- Sys.getenv("GOOGLE_API_KEY")
if (nchar(apiKey) == 0) {
  warning(paste("To build this vignette, please setup the environment variable",
                "GOOGLE_API_KEY with the public API key from your Google",
                "Developer Console before loading the GoogleGenomics package,",
                "or run GoogleGenomics::authenticate."))
  knitr::knit_exit()
}

## ----message=FALSE---------------------------------------------------------
library(GoogleGenomics)
# This vignette is authenticated on package load from the env variable GOOGLE_API_KEY.
# When running interactively, call the authenticate method.
# ?authenticate

## --------------------------------------------------------------------------
reads <- getReads()
length(reads)

## --------------------------------------------------------------------------
class(reads)
mode(reads)

## --------------------------------------------------------------------------
names(reads[[1]])

## --------------------------------------------------------------------------
reads[[1]]$alignedSequence
reads[[1]]$alignment$position$referenceName
reads[[1]]$alignment$position$position

## --------------------------------------------------------------------------
readsToGAlignments(reads)

## --------------------------------------------------------------------------
# Change the values of 'chromosome', 'start', or 'end' here if you wish to plot 
# alignments from a different portion of the genome.
alignments <- getReads(readGroupSetId="CMvnhpKTFhD3he72j4KZuyc",
                       chromosome="chr13",
                       start=33628130,
                       end=33628145,
                       converter=readsToGAlignments)
alignments

## ----message=FALSE---------------------------------------------------------
library(ggbio)

## ----coverage--------------------------------------------------------------
alignmentPlot <- autoplot(alignments, aes(color=strand, fill=strand))
coveragePlot <- ggplot(as(alignments, "GRanges")) +
                stat_coverage(color="gray40", fill="skyblue")
tracks(alignmentPlot, coveragePlot,
       xlab="Reads overlapping rs9536314 for NA12893")

## ----ideogram--------------------------------------------------------------
ideogramPlot <- plotIdeogram(genome="hg19", subchr="chr13")
ideogramPlot + xlim(as(alignments, "GRanges"))

## --------------------------------------------------------------------------
sessionInfo()

