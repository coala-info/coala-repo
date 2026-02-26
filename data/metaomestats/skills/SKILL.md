---
name: metaomestats
description: MetaomeStats calculates descriptive statistics for metaome de novo assemblies to evaluate fragmentation and assembly quality. Use when user asks to calculate assembly statistics, process a directory of FASTA files in batch, or perform reference-based assembly evaluation.
homepage: https://github.com/raw-lab/metaome_stats
---


# metaomestats

## Overview

MetaomeStats is a Python-based statistical package tailored for evaluating the quality of metaome de novo assemblies. Its primary function is to parse FASTA files—either individually or in bulk from a directory—to produce descriptive statistics that help researchers understand the fragmentation and scale of their assembly data. It is an essential tool for bioinformatics workflows involving metagenome-assembly, metatranscriptomics, and general genome analysis.

## Usage Patterns

The core functionality is accessed via the `countAssembly.py` script.

### Basic Assembly Statistics
To calculate statistics for a single assembly file with a specific residue interval:
```bash
countAssembly.py -i 100 -f assembly_results.fa
```

### Batch Processing
The tool can process an entire directory of FASTA files at once. This is useful for comparing multiple assembly iterations or different samples:
```bash
countAssembly.py -i 100 -f /path/to/fasta_directory/
```

### Reference-Based Evaluation
If a reference genome is available, you can provide it along with the expected genome size to get more comparative metrics:
```bash
countAssembly.py -i 100 -f assembly.fa -r reference_genome.fa -s 4600000
```

## Parameters and Best Practices

- **Interval (`-i`)**: This required argument sets the bin size for residue calculations. Choose an interval that matches your reporting requirements (e.g., 100 or 1000).
- **Input Formats**: Ensure your input files are in standard FASTA format (.fasta, .fa, .fna, or .ffn). The tool does not process quality scores (FASTQ).
- **Reference Size (`-s`)**: When using a reference, providing the exact size in base pairs allows for more accurate calculation of assembly coverage and completeness statistics.
- **Installation**: If the tool is missing from the environment, it can be installed via Bioconda: `conda install -c bioconda MetaomeStats`.

## Reference documentation
- [Metaome Stats GitHub Repository](./references/github_com_raw-lab_metaome_stats.md)
- [Bioconda MetaomeStats Overview](./references/anaconda_org_channels_bioconda_packages_metaomestats_overview.md)