---
name: mtglink
description: MTG-Link performs local assembly of genomic regions by leveraging barcode information from linked-read sequencing data. Use when user asks to assemble specific genomic gaps, resolve complex structural variants, or perform targeted assembly of dark regions using linked reads.
homepage: https://github.com/anne-gcd/MTG-Link
---


# mtglink

## Overview
MTG-Link (MindTheGap-Link) is a specialized tool for the local assembly of genomic regions using the barcode information inherent in linked-read sequencing. It operates by identifying barcodes present in the flanking regions of a target locus and then subsampling all reads sharing those barcodes to perform a focused assembly. This approach significantly reduces the computational complexity and noise associated with whole-genome assembly, making it highly effective for characterizing "dark" regions of the genome or resolving complex structural variants.

## Installation and Setup
MTG-Link is available via Bioconda. Ensure all external dependencies (Biopython, Gfapy, Mummer, Pysam, LRez, and MindTheGap) are present in your environment.

```bash
conda install -c bioconda mtglink
```

## Core Workflow

### 1. Prepare the Target Definition (GFA)
MTG-Link requires a GFA file where flanking sequences are defined as segments (S lines) and the target to be assembled is defined as a gap (G line). If you have coordinates in a BED file, use the provided utility script:

```bash
./utils/bed2gfa.py -bed targets.bed -fa reference.fasta -out targets.gfa
```

### 2. Build the Barcode Index
Before running the assembly, you must create a barcode index of your gzipped FASTQ files using `LRez`. The barcodes must be stored in the read headers using the `BX:Z` tag.

```bash
LRez index fastq -f reads.fastq.gz -o barcodes.bci -g
```

### 3. Execute Local Assembly
Run the main assembly pipeline using the `DBG` (De Bruijn Graph) command.

```bash
mtglink.py DBG -gfa targets.gfa -bam mapped_reads.bam -fastq reads.fastq.gz -index barcodes.bci -out results_dir
```

## CLI Parameter Optimization

| Parameter | Default | Expert Guidance |
| :--- | :--- | :--- |
| `-k` | `51,41,31,21` | K-mer sizes for assembly. Use larger k-mers for high-coverage/repeat regions; smaller k-mers for low-coverage. |
| `-flank` | `10000` | Size of the flanking region (bp) used to harvest barcodes. Increase if the region is highly repetitive. |
| `-occ` | `2` | Minimum barcode occurrences in flanking regions to retain a barcode. Increase to filter noise in high-depth data. |
| `-ext` | `500` | Extension size (bp) into the flanks to determine the start/end of the local assembly. |
| `-t` | `1` | Number of threads. Primarily affects the Read Subsampling step. |
| `-m` | `1000` | Minimum assembly length. Should be at least `2 * ext`. |

## Best Practices and Troubleshooting
- **Input Validation**: Ensure your BAM file is indexed (`.bai` file must exist in the same directory).
- **Barcode Format**: MTG-Link specifically looks for the `BX:Z` tag. If your linked-read data uses a different tag, you must preprocess the headers.
- **Memory Management**: While local assembly is memory-efficient, the subsampling step can be intensive. Use the `-bxuDir` option if you have already performed subsampling in a previous run to skip that phase.
- **Output Files**: 
    - `assembled_targets.fasta`: Contains the successful assemblies.
    - `assembly_graph.gfa`: The updated GFA including the new sequences.
    - `bad_solutions.fasta`: Contains assemblies with multiple possible paths or ambiguities.

## Reference documentation
- [MTG-Link Main Documentation](./references/github_com_anne-gcd_MTG-Link.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mtglink_overview.md)