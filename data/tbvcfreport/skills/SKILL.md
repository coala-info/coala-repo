---
name: tbvcfreport
description: The `tbvcfreport` tool is designed to bridge the gap between raw genomic variant data and actionable biological insights for *Mycobacterium tuberculosis*.
homepage: http://github.com/COMBAT-TB/tbvcfreport
---

# tbvcfreport

## Overview

The `tbvcfreport` tool is designed to bridge the gap between raw genomic variant data and actionable biological insights for *Mycobacterium tuberculosis*. It parses VCF files that have been annotated with SnpEff and produces a standalone, interactive HTML report. These reports facilitate the exploration of variants, their genomic context, and their potential impact on drug resistance, often linking directly to the COMBAT-TB-eXplorer for deeper analysis.

## Installation

The tool is primarily distributed via Bioconda and Pip:

```bash
# Using Conda
conda install bioconda::tbvcfreport

# Using Pip
pip install tbvcfreport
```

## Command Line Usage

The primary interface is the `generate` command, which processes a directory containing VCF files.

### Basic Report Generation
To generate reports for all VCF files in a specific folder:

```bash
tbvcfreport generate /path/to/vcf_directory/
```
This will create a `{vcf-file-name}.html` file in your current working directory for every VCF found in the input directory.

### Integrating TBProfiler Data
To include drug resistance predictions and lineage information from TBProfiler in your HTML report, provide the JSON output from TBProfiler:

```bash
tbvcfreport generate /path/to/vcf_directory/ --tbprofiler-report sample_results.json
```

### Managing Variant Filters
By default, the tool filters out upstream, downstream, and intergenic (UDI) variants to focus on coding regions. You can toggle this behavior:

*   **Disable UDI filtering** (show all variants):
    ```bash
    tbvcfreport generate /path/to/vcf_directory/ --no-filter-udi
    ```
*   **Enable UDI filtering** (default):
    ```bash
    tbvcfreport generate /path/to/vcf_directory/ --filter-udi
    ```

## Expert Tips and Best Practices

### Database Connectivity
`tbvcfreport` relies on a Neo4j backend (COMBAT-TB-NeoDB) for certain annotations. By default, it connects to `neodb.sanbi.ac.za`. If you are working in a restricted environment or using a local mirror, you must export the `DATABASE_URI` environment variable:

```bash
export DATABASE_URI=localhost
tbvcfreport generate ./vcfs/
```

### Input Requirements
*   **SnpEff Annotation**: The tool specifically requires VCFs to be pre-annotated with SnpEff. Standard VCFs without these annotations will not produce meaningful reports.
*   **M.tb Specificity**: The tool is hardcoded for *M. tuberculosis* logic and drug lists (including aminoglycosides). Using it for other organisms is not supported.

### Output Management
Since the tool outputs HTML files to the current working directory (`pwd`), it is best practice to run the command from the directory where you want the final reports to reside, rather than the directory containing the source VCFs.

## Reference documentation
- [tbvcfreport GitHub Repository](./references/github_com_COMBAT-TB_tbvcfreport.md)
- [Bioconda tbvcfreport Overview](./references/anaconda_org_channels_bioconda_packages_tbvcfreport_overview.md)