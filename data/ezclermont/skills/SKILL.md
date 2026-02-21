---
name: ezclermont
description: The `ezclermont` tool automates the Clermont 2013 phylotyping method for *E.
homepage: https://github.com/nickp60/ezclermont
---

# ezclermont

## Overview
The `ezclermont` tool automates the Clermont 2013 phylotyping method for *E. coli*, which is the gold standard for categorizing strains based on their genetic background. It is designed for bioinformaticians and microbiologists who need to characterize isolates from genomic assemblies (FASTA) rather than performing wet-lab quadriplex PCR. The tool identifies the presence of specific markers (chuA, yjaA, TspE4.C2, etc.) and determines the phylotype based on the resulting combination.

## Installation
The recommended way to install `ezclermont` is via Conda:
```bash
conda install -c bioconda ezclermont
```

## Common CLI Patterns

### Basic Usage
To analyze a single FASTA file (genome or contigs):
```bash
ezclermont assembly.fasta
```

### Reading from Stdin
Useful for integration into pipelines where files are decompressed on the fly:
```bash
zcat genome.fasta.gz | ezclermont - --experiment_name "Strain_01"
```

### Batch Processing
To process multiple assemblies and aggregate results into a single table:
```bash
for i in *.fasta; do ezclermont "$i" >> all_results.txt; done
```

For faster processing using GNU Parallel:
```bash
ls *.fasta | parallel "ezclermont {} 1>> results.txt 2>> results.log"
```

## Tool-Specific Best Practices

### Handling Fragmented Assemblies
By default, `ezclermont` considers "partial hits" if an assembly has more than 4 sequences. This accounts for cases where a PCR target might be split across two contigs.
- **For Complete Genomes**: Use the `-n` or `--no_partial` flag to disable this behavior and reduce potential false positives.
- **For Highly Fragmented Data**: If your assembly is very poor, you may need to lower the `-m` (minimum contig length) parameter from its default of 500bp, though results may become less reliable.

### Interpreting Output
- **Stdout**: Contains the experiment name and the final Clermont phylotype. This is what you should capture for your final report.
- **Stderr**: Contains the detailed presence/absence data for each PCR product. If a phylotype seems unexpected, check the stderr logs to see which specific markers were detected.

### Experiment Naming
When reading from a file, the tool defaults the experiment name to the filename. When reading from `stdin`, it uses the first contig's ID. Use the `-e` flag to explicitly set a name for better downstream data management.

## Reference documentation
- [EzClermont GitHub Repository](./references/github_com_nickp60_EzClermont.md)
- [Bioconda ezclermont Overview](./references/anaconda_org_channels_bioconda_packages_ezclermont_overview.md)