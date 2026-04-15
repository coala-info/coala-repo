---
name: beamspy
description: BEAMSpy is a Python toolkit for the putative annotation of metabolites in untargeted LC-MS and DIMS metabolomics assays. Use when user asks to annotate metabolites, match features against reference databases, or perform correlation analysis to group metabolic features.
homepage: https://github.com/computational-metabolomics/beamspy
metadata:
  docker_image: "quay.io/biocontainers/beamspy:1.2.0--pyhdfd78af_0"
---

# beamspy

## Overview
BEAMSpy (Birmingham mEtabolite Annotation for Mass Spectrometry) is a Python-based toolkit designed for the putative annotation of metabolites in untargeted metabolomics assays. It supports both Liquid Chromatography-Mass Spectrometry (LC-MS) and Direct Infusion Mass Spectrometry (DIMS). The tool automates the identification process by matching detected features against reference databases, considering adducts, isotopes, and neutral losses to reach Metabolomics Standards Initiative (MSI) reporting standards.

## Installation and Setup
To ensure all dependencies (such as PySide2 for the GUI) are correctly resolved, it is recommended to install BEAMSpy via Conda using the specific channel priority:

```bash
conda create -n beamspy beamspy -c conda-forge -c bioconda -c computational-metabolomics
conda activate beamspy
```

## Common CLI Patterns
The primary interface for BEAMSpy is the command line, though it includes a graphical component for interactive sessions.

### Basic Help and Versioning
Check the installed version and available subcommands:
```bash
beamspy --version
beamspy --help
```

### Launching the Graphical Interface
For users preferring a visual workflow for parameter selection and data inspection:
```bash
beamspy start-gui
```

## Expert Tips and Best Practices
- **Reference Libraries**: While BEAMSpy includes standard reference files, you can improve annotation accuracy by providing custom reference libraries tailored to your specific sample matrix or instrument setup.
- **Correlation Analysis**: Use the correlation modules to group features originating from the same metabolite. Recent updates include a "positive" flag for correlation analysis to filter or focus on specific correlation directions.
- **Adduct and Isotope Handling**: Ensure your input parameters account for expected adducts (e.g., [M+H]+, [M+Na]+) and isotopes to reduce redundancy in your feature list and improve MSI level 2/3 confidence.
- **Neutral Losses**: When working with complex fragmentation patterns, utilize the neutral loss modules to identify related metabolic features.
- **Memory Management**: BEAMSpy utilizes SQLite in-memory databases for compound annotation to speed up processing; ensure your environment has sufficient RAM when working with exceptionally large peak lists or extensive custom databases.



## Subcommands

| Command | Description |
|---------|-------------|
| beamspy annotate-compounds | Annotate compounds using a peaklist and a database. |
| beamspy annotate-mf | Annotate molecular formulas for peaks. |
| beamspy annotate-peak-patterns | Annotate peaks with adducts, isotopes, oligomers, and neutral losses. |
| beamspy group-features | Groups features based on correlation and retention time. |
| beamspy summary-results | Generates a summary of BEAMSpy results. |

## Reference documentation
- [BEAMSpy Overview](./references/anaconda_org_channels_bioconda_packages_beamspy_overview.md)
- [GitHub Repository](./references/github_com_computational-metabolomics_beamspy.md)