---
name: pbptyper
description: pbptyper is a specialized bioinformatics tool used to identify the PBP types of Streptococcus pneumoniae.
homepage: https://github.com/rpetit3/pbptyper
---

# pbptyper

## Overview
pbptyper is a specialized bioinformatics tool used to identify the PBP types of Streptococcus pneumoniae. Unlike older methods that require raw FASTQ reads and complex assembly pipelines, pbptyper operates directly on genome assemblies (FASTA format). It utilizes tblastn to compare the assembly against a database of known PBP 1A, 2B, and 2X proteins and employs FastANI to ensure the input assembly is indeed S. pneumoniae.

## Installation and Environment
The tool is primarily distributed via Bioconda. Before running analysis, ensure the environment is correctly configured.

```bash
# Install via conda/mamba
mamba create -n pbptyper -c conda-forge -c bioconda pbptyper
conda activate pbptyper

# Verify dependencies (tblastn and fastANI)
pbptyper --check
```

## Core Usage Patterns

### Basic Typing
To predict the PBP type for a single assembly:
```bash
pbptyper --assembly input_assembly.fasta --outdir output_directory --prefix sample_name
```
*Note: The tool accepts both uncompressed and gzip-compressed (.gz) FASTA files.*

### Adjusting Stringency
If working with low-quality assemblies or highly divergent strains, you may need to adjust the default thresholds (default is 95% for all):
```bash
pbptyper --assembly sample.fna \
  --min_pident 90 \
  --min_coverage 90 \
  --min_ani 90
```

## Interpreting Results
The primary output is `{PREFIX}.tsv`, which contains the predicted PBP type in the format `1A:2B:2X`.

### Allele Call Meanings
- **Integer (e.g., 23:0:2):** A perfect match was found for that specific allele ID.
- **MULTIPLE:** Multiple perfect matches were found for a single locus; a specific ID could not be determined.
- **NEW:** A hit was found exceeding the identity/coverage thresholds, but it does not perfectly match any known allele in the database.
- **NA:** No hits met the minimum identity and coverage thresholds.
- **NOTSPN:** The assembly failed the minimum ANI threshold (default 95%) against the S. pneumoniae reference (GCF_000006885), suggesting the input is not S. pneumoniae.

## Expert Tips
- **Database Management:** By default, pbptyper uses its internal database. If you need to use a custom or updated PBP database, use the `--db` flag to point to a directory containing the required 1A, 2B, and 2X FASTA files.
- **Batch Processing:** When processing multiple samples, use the `--prefix` flag to prevent output files from overwriting each other.
- **Merging Results:** To combine results from multiple runs into a single summary table, use `csvtk` or a simple tail/awk command:
  ```bash
  # Example using csvtk to merge all main result TSVs
  csvtk concat --tabs --out-tabs *.tsv | grep -v "tblastn" > combined_pbp_results.tsv
  ```

## Reference documentation
- [pbptyper GitHub Repository](./references/github_com_rpetit3_pbptyper.md)
- [Bioconda pbptyper Overview](./references/anaconda_org_channels_bioconda_packages_pbptyper_overview.md)