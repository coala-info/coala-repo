---
name: hamronization
description: The hamronization tool converts disparate output formats from various antimicrobial resistance detection tools into a single unified specification. Use when user asks to convert AMR tool reports to a common format, harmonize outputs from tools like Abricate or RGI, or summarize multiple AMR reports into a single table or interactive HTML report.
homepage: https://github.com/pha4ge/hAMRonization
---

# hamronization

## Overview
The `hamronization` tool is a specialized CLI utility designed to solve the "Tower of Babel" problem in antimicrobial resistance (AMR) genomics. Different bioinformatic tools produce disparate output formats (TSV, JSON, TXT) with varying column headers and data structures. This skill enables the conversion of outputs from 17 different AMR detection tools into a single unified specification, supporting both gene presence/absence and mutational resistance data.

## Installation and Setup
The tool is available via multiple package managers. Use the following commands to ensure the environment is ready:

- **Pip**: `pip install hAMRonization`
- **Conda**: `conda install -c bioconda hamronization`
- **Docker**: `docker pull finlaymaguire/hamronization:latest`

## Common CLI Patterns

### Converting Tool-Specific Reports
The primary syntax is `hamronize <tool> <options>`. Each tool has specific input requirements based on its native output.

- **Abricate**: `hamronize abricate results.tsv > hamronized_results.tsv`
- **RGI (Resistance Gene Identifier)**: `hamronize rgi rgi_output.txt > hamronized_rgi.tsv`
- **ResFinder (JSON)**: `hamronize resfinder -j results.json > hamronized_resfinder.tsv`
- **AMRFinderPlus**: `hamronize amrfinderplus results.tsv > hamronized_amrfinder.tsv`
- **TBProfiler**: `hamronize tbprofiler results.results.json > hamronized_tb.tsv`

### Summarizing Multiple Reports
Once individual reports are converted to the hAMRonization format, use the `summarize` command to aggregate them into a single table or an interactive HTML report.

- **Standard Summary**:
  `hamronize summarize report1.tsv report2.tsv report3.tsv --output summary.tsv`

- **Interactive HTML Report**:
  `hamronize summarize report1.tsv report2.tsv --format interactive --output summary.html`

## Expert Tips and Best Practices

- **Version Sensitivity**: The parsers are typically tested against the latest versions of the underlying AMR tools. If a tool undergoes a major version change that alters its output format, the `hamronize` parser may require an update. Always verify the tool version if parsing fails.
- **Metadata Enrichment**: When hamronizing, you can often provide additional context like `--sample_id` or `--input_file_name` to ensure the unified output correctly attributes results to specific samples in a large batch.
- **Input Validation**: For tools like ResFinder, ensure you are using the correct flags (e.g., `-j` for JSON) as the parser expects specific structures.
- **Pipeline Integration**: Use hAMRonization as a "shim" layer immediately following your AMR detection step. This allows all subsequent analysis scripts to target a single, stable schema regardless of which detection tool was used upstream.



## Subcommands

| Command | Description |
|---------|-------------|
| hamronize | hamronize: error: argument analysis_tool: invalid choice: 'interactive' (choose from abricate, amrfinderplus, amrplusplus, ariba, csstar, deeparg, fargene, groot, kmerresistance, resfams, resfinder, mykrobe, rgi, srax, srst2, staramr, tbprofiler, summarize) |
| hamronize | Convert AMR gene detection tool output(s) to hAMRonization specification format |
| hamronize summarize | Concatenate and summarize AMR detection reports |

## Reference documentation
- [hAMRonization README](./references/github_com_pha4ge_hAMRonization_blob_master_README.md)
- [hAMRonization Specification Details](./references/github_com_pha4ge_hAMRonization_blob_master_docs_hAMRonization_specification_details.csv.md)