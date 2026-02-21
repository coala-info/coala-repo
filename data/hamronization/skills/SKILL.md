---
name: hamronization
description: The `hamronization` tool is a specialized parser designed to unify the outputs of 17 different antimicrobial resistance gene detection tools into a single, standardized data structure.
homepage: https://github.com/pha4ge/hAMRonization
---

# hamronization

## Overview
The `hamronization` tool is a specialized parser designed to unify the outputs of 17 different antimicrobial resistance gene detection tools into a single, standardized data structure. It solves the problem of disparate output formats by mapping tool-specific results to the hAMRonization specification. This allows researchers to combine results from different algorithms (e.g., BLAST-based vs. k-mer based) into a single table or an interactive dashboard for easier interpretation and downstream processing.

## Installation
The tool is primarily available via Bioconda or Pip:
```bash
conda install -c bioconda hamronization
# OR
pip install hAMRonization
```

## Common CLI Patterns

### 1. Standardizing a Single Tool Output
Most tools require you to manually provide version information for the software and the reference database used, as this metadata is often missing from the raw output files but required by the hAMRonization spec.

```bash
# Example for abricate
hamronize abricate path/to/abricate_report.tsv \
    --analysis_software_version 1.0.1 \
    --reference_database_version 2023-01-01 \
    --format tsv \
    --output standardized_report.tsv
```

### 2. Batch Processing Same-Tool Reports
You can pass multiple reports from the same tool to a single command to generate a concatenated standardized file.

```bash
# Standardizing multiple RGI reports at once
hamronize rgi report1.txt report2.txt report3.txt \
    --analysis_software_version 6.0.0 \
    --reference_database_version 3.2.5 \
    --format json \
    --output combined_rgi.json
```

### 3. Summarizing Mixed Tool Outputs
The `summarize` command is used to merge reports that have already been "hamronized," even if they are in different formats (TSV and JSON).

```bash
# Combine different tool outputs into one master TSV
hamronize summarize -t tsv -o master_summary.tsv \
    standardized_abricate.json \
    standardized_rgi.tsv \
    standardized_deeparg.json
```

### 4. Generating Interactive Reports
For visual exploration, use the `interactive` summary type to create an HTML file.

```bash
hamronize summarize -t interactive -o amr_dashboard.html report1.tsv report2.tsv
```

## Supported Tools and Expected Inputs
When calling `hamronize <tool>`, ensure you are providing the correct file type:
- **abricate/amrfinderplus/ariba/groot**: Expects `.tsv`
- **resfinder/mykrobe/tbprofiler**: Expects `.json`
- **rgi**: Expects `.txt` (standard output) or `_bwtoutput.gene_mapping_data.txt`
- **srst2**: Expects `_srst2_report.tsv`
- **fargene**: Expects `retrieved-genes-*-hmmsearched.out`

## Expert Tips
- **Metadata Requirements**: If a command fails, check the `--help` for that specific tool (e.g., `hamronize rgi --help`). Many tools have mandatory flags for software/database versions to ensure the output meets the hAMRonization specification.
- **Python Integration**: For complex workflows, use the library directly. `hAMRonization.parse()` returns a generator of result objects, which is memory-efficient for large datasets.
- **Version Sensitivity**: The parsers are generally tested against the latest versions of the underlying AMR tools. If a tool's output format changes significantly in a new release, the parser may require an update.

## Reference documentation
- [hAMRonization GitHub Repository](./references/github_com_pha4ge_hAMRonization.md)
- [Bioconda hamronization Overview](./references/anaconda_org_channels_bioconda_packages_hamronization_overview.md)