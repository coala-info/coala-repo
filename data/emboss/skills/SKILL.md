---
name: emboss
description: EMBOSS is a comprehensive suite of bioinformatics tools for analyzing DNA and protein sequences, searching databases, and performing sequence alignments. Use when user asks to convert sequence formats, translate nucleic acids to proteins, process restriction enzyme data, or manipulate molecular biology data using a consistent command-line interface.
homepage: http://emboss.open-bio.org/
---


# emboss

## Overview

EMBOSS (European Molecular Biology Open Software Suite) is a comprehensive collection of over 200 bioinformatics tools designed to handle a wide array of molecular biology tasks. It provides a consistent command-line interface for analyzing DNA and protein sequences, searching databases, and performing complex alignments. Use this skill to leverage EMBOSS's robust handling of diverse file formats and its "Uniform Sequence Address" (USA) system, which allows for seamless data integration across different applications.

## Core CLI Usage

Every EMBOSS application follows a consistent command-line structure:
`application_name -parameter1 value1 -parameter2 value2 ...`

### Uniform Sequence Address (USA)
The USA is the standard way to specify sequence inputs. It avoids the need for manual file path management:
- **File**: `filename` or `format::filename`
- **Database entry**: `database:entry`
- **Specific sequence in a file**: `file:entry`
- **Standard input**: `stdin`

### Essential Global Qualifiers
These qualifiers work across almost all EMBOSS programs to control behavior:
- `-auto`: Turns off interactive prompting; uses default values for any unspecified required parameters.
- `-stdout`: Forces output to be written to the standard output stream.
- `-filter`: Allows the program to act as a UNIX filter (reads from stdin, writes to stdout).
- `-options`: Displays all parameters, including optional ones, when prompting.
- `-help`: Displays a brief help text and exits.

## Common Workflows

### 1. Installation and Verification
The most efficient way to install EMBOSS is via Bioconda:
```bash
conda install bioconda::emboss
embossversion
```

### 2. Data Preparation
Many EMBOSS applications require external data files (like REBASE or PROSITE). Use the extraction tools to set these up:
- `rebaseextract`: Process restriction enzyme data.
- `prosextract`: Process PROSITE motif data.
- `printsextract`: Process PRINTS fingerprint data.

### 3. Sequence Manipulation
- **Format Conversion**: Use `seqret` to read a sequence in one format and write it in another.
  `seqret -sequence input.fasta -outseq output.gcg`
- **Translation**: Use `transeq` to translate nucleic acid sequences to proteins.
  `transeq -sequence dna.fasta -outseq protein.fasta`

## Expert Tips
- **ACD Files**: EMBOSS uses Ajax Command Definition (ACD) files to define parameters. If an application behaves unexpectedly, check the `.acd` file in the EMBOSS distribution to understand the validation logic.
- **Environment Variables**: Set `EMBOSS_DATA` to point to the directory containing your data files if they are not in the default installation path.
- **Memory Management**: EMBOSS has no arbitrary sequence length limits; it allocates memory dynamically based on the input size. If you encounter memory errors, ensure your system's swap space or RAM is sufficient for the specific dataset.

## Reference documentation
- [EMBOSS Overview](./references/anaconda_org_channels_bioconda_packages_emboss_overview.md)
- [Key Features](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [Post-installation and Data Setup](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [EMBOSS Introduction](./references/emboss_open-bio_org_html_use_pr01s01.html.md)