---
name: ngsrelate
description: ngsrelate infers kinship and inbreeding coefficients from next-generation sequencing data using genotype likelihoods. Use when user asks to estimate relatedness statistics, calculate Jacquard coefficients, or infer kinship from low-coverage VCF or GLF files.
homepage: https://github.com/ANGSD/NgsRelate
metadata:
  docker_image: "quay.io/biocontainers/ngsrelate:2.0--hea85c65_0"
---

# ngsrelate

## Overview
ngsrelate is a specialized bioinformatics tool for inferring kinship and inbreeding from NGS data. Unlike traditional methods that rely on called genotypes—which can be error-prone in low-depth sequencing—ngsrelate utilizes genotype likelihoods to provide more accurate estimates of relatedness statistics, including the nine Jacquard coefficients. It is particularly effective for population genetics studies where data quality varies across samples.

## Usage Instructions

### Core Workflows

#### 1. Analysis from VCF/BCF Files (Recommended for v2.0+)
The simplest way to run ngsrelate is directly on a VCF or BCF file. By default, it will estimate allele frequencies from the individuals in the file.
```bash
ngsrelate -h input.vcf.gz -O output_results.res
```

#### 2. Analysis from Genotype Likelihoods (ANGSD Workflow)
When working with low-coverage data processed through ANGSD, use the binary genotype likelihood file (`.glf.gz`).
1. **Generate input with ANGSD**:
   ```bash
   angsd -b filelist -gl 2 -domajorminor 1 -snp_pval 1e-6 -domaf 1 -doGlf 3
   ```
2. **Prepare frequency file**:
   ```bash
   zcat angsdput.mafs.gz | cut -f6 | sed 1d > freq_file
   ```
3. **Run ngsrelate**:
   ```bash
   ngsrelate -g angsdput.glf.gz -n [num_samples] -f freq_file -O output_results.res
   ```

### Common CLI Patterns

*   **Estimate Inbreeding Only**: Use the `-F 1` flag to focus on inbreeding coefficients rather than the full suite of Jacquard coefficients.
    ```bash
    ngsrelate -h input.vcf.gz -F 1 -O inbreeding.res
    ```
*   **Assume No Inbreeding**: Use `-o 1` to estimate only the 3 Jacquard coefficients (k0, k1, k2), which is faster if inbreeding is not expected.
*   **Parallel Processing**: Increase the number of threads (default is 4) for large datasets.
    ```bash
    ngsrelate -h input.vcf.gz -p 16 -O output.res
    ```
*   **Specific Regions**: For BCF files, restrict analysis to a specific genomic region.
    ```bash
    ngsrelate -h input.bcf -R chr1:1-1000000 -O region.res
    ```

### Expert Tips

*   **Allele Frequency Source**: While ngsrelate can estimate frequencies from the input VCF, using a large, independent reference population via the `-f` flag or the `-A [TAG]` (to pull from VCF INFO fields like AF) usually yields more accurate relatedness estimates for small cohorts.
*   **Genotype Calling**: If you must use called genotypes instead of likelihoods, use `-T GT -c 1`. However, this is generally discouraged for low-coverage data as it ignores the uncertainty in the calls.
*   **Memory and Sites**: If you do not have an allele frequency file but know the number of sites, you can use `-L [INT]` to estimate basic summary statistics based on the 2D-SFS.
*   **Bootstrap Support**: For single pairs of individuals, use `-B [INT]` to perform bootstrap replicates and assess the variance of your estimates.

## Reference documentation
- [NgsRelate GitHub Repository](./references/github_com_ANGSD_NgsRelate.md)
- [Bioconda ngsrelate Overview](./references/anaconda_org_channels_bioconda_packages_ngsrelate_overview.md)