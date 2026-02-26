---
name: mobidic-mpa
description: The MoBiDiC Prioritization Algorithm filters and ranks genomic variants to help identify causative mutations in large datasets. Use when user asks to prioritize genomic variants, rank mutations from VCF files, or interpret variants for rare disease diagnostics.
homepage: https://neuro-2.iurc.montp.inserm.fr/mpaweb/
---


# mobidic-mpa

## Overview
The MoBiDiC Prioritization Algorithm (MPA) is a specialized tool used in bioinformatics to filter and rank genomic variants. It streamlines the interpretation process by applying a prioritization logic that helps clinicians and researchers identify the most likely causative mutations from large datasets (such as VCF files). It is particularly useful in the context of rare disease diagnostics where manual curation of thousands of variants is impractical.

## Installation and Setup
The tool is primarily distributed via Bioconda. To ensure all dependencies are correctly managed, use a dedicated conda environment:

```bash
conda create -n mpa_env -c bioconda mobidic-mpa
conda activate mpa_env
```

## Common Usage Patterns
While specific command-line arguments depend on the version and local configuration, the general workflow involves providing a variant file and specifying the prioritization criteria.

### Basic Execution
Run the algorithm by passing your input file (typically in VCF or a specific tabular format required by the MoBiDiC pipeline):

```bash
mpa -i input_variants.vcf -o prioritized_output.tsv
```

### Key Considerations
- **Input Preparation**: Ensure your input files are properly annotated. MPA often relies on external annotations (like SnpEff, VEP, or ClinVar) to perform its ranking logic.
- **Prioritization Logic**: The algorithm integrates multiple scores. When interpreting results, focus on the "MPA Score" or rank, which aggregates various evidence levels into a single actionable metric.
- **Clinical Integration**: This tool is often used as part of the USMA (Unité de Stratégie Génomique et Médicale) workflow for medical genomics.

## Expert Tips
- **Version Consistency**: Ensure you are using version 1.3.0 or higher for the most up-to-date prioritization schemas.
- **Output Analysis**: The output is typically a TSV file. Use standard Unix tools (`awk`, `column`, `grep`) or spreadsheet software to filter for variants with the highest priority scores.
- **Resource Migration**: Note that the web-based interface and documentation have migrated to the USMA portal (https://usma.chu-montpellier.fr). Refer to the portal for updated scoring matrices or population frequency thresholds used by the algorithm.

## Reference documentation
- [MoBiDiC MPA Overview](./references/anaconda_org_channels_bioconda_packages_mobidic-mpa_overview.md)
- [USMA Portal Information](./references/neuro-2_iurc_montp_inserm_fr_usma_index.html.md)