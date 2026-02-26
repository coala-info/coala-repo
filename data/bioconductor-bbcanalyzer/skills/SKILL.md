---
name: bioconductor-bbcanalyzer
description: BBCAnalyzer visualizes base counts, deletions, and insertions from BAM files at specific genomic positions. Use when user asks to analyze sequencing alignment data, visualize base distributions at targeted regions, compare samples, or validate variants using barplots.
homepage: https://bioconductor.org/packages/release/bioc/html/BBCAnalyzer.html
---


# bioconductor-bbcanalyzer

name: bioconductor-bbcanalyzer
description: Visualizing base counts, deletions, and insertions from BAM files at specific genomic positions. Use this skill when you need to analyze sequencing alignment data (BAM files) to see the exact distribution of bases (A, C, G, T), deletions, and insertions at targeted regions, compare different samples, or validate variants with high-quality barplots.

## Overview
BBCAnalyzer is a Bioconductor package designed to provide a detailed visualization of base counts at specific genomic positions. Unlike standard variant callers that apply complex filters, BBCAnalyzer reports the unfiltered number of reads, making it ideal for investigating "background noise," analyzing positions where a variant was expected but not called, or comparing sequencing techniques. It supports incorporating VCF files to show expected vs. observed counts and can include known polymorphisms (e.g., dbSNP).

## Core Workflow

The package relies on a structured input system and a primary execution function.

### 1. Required Input Files
Before running the analysis, ensure the following files are prepared:
- **Sample Names**: A text file with one sample name per line (no `.bam` extension).
- **BAM/BAI Files**: BAM files and their corresponding indices must be in the same folder, named identically to the sample names.
- **Target Regions**: A tab-separated file containing either regions (`chr`, `start`, `end`) or specific positions (`chr`, `pos`).

### 2. Main Analysis Function: `analyzeBases`
This function performs the full pipeline: determining targets, analyzing reads (CIGAR strings), calculating frequencies/qualities, and reporting variants.

```r
library(BBCAnalyzer)
library(BSgenome.Hsapiens.UCSC.hg19)

ref_genome <- BSgenome.Hsapiens.UCSC.hg19

output <- analyzeBases(
  sample_names = "SampleNames.txt",
  bam_input = "./bam_folder/",
  target_regions = "targetRegions.txt",
  genome = ref_genome,
  output = "./results/",
  MQ_threshold = 60,          # Mapping quality threshold
  BQ_threshold = 50,          # Base quality threshold
  frequency_threshold = 0.01, # Min frequency to report a variant
  relative = TRUE,            # Plot relative frequencies (TRUE) or absolute counts (FALSE)
  per_sample = TRUE           # One plot per sample (TRUE) or per target (FALSE)
)
```

### 3. Plotting Only: `analyzeBasesPlotOnly`
If you have already run `analyzeBases` and want to change the visual output (e.g., switching from relative to absolute counts or changing quality bounds) without re-processing the BAM files, use this function.

```r
analyzeBasesPlotOnly(
  sample_names = "SampleNames.txt",
  output_list = output,       # The return value from analyzeBases
  qual_lower_bound = 58,
  qual_upper_bound = 63,
  marks = c(0.2, 0.4, 0.6, 0.8, 1.0), # Horizontal lines for frequency levels
  relative = FALSE,
  per_sample = FALSE
)
```

## Interpreting Results

### Output Files
- **[Sample].bases.txt**: Raw bases/deletions/insertions detected per read.
- **[Sample].quality.txt**: Phred quality scores for every detected base.
- **[Sample].frequency.txt**: Summed counts and mean qualities per position.
- **[Sample].calling.txt**: Calculated ratios and potential calls based on the frequency threshold.
- **Plots (.png)**: Barplots where:
  - **A**: Green, **C**: Blue, **G**: Yellow, **T**: Red.
  - **Deletions**: Black.
  - **Insertions**: Lilac edge.
  - **Color Intensity**: Darker bars indicate higher mean quality (if `qual_lower_bound` and `qual_upper_bound` are set).
  - **Negative Y-axis**: Displays the reference base(s).

## Tips for Success
- **Insertions**: To analyze a known insertion, provide the genomic position of the base *succeeding* the insertion.
- **VCF Integration**: Provide a `vcf_input` folder to overlay dashed lines on the plots representing the expected allele frequencies from your variant calls.
- **Memory/Time**: Runtime scales with the number of samples, positions, and read depth. For large datasets, analyze specific regions of interest rather than whole chromosomes.
- **Mapping Quality**: Reads with mapping quality below `MQ_threshold` are marked as "MQ" in output files and excluded from frequency counts.

## Reference documentation
- [BBCAnalyzer – an R/Bioconductor package for visualizing base counts](./references/BBCAnalyzer.md)