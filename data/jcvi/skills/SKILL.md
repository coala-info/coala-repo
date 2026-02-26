---
name: jcvi
description: The jcvi library is a comprehensive Python toolkit for genomic data processing, comparative genomics, and high-quality biological visualization. Use when user asks to manipulate FASTA files, detect orthologs, perform synteny mapping, reconstruct assemblies with ALLMAPS, or generate genomic dot plots and karyotype visualizations.
homepage: http://github.com/tanghaibao/jcvi
---


# jcvi

## Overview
The `jcvi` library is a comprehensive Python toolkit designed to streamline complex genomic workflows. It provides a modular architecture for handling everything from basic sequence manipulation and file format conversion to advanced comparative genomics like ancestral genome reconstruction and synteny mapping. Use this skill to execute specialized bioinformatics procedures that require deterministic processing of large-scale genomic datasets.

## Core CLI Usage Pattern
All `jcvi` tools are invoked as Python modules. The general syntax is:
```bash
python -m jcvi.<path.to.module> <ACTION> [options]
```
To view available actions for a module, run the module without an action. To view options for a specific action, run the action without arguments.

## High-Utility Modules and Actions

### Sequence Manipulation (`jcvi.formats.fasta`)
*   **Summary Statistics**: `python -m jcvi.formats.fasta summary seqs.fasta` (Reports base counts and Ns).
*   **Filtering**: `python -m jcvi.formats.fasta filter seqs.fasta --minsize=1000` (Filters records by size).
*   **Extraction**: `python -m jcvi.formats.fasta extract seqs.fasta ids.txt` (Retrieves specific sequences by ID).
*   **Translation**: `python -m jcvi.formats.fasta translate cds.fasta` (Translates CDS to protein sequences).

### Comparative Genomics (`jcvi.compara`)
*   **Synteny Scanning**: Use `jcvi.compara.catalog` to find anchors in BLAST or LAST output.
*   **Ortholog Detection**: `python -m jcvi.compara.catalog ortholog query.bed subject.bed` (Finds orthologous gene pairs).
*   **Dot Plots**: `python -m jcvi.graphics.dotplot blast_output.lastz` (Generates alignment dot plots).

### Assembly and Scaffolding
*   **ALLMAPS**: Reconstruct chromosomal assemblies by anchoring scaffolds onto linkage groups.
    *   `python -m jcvi.assembly.allmaps path weights.txt`
*   **K-mer Analysis**: `python -m jcvi.assembly.kmer` for genome size estimation and histogram analysis.

### Graphics and Visualization
*   **Synteny Plots**: Use `jcvi.graphics.synteny` for micro-synteny or macro-synteny visualizations.
*   **Karyotype Plotting**: `python -m jcvi.graphics.karyotype seqids layout` (Paints regions on chromosomes).
*   **Requirement**: Ensure `ImageMagick` is installed and `latex` is in your PATH for high-quality rendering.

## Expert Tips
*   **Help Discovery**: If you are unsure of the submodule path, check the `jcvi` source structure. Common paths include `jcvi.formats`, `jcvi.apps`, `jcvi.compara`, and `jcvi.graphics`.
*   **Dependency Check**: Many modules rely on external tools like `BEDTOOLS`, `EMBOSS`, or `Kent tools`. Ensure these are in your system `$PATH`.
*   **Memory Management**: For large-scale comparative tasks (like `liftover`), `jcvi` includes optimizations to reduce memory usage. Always use the latest version (v1.5.10+) for improved performance on large BLAST files.
*   **Format Conversion**: `jcvi` is excellent for "tidying" files. Use `jcvi.formats.gff format` or `jcvi.formats.fasta format` to standardize headers and metadata before downstream analysis.

## Reference documentation
- [JCVI Main README](./references/github_com_tanghaibao_jcvi.md)
- [JCVI Wiki and Applications](./references/github_com_tanghaibao_jcvi_wiki.md)