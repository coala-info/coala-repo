# Code example from 'GenomicFiles' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("GenomicFiles")

## ----quick_start-load, results="hide", message=FALSE--------------------------
library(GenomicFiles)

## ----quick_start-ranges-------------------------------------------------------
gr <- GRanges("chr14", IRanges(c(19411500 + (1:5)*20), width=10))

## ----class-bam-data-----------------------------------------------------------
library(RNAseqData.HNRNPC.bam.chr14)
fls <- RNAseqData.HNRNPC.bam.chr14_BAMFILES

## ----quick_start-MAP----------------------------------------------------------
MAP <- function(range, file, ...) {
    requireNamespace("Rsamtools")
    Rsamtools::pileup(file, scanBamParam=Rsamtools::ScanBamParam(which=range))
} 

## ----quick_start-reduceByFile-------------------------------------------------
se <- reduceByFile(gr, fls, MAP, summarize=TRUE)
se 

## ----quick_start-assays-------------------------------------------------------
dim(assays(se)$data) ## ranges x files

## ----quick_start-MAP-REDUCE-reduceByRange-------------------------------------
REDUCE <- function(mapped, ...) {
    cmb = do.call(rbind, mapped)
    xtabs(count ~ pos + nucleotide, cmb)
}
lst <- reduceByRange(gr, fls, MAP, REDUCE, iterate=FALSE)

## ----quick_start-result-------------------------------------------------------
head(lst[[1]], 3)

## ----overview-GenomicFiles----------------------------------------------------
GenomicFiles(gr, fls)

## ----fig1, echo = FALSE, fig.cap = "Mechanics of `reduceByRange` and `reduceRanges`"----
knitr::include_graphics("reduceByRange_flow.png")

## ----fig2, echo = FALSE, fig.cap = "Mechanics of `reduceByFile` and `reduceFiles`"----
knitr::include_graphics("reduceByFile_flow.png")

## ----pileups-ranges-----------------------------------------------------------
gr <- GRanges("chr14", IRanges(c(19411677, 19659063, 105421963,
                                 105613740), width=20))

## ----pileups-MAP--------------------------------------------------------------
MAP <- function(range, file, ...) {
    requireNamespace("deepSNV")
    ct <- deepSNV::bam2R(file,
                         GenomeInfoDb::seqlevels(range),
                         GenomicRanges::start(range),
                         GenomicRanges::end(range), q=0)
    ct[, c("A", "T", "C", "G", "a", "t", "c", "g")]
}

## ----pileups-REDUCE-----------------------------------------------------------
REDUCE <- function(mapped, ...) {
    Reduce("+", mapped)
}

## ----pileups-reduceByRange, message=FALSE-------------------------------------
pile2 <- reduceByRange(gr, fls, MAP, REDUCE)
length(pile2)
elementNROWS(pile2)

## ----pileups-res, warning=FALSE-----------------------------------------------
head(pile2[[1]])

## ----ttest-ranges, warning=FALSE----------------------------------------------
roi <- GRanges("chr14", IRanges(c(19411677, 19659063, 105421963,
               105613740), width=20))

## ----ttest-group--------------------------------------------------------------
grp <- factor(rep(c("A","B"), each=length(fls)/2))

## ----ttest-MAP----------------------------------------------------------------
MAP <- function(range, file, ...) {
    requireNamespace("GenomicAlignments")
    param <- Rsamtools::ScanBamParam(which=range)
    as.numeric(unlist(
        GenomicAlignments::coverage(file, param=param)[range], use.names=FALSE))
    }

## ----ttest-REDUCE-------------------------------------------------------------
REDUCE <- function(mapped, ..., grp) {
    mat = simplify2array(mapped)
    idx = which(rowSums(mat) != 0)
    df = genefilter::rowttests(mat[idx,], grp)
    cbind(offset = idx - 1, df)
}

## ----ttest-results, eval=FALSE------------------------------------------------
# ttest <- reduceByRange(roi, fls, MAP, REDUCE, iterate=FALSE, grp=grp)

## ----junctions-ranges---------------------------------------------------------
gr <- GRanges("chr14", IRanges(c(19100000, 106000000), width=1e7))

## ----junctions-MAP------------------------------------------------------------
MAP <- function(range, file, ...) {
     requireNamespace("GenomicAlignments") ## for readGAlignments()
                                           ## ScanBamParam()
     param = Rsamtools::ScanBamParam(which=range)
     gal = GenomicAlignments::readGAlignments(file, param=param)
     table(GenomicAlignments::njunc(gal))
}

## ----junctions-GenomicFiles---------------------------------------------------
gf <- GenomicFiles(gr, fls)
gf

## ----junctions-counts1--------------------------------------------------------
counts1 <- reduceByFile(gf[,1:3], MAP=MAP)
length(counts1) ## 3 files
elementNROWS(counts1) ## 2 ranges

