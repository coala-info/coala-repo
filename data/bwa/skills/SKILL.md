---
name: bwa
description: BWA is a bioinformatics tool suite used for aligning DNA sequences against a reference genome. Use when user asks to index a reference genome, align short or long reads using BWA-MEM, or map sequences to references with ALT contigs.
homepage: https://github.com/lh3/bwa
---

# bwa

## Overview
BWA is a foundational bioinformatics tool suite designed for aligning DNA sequences against a reference genome. It is particularly effective for short-read data (Illumina) but has evolved to support long-read technologies. This skill provides the procedural knowledge required to navigate its different algorithms—primarily BWA-MEM, BWA-backtrack, and BWA-SW—to ensure high-accuracy genomic mapping and proper handling of modern reference assemblies like GRCh38.

## Core Workflows

### 1. Reference Indexing
Before alignment, the reference FASTA must be indexed.
- **Standard Indexing**: `bwa index ref.fa`
- **Large Genomes**: For very large references (e.g., BLAST nt database), use `-b` to tune batch size: `bwa index -b 1000000000 ref.fa`
- **Algorithm Selection**: BWA typically chooses the construction algorithm automatically, but `bwtsw` is preferred for human-sized genomes.

### 2. Choosing the Right Algorithm
- **BWA-MEM**: The industry standard for high-quality queries (70bp to 1Mbp). It is faster, more accurate, and supports split alignments.
- **BWA-backtrack**: Best for Illumina reads up to 100bp (`aln`, `samse`, `sampe` commands).
- **BWA-SW**: Designed for long reads with higher error rates or frequent indels.

### 3. Alignment with BWA-MEM
BWA-MEM is the most versatile command for modern sequencing data.

**Illumina Paired-End:**
```bash
bwa mem -t 8 ref.fa read1.fq read2.fq > aln.sam
```

**Long-Read Presets:**
Use the `-x` flag to apply optimized heuristics for specific platforms:
- **PacBio**: `bwa mem -x pacbio ref.fa reads.fq`
- **Oxford Nanopore (2D)**: `bwa mem -x ont2d ref.fa reads.fq`

**Smart Interleaving:**
If using an interleaved FASTQ, use `-p`. BWA-MEM identifies adjacent reads with the same name as a pair.

### 4. Advanced Mapping Scenarios

#### Handling ALT Contigs (GRCh38)
When mapping to references with ALT contigs, BWA-MEM identifies hits to these regions.
- Use the `bwakit` wrapper for a complete pipeline that includes post-processing of ALT hits.
- The `AH:*` tag in the SAM header SQ lines indicates alternate haplotypes.

#### Hi-C Pipelines
For Hi-C data, use the `-5` option (which automatically applies `-q`) to preserve mapping quality for split alignments where the 5'-end has a lower score than the primary alignment.

#### Adding Read Groups
Always include Read Group information for downstream GATK/Samtools compatibility:
```bash
bwa mem -R '@RG\tID:foo\tSM:bar\tLB:library1' ref.fa reads.fq
```

## Expert Tips
- **I/O Optimization**: Modern BWA-MEM (v0.7.11+) uses a separate thread for I/O. This significantly reduces wall-clock time when piping data to `samtools view`.
- **Memory Management**: BWA-MEM requires approximately 5GB of RAM for the human genome index.
- **Alignment Scores**: Use the `XB` tag (introduced in v0.7.18) to output alignment scores and mapping quality for detailed QC.
- **Hard Clipping**: Use `-M` to mark shorter split hits as secondary for Picard/GATK compatibility.



## Subcommands

| Command | Description |
|---------|-------------|
| bwa aln | Find the SA coordinates of the input reads |
| bwa bwasw | BWA-SW alignment algorithm for long reads, supporting Smith-Waterman alignment and chimeric read detection. |
| bwa bwt2sa | Generate suffix array from BWT |
| bwa bwtupdate | Update the BWT (Burrows-Wheeler Transform) file. |
| bwa fa2pac | Convert FASTA format to PAC format for BWA indexing |
| bwa fastmap | Identify Super Maximal Exact Matches (SMEMs) in a sequence against a reference index. |
| bwa index | Index database sequences in the FASTA format |
| bwa mem | Burrows-Wheeler Alignment Tool, MEM algorithm for aligning low-divergence sequences against a large reference genome |
| bwa pac2bwt | Generate BWT from a PAC file |
| bwa pemerge | Merge paired-end reads from BWA |
| bwa sampe | Generate alignments in the SAM format given paired-end reads. |
| bwa samse | Generate alignments in the SAM format given single-end reads |
| bwa shm | Manage BWA indices in shared memory |
| bwtgen | Generate a BWT from a PAC file |

## Reference documentation
- [BWA README and Usage](./references/github_com_lh3_bwa_blob_master_README.md)
- [BWA Release News and Version History](./references/github_com_lh3_bwa_blob_master_NEWS.md)
- [BWA-ALT Mapping Guide](./references/github_com_lh3_bwa_blob_master_README-alt.md)