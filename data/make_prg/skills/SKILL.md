---
name: make_prg
description: `make_prg` is a specialized bioinformatics tool designed to transform linear sequence alignments into graph-based reference structures.
homepage: https://github.com/rmcolq/make_prg
---

# make_prg

## Overview

`make_prg` is a specialized bioinformatics tool designed to transform linear sequence alignments into graph-based reference structures. It handles the complexity of nested variation and allows for the incremental update of existing graphs with new sequence data. This tool is primarily used to generate the necessary inputs for pangenome-aware mapping and variant calling suites, ensuring that genetic diversity is accurately represented in the reference.

## Core Workflows

### Creating a PRG from MSAs

The `from_msa` subcommand is used to build a new graph. You can provide a single MSA file or a directory containing multiple alignments.

**Basic command:**
```bash
make_prg from_msa -i input_alignments/ -o my_pangenome_prefix
```

**Key Parameters:**
- `-f`: Specify alignment format (default is `fasta`). Supports any Biopython AlignIO format.
- `-N`: Maximum nesting levels (default: 5). Increase for highly complex regions, though this increases graph complexity.
- `-L`: Minimum match length (default: 7). This defines the number of identical characters required to collapse sequences into a single node.
- `-O`: Output type. Use `p` for PRG, `b` for Binary, `g` for GFA, or `a` for all (default).

### Updating an Existing PRG

The `update` subcommand allows you to incorporate new sequences into a PRG previously created with `from_msa`. This requires the `.update_DS.zip` file generated during the initial build.

**Basic command:**
```bash
make_prg update -u my_pangenome.update_DS.zip -d new_sequences.txt -o updated_pangenome
```

**Key Parameters:**
- `-d`: Path to a `denovo_paths.txt` file containing the new sequences.
- `-D`: Deletion threshold (default: 10). Sequences representing deletions longer than this value are ignored to prevent graph bloat.

## Expert Tips and Best Practices

- **Resource Management**: Use the `-t` flag to specify threads. Setting `-t 0` will automatically utilize all available cores, which is recommended for large MSA sets.
- **Output Selection**: If you only need the graph for visualization or specific downstream tools, use `-O g` (GFA) or `-O p` (PRG) to save disk space and reduce processing time.
- **Handling Large Datasets**: When processing a directory of MSAs, use the `--suffix` flag to ensure only relevant files (e.g., `.aln` or `.fasta`) are picked up by the tool.
- **Nesting and Match Length**: 
    - If the resulting graph is too fragmented, try increasing the minimum match length (`-L`).
    - If the graph fails to capture complex structural variations, consider increasing the max nesting level (`-N`), keeping in mind the computational cost for downstream tools like Pandora.

## Reference documentation
- [make_prg GitHub Repository](./references/github_com_iqbal-lab-org_make_prg.md)
- [Bioconda make_prg Overview](./references/anaconda_org_channels_bioconda_packages_make_prg_overview.md)