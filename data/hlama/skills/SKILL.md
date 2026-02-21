---
name: hlama
description: HLA-MA (hlama) is a quality control tool that uses the Human Leukocyte Antigen (HLA) gene complex as a genetic fingerprint to verify sample relationships.
homepage: https://github.com/bihealth/hlama
---

# hlama

## Overview

HLA-MA (hlama) is a quality control tool that uses the Human Leukocyte Antigen (HLA) gene complex as a genetic fingerprint to verify sample relationships. Since HLA loci (HLA-A, HLA-B, and HLA-C) are highly polymorphic, they provide a unique signature for individuals. The tool automates the process of predicting HLA types from sequencing data and comparing them against expected relationships—ensuring that tumor/normal pairs match and that offspring in a pedigree follow Mendelian inheritance rules.

## Core Workflows

### 1. Tumor/Normal Matching
Use this workflow to verify that a tumor sample and its corresponding germline (normal) sample belong to the same patient.

**Input File (TSV):**
Create a tab-separated file (e.g., `matched.tsv`) with the following columns:
`donor`, `sample_name`, `reference_sample`, `seq_type` (DNA/RNA), `fastq_files` (comma-separated).

```bash
# Example command
hlama --tumor-normal matched.tsv --read-base-dir /path/to/fastqs/
```

### 2. Pedigree Validation
Use this workflow to verify family relationships in germline data.

**Input File (PED):**
Use a standard PED file with an additional 7th column for the FASTQ file names.
Columns: `Family_ID`, `Sample_ID`, `Father_ID`, `Mother_ID`, `Sex`, `Phenotype`, `Fastq_Files`.

```bash
# Example command
hlama --pedigree family.ped --read-base-dir /path/to/fastqs/
```

## Configuration and Dependencies

hlama relies on `OptiType`, `Yara`, and `RazerS3`. It is recommended to manage these via Conda. If dependencies are not in your system PATH, configure them in `~/.hlama.cfg`:

```ini
[hlama]
dep_source = bioconda

[hlama.bioconda]
prepend_path = ~/miniconda2/bin
env = hlama-env
```

## Expert Tips and Best Practices

*   **Data Type Preference**: While hlama supports single-end data, use **paired-end data** whenever possible. OptiType (the underlying predictor) achieves significantly higher precision with paired-end reads.
*   **Resolution Matching**: hlama evaluates both "two-digit" (e.g., HLA-A*02) and "four-digit" (e.g., HLA-A*02:01) types. A single mismatch at the four-digit level may still be considered a match if the two-digit types align, accounting for minor prediction errors.
*   **RNA-Seq Support**: The tool can match RNA-seq samples against DNA-seq references. Ensure the `seq_type` column in your TSV is correctly set to `RNA` to allow hlama to adjust the OptiType mapping parameters accordingly.
*   **File Naming**: hlama automatically recognizes paired-end files if they contain `_1.fq.gz`/`_2.fq.gz` or `_R1_`/`_R2_` patterns.
*   **Somatic Mutations**: In tumor/normal matching, be aware that extreme somatic mutations or loss of heterozygosity (LOH) in the HLA loci can occasionally cause minor discrepancies, though the fingerprint usually remains stable enough for identity verification.

## Reference documentation
- [hlama GitHub Repository](./references/github_com_bihealth_hlama.md)
- [hlama Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hlama_overview.md)