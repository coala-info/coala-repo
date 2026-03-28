---
name: mtglink
description: MTG-Link is a local assembly tool that uses barcode information from linked-read sequencing data to reconstruct sequences at specific genomic loci. Use when user asks to perform local assembly of gaps, reconstruct target sequences using linked-reads, or subsample reads based on barcode sharing for specific genomic regions.
homepage: https://github.com/anne-gcd/MTG-Link
---


# mtglink

## Overview

MTG-Link is a local assembly tool specifically engineered for linked-read sequencing data. It utilizes the barcode information inherent in linked-reads to subsample relevant sequences for a specific locus, significantly reducing the computational complexity of the assembly. By focusing on reads that share barcodes with the flanking regions of a target "gap" or "target sequence," it can reconstruct unknown sequences even in related species or complex genomic regions.

## Core Workflow

### 1. Prepare the Input GFA
MTG-Link requires a GFA file defining the target loci. If you only have coordinates in a BED file, use the provided utility script:

```bash
python3 ./utils/bed2gfa.py -bed targets.bed -fa reference.fasta -out targets.gfa
```

### 2. Build the Barcode Index
Before running the assembly, you must create an LRez barcode index for your gzipped FASTQ files. The barcodes must be present in the read headers (typically using the `BX:Z` tag).

```bash
LRez index fastq -f reads.fastq.gz -o barcodes.bci -g
```

### 3. Execute Local Assembly
Run the main assembly pipeline using the De Bruijn Graph (DBG) approach. Ensure your BAM file is indexed (`.bai` file must exist).

```bash
mtglink.py DBG -gfa targets.gfa -bam mapped_reads.bam -fastq reads.fastq.gz -index barcodes.bci -out ./results
```

## Command Options and Best Practices

### Resource Management
- **Threads**: Use `-t` to specify threads for the read subsampling step (e.g., `-t 8`).
- **Memory**: Local assembly is generally memory-efficient due to read subsampling, but ensure the environment has sufficient RAM for the `MindTheGap` component.

### Assembly Tuning
- **K-mer Sizes**: MTG-Link tests multiple k-mer values. The default is `51, 41, 31, 21`. You can override this with `-k`:
  ```bash
  mtglink.py DBG ... -k 61 51 41
  ```
- **Flanking Size**: The default flanking region used to identify relevant barcodes is 10,000 bp. Adjust with `-flank` if working with very short scaffolds or specific structural variants.
- **Abundance Threshold**: Control the minimal abundance for solid k-mers using `-a` (default: `3, 2`).

### Handling Large Targets
- **Max Length**: If the gap or insertion is expected to be large, increase the `-l` parameter (default: 10,000 bp).
- **Max Nodes**: For complex regions that create massive assembly graphs, use `-max-nodes` to prevent the search from running indefinitely.

## Troubleshooting and Requirements
- **Barcode Format**: The tool strictly expects barcodes in the `BX:Z` tag format within the BAM and FASTQ headers.
- **GFA Format**: The input GFA must identify flanking sequences as "segments" (S lines) and targets as "gaps" (G lines).
- **Dependencies**: Ensure `MindTheGap`, `LRez`, and `Mummer` are in your PATH.



## Subcommands

| Command | Description |
|---------|-------------|
| LRez | LRez allows to work with barcoded Linked-Reads, and offers various barcode management functionalities. |
| bed2gfa.py | Convert a BED file containing the 'N's coordinates for each scaffold (or locus coordinates) to a GFA file (GFA 2.0) ('N's regions are treated as gaps). We can filter the 'N's regions by their size (e.g. gap lengths) and by the contigs' sizes on both sides (long enough for ex to get enough barcodes) |
| mtglink_mtglink.py | Local assembly with linked read data, using either a De Bruijn Graph (DBG) algorithm or an Iterative Read Overlap (IRO) algorithm |

## Reference documentation
- [MTG-Link README](./references/github_com_anne-gcd_MTG-Link_blob_master_README.md)
- [Utility Scripts Documentation](./references/github_com_anne-gcd_MTG-Link_tree_master_utils.md)