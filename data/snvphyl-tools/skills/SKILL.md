---
name: snvphyl-tools
description: The snvphyl-tools package provides a collection of scripts for high-density SNV phylogenomics, including variant calling, filtering, and alignment generation. Use when user asks to prepare genomic data for phylogenetic analysis, convert VCF data into core SNV alignments, or generate distance matrices from microbial isolates.
homepage: https://github.com/phac-nml/snvphyl-tools
metadata:
  docker_image: "quay.io/biocontainers/snvphyl-tools:1.8.2--pl5321h7b50bb2_9"
---

# snvphyl-tools

## Overview

The `snvphyl-tools` package is a collection of Perl scripts and plugins designed for high-density SNV phylogenomics. It serves as the functional core of the SNVPhyl pipeline, handling tasks such as variant calling, filtering, and the conversion of VCF data into core SNV alignments. You should use this skill when you need to prepare genomic data for phylogenetic analysis, specifically when working with microbial isolates where high resolution is required to distinguish closely related strains.

## Environment Setup

Before running the tools, the environment must be correctly configured to locate the Perl libraries and the specific versions of dependencies (notably `bcftools` 1.9 and `samtools` 1.9).

1.  **Installation**: The preferred method is via Bioconda:
    ```bash
    conda install -c bioconda snvphyl-tools
    ```

2.  **Required Environment Variables**:
    If installing from source or using a custom directory, you must export the following:
    ```bash
    # Path to the compiled binaries and dependencies
    export PATH=/path/to/snvphyl-tools/bin:/path/to/bcftools-1.9:/path/to/MUMmer3.23:$PATH

    # Path to bcftools plugins (required for variant filtering)
    export BCFTOOLS_PLUGINS=/path/to/snvphyl-tools/bcftools-1.9/plugins

    # Perl library path
    export PERL5LIB=/path/to/snvphyl-tools/lib/perl5:$PERL5LIB
    ```

## Tool-Specific Best Practices

*   **Dependency Versioning**: Ensure `samtools` version 1.9 is available on your `PATH`. The tools are specifically tested against `bcftools` 1.9; using newer versions may cause issues with filter command syntax (specifically regarding `INFO/AO` and `INFO/DP` field paths).
*   **Isolate Naming**: When using `snv_matrix.pl`, avoid isolate names that look like numeric ranges (e.g., `10-0001`) if using older BioPerl versions, as these can trigger warnings that some workflow managers interpret as errors.
*   **Variant Filtering**: The pipeline relies on `bcftools` plugins located in the `bcfplugins/` directory of the repository. Ensure `BCFTOOLS_PLUGINS` points to the directory containing the `.so` files provided by `snvphyl-tools`.
*   **Verification**: After installation, verify the functional integrity of the tools by running the included test suite:
    ```bash
    prove t/extract_snvs_metaalign.t t/find-positions-used.t t/variant_calls.t t/vcf2core.t
    ```

## Common Functional Components

The suite includes several key scripts (typically found in the `bin/` directory) for the following operations:
*   **vcf2core.pl**: Consolidates VCF files into a core SNV genome.
*   **snv_matrix.pl**: Generates a distance matrix from SNV data.
*   **vcf2snvalignment.pl**: Converts variant calls into a multi-FASTA alignment suitable for tree-building software like RAxML or PhyML.

## Reference documentation
- [SNVPhyl Tools GitHub README](./references/github_com_phac-nml_snvphyl-tools.md)
- [Bioconda snvphyl-tools Overview](./references/anaconda_org_channels_bioconda_packages_snvphyl-tools_overview.md)