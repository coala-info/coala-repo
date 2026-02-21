---
name: bioconductor-biochail
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BiocHail.html
---

# bioconductor-biochail

## Overview

BiocHail provides an R interface to the Hail 0.2 framework, leveraging the `basilisk` package to manage an isolated Python environment containing Hail and its dependencies (including Apache Spark). It allows R users to perform high-throughput genomic analysis on `MatrixTable` objects, which are scalable data structures designed for massive genetic datasets. The package facilitates GWAS workflows, quality control, population stratification assessment (PCA), and integration with Bioconductor visualization tools.

## Core Workflow

### 1. Initialization
Every session must begin by initializing the Hail environment. This handles the underlying Spark and Python configuration.

```r
library(BiocHail)
hl <- hail_init()
```

### 2. Data Acquisition and Loading
You can load example datasets or import your own MatrixTables and VCFs.

*   **Example Data:** `mt <- get_1kg(hl)` loads a slice of 1000 Genomes data.
*   **MatrixTable:** `mt <- hl$read_matrix_table("path/to/data.mt")`
*   **UK Biobank Subset:** `ss <- get_ukbb_sumstat_10kloci_mt(hl)`

### 3. MatrixTable Operations
Hail objects in R use the `$` operator to access Python methods.

*   **Dimensions:** Use `mt$count()` to get row and column counts.
*   **Annotations:** Import external tables and annotate columns (samples) or rows (variants).
    ```r
    annopath <- path_1kg_annotations()
    tab <- hl$import_table(annopath, impute=TRUE)$key_by("Sample")
    # Use reticulate/python syntax for complex annotations
    # r.mt = r.mt.annotate_cols(pheno = r.tab[r.mt.s])
    ```
*   **Aggregation:** Compute statistics across the dataset.
    ```r
    # Count superpopulations
    mt$aggregate_cols(hl$agg$counter(mt$pheno$SuperPopulation))
    ```

### 4. Quality Control and Filtering
QC is essential before running association tests.

*   **Sample QC:** `mt <- hl$sample_qc(mt)` adds metrics like call rate and mean depth.
*   **Variant QC:** `mt <- hl$variant_qc(mt)` adds allele frequencies and HWE p-values.
*   **Filtering:**
    ```r
    # Filter rows by Minor Allele Frequency
    mt <- mt$filter_rows(mt$variant_qc$AF[1] > 0.01)
    ```

### 5. GWAS and PCA
Perform association testing and population structure analysis.

*   **Linear Regression:**
    ```r
    gwas <- hl$linear_regression_rows(
        y = mt$pheno$CaffeineConsumption,
        x = mt$GT$n_alt_alleles(),
        covariates = list(1.0)
    )
    ```
*   **PCA:** Use `hl$hwe_normalized_pca(mt$GT)` to identify population stratification.

## Tips for R-Python Interfacing

*   **Printing Objects:** Printing a Hail object directly in R often provides limited info. Use `mt$describe()` or `mt$show()` for better inspection.
*   **Collecting Data:** To bring data from the distributed Spark environment into your local R session (e.g., for plotting with `ggplot2`), use the `$collect()` method.
    ```r
    p_values <- gwas$p_value$collect()
    hist(p_values)
    ```
*   **Reference Genomes:** When working with non-standard references (like T2T), you may need to update the reference genome using `rg_update` or by reading a JSON configuration.

## Reference documentation

- [01 BiocHail -- GWAS tutorial](./references/gwas_tut.md)
- [02 Working with larger VCF: T2T by chromosome](./references/large_t2t.md)
- [03 Working with UK Biobank summary statistics](./references/ukbb.md)