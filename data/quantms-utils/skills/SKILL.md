---
name: quantms-utils
description: quantms-utils provides a suite of command-line tools and Python helpers for proteomics data transformation, quality control metric extraction, and experimental design validation. Use when user asks to convert DIA-NN results to mzTab, extract mass spectrometry statistics into parquet files, validate SDRF sample sheets, or convert idXML files to CSV.
homepage: https://www.github.com/bigbio/quantms-utils
---


# quantms-utils

## Overview
The `quantms-utils` library provides a suite of command-line tools and Python helpers designed to support the quantms proteomics pipeline. It specializes in data transformation, quality control metric extraction, and experimental design validation. You should use this skill to automate the conversion of identification results into downstream analysis formats and to generate detailed parquet-based statistics from raw mass spectrometry files.

## Core CLI Workflows

### DIA-NN Result Conversion
Convert DIA-NN outputs to standardized formats for quality control or statistical analysis.
- **mzTab Conversion**: `diann2mztab --input report.tsv --output results.mzTab`
- **Configuration Generation**: Use `dianncfg` to programmatically create DIA-NN configuration files including enzyme logic and modification parameters.

### Mass Spectrometry Statistics Extraction
Extract comprehensive metrics from `.mzML` or Bruker `.d` formats. The tool generates Parquet files for efficient storage.
- **General Statistics**: `mzmlstats --input data.mzML --output_prefix sample_name`
  - Generates `{prefix}_ms_info.parquet`: Contains scan IDs, MS levels, RT, and precursor details.
  - Generates `{prefix}_ms2_info.parquet`: Contains MS2 peak arrays (m/z and intensity).
- **MS1 Feature Mapping**: Extracts features using the FeatureFinderMultiplex algorithm.
  - Generates `{prefix}_ms1_feature_info.parquet`: Includes m/z, RT, intensity, charge, and quality metrics.

### Experimental Design & Metadata
Validate and convert sample metadata between different formats used in proteomics.
- **SDRF Validation**: `checksamplesheet --input experimental_design.sdrf` (Checks for inconsistencies in sample naming or factor assignments).
- **OpenMS Integration**: `openms2sample --input design.txt` (Extracts sample information from OpenMS-specific experimental design files).

### PSM Processing
- **idXML to CSV**: `psmconvert --input identifications.idXML --output matches.csv`
  - Automatically filters decoys and extracts scores from multiple search engines.

## Expert Tips
- **Parquet Advantage**: Always prefer the parquet outputs from `mzmlstats` for downstream Python analysis (using pandas/polars) as they preserve the nested structure of m/z and intensity arrays better than flat CSVs.
- **Precursor Purity**: When using `mzmlstats`, the tool automatically calculates precursor purity and total intensity even if not explicitly annotated in the source file, which is critical for assessing DIA data quality.
- **Validation First**: Always run `checksamplesheet` before starting a large-scale quantification run to prevent pipeline failures caused by typos in the SDRF file.

## Reference documentation
- [GitHub Repository - bigbio/quantms-utils](./references/github_com_bigbio_quantms-utils.md)
- [Anaconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quantms-utils_overview.md)