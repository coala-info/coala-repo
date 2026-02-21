# Code example from 'ewceData' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis', message=FALSE-------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(tidy         = FALSE,
                      warning      = FALSE,
                      message      = FALSE)


## ----setup--------------------------------------------------------------------
library(ewceData)

## -----------------------------------------------------------------------------
ensembl_transcript_lengths_GCcontent <- ensembl_transcript_lengths_GCcontent()
mouse_to_human_homologs <- mouse_to_human_homologs()
all_mgi_wtEnsembl <- all_mgi_wtEnsembl()
all_mgi <- all_mgi()
all_hgnc_wtEnsembl <- all_hgnc_wtEnsembl()
all_hgnc <- all_hgnc()
example_genelist <- example_genelist()
tt_alz <- tt_alzh()
tt_alzh_BA36 <- tt_alzh_BA36()
tt_alzh_BA44 <- tt_alzh_BA44()
ctd <- ctd()
schiz_genes <- schiz_genes()
hpsd_genes <- hpsd_genes()
rbfox_genes <- rbfox_genes()
id_genes <- id_genes()
cortex_mrna <- cortex_mrna()
hypothalamus_mrna <- hypothalamus_mrna()
alzh_gwas_top100 <- alzh_gwas_top100()
mgi_synonym_data <- mgi_synonym_data()

## ----setup2-------------------------------------------------------------------
library(ggplot2)
library(cowplot)
theme_set(theme_cowplot())

## -----------------------------------------------------------------------------
cortex_mrna_dt <- cortex_mrna()
gene="Necab1"
cellExpDist = data.frame(e=cortex_mrna_dt$exp[gene,],
                          l1=cortex_mrna_dt$annot[
                            colnames(cortex_mrna_dt$exp),]$level1class)
ggplot(cellExpDist) + geom_boxplot(aes(x=l1,y=e)) + xlab("Cell type") + 
  ylab("Unique Molecule Count") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 

