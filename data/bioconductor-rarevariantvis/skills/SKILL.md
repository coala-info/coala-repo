---
name: bioconductor-rarevariantvis
description: RareVariantVis is an R suite for the rapid analysis and visualization of rare single nucleotide, structural, and copy number variants in whole genome sequencing data. Use when user asks to filter and annotate rare variants from VCF files, generate static chromosome overviews, or create interactive D3-based visualizations for trio and family analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/RareVariantVis.html
---

# bioconductor-rarevariantvis

## Overview

RareVariantVis is an R suite designed for the rapid analysis and visualization of rare variants in whole genome sequencing (WGS) data. It integrates single nucleotide variants (SNV), structural variants (SV), and copy number variants (CNV) from VCF files (compatible with GATK and speedseq). The package is optimized for speed, capable of processing a whole human genome in under 30 minutes on standard desktop hardware. It provides both static PNG outputs for global chromosome overviews and interactive D3-based HTML visualizations for detailed variant inspection and family/trio analysis.

## Core Workflow

### 1. Data Preparation
The package requires VCF files for SNVs and optionally for SVs.

```r
library(RareVariantVis)

# Define paths to your VCF files
sample_vcf <- "path/to/sample.vcf.gz"
sv_vcf <- "path/to/sample.sv.vcf.gz"
```

### 2. Chromosome-Level Analysis
The `chromosomeVis` function is the primary engine for filtering and annotating variants. It generates text reports and static visualizations.

```r
# Analyze specific chromosomes (e.g., chromosome 19)
chromosomeVis(
  sample = sample_vcf, 
  sv_sample = sv_vcf, 
  chromosomes = c("19")
)
```

**Outputs generated:**
* `RareVariants_[Sample].txt`: SNVs passing filters (coding/UTR, nonsynonymous, dbSNP/ExAC freq < 0.01).
* `ComplexVariants_[Sample].txt`: Variants with multiple alternative alleles.
* `StructuralVariants_[Sample].txt`: DUP/DEL variants overlapping coding regions.
* `[Sample]_chr[N].png`: Static plot showing variant distribution and allele frequency ratios.

### 3. Interactive Visualization
To explore variants interactively (zoom, hover for gene names), use the `rareVariantVis` function on the output text files.

```r
rareVariantVis(
  input = "RareVariants_SampleName.txt",
  output = "RareVariants_Visualization.html",
  sampleName = "SampleName"
)
```

### 4. Multiple Sample Comparison
For trio analysis or cohort comparison, use `multipleVis` to view variants from different samples on the same interactive plot.

```r
inputFiles <- c("RareVariants_S1.txt", "RareVariants_S2.txt")
sampleNames <- c("Subject_1", "Subject_2")

multipleVis(
  inputFiles = inputFiles, 
  outputFile = "Comparison.html", 
  sampleNames = sampleNames, 
  chromosome = "19"
)
```

## Interpreting Visualizations

* **X-axis:** Genomic coordinates.
* **Y-axis:** Allele ratio (Alternative Reads / Total Depth). 
    * ~0.5 indicates a heterozygous variant.
    * ~1.0 indicates a homozygous alternative variant.
* **Blue Dots:** All discovered variants.
* **Green Dots:** Rare variants passing filters (coding, low frequency).
* **Orange Dots:** Structural/Copy Number variants overlapping coding regions.
* **Red Curve:** Moving average of the allele ratio. Values > 0.75 typically highlight potential homozygous regions or deletions.

## Tips for Success

* **Resource Efficiency:** If memory is limited, process chromosomes one by one or in small batches using the `chromosomes` argument in `chromosomeVis`.
* **Annotation:** The package automatically pulls annotations from UCSC and UniProt for coding regions, including tissue specificity and involvement in disease. Ensure your R environment has internet access if these databases need to be queried, or ensure the necessary annotation packages are installed.
* **Input Compatibility:** While optimized for speedseq and GATK, ensure your VCFs are properly indexed (.tbi) for efficient access.

## Reference documentation

- [RareVariantVis](./references/RareVariantsVis.md)