---
name: pore-c
description: The pore-c toolkit processes multi-contact long-read sequencing data to analyze higher-order chromatin structure. Use when user asks to generate virtual digests, filter BAM alignments, identify ligation junctions, or convert Pore-C data into pairs and Cooler formats.
homepage: https://github.com/nanoporetech/pore-c
metadata:
  docker_image: "quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0"
---

# pore-c

## Overview
The `pore-c` toolkit is a specialized suite designed to handle the unique requirements of multi-contact Pore-C reads, often referred to as "C-walks." Unlike standard Hi-C tools that focus on pairs, `pore-c` is optimized for long-read concatemers. It manages the transition from raw alignments to filtered contact formats and Cooler-compatible matrices, enabling downstream analysis of higher-order chromatin structure.

## Installation and Environment
The tool is primarily distributed via Bioconda. Because the project is archived, it is best to run it in a dedicated environment to manage dependencies like `pyarrow` and `numpy`.

```bash
# Standard installation
conda install -c bioconda pore-c

# Development/Interactive environment using tox
tox -e dev -- <command> --help
```

## Core Workflow and CLI Patterns

### 1. Reference Genome Preparation
Before processing reads, you must generate a virtual digest of your reference genome based on the restriction enzyme used in the experiment (e.g., HindIII, NlaIII).

```bash
# Generate auxiliary files and virtual digests
pore_c refgenome --help
```

### 2. BAM Processing and Filtering
The toolkit processes BAM files to identify valid ligation junctions and filter out spurious alignments. This step is critical for assigning fragments to specific genomic coordinates.
- **Filtering**: Removes alignments that do not meet quality thresholds or represent technical artifacts.
- **Junction Detection**: Identifies the points where DNA fragments were ligated during the Pore-C protocol.

### 3. Contact Conversion
After processing, the tool converts the multi-contact data into standard formats for visualization and further analysis.
- **Pairs Format**: Generates `.pairs` files compatible with `pairtools`.
- **Cooler Matrices**: Produces COO-formatted matrices that can be loaded into `Cooler` for generating `.cool` or `.mcool` files.

## Expert Tips and Best Practices
- **Check Deprecation Status**: This specific `pore-c` package is archived. For new pipelines, Oxford Nanopore recommends transitioning to `pore-c-py` and the Nextflow-based `wf-pore-c` pipeline.
- **Snakemake Integration**: While the CLI can be used standalone, the developers recommend running these tools via the `Pore-C-Snakemake` wrapper to handle the complex dependencies between alignment, filtering, and matrix generation.
- **Memory Management**: Processing multi-contact long reads is memory-intensive. Ensure your environment has sufficient RAM, especially when generating high-resolution Cooler matrices.
- **Virtual Digest Validation**: Always verify that the restriction enzyme site used in `refgenome` matches your wet-lab protocol, as an incorrect digest will lead to failed fragment assignment.

## Reference documentation
- [Pore-C GitHub Repository](./references/github_com_nanoporetech_pore-c.md)
- [Bioconda Pore-C Overview](./references/anaconda_org_channels_bioconda_packages_pore-c_overview.md)