---
name: novoalign
description: Novoalign is a high-accuracy short-read aligner that performs optimal global alignment of genomic sequences using the Needleman-Wunsch algorithm. Use when user asks to index a reference genome, align single-end or paired-end reads, perform bisulfite mapping, or trim adapters during the alignment process.
homepage: http://www.novocraft.com/products/novoalign/
metadata:
  docker_image: "quay.io/biocontainers/novoalign:4.03.04--h43eeafb_3"
---

# novoalign

## Overview
Novoalign is a premium short-read aligner recognized for its high accuracy and sensitivity. Unlike faster but less exhaustive aligners, Novoalign uses a Needleman-Wunsch algorithm to find the optimal global alignment, making it the preferred choice for variant calling pipelines (like GATK) where precision is more critical than raw throughput. It excels at handling reads up to 950bp, managing gaps/mismatches up to 50% of read length, and performing specialized tasks like bisulfite mapping.

## Core CLI Patterns

### Indexing the Reference
Before alignment, the reference genome must be indexed into a proprietary `.nix` format.
```bash
novoindex reference.nix reference.fasta
```

### Basic Single-End Alignment
Map single-end reads and output in SAM format:
```bash
novoalign -d reference.nix -f reads.fastq -o SAM > alignment.sam
```

### Paired-End Alignment
Specify both read files. Novoalign automatically estimates the insert size distribution.
```bash
novoalign -d reference.nix -f read1.fastq read2.fastq -o SAM > paired_alignment.sam
```

### Bisulfite Sequencing (Methylation)
Enable the bisulfite mode for epigenetic studies:
```bash
novoalign -d reference.nix -f reads.fastq -b -o SAM > bisulfite_alignment.sam
```

## Expert Tips & Best Practices

- **Quality Calibration**: Use the `-i` option for automatic base quality calibration if the input FASTQ qualities are suspected to be inaccurate or from older Illumina pipelines.
- **Adapter Trimming**: Novoalign has built-in adapter stripping. Use `-a [adapter_sequence]` to trim adapters during the alignment process rather than using a separate pre-processing tool to maintain read synchronization.
- **Handling Multi-Mappers**: By default, Novoalign reports the best alignment. Use the `-r` option to control how multiple equidistant alignments are handled (e.g., `-r All` or `-r Random`).
- **Memory Management**: For large genomes (like Human), ensure the system has sufficient RAM to hold the `.nix` index. If memory is limited, use the `-m` flag to limit memory usage, though this may impact speed.
- **Soft Clipping**: Use the `-o SAM -S` flag to enable soft-clipping of reads that cannot be fully aligned, which is often required for downstream variant callers.
- **UMI Extraction**: For modern protocols using Unique Molecular Identifiers, ensure you are using version 4.03.00 or later, which includes improved support for extracting and handling UMI tags.

## Reference documentation
- [Novoalign Product Overview](./references/www_novocraft_com_products_novoalign.md)
- [Bioconda Novoalign Package](./references/anaconda_org_channels_bioconda_packages_novoalign_overview.md)