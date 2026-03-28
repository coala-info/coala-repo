---
name: virsorter
description: VirSorter identifies viral sequences within microbial genomic datasets by scanning contigs for viral hallmark genes and protein enrichment. Use when user asks to detect prophages in genomic data, identify viral contigs in metagenomes, or run the phage contigs sorter pipeline.
homepage: https://github.com/simroux/VirSorter
---


# virsorter

## Overview
VirSorter is a specialized bioinformatics tool designed to detect viral sequences hidden within microbial genomic datasets. It works by scanning genomic contigs for viral "hallmark" genes and enrichment of viral-like proteins using a combination of HMMER and BLAST/Diamond searches against curated databases. This skill provides the necessary command-line patterns to execute the tool, manage its required databases, and interpret the resulting viral predictions.

## Installation and Database Setup
VirSorter requires a specific environment and a large reference database to function.

### Environment Setup (Conda)
```bash
conda create --name virsorter -c bioconda mcl=14.137 muscle blast perl-bioperl perl-file-which hmmer=3.1b2 perl-parallel-forkmanager perl-list-moreutils diamond=0.9.14 metagene_annotator
source activate virsorter
```

### Database Download
The database must be downloaded and extracted before the first run:
```bash
wget https://zenodo.org/record/1168727/files/virsorter-data-v2.tar.gz
tar -xvzf virsorter-data-v2.tar.gz
```

## Common CLI Patterns

### Standard Run
The primary wrapper script is `wrapper_phage_contigs_sorter_iPlant.pl`.
```bash
wrapper_phage_contigs_sorter_iPlant.pl -f assembly.fasta --db 1 --wdir output_directory --ncpu 4 --data-dir /path/to/virsorter-data-v2
```

### Key Arguments
- `-f`: Input FASTA file containing genomic contigs.
- `--db`: Database choice. Use `1` for the standard RefSeq database or `2` for the Virome database.
- `--wdir`: Working directory for outputs. **Note**: If this directory exists, VirSorter assumes a resumed run; delete it for a fresh start.
- `--ncpu`: Number of processors to use.
- `--data-dir`: Path to the downloaded and unzipped database.
- `--diamond`: Use Diamond instead of BLASTP for faster protein searches.
- `--no_c`: Use a Perl-based enrichment calculation if the default C-script fails on your architecture.

## Interpreting Results
The main output is found in the `output_directory`:

1.  **VIRSorter_global-phage-signal.csv**: The summary table of all viral predictions.
2.  **Predicted_viral_sequences/**: Contains FASTA and GenBank files of the identified viral regions.
3.  **Metrics_files/VIRSorter_affi-contigs.tab**: Detailed annotation of every ORF in the predicted contigs.
    - **Category 0 & 3**: Hallmark viral genes.
    - **Category 1 & 2**: Non-hallmark genes found in Caudovirales or viromes.

## Troubleshooting
- **Empty Results**: If no sequences are predicted despite viral signals being likely, try running with the `--no_c` flag.
- **Step 1 Failed**: This usually occurs if the `--wdir` already exists and contains partial or corrupted data. Delete the directory and restart.
- **Perl Library Mismatch**: In some Conda environments, you may need to manually set `PERL5LIB` to point to the environment's site_perl directory if you see "loadable library and perl binaries are mismatched" errors.



## Subcommands

| Command | Description |
|---------|-------------|
| config | CLI for managing configurations. |
| virsorter run | Runs the virsorter main function to classify viral sequences |
| virsorter setup | Setup databases and install dependencies. |
| virsorter train-model | Training customized classifier model. |
| virsorter_train-feature | Training features for customized classifier. |

## Reference documentation
- [VirSorter GitHub Repository](./references/github_com_simroux_VirSorter.md)