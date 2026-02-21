---
name: pmultiqc
description: pmultiqc is a specialized MultiQC plugin designed for the proteomics community.
homepage: https://github.com/bigbio/pmultiqc/
---

# pmultiqc

## Overview
pmultiqc is a specialized MultiQC plugin designed for the proteomics community. It transforms raw output from various search engines and analysis pipelines into interactive, web-based reports. By integrating with the MultiQC framework, it allows researchers to assess instrument performance, identification success, and quantification consistency across multiple samples in a single view. It is particularly useful for identifying batch effects, contamination, or sample preparation issues in LFQ, TMT, and DIA experiments.

## Installation
Install via Bioconda or PyPI:
```bash
conda install bioconda::pmultiqc
# OR
pip install pmultiqc
```

## Core Usage Patterns
pmultiqc operates as a plugin for the standard `multiqc` command. You must specify the appropriate plugin flag based on your data source.

### Basic Execution
Run MultiQC on a directory containing your proteomics results:
```bash
multiqc . --quantms-plugin -o ./qc_report
```

### Search Engine Specific Triggers
Use the specific flag corresponding to your analysis tool:
- **MaxQuant**: `multiqc . --maxquant-plugin`
- **DIA-NN**: `multiqc . --diann-plugin`
- **FragPipe**: `multiqc . --fragpipe-plugin`
- **mzIdentML**: `multiqc . --mzid-plugin`
- **ProteoBench**: `multiqc . --proteobench-plugin`

## Advanced Configuration and Best Practices

### Handling Large Datasets
For experiments with hundreds of samples or massive peptide lists, the interactive tables can slow down report loading.
- **Disable heavy tables**: Use `--disable-table` to skip the rendering of large protein/peptide tables while keeping the summary plots.
- **Speed up processing**: Use `--ignored-idxml` if you only need summary statistics and want to skip parsing heavy identification files.

### Experimental Design and Grouping
To make the QC report biologically meaningful, use the condition flag to group samples:
- **Group by factor**: `multiqc . --quantms-plugin --condition Treatment`
- **Keep raw names**: Use `--keep-raw` if you want to prevent the plugin from shortening or cleaning up filenames in the report.

### Filtering Decoys and Contaminants
Accurate QC requires distinguishing between real hits and noise:
- **Decoy handling**: By default, decoys are removed (`--remove-decoy`). Customize the marker with `--decoy-affix REV_` and specify position with `--affix-type prefix` or `suffix`.
- **Contaminant marking**: Define your contaminant prefix (default is `CONT`) using `--contaminant-affix`.

### Quantification Methods
For Label-Free Quantification (LFQ), you can specify how intensities are handled:
- `multiqc . --quantms-plugin --quantification-method feature_intensity` (default)

## Key Metrics to Monitor
When reviewing the generated `multiqc_report.html`, focus on these sections:
1. **Contaminants Score**: High scores indicate potential sample preparation issues.
2. **Missed Cleavages**: High percentages suggest inefficient trypsin digestion.
3. **Charge Score**: Monitors the distribution of precursor charges; shifts can indicate instrument calibration issues.
4. **ID rate over RT**: Helps identify periods during the LC gradient where identification efficiency dropped.
5. **Delta Mass**: Essential for checking the mass accuracy of the instrument across the run.

## Reference documentation
- [pmultiqc GitHub Repository](./references/github_com_bigbio_pmultiqc.md)
- [pmultiqc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pmultiqc_overview.md)