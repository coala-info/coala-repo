---
name: updio
description: UPDio is a bioinformatics tool that identifies Uniparental Disomy (UPD) in a proband by analyzing their genotypes against their parents. Use when user asks to identify Uniparental Disomy, find UPD events, or analyze VCF data for UPD.
homepage: https://github.com/rhpvorderman/updio
---


# updio

## Overview

UPDio is a specialized bioinformatics tool designed to identify Uniparental Disomy in a proband by comparing their genotypes against those of their biological parents. It processes VCF data to find informative Mendelian inheritance patterns and inconsistencies that signify UPD. The tool produces tabulated event lists and visual plots (PNGs) to facilitate the interpretation of genomic data in a clinical or research context.

## Pre-processing Requirements

Before running UPDio, input VCF files must meet two strict formatting requirements:

1.  **Numeric Sorting**: VCFs must be sorted in numeric chromosome order (1, 2, 3... 22, X). Use the provided `sort-vcf` script if the files are sorted lexicographically.
2.  **Homozygous Reference Calls**: The tool requires "0/0" genotypes to be present in the VCF. If your VCF only contains variant calls, use the `add_hom_refs_to_sorted_vcfs.pl` script found in the `pre_processing` directory to populate these positions.

## Command Line Usage

The primary execution script is `UPDio.pl`. Detailed documentation can be accessed via `perldoc UPDio.pl`.

### Basic Execution
UPDio accepts either three single-sample VCFs or one multisample VCF containing the trio.

```bash
# Using single-sample VCFs
perl UPDio.pl -p proband.vcf -m mother.vcf -f father.vcf -o output_directory

# Using a multisample VCF
perl UPDio.pl -v trio_multisample.vcf -o output_directory
```

### Recommended Options
*   **CNV Integration**: To significantly reduce false positives, include a CNV call file for the proband. CNVs often mimic the signal of UPD events.
    ```bash
    perl UPDio.pl -p proband.vcf -m mother.vcf -f father.vcf -c proband_cnvs.txt -o output_dir
    ```
*   **Output Directory**: Use the `-o` flag to specify a custom directory; otherwise, results default to `output_dir`.

## Interpreting Results

The tool generates several files in the output directory:

*   **.upd**: The primary output containing a list of significant UPD events. These lines can be very long; use `less -S` to view them properly.
*   **.events_list**: A detailed printout of all informative genotypes found in the proband.
*   **.table**: A chromosomal tabulation of informative genotypes.
*   **.pngs**: Graphical representations of the UPD events across the genome.
*   **.log**: Execution details and potential errors.

## Expert Tips

*   **False Positive Mitigation**: Always prioritize the use of a CNV file. Smaller UPD events are particularly prone to being misidentified if CNV data is missing.
*   **Dependency Check**: Ensure `Statistics::R` (version 0.31 or higher) is installed in your Perl environment, as older versions lack the required `set` method.
*   **Environment**: If running in a containerized environment, use the pre-built Docker image or the provided `environment.yml` for Conda to ensure all R and Perl dependencies (like `quantsmooth` and `ggplot2`) are correctly configured.

## Reference documentation
- [GitHub - rhpvorderman/UPDio](./references/github_com_rhpvorderman_UPDio.md)