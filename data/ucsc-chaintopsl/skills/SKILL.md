---
name: ucsc-chaintopsl
description: ucsc-chaintopsl converts genomic alignment chain files into PSL format. Use when user asks to convert chain files to PSL, perform basic chain to PSL conversion, prepare chain files for genome assembly comparisons, convert chain files for cross-species alignments, or create browser-compatible alignment tracks.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-chaintopsl

# ucsc-chaintopsl

## Overview
The `ucsc-chaintopsl` utility (part of the UCSC Kent Toolkit) is a specialized tool designed to transform chain alignment files into PSL format. Chain files represent genomic alignments as a series of linked blocks, while PSL files provide a detailed, tab-separated layout of how a query sequence aligns to a target sequence. This conversion is a critical step in bioinformatics workflows involving genome assembly comparisons, cross-species alignments, and the creation of browser-compatible alignment tracks.

## Execution Patterns

### Basic Conversion
The standard usage requires the input chain file and the chromosome sizes for both the target and query genomes to correctly calculate coordinates.

```bash
chainToPsl input.chain target.sizes query.sizes output.psl
```

### Parameters
- **input.chain**: The alignment file to be converted.
- **target.sizes**: A tab-separated file containing `<chromName> <size>` for the target genome.
- **query.sizes**: A tab-separated file containing `<chromName> <size>` for the query genome.
- **output.psl**: The resulting PSL format alignment file.

## Expert Tips and Best Practices

### Generating .sizes Files
If you do not have the `.sizes` files, you can generate them from 2bit files or FASTA files using other UCSC utilities:
- From 2bit: `twoBitInfo genome.2bit genome.sizes`
- From FASTA: `faSize -detailed genome.fa > genome.sizes`

### Handling "Basic" Conversion
The package often includes `chainToPslBasic`. Use this version if you have a simplified chain file or if the standard `chainToPsl` fails due to complex gap structures that do not require full PSL metadata.

### Validation
After conversion, it is recommended to validate the PSL file if it is intended for use as a custom track:
```bash
pslCheck output.psl
```

### Permission Errors
If running the binary directly from a downloaded source (outside of Conda), ensure the execution bit is set:
```bash
chmod +x chainToPsl
```

## Reference documentation
- [Bioconda ucsc-chaintopsl Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-chaintopsl_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)