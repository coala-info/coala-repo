---
name: freddie
description: Freddie is a bioinformatics pipeline that discovers transcriptomic isoforms from long-read sequencing data without requiring a reference annotation. Use when user asks to partition alignments, segment read sets, cluster reads using Gurobi optimization, or generate consensus isoforms in GTF format.
homepage: https://github.com/vpc-ccg/freddie
metadata:
  docker_image: "quay.io/biocontainers/freddie:0.4--hdfd78af_0"
---

# freddie

## Overview

Freddie is a specialized bioinformatics pipeline designed to discover transcriptomic isoforms from long-read sequencing data. Unlike many other tools, it does not require a reference annotation file (GTF/GFF) to guide the discovery process. It works by partitioning alignments into independent sets, segmenting them to find canonical breakpoints, clustering reads based on these segments using the Gurobi optimization solver, and finally generating consensus isoforms. This skill provides the procedural knowledge required to execute the four primary stages of the Freddie workflow via its native Python CLI.

## Execution Workflow

The Freddie pipeline consists of four sequential stages. Before starting, ensure your input SAM file is sorted and indexed.

### 1. Split (Partitioning)
Partitions reads into independent genomic sets to allow for parallel processing.
```bash
python py/freddie_split.py --reads [reads.fastq] --bam [sorted.bam] --outdir [split_dir] --threads [t]
```

### 2. Segment
Computes canonical segmentation for each read set.
```bash
python py/freddie_segment.py --split-dir [split_dir] --outdir [segment_dir] --threads [t]
```
*   **Expert Tip**: Adjust `--sigma` (default 5.0) if you have extremely high or low coverage to refine the Gaussian filter used for breakpoint detection.

### 3. Cluster
Clusters reads using their segmentation representation. This stage requires a Gurobi license.
```bash
export GRB_LICENSE_FILE=/path/to/gurobi.lic
python py/freddie_cluster.py --segment-dir [segment_dir] --outdir [cluster_dir] --threads [t]
```
*   **Constraint**: If the optimization takes too long, use `--timeout` (default 4 minutes) to limit the time spent per isoform.

### 4. Isoforms
Generates the final consensus isoforms in GTF format.
```bash
python py/freddie_isoforms.py --split-dir [split_dir] --cluster-dir [cluster_dir] --output [isoforms.gtf] --threads [t]
```

## Best Practices and Requirements

*   **Input Alignment**: Use a splice-aware aligner like `minimap2` (with `-x splice`) or `deSALT`. Freddie relies on the quality of these initial splice alignments.
*   **Gurobi License**: The clustering stage is mathematically intensive and requires the Gurobi Solver. Academic users can obtain a free license from Gurobi's website.
*   **Environment**: It is recommended to run Freddie within its dedicated Conda environment to ensure all Python dependencies and Gurobi components are correctly linked.
*   **Parallelization**: Freddie is designed for multi-threading. Always specify the `-t` parameter across all stages to significantly reduce processing time, especially during the Segment and Cluster phases.



## Subcommands

| Command | Description |
|---------|-------------|
| freddie_isoforms.py | Extract alignment information from BAM/SAM file and splits reads into distinct transcriptional intervals |
| freddie_segment.py | Cluster aligned reads into isoforms |
| freddie_split.py | Extract alignment information from BAM/SAM file and splits reads into distinct transcriptional intervals |

## Reference documentation
- [Freddie README](./references/github_com_vpc-ccg_freddie_blob_master_README.md)
- [Freddie Output Structure](./references/github_com_vpc-ccg_freddie_blob_master_OUTPUT.md)