---
name: embassy-phylip
description: The `embassy-phylip` skill provides a specialized interface for the PHYLIP (Phylogeny Inference Package) as implemented within the EMBOSS (European Molecular Biology Open Software Suite) framework.
homepage: http://emboss.open-bio.org/
---

# embassy-phylip

## Overview

The `embassy-phylip` skill provides a specialized interface for the PHYLIP (Phylogeny Inference Package) as implemented within the EMBOSS (European Molecular Biology Open Software Suite) framework. It transforms the traditional interactive PHYLIP programs into non-interactive, command-line-driven tools that follow the consistent EMBOSS syntax. This integration allows for seamless inclusion of phylogenetic steps into bioinformatics pipelines, benefiting from EMBOSS's robust automatic file format detection and standardized handling of molecular sequence data.

## Command Line Usage Patterns

All tools within the `embassy-phylip` package follow the standard EMBOSS execution pattern. Programs are typically prefixed with the letter 'f' to distinguish them as the EMBASSY-phylip versions of the original PHYLIP tools.

### Standard Syntax
```bash
fprogramname -parameter1 value1 -parameter2 value2 ...
```

### Common Global Qualifiers
These qualifiers can be applied to any `embassy-phylip` command to control behavior:
- `-auto`: Bypasses all user prompts and uses default values for any non-specified parameters. Essential for scripting.
- `-stdout`: Directs the primary output to the terminal screen instead of a file.
- `-filter`: Allows the program to act as a UNIX filter, reading from standard input and writing to standard output.
- `-help`: Displays all available parameters, including optional ones and their descriptions.

### Data Input (USA Syntax)
Instead of simple filenames, use the Uniform Sequence Address (USA) to specify inputs precisely:
- `filename`: Standard file in the current directory.
- `format::filename`: Forces a specific format (e.g., `fasta::myseq.txt`).
- `filename:entryname`: Selects a specific sequence from a multi-sequence file.
- `@listfile`: Processes all sequences listed in a text file.

## Functional Categories

The suite covers several phylogenetic methodologies:
1.  **Distance Matrix Methods**: Tools for calculating distance matrices from sequences and building trees (e.g., Neighbor-Joining).
2.  **Parsimony**: Programs for finding the most parsimonious trees for DNA or protein sequences.
3.  **Maximum Likelihood**: Tools for estimating phylogenies using likelihood models.
4.  **Tree Drawing and Utilities**: Functions for manipulating and displaying tree files.

## Expert Tips

- **Format Flexibility**: Unlike original PHYLIP, which often requires strict "Phylip format" input, `embassy-phylip` tools can read any sequence format supported by EMBOSS (FASTA, GenBank, GCG, etc.) and convert them internally.
- **Validation**: EMBOSS uses ACD (AJAX Command Definition) files to validate your input before the program starts. If a required parameter is missing and `-auto` is not used, the program will prompt you interactively.
- **Environment Setup**: Ensure your `PATH` includes the EMBOSS bin directory (typically `/usr/local/emboss/bin` or similar). Use the `embossversion` command to verify the installation is active.
- **Output Handling**: PHYLIP tools often generate a "tree file" and an "outfile". In the EMBOSS version, these are explicitly handled by qualifiers like `-treefile` and `-outfile`.

## Reference documentation
- [EMBOSS Key Features](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [UNIX Command Line Interface](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [Post-installation and Testing](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [EMBOSS Overview](./references/emboss_open-bio_org_index.md)