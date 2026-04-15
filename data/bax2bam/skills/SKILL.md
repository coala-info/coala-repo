---
name: bax2bam
description: The bax2bam tool converts legacy PacBio HDF5-formatted basecall files into consolidated BAM files that follow the PacBio BAM specification. Use when user asks to convert bax.h5 files to BAM format, process legacy PacBio data for modern workflows, or generate subreads and scraps from HDF5 movie files.
homepage: https://github.com/PacificBiosciences/bax2bam
metadata:
  docker_image: "quay.io/biocontainers/bax2bam:0.0.11--0"
---

# bax2bam

## Overview
The `bax2bam` tool is a specialized utility designed to bridge the gap between legacy PacBio data formats and modern genomic analysis workflows. It transforms the multi-file HDF5-based basecall format into a single, consolidated BAM file that adheres to the PacBio BAM specification. This conversion preserves essential metadata, including pulse features and signal-to-noise ratios, ensuring that downstream applications like circular consensus sequencing (CCS) or subread mapping can function correctly with older datasets.

## Usage Patterns

### Basic Conversion
To convert a set of legacy files from a single movie into a BAM file:
```bash
bax2bam movie.1.bax.h5 movie.2.bax.h5 movie.3.bax.h5 -o movie_prefix
```
Note: You must provide all three `.bax.h5` files associated with a single movie to ensure a complete conversion.

### Processing Multiple Movies
When dealing with multiple movies, it is more efficient to use a metadata file (XML) as input:
```bash
bax2bam input.dataset.xml -o output_prefix
```

### Common Command Options
- `--subread`: (Default) Outputs a BAM file containing subreads (adapter sequences removed).
- `--hqregion`: Outputs only the high-quality regions of the inserts.
- `--polymeraseread`: Outputs the full polymerase read, including adapters.
- `--scrap`: Generates an additional BAM file containing "scraps" (e.g., adapter sequences, low-quality regions) which are often required for certain downstream tools like `ccs`.

### Expert Tips
- **Resource Management**: Use the `-j` or `--num-threads` flag to specify the number of threads for faster processing on multi-core systems.
- **Pulse Features**: By default, `bax2bam` may not include all pulse features. If your downstream analysis requires specific kinetics (like IPD or PulseWidth), ensure you check if additional flags are needed for your specific version, though standard subread conversion typically includes basic kinetics.
- **Disk Space**: BAM files are generally more space-efficient than the legacy HDF5 format, but the conversion process requires temporary overhead. Ensure the output directory has sufficient space for the consolidated BAM and the optional scraps file.

## Reference documentation
- [bax2bam Overview](./references/anaconda_org_channels_bioconda_packages_bax2bam_overview.md)