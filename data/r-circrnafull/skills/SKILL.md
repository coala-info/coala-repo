---
name: r-circrnafull
description: This tool reconstructs full-length circRNA sequences by integrating chimeric alignment data from STAR and circRNA predictions from CIRCexplorer. Use when user asks to process circRNA junction data, extract reads from BAM files, detect skipped exons, or reconstruct complete circular RNA sequences in FASTA format.
homepage: https://cran.r-project.org/web/packages/circrnafull/index.html
---

# r-circrnafull

name: r-circrnafull
description: Reconstruction of full-length circRNA sequences using chimeric alignment information from STAR and CIRCexplorer. Use this skill when you need to process circRNA junction data, extract specific reads from BAM files, detect skipped exons, and reconstruct complete circular RNA sequences in FASTA format.

## Overview

The `circrnafull` package provides a comprehensive workflow for reconstructing full-length circRNA sequences. It leverages chimeric alignment information (from STAR aligner) and circRNA predictions (from CIRCexplorer) to identify constitutive and skipped exons, ultimately producing the reconstructed circular sequence.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("Biostrings", "Rsamtools"))

install.packages("devtools")
devtools::install_github("tofazzalh/circRNAFull")
library(circRNAFull)
```

## Core Workflow

### 1. Extract Circle IDs and Spanning Reads
Identify circRNAs and their associated transcript names and spanning reads.
- **Function**: `extract_circle_ids(circ_out, chimeric_out, output)`
- **Inputs**: `circ_out` (CIRCexplorer output), `chimeric_out` (STAR Chimeric.out.junction).

### 2. Extract Reads from BAM
Generate individual alignment files for each circRNA from the chimeric BAM.
- **Function**: `extract_reads_from_bam(circle_id, bamfile, outfolder)`
- **Note**: Load the BAM using `Rsamtools::scanBam("Chimeric.out.bam")` and convert to a data frame.

### 3. Exon Extraction and Refinement
Identify exons based on CIGAR strings and reference coordinates, then detect and remove skipped exons.
- **Extract Exons**: `Extract_exon(bed_file, folder_name, circle_ids, output_folder)`
- **Detect Skips**: `skip_exon_detection(circle_reads_folder, exon_count_file, output_folder)`
- **Filter Skips**: `extract_exon_after_delete_skip_exon(exon_count_file, skip_exon_file, output_folder)`

### 4. Sequence Reconstruction
Reconstruct the final full-length circRNA sequences into a FASTA file.
- **Function**: `extract_sequence(seq_name, sequence, exon_count_file, output)`
- **Inputs**: Reference genome chromosome names and sequences (typically loaded via `Biostrings::readDNAStringSet`).

## Usage Tips
- **Data Prep**: Ensure your reference genome (FASTA) and exon coordinates (BED) match the assembly used for alignment (e.g., hg38).
- **Output Management**: Most functions write results to a specified directory rather than returning objects to the R environment. Use `tempdir()` for intermediate steps if you do not need to persist the files.
- **Dependencies**: This package relies heavily on `Biostrings` for sequence manipulation and `Rsamtools` for BAM processing.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)