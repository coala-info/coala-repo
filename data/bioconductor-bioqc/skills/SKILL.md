---
name: bioconductor-bioqc
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BioQC.html
---

# bioconductor-bioqc

name: bioconductor-bioqc
description: Detect tissue heterogeneity and perform gene-set enrichment analysis (GSEA) in gene expression data using the BioQC R package. Use this skill when you need to: (1) Identify potential tissue contamination in transcriptomic samples, (2) Perform fast Wilcoxon-Mann-Whitney (WMW) based gene set enrichment, (3) Work with signed or unsigned gene signatures (GMT files), or (4) Quality control ExpressionSet or numeric matrix data for unexpected tissue signals.

# bioconductor-bioqc

## Overview
BioQC is a Bioconductor package designed to detect tissue heterogeneity (contamination) in high-throughput gene expression data. It uses a highly optimized C-implementation of the Wilcoxon-Mann-Whitney (WMW) test to compare the expression levels of genes in a specific signature against the background of all other genes. It is significantly faster than native R implementations, making it suitable for large-scale datasets and extensive signature libraries.

## Core Workflow

### 1. Loading Signatures
BioQC uses gene signatures typically stored in GMT format. The package provides a built-in set of tissue-specific signatures.

```r
library(BioQC)

# Load default tissue signatures
gmtFile <- system.file("extdata/exp.tissuemark.affy.roche.symbols.gmt", package="BioQC")
gmt <- readGmt(gmtFile)

# For signed gene sets (up/down regulated)
# gmtSigned <- readSignedGmt("path/to/signed.gmt")
```

### 2. Preparing Data
BioQC accepts `ExpressionSet` objects or standard numeric matrices. Ensure your data is normalized (e.g., RMA or TPM). While BioQC is non-parametric and robust to log-transformation, consistency in preprocessing is recommended.

```r
# Example with a matrix
# expr_matrix <- exprs(your_eset) 
```

### 3. Running the WMW Test
The `wmwTest` function is the primary interface. It calculates the enrichment of signatures in each sample.

```r
# Run the test
# valType="p.greater" for standard enrichment
bioqcRes <- wmwTest(myEset, gmt, valType="p.greater")

# For signed gene sets, use valType="Q" to get a signed score
# Q = sign * abs(log10(p-value))
# bioqcResQ <- wmwTest(myEset, signedIndex, valType="Q")
```

### 4. Processing and Visualizing Results
Results are typically transformed into "BioQC scores" (absolute log10 p-values) for easier interpretation and visualization.

```r
# Filter and transform
bioqcResFil <- filterPmat(bioqcRes, 1E-6)
bioqcAbsLogRes <- absLog10p(bioqcResFil)

# Heatmap visualization
library(RColorBrewer)
heatmap(bioqcAbsLogRes, 
        col=rev(brewer.pal(7, "RdBu")),
        main="BioQC Tissue Enrichment Scores")
```

## Advanced Usage

### Signed Gene Sets
When using signed gene sets, use `matchGenes` to map signature symbols to the indices of your expression object before running `wmwTest`.

```r
# Map genes to indices
testIndex <- matchGenes(signedGenesets, testEset)

# Run test with Q-values
resQ <- wmwTest(testEset, testIndex, valType="Q")
```

### Performance Tips
- **Speed**: BioQC is optimized to sort the background genes only once per sample. This makes it ~500x faster than `wilcox.test` for large signature sets.
- **Background**: The choice of background genes matters. If you filter out lowly expressed genes before analysis, the p-values will change. It is generally recommended to use the full set of genes as the background.
- **Interpretation**: A high score for a tissue other than the target tissue (e.g., a pancreas signature appearing in a kidney sample) suggests potential contamination or infiltration.

## Reference documentation
- [BioQC-kidney: The kidney expression example](./references/BioQC.md)
- [BioQC Algorithm: Speeding up the Wilcoxon-Mann-Whitney Test](./references/bioqc-efficiency.md)
- [BioQC: Detect tissue heterogeneity in gene expression data](./references/bioqc-introduction.md)
- [Using BioQC with signed genesets](./references/bioqc-signedGenesets.md)
- [BioQC-benchmark: Testing Efficiency, Sensitivity and Specificity](./references/bioqc-simulation.md)
- [Comparing the Wilcoxon-Mann-Whitney to alternative statistical tests](./references/bioqc-wmw-test-performance.md)