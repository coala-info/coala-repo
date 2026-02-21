---
name: clsify
description: The `clsify` tool (also known as Haplotype-LSO) provides a specialized workflow for the molecular identification of the plant pathogen *C.
homepage: https://github.com/holtgrewe/clsify
---

# clsify

## Overview
The `clsify` tool (also known as Haplotype-LSO) provides a specialized workflow for the molecular identification of the plant pathogen *C. Liberibacter solanacearum*. It automates the comparison of Sanger reads against official reference sequences to determine species identity and specific haplotype classification. This skill streamlines the transition from raw FASTA/FASTQ data to a structured TSV report, ensuring adherence to International Plant Protection Convention (IPPC) diagnostic protocols.

## Command Line Usage

### Basic Analysis
To process one or more sequence files and output results to a TSV file:
```bash
hlso -o result.tsv input.fasta
```

### Handling Multiple Files
If your data consists of multiple files where each file contains a single sequence, use the `--use-file-name` flag to ensure the output uses the filename as the sample identifier instead of the internal sequence header:
```bash
hlso --use-file-name -o result.tsv *.fasta
```

### Input Requirements
- **Data Type**: Sanger sequences.
- **Formats**: FASTA or FASTQ.
- **Primers**: Sequences should be derived from 16S, 16S-23S, or 50S primers as specified in IPPC DP 21.

## Best Practices
- **Sample Naming**: By default, `clsify` infers sample names from read names. If your read names are non-descriptive, ensure your files are named logically and use the `--use-file-name` flag.
- **Reference Alignment**: The tool automatically aligns against EU812559 and EU834131. Ensure your input sequences have sufficient quality and length to meet the sequence identity thresholds required for a positive species identification.
- **Installation**: The tool is most reliably managed via Bioconda using `conda install clsify`.

## Reference documentation
- [Haplotype-LSO GitHub Repository](./references/github_com_holtgrewe_haplotype-lso.md)
- [Bioconda clsify Package Overview](./references/anaconda_org_channels_bioconda_packages_clsify_overview.md)