---
name: bio2zarr
description: bio2zarr is a specialized utility designed to bridge the gap between legacy bioinformatics file formats and modern, distributed computing frameworks.
homepage: https://sgkit-dev.github.io/bio2zarr/
---

# bio2zarr

## Overview
bio2zarr is a specialized utility designed to bridge the gap between legacy bioinformatics file formats and modern, distributed computing frameworks. It converts large-scale genomic data—primarily VCF (Variant Call Format) and PLINK files—into Zarr stores. This transformation enables efficient, parallelized access to genotype data, which is essential for high-performance genomic analysis in Python-based ecosystems.

## Core CLI Patterns

### VCF to Zarr Conversion
The conversion of VCF files is typically a two-step process: indexing (exploring the file) and encoding (writing the Zarr data).

```bash
# Step 1: Inspect the VCF and create an intermediate metadata file
bio2zarr vcf2zarr explode input.vcf.gz intermediate_directory

# Step 2: Encode the exploded data into the final Zarr store
bio2zarr vcf2zarr encode intermediate_directory output.zarr
```

### PLINK to Zarr Conversion
For PLINK datasets (BED/BIM/FAM), use the `plink2zarr` command:

```bash
# Convert PLINK triplet to Zarr
bio2zarr plink2zarr input_prefix output.zarr
```

## Performance Optimization

### Chunking and Compression
Zarr's performance depends heavily on chunk sizes. bio2zarr allows you to specify how the data is partitioned.
- **Variants vs. Samples**: For most GWAS or population genetics tasks, chunking by variants (e.g., 10,000 variants per chunk) is standard.
- **Memory Management**: Use the `--max-memory` flag during encoding to prevent OOM (Out of Memory) errors on large datasets.

### Parallel Execution
bio2zarr is designed for multi-core systems.
- Use the `-p` or `--workers` flag to specify the number of concurrent processes.
- Ensure the temporary directory used during the `explode` step has sufficient IOPS and disk space, as it stores uncompressed intermediate representations.

## Expert Tips
- **Validation**: Always run `bio2zarr vcf2zarr inspect` on your VCF before conversion to identify potential schema inconsistencies or malformed headers.
- **Remote Storage**: While bio2zarr writes to local disk, the resulting Zarr store is highly optimized for migration to S3 or Google Cloud Storage for use in distributed clusters.
- **Filtering**: Perform quality control (QC) and filtering on your VCF/PLINK files *before* converting to Zarr to minimize the footprint of the final store.

## Reference documentation
- [bio2zarr Documentation](./references/sgkit-dev_github_io_bio2zarr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bio2zarr_overview.md)