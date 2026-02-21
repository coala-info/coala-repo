# Code example from 'full_analysis' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
options(warn=2)
suppressPackageStartupMessages(library(HERON))

## ----example_seq_mat----------------------------------------------------------
data(heffron2021_wuhan)
knitr::kable(assay(heffron2021_wuhan)[1:5,1:5])

## ----example_colData----------------------------------------------------------
knitr::kable(head(colData(heffron2021_wuhan)))

## ----example_probe_meta-------------------------------------------------------
probe_meta <- metadata(heffron2021_wuhan)$probe_meta
knitr::kable(head(probe_meta[,c("PROBE_SEQUENCE", "PROBE_ID")]))

## ----create_object------------------------------------------------------------
seq_mat <- assay(heffron2021_wuhan)
sds <- HERONSequenceDataSet(seq_mat)
colData(sds) <- colData(heffron2021_wuhan)
metadata(sds)$probe_meta <- probe_meta

## ----quantile_normalize-------------------------------------------------------
seq_ds_qn <- quantileNormalize(sds)
knitr::kable(head(assay(seq_ds_qn)[,1:5]))

## ----example_probe_pvalues----------------------------------------------------
seq_pval_res <- calcCombPValues(seq_ds_qn)
probe_pval_res <- convertSequenceDSToProbeDS(seq_pval_res)
knitr::kable(head(assay(probe_pval_res, "padj")[,1:5]))

## ----example_probe_calls------------------------------------------------------
probe_calls_res <- makeProbeCalls(probe_pval_res)
knitr::kable(head(assay(probe_calls_res, "calls")[,1:5]))

## -----------------------------------------------------------------------------
probe_calls_k_of_n <- getKofN(probe_calls_res)
knitr::kable(head(probe_calls_k_of_n))

## ----example_epitope_finding_unique-------------------------------------------

epi_segments_uniq_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "unique"
)

knitr::kable(head(epi_segments_uniq_res))



## ----example_epitope_pvalues--------------------------------------------------

epi_padj_uniq <- calcEpitopePValues(
    probe_calls_res,
    epitope_ids = epi_segments_uniq_res,
    metap_method = "wmax1"
)


## -----------------------------------------------------------------------------
epi_padj_uniq <- addSequenceAnnotations(epi_padj_uniq)

## ----example_epitope_calls----------------------------------------------------

epi_calls_uniq <- makeEpitopeCalls(epi_padj_uniq, one_hit_filter = TRUE)
epi_calls_k_of_n_uniq <- getKofN(epi_calls_uniq)
knitr::kable(head(epi_calls_k_of_n_uniq))


## ----example_protein_pvalues--------------------------------------------------
prot_padj_uniq <- calcProteinPValues(
    epi_padj_uniq,
    metap_method = "tippetts"
)

## ----example_protein_calls----------------------------------------------------
prot_calls_uniq <- makeProteinCalls(prot_padj_uniq)
prot_calls_k_of_n_uniq <- getKofN(prot_calls_uniq)
knitr::kable(head(prot_calls_k_of_n_uniq))

## ----example_epitope_finding_hclust-------------------------------------------
epi_segments_hclust_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "hclust",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette"
)

## ----example_epitope_finding_hclust2------------------------------------------
epi_segments_hclust_res2 <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "hclust",
    segment_score_type = "zscore",
    segment_dist_method = "euclidean",
    segment_cutoff = "silhouette"
)

## ----example_epitope_finding_skater-------------------------------------------
epi_segments_skater_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "skater",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette"
)

## ----example_epitope_finding_skater2------------------------------------------
epi_segments_skater_res <- findEpitopeSegments(
    probe_calls_res,
    segment_method = "skater",
    segment_score_type = "zscore",
    segment_dist_method = "euclidean",
    segment_cutoff = "silhouette"
)

## ----pvalue_zscore------------------------------------------------------------

seq_pval_res_z <- calcCombPValues(
    obj = seq_ds_qn, 
    use = "z", 
    p_adjust_method = "none"
)


p_cutoff <- pnorm(2, lower.tail = FALSE)

probe_pval_res_z <- convertSequenceDSToProbeDS(seq_pval_res_z, probe_meta)

