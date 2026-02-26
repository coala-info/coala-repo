---
name: bioconductor-easier
description: This tool analyzes tumor RNA-seq data to predict patient response to immune checkpoint inhibitors and identify systems biomarkers of the tumor microenvironment. Use when user asks to compute immune cell fractions, estimate pathway or transcription factor activities, calculate ligand-receptor interaction scores, or predict immune response hallmarks.
homepage: https://bioconductor.org/packages/release/bioc/html/easier.html
---


# bioconductor-easier

name: bioconductor-easier
description: Use when analyzing tumor RNA-seq data to predict patient response to immune checkpoint inhibitors (ICB) and identify systems biomarkers. This skill provides workflows for computing quantitative descriptors of the tumor microenvironment (TME), including pathway activity, immune cell fractions, transcription factor activity, and ligand-receptor interactions.

# bioconductor-easier

## Overview

The `easier` (Estimate Systems Immune Response) package provides a toolset to derive high-level representations of anti-tumor immune responses from bulk RNA-seq data. It integrates patient data with biological prior knowledge to extract quantitative descriptors of the tumor microenvironment (TME). These descriptors are used by cancer-specific models to predict immune response hallmarks and identify interpretable systems biomarkers.

## Data Preparation

The package requires HGNC gene symbols as row names and sample identifiers as column names.

- **RNA_counts**: data.frame of raw counts.
- **RNA_tpm**: data.frame of TPM values.
- **patient_response**: (Optional) Character vector with "R" (responder) and "NR" (non-responder).
- **TMB**: (Optional) Numeric vector of Tumor Mutational Burden values.

## Typical Workflow

### 1. Compute TME Descriptors
Extract quantitative features from the expression data:

```r
# 1. Immune cell fractions (quanTIseq)
cell_fractions <- compute_cell_fractions(RNA_tpm = RNA_tpm)

# 2. Pathway activities (PROGENy)
pathway_activities <- compute_pathway_activity(RNA_counts = RNA_counts)

# 3. Transcription Factor (TF) activities (DoRothEA)
tf_activities <- compute_TF_activity(RNA_tpm = RNA_tpm)

# 4. Ligand-Receptor (LR) pair weights
lrpair_weights <- compute_LR_pairs(RNA_tpm = RNA_tpm, cancer_type = "pancan")

# 5. Cell-Cell (CC) interaction scores
ccpair_scores <- compute_CC_pairs(lrpairs = lrpair_weights, cancer_type = "pancan")
```

### 2. Predict Immune Response
Use the computed descriptors to predict response based on cancer-specific models (e.g., "BLCA", "SKCM", "LUAD").

```r
predictions <- predict_immune_response(
  pathways = pathway_activities,
  immunecells = cell_fractions,
  tfs = tf_activities,
  lrpairs = lrpair_weights,
  ccpairs = ccpair_scores,
  cancer_type = "BLCA"
)
```

### 3. Assess and Retrieve Scores
Evaluate the predictions or integrate them with TMB data.

```r
# Evaluate against clinical response (if available)
evaluation <- assess_immune_response(
  predictions_immune_response = predictions,
  patient_response = patient_ICBresponse,
  RNA_tpm = RNA_tpm,
  TMB_values = TMB,
  easier_with_TMB = "weighted_average"
)

# Retrieve final scores
scores <- retrieve_easier_score(
  predictions_immune_response = predictions,
  TMB_values = TMB,
  easier_with_TMB = "weighted_average"
)
```

### 4. Identify Systems Biomarkers
Visualize the features driving the immune response predictions.

```r
biomarkers <- explore_biomarkers(
  pathways = pathway_activities,
  immunecells = cell_fractions,
  tfs = tf_activities,
  lrpairs = lrpair_weights,
  ccpairs = ccpair_scores,
  cancer_type = "BLCA",
  patient_label = patient_ICBresponse
)
```

## Key Functions and Parameters

- `compute_scores_immune_response()`: Calculates published gold-standard signatures (CYT, TLS, IFNy, etc.).
- `cancer_type`: Must be a valid TCGA code (e.g., BLCA, BRCA, CESC, CRC, GBM, HNSC, KIRC, KIRP, LIHC, LUAD, LUSC, NSCLC, OV, PAAD, PRAD, SKCM, STAD, THCA, UCEC).
- `easier_with_TMB`: Options include "weighted_average" or "penalized_score" to integrate TMB data into the final prediction.

## Tips
- Use `easierData::get_opt_models()` to inspect the available cancer-specific models.
- Ensure gene symbols are updated; the package includes an internal `reannotate_genes` helper (accessible via `easier:::reannotate_genes`) if symbols are deprecated.
- When computing pathway activity, `remove_sig_genes_immune_response = TRUE` (default) prevents data leakage by removing genes that are part of the immune response hallmarks being predicted.

## Reference documentation
- [easier User Manual](./references/easier_user_manual.md)