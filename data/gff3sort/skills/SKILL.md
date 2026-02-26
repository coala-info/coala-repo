---
name: gff3sort
description: gff3sort is a Perl script that sorts GFF3 files while maintaining the correct hierarchical order of parent and child features. Use when user asks to sort GFF3 files by coordinate, prepare GFF3 files for tabix indexing, or fix parent-child structural errors for genome browsers.
homepage: https://github.com/billzt/gff3sort
---


# gff3sort

## Overview
gff3sort is a specialized Perl script designed to address a specific limitation in standard GFF3 sorting methods. While tools like GNU `sort` or `gt gff3` can sort by coordinate, they often fail to maintain the correct hierarchical order (Parent features before Child features) when multiple features share the same start position. This tool ensures that parent features (like mRNAs) always precede their children (like exons) in the output, which is a requirement for valid tabix indexing and proper rendering in genome browsers.

## Usage Patterns

### Basic Sorting
The most common use case is sorting a GFF3 file for downstream indexing. By default, it sorts chromosomes alphabetically.
```bash
gff3sort.pl input.gff3 > output.sorted.gff3
```

### Preparing for Tabix
To create a tabix-indexed GFF3 file, use gff3sort followed by bgzip and tabix:
```bash
gff3sort.pl input.gff3 > output.sorted.gff3
bgzip output.sorted.gff3
tabix -p gff output.sorted.gff3.gz
```

### Handling Disordered Inputs
If the original GFF3 file is highly disordered (where parent features appear physically after their children in the file), use the precise mode. This is slower but ensures structural integrity.
```bash
gff3sort.pl --precise input.gff3 > output.sorted.gff3
```

### Chromosome Ordering
Control how chromosome IDs are sorted using the `--chr_order` flag:
- `alphabet`: Standard alphabetical (e.g., chr1, chr10, chr2). [Default]
- `natural`: Numerical/natural sorting (e.g., chr1, chr2, chr10).
- `original`: Maintains the order found in the input file.

```bash
gff3sort.pl --chr_order natural input.gff3 > output.sorted.gff3
```

### Extracting Embedded FASTA
If the GFF3 file contains a `##FASTA` section at the end, gff3sort will discard it by default. Use the extract flag to save it to a separate file.
```bash
gff3sort.pl --extract_FASTA input.gff3 > output.sorted.gff3
# This creates output.sorted.gff3.fasta
```

## Best Practices
- **JBrowse Compatibility**: Always use gff3sort if you encounter "parent-child" errors or missing features in JBrowse, as standard sorting often triggers these bugs.
- **Performance**: Only use `--precise` if the default mode fails to resolve ordering issues, as it is 2x-3x slower.
- **Validation**: You can use the companion script `check-disorder.pl` (if available in the environment) to verify if a GFF3 file requires sorting.

## Reference documentation
- [GFF3sort GitHub Repository](./references/github_com_tao-bioinfo_gff3sort.md)