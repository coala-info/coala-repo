---
name: fusion-report
description: Fusion-report unifies and annotates gene fusion detection results from multiple bioinformatics tools into a single comprehensive report. Use when user asks to generate fusion reports, download or sync fusion databases, and cross-reference detection results against known databases.
homepage: https://github.com/matq007/fusion-report
---


# fusion-report

## Overview
The `fusion-report` tool is a specialized utility for clinical genomics and bioinformatics workflows that simplifies the interpretation of gene fusion data. Instead of manually comparing disparate output formats from different detection algorithms, this tool parses them into a unified structure and cross-references them against known fusion databases. Use this skill to generate comprehensive reports that highlight consensus between tools and provide functional annotations for detected fusion events.

## Database Management
Before generating reports, you must set up the local knowledge base. The tool supports FusionGDB2, Mitelman, and COSMIC.

### Downloading Databases
Use the `download` command to initialize your database directory. Note that COSMIC requires valid credentials.

```bash
# Basic download for open databases
fusion_report download /path/to/db_folder/

# Download including COSMIC (requires registration)
fusion_report download --cosmic_usr 'USERNAME' --cosmic_passwd 'PASSWORD' /path/to/db_folder/
```

### Syncing
To ensure your local databases are up to date with the latest versions of the source repositories:
```bash
fusion_report sync /path/to/db_folder/
```

## Running the Report
The `run` command requires a sample name, an output directory, the path to your databases, and at least one tool-specific output file.

### Common CLI Pattern
Pass the output files from your fusion callers using the corresponding flags:

```bash
fusion_report run "Sample_ID" ./output_dir/ /path/to/db_folder/ \
  --arriba arriba_fusions.tsv \
  --starfusion star-fusion.fusion_predictions.abridged.tsv \
  --fusioncatcher fusioncatcher_final.txt \
  --ericscript ericscript_results.results.tsv \
  --pizzly pizzly_fusions.tsv \
  --squid squid_fusions.txt \
  --jaffa jaffa_results.csv
```

### Handling Ambiguous Gene Symbols
In cases where a fusion's gene symbol cannot be uniquely determined, use the following flag to prevent the tool from collapsing potentially distinct events:
- `--allow-multiple-gene-symbols`: Treats each provided fusion as a separate entry if the symbol is ambiguous.

## Supported Tool Formats
Ensure your input files match the expected formats for these specific flags:
- `--arriba`: `.tsv` output
- `--dragen`: `.tsv` output
- `--ericscript`: `.tsv` output
- `--fusioncatcher`: `.txt` output
- `--jaffa`: `.csv` output
- `--pizzly`: `.tsv` output
- `--squid`: `.txt` output
- `--starfusion`: `.tsv` output

## Expert Tips
- **Consensus Filtering**: The resulting interactive report is most powerful when comparing 3+ tools. Look for fusions detected by multiple callers as high-confidence candidates.
- **Path Management**: Always use absolute paths for the database directory to avoid resolution errors during multi-sample processing.
- **Help Documentation**: For a full list of parameters and version-specific flags, use `fusion_report run --help`.

## Reference documentation
- [github_com_Clinical-Genomics_fusion-report.md](./references/github_com_Clinical-Genomics_fusion-report.md)
- [anaconda_org_channels_bioconda_packages_fusion-report_overview.md](./references/anaconda_org_channels_bioconda_packages_fusion-report_overview.md)