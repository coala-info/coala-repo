---
name: pangolearn
description: This tool provides the trained decision tree models used by pangolin to assign SARS-CoV-2 sequences to Pango lineages. Use when user asks to install, update, or verify the model repository for legacy pangolin v2 and v3 workflows.
homepage: https://github.com/cov-lineages/pangoLEARN
---


# pangolearn

## Overview
The pangoLEARN package serves as the model repository for the pangolin tool. It contains the trained decision tree logic used to assign SARS-CoV-2 sequences to specific Pango lineages. While modern versions of pangolin (4.0+) have transitioned to using the `pangolin-data` repository, pangoLEARN remains the critical dependency for all legacy v2 and v3 workflows. This skill provides guidance on installing, updating, and verifying these models to ensure accurate lineage classification in older environments.

## Installation and Environment Setup
pangoLEARN is primarily distributed via Bioconda. It should be installed within the same environment as the pangolin tool.

```bash
# Standard installation via conda
conda install -c bioconda pangolearn

# Install a specific version for reproducibility
conda install -c bioconda pangolearn=2022.03.22
```

## Updating Models
Because lineage definitions evolve rapidly, keeping the model store updated is the most common task associated with this tool.

### Automatic Updates
The most reliable way to update pangoLEARN is through the pangolin interface itself:
```bash
pangolin --update
```
This command checks for the latest releases of both the tool and the pangoLEARN model data.

### Manual Updates via Pip
If you need a version not yet available on Bioconda or are working in a development environment:
```bash
pip install git+https://github.com/cov-lineages/pangoLEARN.git --upgrade
```

## Version Verification
To ensure your pipeline is using the intended model version, use the following patterns:

1. **Check via pangolin**:
   ```bash
   pangolin --version
   ```
   This typically outputs both the tool version and the pangoLEARN model version (e.g., `pangolin 3.1.20`, `pangoLEARN 2022-01-20`).

2. **Check via Conda**:
   ```bash
   conda list pangolearn
   ```

## Best Practices and Troubleshooting
- **Deprecation Awareness**: pangoLEARN is deprecated for `pangolin 4.0` and higher. If you are upgrading your main tool to v4.0+, you must switch to `pangolin-data` instead of pangoLEARN.
- **Reproducibility**: When publishing results, always record the specific pangoLEARN release date (e.g., 2022-07-09) rather than just the pangolin tool version, as the model data determines the actual lineage assignment logic.
- **Path Conflicts**: If pangolin fails to find the model, ensure that `setup.py` was executed correctly during installation, as this script handles the path finding for the decision tree files.

## Reference documentation
- [Bioconda pangolearn Overview](./references/anaconda_org_channels_bioconda_packages_pangolearn_overview.md)
- [pangoLEARN GitHub Repository](./references/github_com_cov-lineages_pangoLEARN.md)
- [pangoLEARN Master Tree](./references/github_com_cov-lineages_pangoLEARN_tree_master_pangoLEARN.md)