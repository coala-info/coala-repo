---
name: vidjil-algo
description: Vidjil-algo processes high-throughput sequencing data to identify and quantify V(D)J recombinations in B and T cells. Use when user asks to identify V(D)J recombinations, quantify V(D)J recombinations, process sequencing data, identify clones, merge paired-end reads, or analyze multiple genomes.
homepage: https://gitlab.inria.fr/vidjil/vidjil
metadata:
  docker_image: "quay.io/biocontainers/vidjil-algo:2025.02--h077b44d_0"
---

# vidjil-algo

## Overview
This skill provides specialized guidance for using `vidjil-algo`, the core computational engine of the Vidjil platform. It is designed to process high-throughput sequencing data to identify and quantify V(D)J recombinations in B and T cells. Use this tool to transform raw genomic reads into structured repertoire data, enabling clonal identification and longitudinal tracking.

## Core Command Patterns

### Basic Analysis
The most common usage involves processing a single-end or paired-end file against the default germline database:
```bash
vidjil-algo -c vdj -g germline/homo-sapiens.yaml data/sample.fastq
```

### Paired-End Merging
For paired-end reads that require merging before analysis:
```bash
vidjil-algo -c vdj -g germline/homo-sapiens.yaml data/read1.fastq data/read2.fastq
```

### Multi-Genome Analysis
To search for recombinations across multiple species or specific loci (e.g., human and mouse for xenografts):
```bash
vidjil-algo -g germline/homo-sapiens.yaml -g germline/mus-musculus.yaml data/sample.fastq
```

## Expert Tips & Best Practices

- **Output Files**: By default, the tool produces a `.vidjil` JSON file. This file contains the identified clones and their frequencies, which can be uploaded to the Vidjil web platform for visualization.
- **Germline Selection**: Always ensure the `-g` flag points to the correct species configuration. The algorithm relies on these YAML definitions to identify V, D, and J segments.
- **Performance**: For large datasets, use the `-u` (unsegmented) flag to output reads that did not match any V(D)J recombination into a separate file for further troubleshooting.
- **Read Filtering**: Use the `-v` (verbose) flag during initial runs to monitor the percentage of reads successfully assigned to clones. A low assignment rate often indicates poor sequencing quality or incorrect germline selection.
- **Memory Management**: When processing very deep sequencing runs, ensure the host system has sufficient RAM, as `vidjil-algo` performs intensive string matching and clustering in-memory.

## Reference documentation
- [Vidjil-algo Overview](./references/anaconda_org_channels_bioconda_packages_vidjil-algo_overview.md)
- [Vidjil Source Repository](./references/gitlab_inria_fr_vidjil_vidjil.md)