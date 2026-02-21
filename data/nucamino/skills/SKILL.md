---
name: nucamino
description: nucamino is a specialized alignment tool tailored for the unique requirements of viral genomics.
homepage: https://github.com/hivdb/nucamino
---

# nucamino

## Overview

nucamino is a specialized alignment tool tailored for the unique requirements of viral genomics. While general-purpose aligners often struggle with the high mutation rates and frequent insertions/deletions (indels) found in viruses, nucamino utilizes pre-defined alignment profiles to accurately map nucleotide sequences to their corresponding amino acids. It is particularly effective for processing HIV-1, HIV-2, and various HCV genotypes, providing a robust solution for researchers working with viral sequence data.

## Installation and Setup

The most efficient way to install nucamino is via Bioconda:

```bash
conda install -c bioconda nucamino
```

Alternatively, for development or custom builds, it can be compiled from source using Go or via the provided Dockerfile in the repository.

## Common CLI Patterns

### Basic Alignment
To align sequences against a standard profile (e.g., HIV-1 subtype B):

```bash
nucamino align hiv1b input.fasta > output.json
```

### Exploring Profiles and Genes
Before running an alignment, you can inspect the available genes within a specific profile:

```bash
nucamino profile list-genes hiv1b
```

### Validating Sequences
Use the `check` command to verify the integrity or compatibility of sequences before performing full alignments:

```bash
nucamino check <input_file>
```

### Custom Alignment
If you have a specific reference or profile not included in the defaults, use the `align-with` command:

```bash
nucamino align-with <profile_file> <input_file>
```

## Expert Tips and Best Practices

- **Profile Selection**: Always match the profile to the specific virus and subtype of your data. Using a `hiv1b` profile for `hiv2` sequences will result in poor alignment quality or errors.
- **Output Handling**: nucamino typically outputs results in a structured format (JSON). Use tools like `jq` to parse specific alignment scores or amino acid translations from the output.
- **Performance**: nucamino is optimized for speed. When processing large datasets, ensure your input FASTA files are well-formatted to prevent parser overhead.
- **Case Sensitivity**: The CLI is designed to be user-friendly; for example, gene names passed as arguments are generally accepted in lowercase.

## Reference documentation

- [NucAmino GitHub Repository](./references/github_com_hivdb_nucamino.md)
- [Bioconda NucAmino Overview](./references/anaconda_org_channels_bioconda_packages_nucamino_overview.md)
- [NucAmino Commit History (Subcommand Details)](./references/github_com_hivdb_nucamino_commits_master.md)