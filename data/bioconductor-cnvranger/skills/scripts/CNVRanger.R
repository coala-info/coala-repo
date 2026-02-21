# Code example from 'CNVRanger' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
suppressPackageStartupMessages({ 
    library(CNVRanger)
    library(AnnotationHub)
    library(regioneR)
    library(BSgenome.Btaurus.UCSC.bosTau6.masked)
    library(SummarizedExperiment)
    library(curatedTCGAData)
    library(TCGAutils)
    library(Gviz)
})

## ----oview, echo=FALSE, fig.wide=TRUE-----------------------------------------
knitr::include_graphics("../man/figures/CNVRanger.png")

## ----input, echo=FALSE, fig.wide=TRUE-----------------------------------------
knitr::include_graphics("../man/figures/Input.png")

## ----lib----------------------------------------------------------------------
library(CNVRanger)

## ----readCalls----------------------------------------------------------------
data.dir <- system.file("extdata", package="CNVRanger")
call.file <- file.path(data.dir, "Silva16_PONE_CNV_calls.csv")
calls <- read.csv(call.file, as.is=TRUE)
nrow(calls)
head(calls)

## ----nrSamples----------------------------------------------------------------
length(unique(calls[,"NE_id"]))

## ----cnvCalls-----------------------------------------------------------------
grl <- GenomicRanges::makeGRangesListFromDataFrame(calls, 
    split.field="NE_id", keep.extra.columns=TRUE)
grl

## ----sortCalls----------------------------------------------------------------
grl <- GenomicRanges::sort(grl)
grl

## ----RaggedExperiment---------------------------------------------------------
ra <- RaggedExperiment::RaggedExperiment(grl)
ra

## ----RaggedExperiment-assay---------------------------------------------------
RaggedExperiment::assay(ra[1:5,1:5])

## ----RaggedExperiment-colData-------------------------------------------------
weight <- rnorm(ncol(ra), mean=1100, sd=100)
fcr <- rnorm(ncol(ra), mean=6, sd=1.5)
RaggedExperiment::colData(ra)$weight <- round(weight, digits=2)
RaggedExperiment::colData(ra)$fcr <- round(fcr, digits=2)
RaggedExperiment::colData(ra)

## ----summarization, echo=FALSE, out.width = "40%", out.extra='style="float:right; padding:10px"'----
knitr::include_graphics("../man/figures/Summarization.png")

## ----cnvrs--------------------------------------------------------------------
cnvrs <- populationRanges(grl, density=0.1)
cnvrs

## ----cnvrsRO------------------------------------------------------------------
ro.cnvrs <- populationRanges(grl[1:100], mode="RO", ro.thresh=0.51)
ro.cnvrs

## ----gistic-------------------------------------------------------------------
cnvrs <- populationRanges(grl, density=0.1, est.recur=TRUE)
cnvrs

## ----recurr-------------------------------------------------------------------
subset(cnvrs, pvalue < 0.05)

## ----recurrViz----------------------------------------------------------------
plotRecurrentRegions(cnvrs, genome="bosTau6", chr="chr1")

## ----overlap, echo=FALSE, out.width = "40%", out.extra='style="float:right; padding:10px"'----
knitr::include_graphics("../man/figures/Overlap.png")

## ----getBtGenes---------------------------------------------------------------
library(AnnotationHub)
ah <- AnnotationHub::AnnotationHub()
ahDb <- AnnotationHub::query(ah, pattern = c("Bos taurus", "EnsDb"))
ahDb

## ----getBtGenes2--------------------------------------------------------------
ahEdb <- ahDb[["AH60948"]]
bt.genes <- ensembldb::genes(ahEdb)
GenomeInfoDb::seqlevelsStyle(bt.genes) <- "UCSC"
bt.genes

## ----formatBtGenes------------------------------------------------------------
sel.genes <- subset(bt.genes, seqnames %in% paste0("chr", 1:2))
sel.genes <- subset(sel.genes, gene_biotype == "protein_coding")
sel.cnvrs <- subset(cnvrs, seqnames %in% paste0("chr", 1:2))

## ----findOlaps----------------------------------------------------------------
olaps <- GenomicRanges::findOverlaps(sel.genes, sel.cnvrs, ignore.strand=TRUE)
qh <- S4Vectors::queryHits(olaps)
sh <- S4Vectors::subjectHits(olaps)
cgenes <- sel.genes[qh]
cgenes$type <- sel.cnvrs$type[sh]
subset(cgenes, select = "type")

