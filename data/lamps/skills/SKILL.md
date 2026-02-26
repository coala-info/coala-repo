---
name: lamps
description: The lamps tool identifies and annotates metabolites by mapping mass-to-charge ratios from mass spectrometry data to specific chemical entities. Use when user asks to annotate metabolites, identify small molecules, or match experimental m/z values against metabolite databases.
homepage: https://pypi.org/project/lamps/
---


# lamps

## Overview
The `lamps` (Liverpool Annotation of Metabolites using Mass Spectrometry) tool provides a specialized framework for the identification and characterization of small molecules. It is particularly useful for researchers working with metabolomics datasets who need to map mass-to-charge (m/z) ratios to specific chemical entities. This skill assists in executing the tool's core annotation logic and managing its dependencies via the Bioconda ecosystem.

## Usage Guidelines

### Installation and Environment
The tool is distributed via Bioconda. Ensure your environment is configured with the necessary channels before execution:
```bash
conda install -c bioconda lamps
```

### Core Command Patterns
While specific subcommands depend on the version installed, the general execution flow follows these principles:

- **Input Data**: Prepare your mass spectrometry peak lists or intensity matrices in standard formats (typically CSV or TSV).
- **Annotation Logic**: Use the tool to match experimental m/z values against internal or external metabolite databases.
- **Parameter Tuning**: 
    - Adjust mass tolerance (ppm) based on the resolution of the mass spectrometer used (e.g., Orbitrap vs. Q-ToF).
    - Specify adduct types (e.g., [M+H]+, [M-H]-) relevant to your ionization mode.

### Best Practices
- **Data Preprocessing**: Ensure that peak picking and deconvolution are performed prior to using `lamps` for annotation to reduce false discovery rates.
- **Version Consistency**: As the tool is updated (current stable version 1.0.4), ensure that the database schemas used for annotation are compatible with the software version.
- **Output Interpretation**: Review the confidence scores or E-values provided in the output to distinguish between high-confidence assignments and isobaric overlaps.

## Reference documentation
- [lamps on Bioconda](./references/anaconda_org_channels_bioconda_packages_lamps_overview.md)
- [lamps Project Page](./references/pypi_org_project_lamps.md)