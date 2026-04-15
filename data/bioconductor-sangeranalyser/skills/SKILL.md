---
name: bioconductor-sangeranalyser
description: This tool performs automated Sanger sequencing data analysis, including quality trimming, read assembly into contigs, and interactive report generation. Use when user asks to assemble Sanger reads, perform quality trimming on AB1 or SCF files, generate chromatogram reports, or export consensus sequences to FASTA format.
homepage: https://bioconductor.org/packages/release/bioc/html/sangeranalyseR.html
---

# bioconductor-sangeranalyser

name: bioconductor-sangeranalyser
description: A specialized skill for using the sangeranalyseR Bioconductor package to perform automated Sanger sequencing data analysis. Use this skill when you need to assemble Sanger reads into contigs, perform quality trimming, align sequences, and generate interactive HTML reports with chromatograms.

# bioconductor-sangeranalyser

## Overview
`sangeranalyseR` is an R package designed for reproducible, high-throughput assembly of Sanger sequencing data. It automates the process of reading AB1/SCF files, performing quality trimming based on Phred scores, and assembling reads into contigs. A key feature is the generation of comprehensive HTML reports that allow for visual inspection of chromatograms and alignment quality.

## Core Workflow

### 1. Data Preparation
Organize your Sanger reads (AB1 or SCF files) into a directory. For multi-contig projects, use a subfolder structure where each folder represents a contig.

### 2. Loading and Analyzing Data
The package uses an object-oriented approach (S4 classes). There are two primary entry points:

- **SangerAlignment**: Use this for projects containing multiple contigs.
- **SangerContig**: Use this for a single contig (forward and reverse reads).

```r
library(sangeranalyseR)

# Example: Analyzing a single contig
contig <- SangerContig(
    parentDirectory = "path/to/reads",
    contigName = "MyContig",
    fwdReadPrefix = "F_",
    revReadPrefix = "R_",
    processorConfig = list(trimmingMethod = "M1")
)

# Example: Analyzing an entire project (multiple contigs)
alignment <- SangerAlignment(
    parentDirectory = "path/to/project",
    suffixForwardRegExp = "_F.ab1",
    suffixReverseRegExp = "_R.ab1"
)
```

### 3. Quality Trimming
The package supports different trimming methods (e.g., "M1" or "M2"). You can adjust parameters like `M1TrimmingCutoff` (default 0.0001) to control how aggressively low-quality ends are removed.

### 4. Generating Reports
The most powerful feature is the automated report generation.

```r
# Generate an interactive HTML report
generateReport(contig, outputDir = "reports")
```

## Key Functions
- `SangerAlignment()`: Creates a project-level object for multiple contigs.
- `SangerContig()`: Creates a contig-level object from forward and reverse reads.
- `SangerRead()`: The lowest level object representing a single chromatogram file.
- `generateReport()`: Produces the HTML summary and visual chromatogram views.
- `writeFasta()`: Exports the assembled consensus sequences to FASTA format.

## Tips for Success
- **Naming Conventions**: Ensure your file naming is consistent (e.g., always ending in `_F.ab1` and `_R.ab1`) to make regex matching easier.
- **Interactive Inspection**: Always use `generateReport()` to check the "Internal Trim" and "Chromatogram" sections to ensure the automated trimming didn't remove high-quality data or leave too much noise.
- **Consensus Calculation**: You can adjust the `consensusHeight` parameter to change how the consensus sequence is called at polymorphic sites.

## Reference documentation
- [sangeranalyseR](./references/sangeranalyseR.md)