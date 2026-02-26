---
name: lemur
description: Lemur is a command-line tool that performs rapid taxonomic profiling and abundance estimation for long-read metagenomics data using marker gene databases and an EM algorithm. Use when user asks to profile the taxonomic composition of metagenomic samples, estimate relative abundance of organisms from long reads, or map reads to marker gene databases.
homepage: https://github.com/treangenlab/lemur
---


# lemur

## Overview
Lemur is a command-line tool optimized for long-read metagenomics that provides rapid taxonomic profiling. It maps reads to marker gene databases and uses an Expectation-Maximization (EM) algorithm to infer the relative abundance of organisms in a sample. It is specifically designed to handle the unique characteristics of long-read data, such as higher error rates and varying read lengths, providing both aggregated abundance tables and individual read-to-taxon probabilities.

## Installation and Setup
Install lemur via bioconda or by placing the executable in the system path.
```bash
conda install -c bioconda lemur
```
Ensure you have downloaded the required marker gene database (e.g., RefSeq bacterial/archaeal/fungal genes) and the corresponding taxonomy TSV file before running the analysis.

## Core Workflow
To perform a standard taxonomic profile, provide the input reads, output directory, database prefix, taxonomy path, and target rank.

```bash
lemur -i input.fastq \
      -o output_dir \
      -d /path/to/db_prefix \
      --tax-path /path/to/taxonomy.tsv \
      -r species
```

### Key Parameters
- `-i, --input`: Input FASTQ file.
- `-o, --output`: Directory for results.
- `-d, --db-prefix`: Path to the marker gene database folder.
- `--tax-path`: Path to the `taxonomy.tsv` file associated with the database.
- `-r, --rank`: The taxonomic level for aggregation (e.g., `species`, `genus`, `family`).
- `-t, --num-threads`: Set the number of CPU threads for parallel processing.

## Advanced Configuration and Best Practices

### Optimizing for Sequencing Technology
Adjust the alignment parameters based on the sequencing platform using the `--mm2-type` flag:
- **Oxford Nanopore**: `--mm2-type map-ont` (Default)
- **PacBio HiFi**: `--mm2-type map-hifi`
- **PacBio CLR**: `--mm2-type map-pb`
- **Short Reads**: `--mm2-type sr`

### Handling Low-Quality or Short Reads
If the analysis fails with a `ZeroDivisionError` or produces empty results, it often indicates that the default alignment filters are too stringent.
- **Default Filter**: Lemur removes alignments shorter than 75% of the marker gene length (`--min-aln-len-ratio 0.75`).
- **Adjustment**: For samples with shorter fragments or lower quality, reduce this ratio to retain more alignments:
  ```bash
  lemur -i input.fastq ... --min-aln-len-ratio 0.10
  ```

### Scoring Methods
The `--aln-score` flag determines how alignments are weighted:
- `AS`: Uses the SAM Alignment Score (AS) tag (Recommended for most cases).
- `edit`: Uses an edit-distance based distribution.
- `markov`: Scores the CIGAR string as a Markov chain.

### Output Interpretation
- `relative_abundance.tsv`: Contains raw taxonomic IDs, lineage info, and inferred abundance (Column F).
- `relative_abundance-[rank].tsv`: The final profile aggregated at your specified rank.
- `P_rgs_df_raw.tsv`: Useful for debugging; contains raw alignment info before filters are applied.

## Reference documentation
- [Lemur GitHub Repository](./references/github_com_treangenlab_lemur.md)
- [Bioconda Lemur Overview](./references/anaconda_org_channels_bioconda_packages_lemur_overview.md)