---
name: protk
description: Protk is a Ruby-based suite of tools that provides a consistent command-line interface for managing proteomics workflows and third-party search engines. Use when user asks to run MS/MS searches, perform protein inference, manage protein databases, or convert proteomics data formats.
homepage: https://github.com/iracooke/protk
---


# protk

## Overview

Protk (Proteomics Toolkit) is a Ruby-based suite of tools designed to provide a consistent command-line interface for disparate third-party proteomics software. It streamlines the transition between mass spectrometry search results and downstream statistical inference. Use this skill to automate proteomics pipelines, manage protein databases, and handle format conversions without needing to learn the specific CLI syntax of every underlying tool.

## Core Workflows and CLI Patterns

### 1. Environment Setup
Before running searches, ensure third-party dependencies are installed. Protk manages these in a local directory (defaulting to `~/.protk`).

- **Install dependencies**: `protk_setup.rb [tool_name]`
  - Supported tools: `tpp`, `omssa`, `blast`, `msgfplus`, `pwiz`.
- **Custom Install Path**: Set the `PROTK_INSTALL_DIR` environment variable to change where tools and databases are stored.

### 2. MS/MS Search Execution
Protk wraps several search engines. Running any command without arguments displays its specific help menu.

- **X!Tandem**: `tandem_search.rb [options] <input_file>`
- **MS-GF+**: `msgfplus_search.rb [options] <input_file>`
- **Mascot**: `mascot_search.rb [options] <input_file>` (Requires a configured Mascot server).
- **OMSSA**: `omssa_search.rb [options] <input_file>`

### 3. Inference and Validation
After searching, use the TPP-based tools for statistical validation.

- **Peptide Prophet**: `peptide_prophet.rb <input.pepXML>` (Calculates peptide probabilities).
- **iProphet**: `interprophet.rb <input1.pepXML> <input2.pepXML> ...` (Combines results from multiple search engines).
- **Protein Prophet**: `protein_prophet.rb <input.pepXML>` (Performs protein-level inference).

### 4. Data Conversion and Export
Protk excels at turning complex XML outputs into human-readable or genome-mapped formats.

- **To Tabular**: 
  - `pepxml_to_table.rb <file.pepXML>`
  - `protxml_to_table.rb <file.protXML>`
- **To Genomic Coordinates (GFF)**:
  - `protxml_to_gff.rb [options] <file.protXML>` (Useful for proteogenomics).
- **Raw Search Output to pepXML**:
  - `mascot_to_pepxml.rb <file.dat>`
  - `tandem_to_pepxml.rb <file.tandem>`

### 5. Database and Sequence Utilities
- **Manage Databases**: `manage_db.rb` is used to download and format protein databases (e.g., UniProt).
- **Decoy Generation**: `make_decoy.rb <input.fasta>` creates semi-random decoy sequences for FDR estimation.
- **Six-Frame Translation**: `sixframe.rb <input.fasta>` generates translations of DNA sequences for proteogenomic searches.

## Expert Tips

- **Tool Discovery**: If you have third-party tools installed manually, Protk will fallback to using them if they are in your `$PATH`, even if they weren't installed via `protk_setup.rb`.
- **Ruby Version**: Ensure Ruby 2.0 or higher is used. Avoid Ruby 2.1.5 specifically due to known deadlocking bugs with child processes.
- **Libxml2**: On macOS, if installation fails, ensure `libxml2` is linked correctly via homebrew before installing the gem.



## Subcommands

| Command | Description |
|---------|-------------|
| interprophet.rb | Run InterProphet on a set of pep.xml input files. |
| mascot_search.rb | Run a Mascot msms search on a set of mgf input files. |
| msgfplus_search.rb | Run an MSGFPlus msms search on a set of msms spectrum input files. |
| peptide_prophet.rb | Run PeptideProphet on a set of pep.xml input files. |
| protein_prophet.rb | Run ProteinProphet on a set of pep.xml input files. |
| protk_make_decoy.rb | Create a decoy database from real protein sequences. |
| protk_manage_db.rb | Manage named protein databases. |
| protk_pepxml_to_table.rb | Convert a pepXML file to a tab delimited table. |
| protk_setup.rb | Post install tasks for protk. |
| protk_sixframe.rb | Create a sixframe translation of a genome. |
| protxml_to_gff.rb | Map proteins and peptides to genomic coordinates. |
| protxml_to_table.rb | Convert a protXML file to a tab delimited table. |
| tandem_search.rb | Run an X!Tandem msms search on a set of mzML input files. |

## Reference documentation
- [Proteomics Toolkit in Ruby](./references/github_com_iracooke_protk.md)