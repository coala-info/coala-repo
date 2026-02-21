# Code example from 'easier_user_manual' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include = FALSE---------------------------------------------------
#library("easier")

## ----table1, echo=FALSE, message=FALSE, warning=FALSE, results='asis'---------
library(knitr)
table1 <- "
| Quantitative descriptor  | Descriptor conception  | Prior knowledge |
| -----------------------  | ----------------------------------- | ----------------------------------- |
| Pathway activity | @HOLLAND2020194431; @Schubert2018 | @HOLLAND2020194431; @Schubert2018 |
| Immune cell quantification | @Finotello2019 | @Finotello2019 |
| TF activity | @Garcia-Alonso01082019 | @Garcia-Alonso01082019 |
| Ligand-Receptor pairs | @LAPUENTESANTANA2021100293 | @Ramilowski2015; @Barretina2012 |
| Cell-cell interaction | @LAPUENTESANTANA2021100293 | @Ramilowski2015; @Barretina2012 |
Table: Quantitative descriptors of the TME
"
cat(table1)

## ----table2, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'--------
table2 <- "
| Hallmark of the immune response | Original study |
|-------------------------------- | -------------- |
| Cytolytic activity (CYT) | @ROONEY201548 |
| Roh immune score (Roh_IS) | @Roheaah3560 |
| Chemokine signature (chemokines) | @Messina2012 |
| Davoli immune signature (Davoli_IS) | @Davolieaaf8399 |
| IFNy signature (IFNy) | @Ayers2017 |
| Expanded immune signature (Ayers_expIS) | @Ayers2017 |
| T-cell inflamed signature (Tcell_inflamed) | @Ayers2017 |
| Repressed immune resistance (RIR) | @JERBYARNON2018984 |
| Tertiary lymphoid structures signature (TLS) | @Cabrita2020 |
| Immuno-predictive score (IMPRES) | @Auslander2018 |
| Microsatellite instability status | @Fu2019 |
Table: Hallmarks of anti-cancer immune responses
"
cat(table2)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("easier")
# # to install also the dependencies used in the vignettes and in the examples:
# BiocManager::install("easier", dependencies = TRUE)
# # to download and install the development version from GitHub, you can use
# BiocManager::install("olapuentesantana/easier")

## ----eval=TRUE----------------------------------------------------------------
library("easier")

## ----message=FALSE------------------------------------------------------------
suppressPackageStartupMessages({
  library("easierData")
  library("SummarizedExperiment")
})

## ----eval=TRUE----------------------------------------------------------------
dataset_mariathasan <- get_Mariathasan2018_PDL1_treatment()

# patient response
patient_ICBresponse <- colData(dataset_mariathasan)[["BOR"]]
names(patient_ICBresponse) <- colData(dataset_mariathasan)[["pat_id"]]

# tumor mutational burden
TMB <- colData(dataset_mariathasan)[["TMB"]]
names(TMB) <- colData(dataset_mariathasan)[["pat_id"]]

# cohort cancer type 
cancer_type <- metadata(dataset_mariathasan)[["cancertype"]]

# gene expression data
RNA_counts <- assays(dataset_mariathasan)[["counts"]]
RNA_tpm <- assays(dataset_mariathasan)[["tpm"]]

# Select a subset of patients to reduce vignette building time.
set.seed(1234)
pat_subset <- sample(names(patient_ICBresponse), size = 30)
patient_ICBresponse <- patient_ICBresponse[pat_subset]
TMB <- TMB[pat_subset]
RNA_counts <- RNA_counts[, pat_subset]
RNA_tpm <- RNA_tpm[, pat_subset]

# Some genes are causing issues due to approved symbols matching more than one gene
genes_info <- easier:::reannotate_genes(cur_genes = rownames(RNA_tpm))

## Remove non-approved symbols
non_na <- !is.na(genes_info$new_names)
RNA_tpm <- RNA_tpm[non_na, ]
genes_info <- genes_info[non_na, ]

## Remove entries that are withdrawn
RNA_tpm <- RNA_tpm[-which(genes_info$new_names == "entry withdrawn"), ]
genes_info <- genes_info[-which(genes_info$new_names == "entry withdrawn"), ]

## Identify duplicated new genes
newnames_dup <- unique(genes_info$new_names[duplicated(genes_info$new_names)])
newnames_dup_ind <- do.call(c, lapply(newnames_dup, function(X) which(genes_info$new_names == X)))
newnames_dup <- genes_info$new_names[newnames_dup_ind]

