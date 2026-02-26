---
name: emboss-explorer
description: EMBOSS is a comprehensive suite of bioinformatics tools for sequence analysis, alignment, and database searching. Use when user asks to align sequences, search databases, identify protein motifs, analyze nucleic acids, or perform restriction mapping.
homepage: http://emboss.open-bio.org/
---


# emboss-explorer

## Overview
EMBOSS is a comprehensive, open-source suite of over 200 command-line applications designed for molecular biology and bioinformatics. It provides a unified interface for tasks such as sequence alignment, database searching, protein motif identification, and nucleic acid analysis. This skill enables efficient interaction with the suite by leveraging its consistent command-line syntax, automatic format detection, and powerful sequence addressing system.

## Usage Instructions

### 1. Environment Verification
Before running analysis, ensure the EMBOSS environment is correctly configured.
- **Check Version**: Run `embossversion` to verify the installation and current version (e.g., 6.6.0).
- **Pathing**: Ensure the EMBOSS binaries (typically in `/usr/local/emboss/bin` or a conda path) are in your `PATH`.
- **Data Files**: If using restriction mapping or motif tools, ensure data files are initialized using extraction tools:
  - `rebaseextract` (Restriction enzymes)
  - `aaindexextract` (Amino acid indices)
  - `prosextract` (PROSITE patterns)

### 2. Command Line Syntax
All EMBOSS tools follow a consistent AJAX Command Definition (ACD) pattern.
- **Standard Pattern**: `toolname -parameter1 value1 -parameter2 value2`
- **Validation**: EMBOSS automatically validates inputs against the tool's ACD file. If a required parameter is missing, the tool will prompt for it interactively.
- **Help**: Use the `-help` global qualifier with any tool to see available parameters and descriptions.

### 3. Uniform Sequence Address (USA)
The USA is the standard way to specify sequence inputs. It allows you to point to files, database entries, or specific sequences within a multi-sequence file.
- **Syntax**: `format::path/to/file:entryname`
- **Examples**:
  - `fasta::myseq.fa` (Specific format and file)
  - `sw:pep_human` (Entry from a defined database)
  - `asis::atgc...` (Raw sequence string)
- **Automatic Detection**: EMBOSS can usually detect the format automatically if the prefix is omitted, but specifying it (e.g., `genbank::file.gb`) improves efficiency.

### 4. Handling File Formats
EMBOSS is format-agnostic and can read/write most common bioinformatics formats (FASTA, GenBank, EMBL, GCG, etc.).
- **Input**: Use the `-sformat` qualifier to force an input format if auto-detection fails.
- **Output**: Use the `-osformat` qualifier to specify the output format for sequences.
- **Reports**: Many tools produce report files. Use `-rformat` to change the report style (e.g., `excel`, `table`, `gff`).

### 5. Global Qualifiers
These qualifiers work across almost all EMBOSS applications:
- `-auto`: Turns off interactive prompting; uses defaults for any non-specified required parameters.
- `-stdout`: Directs the primary output to the standard output stream.
- `-filter`: Allows the tool to act as a UNIX pipe (reads from stdin, writes to stdout).
- `-options`: Prompts for all optional parameters, not just required ones.

### 6. Tool Discovery
If the specific tool name is unknown, use the following logic based on the suite's organization:
- **Groups**: Tools are organized by function (e.g., EDIT, ALIGNMENT, NUCLEIC, PROTEIN).
- **Documentation**: Refer to the "EMBOSS Apps A-Z" or functional groups to identify the correct utility for a specific biological question.

## Reference documentation
- [EMBOSS Key Features](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [Post-installation and Data Setup](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [Introduction to EMBOSS](./references/emboss_open-bio_org_html_use_pr02s01.html.md)
- [EMBOSS Homepage Overview](./references/emboss_open-bio_org_index.md)