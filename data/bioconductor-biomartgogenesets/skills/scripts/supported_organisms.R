# Code example from 'supported_organisms' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    echo = FALSE)
library(GetoptLong)
library(DT)
library(BioMartGOGeneSets)

## -----------------------------------------------------------------------------
table = readRDS(system.file("extdata", "all_supported_organisms.rds", package = "BioMartGOGeneSets"))
table$genesets = paste0("BP (", table$n_bp_genesets, "), CC (", table$n_cc_genesets, "), MF (", table$n_mf_genesets, ")")
colnames(table)[colnames(table) == "n_gene"] = "genes"
df_genes = table[table$mart == "genes_mart", c("dataset", "name", "version", "taxon_id", "genbank_accession", "genesets"), drop = FALSE]
df_plants = table[table$mart == "plants_mart", c("dataset", "name", "version", "taxon_id", "genbank_accession", "genesets"), drop = FALSE]
df_metazoa = table[table$mart == "metazoa_mart", c("dataset", "name", "version", "taxon_id", "genbank_accession", "genesets"), drop = FALSE]
df_fungi = table[table$mart == "fungi_mart", c("dataset", "name", "version", "taxon_id", "genbank_accession", "genesets"), drop = FALSE]
df_protists = table[table$mart == "protists_mart", c("dataset", "name", "version", "taxon_id", "genbank_accession", "genesets"), drop = FALSE]

## ----echo = TRUE--------------------------------------------------------------
BioMartGOGeneSets

## -----------------------------------------------------------------------------
datatable(df_genes, rownames = FALSE)

## -----------------------------------------------------------------------------
datatable(df_plants, rownames = FALSE)

## -----------------------------------------------------------------------------
datatable(df_metazoa, rownames = FALSE)

## -----------------------------------------------------------------------------
datatable(df_fungi, rownames = FALSE)

## -----------------------------------------------------------------------------
datatable(df_protists, rownames = FALSE)