## ----junctions-counts1-show---------------------------------------------------
counts1[[1]]

## ----junctions-REDUCE---------------------------------------------------------
REDUCE <- function(mapped, ...)
    sum(sapply(mapped, "[", "1"))
    reduceByFile(gr, fls, MAP, REDUCE)

## ----junctions-counts2--------------------------------------------------------
counts2 <- reduceFiles(gf[,1:3], MAP=MAP)

## ----junctions-counts2-show---------------------------------------------------
## reduceFiles returns counts for all ranges.
counts2[[1]]
## reduceByFile returns counts for each range separately.
counts1[[1]]

## ----coverage1-tiles----------------------------------------------------------
chr14_seqlen <- seqlengths(seqinfo(BamFileList(fls))["chr14"])
tiles <- tileGenome(chr14_seqlen, ntile=5)

## ----coverage1-tiles-show-----------------------------------------------------
tiles

## ----coverage1-MAP------------------------------------------------------------
MAP = function(range, file, ...) {
    requireNamespace("GenomicAlignments") ## for ScanBamParam() and coverage()
    param = Rsamtools::ScanBamParam(which=range)
    rle = GenomicAlignments::coverage(file, param=param)[range]
    c(width = GenomicRanges::width(range),
      sum = sum(S4Vectors::runLength(rle) * S4Vectors::runValue(rle)))
}

## ----coverage1-REDUCE---------------------------------------------------------
REDUCE = function(mapped, ...) {
    Reduce(function(i, j) Map("+", i, j), mapped)
}

## ----coverage1-results, eval=FALSE--------------------------------------------
# cvg1 <- reduceByFile(tiles, fls, MAP, REDUCE, iterate=TRUE)

## ----coverage2-MAP------------------------------------------------------------
MAP = function(range, file, ...) {
    requireNamespace("GenomicAlignments")  ## for ScanBamParam() and coverage()
    GenomicAlignments::coverage(
        file,
        param=Rsamtools::ScanBamParam(which=range))[range]
}

## ----coverage2-REDUCE---------------------------------------------------------
REDUCE = function(mapped, ...) {
    sapply(mapped, Reduce, f = "+")
}

## ----coverage2-results--------------------------------------------------------
cvg2 <- reduceFiles(unlist(tiles), fls, MAP, REDUCE)

## ----coverage2-show-----------------------------------------------------------
cvg2[1]

## ----coverage3-MAP------------------------------------------------------------
MAP = function(range, file, ...) {
    requireNamespace("BiocParallel")  ## for bplapply()
    nranges = 2
    idx = split(seq_along(range), ceiling(seq_along(range)/nranges))
    BiocParallel::bplapply(idx, 
        function(i, range, file) {
            requireNamespace("GenomicAlignments")  ## ScanBamParam(), coverage()
            chunk = range[i]
            param = Rsamtools::ScanBamParam(which=chunk)
            cvg = GenomicAlignments::coverage(file, param=param)[chunk]
            Reduce("+", cvg)            ## collapse coverage within chunks
        }, range, file)
}

## ----coverage3-REDUCE---------------------------------------------------------
REDUCE = function(mapped, ...) {
    sapply(mapped, Reduce, f = "+")
}

## ----coverage3-Results, eval=FALSE--------------------------------------------
# cvg3 <- reduceFiles(unlist(tiles), fls, MAP, REDUCE)

## ----reduceByYield-YIELD------------------------------------------------------
library(GenomicAlignments)
bf <- BamFile(fls[1], yieldSize=100000)
YIELD <- function(x, ...) readGAlignments(x)

## ----reduceByYield-MAP-REDUCE-------------------------------------------------
gr <- unlist(tiles, use.names=FALSE)
MAP <- function(value, gr, ...) {
    requireNamespace("GenomicRanges") ## for countOverlaps()
    GenomicRanges::countOverlaps(gr, value)
    }
REDUCE <- `+`

## ----reduceByYield-DONE-------------------------------------------------------
DONE <- function(value) length(value) == 0L

## ----reduceByYield-bplapply---------------------------------------------------
FUN <- function(file, gr, YIELD, MAP, REDUCE, tiles, ...) {
    requireNamespace("GenomicAlignments") ## for BamFile, readGAlignments()
    requireNamespace("GenomicFiles") ## for reduceByYield()
    gr <- unlist(tiles, use.names=FALSE)
    bf <- Rsamtools::BamFile(file, yieldSize=100000)
    YIELD <- function(x, ...) GenomicAlignments::readGAlignments(x)
    MAP <- function(value, gr, ...) {
        requireNamespace("GenomicRanges") ## for countOverlaps()
        GenomicRanges::countOverlaps(gr, value)
    }
    REDUCE <- `+`
    GenomicFiles::reduceByYield(bf, YIELD, MAP, REDUCE, gr=gr, parallel=FALSE)
}

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

