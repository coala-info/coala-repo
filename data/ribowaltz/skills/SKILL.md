---
name: ribowaltz
description: riboWaltz is a specialized R package designed to identify the precise position of ribosomes (the P-site) within ribosome-protected fragments (RPFs).
homepage: https://github.com/LabTranslationalArchitectomics/riboWaltz
---

# ribowaltz

## Overview
riboWaltz is a specialized R package designed to identify the precise position of ribosomes (the P-site) within ribosome-protected fragments (RPFs). By utilizing a two-step algorithm that maximizes offset coherence across different read lengths, it enables researchers to achieve nucleotide-resolution insights into translation activity. It is the standard tool for converting raw RiboSeq alignments into biologically meaningful codon-occupancy data.

## Installation
Install the package directly from GitHub using `devtools`. It is recommended to build the vignettes for detailed local documentation.

```R
# Install dependencies and the package
if (!require("devtools")) install.packages("devtools")
devtools::install_github("LabTranslationalArchitectomics/riboWaltz", dependencies = TRUE, build_vignettes = TRUE)

# Load the library
library(riboWaltz)
```

## Core Workflow Patterns

### 1. Input Preparation
riboWaltz requires BAM files aligned to **transcript coordinates**. 
- **STAR users**: Use the `--quantMode TranscriptomeSAM` option.
- **Bowtie users**: Align directly against a transcriptome FASTA file.

### 2. Data Acquisition
Convert BAM files into a list of data tables. This step requires an annotation data table (`annotation_dt`) containing transcript information (transcript ID, length, CDS start, CDS end).

```R
# Load BAM files into R
# name_samples allows you to define custom labels for your samples
reads_list <- bamtolist(bamfolder = "path/to/BAM/files", 
                        annotation = annotation_dt, 
                        name_samples = c("Control", "Treatment"))
```

### 3. P-site Offset Calculation
The `psite` function determines the distance between the read extremity (usually the 5' end) and the P-site.

```R
# Calculate optimal offsets
# 'flanking' defines the number of nucleotides around the start/stop codons to consider
psite_offset <- psite(reads_list, flanking = 6, extremity = "5p")

# Apply offsets to the reads to get P-site positions
reads_psite_list <- psite_info(reads_list, psite_offset)
```

### 4. Diagnostic Visualizations
Use these functions to assess the quality of the RiboSeq library:

- **Read Length Distribution**: `rlength_distr(reads_list, sample = "Control")`
- **Trinucleotide Periodicity**: Check if ribosomes are moving 3-nt at a time.
- **Metaplots**: Visualize ribosome density around start and stop codons using `metaplots`.

## Expert Tips and Best Practices
- **Transcript Coordinates**: Never use BAM files aligned to genomic coordinates (chromosomes) directly; riboWaltz expects coordinates relative to the start of the transcript.
- **Duplicate Reads**: If your library has high PCR duplication, use the `duplicates_filter` function within the package to remove them before calculating offsets.
- **Read Length Selection**: Not all read lengths provide high-quality positional information. Use `rlength_distr` and `rend_localization` to identify and select only the read lengths that show strong periodicity (typically 28-30 nt in eukaryotes).
- **Annotation Consistency**: Ensure the `annotation_dt` used in `bamtolist` exactly matches the version of the transcriptome used during the alignment step to avoid coordinate mismatches.

## Reference documentation
- [riboWaltz README](./references/github_com_LabTranslationalArchitectomics_riboWaltz.md)