---
name: crocodeel
description: "CroCoDeEL detects and estimates cross-sample contamination levels in metagenomic datasets by analyzing species abundance tables. Use when user asks to identify contaminated samples, estimate contamination rates, or generate visual contamination reports from species abundance data."
homepage: https://github.com/metagenopolis/crocodeel
---


# crocodeel

## Overview
CroCoDeEL (CROss-sample COntamination DEtection and Estimation of its Level) is a specialized tool for quality control in metagenomics. It analyzes species abundance tables to identify samples that have been contaminated by other samples in the same batch. By using a Random Forest model, it distinguishes between shared biological signatures and actual contamination events, providing the likely source of contamination and an estimated contamination rate.

## Installation and Verification
Verify the environment is correctly configured before processing large datasets:
```bash
crocodeel test_install
```
Use `--keep-results` to inspect the toy dataset output if troubleshooting.

## Core Workflows

### The "Easy" Workflow
For most standard analyses, use the integrated workflow to search for contamination and generate a visual report in one step:
```bash
crocodeel easy_wf -s species_abundance.tsv -c contamination_events.tsv -r contamination_report.pdf
```

### Manual Search and Visualization
If you prefer to separate the detection from the plotting:
1. **Search**: `crocodeel search_conta -s species_abundance.tsv -c contamination_events.tsv`
2. **Plot**: `crocodeel plot_conta -s species_abundance.tsv -c contamination_events.tsv -r contamination_report.pdf`

## Input Requirements and Best Practices

### Data Formatting
- **Format**: TSV file.
- **Structure**: First column must be species names; subsequent columns are sample abundances.
- **Normalization**: CroCoDeEL automatically normalizes columns to relative abundance (sum = 1.0).

### Taxonomic Profiler Recommendations
The accuracy of CroCoDeEL depends heavily on the detection of subdominant species:
- **Meteor**: The preferred suite for generating input tables.
- **MetaPhlAn4**: Supported, but you **must** use the `--tax_level t` parameter during profiling.
- **Filtering**: When using MetaPhlAn4, use the `--filter-low-ab` flag in CroCoDeEL to improve sensitivity:
  ```bash
  crocodeel search_conta -s species_abundance.tsv --filter-low-ab 20 -c contamination_events.tsv
  ```

## Result Interpretation and Expert Tips

### Identifying False Positives
CroCoDeEL may report false positives in specific biological contexts where samples are naturally very similar. Exercise caution and manually inspect scatterplots for:
- **Longitudinal data**: Multiple samples from the same individual over time.
- **Related samples**: Animals raised in the same cage or co-housed individuals.

### Scatterplot Analysis
The generated PDF report (`-r`) provides log-scale scatterplots. 
- **Red Line**: Represents the contamination line.
- **Interpretation**: Species appearing along the red line are those specifically introduced by the source into the target sample. If the "contaminated" species follow the general diagonal of the cloud rather than the red line, it is likely a false positive due to biological similarity.

### Custom Models
For advanced users with specific lab signatures, you can train and apply a custom Random Forest model:
```bash
# Training
crocodeel train_model -s training_data.tsv -m custom_model.tsv -r performance_metrics.tsv

# Application
crocodeel search_conta -s species_abundance.tsv -m custom_model.tsv -c results.tsv
```

## Reference documentation
- [CroCoDeEL GitHub Repository](./references/github_com_metagenopolis_crocodeel.md)
- [CroCoDeEL Wiki](./references/github_com_metagenopolis_crocodeel_wiki.md)