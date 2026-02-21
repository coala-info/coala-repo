---
name: r
description: The STAR (Spliced Transcripts Alignment to a Reference) tool is a high-performance aligner specifically engineered for RNA-seq data.
homepage: https://github.com/alexdobin/STAR
---

# r

## Overview
The STAR (Spliced Transcripts Alignment to a Reference) tool is a high-performance aligner specifically engineered for RNA-seq data. It is designed to accurately identify splice junctions and map reads across long introns with high speed. The workflow typically involves two distinct stages: generating a genome index from FASTA and GTF files, followed by the actual alignment of sequencing reads. It is the standard choice for pipelines requiring high-precision transcriptomics analysis.

## Common CLI Patterns

### 1. Genome Index Generation
Before mapping, you must generate a genome index. This requires significant RAM (approx. 30GB for human/mouse).
```bash
STAR --runMode genomeGenerate \
     --runThreadN 8 \
     --genomeDir ./genome_index \
     --genomeFastaFiles reference.fasta \
     --sjdbGTFfile annotations.gtf \
     --sjdbOverhang 99
```
*Note: `--sjdbOverhang` should ideally be (ReadLength - 1).*

### 2. Basic Alignment
Standard mapping for paired-end reads, outputting a coordinate-sorted BAM file.
```bash
STAR --runThreadN 12 \
     --genomeDir ./genome_index \
     --readFilesIn read1.fastq read2.fastq \
     --outFileNamePrefix sample_output_ \
     --outSAMtype BAM SortedByCoordinate
```

### 3. Handling Compressed Files
If your FASTQ files are gzipped, use the `--readFilesCommand` parameter.
```bash
STAR --genomeDir ./genome_index \
     --readFilesIn read1.fastq.gz read2.fastq.gz \
     --readFilesCommand zcat \
     --outSAMtype BAM SortedByCoordinate
```

### 4. Two-Pass Mapping
For better detection of novel splice junctions, use the 2-pass mode.
```bash
STAR --genomeDir ./genome_index \
     --readFilesIn read1.fastq read2.fastq \
     --twopassMode Basic \
     --outSAMtype BAM SortedByCoordinate
```

### 5. Single-Cell RNA-seq (STARsolo)
To process 10x Genomics or similar single-cell data:
```bash
STAR --genomeDir ./genome_index \
     --readFilesIn cDNA_read.fastq.gz CellBarcode_UMI_read.fastq.gz \
     --readFilesCommand zcat \
     --soloType CB_UMI_Simple \
     --soloCBwhitelist /path/to/whitelist.txt \
     --outSAMtype BAM SortedByCoordinate
```

## Expert Tips and Best Practices

- **Memory Management**: For large genomes (mammals), ensure the system has at least 32GB of RAM. If memory is limited, use `--genomeSAsparseD 2` during genome generation to reduce the index size at a slight cost to mapping speed.
- **Multithreading**: Always scale `--runThreadN` to the available CPU cores to maximize throughput.
- **FIFO Cleanup**: If a run crashes, check for leftover FIFO files in the temporary directory that might block subsequent runs.
- **Chromosome Names**: Ensure that chromosome names in the GTF file exactly match those in the FASTA files to avoid empty alignment results.
- **Output Filtering**: Use `--outFilterMultimapNmax` to control how many loci a read can map to before being marked as unmapped (default is 10).

## Reference documentation
- [STAR Main Repository](./references/github_com_alexdobin_STAR.md)
- [STAR Wiki and FAQ](./references/github_com_alexdobin_STAR_wiki.md)