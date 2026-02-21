# Code example from 'RiboDiPA' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
library(RiboDiPA)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RiboDiPA")

## ----warning=FALSE, message=FALSE---------------------------------------------
## Download sample files from GitHub
library(BiocFileCache)
file_names <- c("WT1.bam", "WT2.bam", "MUT1.bam", "MUT2.bam", "eg.gtf")
url <- "https://github.com/jipingw/RiboDiPA-data/raw/master/"
bfc <- BiocFileCache()
bam_path <- bfcrpath(bfc,paste0(url,file_names))

## ----warning=FALSE, message=FALSE---------------------------------------------
## Make the class label for the experiment
classlabel <- data.frame(
    condition = c("mutant", "mutant", "wildtype", "wildtype"),
    comparison = c(2, 2, 1, 1)
)
rownames(classlabel) <- c("mutant1","mutant2","wildtype1","wildtype2")

## ----warning=FALSE, message=FALSE---------------------------------------------
## Run the RiboDiPA pipeline with default parameters
result.wrp <- RiboDiPA(bam_path[1:4], bam_path[5], classlabel, cores = 2)

## -----------------------------------------------------------------------------
## View the table of output from RiboDiPA
head(result.wrp$gene[order(result.wrp$gene$qvalue), ])

## ----warning=FALSE, message=FALSE---------------------------------------------
## Perform individual P-site mapping procedure
data.psite <- psiteMapping(bam_file_list = bam_path[1:4], 
    gtf_file = bam_path[5], psite.mapping = "auto", cores = 2)

## -----------------------------------------------------------------------------
## P-site mapping offset rule generated
data.psite$psite.mapping

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# ## Use user specified psite mapping offset rule
# offsets <- cbind(qwidth = c(28, 29, 30, 31, 32),
#     psite = c(18, 18, 18, 19, 19))
# data.psite2 <- psiteMapping(bam_path[1:4], bam_path[5],
#     psite.mapping = offsets, cores = 2)

## ----warning=FALSE, message=FALSE,eval=FALSE----------------------------------
# ## Merge the P-site data into bins with a fixed or an adaptive width
# data.binned <- dataBinning(data = data.psite$coverage, bin.width = 0,
#     zero.omit = FALSE, bin.from.5UTR = TRUE, cores = 2)

## ----warning=FALSE, message=FALSE,eval=FALSE----------------------------------
# ## Merge the P-site data on each codon
# data.codon <- dataBinning(data = data.psite$coverage, bin.width = 1,
#     zero.omit = FALSE, bin.from.5UTR = TRUE, cores = 2)

## ----warning=FALSE, message=FALSE,eval=FALSE----------------------------------
# ## Merge the P-site data on each exon and perform differential pattern analysis
# result.exon <- diffPatternTestExon(psitemap = data.psite,
#     classlabel = classlabel, method = c('gtxr', 'qvalue'))

## ----warning=FALSE, message=FALSE,eval=FALSE----------------------------------
# ## Perform differential pattern analysis
# result.pst <- diffPatternTest(data = data.binned,
#     classlabel = classlabel, method=c('gtxr', 'qvalue'))

## ----fig2, fig.height=6, fig.width=6, fig.align="center", results='hide'------
## Plot ribosome per nucleotide tracks of specified genes.
plotTrack(data = data.psite, genes.list = c("YDR050C", "YDR064W"),
    replicates = NULL, exons = FALSE)

## ----fig3, fig.height = 9, fig.width = 10, fig.align = "center",results='hide'----
## Plot binned ribosome tracks of siginificant genes: YDR086C and YDR210W.
## you can specify the thrshold to redefine the significant level
plotTest(result = result.pst, genes.list = NULL, threshold = 0.05) 

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# ##base-bair RPF track
# library(igvR)
# thred <- 0.05
# igv <- igvR()
# setBrowserWindowTitle(igv, "ribosome footprint track example")
# setGenome(igv, "saccer3")
# 
# data(data.psite)
# names.rep <- c("mutant1", "mutant2", "wildtype1", "wildtype2")
# tracks.bp <- bpTrack(data = data.psite, names.rep = names.rep,
#     genes.list = c("YDR050C", "YDR062W", "YDR064W"))
# 
# for(track.name in names.rep){
#     track.rep <- tracks.bp[[track.name]]
#     track <- GRangesQuantitativeTrack(trackName = paste(track.name, "bp"),
#         track.rep[,1], color = "green")
#     displayTrack(igv, track)
# }}
# 

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# ## bin track and test results
# data(result.pst)
# data(data.psite)
# tracks.bin <- binTrack(data = result.pst, exon.anno = data.psite$exons)
# 
# for(track.name in names(tracks.bin)){
#     track.rep <- tracks.bin[[track.name]]
#     resize(track.rep, width(track.rep) + 1)
#     track <- GRangesQuantitativeTrack(trackName = paste(track.name, "binned"),
#         track.rep[,1], color = "black")
#     displayTrack(igv, track)
# }
# 
# track.rep2 <- tracks.bin[[1]]
# sig.bin <- (values(track.rep2)[,5] <= thred)
# log10.padj <- - log10(values(track.rep2)[,5])
# mcols(track.rep2) <- data.frame(log10padj = log10.padj)
# track.rep2 <- track.rep2[which(sig.bin),]
# track <- GRangesQuantitativeTrack(trackName = "- log 10 of padj",
#     track.rep2, color = "red", trackHeight = 40)
# displayTrack(igv, track)

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# ## bin track and test results
# igv2 <- igvR()
# setBrowserWindowTitle(igv2, "ribosome footprint per exon example")
# setGenome(igv2, "saccer3")
# data(result.exon)
# tracks.exon <- exonTrack(data = result.exon, gene = "tY(GUA)D")
# for(track.name in names(tracks.exon)){
#     track.rep <- tracks.exon[[track.name]]
#     for(tx.name in names(track.rep)){
#         track.tx <- tracks.exon[[track.name]][[tx.name]]
#         track <- GRangesQuantitativeTrack(trackName =
#             paste(track.name, tx.name), track.tx[,1], color = track.name)
#         displayTrack(igv2, track)
#     }
# }

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

