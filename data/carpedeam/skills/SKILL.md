---
name: carpedeam
description: CarpeDeam is a specialized de novo metagenome assembler designed to handle the unique challenges of ancient DNA (aDNA).
homepage: https://github.com/LouisPwr/CarpeDeam
---

# carpedeam

## Overview
CarpeDeam is a specialized de novo metagenome assembler designed to handle the unique challenges of ancient DNA (aDNA). Standard assemblers often struggle with the high frequency of C-to-T and G-to-A substitutions caused by post-mortem chemical degradation. CarpeDeam incorporates a damage-aware correction step to reconstruct contigs from these heavily damaged datasets more accurately than general-purpose tools.

## Core Assembly Workflow

The primary command for assembling ancient metagenomes is `ancient_assemble`.

```bash
carpedeam ancient_assemble [reads.fastq.gz] [output.fasta] [tmp_dir] --ancient-damage [damage_prefix]
```

### Essential Parameters
- `--ancient-damage`: The path prefix to your damage profiles. The tool expects two files at this location: `[prefix]_5p.prof` and `[prefix]_3p.prof`.
- `--num-iter-reads-only`: Sets the number of damage-aware iterations using only raw reads. This produces short but highly precise contigs. Recommended range: 3 to 5.
- `--num-iterations`: The total number of iterations, including both read-only and contig-merging phases. Recommended range: 9 to 12.
- `--min-merge-seq-id`: The identity threshold for overlapping sequences during merging. Lowering this below 0.99 increases contig length but raises the risk of misassemblies.
- `--unsafe`: Enable this to maximize sensitivity and contig length if you are willing to accept a higher risk of chimeric contigs.

## Data Preparation and Best Practices

### Read Pre-processing
- **Merging**: Always merge paired-end reads before assembly. Merging improves read quality and provides a clearer damage signal for the assembler.
- **Length Filtering**: CarpeDeam may encounter segmentation faults if reads are too short (e.g., 1bp). Filter your input to ensure all reads are at least 20bp long.
  - Example using seqkit: `seqkit seq -m 20 input.fastq > filtered.fastq`

### Damage Matrix Requirements
The tool is highly sensitive to the formatting of the `.prof` files. They must be strictly tab-separated with no trailing whitespaces.

**Format Specifications:**
- Must contain a header line with 12 substitution types (A>C, A>G, A>T, C>A, C>G, C>T, G>A, G>C, G>T, T>A, T>C, T>G).
- One line per position.
- 5p profile: Focuses on C-to-T substitutions starting at position 1.
- 3p profile: Focuses on G-to-A substitutions starting at position 1.

**Fixing Formatting Errors:**
If you receive the error "Profile not 12 fields uniq1", use `sed` to normalize the tabs and remove trailing spaces:
```bash
sed -E 's/[[:space:]]+/\t/g; s/\t$//' input_damage.prof > fixed_damage.prof
```

## Hardware Considerations
- **Memory**: CarpeDeam requires approximately 1 byte of RAM per residue. It scales its consumption based on available system memory.
- **CPU**: Requires a processor supporting at least the SSE4.1 instruction set.

## Reference documentation
- [CarpeDeam GitHub Repository](./references/github_com_LouisPwr_CarpeDeam.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_carpedeam_overview.md)