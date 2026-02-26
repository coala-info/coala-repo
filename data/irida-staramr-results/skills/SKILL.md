---
name: irida-staramr-results
description: This tool automates the retrieval and consolidation of StarAMR analysis results from the IRIDA platform into structured spreadsheets. Use when user asks to download AMR data from IRIDA projects, extract StarAMR outputs via the command line, or filter and export antimicrobial resistance results by date.
homepage: https://github.com/phac-nml/irida-staramr-results
---


# irida-staramr-results

## Overview
The `irida-staramr-results` tool is a command-line utility designed to automate the retrieval of StarAMR analysis outputs from the IRIDA (Integrated Rapid Infectious Disease Analysis) platform. Instead of manually downloading individual results through a web interface, this tool allows bioinformaticians to programmatically extract AMR data across multiple projects and timeframes, consolidating them into structured spreadsheets.

## Installation
The tool requires Python 3.8 or later. It can be installed via Conda or Pip:

```bash
# Via Conda (recommended for bioinformatics environments)
conda install -c bioconda irida-staramr-results

# Via Pip
pip install irida-staramr-results
```

## Command Line Usage

### Required Arguments
To run a basic extraction, you must provide the project ID and a path to your IRIDA API configuration file:
- `-p, --project`: The ID of the IRIDA project to scan.
- `-c, --config`: Path to the YAML configuration file containing your IRIDA API client credentials (`base-url`, `client-id`, and `client-secret`).

### Authentication
While the config file handles API client details, user authentication is typically provided via the CLI:
- `-u, --username`: Your IRIDA account username.
- `-pw, --password`: Your IRIDA account password.

### Filtering and Output Control
- `-fd, --from_date`: Filter results created on or after `YYYY-mm-dd`.
- `-td, --to_date`: Filter results created on or before `YYYY-mm-dd`.
- `-o, --output`: Specify the name of the output Excel file (default is `out.xlsx`).
- `-sr, --split_results`: Export each analysis into its own separate `.xlsx` file instead of a single consolidated workbook.

## Common Patterns and Best Practices

### Batch Downloading Recent Results
To download results from a specific project for the first quarter of a year:
```bash
irida-staramr-results -u <user> -pw <pass> -c config.yml -p 123 -fd 2023-01-01 -td 2023-03-31 -o Q1_AMR_Results.xlsx
```

### Managing Large Datasets
When dealing with hundreds of samples, a single Excel file can become unwieldy. Use the `--split_results` flag to generate individual files for each analysis:
```bash
irida-staramr-results -p 123 -c config.yml --split_results
```

### Troubleshooting and Debugging
If the tool is not returning expected results or you are encountering connection issues:
1. **Check API URL**: Ensure the `base-url` in your config ends with `/api/` (e.g., `https://irida.example.ca/irida/api/`).
2. **Verify Permissions**: Ensure your IRIDA user has "Project Data Provider" or "Manager" access to the project ID specified.
3. **Logging**: For developers, changing the logging level to `DEBUG` in the source `cli.py` will disable the progress bar and show raw API request IDs.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_phac-nml_irida-staramr-results.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_irida-staramr-results_overview.md)