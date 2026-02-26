---
name: peekseq
description: peekseq uses a k-mer approach to calculate the protein-coding potential of nucleotide sequences and identify likely peptide-encoding regions. Use when user asks to predict coding regions in intronless sequences, evaluate the coding potential of bacterial or viral genomes, or translate nucleotide sequences into proteins using specific genetic code tables.
homepage: https://github.com/bcgsc/peekseq
---


# peekseq

## Overview

peekseq is a Perl-based tool that utilizes a k-mer approach to calculate the protein-coding potential of nucleotide sequences. Unlike traditional gene finders that rely on complex hidden Markov models or specific organism training, peekseq systematically processes k-mers to identify regions likely to encode peptides. It is most effective for evaluating sequences where splicing (introns) is absent, such as bacterial genomes or viral sequences like SARS-CoV-2.

## Command Line Usage

The primary interface is the `peekseq.pl` script.

### Basic Syntax
```bash
./peekseq.pl -f <input.fasta> [options]
```

### Core Arguments
- `-f FASTA`: Path to the input DNA/RNA file (Single or Multi-FASTA).
- `-k INT`: Nucleotide k-mer length (default: 90). Adjusting this affects the resolution of the coding potential scan.
- `-c INT`: Genetic code translation table ID (default: 1). This is critical for non-standard genomes (e.g., use `2` for Vertebrate Mitochondrial, `11` for Bacterial/Archaeal).
- `-s INT`: Minimum region size in base pairs to include in the output (default: 270).
- `-v 1|0`: Set to `1` to generate a TSV file containing raw coding potential data for all 6 frames, useful for downstream visualization.

### Common Workflow Examples

**1. Analyzing a Bacterial Genome**
To scan a bacterial sequence using the appropriate translation table (11) and a custom k-mer length:
```bash
./peekseq.pl -f bacteria.fa -k 120 -c 11 -s 300 -v 1
```

**2. Surveying a Mitogenome**
For mitochondrial DNA (often using table 2 or 5 depending on the taxa):
```bash
./peekseq.pl -f mito.fa -c 2 -s 200
```

## Output Interpretation

peekseq generates several files based on the input filename and parameters:

1.  **`*-codingDNA.fa`**: Contains the nucleotide sequences of predicted coding regions. Bases outside the initiation codon are soft-masked (lowercase).
2.  **`*-codingPROTEIN.fa`**: Contains the corresponding protein translations. Residues outside the initiation amino acid are soft-masked.
3.  **`*-frameKmers.tsv`**: (Only with `-v 1`) A tab-separated file mapping genomic positions to frames and coding status (1 or -1 for plus/minus strands, 0 for non-coding).
4.  **`.log`**: A record of the execution progress and parameters used.

## Expert Tips and Best Practices

- **Organism Selection**: Do not use peekseq for complex eukaryotic nuclear genomes where intron/exon boundaries are present, as it does not predict splicing.
- **Translation Tables**: Always verify the correct NCBI genetic code ID for your organism. Using the default (Standard Code) on mitochondrial data will result in incorrect coding predictions.
- **Sensitivity Tuning**: If you are looking for small peptides or sORFs, decrease the `-s` (minimum size) and `-k` (k-mer length) parameters.
- **Visualization**: The TSV output is designed for `ggplot2`. A value of `1` in the coding column indicates plus-strand coding potential, while `-1` indicates minus-strand potential.
- **Soft-masking**: When processing the output FASTA files for further analysis, remember that lowercase letters indicate regions the algorithm considers "outside" the core initiation-to-stop boundary but still part of the identified region.

## Reference documentation
- [peekseq GitHub Repository](./references/github_com_bcgsc_peekseq.md)
- [peekseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_peekseq_overview.md)