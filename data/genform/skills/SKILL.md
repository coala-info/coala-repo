---
name: genform
description: GenForm identifies molecular formulas for chemical compounds by analyzing high-resolution mass spectrometry and tandem mass spectrometry data. Use when user asks to identify molecular formulas, analyze MS and MS/MS fragmentation patterns, or determine chemical compositions from mass spectrometry data.
homepage: https://sourceforge.net/projects/genform/
metadata:
  docker_image: "quay.io/biocontainers/genform:r8--h9948957_8"
---

# genform

## Overview

GenForm is a specialized tool for chemical informatics and metabolomics. It automates the process of identifying the most likely molecular formulas for a given compound by analyzing the precise mass of the precursor ion (MS) and its fragmentation patterns (MS/MS). By integrating tandem mass spectrometry data, GenForm significantly improves the accuracy of automated formula determination compared to using MS data alone. It is designed for researchers in chemistry and bio-informatics working with high-resolution mass spectrometry datasets.

## Command Line Usage

GenForm is a console-based application. The primary interaction method is through specific key-value pairs passed as arguments.

### Basic Syntax
The standard execution requires paths to your MS and MS/MS data files:

`GenForm ms=<MS_DATA_FILE> msms=<MSMS_DATA_FILE> [options]`

### Common CLI Patterns
Based on the tool's implementation, a typical first call to process a sample (e.g., Sinapinic Acid) looks like this:

`GenForm ms=SinapinicAcidMs.txt msms=SinapinicAcidMsMs.txt exist out`

### Parameter Breakdown
- `ms=`: Path to the text file containing high-resolution MS data.
- `msms=`: Path to the text file containing high-resolution MS/MS data.
- `exist`: A flag used to validate or check for the existence of specific fragments or constraints during the formula generation process.
- `out`: Triggers the generation of output results based on the calculation.

## Best Practices and Expert Tips

- **Data Integration**: Always provide both `ms` and `msms` files when available. The underlying algorithm (Meringer et al., 2011) is specifically optimized to use fragmentation patterns to prune the search space of possible molecular formulas.
- **Input Formatting**: Ensure your MS and MS/MS data are in the expected plain text format. You can find template data files in the project's source tree under the `/trunk/data/` directory.
- **High Resolution**: The tool is designed for high-resolution data. Using low-resolution inputs will result in a significantly higher number of candidate formulas, reducing the utility of the output.
- **Manual Reference**: For complex configurations or specific chemical constraints, refer to the MOLGEN-MSMS Software User Manual available via ResearchGate.



## Subcommands

| Command | Description |
|---------|-------------|
| genform | Formula calculation from MS and MS/MS data as described in Meringer et al (2011) MATCH Commun Math Comput Chem 65: 259-290 |
| genform | Formula calculation from MS and MS/MS data as described in Meringer et al (2011) MATCH Commun Math Comput Chem 65: 259-290 |
| genform | Formula calculation from MS and MS/MS data as described in Meringer et al (2011) MATCH Commun Math Comput Chem 65: 259-290 |
| genform | Formula calculation from MS and MS/MS data as described in Meringer et al (2011) MATCH Commun Math Comput Chem 65: 259-290 |
| genform | Formula calculation from MS and MS/MS data as described in Meringer et al (2011) MATCH Commun Math Comput Chem 65: 259-290 |

## Reference documentation
- [GenForm Project Summary](./references/sourceforge_net_projects_genform.md)
- [GenForm Support and Manual Information](./references/sourceforge_net_projects_genform_support.md)