---
name: drhip
description: drhip parses and aggregates complex JSON output files from HyPhy molecular evolution tests into structured CSV summaries. Use when user asks to process HyPhy selection test results, synthesize data from the CAPHEINE workflow, or identify patterns of selection across multiple genes.
homepage: https://github.com/veg/drhip
---


# drhip

## Overview
drhip (Data Reduction for HyPhy with Inference Processing) is a specialized toolkit for molecular evolution researchers. It automates the tedious task of parsing complex JSON output files from various HyPhy selection tests across multiple genes. By synthesizing these results into structured CSV files, it enables researchers to quickly identify patterns of selection, relaxation, or conservation across an entire dataset. It is the standard tool for processing outputs from the CAPHEINE workflow.

## Installation
Install drhip via Bioconda or Pip:
```bash
# Via Conda
conda install -c bioconda drhip

# Via Pip
pip install drhip
```

## Basic Usage
The primary interface is a single command-line execution that points to your HyPhy results directory and a desired output location.

```bash
drhip -i /path/to/hyphy_results -o /path/to/output_directory
```

### Input Directory Structure
For drhip to function correctly, input files should follow the standard CAPHEINE organization. The tool looks for subdirectories named after specific HyPhy methods:
- `hyphy/BUSTED/` (Episodic diversification)
- `hyphy/RELAX/` (Relaxation of selection)
- `hyphy/MEME/` (Site-specific episodic selection)
- `hyphy/FEL/` (Fixed effects likelihood)
- `hyphy/PRIME/` (Property-informed models)
- `hyphy/CONTRASTFEL/` (Selection comparison between groups)

## Output Files and Interpretation
drhip generates four primary CSV files that aggregate data across all processed genes:

1. **combined_summary.csv**: Gene-level statistics. Includes p-values, LRT statistics, and omega distributions.
2. **combined_sites.csv**: Site-specific analysis. Includes amino acid composition and inferred substitutions.
3. **combined_comparison_summary.csv**: (Generated if RELAX/Contrast-FEL are present) Group-specific dN/dS ratios and branch metrics.
4. **combined_comparison_site.csv**: (Generated if RELAX/Contrast-FEL are present) Site-specific metrics for comparison groups (e.g., foreground vs. background).

### Data Markers
- **Actual Values**: Represent statistically significant results (e.g., p < 0.05).
- **"-" (Dash)**: Represents non-significant results.
- **"NA"**: Indicates missing, malformed, or unprocessable data for that specific gene/method.

## Best Practices
- **Parallel Processing**: drhip handles multi-gene results in parallel by default; ensure your environment has sufficient memory if processing thousands of genes.
- **Backward Compatibility**: The tool is designed to handle older HyPhy JSON versions by marking missing fields as `NA` rather than failing.
- **Comparison Groups**: To generate comparison-specific files, ensure your phylogenetic trees in the HyPhy analysis were labeled with groups (e.g., `{Foreground}` and `{Background}`).

## Reference documentation
- [DRHIP GitHub Repository](./references/github_com_veg_DRHIP.md)
- [Bioconda drhip Overview](./references/anaconda_org_channels_bioconda_packages_drhip_overview.md)