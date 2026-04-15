---
name: pasty
description: pasty is a command-line utility for the rapid serogrouping of Pseudomonas aeruginosa isolates from genomic assembly data. Use when user asks to predict Pseudomonas aeruginosa serogroups, perform O-antigen typing, or automate serotyping for large batches of genomic assemblies.
homepage: https://github.com/rpetit3/pasty
metadata:
  docker_image: "quay.io/biocontainers/pasty:2.2.1--hdfd78af_0"
---

# pasty

## Overview
pasty is a command-line utility designed for the rapid serogrouping of Pseudomonas aeruginosa isolates from genomic data. It automates the process of BLASTing assembly sequences against a curated database of O-antigen sequences and applies specific logic to predict the serogroup based on alignment coverage and identity. It is a more efficient alternative to web-based serotypers when handling hundreds of genomes.

## Installation
The recommended way to install pasty is via Bioconda:
```bash
mamba create -n pasty -c conda-forge -c bioconda pasty
conda activate pasty
```

## Basic Usage
The primary command for pasty is `pasty`. At a minimum, you must provide an input assembly file.

```bash
pasty --input assembly.fasta --outdir results/ --prefix sample_01
```

### Input Requirements
- **Format**: FASTA format.
- **Compression**: Supports both uncompressed and gzip-compressed (`.gz`) files.
- **Content**: Typically works best with genome assemblies (contigs/scaffolds).

## Command Line Options
- `--input`, `-i`: Path to the input FASTA file (Required).
- `--outdir`, `-o`: Directory to write output files (Default: `./`).
- `--prefix`, `-p`: Prefix for output filenames (Default: basename of input).
- `--min-pident`: Minimum percent identity for a BLAST hit to be considered (Default: 90).
- `--min-coverage`: Minimum percent coverage of an O-antigen to be considered (Default: 90).
- `--force`: Overwrite existing reports in the output directory.

## Interpreting Results
pasty generates three primary output files:

1. **{PREFIX}.tsv**: The main summary file.
   - **type**: The predicted serogroup (e.g., O1, O6, O11).
   - **coverage**: The percentage of the O-antigen aligned.
   - **hits**: Number of BLAST hits included in the prediction (fewer is generally better/more certain).
2. **{PREFIX}.details.tsv**: Provides coverage and hit counts for every serogroup in the schema, useful for resolving ambiguous results.
3. **{PREFIX}.blastn.tsv**: The raw BLAST results in standard `-outfmt 6` format.

## Expert Tips and Best Practices
- **Threshold Adjustments**: While the defaults are 90%, the tool author notes that 95% identity is often expected for high-confidence matches. If you encounter "Unknown" results or low-confidence calls, check the `{PREFIX}.details.tsv` file to see if a serogroup was close to the threshold.
- **Batch Processing**: Since pasty is a CLI tool, it is significantly faster than the CGE web service for large datasets. Use a simple loop or `xargs` to process multiple assemblies in parallel.
- **Schema Defaults**: The `--yaml` and `--targets` flags are automatically set to the internal Pseudomonas O-antigen database. Do not modify these unless you are an advanced user attempting to use a custom schema.
- **Assembly Quality**: Serogrouping relies on the presence of the O-antigen biosynthesis cluster. If an assembly is highly fragmented, the cluster may be split across contigs, which might increase the `hits` count in the output.

## Reference documentation
- [github_com_rpetit3_pasty.md](./references/github_com_rpetit3_pasty.md)
- [anaconda_org_channels_bioconda_packages_pasty_overview.md](./references/anaconda_org_channels_bioconda_packages_pasty_overview.md)