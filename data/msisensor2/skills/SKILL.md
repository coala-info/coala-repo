---
name: msisensor2
description: MSIsensor2 is a machine learning-based algorithm designed for MSI detection in tumor-only sequencing workflows.
homepage: https://github.com/niu-lab/msisensor2
---

# msisensor2

## Overview
MSIsensor2 is a machine learning-based algorithm designed for MSI detection in tumor-only sequencing workflows. Unlike its predecessor, it does not require a matched normal sample, making it ideal for liquid biopsies (cfDNA) and clinical samples where normal tissue may be unavailable. It evaluates microsatellite sites based on read distribution models to provide an MSI score, somatic site list, and read count distributions.

## Command Line Usage

The primary command for analysis is `msi`.

### Basic Syntax
```bash
msisensor2 msi -M <models_dir> -t <tumor_bam> -o <output_prefix> [options]
```

### Core Options
- `-M <string>`: Path to the directory containing machine learning models (must match the reference genome used for alignment).
- `-t <string>`: Input tumor BAM file. **Note:** A BAM index file (.bai) must exist in the same directory.
- `-o <string>`: Prefix for the three output files.
- `-c <int>`: Coverage threshold for MSI analysis. Recommended settings:
    - **WES/WXS**: 20 (default)
    - **WGS**: 15
- `-b <int>`: Number of threads for parallel computing (default: 1).

### Reference-Specific Examples

**For hg38 alignment:**
```bash
msisensor2 msi -M ./models_hg38 -t tumor_hg38.bam -o sample_hg38
```

**For hg19 or GRCh37 alignment:**
```bash
msisensor2 msi -M ./models_hg19_GRCh37 -t tumor_hg19.bam -o sample_hg19
```

**For b37 or HumanG1Kv37 alignment:**
```bash
msisensor2 msi -M ./models_b37_HumanG1Kv37 -t tumor_b37.bam -o sample_b37
```

## Output Interpretation

The tool generates three files based on the provided prefix:

1.  **`<prefix>`**: Contains the final MSI score.
    - Columns: `Total_Number_of_Sites`, `Number_of_Somatic_Sites`, `%` (MSI Score).
    - **Threshold**: A score ≥ 20% is the recommended cutoff for MSI-High (MSI-H) status.
2.  **`<prefix>_somatic`**: Lists specific somatic sites detected.
    - Includes the discrimination value from the machine learning model for each site.
3.  **`<prefix>_dis`**: Detailed read count distribution for each microsatellite site.

## Expert Tips and Best Practices

- **Model Selection**: Always ensure the model directory (`-M`) matches the specific version of the human reference genome used for the BAM alignment. Using mismatched models will lead to inaccurate scoring.
- **Low Tumor Content**: MSIsensor2 is sensitive enough to handle cfDNA samples with tumor content as low as 0.1%.
- **Performance**: The tumor-only module is significantly faster than paired-sample methods (often 10x faster). A typical WES sample can be processed in approximately 3 minutes.
- **Custom Panels**: While standard models are provided for whole genomes and exomes, the tool supports customized site model training for specific panels (e.g., TSO500) if provided with a BED file of target regions.
- **Visualization**: Use the provided R script (`plot.r` in the source repository) to visualize the MSI score distribution across a cohort of samples.

## Reference documentation
- [MSIsensor2 Overview](./references/anaconda_org_channels_bioconda_packages_msisensor2_overview.md)
- [MSIsensor2 GitHub Documentation](./references/github_com_niu-lab_msisensor2.md)