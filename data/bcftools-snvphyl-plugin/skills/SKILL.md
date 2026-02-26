---
name: bcftools-snvphyl-plugin
description: This tool identifies and processes single nucleotide variants across microbial genomes as a high-performance plugin for bcftools. Use when user asks to configure environment variables for SNVPhyl, install the bcftools-snvphyl-plugin, or format VCF fields for downstream phylogenomic analysis.
homepage: https://github.com/phac-nml/snvphyl-tools
---


# bcftools-snvphyl-plugin

## Overview
The `bcftools-snvphyl-plugin` is a high-performance C plugin for `bcftools` specifically engineered for the SNVPhyl (Single Nucleotide Variant PHYLogenomics) pipeline. It is used to identify and process SNVs across collections of microbial genomes. Because it operates as a plugin, it requires specific environment variables to be set so that `bcftools` can locate the shared library. This skill focuses on the correct setup and the specific VCF field formatting required by version 1.9 of the tool to ensure compatibility with downstream SNVPhyl analysis.

## Environment Configuration
To use the plugin, `bcftools` must be informed of the plugin's location.

1.  **Set the Plugin Path**: Define the `BCFTOOLS_PLUGINS` environment variable to point to the directory containing the compiled C plugin.
    ```bash
    export BCFTOOLS_PLUGINS=/path/to/snvphyl-tools/bcftools-1.9/plugins
    ```
2.  **Perl Library Path**: If using the associated `snvphyl-tools` scripts alongside the plugin, update your `PERL5LIB`.
    ```bash
    export PERL5LIB=/path/to/snvphyl-tools/lib/perl5
    ```

## Version-Specific Requirements (bcftools 1.9)
The plugin and associated pipeline tools are strictly validated for `bcftools` version 1.9. Using other versions may lead to header parsing errors or filtering failures.

### VCF Field Addressing
When performing filtering or variant calling that interacts with the SNVPhyl plugin logic, you must use the full path for INFO fields. In version 1.9, shorthand notations (like `AO` or `DP`) may fail or be ambiguous.
- **Correct**: `INFO/AO` and `INFO/DP`
- **Incorrect**: `AO` and `DP`

Example of a compliant filter pattern:
```bash
bcftools filter -i 'INFO/DP > 10 && INFO/AO > 5' input.vcf
```

## Installation Patterns
The recommended method for deploying the plugin is via Bioconda to ensure all C dependencies and linked libraries (like `htslib`) are correctly versioned.

```bash
conda install -c bioconda bcftools-snvphyl-plugin
```

## Best Practices
- **Dependency Alignment**: Ensure `samtools` version 1.9 is available on your `PATH`, as the SNVPhyl suite relies on the specific output formatting of the 1.9 series.
- **Verification**: After installation and setting environment variables, verify the plugin is visible to `bcftools`:
    ```bash
    bcftools plugin --list
    ```
- **Data Integrity**: The plugin expects VCF files to contain Allelic Observation (`AO`) and Depth (`DP`) fields. Ensure your upstream variant caller (e.g., mpileup) is configured to output these tags.

## Reference documentation
- [bcftools-snvphyl-plugin Overview](./references/anaconda_org_channels_bioconda_packages_bcftools-snvphyl-plugin_overview.md)
- [SNVPhyl Tools GitHub Repository](./references/github_com_phac-nml_snvphyl-tools.md)
- [SNVPhyl Tools Commits (Version 1.9 Updates)](./references/github_com_phac-nml_snvphyl-tools_commits_master.md)