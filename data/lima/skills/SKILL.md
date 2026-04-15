---
name: lima
description: Lima demultiplexes Pacific Biosciences sequencing data by identifying barcode sequences and sorting reads into per-sample files. Use when user asks to demultiplex PacBio reads, remove primers for IsoSeq workflows, or sort HiFi data by barcode.
homepage: https://github.com/PacificBiosciences/barcoding
metadata:
  docker_image: "quay.io/biocontainers/lima:2.13.0--h9ee0642_0"
---

# lima

## Overview
Lima is the specialized demultiplexer for Pacific Biosciences (PacBio) data. It identifies barcode sequences in sequencing reads and sorts them into per-sample files. It is designed to handle the specific error profiles of PacBio data and supports both subread and HiFi (CCS) inputs. Use this skill to configure demultiplexing runs, optimize scoring thresholds, and manage output formats for downstream analysis like IsoSeq or variant calling.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::lima
```

## Common CLI Patterns

### Basic Demultiplexing
The standard execution requires an input BAM file, a FASTA file containing the barcodes, and an output prefix.
```bash
lima input.bam barcodes.fasta output.bam
```

### HiFi Data (Recommended)
For HiFi/CCS data, use the specialized preset to optimize scoring for high-accuracy reads.
```bash
lima --hifi input.ccs.bam barcodes.fasta output.bam
```

### IsoSeq Workflows
When processing IsoSeq data, lima is used to remove primers and barcodes.
```bash
lima input.ccs.bam primers.fasta output.bam --isoseq
```

### Single-End Barcoding
If the library preparation uses barcodes on only one end of the insert:
```bash
lima input.bam barcodes.fasta output.bam --single-end
```

## Expert Tips and Best Practices

### Scoring and Filtering
*   **Adjusting Stringency**: Use `--min-score` to control the threshold for barcode identification. A higher score increases precision but may reduce yield.
*   **Handle Management**: In versions 2.7.1 and later, use the flag `--output-handles` (which replaced the older `--bam-handles`) to manage the number of open file descriptors when demultiplexing a large number of barcodes.

### Output Files
Lima produces several files based on the provided prefix:
*   `prefix.json`: Summary of the run and barcode hits.
*   `prefix.lima.counts`: A TSV file showing the number of reads assigned to each barcode pair.
*   `prefix.lima.report`: Detailed per-read information (useful for troubleshooting low yield).
*   `prefix.<barcode_pair>.bam`: The demultiplexed reads for each identified sample.

### Performance
*   **Threading**: Use `-j` or `--num-threads` to specify the number of CPU cores. Lima scales well with additional threads.
*   **Memory**: For very large barcode sets, ensure the system has sufficient memory to track output handles and scoring matrices.

## Reference documentation
- [lima - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_lima_overview.md)
- [Lima - Demultiplex PacBio data (README)](./references/github_com_PacificBiosciences_barcoding_blob_master_README.md)
- [Lima Commit History (Technical Flags)](./references/github_com_PacificBiosciences_barcoding_commits_master.md)