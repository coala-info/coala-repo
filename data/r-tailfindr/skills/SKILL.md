---
name: r-tailfindr
description: tailfindr is an R package for alignment-free estimation of poly(A)-tail lengths from Oxford Nanopore RNA and DNA sequencing data. Use when user asks to estimate tail lengths from FAST5 files, process direct RNA or cDNA reads, or visualize tail boundaries in raw squiggle data.
homepage: https://cran.r-project.org/web/packages/tailfindr/index.html
---


# r-tailfindr

name: r-tailfindr
description: Estimating poly(A)-tail lengths in Oxford Nanopore RNA and DNA reads using the tailfindr R package. Use this skill when you need to process FAST5 files to measure tail lengths, handle different basecalling models (Albacore, Guppy, flipflop), or visualize tail boundaries in raw squiggle data.

# r-tailfindr

## Overview
tailfindr is an R package designed for alignment-free estimation of poly(A)-tail lengths from Oxford Nanopore sequencing data. It supports both direct RNA and DNA (cDNA) reads, providing nucleotide-level resolution by normalizing raw signal samples using the read-specific translocation rate.

## Installation
To install the package from GitHub (as it is not currently on CRAN):

```R
if (!require("devtools")) install.packages("devtools")
# Required dependency rbokeh must be installed from archive
devtools::install_url('https://cran.r-project.org/src/contrib/Archive/rbokeh/rbokeh_0.5.1.tar.gz', type = "source", dependencies = TRUE)
# Install tailfindr
devtools::install_github("adnaniazi/tailfindr")
```

## Core Workflow
The primary function is `find_tails()`, which processes a directory of FAST5 files and returns a tibble while optionally saving results to a CSV.

### Basic Usage (RNA)
```R
library(tailfindr)
df <- find_tails(fast5_dir = 'path/to/fast5',
                 save_dir = 'path/to/output',
                 csv_filename = 'rna_tails.csv',
                 num_cores = 4)
```

### Processing DNA/cDNA
For DNA data, tailfindr identifies both poly(A) and poly(T) tails.
```R
df <- find_tails(fast5_dir = 'path/to/cdna_fast5',
                 save_dir = 'path/to/output',
                 csv_filename = 'cdna_tails.csv',
                 num_cores = 4)
```

### Custom Primers (cDNA)
If using custom constructs, specify the primers (5' to 3') to help the algorithm orient the read.
```R
df <- find_tails(fast5_dir = 'path/to/custom_cdna',
                 save_dir = 'path/to/output',
                 dna_datatype = 'custom-cdna',
                 front_primer = "TTTCTGTTGGTGCTGATATTGCTGCCATTACGGCCGG",
                 end_primer = "ACTTGCCTGTCGCTCTATCTT")
```

## Visualization
You can generate interactive HTML plots to inspect the tail boundaries in the raw signal (squiggle).
```R
df <- find_tails(..., 
                 save_plots = TRUE, 
                 plotting_library = 'rbokeh',
                 plot_debug_traces = TRUE) # Shows internal boundary logic
```

## Key Parameters and Troubleshooting
- **basecall_group**: Defaults to `Basecall_1D_000`. If you re-basecalled data (e.g., using Guppy standalone), you may need to set this to `Basecall_1D_001` to access the required `Events/Move` table.
- **samples_per_nt**: This value is calculated per-read. If the `Events/Move` table is missing (common in MinKNOW live basecalling), the package cannot calculate tail length in nucleotides.
- **Flipflop Model**: When using flipflop basecallers, ensure `enable_trimming = 0` was used during basecalling so that adapters (needed for orientation) are preserved.
- **Supported Kits**: SQK-RNA001/002, SQK-LSK108/109, and SQK-PCS110.

## Reference documentation
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)