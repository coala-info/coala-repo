---
name: bioconductor-ensemblvep
description: The ensemblVEP package provides an R interface to the Ensembl Variant Effect Predictor for annotating genomic variants and predicting their functional consequences. Use when user asks to perform variant annotation, predict variant consequences, or parse VEP results into Bioconductor objects like GRanges and VCF.
homepage: https://bioconductor.org/packages/3.6/bioc/html/ensemblVEP.html
---

# bioconductor-ensemblvep

## Overview

The `ensemblVEP` package provides an R interface to the Ensembl Variant Effect Predictor (VEP). It allows users to perform variant annotation and consequence prediction by wrapping the `vep` Perl script. Results can be seamlessly integrated into the Bioconductor ecosystem as `GRanges` or `VCF` objects.

**Prerequisite:** The Ensembl VEP Perl script must be installed and accessible in the system PATH.

## Core Workflow

### 1. Configuration with VEPParam or VEPFlags
The package uses parameter objects to manage VEP runtime options. The choice of object depends on the Ensembl version:
*   **Ensembl < 90:** Use `VEPParam(version=88)`. Options are organized into slots like `input`, `output`, `database`, etc.
*   **Ensembl >= 90:** Use `VEPFlags()`. Options are passed as a list to the `flags` argument.

```R
library(ensemblVEP)

# For newer VEP versions (>= 90)
param <- VEPFlags(flags = list(
    vcf = TRUE,             # Return results as VCF
    symbol = TRUE,          # Add HGNC gene identifiers
    terms = "SO"            # Use Sequence Ontology terms
))
```

### 2. Running the Predictor
The `ensemblVEP()` function is the primary entry point. It accepts a file path (VCF or other VEP-supported formats) and a parameter object.

```R
fl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation")

# Returns a GRanges by default
gr <- ensemblVEP(fl, param)
```

### 3. Parsing VCF Results
When VEP returns a VCF, the consequence data is stored in an unparsed `CSQ` column within the `INFO` field. Use `parseCSQToGRanges()` to convert this into a structured `GRanges` object.

```R
# If ensemblVEP was called with vcf=TRUE
vcf_results <- ensemblVEP(fl, param)

# Parse the CSQ info into metadata columns
csq_gr <- parseCSQToGRanges(vcf_results)

# To map back to original VCF rows, use VCFRowID
vcf_orig <- VariantAnnotation::readVcf(fl, "hg19")
csq_gr <- parseCSQToGRanges(vcf_results, VCFRowID = rownames(vcf_orig))
```

### 4. Writing to File
To bypass R memory and write directly to disk, set the `output_file` flag.

```R
# Write as a tab-delimited file
param_file <- VEPFlags(flags = list(output_file = "results.txt"))
ensemblVEP(fl, param_file)

# Write as VCF to disk
param_vcf <- VEPFlags(flags = list(
    output_file = "results.vcf",
    vcf = TRUE
))
ensemblVEP(fl, param_vcf)
```

## Common Parameter Patterns

*   **Regulatory Regions:** `list(regulatory = TRUE)`
*   **Coding Only:** `list(coding_only = TRUE)`
*   **Check Existing Variants:** `list(check_existing = TRUE)`
*   **SIFT/PolyPhen:** `list(sift = "b", polyphen = "p")` (b = both, p = prediction)
*   **Specific Species:** `list(species = "mus_musculus")`

## Troubleshooting

*   **Format Detection:** If VEP fails to detect the input format, explicitly set it: `list(format = "vcf")`.
*   **Script Path:** If the `vep` script is not in the PATH, it can be specified in the `scriptPath` slot of the parameter object.
*   **Version Mismatch:** Ensure the `version` argument in `VEPParam` or the logic in `VEPFlags` matches your installed VEP version.

## Reference documentation
- [Overview of ensemblVEP Pre Ensembl 90](./references/PreV90EnsemblVEP.md)
- [Overview of ensemblVEP](./references/ensemblVEP.md)