---
name: bioconductor-generegionscan
description: GeneRegionScan performs high-resolution, probe-level analysis of specific genomic regions to investigate alternative splicing and eQTLs. Use when user asks to analyze probe-level expression data, visualize intensities across gene structures, test for genotype-specific expression, or identify co-expression patterns within genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/GeneRegionScan.html
---


# bioconductor-generegionscan

## Overview

GeneRegionScan is a specialized Bioconductor package designed for high-resolution analysis of specific genomic regions rather than whole-genome screening. It focuses on **probe-level data**, making it particularly powerful for detecting alternative splicing events and investigating how SNPs (genotypes) influence the expression of specific exons. The package introduces the `ProbeLevelSet` class, which extends `ExpressionSet` to include probe sequences and genomic coordinates.

## Core Workflow

### 1. Creating a ProbeLevelSet
A `ProbeLevelSet` contains the raw or normalized intensities of every probe in a region, along with their sequences.

*   **From Local Files:** Use `getLocalProbeIntensities` to extract data from CEL files. This requires Affymetrix Power Tools (APT) and the relevant PGF/CLF files.
*   **Adding Metadata:** Since it inherits from `ExpressionSet`, you can add sample metadata (pData) using standard methods or use `addSnpPdata` to import HapMap-formatted SNP data for eQTL analysis.

### 2. Visualizing Expression on Genes
The primary tool for analysis is `plotOnGene`. It maps probe intensities directly onto an mRNA or genomic sequence.

```r
# Basic plot: Median expression across the gene
plotOnGene(probeLevelSet, mrna_sequence)

# Zooming in on a specific region (e.g., first 1000 bp)
plotOnGene(probeLevelSet, mrna_sequence, summaryType="dots", interval=c(1, 1000))

# Adding Exon Structure (requires a DNAStringSet of exons)
exonStructure(mrna_sequence, genomic_exons)
```

### 3. Testing for Differential Splicing or eQTLs
You can group samples by metadata (e.g., "case" vs "control" or "genotype") to see if specific parts of a gene are regulated differently.

```r
# Compare expression by gender using a Wilcoxon test
plotOnGene(probeLevelSet, mrna_sequence, label="gender", testType="wilcoxon")

# Investigate genotype-specific expression (eQTL)
plotOnGene(probeLevelSet, mrna_sequence, label="genotype_id", testType="linear model")
```
*Probes showing significant correlation to the label will be circled in the plot.*

### 4. Co-expression Analysis
To find probes that behave similarly (suggesting they belong to the same splice variant), use `plotCoexpression`.

```r
# Calculate Pearson correlation between all probes in a region
plotCoexpression(probeLevelSet, gene=mrna_subset, correlationCutoff=0.5)
```

### 5. Batch Processing
The `geneRegionScan` function acts as a wrapper to perform the full analysis (plotting expression, testing labels, and calculating co-expression) for multiple genes and output the results to a single PDF.

## Tips for Success
*   **Sequence Data:** Obtain mRNA and genomic sequences from the UCSC Genome Browser. For `exonStructure` to work, the genomic sequence should be a `DNAStringSet` where each entry is one exon.
*   **Memory Efficiency:** `getLocalProbeIntensities` uses APT to extract only the necessary probes, which is much more memory-efficient than loading entire CEL files into R.
*   **Probe Matching:** The package automatically matches probe sequences to the provided mRNA/genomic sequence. If few probes match, verify that you are using the correct isoform sequence.

## Reference documentation
- [GeneRegionScan](./references/GeneRegionScan.md)