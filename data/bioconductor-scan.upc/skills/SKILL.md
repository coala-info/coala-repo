---
name: bioconductor-scan.upc
description: The SCAN.UPC package normalizes gene-expression data at the single-sample level and estimates the probability of gene activation. Use when user asks to normalize Affymetrix or Agilent microarrays, generate universal expression codes for cross-platform integration, or process RNA-Seq count data for biological signal detection.
homepage: https://bioconductor.org/packages/release/bioc/html/SCAN.UPC.html
---

# bioconductor-scan.upc

## Overview

The `SCAN.UPC` package provides methods for normalizing gene-expression data at the single-sample level. Unlike methods that require batches of arrays (like RMA), SCAN and UPC process each sample independently, ensuring that results for a specific sample remain constant regardless of the cohort size.

- **SCAN (Single-Channel Array Normalization):** Corrects for technical biases (like G/C content) to provide standardized expression values. Best for single-platform microarray studies.
- **UPC (Universal exPression Codes):** Uses a mixture model to estimate the probability (0 to 1) that a gene is "active" (biological signal vs. background noise). Best for cross-platform integration (e.g., combining Microarray and RNA-Seq).

## Core Workflows

### 1. Affymetrix Microarray Normalization
You can process local CEL files or download directly from GEO using identifiers.

```r
library(SCAN.UPC)

# Normalize a single CEL file
normalized_data = SCAN("path/to/sample.CEL")

# Download and normalize from GEO in one step
normalized_data = SCAN("GSM555237")

# Process multiple files (returns an ExpressionSet)
batch_data = SCAN("GSE22309")
```

### 2. Agilent Two-Color Normalization
SCAN corrects for dye biases and inter-channel correlation in two-color setups.

```r
# Normalize Agilent two-color data from GEO
agilent_data = SCAN_TwoColor("GSM1072833")
```

### 3. Generating Universal exPression Codes (UPC)
UPC functions follow the same syntax as SCAN but return probabilities of activation.

```r
# For Affymetrix
upc_affy = UPC("GSM555237")

# For Agilent Two-Color
upc_agilent = UPC_TwoColor("GSM1072833")

# For RNA-Seq (requires a count file: Col 1 = ID, Col 2 = Counts)
# Optional: Provide an annotation file with Length and GC count for bias correction
upc_rnaseq = UPC_RNASeq("ReadCounts.txt", "Annotation.txt")
```

### 4. Generic UPC Transformation
If you have already pre-processed data in an `ExpressionSet`, you can convert it to UPCs.

```r
upc_generic = UPC_Generic(expression_matrix)
```

## Performance and Optimization

### Faster Processing
SCAN can be computationally intensive due to probe-level modeling. Use the "fast" variants to reduce processing time by ~75% with minimal loss in accuracy (r > 0.99).

```r
# Faster versions of the main functions
fast_norm = SCANfast("GSM555237")
fast_upc = UPCfast("GSM555237")
```

### Parallel Execution
Process multiple CEL files simultaneously by registering a parallel backend.

```r
library(doParallel)
registerDoParallel(cores = 4)

# SCAN will automatically detect the parallel backend
result = SCAN("GSE22309")
```

## Advanced Mapping (BrainArray)
To use updated gene-level mappings instead of default manufacturer probesets, use `InstallBrainArrayPackage`.

```r
# Download and install a specific version (e.g., version 15.0.0, Homo sapiens, EntrezG)
pkgName = InstallBrainArrayPackage("sample.CEL", "15.0.0", "hs", "entrezg")

# Apply during normalization
normalized = SCAN("sample.CEL", probeSummaryPackage = pkgName)
```

## Tips and Best Practices
- **Single Sample Consistency:** Because SCAN/UPC are single-sample methods, you can add new samples to a study later without re-normalizing the original samples.
- **Output to File:** Use the `outFilePath` parameter in `SCAN()` or `UPC()` to save results directly to a text file.
- **RNA-Seq Inputs:** Ensure RNA-Seq data are raw read counts, not RPKM/FPKM, when using `UPC_RNASeq`.

## Reference documentation
- [Introduction to the SCAN.UPC Package](./references/SCAN.vignette.md)