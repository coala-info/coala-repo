---
name: mixcr
description: MiXCR is a comprehensive bioinformatics platform designed for the fast and accurate processing of raw adaptive immune receptor repertoire sequencing (Rep-Seq) data.
homepage: https://github.com/milaboratory/mixcr
---

# mixcr

## Overview
MiXCR is a comprehensive bioinformatics platform designed for the fast and accurate processing of raw adaptive immune receptor repertoire sequencing (Rep-Seq) data. It transforms raw sequencing reads into quantified clonotypes by performing alignment against germline V, D, J, and C gene segments, assembling clones based on specific gene features (like CDR3), and applying sophisticated error correction. It is compatible with a wide range of data types, including bulk sequencing, single-cell (e.g., 10x Genomics), and fragmented RNA-Seq data.

## Installation and Setup
MiXCR can be installed via multiple package managers or run via Docker:

- **Homebrew**: `brew install milaboratory/all/mixcr`
- **Conda**: `conda install -c milaboratories mixcr` (Use `--no-deps` if you already have Java installed).
- **Docker**: Use the official image `ghcr.io/milaboratory/mixcr/mixcr:latest`.

### License Activation
MiXCR requires a license for most operations. Pass the license via environment variables:
```bash
export MI_LICENSE="your-license-token-here"
```
In Docker:
```bash
docker run -e MI_LICENSE="token" -v /data:/raw ghcr.io/milaboratory/mixcr/mixcr align ...
```

## Core CLI Workflow
The standard MiXCR pipeline follows a sequential processing of binary files:

1. **Alignment (`align`)**:
   Aligns raw reads to the reference library.
   - Pattern: `mixcr align -s <species> <input_R1.fastq> [input_R2.fastq] output.vdjca`
   - Species codes: `hs` (human), `mmu` (mouse), `rat`, `monkey`.
   - Example: `mixcr align -s hs data_R1.fastq.gz data_R2.fastq.gz alignments.vdjca`

2. **Assembly (`assemble`)**:
   Groups alignments into clonotypes.
   - Pattern: `mixcr assemble alignments.vdjca output.clna`
   - This step performs PCR and sequencing error correction.

3. **Exporting Results (`export`)**:
   Converts binary `.clna` or `.vdjca` files into human-readable TSV formats.
   - **Clonotypes**: `mixcr exportClonotypes output.clna clonotypes.txt`
   - **AIRR Format**: `mixcr exportAirr output.clna clonotypes.tsv`
   - **Alignments**: `mixcr exportAlignments alignments.vdjca alignments.txt`

## Common CLI Patterns and Presets
MiXCR uses "presets" to simplify complex pipelines for specific library preparation kits.

- **Single-Cell (10x Genomics)**:
  Use the specific 10x presets to handle cell barcodes and UMIs automatically.
  `mixcr align -p 10x-sc-5gex -s hs input_R1.fastq input_R2.fastq output.vdjca`

- **RNA-Seq / Shotgun Data**:
  For fragmented data where reads might not cover the whole CDR3, use the assembly contig feature.
  `mixcr assembleContigs alignments.vdjca output.clna`

- **UMI Processing**:
  If using custom UMI architectures, ensure you use `refineTagsAndSort` before assembly to group reads by molecular identifiers.

## Expert Tips
- **Species Support**: Beyond human and mouse, MiXCR supports `alpaca`, `spalax`, and `monkey`.
- **Partial Sequences**: If your data has floating read positions (RNA-Seq), MiXCR can reconstruct CDR3 regions by assembling overlapping fragmented reads.
- **Quality Control**: MiXCR generates comprehensive reports at every step. Always check the `.report` files to monitor alignment rates and successful clonotype assembly.
- **Memory Management**: For large datasets (especially single-cell), ensure the Java heap size is sufficient by setting the `_JAVA_OPTIONS` environment variable (e.g., `-Xmx16G`).
- **Backtracking**: You can use `exportAlignments` with specific flags to backtrack the fate of every raw sequencing read through the pipeline.

## Reference documentation
- [MiXCR Main README](./references/github_com_milaboratory_mixcr.md)
- [MiXCR Community Discussions](./references/github_com_milaboratory_mixcr_discussions.md)