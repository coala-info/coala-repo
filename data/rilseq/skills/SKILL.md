---
name: rilseq
description: RIL-seq identifies RNA-RNA interactions in bacteria by processing chimeric sequencing reads through mapping and statistical enrichment analysis. Use when user asks to map single or chimeric fragments, identify significant interacting regions, or analyze sRNA-target interaction datasets.
homepage: http://github.com/asafpr/RILseq
---

# rilseq

## Overview
RIL-seq is a specialized toolset designed to identify RNA-RNA interactions in bacteria by processing chimeric sequencing reads. This skill provides the procedural knowledge required to execute the three primary stages of the RIL-seq pipeline: initial fragment mapping, chimera identification, and statistical enrichment analysis. It is particularly useful for researchers working with Hfq-mediated or other sRNA-target interaction datasets.

## Installation and Prerequisites
RIL-seq can be installed via `pip` or `conda`. Note that fastq files must be pre-processed (adapter trimming and quality filtering) using tools like `cutadapt` before starting this protocol.

```bash
# Installation
pip install rilseq
# OR
conda install -c bioconda rilseq
```

## Core Workflow

### 1. Single Fragment Mapping
Map reads to the reference genome using `bwa`. This step handles both single-end and paired-end data.

```bash
map_single_fragments.py genome.fa \
  -g annotations.gff \
  -1 lib1_1.fastq.gz lib2_1.fastq.gz \
  -2 lib1_2.fastq.gz lib2_2.fastq.gz \
  -d output_dir \
  -o output_prefix \
  -m 3
```
- **-1 / -2**: Paths to R1 and R2 files. Order must match.
- **-m**: Maximum mismatches allowed (default is often 3).

### 2. Chimeric Fragment Mapping
Identify reads where the two ends map to different genomic locations, indicating a potential interaction.

```bash
map_chimeric_fragments.py genome.fa lib1_bwa.bam lib2_bwa.bam [additional_bams...]
```
- **Logic**: For paired-end, it takes the first 25nt of each fragment. For single-end, it takes the first and last 25nt.
- **Dust Filter**: Low complexity sequences are removed by default (threshold 10). Use `--dust_thr 0` to disable.
- **Circular RNAs**: By default, reads mapping in reverse order within 1000nt are removed. Use `--keep_circular` to retain them.
- **Long Transcripts**: Use `-t` to prevent flagging reads from the same long transcript (e.g., rRNAs) as chimeras.

### 3. Identifying Significant Interacting Regions
Apply Fisher's exact test to distinguish true biological interactions from random ligation events.

```bash
RIL_significant_regions.py reads_in_list \
  --ec_dir EcoCyc_dir \
  --EC_chrlist "chr,COLI-K12" \
  --seglen 100 \
  --min_int 5 \
  --max_pv 0.05
```
- **Segmentation**: The genome is divided into windows (default `--seglen 100`).
- **Normalization**: If total RNA-seq data is available, use `--total_RNA <indexed_bam_list>` to calculate a "Total normalized odds ratio," which accounts for RNA abundance.
- **Expansion**: Use `--maxsegs` (default 500) to allow interacting regions to expand and find the most significant p-value.

## Expert Tips
- **Read Length**: Ensure your chimeric mapping length (`-l`, default 25) does not cause overlaps in single-end reads, or the script will fail to produce results.
- **Memory Management**: When processing many BAM files, you can run `map_chimeric_fragments.py` on each individually and then concatenate the resulting text files before running the significance script.
- **Annotation**: Ensure your GFF/GTF files match the chromosome names in your `genome.fa` exactly to avoid decoration errors in the final report.



## Subcommands

| Command | Description |
|---------|-------------|
| RILseq_significant_regions.py | Find over-represented regions of interactions. |
| map_chimeric_fragments.py | Map unmapped reads as chimeric fragments |
| map_single_fragments.py | Map fastq files to the genome using bwa. |

## Reference documentation
- [RILseq GitHub Repository](./references/github_com_asafpr_RILseq.md)
- [Bioconda RILseq Package](./references/anaconda_org_channels_bioconda_packages_rilseq_overview.md)