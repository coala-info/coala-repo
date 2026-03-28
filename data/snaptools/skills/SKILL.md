---
name: snaptools
description: Snaptools processes single-cell epigenomics data by managing the creation, manipulation, and analysis of structured .snap files. Use when user asks to index genomes, align sequencing reads, create snap files from BAM files, or generate cell-by-bin, cell-by-peak, and cell-by-gene count matrices.
homepage: https://github.com/r3fang/SnapTools.git
---


# snaptools

## Overview

snaptools is a specialized Python-based command-line suite designed for handling Single Nucleus Accessibility Profile (.snap) files. These files are hierarchically structured HDF5 containers optimized for storing and querying large-scale single-cell epigenomics datasets. The tool manages the entire primary data processing pipeline—from raw sequencing reads and genome alignment to the generation of structured count matrices (bins, peaks, and genes) and fragment indexing.

## Core Workflow and CLI Patterns

### 1. Genome Indexing
Before alignment, index the reference genome using a supported aligner (e.g., BWA).
```bash
snaptools index-genome \
    --input-fasta=genome.fa \
    --output-prefix=genome_index \
    --aligner=bwa \
    --path-to-aligner=/path/to/bwa/bin/ \
    --num-threads=5
```

### 2. Alignment
Align paired-end or single-end reads. **Critical**: Set `--if-sort=True` to sort reads by name, which is required for grouping fragments by barcode in subsequent steps.
```bash
snaptools align-paired-end \
    --input-reference=genome.fa \
    --input-fastq1=reads.R1.fastq.gz \
    --input-fastq2=reads.R2.fastq.gz \
    --output-bam=aligned.bam \
    --aligner=bwa \
    --read-fastq-command=zcat \
    --if-sort=True \
    --num-threads=8
```

### 3. Snap File Creation (Preprocessing)
Convert BAM files into the `.snap` format. This step performs quality control, filters fragments by mapping quality (MAPQ) and length, and removes PCR duplicates.
```bash
snaptools snap-pre \
    --input-file=aligned.bam \
    --output-snap=sample.snap \
    --genome-name=hg38 \
    --genome-size=hg38.chrom.size \
    --min-mapq=30 \
    --max-flen=1000 \
    --keep-chrm=TRUE \
    --min-cov=100
```
*Note: This command also generates a `.snap.qc` file containing library quality metrics.*

### 4. Matrix Generation
Add count matrices to the existing `.snap` file. These commands modify the file in-place.

**Cell-by-Bin Matrix:**
```bash
snaptools snap-add-bmat \
    --snap-file=sample.snap \
    --bin-size-list 5000 10000
```

**Cell-by-Peak Matrix:**
```bash
snaptools snap-add-pmat \
    --snap-file=sample.snap \
    --peak-file=peaks.bed
```

**Cell-by-Gene Matrix:**
```bash
snaptools snap-add-gmat \
    --snap-file=sample.snap \
    --gene-file=genes.bed
```

## Expert Tips and Best Practices

- **In-place Updates**: Most `snap-add-*` commands append data to the original `.snap` file rather than creating new files. Ensure you have sufficient disk space and write permissions.
- **Session Management**: Use `snap-del` to remove specific sessions (e.g., a specific bin resolution or the peak matrix) if you need to re-run a step without recreating the entire file.
- **Memory and Performance**: When processing large datasets, utilize the `--num-threads` parameter in alignment and indexing steps. For `snap-pre`, the `--max-num` parameter can limit the number of barcodes processed if testing on a subset.
- **Fragment Indexing**: The FM (fragment) session in the snap file is indexed for fast search. This is essential for downstream visualization and subsetting.



## Subcommands

| Command | Description |
|---------|-------------|
| snap-add-bmat | Add cell-by-bin count matrix to snap file. |
| snap-add-gmat | Add gene matrix to snap file. |
| snap-add-pmat | Add peak information to snap file. |
| snap-del | Delete a session from a snap file. |
| snap-pre | Preprocess single-cell ATAC-seq data into snap format. |
| snaptools align-paired-end | Align paired-end FASTQ files to a reference genome. |
| snaptools align-single-end | Align single-end reads to a reference genome. |
| snaptools dex-fastq | Decomplexes a fastq file containing reads from multiple cells into individual fastq files for each cell. |
| snaptools index-genome | Builds genome index for snaptools. |

## Reference documentation
- [SnapTools README](./references/github_com_r3fang_SnapTools_blob_master_README.md)