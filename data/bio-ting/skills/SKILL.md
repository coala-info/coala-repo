---
name: bio-ting
description: The `bio-ting` skill facilitates the use of the **T cell receptor interaction grouping (ting)** tool.
homepage: https://github.com/FelixMoelder/ting
---

# bio-ting

## Overview

The `bio-ting` skill facilitates the use of the **T cell receptor interaction grouping (ting)** tool. This tool is specifically designed to handle large-scale TCR repertoire data, clustering sequences that likely share antigen specificity. It employs a dual approach: local clustering based on significantly enriched k-mers (using Fisher's exact test against a reference set) and global clustering based on sequence similarity. Use this skill when you need to identify functional groups within immunosequencing data or discover significant motifs in CDR3b sequences.

## Command Line Usage

The primary command for the tool is `ting`.

### Basic Syntax
```bash
ting --tcr_sequences sample.tsv --reference reference.fasta --kmer_file kmers.tsv -o output.tsv
```

### Required Arguments
- `-t, --tcr_sequences`: A tab-separated file containing TCR sequences. The tool expects the CDR3b sequences in the first column.
- `-r, --reference`: A FASTA file containing naive CDR3 amino acid sequences used as a control set for statistical enrichment.
- `-k, --kmer_file`: A file to store or read 2-, 3-, and 4-mers. If the file does not exist, `ting` will generate it automatically.
- `-o`: The path for the output results file.

### Common CLI Patterns

**Strict CDR3 Filtering**
To ensure only valid CDR3 regions (starting with Cysteine and ending with Phenylalanine per IMGT definition) are analyzed:
```bash
ting -t sample.tsv -r ref.fasta -k kmers.tsv -o out.tsv --stringent_filtering
```

**Adjusting Motif Significance**
To change the sensitivity of the local clustering, adjust the p-value threshold:
```bash
ting -t sample.tsv -r ref.fasta -k kmers.tsv -o out.tsv --max_p_value 0.01
```

**Disabling Clustering Modes**
If only one type of clustering is required, you can skip the other to save time:
- Skip global similarity clustering: `--no_global`
- Skip local k-mer clustering: `--no_local`

## Expert Tips and Best Practices

- **K-mer Reuse**: The k-mer generation process can be computationally intensive. Once a `.tsv` k-mer file is generated for a specific sample, reuse that file in subsequent runs to significantly speed up analysis.
- **Reference Selection**: The quality of the clustering depends heavily on the reference file. Use a reference set that represents a diverse, naive repertoire to ensure that the Fisher's exact test correctly identifies antigen-driven enrichment rather than common germline motifs.
- **Structural Boundaries**: By default, `ting` excludes the first and last three amino acids of the CDR3 sequence as they are often conserved and less involved in antigen contact. Use `--use_structural_boundaries` only if you have specific reason to believe these regions are relevant to your clustering logic.
- **Input Formatting**: While `ting` supports the GLIPH-style tab-separated format, it primarily looks at the first column. Ensure your input file is strictly tab-delimited to avoid parsing errors.

## Reference documentation
- [ting - T cell receptor interaction grouping](./references/github_com_FelixMoelder_ting.md)
- [bio-ting - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bio-ting_overview.md)