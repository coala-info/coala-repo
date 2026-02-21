---
name: bioconductor-bsgenomeforge
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BSgenomeForge.html
---

# bioconductor-bsgenomeforge

name: bioconductor-bsgenomeforge
description: Create and forge BSgenome data packages for Bioconductor. Use this skill when you need to build a custom R package containing genomic sequences (and optionally masks) from NCBI, UCSC, or local FASTA/2bit files.

## Overview

The `BSgenomeForge` package is used to generate "forge" BSgenome data packages. These packages provide efficient, programmatic access to whole-genome sequences within the Bioconductor ecosystem. The workflow generally involves identifying a genome source (NCBI, UCSC, or custom), preparing a "seed" file (for custom sources), and running a forge function to generate the R package source tree.

## Basic Workflows

### Forging from NCBI or UCSC (Standard Cases)
For genomes hosted on NCBI or UCSC, use high-level functions that automate data retrieval and package structure.

```r
library(BSgenomeForge)

# From NCBI
forgeBSgenomeDataPkgFromNCBI(
    assembly_accession = "GCA_009729545.1",
    organism = "Acidianus infernus",
    pkg_maintainer = "Your Name <your.email@example.com>",
    circ_seqs = character(0) # Optional: vector of circular sequence names
)

# From UCSC
forgeBSgenomeDataPkgFromUCSC(
    genome = "wuhCor1",
    organism = "Severe acute respiratory syndrome coronavirus 2",
    pkg_maintainer = "Your Name <your.email@example.com>"
)
```

### Forging from Custom/Local Sources (Advanced Case)
If the genome is not on NCBI/UCSC, you must manually prepare a "seed" file in DCF format (similar to an R DESCRIPTION file).

1.  **Prepare Sequence Data**: Place a `.2bit` file or multiple FASTA files in a source directory (`seqs_srcdir`).
2.  **Create Seed File**: A text file containing fields like `Package`, `Title`, `organism`, `provider`, `seqs_srcdir`, etc.
3.  **Run Forge**:
    ```r
    forgeBSgenomeDataPkg("path/to/my_seed_file")
    ```

### Forging Masked Genomes
To add masks (e.g., RepeatMasker, Tandem Repeats Finder, assembly gaps):
1.  Forge and install the "bare" (unmasked) BSgenome package first.
2.  Prepare a masked seed file specifying `RefPkgname` (the bare package) and `nmask_per_seq`.
3.  Run the masked forge function:
    ```r
    forgeMaskedBSgenomeDataPkg("path/to/masked_seed_file")
    ```

## Post-Forging Steps

Once the forge function completes, it creates a directory containing the R package source. You must build and install it using standard R tools:

```r
# Using devtools within R
devtools::build("./BSgenome.Organism.Provider.Version")
devtools::install_local("BSgenome.Organism.Provider.Version_1.0.0.tar.gz")

# Or via Terminal
# R CMD build <pkgdir>
# R CMD check <tarball>
# R CMD INSTALL <tarball>
```

## Key Seed File Fields
- **Package**: Convention is `BSgenome.<Organism>.<Provider>.<Version>`.
- **circ_seqs**: R expression returning names of circular sequences (e.g., `"chrM"`).
- **ondisk_seq_format**: Usually `"2bit"` (default) for efficiency.
- **seqs_srcdir**: Absolute path to the folder containing source sequences.

## Reference documentation
- [Advanced BSgenomeForge usage](./references/AdvancedBSgenomeForge.md)
- [A quick introduction to the BSgenomeForge package](./references/QuickBSgenomeForge.md)