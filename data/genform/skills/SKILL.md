---
name: genform
description: genform automatically determines molecular formulas by processing high-resolution MS and MS/MS data. Use when user asks to identify chemical compositions, determine molecular formulas from mass spectrometry data, or process MS/MS fragmentation patterns.
homepage: https://sourceforge.net/projects/genform/
---


# genform

## Overview

genform is a specialized command-line tool for the automated determination of molecular formulas. It processes high-resolution MS and MS/MS data to identify potential chemical compositions, implementing the algorithms described in the MOLGEN-MSMS framework. By combining precursor mass information with fragmentation patterns, it significantly improves the accuracy of formula assignment compared to using MS data alone.

## Installation

The tool is available via the Bioconda channel:

```bash
conda install bioconda::genform
```

## Command Line Usage

The tool is invoked using the `GenForm` command. It uses a key-value pair syntax for arguments rather than standard POSIX flags.

### Basic Syntax
```bash
GenForm ms=<ms_data_file> msms=<msms_data_file> [options]
```

### Common Arguments
- `ms=`: Path to the primary mass spectrometry data file (typically a text file containing peak lists).
- `msms=`: Path to the tandem mass spectrometry data file.
- `exist`: A flag often used in standard calls to check for existing data or constraints.
- `out`: Directs the tool to generate output files based on the calculations.

### Example Execution
To process a sample like Sinapinic Acid using provided data files:
```bash
GenForm ms=SinapinicAcidMs.txt msms=SinapinicAcidMsMs.txt exist out
```

## Best Practices and Tips

- **Data Quality**: Ensure that input files are formatted as plain text peak lists. High-resolution data is required for the algorithm to effectively prune the search space of potential formulas.
- **Combined Analysis**: Always provide both `ms` and `msms` files when available. The integration of fragmentation data (MS/MS) is the primary strength of genform and drastically reduces the number of false-positive formula candidates.
- **Manual Reference**: For complex parameter tuning or understanding specific scoring metrics, refer to the MOLGEN-MSMS Software User Manual.
- **Environment**: On Linux systems, the binary may be named `GenForm.linux`. Ensure the binary is in your PATH or call it directly from the installation directory.

## Reference documentation
- [GenForm Overview](./references/sourceforge_net_projects_genform.md)
- [Bioconda GenForm Package](./references/anaconda_org_channels_bioconda_packages_genform_overview.md)
- [GenForm Support and Manual](./references/sourceforge_net_projects_genform_support.md)