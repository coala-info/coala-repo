---
name: r-calder2
description: r-calder2 performs hierarchical analysis of Hi-C data to identify chromatin domains, sub-compartments, and nested sub-domains. Use when user asks to compute chromatin domains, identify hierarchical sub-compartments, or detect nested TAD-like structures from Hi-C contact matrices.
homepage: https://cran.r-project.org/web/packages/calder2/index.html
---

# r-calder2

name: r-calder2
description: Comprehensive Hi-C analysis for computing chromatin domains, hierarchical sub-compartments, and nested sub-domains. Use when analyzing Hi-C contact matrices to identify 3D genome structures, compartment organization, and TAD-like nested domains in R.

# r-calder2

## Overview
CALDER is a Hi-C analysis tool designed to partition the genome into hierarchical functional units. It operates through three primary modules:
1. Computing chromatin domains from whole-chromosome contacts.
2. Deriving non-linear hierarchical organization to identify sub-compartments (e.g., A.1.1, B.2.2).
3. Computing nested sub-domains (TAD-like structures) within chromatin domains from short-range contacts.

CALDER 2.0 features optimized bin size selection and support for multiple genomes (hg19, hg38, mm9, mm10) and input formats (.hic and dump files).

## Installation
Install the package from CRAN:
```R
install.packages("r-calder2")
```

## Main Function: CALDER()
The `CALDER()` function is the primary interface for all analysis modules.

### Key Parameters
- `contact_file_hic`: Path to a `.hic` file (Juicer format).
- `contact_file_dump`: A named list of paths to three-column contact "dump" files (from Juicer/Straw).
- `chrs`: Vector of chromosome names (e.g., `c(1:22, "X")`).
- `bin_size`: Resolution in bp (recommended: 10,000 to 100,000).
- `genome`: 'hg19', 'hg38', 'mm9', 'mm10', or 'others'.
- `save_dir`: Directory for output files.
- `sub_domains`: Logical; set to `TRUE` to compute nested sub-domains (Step 3).
- `feature_track`: Required if `genome='others'`. A data.frame with 4 columns (chr, start, end, score) used to orient the A/B compartment direction.

## Workflows

### Using .hic Files
Analyze specific chromosomes directly from a Juicer `.hic` file:
```R
library(CALDER)
CALDER(contact_file_hic = "path/to/data.hic",
       chrs = c(21, 22),
       bin_size = 10000,
       genome = "hg38",
       save_dir = "./calder_output",
       sub_domains = TRUE)
```

### Using Dump/Straw Tables
If using text-based contact matrices (columns: bin1, bin2, count):
```R
chrs = c(21, 22)
contact_files = list("21" = "chr21_10kb.txt.gz", "22" = "chr22_10kb.txt.gz")

CALDER(contact_file_dump = contact_files,
       chrs = chrs,
       bin_size = 10000,
       genome = "hg19",
       save_dir = "./calder_output")
```

### Analyzing Non-Standard Genomes
When using a genome other than human or mouse, provide a `feature_track` (e.g., gene density or H3K27ac) to ensure correct A/B compartment assignment:
```R
# feature_track columns: chr, start, end, score
CALDER(contact_file_hic = "data.hic",
       chrs = "chr1",
       bin_size = 25000,
       genome = "others",
       feature_track = my_feature_df,
       save_dir = "./custom_genome_out")
```

## Output Structure
The function creates a directory containing:
- `sub_compartments/`:
    - `all_sub_compartments.bed`: Visualization file for IGV (8 sub-compartment resolution).
    - `all_sub_compartments.tsv`: Tabular bin-level compartment assignments.
- `sub_domains/`:
    - `all_nested_boundaries.bed`: Nested TAD-like boundaries.
- `intermediate_data/`: Per-chromosome hierarchy files (`_domain_hierachy.tsv`) and Rds objects.

## Tips for Success
- **Bin Size Optimization**: By default, CALDER 2.0 performs an optimized bin size selection for supported genomes to ensure compartment robustness. To disable this and use only the user-specified size, set `single_binsize_only = TRUE`.
- **Memory and Cores**: Use `n_cores` to parallelize across chromosomes. For 10kb resolution, ensure at least 64GB of RAM is available for large genomes.
- **Feature Tracks**: For `genome='others'`, use tracks positively correlated with activity (Gene density, H3K4me3, H3K27ac) to orient the A/B axis correctly.

## Reference documentation
- [Data Extraction](./references/Data-Extraction.md)
- [README](./references/README.md)
- [Articles](./references/articles.md)
- [Home Page](./references/home_page.md)