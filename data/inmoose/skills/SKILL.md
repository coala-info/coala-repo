---
name: inmoose
description: InMoose is a Python library that provides bioinformatics workflows for batch effect correction, quality control, and differential expression analysis of transcriptomic data. Use when user asks to correct batch effects using ComBat, perform differential expression analysis with limma or DESeq2, evaluate cohort quality, or conduct consensus clustering.
homepage: https://github.com/epigenelabs/inmoose
metadata:
  docker_image: "quay.io/biocontainers/inmoose:0.9.1--py311hc1104ee_0"
---

# inmoose

## Overview

InMoose (Integrated Multi Omic Open Source Environment) is a specialized Python library designed to bring gold-standard bioinformatics workflows—traditionally found in R—into the Python ecosystem. It is primarily used for processing bulk transcriptomic data, offering robust tools to mitigate technical biases (batch effects), evaluate data quality, and identify differentially expressed genes.

## Core Workflows

### Batch Effect Correction
InMoose provides two primary functions for correcting technical variation depending on the data type:

*   **Microarray Data**: Use `pycombat_norm` (the Python implementation of ComBat).
*   **RNASeq Data**: Use `pycombat_seq` (the Python implementation of ComBat-Seq), which is designed for integer count data.

```python
from inmoose.pycombat import pycombat_norm, pycombat_seq

# For Microarray (normalized data)
corrected_microarray = pycombat_norm(expression_df, batch_list)

# For RNASeq (raw counts)
corrected_rnaseq = pycombat_seq(counts_df, batch_list)
```

### Cohort Quality Control (QC)
After batch correction, use the `CohortMetric` and `QCReport` classes to validate the results. This workflow calculates PCA, Silhouette scores, and entropy to ensure biological signal is preserved while technical noise is reduced.

```python
from inmoose.cohort_qc.cohort_metric import CohortMetric
from inmoose.cohort_qc.qc_report import QCReport

# 1. Calculate metrics
metric = CohortMetric(
    clinical_df=metadata,
    batch_column="batch_id",
    data_expression_df=corrected_df,
    data_expression_df_before=original_df,
    covariates=["condition", "cell_type"]
)
metric.process()

# 2. Generate HTML report
report = QCReport(metric)
report.save_report(output_path='qc_results')
```

### Differential Expression Analysis
InMoose provides Python ports for the most common R-based differential expression frameworks:
*   **Microarray**: `limma`
*   **RNASeq**: `edgeR` and `DESeq2`

### Consensus Clustering
To determine the optimal number of clusters and assess clustering stability, use the `consensusClustering` class. It is compatible with scikit-learn clustering algorithms.

```python
from inmoose.consensus_clustering.consensus_clustering import consensusClustering
from sklearn.cluster import AgglomerativeClustering

cc = consensusClustering(AgglomerativeClustering)
cc.compute_consensus_clustering(data_array)
```

## Best Practices

*   **Data Orientation**: Ensure expression matrices follow the standard convention: genes/features as rows and samples as columns.
*   **Batch Indices**: The `batch_list` provided to ComBat functions must be a list of indices or labels corresponding exactly to the columns in your expression matrix.
*   **Metadata Alignment**: When using `CohortMetric`, ensure the index of your `clinical_df` matches the column names of your `data_expression_df`.
*   **Library Selection**: 
    *   Use `pycombat_seq` for raw counts to maintain the distributional properties of RNASeq data.
    *   Use `pycombat_norm` for log-transformed or normalized intensity data.

## Reference documentation
- [InMoose GitHub Repository](./references/github_com_epigenelabs_inmoose.md)
- [InMoose Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_inmoose_overview.md)