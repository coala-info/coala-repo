---
name: irida-sistr-results
description: This tool automates the retrieval and export of Salmonella serovar predictions and metadata from the IRIDA SISTR pipeline into Excel or TSV reports. Use when user asks to export SISTR results from IRIDA projects, filter samples by date or workflow version, or generate summary reports of Salmonella serovar status.
homepage: http://github.com/phac-nml/irida-sistr-results
---


# irida-sistr-results

## Overview
The `irida-sistr-results` tool is a command-line utility designed to bridge the gap between IRIDA's internal database and external reporting requirements. It automates the retrieval of SISTR pipeline outputs, handling complex tasks like sample selection, version filtering, and QC status reporting. It is particularly useful for bioinformaticians and public health analysts who need to generate summary reports of Salmonella serovar predictions and metadata without manually navigating the IRIDA web interface for every sample.

## Core CLI Patterns

### Basic Export
To export results from specific projects to an Excel file:
```bash
irida-sistr-results -p <project_id_1> -p <project_id_2> -u <username> -o results.xlsx
```

### Global Export
To scan and export results from all projects accessible to the user:
```bash
irida-sistr-results -a -u <username> -o all_results.xlsx
```

### Temporal Filtering
Restrict results to samples created within a specific window:
- **Relative**: `-d 7` (samples from the last 7 days)
- **Absolute**: `-d 2023-01-01` (samples created since January 1, 2023)

### Workflow Version Control
To ensure data consistency, filter results by specific SISTR workflow versions or UUIDs:
```bash
irida-sistr-results -p <id> -w 0.3 -w 0.2 -o version_filtered.xlsx
```

## Expert Tips and Best Practices

### Connection Management
Avoid passing sensitive credentials directly in the command line. Use a configuration file located at `~/.local/share/irida-sistr-results/config.ini`.
- Run the tool once without arguments to generate a template.
- Fill in `irida_url`, `client_id`, and `client_secret`.
- Use the `--config` flag if you need to point to a non-standard location.

### Handling Multiple Results
By default, the tool loads the most recent SISTR result with a `PASS` status for a sample. 
- To change this behavior and include older results, use `--exclude-user-existing-results`.
- If a sample shows a `MISSING` status, it means no SISTR result was found; you must re-run the SISTR pipeline within IRIDA and ensure results are shared with the project before re-exporting.

### Reportable Serovars
The tool includes a "Reportable Serovar Status" column based on a default list.
- **Override**: Use `--reportable-serovars-file <file.tsv>` to provide a custom list of serovars of interest.
- **Disable**: Use `--exclude-reportable-status` to remove this column from the output if it is not required for your analysis.

### Output Formats
While `.xlsx` is the default for the `-o` flag, you can generate tabular text files using:
```bash
irida-sistr-results -p <id> --output-tab results.tsv
```

## Reference documentation
- [IRIDA SISTR Results README](./references/github_com_phac-nml_irida-sistr-results.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_irida-sistr-results_overview.md)