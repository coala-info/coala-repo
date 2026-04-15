---
name: bioconductor-geotcgadata
description: This package provides utilities for preprocessing, normalizing, and performing differential analysis on GEO and TCGA multi-omics data. Use when user asks to identify differentially expressed genes, analyze differential methylation or copy number variations, convert TCGA IDs, normalize counts to FPKM or TPM, and handle multi-probe mapping in GEO chip data.
homepage: https://bioconductor.org/packages/release/bioc/html/GeoTcgaData.html
---

# bioconductor-geotcgadata

## Overview

The `GeoTcgaData` package is designed to bridge the gap between raw data downloaded from GEO or TCGA and the formatted matrices required for bioinformatics analysis. It provides utilities for differential analysis across multiple data types (RNA-seq, Methylation, Copy Number Variation, and Single Nucleotide Variation) and essential preprocessing tools for GEO chip data and TCGA ID conversion.

## Core Workflows

### 1. RNA-seq Differential Analysis
Use `differential_RNA` to identify differentially expressed genes. It supports Wilcoxon tests and can handle both standard data frames and `SummarizedExperiment` objects.

```r
library(GeoTcgaData)

# Using a data frame
result <- differential_RNA(counts = df, group = group_vector, filte = FALSE, method = "Wilcoxon")

# Using SummarizedExperiment
result <- differential_RNA(counts = se_object, groupCol = "group_column_name", method = "Wilcoxon")
```

### 2. DNA Methylation Integration
The package integrates CpG-level data into gene-level differential methylation results. It offers two models: "cpg" (calculates diff CpG then diff gene) and "gene" (calculates gene methylation level then diff gene). The "gene" model is recommended to avoid CpG number bias.

```r
# Requires ChAMP for some internal processing
result <- differential_methy(cpgData = my_cpg_matrix, 
                             sampleGroup = group_vector, 
                             cpg2gene = mapping_df, 
                             model = "gene")
```

### 3. Copy Number (CNV) and SNP Analysis
- **CNV**: Use `differential_CNV` on gene-level copy number scores.
- **SNP**: Use `SNP_QC` for quality control followed by `differential_SNP`.

```r
# CNV
diffCnv <- differential_CNV(cnv_matrix, sampleGroup)

# SNP
qc_snp <- SNP_QC(snp_df)
diff_snp <- differential_SNP(qc_snp, sampleGroup)
```

### 4. GEO Chip Data Preprocessing
GEO data often contains multiple probes for one gene or multiple genes for one probe.
- `gene_ave()`: Averages expression values for multiple IDs/probes mapping to the same gene.
- `repAssign()`: Assigns expression to each gene when a probe maps to multiple symbols (e.g., "GENE1 /// GENE2").
- `repRemove()`: Removes entries where a probe maps to multiple symbols.

```r
# Average probes for the same gene
clean_data <- gene_ave(file_gene_ave, 1) # 1 is the column index of Gene Symbols

# Handle multi-symbol strings
assigned_data <- repAssign(input_file, sep = " /// ")
```

### 5. ID Conversion and Normalization
- **ID Conversion**: `id_conversion_TCGA` converts ENSEMBL IDs to Symbols specifically for TCGA profiles.
- **Normalization**: Convert raw counts to FPKM or TPM using `countToFpkm` and `countToTpm`. These require a `gene_cov` object (provided in the package) for gene length/GC content.

```r
# ID Conversion
symbol_profile <- id_conversion_TCGA(ensembl_profile)

# Normalization
data(gene_cov)
fpkm_data <- countToFpkm(count_matrix, keyType = "SYMBOL", gene_cov = gene_cov)
tpm_data <- countToTpm(count_matrix, keyType = "SYMBOL", gene_cov = gene_cov)
```

## Reference documentation
- [GeoTcgaData Vignette (Rmd)](./references/GeoTcgaData.Rmd)
- [GeoTcgaData Documentation (md)](./references/GeoTcgaData.md)