# Code example from 'tximeta' vignette. See references/ for full tutorial.

## ----echo=FALSE, fig.alt="How tximeta works"----------------------------------
knitr::include_graphics("images/diagram.png")

## -----------------------------------------------------------------------------
dir <- system.file("extdata/salmon_dm", package="tximportData")
files <- file.path(dir, "SRR1197474", "quant.sf") 
file.exists(files)
coldata <- data.frame(files, names="SRR1197474", condition="A", stringsAsFactors=FALSE)
coldata

## ----eval=FALSE---------------------------------------------------------------
# library(tximeta)
# se <- tximeta(coldata)

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(GenomicFeatures)
  })

## -----------------------------------------------------------------------------
indexDir <- file.path(dir, "Dm.BDGP6.22.98_salmon-0.14.1")
fastaFTP <- c("ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP6.22.cdna.all.fa.gz",
              "ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/ncrna/Drosophila_melanogaster.BDGP6.22.ncrna.fa.gz")
gtfPath <- file.path(dir,"Drosophila_melanogaster.BDGP6.22.98.gtf.gz")
suppressPackageStartupMessages(library(tximeta))
makeLinkedTxome(indexDir=indexDir,
                source="LocalEnsembl",
                organism="Drosophila melanogaster",
                release="98",
                genome="BDGP6.22",
                fasta=fastaFTP,
                gtf=gtfPath,
                write=FALSE)

## ----message=FALSE------------------------------------------------------------
library(tximeta)

## -----------------------------------------------------------------------------
se <- tximeta(coldata)

## ----echo=FALSE---------------------------------------------------------------
dir2 <- system.file("extdata", package="tximeta")
tab <- read.csv(file.path(dir2, "hashtable.csv"),
                stringsAsFactors=FALSE)
release.range <- function(tab, source, organism) {
  tab.idx <- tab$organism == organism & tab$source == source
  rels <- tab$release[tab.idx]
  if (organism == "Mus musculus" & source == "GENCODE") {
    paste0("M", range(as.numeric(sub("M","",rels))))
  } else if (source == "RefSeq") {
    paste0("p", range(as.numeric(sub(".*p","",rels))))
  } else {
    range(as.numeric(rels))
  }
}
dat <- data.frame(
  source=rep(c("GENCODE","Ensembl","RefSeq"),c(2,3,2)),
  organism=c("Homo sapiens","Mus musculus",
             "Drosophila melanogaster")[c(1:2,1:3,1:2)]
)
rng <- t(sapply(seq_len(nrow(dat)), function(i)
  release.range(tab, dat[i,1], dat[i,2])))
dat$releases <- paste0(rng[,1], "-", rng[,2])
knitr::kable(dat)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(SummarizedExperiment))
colData(se)

## -----------------------------------------------------------------------------
assayNames(se)

## -----------------------------------------------------------------------------
rowRanges(se)

## -----------------------------------------------------------------------------
seqinfo(se)

## -----------------------------------------------------------------------------
edb <- retrieveDb(se)
class(edb)

## -----------------------------------------------------------------------------
se.exons <- addExons(se)
rowRanges(se.exons)[[1]]

## -----------------------------------------------------------------------------
gse <- summarizeToGene(se)
rowRanges(gse)

## ----eval=FALSE---------------------------------------------------------------
# # unevaluated code chunk
# gse <- summarizeToGene(se, assignRanges="abundant")

## ----echo=FALSE, fig.alt="Transcripts compared to whole gene extent"----------
knitr::include_graphics("images/assignRanges-abundant.png")

## -----------------------------------------------------------------------------
library(org.Dm.eg.db)
gse <- addIds(gse, "REFSEQ", gene=TRUE)
mcols(gse)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(DESeq2))
# here there is a single sample so we use ~1.
# expect a warning that there is only a single sample...
suppressWarnings({dds <- DESeqDataSet(gse, ~1)})
# ... see DESeq2 vignette

## ----eval=FALSE---------------------------------------------------------------
# # un-evaluated code
# library(fishpond)
# y <- se
# y <- scaleInfReps(y)
# y <- labelKeep(y)
# y <- swish(y, x="condition")
# # ... see Swish vignette in fishpond package

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(edgeR))
y <- makeDGEList(gse)
# ... see edgeR User's Guide for further steps

## -----------------------------------------------------------------------------
cts <- assays(gse)[["counts"]]
normMat <- assays(gse)[["length"]]
normMat <- normMat / exp(rowMeans(log(normMat)))
o <- log(calcNormFactors(cts/normMat)) + log(colSums(cts/normMat))
y <- DGEList(cts)
y <- scaleOffset(y, t(t(log(normMat)) + o))
# ... see edgeR User's Guide for further steps

## -----------------------------------------------------------------------------
gse <- summarizeToGene(se, countsFromAbundance="lengthScaledTPM")
library(limma)
y <- DGEList(assays(gse)[["counts"]])
# see limma User's Guide for further steps

## -----------------------------------------------------------------------------
metadata(gse)$countsFromAbundance 

## -----------------------------------------------------------------------------
names(metadata(se))
str(metadata(se)[["quantInfo"]])
str(metadata(se)[["txomeInfo"]])
str(metadata(se)[["tximetaInfo"]])
str(metadata(se)[["txdbInfo"]])

