---
name: marvd2
description: The Metagenomic Archaeal Virus Detector 2 (marvd2) is a specialized bioinformatics tool for the identification of archaeal viruses within metagenomic datasets.
homepage: https://bitbucket.org/MAVERICLab/marvd2
---

# marvd2

## Overview
The Metagenomic Archaeal Virus Detector 2 (marvd2) is a specialized bioinformatics tool for the identification of archaeal viruses within metagenomic datasets. Unlike general viral detectors, marvd2 focuses on the unique genomic signatures of viruses that infect Archaea. It processes genomic scaffolds to distinguish viral sequences from host DNA and provides classification based on known archaeal viral families.

## Usage Patterns

### Basic Identification
To run the standard detection pipeline on a set of scaffolds:
```bash
marvd2 -i input_scaffolds.fasta -o output_directory
```

### Core Parameters
- `-i, --input`: Path to the input FASTA file containing metagenomic scaffolds or contigs.
- `-o, --outdir`: Directory where results, including identified viral sequences and summary tables, will be stored.
- `-t, --threads`: Number of CPU threads to use for parallel processing (e.g., `-t 8`).

### Interpreting Results
The tool generates several key files in the output directory:
- `marvd_summary.tsv`: A tabular summary of all identified viral sequences, including their predicted taxonomy and confidence scores.
- `viral_sequences.fasta`: The nucleotide sequences of the scaffolds identified as archaeal viruses.
- `functional_annotation.tsv`: Predicted gene functions for the identified viral contigs.

## Best Practices
- **Minimum Contig Length**: For reliable detection, ensure input scaffolds are at least 1.5kb to 2kb. Shorter sequences often lack sufficient genomic context for accurate classification.
- **Preprocessing**: Remove low-quality reads and perform assembly before running marvd2. The tool performs best on assembled contigs rather than raw reads.
- **Resource Allocation**: marvd2 can be computationally intensive during the protein search phase; always specify the `-t` flag to match your available hardware resources.
- **Taxonomic Context**: Use the output in conjunction with host prediction tools to link identified viruses to specific archaeal hosts within your metagenome.

## Reference documentation
- [marvd2 Bitbucket Repository](./references/bitbucket_org_MAVERICLab_marvd2.md)
- [Bioconda marvd2 Overview](./references/anaconda_org_channels_bioconda_packages_marvd2_overview.md)