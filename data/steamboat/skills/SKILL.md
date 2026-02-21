---
name: steamboat
description: Steamboat is a specialized collection of Python-based tools and scripts tailored for microbial bioinformatics.
homepage: https://github.com/rpetit3/steamboat-py
---

# steamboat

## Overview
Steamboat is a specialized collection of Python-based tools and scripts tailored for microbial bioinformatics. It simplifies the often-complex task of preparing and submitting genomic data to public health databases. Use this skill when you need to automate batch submissions or handle surveillance data formats required by international repositories or national health agencies.

## Installation
Steamboat is primarily distributed via Bioconda. To set up the environment:
```bash
conda install -c bioconda steamboat
```

## Common CLI Patterns
Steamboat operates through a primary command-line interface with several specialized subcommands for batch operations.

### Batch Submissions
The tool is frequently used for preparing batch uploads to surveillance databases:
- **GISAID Submissions**: Use the `gisaid-batch` command to process and package viral genomic data for the GISAID repository.
- **NWSS Submissions**: Use the `nwss-batch` command for tasks related to the National Wastewater Surveillance System, specifically for wastewater-based epidemiology data.
- **News Reporting**: Use `news-batch` for generating or adjusting reporting outputs.

### Command Discovery
Since the tool is a collection of scripts that may have specific input requirements (like metadata CSVs or FASTA files), always use the `--help` flag to see the required arguments for each utility:
```bash
steamboat gisaid-batch --help
steamboat nwss-batch --help
```

## Expert Tips
- **Environment Isolation**: Always run steamboat within a dedicated Conda or Mamba environment to avoid dependency conflicts with other bioinformatics suites.
- **Submission Readiness**: When using `nwss-batch`, check the output for temporary files or logs that indicate whether the submission manifest was generated successfully.
- **Version Consistency**: Ensure you are using the latest version (e.g., v1.1.1) to benefit from the most recent adjustments to submission formats required by public health databases.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_steamboat_overview.md)
- [GitHub Repository](./references/github_com_rpetit3_steamboat-py.md)
- [Commit History](./references/github_com_rpetit3_steamboat-py_commits_main.md)