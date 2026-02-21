---
name: gpatch
description: GPatch is a specialized tool designed to upgrade draft contig assemblies into chromosome-scale pseudoassemblies.
homepage: https://github.com/adadiehl/GPatch.git
---

# gpatch

## Overview
GPatch is a specialized tool designed to upgrade draft contig assemblies into chromosome-scale pseudoassemblies. It works by taking alignments of contigs against a high-quality reference genome and filling the gaps between those contigs with the corresponding sequences from the reference. This process is particularly useful for creating a more continuous assembly for downstream analysis while maintaining the structural integrity of the original contigs.

## Core Workflow
The primary command is `GPatch.py`. It requires a SAM/BAM file of contig-to-reference alignments and the reference FASTA file.

### Basic Usage
```bash
GPatch.py -q alignments.bam -r reference.fasta -x output_prefix
```

### Recommended Alignment Parameters
For best results, use `minimap2` to generate the input SAM/BAM file. GPatch expects non-overlapping contig mappings.
```bash
minimap2 -a reference.fasta contigs.fasta > alignments.sam
```

## Expert Tips and CLI Patterns

### Handling Telomeres and Ends
By default, GPatch patches the 5' and 3' ends to match the reference chromosome length.
- **To prevent extension**: Use `--no_extend` if you want the pseudochromosome to start and end exactly where your contig alignments begin and end. This avoids potential spurious duplications at the telomeres.

### Scaffolding vs. Patching
- **Default (Patching)**: Fills gaps with actual reference sequence.
- **Scaffolding Only**: Use `--scaffold_only` to pad gaps with "N" characters instead of reference sequence. This is useful if you want a reference-guided scaffold without introducing foreign sequence data.
- **Gap Length**: When using `--scaffold_only`, use `-l N` to set a fixed gap length, or omit it to let GPatch estimate the gap size from the alignment coordinates.

### Quality Control and Filtering
- **Mapping Quality**: Use `-m 30` (default) or higher to ensure only confident alignments are used for patching.
- **Blacklist/Whitelist**: Use `-w whitelist.bed` to restrict alignments to specific genomic regions, effectively ignoring alignments in problematic or blacklisted areas.
- **Nested Contigs**: By default, GPatch drops contigs nested entirely within others. Use `--keep_nested` only if you have a specific reason to bookend these sequences, though this is generally discouraged as it can lead to unpredictable results.

### Multi-Haplotype Data
GPatch is designed for single-haplotype or unphased assemblies.
- **Phased Assemblies**: Separate each haplotype into its own FASTA file and run GPatch independently for each. Running them together in a single BAM will produce incorrect results.

## Output Files
GPatch generates three primary files:
1. `{prefix}patched.fasta`: The final pseudoassembly.
2. `{prefix}contigs.bed`: Coordinates of your original contigs within the new assembly.
3. `{prefix}patches.bed`: Coordinates of the reference patches used, relative to the reference genome.

## Reference documentation
- [GPatch GitHub Repository](./references/github_com_adadiehl_GPatch.md)
- [GPatch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gpatch_overview.md)