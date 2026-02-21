---
name: ampliconsplitter
description: AmpliconSplitter is a specialized tool for resolving "collapsed" amplicons in metagenomic or multi-variant samples.
homepage: https://github.com/RolandFaure/AmpliconSplitter
---

# ampliconsplitter

## Overview
AmpliconSplitter is a specialized tool for resolving "collapsed" amplicons in metagenomic or multi-variant samples. Many assemblers fail to distinguish between sequences with 95-96% similarity, merging them into a single consensus. This tool uses the original long reads and a reference assembly to identify correlating SNPs and "unzip" these sequences into their constituent amplicons. It is based on the HairSplitter algorithm and is particularly effective for Oxford Nanopore Technologies (ONT) data.

## Basic Usage
The core workflow requires your original sequencing reads and the collapsed reference sequence.

```bash
python ampliconsplitter.py -f reads.fastq -r collapsed_amplicons.fa -o output_directory/
```

The primary output will be located at `output_directory/ampliconsplitter_final_amplicons.fa`.

## Command Line Options
- `-r, --ref`: Reference amplicon(s) to separate (FASTA or GFA format).
- `-f, --fastq`: Original sequencing reads (FASTQ or FASTA).
- `-p, --polisher`: Choose between `racon` (default, faster) or `medaka` (slower, higher accuracy).
- `-t, --threads`: Number of threads to use (default: 1).
- `-u, --rescue_snps`: SNP frequency threshold. SNPs shared by this proportion of reads are automatically considered true variants (default: 0.33).
- `-q, --min-read-quality`: Filter out reads with average quality below this threshold (default: 0).
- `--resume`: Resume a previously interrupted run using the same output directory.
- `-l, --low-memory`: Enable low-memory mode at the cost of processing speed.
- `-F, --force`: Overwrite the output folder if it already exists.

## Expert Tips and Best Practices
- **Polishing Selection**: Use `-p medaka` for final publication-quality sequences, but ensure Medaka is installed in your environment as it is a heavy dependency. For quick iterations, stick with the default `racon`.
- **Handling High Diversity**: If you suspect very low-frequency variants are being missed, try lowering the `-u` (rescue_snps) parameter below 0.33. Conversely, if you are getting too many false positives due to noise, increase this value.
- **Memory Constraints**: On shared clusters or machines with limited RAM, always use the `-l` flag. The tool also attempts to minimize SAM file size by stripping sequences and qualities during processing.
- **Dependency Paths**: If tools like `minimap2`, `samtools`, or `racon` are not in your system PATH, use the explicit path flags:
  - `--path_to_minimap2`
  - `--path_to_racon`
  - `--path_to_medaka`
  - `--path_to_samtools`
- **Input Formats**: The tool accepts both FASTA and GFA for the reference. If your assembler produced a graph (GFA), providing it directly can sometimes help the tool understand the assembly context better than a flattened FASTA.

## Reference documentation
- [AmpliconSplitter Overview](./references/anaconda_org_channels_bioconda_packages_ampliconsplitter_overview.md)
- [AmpliconSplitter GitHub Repository](./references/github_com_RolandFaure_AmpliconSplitter.md)