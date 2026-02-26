---
name: ebolaseq
description: ebolaseq is a bioinformatics pipeline that automates the retrieval of Ebola virus sequences from GenBank, performs multiple sequence alignment, and generates phylogenetic trees. Use when user asks to fetch Ebola genomic data, perform sequence alignment, generate phylogenetic trees, or compare local consensus sequences against GenBank records.
homepage: https://github.com/DaanJansen94/ebolaseq
---


# ebolaseq

## Overview

`ebolaseq` is a specialized bioinformatics pipeline designed to streamline the analysis of Ebola virus (EBOV) genomic data. It handles the end-to-end process of fetching sequences from GenBank based on user-defined filters—such as species, host, and genome completeness—performing multiple sequence alignment (MSA), and generating phylogenetic trees. It is particularly useful for researchers needing standardized, reproducible workflows for Ebola outbreak tracking or comparative genomics without manually managing intermediate files and tool chains.

## Usage Patterns

### Interactive Mode
For most local tasks, run the tool with only the output directory specified. The tool will prompt you for species selection, host filters, and analysis parameters.

```bash
ebolaseq --output-dir ./ebola_analysis
```

### Non-Interactive (HPC) Mode
For automated pipelines or cluster submissions, provide all parameters as flags to bypass interactive prompts.

```bash
ebolaseq --output-dir ./ebola_analysis \
  --virus 1 \
  --genome 1 \
  --host 1 \
  --metadata 3 \
  --beast 2 \
  --phylogeny
```

### Parameter Mapping for Non-Interactive Mode
When using the non-interactive flags, use the following integer mappings:

*   **--virus**: 1 (Zaire), 2 (Sudan), 3 (Bundibugyo), 4 (Tai Forest), 5 (Reston)
*   **--genome**: 1 (Complete), 2 (Partial - requires `--completeness`), 3 (All)
*   **--host**: 1 (Human), 2 (Non-human), 3 (All)
*   **--metadata**: 1 (Location), 2 (Date), 3 (Both), 4 (None)
*   **--beast**: 1 (No), 2 (Yes) - Required if metadata is 2 or 3.

## Expert Tips and Best Practices

### Data Quality Control
**Always use a removal list.** It is a best practice in Ebola phylogenetics to exclude sequences that do not represent natural viral diversity. Create a `remove.txt` file containing one GenBank accession per line for:
*   Cell culture passages
*   Laboratory-adapted strains
*   Artificially modified or experimental infection sequences

Run with:
```bash
ebolaseq --output-dir analysis --remove remove.txt --phylogeny
```

### Phylogenetic Rooting
When analyzing **Zaire ebolavirus**, it is recommended to root the resulting phylogenetic tree using sequences from the **1976 Yambuku outbreak**. This represents the first documented outbreak and provides the most accurate evolutionary context for the lineage.

### Integrating Local Sequences
To compare your own newly sequenced consensus genomes against the GenBank database, use the `--consensus-file` flag:
```bash
ebolaseq --output-dir analysis --consensus-file my_new_isolate.fasta --phylogeny
```

### Dependencies
Ensure the following tools are in your PATH (typically handled via the Conda environment):
*   **MAFFT**: For sequence alignment.
*   **TrimAl**: For alignment trimming.
*   **IQTree2**: For maximum likelihood phylogenetic inference.

## Reference documentation
- [ebolaseq Overview](./references/anaconda_org_channels_bioconda_packages_ebolaseq_overview.md)
- [ebolaseq GitHub Documentation](./references/github_com_DaanJansen94_ebolaseq.md)