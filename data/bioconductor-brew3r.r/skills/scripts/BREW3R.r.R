# Code example from 'BREW3R.r' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation bioconductor, eval=FALSE------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("BREW3R.r")

## ----installation github, eval=FALSE------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("lldelisle/BREW3R.r")

## ----dependencies-------------------------------------------------------------
library(rtracklayer)
library(GenomicRanges)

## ----set file variables-------------------------------------------------------
input_gtf_file_to_extend <-
    system.file(
        "extdata/chr19.gencode.vM25.annotation.gtf.gz",
        package = "BREW3R.r",
        mustWork = TRUE
    )
input_gtf_file_template <-
    system.file(
        "extdata/chr19.mm10.ncbiRefSeq.gtf.gz",
        package = "BREW3R.r",
        mustWork = TRUE
    )

## ----get GRanges--------------------------------------------------------------
input_gr_to_extend <- rtracklayer::import(input_gtf_file_to_extend)
input_gr_template <- rtracklayer::import(input_gtf_file_template)

## ----save CDS-----------------------------------------------------------------
input_gr_CDS <- subset(input_gr_to_extend, type == "CDS")

## ----extend-------------------------------------------------------------------
library(BREW3R.r)
new_gr_exons <- extend_granges(
    input_gr_to_extend = input_gr_to_extend,
    input_gr_to_overlap = input_gr_template
)

## ----plot Btrc, echo=FALSE----------------------------------------------------
my_gene_name <- "Btrc"
gene_before <- subset(
    input_gr_to_extend,
    type == "exon" & gene_name == my_gene_name
)
gene_to_overlap <- subset(
    input_gr_template,
    type == "exon" & gene_name == my_gene_name
)
gene_after <- subset(
    new_gr_exons,
    type == "exon" & gene_name == my_gene_name
)
code <- (runValue(strand(gene_after[1])) == "+") + 1

plot(
    1,
    type = "n", xlab = "", ylab = "", axes = FALSE,
    xlim = c(
        min(start(gene_after)) - 1,
        max(end(gene_after))
    ),
    ylim = c(0, 4)
)
par(las = 1)
axis(2, at = 1:3, labels = c("new gtf", "template", "original"))
arrows(
    x0 = start(gene_before) - 1,
    x1 = end(gene_before),
    y0 = 3, col = "blue",
    code = code
)
arrows(
    x0 = start(gene_to_overlap) - 1,
    x1 = end(gene_to_overlap),
    y0 = 2, col = "red",
    code = code
)
arrows(
    x0 = start(gene_after) - 1,
    x1 = end(gene_after),
    y0 = 1, col = "purple",
    code = code
)

## ----plot Mrpl21, echo=FALSE--------------------------------------------------
my_gene_name <- "Mrpl21"
my_transcript <- "ENSMUST00000155870.1"
gene_before <- subset(
  input_gr_to_extend,
  type == "exon" & gene_name == my_gene_name
)
gene_to_overlap <- subset(
  input_gr_template,
  type == "exon" & gene_name == my_gene_name
)
gene_after <- subset(new_gr_exons, type == "exon" & gene_name == my_gene_name)

code <- (runValue(strand(gene_after[1])) == "+") + 1

plot(1,
     type = "n", xlab = "", ylab = "", axes = FALSE,
     xlim = c(
       min(start(gene_after)) - 1,
       max(end(gene_after))
     ),
     ylim = c(0, 4)
)
par(las = 1)
axis(2, at = 1:3, labels = c("new gtf", "template", "original"))
arrows(
  x0 = start(gene_before) - 1,
  x1 = end(gene_before),
  y0 = 2.8 + 0.4 * as.numeric(gene_before$transcript_id == my_transcript),
  col = "blue",
  code = code
)
arrows(
  x0 = start(gene_to_overlap) - 1,
  x1 = end(gene_to_overlap),
  y0 = 2, col = "red",
  code = code
)
arrows(
  x0 = start(gene_after) - 1,
  x1 = end(gene_after),
  y0 = 0.8 + 0.4 * as.numeric(gene_after$transcript_id == my_transcript),
  col = "purple",
  code = code
)

## ----recompose----------------------------------------------------------------
new_gr <- c(new_gr_exons, input_gr_CDS)

## ----write, eval=FALSE--------------------------------------------------------
# rtracklayer::export.gff(sort(new_gr), "my_new.gtf")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

