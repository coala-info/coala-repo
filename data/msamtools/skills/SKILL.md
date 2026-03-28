---
name: msamtools
description: msamtools is a suite of tools designed to filter and profile large-scale shotgun metagenomics data by extending the functionality of samtools. Use when user asks to filter SAM/BAM alignments by identity or length, estimate relative abundance profiles, calculate sequence coverage, or remove host sequences from metagenomic datasets.
homepage: https://github.com/arumugamlab/msamtools
---

# msamtools

## Overview
msamtools is a specialized suite of tools designed to extend the functionality of samtools for microbiome research. It excels at processing large-scale shotgun metagenomics data by providing high-performance filtering and profiling capabilities. It is particularly useful for "on-the-fly" processing in command-line pipes, allowing researchers to filter alignments by specific identity and length thresholds without creating massive intermediate files.

## Core Commands and Usage

### 1. msamtools filter
Used to filter SAM/BAM alignments based on alignment statistics. This is often used to remove low-quality or spurious mappings.

**Common Options:**
- `-l <int>`: Minimum alignment length (e.g., `-l 80`).
- `-p <float>`: Minimum percent identity (e.g., `-p 95`).
- `-z <float>`: Minimum percent of the read aligned (e.g., `-z 80`).
- `-b`: Output in BAM format.
- `-S`: Input is in SAM format.
- `-u`: Output uncompressed BAM (faster for piping).
- `--besthit`: Retain only the highest-scoring alignment for each read.
- `--invert`: Invert the filter (useful for host-removal workflows).
- `--keep_unmapped`: Retain unmapped reads in the output.

**Example: Filtering on the fly**
```bash
bwa-mem2 mem DB R1.fq R2.fq | msamtools filter -S -b -l 80 -p 95 -z 80 > filtered.bam
```

### 2. msamtools profile
Estimates the relative abundance profile of reference sequences (genes or genomes) from a BAM file.

**Common Options:**
- `--multi <string>`: How to handle multi-mapping reads (`proportional`, `random`, or `all`). `proportional` is recommended for metagenomics.
- `--label <string>`: Sample label for the output table.
- `-o <file>`: Output file path.

**Example: Generating a gene profile**
```bash
msamtools profile --multi=proportional --label=SampleA -o profile.txt input.bam
```

### 3. msamtools coverage
Estimates per-base or per-sequence read coverage.

### 4. msamtools summary
Summarizes alignment statistics (matches, mismatches, edits, etc.) for every read in a table format.

## Expert Workflows

### Host Sequence Removal
To remove human/host reads effectively, use a low alignment length threshold and the `--invert` flag. This captures even short partial matches to the host genome and discards them.

```bash
bwa-mem2 mem HUMAN_DB R1.fq R2.fq \
  | msamtools filter -S -l 30 --invert --keep_unmapped -bu - \
  | samtools fastq -1 hostfree_R1.fq.gz -2 hostfree_R2.fq.gz -
```

### Best-Hit Profiling
For gene catalog mapping (e.g., IGC), it is common to filter for high-quality alignments and then take the best hit before profiling.

```bash
samtools sort -n input.bam \
  | msamtools filter -b -u -l 80 -p 95 --besthit - \
  | msamtools profile --multi=proportional --label=Sample1 -o Sample1.profile.txt -
```
*Note: Input to msamtools filter/profile often benefits from being name-sorted (`samtools sort -n`) when dealing with paired-end data.*



## Subcommands

| Command | Description |
|---------|-------------|
| msamtools profile | Produces an abundance profile of all reference sequences in a BAM file based on the number of read-pairs (inserts) mapping to each reference sequence. |
| msamtools_coverage | Produces per-position sequence coverage information for all reference sequences in the BAM file. Output is similar to old-style quality files from the Sanger  sequencing era, with a fasta-style header followed by lines of space-delimited  numbers. |
| msamtools_filter | Filter alignments from BAM/SAM files. |
| msamtools_summary | Prints summary of alignments in the given BAM/SAM file. By default, it prints a summary line per alignment entry in the file. The summary is a tab-delimited line with the following fields: qname,aligned_qlen,target_name,glocal_align_len,matches,percent_identity glocal_align_len includes the unaligned qlen mimicing a global alignment in the query and local alignment in target, thus glocal. With --stats option, summary is consolidated as distribution of read counts for a given measure. --stats=mapped   - distribution for number of mapped query bases --stats=unmapped - distribution for number of unmapped query bases --stats=edit     - distribution for edit distances --stats=score    - distribution for score=match-edit |

## Reference documentation
- [msamtools README](./references/github_com_arumugamlab_msamtools_blob_master_README.md)
- [msamtools Overview](./references/anaconda_org_channels_bioconda_packages_msamtools_overview.md)