## -----------------------------------------------------------------------------
# specify 3 oarfish .quant files, quantified against an index of two .fa files:
# `--annotated gencode.v48.transcripts.fa.gz --novel novel.fa.gz`
dir <- system.file("extdata/oarfish", package="tximportData")
names <- paste0("rep", 2:4)
files <- file.path(dir, paste0("sgnex_h9_", names, ".quant.gz"))
coldata <- data.frame(files, names)
# read in the quantification data
se <- importData(coldata, type="oarfish")

## -----------------------------------------------------------------------------
class(se)
rowData(se)

## ----echo=FALSE, message=FALSE------------------------------------------------
# this chunk is required to avoiding downloading GTF file from FTP
gtf_dir <- system.file("extdata/gencode", package="tximportData")
gtf <- file.path(gtf_dir, "gencode.v48.annotation.gtf.gz")
makeLinkedTxome(
  digest = "6fc626c828b7a342ab0c6ff753055761989bf0e2306370e8766fedf45ad3adb3",
  indexName = "gencode.v48",
  source = "LocalGENCODE",
  organism = "Homo sapiens",
  release = "48",
  genome = "GRCh38",
  fasta = "/path/to/fasta.fa",
  gtf = gtf,
  write = FALSE
)

## -----------------------------------------------------------------------------
# returns a 2-row tibble
# (here localGENCODE avoids downloading an ftp file)
inspectDigests(se)

## -----------------------------------------------------------------------------
inspectDigests(se, fullDigest=TRUE)

## -----------------------------------------------------------------------------
se_update <- updateMetadata(se)
mcols(se_update)

## -----------------------------------------------------------------------------
# define novel set so we can add metadata
novel <- data.frame(
  seqnames = paste0("chr", rep(1:22, each = 500)),
  start = 1e6 + 1 + 0:499 * 1000,
  end = 1e6 + 1 + 0:499 * 1000 + 1000 - 1,
  strand = "+",
  tx_name = paste0("novel", 1:(22 * 500)),
  gene_id = paste0("novel_gene", rep(1:(22 * 10), each = 50)),
  type = "protein_coding"
)
head(novel)
library(GenomicRanges)
novel_gr <- as(novel, "GRanges")
names(novel_gr) <- novel$tx_name

## -----------------------------------------------------------------------------
se_with_ranges <- updateMetadata(se, txpData=novel_gr, ranges=TRUE)
rowRanges(se_with_ranges)

## -----------------------------------------------------------------------------
library(BiocFileCache)
bfc <- BiocFileCache()

## -----------------------------------------------------------------------------
dir <- system.file("extdata/salmon_dm", package="tximportData")
file <- file.path(dir, "SRR1197474.plus", "quant.sf")
file.exists(file)
coldata <- data.frame(files=file, names="SRR1197474", sample="1",
                      stringsAsFactors=FALSE)

## -----------------------------------------------------------------------------
se <- tximeta(coldata)

## -----------------------------------------------------------------------------
indexDir <- file.path(dir, "Dm.BDGP6.22.98.plus_salmon-0.14.1")

## -----------------------------------------------------------------------------
fastaFTP <- c("ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP6.22.cdna.all.fa.gz",
              "ftp://ftp.ensembl.org/pub/release-98/fasta/drosophila_melanogaster/ncrna/Drosophila_melanogaster.BDGP6.22.ncrna.fa.gz",
              "extra_transcript.fa.gz")
#gtfFTP <- "ftp://path/to/custom/Drosophila_melanogaster.BDGP6.22.98.plus.gtf.gz"

## -----------------------------------------------------------------------------
gtfPath <- file.path(dir,"Drosophila_melanogaster.BDGP6.22.98.plus.gtf.gz")

## -----------------------------------------------------------------------------
tmp <- tempdir() # just for vignette demo, make temp directory
jsonFile <- file.path(tmp, paste0(basename(indexDir), ".json"))
makeLinkedTxome(indexDir=indexDir,
                source="LocalEnsembl", organism="Drosophila melanogaster",
                release="98", genome="BDGP6.22",
                fasta=fastaFTP, gtf=gtfPath,
                jsonFile=jsonFile)

## -----------------------------------------------------------------------------
se <- tximeta(coldata)

## -----------------------------------------------------------------------------
rowRanges(se)
seqinfo(se)

## -----------------------------------------------------------------------------
library(BiocFileCache)
if (interactive()) {
  bfcloc <- getTximetaBFC()
} else {
  bfcloc <- tempdir()
}
bfc <- BiocFileCache(bfcloc)
bfcinfo(bfc)
# only run the next line if you want to remove your linkedTxome table!
bfcremove(bfc, bfcquery(bfc, "linkedTxomeTbl")$rid)
bfcinfo(bfc)

## -----------------------------------------------------------------------------
jsonFile <- file.path(tmp, paste0(basename(indexDir), ".json"))
loadLinkedTxome(jsonFile)

## -----------------------------------------------------------------------------
se <- tximeta(coldata)

## -----------------------------------------------------------------------------
if (interactive()) {
  bfcloc <- getTximetaBFC()
} else {
  bfcloc <- tempdir()
}
bfc <- BiocFileCache(bfcloc)
bfcinfo(bfc)
# only run the next line if you want to remove your linkedTxome table!
bfcremove(bfc, bfcquery(bfc, "linkedTxomeTbl")$rid)
bfcinfo(bfc)

## -----------------------------------------------------------------------------
library(devtools)
session_info()

