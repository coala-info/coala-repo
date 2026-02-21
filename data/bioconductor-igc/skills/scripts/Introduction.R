# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("iGC")

## -----------------------------------------------------------------------------
library(iGC)

## -----------------------------------------------------------------------------
sample_desc_pth <- system.file("extdata", "sample_desc.csv", package = "iGC")
sample_desc <- create_sample_desc(sample_desc_pth)

## ----eval=FALSE---------------------------------------------------------------
# sample_desc <- create_sample_desc(
#   sample_names = sample_desc$Sample,
#   cna_filepaths = sample_desc$CNA_filepath,
#   ge_filepaths = sample_desc$GE_filepath
# )

## -----------------------------------------------------------------------------
head(sample_desc)

## -----------------------------------------------------------------------------
gene_exp <- create_gene_exp(sample_desc, progress = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# gene_exp <- create_gene_exp(
#   sample_desc,
#   read_fun = read.table,
#   progress = TRUE, progress_width = 60,
#   # arugments passed to the customized read_fun (here is read.table)
#   header = FALSE,
#   skip = 2,
#   na.strings = "null",
#   colClasses = c("character", "double")
# )

## -----------------------------------------------------------------------------
gene_exp[GENE %in% c('TP53', 'BRCA1', 'NFKB1'), 1:10, with=FALSE]

## -----------------------------------------------------------------------------
my_cna_reader <- function(cna_filepath) {
  cna <- data.table::fread(cna_filepath, sep = '\t', header = TRUE)
  cna[, .(Chromosome, Start, End, Segment_Mean)]
}

gain_loss = log2(c(2.4, 1.6)) - 1
gene_cna <- create_gene_cna(
  sample_desc,
  gain_threshold = gain_loss[1], loss_threshold = gain_loss[2],
  read_fun = my_cna_reader,
  progress = FALSE
)
gene_cna[GENE %in% c('TP53', 'BRCA1', 'NFKB1'), 1:10, with=FALSE]

## ----eval=FALSE---------------------------------------------------------------
# # Change 4 to match one's total CPU cores
# doMC::registerDoMC(cores = 4)
# gene_cna <- faster_gene_cna(
#   sample_desc, gain_loss[[1]], gain_loss[[2]], parallel = TRUE
# )

## -----------------------------------------------------------------------------
cna_driven_genes <- find_cna_driven_gene(
  gene_cna, gene_exp,
  gain_prop = 0.15, loss_prop = 0.15,
  progress = FALSE, parallel = FALSE
)
head(cna_driven_genes$gain_driven)
head(cna_driven_genes$loss_driven)
head(cna_driven_genes$both)

## -----------------------------------------------------------------------------
cna_driven_genes$loss_driven[GENE %in% c('BRCA1')]

