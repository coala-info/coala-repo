# Code example from 'Vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
library(knitr)
# knitr::opts_knit$set(root.dir = normalizePath("/Users/mbuljan/Documents/Paket_op/DominoEffect_radna/inst/doc"))
#library(devtools)
#knitr::opts_knit$set(root.dir = normalizePath(inst("DominoEffect"))) 

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("DominoEffect")

## -----------------------------------------------------------------------------
library(DominoEffect)

## -----------------------------------------------------------------------------
data("TestData", package = "DominoEffect")
data("SnpData", package = "DominoEffect")
data("DominoData", package = "DominoEffect")

## ----eval=FALSE---------------------------------------------------------------
# DominoEffect(TestData, DominoData, SnpData)

## ----eval=FALSE---------------------------------------------------------------
# mutation_dataset = read.table ("user_file_with_mutations.txt", header = T)
# gene_data = read.table ("user_ensembl_gene_list.txt", header = T)
# snp_data = read.table ("user_population_SNPs_with_frequency.txt", header = T)

## ----message = FALSE, results = "hide"----------------------------------------
hotspot_mutations <- DominoEffect(mutation_dataset = TestData, 
                                  gene_data = DominoData, snp_data = SnpData)

## ----eval= FALSE--------------------------------------------------------------
# data("TestData", package = "DominoEffect")

## ----echo = FALSE-------------------------------------------------------------
kable(head(TestData), row.names = FALSE)

## ----echo = FALSE-------------------------------------------------------------
kable(head(hotspot_mutations), row.names = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# hotspot_mutations <- DominoEffect(mutation_dataset, gene_data, snp_data, min_n_muts, MAF_thresh, flanking_region, poisson.thr, percentage.thr, ratio.thr, approach, write_to_file)

## -----------------------------------------------------------------------------
min_n_muts <- 5

## -----------------------------------------------------------------------------
MAF.thr <- 0.01

## -----------------------------------------------------------------------------
flanking_region <- c(200, 300)
flanking_region <- c(300)

## -----------------------------------------------------------------------------
poisson.thr <- 0.01

## -----------------------------------------------------------------------------
percentage.thr <- 0.15

## -----------------------------------------------------------------------------
ratio.thr <- 40

## -----------------------------------------------------------------------------
approach = "percentage"

## ----eval = FALSE-------------------------------------------------------------
# write_to_file = "YES"

## ----message = FALSE, results = "hide", eval = FALSE--------------------------
# hotspot_mutations <- DominoEffect(mutation_dataset = TestData,
#                                   gene_data = DominoData, snp_data = SnpData)

## ----message = FALSE----------------------------------------------------------
hotspot_mutations <- identify_hotspots(mutation_dataset = TestData, 
                                       gene_data = DominoData, 
                                       snp_data = SnpData, min_n_muts = 5, 
                                       MAF_thresh = 0.01, 
                                       flanking_region = c(200, 300), 
                                       poisson.thr = 0.01, 
                                       percentage.thr = 0.15, ratio.thr = 45, 
                                       approach = "percentage")

## ----message = FALSE, eval = FALSE--------------------------------------------
# results_w_annotations <- map_to_func_elem(hotspot_mutations,
#                                           write_to_file = "NO",
#                                           ens_release = "73")

## ----echo = FALSE-------------------------------------------------------------
kable(head(DominoData), row.names = FALSE)

## ----echo = FALSE-------------------------------------------------------------
kable(head(SnpData), row.names = FALSE)

## ----echo = FALSE-------------------------------------------------------------
hotspot_mutations.GPo <- GPo_of_hotspots(hotspot_mutations)
head(hotspot_mutations.GPo)

## -----------------------------------------------------------------------------
sessionInfo()

