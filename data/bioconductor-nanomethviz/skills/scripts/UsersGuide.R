# Code example from 'UsersGuide' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(fig.width = 7)
knitr::opts_chunk$set(fig.height = 5)
knitr::opts_chunk$set(dpi = 72)

# preload to avoid loading messages
library(NanoMethViz)
library(dplyr)
exon_tibble <- get_exons_mm10()

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("NanoMethViz")

## -----------------------------------------------------------------------------
library(NanoMethViz)
library(dplyr)

## -----------------------------------------------------------------------------
# construct with a ModBamFiles object as the methylation data
mbr <- ModBamResult(
    methy = ModBamFiles(
        samples = "sample1",
        system.file(package = "NanoMethViz", "peg3.bam")
    ),
    samples = data.frame(
        sample = "sample1",
        group = 1
    ),
    exons = exon_tibble
)

# use in the same way as you would a NanoMethResult object
plot_gene(mbr, "Peg3", heatmap = TRUE)

## -----------------------------------------------------------------------------
methy_calls <- system.file(package = "NanoMethViz",
    c("sample1_nanopolish.tsv.gz", "sample2_nanopolish.tsv.gz"))

## ----message=F----------------------------------------------------------------
# create a temporary file to store the converted data
methy_tabix <- file.path(tempdir(), "methy_data.bgz")
samples <- c("sample1", "sample2")

# you should see messages when running this yourself
create_tabix_file(methy_calls, methy_tabix, samples)

# don't do this with full datasets, it will take a long time
# we have to use gzfile to tell R that we have a gzip compressed file
methy_data <- read.table(
    gzfile(methy_tabix), col.names = methy_col_names(), nrows = 6)

methy_data

## -----------------------------------------------------------------------------
# methylation data stored in tabix file
methy <- system.file(package = "NanoMethViz", "methy_subset.tsv.bgz")

# tabix is just a special gzipped tab-separated-values file
read.table(gzfile(methy), col.names = methy_col_names(), nrows = 6)

## -----------------------------------------------------------------------------
# helper function extracts exons from TxDb package
exon_tibble <- get_exons_mm10()

head(exon_tibble)

## -----------------------------------------------------------------------------
sample <- c(
  "B6Cast_Prom_1_bl6", "B6Cast_Prom_1_cast",
  "B6Cast_Prom_2_bl6", "B6Cast_Prom_2_cast",
  "B6Cast_Prom_3_bl6", "B6Cast_Prom_3_cast"
)

group <- c("bl6", "cast", "bl6", "cast", "bl6", "cast")

sample_anno <- data.frame(sample, group, stringsAsFactors = FALSE)

sample_anno

## -----------------------------------------------------------------------------
nmr <- NanoMethResult(methy, sample_anno, exon_tibble)

## -----------------------------------------------------------------------------
plot_gene(nmr, "Peg3")

## -----------------------------------------------------------------------------
# loading saved results from previous bsseq analysis
bsseq_dmr <- read.table(
    system.file(package = "NanoMethViz", "dmr_subset.tsv.gz"),
    sep = "\t",
    header = TRUE,
    stringsAsFactors = FALSE
)

## -----------------------------------------------------------------------------
plot_gene(nmr, "Peg3", anno_regions = bsseq_dmr)

## ----message = FALSE----------------------------------------------------------
nmr <- load_example_nanomethresult()
bss <- methy_to_bsseq(nmr)

bss

## -----------------------------------------------------------------------------
gene_regions <- exons_to_genes(NanoMethViz::exons(nmr))
edger_mat <- bsseq_to_edger(bss, gene_regions)

edger_mat

## -----------------------------------------------------------------------------
anno <- rtracklayer::import(system.file(package = "NanoMethViz", "c_elegans.gtf.gz"))

head(anno)

## -----------------------------------------------------------------------------
anno <- anno %>%
    as.data.frame() %>%
    dplyr::rename(
        chr = "seqnames",
        symbol = "gene_name"
    ) %>%
    dplyr::select("gene_id", "chr", "strand", "start", "end", "transcript_id", "symbol")

head(anno)

## ----message = FALSE----------------------------------------------------------
nmr <- load_example_nanomethresult()

plot_gene(nmr, "Peg3")

## -----------------------------------------------------------------------------
new_exons <- NanoMethViz::exons(nmr) %>%
    exons_to_genes() %>%
    mutate(transcript_id = gene_id)

NanoMethViz::exons(nmr) <- new_exons

plot_gene(nmr, "Peg3")

## ----message = FALSE----------------------------------------------------------
# convert to bsseq
bss <- methy_to_bsseq(nmr)
bss

## -----------------------------------------------------------------------------
# create gene annotation from exon annotation
gene_anno <- exons_to_genes(NanoMethViz::exons(nmr))

# create log-methylation-ratio matrix
lmr <- bsseq_to_log_methy_ratio(bss, regions = gene_anno)

## -----------------------------------------------------------------------------
plot_mds(lmr) +
    ggtitle("MDS Plot")

plot_pca(lmr) +
    ggtitle("PCA Plot")

## -----------------------------------------------------------------------------
new_labels <- gsub("B6Cast_Prom_", "", colnames(lmr))
new_labels <- gsub("(\\d)_(.*)", "\\2 \\1", new_labels)
groups <- gsub(" \\d", "", new_labels)

plot_mds(lmr, labels = new_labels, groups = groups) +
    ggtitle("MDS Plot") +
    scale_colour_brewer(palette = "Set1")

## -----------------------------------------------------------------------------
plot_mds(lmr, labels = NULL, groups = groups) +
    ggtitle("MDS Plot") +
    scale_colour_brewer(palette = "Set1")

## ----eval = FALSE-------------------------------------------------------------
# options("NanoMethViz.site_filter" = 5)

## ----eval = FALSE-------------------------------------------------------------
# options("NanoMethViz.highlight_col" = "red")

