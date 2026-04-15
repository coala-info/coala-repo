---
name: r-dimsum
description: DiMSum is an R-based pipeline and error model for processing and analyzing Deep Mutational Scanning data to estimate variant fitness. Use when user asks to process raw sequencing reads into variant counts, estimate variant fitness and error from counts, or diagnose experimental pathologies in mutational scanning data.
homepage: https://cran.r-project.org/web/packages/dimsum/index.html
---

# r-dimsum

name: r-dimsum
description: Analyzing Deep Mutational Scanning (DMS) data using the DiMSum error model and pipeline. Use this skill when you need to process raw sequencing reads (FASTQ) or variant counts to estimate variant fitness and associated error, diagnose experimental pathologies, or prepare data for downstream epistasis and protein structure modeling.

# r-dimsum

## Overview
DiMSum (Deep Mutational Scanning Summation) is an R-based pipeline and error model designed to process and analyze data from Deep Mutational Scanning (DMS) experiments. It handles the transition from raw sequencing reads to high-quality fitness estimates by modeling both Poisson (sampling) and overdispersion (experimental) noise.

The pipeline is divided into two main modules:
1. **WRAP**: Processes raw FASTQ files into variant counts.
2. **STEAM**: Analyzes variant counts to produce fitness and error estimates.

## Installation
To install the R package:
```R
install.packages("dimsum")
```
Note: DiMSum has several external dependencies (FastQC, vsearch, starcode) required for the WRAP module.

## Workflow and Functions

### 1. Experimental Design
Before running the pipeline, you must define your experimental design. This is typically a tab-separated file containing:
- `sample_name`: Unique identifier for each sequencing sample.
- `fastq1`: Filename of the first read (forward).
- `fastq2`: Filename of the second read (reverse).
- `replicate`: Replicate number.
- `selection_id`: Identifier for the selection condition (e.g., 'input', 'output').
- `selection_time`: Time point or selection strength.

### 2. Running the Pipeline
The primary interface is the `DiMSum()` function. It can be run in different modes depending on your starting point.

**From FASTQ files (Full Pipeline):**
```R
library(dimsum)

DiMSum(
  fastqFileDir = "path/to/fastq",
  experimentDesignPath = "experimentDesign.txt",
  wildtypeSequence = "ATGC...", # DNA sequence
  projectName = "MyDMSProject",
  outputPath = "./results"
)
```

**From Variant Counts (STEAM module only):**
If you already have a table of counts, use the `variantCountsPath` argument:
```R
DiMSum(
  variantCountsPath = "counts.txt",
  experimentDesignPath = "experimentDesign.txt",
  wildtypeSequence = "ATGC...",
  projectName = "MyDMSProject"
)
```

### 3. Key Arguments
- `wildtypeSequence`: The reference DNA sequence of the mutated region.
- `sequenceType`: Set to "DNA" (default) or "AA" (protein).
- `mutagenesisType`: "random" (default) or "targeted" (e.g., site-directed).
- `indels`: Set to "none", "all", or "wt" to control how insertions/deletions are handled.
- `maxSubstitutions`: Maximum number of substitutions allowed per variant (default: 2).

### 4. Output Analysis
DiMSum produces a `fitness_estimates.txt` file containing:
- `fitness`: The estimated fitness value.
- `sigma`: The estimated standard error.
- `p_value`: Significance of the fitness change relative to wild-type.

## Tips for Success
- **Wild-type sequence**: Ensure the `wildtypeSequence` provided matches the exact DNA sequence used in the library, including any constant flanking regions if they are present in the reads.
- **Memory Management**: For large FASTQ files, DiMSum can be memory-intensive. Use the `numCores` argument to parallelize processing where possible.
- **Diagnostics**: Review the generated PDF reports in the output directory to check for common pathologies like low library complexity or high sequencing error rates.

## Reference documentation
- [Command-line Arguments](./references/ARGUMENTS.md)
- [Demo Guide](./references/DEMO.md)
- [File Formats](./references/FILEFORMATS.md)
- [Installation Instructions](./references/INSTALLATION.md)
- [Pipeline Stages](./references/PIPELINE.md)
- [Package README](./references/README.md)
- [Related Articles](./references/articles.md)
- [Project Home Page](./references/home_page.md)