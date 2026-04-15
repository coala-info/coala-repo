---
name: selscan
description: selscan calculates haplotype-based statistics to detect signatures of recent or ongoing positive selection in genomic data. Use when user asks to calculate iHS, nSL, or iHH12 for single populations, perform cross-population scans like XP-EHH or XP-nSL, or analyze site-specific EHH decay.
homepage: https://github.com/szpiech/selscan
metadata:
  docker_image: "quay.io/biocontainers/selscan:1.2.0a--hb66fcc3_7"
---

# selscan

## Overview
selscan is a specialized tool for detecting signatures of recent or ongoing positive selection in genomes by analyzing haplotype structure. It calculates various Extended Haplotype Homozygosity (EHH) based statistics, which identify alleles that have risen to high frequency faster than expected under neutrality, leaving behind long blocks of linkage disequilibrium. This skill provides the command-line interface (CLI) patterns and parameter guidance required to execute these scans on phased datasets, whether comparing a single population to a neutral model or comparing two populations to identify local adaptation.

## Core Usage Patterns

### Single-Population Scans
These statistics identify selective sweeps within a single population.

*   **iHS (Integrated Haplotype Score):** Best for detecting incomplete sweeps (moderate frequency).
    `selscan --ihs --vcf <input.vcf> --map <input.map> --out <output_prefix>`
*   **nSL (Number of Segregating Sites by Length):** Similar to iHS but more robust to recombination rate variations; does not require a genetic map.
    `selscan --nsl --vcf <input.vcf> --out <output_prefix>`
*   **iHH12:** A measure designed to detect both hard and soft sweeps.
    `selscan --ihh12 --vcf <input.vcf> --map <input.map> --out <output_prefix>`

### Cross-Population Scans
These statistics compare two populations to identify alleles that have undergone selection in one but not the other.

*   **XP-EHH (Cross-population EHH):** Compares the EHH decay between a test and reference population.
    `selscan --xpehh --vcf <test.vcf> --vcf-ref <reference.vcf> --map <input.map> --out <output_prefix>`
*   **XP-nSL:** The cross-population version of nSL.
    `selscan --xpnsl --vcf <test.vcf> --vcf-ref <reference.vcf> --out <output_prefix>`

### Site-Specific EHH
To calculate the EHH decay for a specific locus:
`selscan --ehh <locusID> --vcf <input.vcf> --map <input.map> --out <output_prefix>`

## Input Requirements and Data Preparation
*   **No Missing Data:** selscan requires datasets with no missing genotypes. Ensure data is imputed before running.
*   **Phasing:** Data must be phased.
*   **Coding:** Alleles must be coded as 0 (typically ancestral) and 1 (typically derived). selscan reports unstandardized scores as log(iHH1/iHH0).
*   **Map Files:** For iHS, XP-EHH, and iHH12, a map file is required with four columns: `<chr#> <locusID> <genetic_pos> <physical_pos>`.
*   **Physical Maps:** If a genetic map is unavailable, use the `--pmap` flag to use physical distances, though genetic distances are preferred for EHH-based stats.

## Expert Tips and Parameters
*   **Parallelization:** selscan is multi-threaded. Use `--threads <int>` to speed up calculations on large chromosomes.
*   **MAF Filtering:** Use `--maf <double>` (default 0.05) to exclude low-frequency variants from being treated as core SNPs. Use `--keep-low-freq` if you explicitly want to include them in the haplotype background.
*   **Gap Handling:** If your genome has large assembly gaps, adjust `--max-gap <int>` (default 200,000 bp) to prevent EHH decay from being artificially truncated or extended across regions with no data.
*   **Window Limits:** For nSL, `--max-extend-nsl` (default 100) limits how many segregating sites the haplotype extends. For EHH, `--max-extend` (default 1,000,000 bp) limits physical distance.
*   **Batch Processing:** Use `--multi-param <json_file>` to run multiple configurations in a single execution.

## Reference documentation
- [github.com/szpiech/selscan](./references/github_com_szpiech_selscan.md)
- [anaconda.org/bioconda/selscan](./references/anaconda_org_channels_bioconda_packages_selscan_overview.md)