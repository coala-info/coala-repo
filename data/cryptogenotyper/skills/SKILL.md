---
name: cryptogenotyper
description: CryptoGenotyper is a specialized bioinformatics tool designed for the rapid and reproducible identification of *Cryptosporidium* genotypes.
homepage: https://github.com/phac-nml/CryptoGenotyper
---

# cryptogenotyper

## Overview

CryptoGenotyper is a specialized bioinformatics tool designed for the rapid and reproducible identification of *Cryptosporidium* genotypes. It automates the analysis of DNA sequences—either directly from Sanger electropherogram (.ab1) files or standard FASTA files—targeting the SSU rRNA (18S) and gp60 gene markers. The tool is particularly valuable for resolving complex gp60 subtyping nomenclature and handling poorly-resolved sequencing peaks to provide standard nomenclature outputs.

## CLI Usage and Patterns

The tool requires three primary parameters: the input path, the gene marker, and the sequence orientation.

### Basic Command Structure
```bash
cryptogenotyper -i <INPUT> -m <MARKER> -t <SEQTYPE> -o <PREFIX>
```

### Key Arguments
- `-i, --input`: Path to a single file or a directory containing multiple files.
- `-m, --marker`: Specify either `18S` or `gp60`.
- `-t, --seqtype`: Define the input format:
    - `forward`: Single forward read.
    - `reverse`: Single reverse read.
    - `contig`: Both forward and reverse reads (requires pairing).
- `-f, --forwardprimername`: String used to identify/filter forward reads (e.g., "SSUF").
- `-r, --reverseprimername`: String used to identify/filter reverse reads (e.g., "SSUR").

## Common Workflow Examples

### Analyzing Single Sanger Reads
To process a single .ab1 file for the 18S marker:
```bash
cryptogenotyper -i sample_SSUF.ab1 -m 18S -t forward -f SSUF -o output_report
```

### Batch Processing with Contig Assembly
When you have a directory of paired Sanger files, use the primer flags to help the tool pair the files correctly:
```bash
cryptogenotyper -i ./data_dir/ -m gp60 -t contig -f gp60F -r gp60R -o batch_results
```

### Processing FASTA Sequences
Since v1.5.0, the tool supports FASTA inputs for both markers:
```bash
cryptogenotyper -i sequence.fasta -m gp60 -t forward -o fasta_analysis
```

## Expert Tips and Best Practices

- **Version Sensitivity**: Ensure Biopython is within the `1.70` to `1.77` range. Versions `1.78` and above may cause compatibility issues with the tool's internal logic.
- **File Pairing**: In `contig` mode, the tool uses the strings provided in `-f` and `-r` to find matching pairs in a directory. Ensure your filenames contain these specific substrings to avoid pairing errors.
- **Quality Control**: CryptoGenotyper performs internal quality checks. For 18S markers, it utilizes PHRED scores (when using .ab1 files); sequences with average PHRED scores below 13 are typically excluded from reporting to ensure accuracy.
- **Database Customization**: If you have a proprietary or updated local database of genotypes, use the `-d` flag to point to your custom reference file instead of the default internal database.
- **Nomenclature**: The gp60 module is updated to follow the most recent typing nomenclature (Robinson et al., 2025). Always use the latest version (v1.5.0+) to ensure compliance with current parasitology standards.

## Reference documentation
- [CryptoGenotyper GitHub Repository](./references/github_com_phac-nml_CryptoGenotyper.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cryptogenotyper_overview.md)