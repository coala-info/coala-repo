# Code example from 'RNAmodR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
  library(rtracklayer)
  library(Rsamtools)
  library(GenomicFeatures)
  library(txdbmaker)
  library(RNAmodR.Data)
  library(RNAmodR)
})

## ----eval = FALSE-------------------------------------------------------------
# library(rtracklayer)
# library(Rsamtools)
# library(GenomicFeatures)
# library(txdbmaker)
# library(RNAmodR.Data)
# library(RNAmodR)

## ----example_files, message=FALSE, results='hide'-----------------------------
annotation <- GFF3File(RNAmodR.Data.example.gff3())
sequences <- RNAmodR.Data.example.fasta()
files <- c(Treated = RNAmodR.Data.example.bam.1(),
           Treated = RNAmodR.Data.example.bam.2(),
           Treated = RNAmodR.Data.example.bam.3())

## ----seqdata------------------------------------------------------------------
seqdata <- End5SequenceData(files, annotation = annotation, 
                            sequences = sequences)
seqdata

## ----seqdata_functions, message=FALSE, results='hide'-------------------------
names(seqdata) # matches the transcript names as returned by a TxDb object
colnames(seqdata) # returns a CharacterList of all column names
bamfiles(seqdata)
ranges(seqdata) # generate from a TxDb object
sequences(seqdata)
seqinfo(seqdata)

## ----seqdata2-----------------------------------------------------------------
seqdata[1]
sdf <- seqdata[[1]]
sdf

## ----seqdata2_functions, message=FALSE, results='hide'------------------------
names(sdf) # this returns the columns names of the data
ranges(sdf)
sequences(sdf)

## ----seqdata2_subset----------------------------------------------------------
sdf[,1:2]
sdf[1:3,]

## ----modifier1----------------------------------------------------------------
mi <- ModInosine(files, annotation = annotation, sequences = sequences)

## ----modifier1_functions, message=FALSE, results='hide'-----------------------
names(mi) # matches the transcript names as returned by a TxDb object
bamfiles(mi)
ranges(mi) # generated from a TxDb object
sequences(mi)
seqinfo(mi)
sequenceData(mi) # returns the SequenceData 

## ----settings-----------------------------------------------------------------
settings(mi)
settings(mi,"minScore")
settings(mi) <- list(minScore = 0.5)
settings(mi,"minScore")

## ----message=FALSE------------------------------------------------------------
sequences <- RNAmodR.Data.example.AAS.fasta()
annotation <- GFF3File(RNAmodR.Data.example.AAS.gff3())
files <- list("SampleSet1" = c(treated = RNAmodR.Data.example.wt.1(),
                               treated = RNAmodR.Data.example.wt.2(),
                               treated = RNAmodR.Data.example.wt.3()),
              "SampleSet2" = c(treated = RNAmodR.Data.example.bud23.1(),
                               treated = RNAmodR.Data.example.bud23.2()),
              "SampleSet3" = c(treated = RNAmodR.Data.example.trm8.1(),
                               treated = RNAmodR.Data.example.trm8.2()))

## ----modifierset1-------------------------------------------------------------
msi <- ModSetInosine(files, annotation = annotation, sequences = sequences)

## ----modifierset2-------------------------------------------------------------
names(msi)
msi[[1]]

## ----modifierset1_functions, message=FALSE, results='hide'--------------------
bamfiles(msi)
ranges(msi) # generate from a TxDb object
sequences(msi)
seqinfo(msi)

## ----results1-----------------------------------------------------------------
mod <- modifications(msi)
mod[[1]]

## ----results2-----------------------------------------------------------------
mod <- modifications(msi, perTranscript = TRUE)
mod[[1]]

## ----coord--------------------------------------------------------------------
mod <- modifications(msi)
coord <- unique(unlist(mod))
coord$score <- NULL
coord$sd <- NULL
compareByCoord(msi,coord)

## -----------------------------------------------------------------------------
txdb <- makeTxDbFromGFF(annotation)
alias <- data.frame(tx_id = names(id2name(txdb)),
                    name = id2name(txdb))

## ----plot1, fig.cap="Heatmap for identified Inosine positions.", fig.asp=1----
plotCompareByCoord(msi, coord, alias = alias)

## ----plot2, fig.cap="Heatmap for identified Inosine positions with normalized scores.", fig.asp=1----
plotCompareByCoord(msi[c(3,1,2)], coord, alias = alias, normalize = "SampleSet3",
                   perTranscript = TRUE)

## ----plot3, fig.cap="Scores along a transcript containing a A to G conversion indicating the presence of Inosine.", fig.asp=1----
plotData(msi, "2", from = 10L, to = 45L, alias = alias) # showSequenceData = FALSE

## ----plot4, fig.cap="Scores along a transcript containing a A to G conversion indicating the presence of Inosine. This figure includes the detailed pileup sequence data.", fig.asp=1.2----
plotData(msi[1:2], "2", from = 10L, to = 45L, showSequenceData = TRUE, alias = alias)

## ----plot5, fig.cap="TPR vs. FPR plot.", fig.asp=1----------------------------
plotROC(msi, coord)

## -----------------------------------------------------------------------------
stats <- stats(msi)
stats
stats[["SampleSet1"]]
stats[["SampleSet1"]][["treated"]]

## ----plot6, echo=FALSE, fig.cap="Distribution of lengths for reads used in the analysis", fig.asp=1----
plotData <- lapply(stats,function(set){
  ans <- lapply(lapply(lapply(set,"[[","used_distro"),"[[","chr1"),"[[","1")
  names <- unique(unlist(lapply(ans,names), use.names = FALSE))
  ans <- lapply(ans,function(a){
    a[names[!(names %in% names(a))]] <- 0
    a <- a/matrixStats::colMaxs(as.matrix(a))
    a
  })
  ans <- reshape2::melt(data.frame(c(list(length = as.integer(names)),ans)),
                        id.vars = "length")
  ans
})
plotData <- Reduce("rbind",Map(function(pd,group){pd$group <- group;pd},
                               plotData,names(plotData)))
ggplot2::ggplot(plotData) + 
  ggplot2::geom_bar(mapping = ggplot2::aes(x = length, y = value, fill = group), 
           stat = "identity",
           position = "dodge")

## -----------------------------------------------------------------------------
sessionInfo()

