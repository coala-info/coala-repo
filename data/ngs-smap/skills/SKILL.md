---
name: ngs-smap
description: ngs-smap processes stack-based NGS data to define genomic loci and identify haplotypes from raw alignments. Use when user asks to delineate loci, call haplotypes, calculate genetic relationship matrices, or compare merged clusters.
homepage: https://gitlab.com/truttink/smap
metadata:
  docker_image: "quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0"
---

# ngs-smap

## Overview
The `ngs-smap` (Stack Mapping Analysis Pipeline) tool is designed to handle the complexity of stack-based NGS data. It transforms raw alignments into biological insights by grouping reads into "stacks" and "clusters" to define loci and haplotypes. This skill provides the necessary CLI patterns for the core modules: `delineate`, `haplotype`, `compare`, and `grm`.

## Core Command Patterns

### 1. Delineating Loci (smap delineate)
Use this to define the genomic regions (clusters) based on read depth and mapping density.

```bash
smap delineate <alignments_dir> \
  -r <stranded|unstranded> \
  -p <processes> \
  -q <min_mapping_quality> \
  -x <min_stack_depth> \
  -y <max_stack_depth> \
  -c <min_cluster_depth> \
  -n <project_name>
```

**Expert Tips:**
- **Filtering**: Use `-x` and `-y` to exclude low-confidence stacks or repetitive regions with excessive depth.
- **Orientation**: Ensure `-r stranded` is used for data where read orientation is biologically significant (e.g., specific amplicon designs).
- **Output**: This generates a `.bed` file defining the discovered loci, which is required for downstream haplotyping.

### 2. Haplotype Calling (smap haplotype)
Use this to identify specific sequences (haplotypes) within the delineated clusters across samples.

```bash
smap haplotype <alignments_dir> <delineated_loci.bed> \
  -p <processes> \
  -o <output_prefix>
```

### 3. Genetic Relationship Matrix (smap grm)
Calculate genetic distances or relationship matrices based on the haplotyping results.

```bash
smap grm <haplotype_table.txt> \
  -m <method> \
  -o <output_file>
```

### 4. SNP-seq Analysis
For targeted SNP sequencing, use the specialized `smap snp-seq` module to extract variant information from defined targets.

## Troubleshooting Common Issues

- **TypeErrors in Delineate**: If you encounter `TypeError: 'float' object is not iterable`, it often relates to pandas/pybedtools handling of mixed types in columns 3, 5, or 6 of intermediate files. Ensure your input BAMs are properly indexed and the reference genome naming is consistent.
- **Memory Management**: For large datasets (millions of reads), balance the `-p` (processes) flag with available RAM, as each process loads a portion of the alignment data.
- **Missing Arguments**: `smap delineate` will issue warnings if filters like `--min_cluster_length` are omitted. Explicitly set them to `0` or `inf` to suppress warnings and ensure deterministic behavior.



## Subcommands

| Command | Description |
|---------|-------------|
| compare | Compare merged clusters of two SMAP outputs. |
| delineate | Create a bed file with clusters of Stacks using a set of bam files containing aligned GBS reads. The Stack Mapping Anchor Points "SMAP" within clustersof Stacks are listed 0-based. The position of the clusters of Stacks themselves are 0-based according to BED format. |
| smap | Convert the haplotype table from SMAP haplotype-sites or SMAP haplotype-windows into a genetic similarity/distance matrix and/or a locus information matrix. |

## Reference documentation
- [SMAP README](./references/gitlab_com_truttink_smap_-_blob_master_README.md)
- [SMAP Project Overview](./references/gitlab_com_truttink_smap.md)