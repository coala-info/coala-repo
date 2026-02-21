---
name: bioconductor-chimera
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/chimera.html
---

# bioconductor-chimera

name: bioconductor-chimera
description: Processing and analyzing fusion gene data from various detection tools (e.g., deFuse, STAR, FusionMap). Use when you need to import fusion discovery results into R, filter candidates, generate fusion sequences, visualize coverage, or predict oncogenic potential.

# bioconductor-chimera

## Overview

The `chimera` package provides a unified framework for the downstream processing of fusion gene data. It acts as a bridge between various third-party fusion detection tools and R/Bioconductor, allowing for standardized manipulation, filtering, and visualization of chimeric transcripts. The core data structure is the `fSet` object, which encapsulates fusion information, genomic locations, sequences, and alignments.

## Core Workflow

### 1. Importing Fusion Data
Use `importFusionData` to load results from supported tools. You must specify the tool name and the organism (e.g., "hg19").

```R
library(chimera)
# Supported tools: "bellerophontes", "defuse", "fusionfinder", "fusionhunter", 
# "mapsplice", "tophat-fusion", "fusionmap", "chimerascan", "star", "rsubread"
fusions <- importFusionData("fusionmap", "path/to/output.txt", org="hg19")
```

### 2. Exploring and Filtering
Fusions are stored as a list of `fSet` objects.

*   **Extract Names:** `fusionName(fusions)`
*   **Get Support Counts:** `supportingReads(fusions, fusion.reads="encompassing")`
*   **Filter List:** Use `filterList` to refine candidates based on quality or biological criteria.
    ```R
    # Filter by name
    fusions_filt <- filterList(fusions, type="fusion.names", "SULF2:ARFGEF2")
    # Filter by minimum spanning reads
    fusions_filt <- filterList(fusions, type="spanning.reads", 2)
    # Remove read-throughs or non-annotated genes
    fusions_filt <- filterList(fusions, type="read.through")
    fusions_filt <- filterList(fusions, type="annotated.genes")
    ```

### 3. Sequence Generation and Mapping
Generate the nucleotide sequences of the putative fusions for further analysis or validation.

```R
myset <- fusions[[1]]
# Generate DNAStringSet of transcript isoforms
trs <- chimeraSeqs(myset, type="transcripts")

# Map reads back to the fusion sequence using Rsubread
subreadRun(ebwt="fusion_ref.fa", input1="R1.fq", input2="R2.fq", outfile.prefix="mapped")

# Add the resulting BAM back to the fSet object for visualization
myset <- addGA(myset, "mapped_accepted_hits.bam")
```

### 4. Visualization
Visualize the fusion structure and read coverage.

```R
# Plot exon structure and coverage
plotCoverage(myset, plot.type="exons", col.box1="red", col.box2="green")

# Plot specific junction boundaries
plotCoverage(myset, junction.spanning=100, fusion.only=TRUE)
```

### 5. Functional Analysis
*   **Peptide Prediction:** `fusionPeptides(trs)` predicts the protein sequence and checks for frame shifts.
*   **Oncofuse:** Predict the oncogenic potential of fusions.
    ```R
    # Requires Oncofuse installation
    # installOncofuse()
    of_results <- oncofuseRun(fusions, tissue="EPI")
    ```

## Tips and Best Practices
*   **Validation:** Use `gapfillerWrap` to perform de novo assembly of reads around the fusion junction to confirm the breakpoint.
*   **Data Access:** Use accessor methods like `fusionData(myset)`, `fusionGRL(myset)`, and `fusionRNA(myset)` to extract specific components from an `fSet` object.
*   **Parallelization:** Many functions like `filterList` and `chimeraSeqSet` support a `parallel=TRUE` argument to speed up processing on large datasets.

## Reference documentation
- [Chimera](./references/chimera.md)