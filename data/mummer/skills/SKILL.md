---
name: mummer
description: MUMmer is a high-performance system for the rapid alignment of large-scale DNA and protein sequences, including entire genomes. Use when user asks to align DNA sequences with nucmer, perform translated protein alignments with promer, or process delta files to show coordinates and structural differences.
homepage: https://github.com/mummer4/mummer
metadata:
  docker_image: "quay.io/biocontainers/mummer:3.23--pl5321hdbdd923_18"
---

# mummer

## Overview
MUMmer is a high-performance system for the rapid alignment of large-scale DNA and protein sequences. It is particularly effective for comparing entire genomes, handling hundreds or thousands of contigs from shotgun sequencing projects, and detecting large rearrangements or duplications. This skill provides the necessary command-line patterns to execute DNA-level alignments (nucmer) and translated protein-level alignments (promer), as well as instructions for parsing the resulting delta files.

## Core Workflows

### DNA Sequence Alignment (nucmer)
Use `nucmer` for comparing highly similar DNA sequences (e.g., same species or closely related strains).

```bash
# Basic alignment
nucmer -p <output_prefix> <reference.fasta> <query.fasta>

# Common use cases:
# 1. Mapping an unfinished assembly to a finished genome
# 2. Comparing two similar genomes with rearrangements
```

**Key Options:**
- `--mum`: Use only maximal unique matches that are unique in both the reference and query.
- `--maxmatch`: Use all matches regardless of their uniqueness; helpful for highly repetitive genomes.
- `-c <int>`: Sets the minimum length of a cluster of matches (default 65).
- `-l <int>`: Sets the minimum length of an initial match (default 20).

### Translated Protein Alignment (promer)
Use `promer` for highly divergent sequences that share similarity only at the protein level. It translates DNA in all six frames before aligning.

```bash
# Basic protein-level alignment
promer -p <output_prefix> <reference.fasta> <query.fasta>

# Common use cases:
# 1. Identifying synteny between distant species
# 2. Comparative genome annotation
```

### Processing Output (.delta files)
MUMmer programs produce a `.delta` file. Use the `show-*` utilities to convert this into human-readable formats.

- **show-coords**: Summarizes alignment coordinates, identities, and coverage.
  ```bash
  show-coords -rcl <prefix>.delta > <prefix>.coords
  ```
  *Tip: Use `-r` to sort by reference, `-c` to include percent coverage, and `-l` to include sequence lengths.*

- **show-aligns**: Displays the actual pairwise alignments of the sequences.
  ```bash
  show-aligns <prefix>.delta "ref_id" "query_id" > <prefix>.aligns
  ```

- **show-diff**: Highlights structural differences such as insertions, deletions, and inversions.
  ```bash
  show-diff <prefix>.delta > <prefix>.diff
  ```

## Expert Tips
- **Memory Management**: MUMmer4 is significantly more memory-efficient than previous versions, but for extremely large plant genomes, ensure you have at least 4-8GB of RAM per Gb of sequence.
- **Prefixing**: Always use the `-p` flag to prevent MUMmer from overwriting the default `out.delta` and `out.cluster` files.
- **Strand Orientation**: All output coordinates in `.delta` files refer to the forward strand of the involved sequence, regardless of the match direction.
- **Large Assemblies**: When aligning thousands of small contigs, `nucmer` is generally faster and more robust than trying to use the core `mummer` engine directly.

## Reference documentation
- [MUMmer4 README](./references/github_com_mummer4_mummer.md)