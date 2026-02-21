---
name: ectyper
description: The ectyper tool is a specialized bioinformatic module designed for the rapid characterization of *Escherichia coli*.
homepage: https://github.com/phac-nml/ecoli_serotyping
---

# ectyper

## Overview
The ectyper tool is a specialized bioinformatic module designed for the rapid characterization of *Escherichia coli*. It performs three primary functions: species identification, serotyping (identifying O and H antigens), and pathotyping (including Shiga toxin subtyping). It is highly versatile, accepting both raw sequencing reads (Fastq) and assembled genomes (Fasta). This skill provides the necessary command-line patterns to execute these analyses efficiently, whether dealing with single isolates or large-scale genomic datasets.

## Basic Usage
The core command requires an input file or directory and an output directory.

```bash
# Analyze a single assembly
ectyper -i genome.fasta -o output_dir

# Analyze raw reads (Fastq)
ectyper -i reads.fastq -o output_dir
```

## Common CLI Patterns

### Batch Processing
Ectyper can handle multiple inputs in several ways:
- **Directory scan**: `ectyper -i /path/to/genomes/ -o batch_results`
- **Comma-separated list**: `ectyper -i sample1.fasta,sample2.fasta -o results`
- **Space-separated list**: `ectyper -i sample1.fasta sample2.fasta -o results`
- **Wildcards**: `ectyper -i "data/*.fasta" -o results`

### Working with Raw Reads
When using raw sequencing data, ensure you use the appropriate flags for the platform:
- **Long Reads**: For Oxford Nanopore (ONT) or PacBio data, always include the `--longreads` flag to adjust mapping parameters for better results.
- **Paired-end Reads**: Concatenate paired-end files if you want them treated as a single entity before running the tool.

### Performance and Tuning
- **Parallelization**: Use `-c` or `--cores` to specify the number of CPU cores.
- **Identity Thresholds**: The default identity for O and H antigen matches is 95%. Adjust these using `-opid` (O-antigen) and `-hpid` (H-antigen) if working with highly divergent samples.
- **Coverage Thresholds**: Use `-opcov` and `-hpcov` to set minimum coverage requirements for antigen calls.

## Expert Tips
- **Species Verification**: Use the `--verify` flag to run the pathotype module even on samples that might not be strictly identified as *E. coli*. This is useful for investigating closely related *Shigella* species or atypical isolates.
- **Output Analysis**: The primary results are stored in `output.csv` within your specified output directory. If no output directory is specified, ectyper creates one using the `ectyper_<date>_<time>` pattern.
- **Database Management**: Ectyper relies on specific JSON databases for alleles and toxins. If you need to use a custom or updated database, use the `--dbpath` flag to point to the directory containing `ectyper_alleles_db.json` and `ectyper_patho_stx_toxin_typing_database.json`.

## Reference documentation
- [ECTyper GitHub Repository](./references/github_com_phac-nml_ecoli_serotyping.md)
- [ECTyper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ectyper_overview.md)