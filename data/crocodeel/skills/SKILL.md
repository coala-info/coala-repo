---
name: crocodeel
description: CroCoDeEL detects and estimates cross-sample contamination levels in metagenomic datasets using a Random Forest model. Use when user asks to identify contamination events, visualize contamination scatterplots, or train custom models for specific sequencing protocols.
homepage: https://github.com/metagenopolis/crocodeel
---


# crocodeel

## Overview
CroCoDeEL (CROss-sample COntamination DEtection and Estimation of its Level) is a specialized tool for quality control in metagenomics. It uses a Random Forest model to distinguish between true biological similarity and contamination events. This skill provides the necessary command-line patterns to identify contamination, visualize results for manual validation, and train custom models for specific lab environments.

## Core Workflows

### Input Requirements
- **Format**: TSV file with species names in the first column and sample abundances in subsequent columns.
- **Normalization**: CroCoDeEL automatically normalizes tables to relative abundance (sum = 1).
- **Upstream Tools**: Use **Meteor** for optimal results. **MetaPhlAn4** (with `--tax_level t`) is supported but may miss low-level contamination.

### Detecting Contamination
To identify contamination events and output a report:
```bash
crocodeel search_conta -s species_abundance.tsv -c contamination_events.tsv
```
**For MetaPhlAn4 users**: Always filter low-abundance species to maintain sensitivity:
```bash
crocodeel search_conta -s species_abundance.tsv --filter-low-ab 20 -c contamination_events.tsv
```

### Visualization and Validation
Because related samples (e.g., longitudinal data or co-housed animals) can trigger false positives, manual inspection of scatterplots is highly recommended.

**Generate plots separately:**
```bash
crocodeel plot_conta -s species_abundance.tsv -c contamination_events.tsv -r contamination_report.pdf
```

**One-step workflow (Search + Plot):**
```bash
crocodeel easy_wf -s species_abundance.tsv -c contamination_events.tsv -r contamination_report.pdf
```

### Custom Model Training
For advanced users needing to adapt the tool to specific sequencing protocols:
1. Prepare a labeled training dataset (TSV).
2. Train the model:
   ```bash
   crocodeel train_model -s training_dataset.tsv -m custom_model.tsv -r model_performance.tsv
   ```
3. Apply the custom model:
   ```bash
   crocodeel search_conta -s species_abundance.tsv -m custom_model.tsv -c results.tsv
   ```

## Expert Tips
- **False Positives**: If samples are biologically related (e.g., same individual over time), CroCoDeEL may flag them. Use the generated PDF to check if the "contamination line" (red) truly represents introduced species or general profile similarity.
- **Installation Verification**: Run `crocodeel test_install` to ensure the environment is correctly configured before processing large datasets.
- **Subdominant Species**: The tool's accuracy relies heavily on the precise estimation of low-abundance species; ensure your taxonomic profiler is sensitive enough.



## Subcommands

| Command | Description |
|---------|-------------|
| crocodeel easy_wf | Detects and quantifies contamination events in metagenomic samples. |
| crocodeel plot_conta | Generate scatterplots for contamination events. |
| search_conta | Search for contamination events |
| test_install | Test the installation of crocodeel |
| train_model | Train a Random Forest model to classify species based on their abundance. |

## Reference documentation
- [CroCoDeEL GitHub Repository](./references/github_com_metagenopolis_crocodeel.md)
- [CroCoDeEL Wiki](./references/github_com_metagenopolis_crocodeel_wiki.md)