## ----vizOlaps-----------------------------------------------------------------
cnvOncoPrint(grl, cgenes)

## ----ovlpTest, warning=FALSE--------------------------------------------------
library(regioneR)
library(BSgenome.Btaurus.UCSC.bosTau6.masked)
res <- regioneR::overlapPermTest(A=sel.cnvrs, B=sel.genes, ntimes=100, 
    genome="bosTau6", mask=NA, per.chromosome=TRUE, count.once=TRUE)
res

## ----permDist-----------------------------------------------------------------
summary(res[[1]]$permuted)

## ----vizPermTest--------------------------------------------------------------
plot(res)

## ----expression, echo=FALSE, out.width = "40%", out.extra='style="float:right; padding:10px"'----
knitr::include_graphics("../man/figures/Expression.png")

## ----rseqdata-----------------------------------------------------------------
rseq.file <- file.path(data.dir, "counts_cleaned.txt")
rcounts <- read.delim(rseq.file, row.names=1, stringsAsFactors=FALSE)
rcounts <- as.matrix(rcounts)
dim(rcounts)
rcounts[1:5, 1:5]

## ----rse----------------------------------------------------------------------
library(SummarizedExperiment)
rranges <- GenomicRanges::granges(sel.genes)[rownames(rcounts)]
rse <- SummarizedExperiment(assays=list(rcounts=rcounts), rowRanges=rranges)
rse

## ----cnvEQTL------------------------------------------------------------------
res <- cnvEQTL(cnvrs, grl, rse, window = "1Mbp", verbose = TRUE)
res

## ----tcgaSetup, message=FALSE-------------------------------------------------
library(curatedTCGAData)
gbm <- curatedTCGAData::curatedTCGAData("GBM",
        assays=c("GISTIC_Peaks", "CNVSNP", "RNASeq2GeneNorm"),
        version = "1.1.38",
        dry.run=FALSE)
gbm

## ----tcgaGeneAnno, message=FALSE----------------------------------------------
library(TCGAutils)
gbm <- TCGAutils::symbolsToRanges(gbm, unmapped=FALSE)
for(i in 1:3) 
{
    rr <- rowRanges(gbm[[i]])
    GenomeInfoDb::genome(rr) <- "NCBI37"
    GenomeInfoDb::seqlevelsStyle(rr) <- "UCSC"
    ind <- as.character(seqnames(rr)) %in% c("chr1", "chr2")
    rowRanges(gbm[[i]]) <- rr
    gbm[[i]] <- gbm[[i]][ind,]
}
gbm

## ----gbmIntersect-------------------------------------------------------------
gbm <- MultiAssayExperiment::intersectColumns(gbm)
TCGAutils::sampleTables(gbm)
data(sampleTypes, package="TCGAutils")
sampleTypes
gbm <- TCGAutils::TCGAsplitAssays(gbm, sampleCodes="01")
gbm

## ----segmean------------------------------------------------------------------
ind <- grep("CNVSNP", names(gbm))
head( mcols(gbm[[ind]]) )
summary( mcols(gbm[[ind]])$Segment_Mean )

## ----lr2int, eval=FALSE-------------------------------------------------------
# round( (2^lr) * 2)

## ----transformToStates--------------------------------------------------------
smean <- mcols(gbm[[ind]])$Segment_Mean
state <- round(2^smean * 2)
state[state > 4] <- 4
mcols(gbm[[ind]])$state <- state
gbm[[ind]] <- gbm[[ind]][state != 2,]
mcols(gbm[[ind]]) <- mcols(gbm[[ind]])[,3:1]
table(mcols(gbm[[ind]])$state)

## ----gbmEQTL------------------------------------------------------------------
res <- cnvEQTL(cnvrs="01_GBM_GISTIC_Peaks-20160128", 
    calls="01_GBM_CNVSNP-20160128", 
    rcounts="01_GBM_RNASeq2GeneNorm-20160128_ranged", 
    data=gbm, window="1Mbp", verbose=TRUE)
res

## ----plotEQTL-----------------------------------------------------------------
res[2]
(r <- GRanges(names(res)[2]))
plotEQTL(cnvr=r, genes=res[[2]], genome="hg19", cn="CN1")

