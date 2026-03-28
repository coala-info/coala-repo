---
name: find_differential_primers
description: This tool identifies primer sets that uniquely amplify target sequence groups while excluding negative groups for diagnostic or metabarcoding applications. Use when user asks to design specific primers, perform off-target screening with BLAST, classify primer specificity, or extract predicted amplicons.
homepage: https://github.com/widdowquinn/find_differential_primers
---


# find_differential_primers

## Overview

The `find_differential_primers` package (executed via the `pdp` command) is a bioinformatics suite designed to identify primer sets that can uniquely amplify target "positive" groups of sequences while excluding "negative" groups. It is particularly effective for developing diagnostic assays for pathogens or identifying novel metabarcoding markers. The tool orchestrates a multi-stage pipeline involving sequence filtering, primer design via Primer3, off-target screening with BLAST, and specificity classification.

## Command-Line Usage

The tool uses a subcommand-based architecture. Most workflows follow a sequential execution where each step populates or updates a project directory.

### 1. Project Initialization
Validate your input sequences and create the project structure.
```bash
pdp config -i input_config.tab -o project_dir
```
**Config File Format (.tab):**
A tab-separated file with the following columns:
`Identifier` | `Classes (comma-separated)` | `Path/to/FASTA` | `Features (or -)`

### 2. Sequence Filtering (Optional)
Filter genomes to target specific regions (e.g., CDS identified by Prodigal).
```bash
pdp filter -i project_dir
```

### 3. Primer Design
Design primers for each genome in the project using eprimer3.
```bash
pdp eprimer3 -i project_dir
# Shortcut: pdp e3 -i project_dir
```

### 4. Off-Target Screening
Screen designed primers against a BLAST database of negative examples or environmental sequences.
```bash
pdp blastscreen -i project_dir -d path/to/blast_db
# Shortcut: pdp bs -i project_dir -d path/to/blast_db
```

### 5. Cross-Hybridization Testing
Test primers against all input sequences using `primersearch` to identify potential cross-amplification.
```bash
pdp primersearch -i project_dir
# Shortcut: pdp ps -i project_dir
```

### 6. Specificity Classification
Classify primer sets based on their ability to distinguish between the defined classes.
```bash
pdp classify -i project_dir
# Shortcut: pdp cl -i project_dir
```

### 7. Amplicon Extraction
Extract the predicted amplicon sequences for the candidate diagnostic primers.
```bash
pdp extract -i project_dir
# Shortcut: pdp ex -i project_dir
```

## Expert Tips and Best Practices

- **Version Compatibility:** Ensure **Primer3 version 1.1.4** is installed. Version 2.x is generally incompatible with the EMBOSS wrappers used by this pipeline.
- **Branch Selection:** Use the `diagnostic_primers` branch of the repository for the most up-to-date subcommand-based workflow.
- **Performance:** The `primersearch` step can be computationally expensive. If processing a large number of primer pairs, ensure your environment has sufficient resources or consider pre-filtering primers using `blastscreen`.
- **Ambiguity Codes:** The `pdp config` command automatically handles the replacement of ambiguity symbols in FASTA sequences to ensure compatibility with downstream design tools.
- **Metabarcoding:** When using `pdp extract`, the tool can use MAFFT to align candidate marker sequences, which is essential for assessing the phylogenetic utility of a marker.



## Subcommands

| Command | Description |
|---------|-------------|
| find_differential_primers_eprimer3 | Pick PCR primers and hybridization oligos |
| find_differential_primers_primersearch | Search DNA sequences for matches with primer pairs |

## Reference documentation
- [find_differential_primers GitHub Overview](./references/github_com_widdowquinn_find_differential_primers.md)
- [Emulating PrimerSearch using Bowtie2](./references/github_com_widdowquinn_find_differential_primers_wiki_Emulating-PrimerSearch-using-Bowtie2.md)