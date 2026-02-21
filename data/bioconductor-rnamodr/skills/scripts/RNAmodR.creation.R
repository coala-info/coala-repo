# Code example from 'RNAmodR.creation' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(RNAmodR)
})

## ----eval=FALSE---------------------------------------------------------------
# library(RNAmodR)

## -----------------------------------------------------------------------------
setClass(Class = "ExampleSequenceDataFrame",
         contains = "SequenceDFrame")
ExampleSequenceDataFrame <- function(df, ranges, sequence, replicate,
                                      condition, bamfiles, seqinfo){
  RNAmodR:::.SequenceDataFrame("Example",df, ranges, sequence, replicate,
                               condition, bamfiles, seqinfo)
}
setClass(Class = "ExampleSequenceData",
         contains = "SequenceData",
         slots = c(unlistData = "ExampleSequenceDataFrame"),
         prototype = list(unlistData = ExampleSequenceDataFrame(),
                          unlistType = "ExampleSequenceDataFrame",
                          minQuality = 5L,
                          dataDescription = "Example data"))
ExampleSequenceData <- function(bamfiles, annotation, sequences, seqinfo, ...){
  RNAmodR:::SequenceData("Example", bamfiles = bamfiles, 
                         annotation = annotation, sequences = sequences,
                         seqinfo = seqinfo, ...)
}

## -----------------------------------------------------------------------------
setMethod("getData",
          signature = c(x = "ExampleSequenceData",
                        bamfiles = "BamFileList",
                        grl = "GRangesList",
                        sequences = "XStringSet",
                        param = "ScanBamParam"),
          definition = function(x, bamfiles, grl, sequences, param, args){
            ###
          }
)

## -----------------------------------------------------------------------------
setMethod("aggregateData",
          signature = c(x = "ExampleSequenceData"),
          function(x, condition = c("Both","Treated","Control")){
            ###
          }
)

## -----------------------------------------------------------------------------
setClass("ModExample",
         contains = c("RNAModifier"),
         prototype = list(mod = "X",
                          score = "score",
                          dataType = "ExampleSequenceData"))
ModExample <- function(x, annotation, sequences, seqinfo, ...){
  RNAmodR:::Modifier("ModExample", x = x, annotation = annotation,
                     sequences = sequences, seqinfo = seqinfo, ...)
}

## -----------------------------------------------------------------------------
setReplaceMethod(f = "settings", 
                 signature = signature(x = "ModExample"),
                 definition = function(x, value){
                   x <- callNextMethod()
                   # validate special setting here
                   x@settings[names(value)] <- unname(.norm_example_args(value))
                   x
                 })

## -----------------------------------------------------------------------------
setMethod(f = "aggregateData", 
          signature = signature(x = "ModExample"),
          definition = 
            function(x, force = FALSE){
              # Some data with element per transcript
            }
)

## -----------------------------------------------------------------------------
setMethod("findMod",
          signature = c(x = "ModExample"),
          function(x){
            # an element per modification found.
          }
)

## -----------------------------------------------------------------------------
setClass("ModSetExample",
         contains = "ModifierSet",
         prototype = list(elementType = "ModExample"))
ModSetExample <- function(x, annotation, sequences, seqinfo, ...){
  RNAmodR:::ModifierSet("ModExample", x = x, annotation = annotation,
                        sequences = sequences, seqinfo = seqinfo, ...)
}

## -----------------------------------------------------------------------------
setMethod(
  f = "getDataTrack",
  signature = signature(x = "ExampleSequenceData"),
  definition = function(x, name, ...) {
    ###
  }
)
setMethod(
  f = "getDataTrack",
  signature = signature(x = "ModExample"),
  definition = function(x, name, type, ...) {
  }
)
setMethod(
  f = "plotDataByCoord",
  signature = signature(x = "ModExample", coord = "GRanges"),
  definition = function(x, coord, type = "score", window.size = 15L, ...) {
  }
)
setMethod(
  f = "plotData",
  signature = signature(x = "ModExample"),
  definition = function(x, name, from, to, type = "score", ...) {
  }
)
setMethod(
  f = "plotDataByCoord",
  signature = signature(x = "ModSetExample", coord = "GRanges"),
  definition = function(x, coord, type = "score", window.size = 15L, ...) {
  }
)
setMethod(
  f = "plotData",
  signature = signature(x = "ModSetExample"),
  definition = function(x, name, from, to, type = "score", ...) {
  }
)

## -----------------------------------------------------------------------------
sessionInfo()

