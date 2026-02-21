---
name: gfflu
description: The `gfflu` tool is a specialized Python CLI application designed for the rapid annotation of Influenza A virus (IAV) gene segments.
homepage: https://github.com/CFIA-NCFAD/gfflu
---

# gfflu

## Overview
The `gfflu` tool is a specialized Python CLI application designed for the rapid annotation of Influenza A virus (IAV) gene segments. It leverages BLASTX and Miniprot to map protein sequences—consistent with the Influenza Virus Sequence Annotation Tool—onto nucleotide sequences. It is particularly useful for researchers who need to generate GFF3 files that are pre-configured for downstream analysis with SnpEff, ensuring that the top-scoring annotations for each of the eight IAV segments are correctly captured.

## Usage Patterns

### Basic Annotation
To annotate a single IAV segment FASTA file and generate the default output directory:
```bash
gfflu segment_sequence.fasta
```

### Customizing Output
By default, the tool creates a directory named `gfflu-outdir/`. You can specify a custom location and file prefix for better organization:
```bash
gfflu segment_sequence.fasta --outdir ./results/segment_1 --prefix IAV_S1
```

### Common Options
- `--force` / `-f`: Overwrite the output directory if it already exists.
- `--verbose` / `-v`: Enable detailed logging of the annotation process.
- `--version` / `-V`: Check the current version (e.g., 0.0.2).

## Output Files
Upon successful execution, the tool produces several files in the output directory:
- `.gff`: The primary SnpEff-compatible GFF3 annotation file.
- `.faa`: FASTA file containing translated protein sequences.
- `.gbk`: GenBank formatted file.
- `.miniprot.gff`: Raw output from the Miniprot alignment.
- `.blastx.tsv`: Tab-separated BLASTX results.

## Expert Tips
- **SnpEff Compatibility**: The GFF3 output is specifically formatted to work with SnpEff. If you are building a custom SnpEff database for IAV, use the `.gff` file produced by this tool.
- **Installation**: The recommended way to manage dependencies (like BLAST+ and Miniprot) is via Conda: `conda install -c bioconda gfflu`.
- **Input Requirements**: Ensure your input FASTA contains Influenza A virus segments. While the tool is robust, it is optimized for the standard 8-segment IAV genome.

## Reference documentation
- [gfflu GitHub Repository](./references/github_com_CFIA-NCFAD_gfflu.md)
- [Bioconda gfflu Package](./references/anaconda_org_channels_bioconda_packages_gfflu_overview.md)