---
name: bioconductor-artms
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/artMS.html
---

# bioconductor-artms

name: bioconductor-artms
description: Analysis and integration of large-scale proteomics (mass-spectrometry-based) datasets obtained from MaxQuant. Use this skill when you need to perform quality control (QC), relative quantification using MSstats, downstream analysis (enrichment, clustering, PCA), or generate input files for other tools (SAINTq, SAINTexpress, Photon, Phosfate) from MaxQuant evidence.txt files.

## Overview

The `artMS` package is a Bioconductor tool designed for the analysis of proteomics data, specifically optimized for outputs from MaxQuant. It provides a streamlined workflow for handling `evidence.txt` files, performing rigorous quality control, and executing statistical relative quantification. It supports various experiment types, including global protein abundance (AB), affinity purification mass spectrometry (APMS), and post-translational modifications (PTM) like phosphorylation (PH), ubiquitination (UB), and acetylation (AC).

## Basic Workflow

### 1. Setup and Input Files
Set your working directory to the project folder. `artMS` requires three tab-delimited files:
- `evidence.txt`: The standard MaxQuant output.
- `keys.txt`: User-generated file describing the experimental design (RawFile, IsotopeLabelType, Condition, BioReplicate, Run).
- `contrast.txt`: User-generated file defining the comparisons (e.g., `ConditionA-ConditionB`).

### 2. Quality Control (QC)
Perform QC before quantification to ensure data integrity.
```R
library(artMS)

# Basic QC (Intensity stats, correlation matrices, PTM stats)
artmsQualityControlEvidenceBasic(
  evidence_file = "evidence.txt",
  keys_file = "keys.txt",
  prot_exp = "PH" # Use "AB" for global abundance
)

# Extended QC (Charge states, PCA, peptide/protein detection frequency)
artmsQualityControlEvidenceExtended(
  evidence_file = "evidence.txt",
  keys_file = "keys.txt"
)
```

### 3. Relative Quantification
Quantification is driven by a YAML configuration file.
```R
# 1. Generate a template config file
artmsWriteConfigYamlFile(config_file_name = "my_config.yaml")

# 2. Edit the YAML (set file paths, filters, and MSstats parameters)

# 3. Run quantification
artmsQuantification(yaml_config_file = "my_config.yaml")
```

### 4. Downstream Analysis
After quantification, use `artmsAnalysisQuantifications` for clustering, PCA, and enrichment.
```R
artmsAnalysisQuantifications(
  log2fc_file = "results.txt",
  modelqc_file = "results_ModelQC.txt",
  species = "human",
  output_dir = "AnalysisResults"
)
```

## Specialized Tasks

### PTM Site-Specific Analysis
To quantify specific modification sites rather than total protein:
1. Convert the evidence file using a reference proteome (FASTA):
```R
artmsProtein2SiteConversion(
  evidence_file = "evidence.txt",
  ref_proteome_file = "proteome.fasta",
  output_file = "evidence-site.txt",
  mod_type = "PH"
)
```
2. Update your YAML config to point to `evidence-site.txt` and run `artmsQuantification`.

### Metabolomics (Untargeted)
`artMS` can process MarkerView alignment tables:
```R
# Convert MarkerView output to evidence-like format
artmsConvertMetabolomics(input_file = "markview.txt", out_file = "metab-evidence.txt")

# Run Metabolomics QC
artmsQualityControlMetabolomics(evidence_file = "metab-evidence.txt", keys_file = "keys.txt")
```

### Integration with Other Tools
Generate input files for external software:
- **SAINTexpress**: `artmsEvidenceToSaintExpress(evidence_file, keys_file, ref_proteome_file)`
- **SAINTq**: `artmsEvidenceToSAINTq(evidence_file, keys_file)`
- **Photon/Phosfate**: `artmsPhotonOutput(inputFile)` or `artmsPhosfateOutput(inputFile)`

## Tips and Best Practices
- **Condition Names**: Must not start with a number. Use only letters, numbers, and underscores.
- **Imputation**: `artmsAnalysisQuantifications` uses a "naive imputation" (parameter `mnbr`) for proteins found in one condition but missing in another.
- **Filtering**: By default, `artMS` removes contaminants (`CON__`) and reverse sequences (`REV__`).
- **Species Support**: Downstream enrichment analysis primarily supports "human" and "mouse".

## Reference documentation
- [artMS: Analytical R Tools for Mass Spectrometry](./references/artMS_vignette.md)
- [artMS Vignette Source](./references/artMS_vignette.Rmd)