---
name: strike
description: The STRIKE (Single sTRucture Induced Evaluation) tool provides a quantitative measure of alignment quality by projecting contacts from a known protein structure onto a sequence alignment.
homepage: http://www.tcoffee.org/Projects/strike/index.html
---

# strike

## Overview
The STRIKE (Single sTRucture Induced Evaluation) tool provides a quantitative measure of alignment quality by projecting contacts from a known protein structure onto a sequence alignment. It utilizes a specialized STRIKE matrix—analogous to a BLOSUM matrix but for structural contacts—to score the agreement between the sequences and the template. Higher scores indicate better structural consistency within the alignment.

## Usage Guidelines

### Basic Command Pattern
To calculate the score for an alignment using a template structure, use the following syntax:

```bash
strike -c <template_file> -a <alignment_file>
```

### Key Inputs
- **Template File (`-c`)**: A protein structure file (typically in PDB format) that serves as the reference for contact projection.
- **Alignment File (`-a`)**: The multiple sequence alignment file to be evaluated.

### Interpreting Results
- **Scoring**: The output is a single numerical score representing the whole alignment.
- **Optimization**: When comparing different alignment strategies or parameters for the same set of sequences, the alignment with the higher STRIKE score is generally considered more biologically accurate in terms of structural conservation.

## Best Practices
- **Template Selection**: Ensure the template structure used is representative of the protein family being aligned.
- **File Formats**: While the tool is part of the T-Coffee suite ecosystem, ensure your alignment files are in standard formats (like Clustal or FASTA) compatible with T-Coffee utilities.
- **Installation**: If the binary is not present, it can be installed via bioconda (`conda install bioconda::strike`) or compiled from source using `make`.

## Reference documentation
- [STRIKE Home Page](./references/tcoffee_org_Projects_strike_index.html.md)
- [Bioconda Strike Package Overview](./references/anaconda_org_channels_bioconda_packages_strike_overview.md)