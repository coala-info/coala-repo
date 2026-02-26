---
name: freddie
description: Freddie is an annotation-free tool that detects and discovers alternative splicing isoforms from transcriptomic long-reads aligned to a reference genome. Use when user asks to identify novel transcripts, perform isoform discovery without a GTF file, or generate consensus isoforms from long-read alignments.
homepage: https://github.com/vpc-ccg/freddie
---


# freddie

## Overview

Freddie is an annotation-free isoform detection and discovery tool designed for transcriptomic long-reads. It identifies alternative splicing isoforms by analyzing reads aligned to a reference genome. Unlike many other tools, Freddie does not require a prior annotation file (GTF/GFF) to guide the discovery process, making it ideal for identifying novel transcripts or working with poorly annotated genomes. The pipeline transforms raw alignments into a set of consensus isoforms in GTF format through a four-stage computational process.

## Usage Instructions

### 1. Pre-processing
Before running Freddie, reads must be aligned to the reference genome using a splice-aware aligner (e.g., `minimap2` or `deSALT`) and the resulting SAM file must be sorted and indexed.

```bash
# Example alignment with minimap2
minimap2 -a -x splice -t {threads} {genome.fasta} {reads.fastq} > aligned.sam

# Sort and index
samtools sort aligned.sam -o sorted.bam
samtools index sorted.bam
```

### 2. Pipeline Stages

#### Split (Partitioning)
Partitions the reads into independent sets for parallel processing.
```bash
python py/freddie_split.py --reads {reads.fastq} --bam {sorted.bam} --outdir {split_dir} -t {threads}
```

#### Segment (Canonical Segmentation)
Computes the segmentation for each read set.
```bash
python py/freddie_segment.py -s {split_dir} --outdir {segment_dir} -t {threads}
```
*   **Key Parameter**: `--sigma` (Default: 5.0). Adjust the Gaussian filter standard deviation if breakpoint detection is too sensitive or too coarse.

#### Cluster (Isoform Clustering)
Clusters reads based on their segmentation. This stage requires a Gurobi license.
```bash
# Set license path
export GRB_LICENSE_FILE=/path/to/gurobi.lic

python py/freddie_cluster.py --segment-dir {segment_dir} --outdir {cluster_dir} -t {threads}
```
*   **Key Parameter**: `--min-isoform-size` (Default: 3). Minimum read support required to report an isoform.
*   **Key Parameter**: `--timeout` (Default: 4). Gurobi timeout per isoform in minutes.

#### Isoforms (GTF Generation)
Generates the final consensus isoforms.
```bash
python py/freddie_isoforms.py --split-dir {split_dir} --cluster-dir {cluster_dir} --output {isoforms.gtf} -t {threads}
```

### 3. Expert Tips
*   **Gurobi Requirement**: The `cluster` stage is computationally intensive and relies on the Gurobi Solver. Ensure `GRB_LICENSE_FILE` is exported in your environment before execution.
*   **Parallelization**: Use the `-t` (threads) flag across all stages to significantly reduce processing time, especially during the `split` and `segment` phases.
*   **Memory Management**: For the `segment` stage, if dealing with extremely high-coverage regions, monitor memory usage; you may need to adjust `--max-problem-size` (Default: 50) to break down large problems.

## Reference documentation
- [Freddie GitHub Repository](./references/github_com_vpc-ccg_freddie.md)
- [Bioconda Freddie Overview](./references/anaconda_org_channels_bioconda_packages_freddie_overview.md)