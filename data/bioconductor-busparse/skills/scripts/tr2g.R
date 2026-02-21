# Code example from 'tr2g' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(BUSpaRse)
library(BSgenome.Hsapiens.UCSC.hg38)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(EnsDb.Hsapiens.v86)

## -----------------------------------------------------------------------------
# For Drosophila
dl_transcriptome("Drosophila melanogaster", out_path = "fly", 
                 gene_biotype_use = "cellranger", verbose = FALSE)
list.files("fly")

## -----------------------------------------------------------------------------
dl_transcriptome("Caenorhabditis elegans", out_path = "worm", verbose = FALSE,
                 gene_biotype_use = "cellranger", ensembl_version = 100)
list.files("worm")

## -----------------------------------------------------------------------------
dl_transcriptome("Saccharomyces cerevisiae", out_path = "yeast", 
                 type = "fungus", gene_biotype_use = "cellranger", 
                 verbose = FALSE)
list.files("yeast")

## -----------------------------------------------------------------------------
# Specify other attributes
tr2g_mm <- tr2g_ensembl("Mus musculus", ensembl_version = 105, 
                        other_attrs = "description", 
                        gene_biotype_use = "cellranger")

## -----------------------------------------------------------------------------
head(tr2g_mm)

## -----------------------------------------------------------------------------
# Plants
tr2g_at <- tr2g_ensembl("Arabidopsis thaliana", type = "plant")

## -----------------------------------------------------------------------------
head(tr2g_at)

## -----------------------------------------------------------------------------
# Subset of a real Ensembl FASTA file
toy_fasta <- system.file("testdata/fasta_test.fasta", package = "BUSpaRse")
tr2g_fa <- tr2g_fasta(file = toy_fasta, write_tr2g = FALSE, save_filtered = FALSE)
head(tr2g_fa)

## -----------------------------------------------------------------------------
# Subset of a reral GTF file from Ensembl
toy_gtf <- system.file("testdata/gtf_test.gtf", package = "BUSpaRse")
tr2g_tg <- tr2g_gtf(toy_gtf, Genome = BSgenome.Hsapiens.UCSC.hg38,
                    gene_biotype_use = "cellranger",
                    out_path = "gtf")
head(tr2g_tg)

## -----------------------------------------------------------------------------
list.files("gtf")

## -----------------------------------------------------------------------------
tr2g_hs <- tr2g_TxDb(TxDb.Hsapiens.UCSC.hg38.knownGene, get_transcriptome = FALSE,
                     write_tr2g = FALSE)
head(tr2g_hs)

## -----------------------------------------------------------------------------
tr2g_hs86 <- tr2g_EnsDb(EnsDb.Hsapiens.v86, get_transcriptome = FALSE, 
                        write_tr2g = FALSE, gene_biotype_use = "cellranger",
                        use_gene_version = FALSE, use_transcript_version = FALSE)
head(tr2g_hs86)

## -----------------------------------------------------------------------------
sessionInfo()