## ----phenotype, echo=FALSE, out.width = "40%", out.extra='style="float:right; padding:10px"'----
knitr::include_graphics("../man/figures/Phenotype.png")

## ----readCallsGWAS------------------------------------------------------------
cnv.loc <- file.path(data.dir, "CNVOut.txt") 
cnv.calls <- read.delim(cnv.loc, as.is=TRUE) 
head(cnv.calls)

## ----calls2grl----------------------------------------------------------------
cnv.calls <- GenomicRanges::makeGRangesListFromDataFrame(cnv.calls, 
    split.field="sample.id", keep.extra.columns=TRUE)
sort(cnv.calls)

## ----phenoData----------------------------------------------------------------
phen.loc <- file.path(data.dir, "Pheno.txt")
colData <- read.delim(phen.loc, as.is=TRUE)
head(colData)

## ----importPhen---------------------------------------------------------------
mcols(cnv.calls) <- colData
re <- RaggedExperiment::RaggedExperiment(cnv.calls)
re

## ----map----------------------------------------------------------------------
map.loc <- file.path(data.dir, "MapPenn.txt")
map.df <- read.delim(map.loc, as.is=TRUE)
head(map.df)

## ----importPhenRagged---------------------------------------------------------
phen.info <- setupCnvGWAS("example", cnv.out.loc=re, map.loc=map.loc)
phen.info

## ----Wdir---------------------------------------------------------------------
all.paths <- phen.info$all.paths
all.paths

## ----CNVGWASNames-------------------------------------------------------------
# Define chr correspondence to numeric
chr.code.name <- data.frame(   
                    V1 = c(16, 25, 29:31), 
                    V2 = c("1A", "4A", "25LG1", "25LG2", "LGE22"))

## ----CNVGWA-------------------------------------------------------------------
segs.pvalue.gr <- cnvGWAS(phen.info, chr.code.name=chr.code.name, method.m.test="none")
segs.pvalue.gr

## ----echo=FALSE, fig.cap="Definition of CNV segments. The figure shows construction of a CNV segment from 4 individual CNV calls in a CNV region based on pairwise copy number concordance between adjacent probes.", out.width = '100%'----
knitr::include_graphics("../man/figures/CNVsegments.png")

## ----manh---------------------------------------------------------------------
## Define the chromosome order in the plot
order.chrs <- c(1:24, "25LG1", "25LG2", 27:28, "LGE22", "1A", "4A")

## Chromosome sizes
chr.size.file <- file.path(data.dir, "Parus_major_chr_sizes.txt")
chr.sizes <- scan(chr.size.file)
chr.size.order <- data.frame(chr=order.chrs, sizes=chr.sizes, stringsAsFactors=FALSE)

## Plot a pdf file with a manhatthan within the 'Results' workfolder
plotManhattan(all.paths, segs.pvalue.gr, chr.size.order, plot.pdf=FALSE)

## ----prodGDS------------------------------------------------------------------
## Create a GDS file in disk and export the SNP probe positions
probes.cnv.gr <- generateGDS(phen.info, chr.code.name=chr.code.name)
probes.cnv.gr

## Run GWAS with existent GDS file
segs.pvalue.gr <- cnvGWAS(phen.info, chr.code.name=chr.code.name, produce.gds=FALSE)

## ----importLRR----------------------------------------------------------------
# List files to import LRR/BAF 
files <- list.files(data.dir, pattern = "\\.cnv.txt.adjusted$")
samples <- sub(".cnv.txt.adjusted$", "", files)
samples <- sub("^GT","", samples)
sample.files <- data.frame(file.names=files, sample.names=samples)
 
# All missing samples will have LRR = '0' and BAF = '0.5' in all SNPs listed in the GDS file
importLrrBaf(all.paths, data.dir, sample.files, verbose=FALSE)

# Read the GDS to check if the LRR/BAF nodes were added
cnv.gds <- file.path(all.paths[1], "CNV.gds")
(genofile <- SNPRelate::snpgdsOpen(cnv.gds, allow.fork=TRUE, readonly=FALSE))
gdsfmt::closefn.gds(genofile)

# Run the CNV-GWAS with existent GDS
segs.pvalue.gr <- cnvGWAS(phen.info, chr.code.name=chr.code.name, produce.gds=FALSE, run.lrr=TRUE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