## Retrieve data for duplicated genes
tmp <- RNA_tpm[genes_info$old_names[genes_info$new_names %in% newnames_dup],]

## Remove data for duplicated genes
RNA_tpm <- RNA_tpm[-which(rownames(RNA_tpm) %in% rownames(tmp)),]

## Aggregate data of duplicated genes
dup_genes <- genes_info$new_names[which(genes_info$new_names %in% newnames_dup)]
names(dup_genes) <- rownames(tmp)
if (anyDuplicated(newnames_dup)){
  tmp2 <- stats::aggregate(tmp, by = list(dup_genes), FUN = "mean")
  rownames(tmp2) <- tmp2$Group.1
  tmp2$Group.1 <- NULL
}

# Put data together
RNA_tpm <- rbind(RNA_tpm, tmp2)

## ----eval=TRUE----------------------------------------------------------------
hallmarks_of_immune_response <- c("CYT", "Roh_IS", "chemokines", "Davoli_IS", "IFNy", "Ayers_expIS", "Tcell_inflamed", "RIR", "TLS")
immune_response_scores <- compute_scores_immune_response(RNA_tpm = RNA_tpm, 
                                                         selected_scores = hallmarks_of_immune_response)
head(immune_response_scores)

## ----eval=TRUE----------------------------------------------------------------
cell_fractions <- compute_cell_fractions(RNA_tpm = RNA_tpm)
head(cell_fractions)

## ----eval=TRUE----------------------------------------------------------------
pathway_activities <- compute_pathway_activity(RNA_counts = RNA_counts,
                                               remove_sig_genes_immune_response = TRUE)
head(pathway_activities)

## ----eval=TRUE----------------------------------------------------------------
tf_activities <- compute_TF_activity(RNA_tpm = RNA_tpm)
head(tf_activities[,1:5])

## ----eval=TRUE----------------------------------------------------------------
lrpair_weights <- compute_LR_pairs(RNA_tpm = RNA_tpm,
                                   cancer_type = "pancan")
head(lrpair_weights[,1:5])

## ----eval=TRUE----------------------------------------------------------------
ccpair_scores <- compute_CC_pairs(lrpairs = lrpair_weights, 
                                  cancer_type = "pancan")
head(ccpair_scores[,1:5])

## ----eval=TRUE----------------------------------------------------------------
predictions <- predict_immune_response(pathways = pathway_activities,
                                       immunecells = cell_fractions,
                                       tfs = tf_activities,
                                       lrpairs = lrpair_weights,
                                       ccpairs = ccpair_scores,
                                       cancer_type = cancer_type, 
                                       verbose = TRUE)

## ----eval=TRUE----------------------------------------------------------------
output_eval_with_resp <- assess_immune_response(predictions_immune_response = predictions,
                                                patient_response = patient_ICBresponse,
                                                RNA_tpm = RNA_tpm,
                                                TMB_values = TMB,
                                                easier_with_TMB = "weighted_average",
                                                weight_penalty = 0.5)

## ----eval=FALSE---------------------------------------------------------------
# # inspect output
# output_eval_with_resp[[1]]
# output_eval_with_resp[[2]]
# output_eval_with_resp[[3]]

## ----eval=TRUE----------------------------------------------------------------
output_eval_no_resp <- assess_immune_response(predictions_immune_response = predictions,
                                              TMB_values = TMB,
                                              easier_with_TMB = "weighted_average",
                                              weight_penalty = 0.5)

## ----eval=FALSE---------------------------------------------------------------
# # inspect output
# output_eval_no_resp[[1]]
# output_eval_no_resp[[2]]

## ----eval=TRUE----------------------------------------------------------------
easier_derived_scores <- retrieve_easier_score(predictions_immune_response = predictions,
                                               TMB_values = TMB,
                                               easier_with_TMB = c("weighted_average", 
                                                                   "penalized_score"),
                                               weight_penalty = 0.5)

head(easier_derived_scores)

## ----eval=TRUE----------------------------------------------------------------
output_biomarkers <- explore_biomarkers(pathways = pathway_activities,
                                        immunecells = cell_fractions,
                                        tfs = tf_activities,
                                        lrpairs = lrpair_weights,
                                        ccpairs = ccpair_scores,
                                        cancer_type = cancer_type,
                                        patient_label = patient_ICBresponse)

## ----eval=FALSE---------------------------------------------------------------
# # inspect output
# output_biomarkers[[1]]
# output_biomarkers[[2]]
# output_biomarkers[[3]]
# output_biomarkers[[4]]
# output_biomarkers[[5]]
# output_biomarkers[[6]]

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

