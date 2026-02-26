---
name: bioconductor-biscuiteer
description: The biscuiteer package processes and integrates output from the biscuit aligner into the Bioconductor ecosystem for advanced DNA methylation analysis. Use when user asks to load biscuit-formatted methylation data, estimate epigenetic age, combine multiple datasets, or prepare data for genomic compartment inference.
homepage: https://bioconductor.org/packages/release/bioc/html/biscuiteer.html
---


# bioconductor-biscuiteer

## Overview
The `biscuiteer` package is designed to bridge the gap between `biscuit` (a fast C-based aligner and methylation caller) and the Bioconductor ecosystem, specifically the `bsseq` package. It handles the complexities of VCF header parsing, data merging, and provides specialized analysis tools for epigenetic aging and genomic compartment inference.

## Core Workflows

### 1. Loading Methylation Data
The primary entry point is `readBiscuit`. It requires a BED file (methylation calls) and a VCF file (for header/metadata).
**Note:** Files must be bgzipped and tabix-indexed.

```r
library(biscuiteer)

# Define paths to bgzipped/tabix'ed files
bed_file <- "path/to/output.bed.gz"
vcf_file <- "path/to/output.vcf.gz"

# Load into a bsseq-derived object
# Set merged = TRUE if biscuit mergecg was used
bisc <- readBiscuit(BEDfile = bed_file, VCFfile = vcf_file, merged = FALSE)

# View biscuit-specific metadata (version, invocation, etc.)
biscuitMetadata(bisc)
```

### 2. Combining Datasets
To merge multiple `biscuiteer` or `bsseq` objects into a single experiment, use `unionize`.

```r
# Combine two objects (wrapper around BiocGenerics::combine)
combined_data <- unionize(bisc1, bisc2)
```

### 3. Loading epiBED Files
For read-level or fragment-level analysis (e.g., NOMe-seq or single-molecule patterns), use `readEpibed`.

```r
# Returns a GRanges object with decoded RLE strings
epibed_gr <- readEpibed(epibed = "data.epibed.gz", genome = "hg19", chr = "chr1")
```

### 4. Epigenetic Age Estimation
`biscuiteer` implements several Horvath-style "clocks" for Whole Genome Bisulfite Sequencing (WGBS) data.

```r
# Supported clocks: "horvath", "horvathshrunk", "hannum", "skinandblood"
age_results <- WGBSage(combined_data, "horvath")

# Access predicted ages
age_results$age
```

### 5. A/B Compartment Inference Preparation
To prepare data for compartment inference (e.g., using the `compartmap` package), use Dirichlet smoothing to generate logit-transformed methylated fractions.

```r
# Define genomic regions
regions <- GRanges(seqnames = "chr11", ranges = IRanges(start = 0, end = 1e6))

# Get moderated logit fractions
logit_meth <- getLogitFracMeth(bisc, minSamp = 1, r = regions)
```

## Tips and Best Practices
*   **Tabix Requirement:** Always ensure your BED and VCF files are indexed. Use `bgzip file` and `tabix -p [bed|vcf] file.gz` in the shell before loading into R.
*   **Memory Management:** WGBS data is large. `biscuiteer` objects inherit from `bsseq`, which can be memory-intensive. Consider subsetting to specific chromosomes or regions using `GRanges` if memory is limited.
*   **VCF Headers:** Even if you only have a BED file, a VCF header is required to correctly assign sample names and metadata.
*   **Downstream Analysis:** For differential methylation (DMR) calling, pass the `biscuiteer` object directly to packages like `dmrseq`.

## Reference documentation
- [Biscuiteer User Guide](./references/biscuiteer.Rmd)
- [Biscuiteer User Guide (Markdown)](./references/biscuiteer.md)