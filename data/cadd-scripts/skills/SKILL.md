---
name: cadd-scripts
description: cadd-scripts ranks the pathogenicity of human genome variants by integrating multiple functional annotations into a single C-score. Use when user asks to retrieve C-scores for specific variants via API, perform offline variant scoring for large datasets, or prioritize SNVs and InDels based on their predicted deleteriousness.
homepage: https://github.com/kircherlab/CADD-scripts
---

# cadd-scripts

## Overview

CADD (Combined Annotation Dependent Depletion) is a widely used framework for ranking the pathogenicity of single nucleotide variants (SNVs) and insertion/deletion (InDel) variants in the human genome. It integrates multiple functional annotations into a single metric, known as a C-score. This skill enables the efficient retrieval of these scores via the experimental web API or the execution of local scoring workflows using the `CADD-scripts` repository. It is particularly useful for variant prioritization in clinical genetics, GWAS fine-mapping, and evolutionary biology research.

## Web API Usage

The CADD API is intended for experimental use and small-scale lookups (not for millions of variants).

### Single Position Lookup
Retrieve all three possible SNVs at a specific coordinate:
`curl https://cadd.gs.washington.edu/api/v1.0/<version>/<chrom>:<pos>`

### Specific Variant Lookup
Retrieve a specific allele:
`curl https://cadd.gs.washington.edu/api/v1.0/<version>/<chrom>:<pos>_<ref>_<alt>`

### Range Access
Retrieve SNVs in a range (limited to 100 bases):
`curl https://cadd.gs.washington.edu/api/v1.0/<chrom>:<start>-<end>`

**Supported Versions:** `GRCh38-v1.7`, `GRCh37-v1.7`, `GRCh38-v1.6`, `GRCh37-v1.6`. Append `_inclAnno` to the version string to include underlying functional annotations.

## Offline Scoring with CADD-scripts

For large datasets, use the local installation. The core entry point is the `CADD.sh` script.

### Basic Scoring Command
```bash
./CADD.sh -g <genome_build> -v <version> <input.vcf>
```
- `-g`: Genome build (`GRCh37` or `GRCh38`).
- `-v`: CADD version (e.g., `v1.7`).
- `input.vcf`: A VCF file. Only the first 5 columns (CHROM, POS, ID, REF, ALT) are required.

### Including Annotations
To output the 60+ underlying genomic features used to calculate the score:
```bash
./CADD.sh -a -g <build> -v <version> <input.vcf>
```

### Performance Optimization
Scoring InDels and multi-nucleotide substitutions is computationally expensive. When possible, use pre-scored whole-genome SNV files and tabix to retrieve scores for known variants rather than re-calculating them.

## Expert Tips and Interpretation

### Scaled vs. Raw Scores
- **Scaled C-scores (PHRED-like)**: Use these for filtering and manual review. They represent the rank of a variant relative to all 8.6 billion possible SNVs.
  - **10**: Top 10% most deleterious.
  - **20**: Top 1% most deleterious.
  - **30**: Top 0.1% most deleterious.
  - *Recommended Cutoff*: A value between 10 and 20 is a common starting point for identifying potentially pathogenic variants.
- **Raw C-scores**: Use these for computational analyses and statistical tests (e.g., comparing distributions between cases and controls), as they preserve higher resolution across the scoring spectrum.

### Tabix Retrieval
If you have downloaded the pre-scored files, use `tabix` for the fastest retrieval of SNV scores:
```bash
tabix <score_file.tsv.gz> <chrom>:<start>-<end>
```

### Installation Requirements
- **Storage**: Requires 100 GB to 1 TB depending on the number of genome builds and annotation tracks installed.
- **Memory**: At least 12 GB of RAM is required for scoring.
- **Dependencies**: Managed via Conda and Snakemake. Use the `install.sh` script provided in the repository for guided setup.



## Subcommands

| Command | Description |
|---------|-------------|
| cadd-scripts_cadd-install.sh | CADD version 1.7 |
| cadd-scripts_cadd.sh | CADD version 1.7 |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [CADD API Documentation](./references/cadd_gs_washington_edu_api.md)
- [CADD-scripts README](./references/github_com_kircherlab_CADD-scripts_blob_master_README.md)
- [CADD General Information and Scoring Guidance](./references/cadd_gs_washington_edu_info.md)
- [CADD Download and Offline Installation](./references/cadd_gs_washington_edu_download.md)