probe_calls_z2 <- makeProbeCalls(probe_pval_res_z, padj_cutoff = p_cutoff)
probe_k_of_n_z2 <- getKofN(probe_calls_z2)

knitr::kable(head(assay(probe_calls_z2,"calls")[,1:5]))
knitr::kable(head(probe_k_of_n_z2[probe_k_of_n_z2$K > 0,]))


## ----pvalue_zscore_uniq-------------------------------------------------------
epi_segments_uniq_z2_res <- findEpitopeSegments(
    probe_calls_z2,
    segment_method = "unique"
)

## ----pvalue_zscore_epi_pval---------------------------------------------------

epi_pval_uniq_z2 <- calcEpitopePValues(
    probe_pds = probe_pval_res_z,
    epitope_ids = epi_segments_uniq_z2_res,
    metap_method = "max",
    p_adjust_method = "none"
)

## ----pvalue_zscore_epi_calls--------------------------------------------------
epi_calls_uniq_z2 <- makeEpitopeCalls(
    epi_ds = epi_pval_uniq_z2, 
    padj_cutoff = p_cutoff
)

## ----pvalue_zscore_skater-----------------------------------------------------
epi_segments_skater_z2_res <- findEpitopeSegments(
    probe_calls_z2,
    segment_method = "skater",
    segment_score_type = "binary",
    segment_dist_method = "hamming",
    segment_cutoff = "silhouette")

## ----smooth_probes------------------------------------------------------------

probe_ds_qn <- convertSequenceDSToProbeDS(seq_ds_qn, probe_meta )

smooth_ds <- smoothProbeDS(probe_ds_qn)

## ----smooth_probes_pval-------------------------------------------------------
probe_sm_pval <- calcCombPValues(smooth_ds)

## ----smooth_probes_calls------------------------------------------------------
probe_sm_calls <- makeProbeCalls(probe_sm_pval)
probe_sm_k_of_n <- getKofN(probe_sm_calls)
knitr::kable(assay(probe_sm_calls,"calls")[1:3,1:3])
knitr::kable(head(probe_sm_k_of_n[probe_sm_k_of_n$K > 0,]))

## ----paired_t_tests-----------------------------------------------------------
data(heffron2021_wuhan)
probe_meta <- attr(heffron2021_wuhan, "probe_meta")
colData_paired <- colData(heffron2021_wuhan)

## Make some samples paired by setting the sample ids
pre_idx <- which(colData_paired$visit == "pre")
colData_post <- colData_paired[colData_paired$visit == "post",]
new_ids <- colData_post$SampleName[seq_len(5)]
colData_paired$ptid[pre_idx[seq_len(5)]] = new_ids

paired_ds <- heffron2021_wuhan
colData(paired_ds) <- colData_paired

## calculate p-values
pval_res <- calcCombPValues(
    obj = paired_ds,
    d_paired = TRUE
)

knitr::kable(assay(pval_res[1:3,],"pvalue"))


## ----example_wilcox_probe_pvalues---------------------------------------------
seq_pval_res_w <- calcCombPValues(
    obj = seq_ds_qn, 
    use = "w", d_abs_shift = 1
)
probe_pval_res_w <- convertSequenceDSToProbeDS(seq_pval_res_w)
knitr::kable(assay(probe_pval_res_w[1:3, 1:5], "padj"))

## -----------------------------------------------------------------------------
col_data <- colData(heffron2021_wuhan)
covid <- which(col_data$visit == "post")

col_data$condition[covid[1:10]] <- "COVID2"

seq_ds <- heffron2021_wuhan
colData(seq_ds) <- col_data

seq_ds_qn <- quantileNormalize(seq_ds)
seq_pval_res <- calcCombPValues(seq_ds_qn)
probe_pval_res <- convertSequenceDSToProbeDS(seq_pval_res)
probe_calls_res <- makeProbeCalls(probe_pval_res)
probe_calls_k_of_n <- getKofN(probe_calls_res)
probe_calls_k_of_n <- 
    probe_calls_k_of_n[
        order(probe_calls_k_of_n$K, decreasing = TRUE),]
knitr::kable(head(probe_calls_k_of_n))

## ----session_info-------------------------------------------------------------
sessionInfo()

