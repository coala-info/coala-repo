---
name: neptune-signature
description: Neptune is a specialized tool for genomic signature discovery.
homepage: https://github.com/phac-nml/neptune
---

# neptune-signature

## Overview
Neptune is a specialized tool for genomic signature discovery. It identifies genomic loci that are sufficiently represented in an inclusion group while being sufficiently absent from an exclusion (background) group. Unlike heuristic strategies, Neptune utilizes probabilistic models and an exact k-mer matching strategy that accommodates mismatches to locate sequences that uniquely delineate specific groups, such as isolates from a disease cluster versus environmental microbes.

## Core CLI Usage

The primary command for Neptune requires specifying inclusion and exclusion directories and an output path.

### Basic Command Pattern
```bash
neptune --inclusion /path/to/inclusion/ --exclusion /path/to/exclusion/ --output /path/to/output/
```

### Short-form Syntax
```bash
neptune -i <inclusion_dir> -e <exclusion_dir> -o <output_dir>
```

### Verification and Help
- **Check Version**: `neptune --version` (Ensure version 2.0.0+ for Python 3 support).
- **View All Options**: `neptune --help`

## Best Practices and Expert Tips

### Environment and Dependencies
- **BLAST+ Requirement**: Neptune relies on NCBI BLAST+. Ensure `makeblastdb` and `blastn` are available in your system PATH before execution.
- **Conda Installation**: The most reliable way to manage dependencies is via Bioconda:
  `conda create -n neptune neptune-signature`
- **Python Version**: Neptune 2.0.0+ requires Python 3.10 or higher.

### Input Organization
- **Directory-based Inputs**: Neptune expects directories for the `--inclusion` and `--exclusion` arguments. Ensure your FASTA files are organized into these respective folders rather than passing individual files.
- **Group Selection**: For the most effective signature discovery, ensure the exclusion group is representative of the background population you wish to filter out.

### Troubleshooting
- **No Signatures Produced**: If Neptune finishes without producing signatures, it may be due to the k-mer matching parameters being too stringent for the provided dataset.
- **Package Conflict**: When installing via pip, always use `pip install .` from the source directory or provide the local path. Avoid `pip install neptune` without a path, as it may install an unrelated package of the same name.

## Reference documentation
- [Neptune Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_neptune-signature_overview.md)
- [Neptune GitHub Repository and Documentation](./references/github_com_phac-nml_neptune.md)