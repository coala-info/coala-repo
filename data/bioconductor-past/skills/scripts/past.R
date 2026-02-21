# Code example from 'past' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----setup files--------------------------------------------------------------
library(PAST)
demo_association_file = system.file("extdata", "association.txt.xz", 
                                    package = "PAST", mustWork = TRUE)
demo_effects_file = system.file("extdata", "effects.txt.xz", 
                                package = "PAST", mustWork = TRUE)
demo_LD_file = system.file("extdata", "LD.txt.xz", 
                           package = "PAST", mustWork = TRUE)
demo_genes_file = system.file("extdata", "genes.gff", 
                              package = "PAST", mustWork = TRUE)
demo_pathways_file = system.file("extdata", "pathways.txt.xz", 
                                 package = "PAST", mustWork = TRUE)

## ----loading_gwas_data--------------------------------------------------------
gwas_data <- load_GWAS_data(demo_association_file, 
                            demo_effects_file)

## ----loading_ld_data----------------------------------------------------------
LD <- load_LD(demo_LD_file)

## ----assigning_SNPs-----------------------------------------------------------
genes <-assign_SNPs_to_genes(gwas_data, 
                             LD, 
                             demo_genes_file,
                             c("gene"),
                             1000, 
                             0.8, 
                             2)

## ----finding_pathways---------------------------------------------------------
rugplots_data <- find_pathway_significance(genes, 
                                           demo_pathways_file, 
                                           5,
                                           "increasing", 
                                           1000, 
                                           2)

## ----plotting-----------------------------------------------------------------
plot_pathways(rugplots_data, 
              "pvalue", 
              0.02, 
              "increasing", 
              tempdir())

