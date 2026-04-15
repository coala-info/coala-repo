---
name: bioconductor-ramwas
description: RaMWAS provides a comprehensive toolset for large-scale methylome-wide association studies (MWAS) using enrichment-based assays like MBD-seq. Use when user asks to scan BAM files for quality control, generate normalized CpG coverage matrices, perform PCA for technical variation, conduct association testing, or build methylation risk score prediction models.
homepage: https://bioconductor.org/packages/release/bioc/html/ramwas.html
---

# bioconductor-ramwas

name: bioconductor-ramwas
description: Expert guidance for the RaMWAS R package for Methylome-Wide Association Studies (MWAS). Use this skill when performing methylome analysis on enrichment-based assays (like MBD-seq), including BAM scanning, quality control, CpG score matrix generation, PCA for technical variation, association testing (MWAS), and methylation risk score (MRS) prediction.

# bioconductor-ramwas

## Overview

RaMWAS (Rapid Methylome-Wide Association Study) is a comprehensive toolset designed for large-scale methylome analysis, particularly optimized for enrichment-based methylation assays (e.g., MBD-seq). It utilizes the `filematrix` package to handle large datasets efficiently through parallel processing and memory-mapped files. The workflow is structured into discrete, sequential steps that transform raw BAM files into association results and predictive models.

## Core Workflow

The RaMWAS pipeline follows a numbered sequence of functions. Most functions require a parameter object created by `ramwasParameters()`.

### 1. Project Initialization
Define the project parameters. This object controls directory paths, CPU threads, and statistical model settings.

```r
library(ramwas)
param = ramwasParameters(
    dirproject = "path/to/project",
    dirbam = "bams",
    filebamlist = "bam_list.txt",
    filecpgset = "cpg_locations.rds",
    cputhreads = 4,
    modeloutcome = "phenotype_column",
    modelcovariates = c("age", "sex"),
    modelPCs = 0 # Number of PCs to include in MWAS
)
```

### 2. BAM Scanning and QC (Steps 1 & 2)
Scan BAM files to extract read start locations and calculate quality control metrics.

```r
# Step 1: Scan BAMs (creates rqc and rbam files)
ramwas1scanBams(param)

# Step 2: Summarize QC (generates plots and fragment size estimates)
ramwas2collectqc(param)
```

### 3. Coverage Matrix Generation (Step 3)
Create a normalized CpG score (coverage) matrix. This step filters out CpGs with low coverage across samples.

```r
ramwas3normalizedCoverage(param)
```

### 4. PCA and Association Testing (Steps 4 & 5)
Perform PCA to identify technical variation and run the association study.

```r
# Step 4: PCA (to identify batch effects or outliers)
ramwas4PCA(param)

# Step 5: MWAS (Association testing)
ramwas5MWAS(param)
```

### 5. Annotation and Prediction (Steps 6 & 7)
Annotate top findings using BioMart and build predictive models (Methylation Risk Scores).

```r
# Step 6: Annotate top hits
ramwas6annotateTopFindings(param)

# Step 7: Multi-marker analysis (Elastic Net cross-validation)
ramwas7riskScoreCV(param)
```

## Key Functions and Tips

- **CpG Sets**: RaMWAS requires a predefined set of CpG locations. You can create one from a BSgenome object using `getCpGsetCG(genome)`.
- **Filematrix**: Data is stored in `filematrix` format. Use `fm.load()` or `fm.open()` to access coverage matrices or results manually.
- **Parameter Preprocessing**: Use `pfull = parameterPreprocess(param)` to resolve relative paths and see exactly where RaMWAS is looking for files.
- **Parallelization**: The `cputhreads` parameter is critical for performance during BAM scanning and MWAS steps.
- **QC Interpretation**: Check the `coverage_by_density` plots in the `qc` folder. A successful enrichment shows a clear increase in coverage as CpG density increases.

## Reference documentation

- [RaMWAS Overview](./references/RW1_intro.md)
- [CpG Sets](./references/RW2_CpG_sets.md)
- [BAM Quality Control Measures](./references/RW3_BAM_QCs.md)
- [CpG-SNP Analysis](./references/RW4_SNPs.md)
- [Matrix Data Handling](./references/RW5a_matrix.md)
- [Parameter Specifications](./references/RW6_param.md)