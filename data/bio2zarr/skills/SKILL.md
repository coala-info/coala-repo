---
name: bio2zarr
description: bio2zarr converts bioinformatics file formats like VCF, PLINK, and tskit into the Zarr format for high-performance distributed computing and efficient data access. Use when user asks to convert genomic data to Zarr, perform large-scale VCF transformations, or optimize genomic datasets for parallel processing.
homepage: https://sgkit-dev.github.io/bio2zarr/
---

# bio2zarr

## Overview
bio2zarr is a specialized tool designed to solve the performance bottlenecks associated with traditional bioinformatics file formats like VCF. It converts these formats into Zarr, a chunked, compressed, N-dimensional array format. This transformation enables high-performance distributed computing and efficient random access to genomic data, particularly for large-scale cohorts. The tool supports one-shot conversions for simple use cases and a multi-step "distributed" workflow for massive datasets that require parallel processing across multiple nodes or high-memory environments.

## Core Workflows

### VCF to Zarr Conversion
For most standard datasets, use the one-shot conversion command.

- **One-shot conversion**:
  `bio2zarr vcf2zarr convert input.vcf.gz output.zarr`
- **Handling unindexed VCFs**:
  `bio2zarr vcf2zarr convert --force input.vcf output.zarr`

### Distributed Conversion (Large Datasets)
For massive VCFs, the process is split into three stages to allow for resource management and parallelization:

1.  **Explode**: Extract data from VCF into an intermediate chunked format (ICF).
    `bio2zarr vcf2zarr explode input.vcf.gz intermediate_dir`
2.  **Inspect/Edit Schema**: (Optional) Generate and modify the conversion schema.
    `bio2zarr vcf2zarr mkschema intermediate_dir schema.json`
3.  **Encode**: Convert the intermediate format to the final Zarr array.
    `bio2zarr vcf2zarr encode intermediate_dir output.zarr`

### Other Format Conversions
- **PLINK**: `bio2zarr plink2zarr convert input.bed output.zarr`
- **tskit**: `bio2zarr tskit2zarr convert input.trees output.zarr`

## Expert Tips and Best Practices

### Performance Tuning
- **Memory Management**: Use the `--max-memory` flag (e.g., `--max-memory 10G`) during the `encode` or `convert` steps to prevent OOM (Out of Memory) errors on large sample sizes.
- **Worker Processes**: By default, the tool uses multiple processes. If debugging, set the number of workers to zero to run in the main thread.
- **Chunking Strategy**: The default chunk size is 1,000 variants and 10,000 samples. For specific analysis patterns, you can adjust these via `mkschema` before the `encode` step.

### Handling Metadata
- **Consolidated Metadata**: As of version 0.1.8, bio2zarr no longer automatically generates consolidated metadata. If your downstream tools require it, you must generate it using the standard Zarr Python library after conversion.
- **Contig Merging**: If processing multiple VCFs, bio2zarr supports merging contig IDs to ensure consistency across the resulting Zarr dataset.

### Troubleshooting
- **ICF Compatibility**: If you upgrade bio2zarr, existing Intermediate Chunked Format (ICF) directories may need to be recreated due to schema version bumps (e.g., the transition to NumPy 2.0 support).
- **Progress Tracking**: Use `-Q` or `--no-progress` in CI/CD environments or logs to suppress the interactive progress bar.



## Subcommands

| Command | Description |
|---------|-------------|
| plink2zarr | Convert plink fileset(s) to VCF Zarr format |
| vcf2zarr | Convert VCF file(s) to VCF Zarr format. |

## Reference documentation
- [bio2zarr README](./references/github_com_sgkit-dev_bio2zarr_blob_main_README.md)
- [bio2zarr Changelog](./references/github_com_sgkit-dev_bio2zarr_blob_main_CHANGELOG.md)