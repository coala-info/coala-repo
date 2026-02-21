# Code example from 'CTexploreR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----install1, eval = FALSE---------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("CTexploreR")

## ----install2, eval = FALSE---------------------------------------------------
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("UCLouvain-CBIO/CTexploreR")

## ----CT_genes-----------------------------------------------------------------
library(CTexploreR)
head(CT_genes, 10)

## ----data---------------------------------------------------------------------
CTdata()

## ----ctselection, results='markup', echo=FALSE, fig.align='center', out.width = '100%'----
knitr::include_graphics("./figs/Figure_CT.png")

## -----------------------------------------------------------------------------
testis_specific <- dplyr::filter(
    CT_genes,
    CT_gene_type  == "CT_gene")
GTEX_expression(testis_specific$external_gene_name, units = "log_TPM")

## -----------------------------------------------------------------------------
testis_preferential <- dplyr::filter(
    CT_genes, CT_gene_type  == "CTP_gene")
GTEX_expression(testis_preferential$external_gene_name, units = "log_TPM")

## -----------------------------------------------------------------------------
testis_specific_in_multimapping_analysis <-
    dplyr::filter(CT_genes, lowly_expressed_in_GTEX)

normal_tissue_expression_multimapping(
    testis_specific_in_multimapping_analysis$external_gene_name,
    multimapping = FALSE, units = "log_TPM")

normal_tissue_expression_multimapping(
    testis_specific_in_multimapping_analysis$external_gene_name,
    multimapping = TRUE, units = "log_TPM")

## -----------------------------------------------------------------------------
X_CT <-
    dplyr::filter(CT_genes, X_linked)

testis_expression(X_CT$external_gene_name,
                  cells = "germ_cells")


notX_CT <-
    dplyr::filter(CT_genes, !X_linked)

testis_expression(notX_CT$external_gene_name,
                  cells = "germ_cells")

## -----------------------------------------------------------------------------
oocytes_expression(X_CT$external_gene_name)
oocytes_expression(notX_CT$external_gene_name)

## -----------------------------------------------------------------------------
HPA_cell_type_expression(units = "scaled")

## -----------------------------------------------------------------------------
embryo_expression(dataset = "Petropoulos", include_CTP = FALSE)

## -----------------------------------------------------------------------------
embryo_expression(dataset = "Zhu", include_CTP = FALSE)

## -----------------------------------------------------------------------------
fetal_germcells_expression(include_CTP = FALSE, ncells_max = 100)

## -----------------------------------------------------------------------------
hESC_expression(include_CTP = FALSE, units = "log_TPM",
                values_only = FALSE)

## -----------------------------------------------------------------------------
frequently_activated <- dplyr::filter(
    CT_genes,
    percent_of_positive_CCLE_cell_lines >= 5)

CCLE_expression(
    genes = frequently_activated$external_gene_name,
    type = c(
        "lung", "skin", "bile_duct", "bladder", "colorectal",
        "lymphoma", "uterine", "myeloma", "kidney",
        "pancreatic", "brain", "gastric", "breast", "bone",
        "head_and_neck", "ovarian", "sarcoma", "leukemia",
        "esophageal", "neuroblastoma"),
    units = "log_TPM")

## -----------------------------------------------------------------------------
not_frequently_activated <- dplyr::filter(
    CT_genes,
    percent_of_negative_CCLE_cell_lines >= 95)

CCLE_expression(
    genes = not_frequently_activated$external_gene_name,
    type = c(
        "lung", "skin", "bile_duct", "bladder", "colorectal",
        "lymphoma", "uterine", "myeloma", "kidney",
        "pancreatic", "brain", "gastric", "breast", "bone",
        "head_and_neck", "ovarian", "sarcoma", "leukemia",
        "esophageal", "neuroblastoma"),
    units = "log_TPM")

## -----------------------------------------------------------------------------
CT_correlated_genes("MAGEA3", 0.3)

## -----------------------------------------------------------------------------
TCGA_expression(
    genes = frequently_activated$external_gene_name,
    tumor = "all",
    units = "log_TPM")

## -----------------------------------------------------------------------------
TCGA_expression(
    genes = not_frequently_activated$external_gene_name,
    tumor = "all",
    units = "log_TPM")

## -----------------------------------------------------------------------------
TCGA_expression(
    genes = frequently_activated$external_gene_name,
    tumor = "LUAD",
    units = "log_TPM")

## -----------------------------------------------------------------------------
controlled_by_methylation <- dplyr::filter(CT_genes, regulated_by_methylation)
DAC_induction(genes = controlled_by_methylation$external_gene_name)

## -----------------------------------------------------------------------------
not_controlled_by_methylation <- dplyr::filter(
    CT_genes,
    !regulated_by_methylation)
DAC_induction(genes = not_controlled_by_methylation$external_gene_name)

## -----------------------------------------------------------------------------
normal_tissues_methylation("MAGEB2")

## -----------------------------------------------------------------------------
normal_tissues_methylation("LIN28A")

## -----------------------------------------------------------------------------
normal_tissues_mean_methylation(
    genes = controlled_by_methylation$external_gene_name)

## -----------------------------------------------------------------------------
normal_tissues_mean_methylation(
    genes =
        not_controlled_by_methylation$external_gene_name)

## -----------------------------------------------------------------------------
embryos_mean_methylation(c("MAGEA1", "MAGEA3", "MAGEA4", "MAGEC2", "MAGEB16"),
                         stage = c( "MII Oocyte", "Sperm", "Zygote", "2-cell",
                                    "4-cell", "8-cell",  "Morula"))

## -----------------------------------------------------------------------------
fetal_germcells_mean_methylation(c("MAGEA1", "MAGEA3", "MAGEA4", "MAGEC2"))

## -----------------------------------------------------------------------------
hESC_mean_methylation()

## -----------------------------------------------------------------------------
TCGA_methylation_expression_correlation(
    tumor = "all",
    gene = "TDRD1")

## -----------------------------------------------------------------------------
TCGA_methylation_expression_correlation(
    tumor = "all",
    gene = "LIN28A")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("InteractiveComplexHeatmap")
# library(InteractiveComplexHeatmap)
# 
# GTEX_expression(testis_specific$external_gene_name, units = "log_TPM")
# htShiny()

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

