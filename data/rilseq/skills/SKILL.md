---
name: rilseq
description: "RIL-seq processes RNA-RNA interaction data to identify and statistically validate chimeric fragments in prokaryotic sequencing experiments. Use when user asks to map genomic fragments, identify chimeric RNA reads, or perform statistical enrichment analysis of RNA-RNA interactions."
homepage: http://github.com/asafpr/RILseq
---


# rilseq

## Overview

RIL-seq is a specialized computational protocol designed to process RNA-RNA interaction data in prokaryotes. The tool transforms pre-processed sequencing reads into a map of interacting RNA pairs by identifying chimeric fragments that do not map concordantly to the genome. It employs a three-stage pipeline: initial genomic mapping, chimera detection from fragment ends, and statistical enrichment analysis using Fisher's exact test to distinguish true biological interactions from experimental noise.

## Installation and Prerequisites

RIL-seq can be installed via conda or pip:
- `conda install bioconda::rilseq`
- `pip install rilseq`

**Note**: Input FASTQ files must be pre-processed for quality and adapter removal (e.g., using `cutadapt`) before starting the RIL-seq pipeline.

## Core Workflow

### 1. Initial Mapping
Use `map_single_fragments.py` to map reads to the reference genome using `bwa`.

```bash
map_single_fragments.py genome.fa -g annotations.gff -1 lib1_1.fastq.gz -2 lib1_2.fastq.gz -d output_dir -o output_prefix -m max_mismatches
```
- **Paired-end**: Provide both `-1` and `-2` flags.
- **Single-end**: Provide only the `-1` flag.
- **Mixed**: List all libraries in `-1`; the libraries in `-2` must match the order of the first set.

### 2. Chimera Identification
After generating BAM files, use `map_chimeric_fragments.py` to find chimeric reads. This script extracts the ends of fragments (default 25nt) and maps them independently.

```bash
map_chimeric_fragments.py genome.fa lib1_bwa.bam lib2_bwa.bam [additional_bams...]
```

**Key Parameters:**
- `-l`: Length of the ends to take (default 25).
- `--dust_thr`: Dust filter threshold for low complexity (default 10; set to 0 to disable).
- `--max_mismatches`: Mismatches allowed to determine if reads are on the same transcript (default 3).
- `--allowed_mismatches`: Mismatches allowed for the final mapping of chimeric ends (default 1).
- `--keep_circular`: By default, the tool removes reads that appear to be circular RNAs (mapped <1000nt apart in reverse order). Use this flag to keep them.
- `-t`: Test if reads reside on the same transcript even if distance >1000nt (useful for rRNAs).

### 3. Statistical Significance
Identify over-represented interacting regions by comparing observed interactions against a random distribution.

```bash
RILseq_significant_regions.py reads_in_list --ec_dir EcoCyc_dir --EC_chrlist "chr_name"
```

**Analysis Parameters:**
- `--seglen`: Genome window size for non-overlapping windows (default 100nt).
- `--min_int`: Minimum number of interactions required to test a pair (default 5).
- `--max_pv`: P-value threshold for reporting (default 0.05).
- `--maxsegs`: Maximum expansion of regions to find the lowest p-value (default 500nt).
- `--total_RNA`: Provide a comma-separated list of indexed BAM files from a total RNA experiment to normalize for RNA abundance.

## Expert Tips

- **Memory Management**: For large datasets, you can run `map_chimeric_fragments.py` on individual BAM files and concatenate the resulting reads files before running the significance script.
- **Low Complexity Filtering**: If you are working with AT-rich genomes or specific RNA classes, adjust `--dust_thr`. High values are more stringent.
- **Total RNA Normalization**: Always use the `--total_RNA` option if available. This calculates a "Total normalized odds ratio," which helps identify if an interaction is significant relative to the actual abundance of the RNAs in the cell, rather than just their abundance on the RNA-binding protein (e.g., Hfq).
- **Ribosomal RNA**: Use the `-t` argument during chimera mapping if you suspect many interactions are occurring within long operons like rRNAs, as these are often filtered out as "concordant" by default.

## Reference documentation
- [RILseq computational protocol](./references/github_com_asafpr_RILseq.md)
- [rilseq - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_rilseq_overview.md)