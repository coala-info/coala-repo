---
name: minimac4
description: Minimac4 is a specialized tool for efficient genotype imputation that estimates missing genotypes by comparing target panels against high-density reference panels. Use when user asks to perform genotype imputation, convert reference panels to MVCF format, or update M3VCF files for genomic analysis.
homepage: https://github.com/statgen/Minimac4
metadata:
  docker_image: "quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1"
---

# minimac4

## Overview

Minimac4 is a specialized tool for genotype imputation, designed to be more computationally efficient and memory-light than previous versions (Minimac3). It estimates missing genotypes in a target panel by comparing it against a high-density reference panel. This skill provides the necessary command-line patterns for preparing reference panels and executing imputation workflows across various genomic file formats.

## Usage Guidelines

### 1. Reference Panel Preparation
Minimac4 uses a specific compressed format called MVCF (usually with a `.msav` extension). You must convert your reference data before imputation.

**From a phased VCF, BCF, or SAV:**
```bash
minimac4 --compress-reference reference.vcf.gz > reference.msav
```

**From an existing Minimac3 M3VCF file:**
```bash
minimac4 --update-m3vcf reference.m3vcf.gz > reference.msav
```

### 2. Standard Imputation
The basic command requires a reference panel (MVCF) and a phased target panel (VCF/BCF/SAV).

**Basic execution (output to stdout):**
```bash
minimac4 reference.msav target.vcf.gz > imputed.sav
```

**Specifying output formats:**
Minimac4 automatically detects the desired format based on the file extension provided to the `-o` flag.
```bash
# Output as BCF
minimac4 reference.msav target.vcf.gz -o imputed.bcf

# Output as compressed VCF
minimac4 reference.msav target.vcf.gz -o imputed.vcf.gz
```

### 3. Advanced Output Options
*   **Sites-only file:** Generate a separate VCF containing only the site information (useful for downstream filtering or meta-analysis).
    ```bash
    minimac4 reference.msav target.bcf -o imputed.sav -s imputed.sites.vcf.gz
    ```
*   **Empirical Dosage:** Required for meta-imputation with MetaMinimac2.
    ```bash
    minimac4 reference.msav target.bcf -o imputed.dose.sav --empirical-output imputed.empirical_dose.sav
    ```

## Best Practices and Tips
*   **Phasing Requirement:** Ensure the target VCF/BCF is phased before running Minimac4. The tool expects phased genotype array data.
*   **Memory Efficiency:** Minimac4 is optimized for large-scale datasets. Using the SAV format for both input and output generally provides the best performance in terms of speed and storage.
*   **Format Support:** The tool natively supports VCF, BCF (via htslib logic), and SAV (via savvy). Ensure your environment has `bcftools` installed if you plan to run the internal test suites or perform pre-processing.
*   **Reference Panels:** When downloading public reference panels (like 1000 Genomes), check if an `.msav` or `.m3vcf` version is already provided to save conversion time.



## Subcommands

| Command | Description |
|---------|-------------|
| minimac4 | Performs imputation using the minimac4 algorithm. |
| minimac4 | Performs imputation using reference panels. |

## Reference documentation
- [Minimac4 GitHub Repository](./references/github_com_statgen_Minimac4_blob_master_README.md)