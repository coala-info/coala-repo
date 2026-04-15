---
name: emboss
description: EMBOSS is a comprehensive suite of bioinformatics tools used for sequence analysis, alignment, and format conversion. Use when user asks to retrieve sequences, perform global or local alignments, translate nucleic acids, or find open reading frames.
homepage: http://emboss.open-bio.org/
metadata:
  docker_image: "quay.io/biocontainers/emboss:6.6.0--h0f19ade_14"
---

# emboss

## Overview
EMBOSS (European Molecular Biology Open Software Suite) is a modular collection of open-source tools designed for the molecular biology community. It excels at handling diverse sequence formats and provides specialized applications for tasks ranging from simple sequence retrieval and translation to complex Smith-Waterman alignments and protein property calculations. This skill focuses on the native command-line interface (CLI) patterns and configuration logic required to execute EMBOSS tools efficiently.

## Core CLI Usage Patterns

### Basic Command Structure
Most EMBOSS tools follow a standard parameter pattern:
```bash
application_name -parameter1 value1 -parameter2 value2 -qualifier
```

### Sequence Specification (USA)
EMBOSS uses a Uniform Sequence Address (USA) to identify sequences.
- **Database entry**: `database:entry` (e.g., `swissprot:p12345`)
- **File entry**: `filename:entry` (e.g., `myseqs.fasta:seq1`)
- **All entries in a file**: `filename:*`
- **Standard Input**: `stdin`

### Essential Global Qualifiers
These qualifiers work across almost all EMBOSS applications:
- `-auto`: Turns off interactive prompting; uses default values for any non-specified parameters.
- `-stdout`: Directs the primary output to the terminal instead of a file.
- `-filter`: Reads from standard input and writes to standard output.
- `-options`: Prompts for all optional parameters.
- `-debug`: Generates a `.dbg` file for troubleshooting.

## High-Utility Applications

### Sequence Retrieval and Conversion
- **seqret**: The "Swiss Army knife" for sequences. Use it to change formats or extract specific entries.
  ```bash
  seqret embl:x65923 -outseq fasta::x65923.fasta
  ```
- **prophet**: Gapped alignment profiles.
- **infoseq**: Displays basic information about sequences (length, type, etc.).

### Alignment
- **water**: Performs Smith-Waterman local alignment.
- **needle**: Performs Needleman-Wunsch global alignment.
- **stretcher**: Global alignment for very long sequences.
- **matcher**: Local alignment for identifying similar regions.

### Translation and Nucleic Acids
- **transeq**: Translates nucleic acid sequences to proteins.
- **showfeat**: Displays features of a sequence in a readable format.
- **getorf**: Finds and extracts Open Reading Frames.

## Configuration and Environment

### The .embossrc File
Users can define private databases and global settings in a `.embossrc` file located in their home directory.
- **Database Definition Syntax**:
  ```
  DB embl [
    type: N
    method: direct
    format: embl
    dir: /path/to/data/
    file: *.dat
  ]
  ```

### Environment Variables
- `EMBOSS_AUTO`: Set to `1` to make `-auto` the default behavior.
- `EMBOSS_GRAPHICS`: Defines the default graphics device (e.g., `png`, `x11`, `pdf`).
- `EMBOSS_DATA`: Path to the directory containing EMBOSS data files (REBASE, AAINDEX, etc.).

## Expert Tips
- **Finding Tools**: Use `wossname` to search for applications by keyword (e.g., `wossname alignment`).
- **Handling Short Sequences**: If a short protein sequence is misidentified as nucleic acid, use the `-type P` qualifier to force protein interpretation.
- **Batch Processing**: Combine `seqret` with shell loops or the `-ossingle` qualifier to split a multi-sequence file into individual files.
- **ACD Validation**: If developing new tools or wrappers, use `acvalid` to check the syntax of the Application Control Definition (ACD) file.



## Subcommands

| Command | Description |
|---------|-------------|
| printsextract | Extract fingerprints from PRINTS database |
| transeq | Reads one or more nucleotide sequences and writes the corresponding protein translations. |

## Reference documentation
- [EMBOSS Frequently Asked Questions](./references/emboss_open-bio_org_html_adm_apb.html.md)
- [Post-installation of EMBOSS](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [Installation of CVS (Developers) Release](./references/emboss_open-bio_org_html_dev_ch01s02.html.md)
- [EMBOSS Applications (release R6)](./references/emboss_open-bio_org_html_use_apbs04.html.md)