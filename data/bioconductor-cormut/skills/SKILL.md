---
name: bioconductor-cormut
description: This tool detects correlated mutations in protein-coding genes by combining Ka/Ks ratio analysis with correlation metrics like mutual information and Jaccard index. Use when user asks to identify sites under positive selection, detect compensatory mutation patterns in viral or bacterial sequences, or compare mutation networks between different treatment conditions.
homepage: https://bioconductor.org/packages/3.8/bioc/html/CorMut.html
---


# bioconductor-cormut

name: bioconductor-cormut
description: Detects correlated mutations in protein-coding genes based on selection pressure (Ka/Ks). Use when analyzing viral or bacterial sequence evolution, identifying drug resistance mutations, or comparing mutation networks between different conditions (e.g., treatment-naive vs. treated populations).

# bioconductor-cormut

## Overview
CorMut is an R package designed to detect correlated mutations among positive selection sites by combining Ka/Ks ratio analysis with correlation metrics. It is particularly useful for studying highly variable viruses (like HIV or HCV) where mutations conferring drug resistance often undergo positive selection and exhibit compensatory mutation patterns.

## Core Workflow

### 1. Data Preprocessing
Convert multiple sequence alignment (MSA) files into the internal format required by CorMut. The `seqFormat` function handles base replacement and gap deletion relative to a reference.

```r
library(CorMut)
# Load alignment file (e.g., .aln or .fasta)
example_file <- system.file("extdata", "PI_treatment.aln", package="CorMut")
seq_data <- seqFormat(example_file)
```

### 2. Selection Pressure Analysis (Ka/Ks)
Compute the Ka/Ks ratio for individual codon positions or specific amino acid substitutions to identify sites under positive selection (Ka/Ks > 1).

*   **Codon level:** `kaksCodon(seq_data)`
*   **Amino acid level:** `kaksAA(seq_data)`
*   **Filtering:** Use `filterSites()` to extract significant sites (typically LOD > 2).

```r
result <- kaksAA(seq_data)
significant_sites <- filterSites(result)
```

### 3. Detecting Correlated Mutations
CorMut provides three primary methods to detect dependencies between mutations:

*   **Conditional Ka/Ks (ckaks):** Measures selection pressure at one site given a mutation at another.
    *   `ckaksCodon(seq_data)` or `ckaksAA(seq_data)`
*   **Mutual Information (MI):** Measures mutual dependence between random variables (codons/AA).
    *   `miCodon(seq_data)` or `miAA(seq_data)`
*   **Jaccard Index (JI):** Measures similarity between mutation pairs, avoiding exaggeration of rare pairs.
    *   `jiAA(seq_data)`

### 4. Comparative Network Analysis
Compare mutation correlations between two different conditions (e.g., treatment-naive vs. treated).

```r
# Process two datasets
naive_data <- seqFormat(naive_file)
treated_data <- seqFormat(treated_file)

# Compute conditional Ka/Ks for both
bi_result <- biCkaksAA(naive_data, treated_data)

# Compare and visualize
comparison <- biCompare(bi_result)
plot(comparison)
```

## Interpretation of Results
*   **LOD Score:** A confidence score for positive selection. LOD > 2 is generally considered significant.
*   **Network Plots:** When plotting `biCompare` results:
    *   **Blue nodes:** Positive selection sites unique to the first condition.
    *   **Red nodes:** Positive selection sites unique to the second condition.
    *   **Edges:** Represent the correlation strength between mutations.

## Reference documentation
- [CorMut](./references/CorMut.md)