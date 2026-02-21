# Code example from 'auxiliary_commands' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, warning= FALSE, message=FALSE-------------------------------------
library(ceRNAnetsim)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ceRNAnetsim")

## -----------------------------------------------------------------------------
data("TCGA_E9_A1N5_tumor")
data("TCGA_E9_A1N5_normal")
data("mirtarbasegene")
data("TCGA_E9_A1N5_mirnanormal")

## -----------------------------------------------------------------------------
TCGA_E9_A1N5_mirnanormal %>%
  inner_join(mirtarbasegene, by= "miRNA") %>%
  inner_join(TCGA_E9_A1N5_normal, 
             by = c("Target"= "external_gene_name")) %>%
  select(Target, miRNA, total_read, gene_expression) %>%
  distinct() -> TCGA_E9_A1N5_mirnagene

## -----------------------------------------------------------------------------
TCGA_E9_A1N5_tumor%>%
  inner_join(TCGA_E9_A1N5_normal, by= "external_gene_name")%>%
  select(patient = patient.x, 
         external_gene_name, 
         tumor_exp = gene_expression.x, 
         normal_exp = gene_expression.y)%>%
  distinct()%>%
  inner_join(TCGA_E9_A1N5_mirnagene, by = c("external_gene_name"= "Target"))%>%
  filter(tumor_exp != 0, normal_exp != 0)%>%
  mutate(FC= tumor_exp/normal_exp)%>%
  filter(external_gene_name== "HIST1H3H")

#HIST1H3H: interacts with various miRNA in dataset, so we can say that HIST1H3H is non-isolated competing element and increases to 30-fold.


## -----------------------------------------------------------------------------
TCGA_E9_A1N5_tumor%>%
  inner_join(TCGA_E9_A1N5_normal, by= "external_gene_name") %>%
  select(patient = patient.x, 
         external_gene_name, 
         tumor_exp = gene_expression.x, 
         normal_exp = gene_expression.y) %>%
  distinct() %>%
  inner_join(TCGA_E9_A1N5_mirnagene, 
             by = c("external_gene_name"= "Target")) %>%
  filter(tumor_exp != 0, normal_exp != 0) %>%
  mutate(FC= tumor_exp/normal_exp) %>%
  filter(external_gene_name == "ACTB")

#ACTB: interacts with various miRNA in dataset, so ACTB is not isolated node in network and increases to 1.87-fold.


## -----------------------------------------------------------------------------
TCGA_E9_A1N5_mirnagene %>%    
  group_by(Target) %>%        
  mutate(gene_expression= max(gene_expression)) %>%
  distinct() %>%
  ungroup() -> TCGA_E9_A1N5_mirnagene

TCGA_E9_A1N5_mirnagene%>%
  filter(gene_expression > 10)->TCGA_E9_A1N5_mirnagene


## ----warning=FALSE, eval=FALSE------------------------------------------------
# TCGA_E9_A1N5_mirnagene %>%
#   priming_graph(competing_count = gene_expression,
#                 miRNA_count = total_read)%>%
#   calc_perturbation(node_name= "ACTB", cycle=10, how= 1.87,limit = 0.1)

## ----warning=FALSE, eval=FALSE------------------------------------------------
# TCGA_E9_A1N5_mirnagene %>%
#   priming_graph(competing_count = gene_expression,
#                 miRNA_count = total_read)%>%
#   calc_perturbation(node_name= "ACTB", cycle=10, how= 30,limit = 0.1)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

