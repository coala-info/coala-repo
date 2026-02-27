---
name: bioconductor-umi4cats
description: "UMI4Cats processes and analyzes UMI-4C sequencing data to quantify chromatin interactions from a specific viewpoint. Use when user asks to digest a genome in silico, process FASTQ files into UMI-deduplicated counts, call significant chromatin interactions, or perform differential interaction analysis between conditions."
homepage: https://bioconductor.org/packages/release/bioc/html/UMI4Cats.html
---


# bioconductor-umi4cats

## Overview
UMI4Cats is a Bioconductor package designed for the processing and analysis of UMI-4C data. UMI-4C is a targeted technique that uses UMIs to reduce PCR duplication bias, allowing for accurate quantification of chromatin interactions from a specific viewpoint (bait). This skill facilitates the transition from raw sequencing reads to differential interaction discovery and visualization.

## Core Workflow

### 1. Preparation and Genome Digestion
Before processing reads, you must create an in silico digested genome matching the restriction enzyme used in the lab.

```r
library(UMI4Cats)
library(BSgenome.Hsapiens.UCSC.hg19)

# Digest genome (e.g., DpnII cuts at GATC, pos 0)
hg19_dpnii <- digestGenome(
    res_enz = "GATC",
    cut_pos = 0,
    name_RE = "DpnII",
    ref_gen = BSgenome.Hsapiens.UCSC.hg19,
    out_path = "digested_genome/"
)
```

### 2. Processing FASTQ to Counts
The `contactsUMI4C` function handles alignment (via Bowtie2), UMI deduplication, and fragment counting.

```r
contactsUMI4C(
    fastq_dir = "path/to/fastq",
    wk_dir = "project_folder",
    bait_seq = "GGACAAGCTCCCTGCAACTCA", # DS primer sequence
    bait_pad = "GGACTTGCA",             # Sequence between primer and RE site
    res_enz = "GATC",
    cut_pos = 0,
    digested_genome = hg19_dpnii,
    bowtie_index = "path/to/bowtie2_index",
    ref_gen = BSgenome.Hsapiens.UCSC.hg19
)
```

### 3. Creating the UMI4C Object
Load the processed count files into a `UMI4C` object (based on `SummarizedExperiment`).

```r
# colData must contain: sampleID, replicate, condition, file
umi <- makeUMI4C(
    colData = colData,
    viewpoint_name = "CIITA",
    grouping = "condition",
    bait_expansion = 2e6 # Analysis window (2Mb)
)
```

### 4. Calling Significant Interactions
Identify regions significantly interacting with the viewpoint using Z-scores calculated after Variance Stabilizing Transformation (VST) and monotone smoothing.

```r
# 1. Generate windows or provide specific query_regions (e.g., enhancers)
win_frags <- makeWindowFragments(umi, n_frags = 8)

# 2. Call interactions
gr_list <- callInteractions(
    umi4c = umi,
    design = ~condition,
    query_regions = win_frags,
    padj_threshold = 0.01,
    zscore_threshold = 2
)

# 3. Extract unique significant regions
inter <- getSignInteractions(gr_list)
```

### 5. Differential Analysis
Compare chromatin contacts between two levels of a condition.

*   **DESeq2 (Wald Test):** Recommended when replicates and high UMI depth are available.
*   **Fisher's Exact Test:** Use for low depth or limited replicates.

```r
# DESeq2 approach
umi_wald <- waldUMI4C(
    umi4c = umi,
    query_regions = inter,
    design = ~condition
)

# Fisher approach
umi_fisher <- fisherUMI4C(
    umi,
    query_regions = inter,
    grouping = "condition",
    filter_low = 20
)

# Retrieve results
res <- resultsUMI4C(umi_wald, format = "data.frame")
```

### 6. Visualization
Generate integrated plots showing trends, domainograms, gene annotations, and differential results.

```r
plotUMI4C(umi_wald, 
          grouping = "condition", 
          xlim = c(10.7e6, 11.2e6), 
          ylim = c(0, 10))
```

## Key Functions and Accessors
*   `demultiplexFastq()`: Split multiplexed FASTQ files by bait barcodes.
*   `statsUMI4C()`: Generate QC stats (specific reads, mapping, UMI counts).
*   `bait(umi)`: Get bait coordinates.
*   `trend(umi)`: Get adaptive smoothing trend data.
*   `groupsUMI4C(umi)`: Access grouped UMI4C objects (e.g., merged replicates).

## Reference documentation
- [Analyzing UMI-4C data with UMI4Cats](./references/UMI4Cats.Rmd)
- [Analyzing UMI-4C data with UMI4Cats](./references/UMI4Cats.md)