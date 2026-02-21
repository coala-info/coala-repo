---
name: bioconductor-camutqc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CaMutQC.html
---

# bioconductor-camutqc

## Overview

CaMutQC is a Bioconductor package designed for the integrative quality control and filtration of cancer somatic mutations. It transforms VEP-annotated VCF files into Mutation Annotation Format (MAF) data frames and provides a suite of functions to eliminate false positives and select high-confidence driver mutations. The package supports common technical filters, cancer-type-specific strategies, and reference-based filtration from published studies.

## Core Workflow

### 1. Data Input and Conversion
The primary input is a VEP-annotated VCF file. CaMutQC converts these to MAF data frames, which are used for all subsequent filtering.

```r
library(CaMutQC)

# Convert single VCF to MAF
maf_data <- vcfToMAF(system.file("extdata", "sample.vep.vcf", package="CaMutQC"))

# Convert multiple VCFs (multi-caller or multi-sample) from a directory
vcf_path <- system.file("extdata/Multi-caller", package="CaMutQC")
multi_maf <- vcfToMAF(vcf_path, multiVCF = TRUE)
```

### 2. Technical Artifact Filtration
Use `mutFilterTech` or individual sub-functions to flag artifacts. Variants that fail a filter are labeled with specific flags in the `CaTag` column (starting from '0').

*   **`mutFilterQual` (Flag: Q):** Filters by depth (DP), allele depth (AD), and VAF. Supports panels: "Customized", "WES", "MSKCC".
*   **`mutFilterSB` (Flag: S):** Detects strand bias using SOR (default) or Fisher Strand Test.
*   **`mutFilterAdj` (Flag: A):** Filters SNVs near indels (misalignment artifacts).
*   **`mutFilterNormalDP` (Flag: N):** Filters based on normal sample sequencing depth.
*   **`mutFilterPON` (Flag: P):** Filters variants found in a Panel of Normals.

```r
# Apply technical filters
maf_tech <- mutFilterTech(maf_data, panel = "WES", PONfile = "path/to/pon.txt")
table(maf_tech$CaTag)
```

### 3. Candidate Variant Selection
Use `mutSelection` to isolate mutations likely involved in tumorigenesis.

*   **`mutFilterDB` (Flag: D):** Filters common germline variants (ExAC, 1000G, gnomAD) while preserving COSMIC variants.
*   **`mutFilterType` (Flag: T):** Filters by classification (e.g., keeping only 'nonsynonymous' or 'exonic').
*   **`mutFilterReg` (Flag: R):** Restricts analysis to specific genomic regions (BED file).

```r
# Select candidate variants
maf_selec <- mutSelection(maf_data, keepType = 'nonsynonymous', dbVAF = 0.01)
```

### 4. Integrated and Customized Filtration
The `mutFilterCom` function combines technical and selection filters into one step and can generate a detailed HTML report.

```r
# Comprehensive filtration
final_maf <- mutFilterCom(maf_data, panel = "WES", report = TRUE, TMB = TRUE)

# Cancer-type specific (e.g., LAML, BRCA, COADREAD)
maf_laml <- mutFilterCan(maf_data, cancerType = 'LAML')

# Reference-based (matching specific published study criteria)
maf_ref <- mutFilterRef(maf_data, reference = "Zhu_et_al-Nat_Commun-2020-KIRP")
```

### 5. Tumor Mutational Burden (TMB)
Calculate TMB (mutations/Mb) using various assay standards.

```r
# Calculate TMB using MSK-IMPACT or WES standards
tmb_val <- calTMB(maf_data, assay = 'WES')
# Or customized BED
tmb_custom <- calTMB(maf_data, assay = 'Customized', bedFile = "target_regions.rds")
```

### 6. Multi-Caller Union Strategy
To improve sensitivity and reduce single-caller bias, filter outputs from multiple callers (e.g., MuTect2, VarScan2, MuSE) and take their union.

```r
# Combine filtered MAFs from different callers
maf_list <- list(maf_mutect2_f, maf_muse_f, maf_varscan2_f)
union_maf <- processMut(maf_list, processMethod = "union")
```

## Interpretation of Results
*   **CaTag Column:** A value of `0` indicates the variant passed all applied filters. Any other string (e.g., `0QS`) indicates the specific filters failed (Q = Quality, S = Strand Bias).
*   **Filter Report:** If `report = TRUE` in `mutFilterCom`, an HTML file is generated providing summary statistics and visualization of the filtering process.

## Reference documentation
- [CaMutQC: Cancer Somatic Mutation Quality Control](./references/CaMutQC-manual.md)
- [CaMutQC Manual (RMarkdown Source)](./references/CaMutQC-manual.Rmd)