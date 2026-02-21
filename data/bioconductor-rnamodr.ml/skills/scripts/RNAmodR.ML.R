# Code example from 'RNAmodR.ML' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
  library(rtracklayer)
  library(GenomicRanges)
  library(RNAmodR.ML)
  library(RNAmodR.Data)
})

## ----eval = FALSE-------------------------------------------------------------
# library(rtracklayer)
# library(GenomicRanges)
# library(RNAmodR.ML)
# library(RNAmodR.Data)

## -----------------------------------------------------------------------------
setClass("ModMLExample",
         contains = c("RNAModifierML"),
         prototype = list(mod = c("D"),
                          score = "score",
                          dataType = c("PileupSequenceData",
                                       "CoverageSequenceData"),
                          mlModel = character(0)))
# constructor function for ModMLExample
ModMLExample <- function(x, annotation = NA, sequences = NA, seqinfo = NA,
                           ...){
  RNAmodR:::Modifier("ModMLExample", x = x, annotation = annotation,
                     sequences = sequences, seqinfo = seqinfo, ...)
}

setClass("ModSetMLExample",
         contains = "ModifierSet",
         prototype = list(elementType = "ModMLExample"))
# constructor function for ModSetMLExample
ModSetMLExample <- function(x, annotation = NA, sequences = NA, seqinfo = NA,
                              ...){
  RNAmodR:::ModifierSet("ModMLExample", x, annotation = annotation,
                        sequences = sequences, seqinfo = seqinfo, ...)
}

## -----------------------------------------------------------------------------
setMethod(
  f = "aggregateData",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      aggregate_example(x)
    }
)

## ----include=FALSE------------------------------------------------------------
annotation <- GFF3File(RNAmodR.Data.example.gff3())
sequences <- RNAmodR.Data.example.fasta()
files <- list("wt" = c(treated = RNAmodR.Data.example.bam.1(),
                       treated = RNAmodR.Data.example.bam.2(),
                       treated = RNAmodR.Data.example.bam.3()))

## -----------------------------------------------------------------------------
me <-  ModMLExample(files[[1]], annotation, sequences)

## -----------------------------------------------------------------------------
data("dmod",package = "RNAmodR.ML")
# we just select the next U position from known positions
nextUPos <- function(gr){
  nextU <- lapply(seq.int(1L,2L),
                  function(i){
                    subseq <- subseq(sequences(me)[dmod$Parent], start(dmod)+3L)
                    pos <- start(dmod) + 2L + 
                      vapply(strsplit(as.character(subseq),""),
                    function(y){which(y == "U")[i]},integer(1))
                    ans <- dmod
                    ranges(ans) <- IRanges(start = pos, width = 1L)
                    ans
                  })
  nextU <- do.call(c,nextU)
  nextU$mod <- NULL
  unique(nextU)
}
nondmod <- nextUPos(dmod)
nondmod <- nondmod[!(nondmod %in% dmod)]
coord <- unique(c(dmod,nondmod))
coord <- coord[order(as.integer(coord$Parent))]

## -----------------------------------------------------------------------------
trainingData <- trainingData(me,coord)
trainingData <- unlist(trainingData, use.names = FALSE)
# converting logical labels to integer
trainingData$labels <- as.integer(trainingData$labels)

## -----------------------------------------------------------------------------
library(ranger)
model <- ranger(labels ~ ., data.frame(trainingData))

## -----------------------------------------------------------------------------
setClass("ModifierMLexample",
         contains = c("ModifierMLranger"),
         prototype = list(model = model))
ModifierMLexample <- function(...){
  new("ModifierMLexample")
}
mlmodel <- ModifierMLexample()

## -----------------------------------------------------------------------------
getMethod("useModel", c("ModifierMLranger","ModifierML"))

## -----------------------------------------------------------------------------
setMLModel(me) <- mlmodel

## -----------------------------------------------------------------------------
setMethod(f = "useMLModel",
          signature = signature(x = "ModMLExample"),
          definition =
            function(x){
              predictions <- useModel(getMLModel(x), x)
              data <- getAggregateData(x)
              unlisted_data <- unlist(data, use.names = FALSE)
              unlisted_data$score <- unlist(predictions)
              x@aggregate <- relist(unlisted_data,data)
              x
            }
)

## -----------------------------------------------------------------------------
me <- aggregate(me, force = TRUE)

## ----plot1, fig.cap="Performance of the maching learning model to distinguish unmodified from modified nucleotides.", fig.asp=1.5, dev="png"----
plotROC(me, dmod)

## -----------------------------------------------------------------------------
setMethod(
  f = "findMod",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      find_mod_example(x, 25L)
    }
)

## -----------------------------------------------------------------------------
rm(me)
setClass("ModMLExample",
         contains = c("RNAModifierML"),
         prototype = list(mod = c("D"),
                          score = "score",
                          dataType = c("PileupSequenceData",
                                       "CoverageSequenceData"),
                          mlModel = "ModifierMLexample"))
me <-  ModMLExample(files[[1]], annotation, sequences)

## -----------------------------------------------------------------------------
mod <- modifications(me)
mod <- split(mod, factor(mod$Parent,levels = unique(mod$Parent)))
mod

## -----------------------------------------------------------------------------
options(ucscChromosomeNames=FALSE)

## ----plot2, fig.cap="Visualization of sequence data", dev="png"---------------
plotDataByCoord(sequenceData(me),mod[["4"]][1])

## -----------------------------------------------------------------------------
nonValidMod <- mod[c("1","4")]
nonValidMod[["18"]] <- nonValidMod[["18"]][2]
nonValidMod[["26"]] <- nonValidMod[["26"]][2]
nonValidMod <- unlist(nonValidMod)
nonValidMod <- nonValidMod[,"Parent"]
coord <- unique(c(dmod,nondmod,nonValidMod))
coord <- coord[order(as.integer(coord$Parent))]

## -----------------------------------------------------------------------------
trainingData <- trainingData(me,coord)
trainingData <- unlist(trainingData, use.names = FALSE)
trainingData$labels <- as.integer(trainingData$labels)

## -----------------------------------------------------------------------------
model2 <- ranger(labels ~ ., data.frame(trainingData), num.trees = 2000)
setClass("ModifierMLexample2",
         contains = c("ModifierMLranger"),
         prototype = list(model = model2))
ModifierMLexample2 <- function(...){
  new("ModifierMLexample2")
}
mlmodel2 <- ModifierMLexample2()
me2 <- me
setMLModel(me2) <- mlmodel2
me2 <- aggregate(me2, force = TRUE)

## ----plot3, fig.cap="Performance aggregation of multiple samples and strategies."----
plotROC(me2, dmod, score="score")

## -----------------------------------------------------------------------------
setMethod(
  f = "findMod",
  signature = signature(x = "ModMLExample"),
  definition =
    function(x){
      find_mod_example(x, 25L)
    }
)
me2 <- modify(me2, force = TRUE)
modifications(me2)

## -----------------------------------------------------------------------------
mse <- ModSetMLExample(list(one = me, two = me2))

## ----plot4, fig.cap="Performance average across models", dev="png"------------
plotROC(mse, dmod, score= "score",
        plot.args = list(avg = "threshold", spread.estimate = "stderror"))

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

