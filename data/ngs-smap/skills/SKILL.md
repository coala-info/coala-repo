---
name: ngs-smap
description: ngs-smap is a toolset for analyzing Next-Generation Sequencing data by identifying stacks of overlapping reads to delineate haplotypes and clusters. Use when user asks to delineate loci from alignment files, call haplotypes, generate genomic relationship matrices, or compare sample sets.
homepage: https://gitlab.com/truttink/smap
---


# ngs-smap

## Overview
The ngs-smap (Stack-based Mapping) toolset provides a specialized workflow for analyzing Next-Generation Sequencing data by focusing on "stacks" of reads. Unlike traditional SNP-centric approaches, SMAP identifies clusters of overlapping reads to delineate haplotypes, making it highly effective for diversity studies, polyploid genomics, and complex locus analysis. It is particularly useful for researchers working with non-model organisms or complex polyploid genomes where traditional reference-based SNP calling may be limited.

## Core Command: smap delineate
The `delineate` module is the primary tool for identifying loci and clusters from alignment files.

### Common CLI Pattern
```bash
smap delineate /path/to/alignments/ \
  -r stranded \
  -p 4 \
  -q 20 \
  -x 5 \
  -y 1500 \
  -c 10 \
  -s 20 \
  -w 5 \
  -n project_name
```

### Parameter Reference
- `-r`: Mapping orientation (e.g., `stranded`, `unstranded`).
- `-p`: Number of parallel processes to use.
- `-q`: Minimum mapping quality threshold for read filtering.
- `-x`: Minimum stack depth (minimum number of reads per stack).
- `-y`: Maximum stack depth (to filter out repetitive regions or PCR artifacts).
- `-c`: Minimum cluster depth (total depth across the cluster).
- `-s`: Maximum number of SMAPs (Stack-based Mapping Polymorphisms/Haplotypes) allowed per locus.
- `-w`: Completeness threshold for merged clusters.
- `-n`: Prefix for output files.

## Additional Modules
- **smap haplotype**: Used for calling haplotypes based on the clusters defined during delineation.
- **smap grm**: Generates a Genomic Relationship Matrix from haplotype data for population structure and kinship analysis.
- **smap snp-seq**: Specifically handles SNP sequencing data integration.
- **smap compare**: Facilitates comparison between two different sample sets or populations.
- **smap target-selection**: Assists in selecting targets for downstream analysis or primer design.

## Expert Tips and Best Practices
- **Resource Management**: Always specify the `-p` parameter to match your environment's CPU availability, as SMAP is designed to scale across multiple processes during the stack generation phase.
- **Warning Suppression**: SMAP often issues warnings if specific filters like `--min_cluster_length` or `--max_stack_number` are not explicitly set. To ensure a clean log and reproducible results, explicitly define these parameters (e.g., `--min_cluster_length 0` or `--max_cluster_length inf`) even if using the defaults.
- **Input Validation**: Ensure BAM files are sorted and indexed. If encountering `TypeError: 'float' object is not iterable` or `DtypeWarning` during execution, check for mixed data types in your input BED files or metadata, as the underlying pandas-based processing is sensitive to column type consistency.
- **Stack Depth Tuning**: The range between `-x` (min) and `-y` (max) is critical. Setting `-y` too high may include misaligned repetitive elements, while setting it too low may exclude high-copy functional genes.

## Reference documentation
- [SMAP GitLab Home](./references/gitlab_com_truttink_smap.md)
- [SMAP Issue Log (CLI Examples)](./references/gitlab_com_truttink_smap.atom.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ngs-smap_overview.md)