---
name: fasta3
description: The fasta3 tool compares biological sequences to identify homologous proteins or nucleic acids using various alignment algorithms. Use when user asks to search sequence databases, perform Smith-Waterman alignments, compare DNA to protein sequences, or identify distant evolutionary relationships.
homepage: http://faculty.virginia.edu/wrpearson/fasta
---


# fasta3

## Overview
The `fasta3` skill provides expert guidance for using the FASTA36 software suite to compare biological sequences. It is designed to help identify homologous proteins or nucleic acids by searching a query sequence against local or remote databases. This toolset is particularly effective for identifying distant evolutionary relationships through local alignment (FASTA), global-local alignment (GLSEARCH), or rigorous Smith-Waterman searches (SSEARCH).

## Command Line Patterns

### Basic Sequence Search
To search a protein database with a protein query:
```bash
fasta36 query.fasta database.lib
```

### Rigorous Smith-Waterman Search
Use `ssearch36` for maximum sensitivity when looking for distant homologs:
```bash
ssearch36 -s BL62 query.fasta database.lib
```

### Global-Local Alignment
Use `glsearch36` to search for a query sequence that matches a database sequence from end-to-end:
```bash
glsearch36 query.fasta database.lib
```

### Finding Multiple Local Alignments
Use `lalign36` to find multiple non-overlapping regions of similarity between two sequences:
```bash
lalign36 seq1.fasta seq2.fasta
```

## Expert Tips and Best Practices

- **E-value Interpretation**: Focus on the Expectation (E) value. An E-value < 0.01 is generally considered statistically significant, suggesting homology rather than a chance match.
- **Scoring Matrices**: 
  - For proteins, use `-s BL62` (BLOSUM62) for general searches.
  - Use `-s VT20` or `-s BL80` for very similar sequences.
  - Use `-s P250` (PAM250) for very distant relationships.
- **Output Formatting**: Use the `-m` flag to change output styles:
  - `-m 9`: Tabular output with comments (ideal for parsing).
  - `-m 10`: Script-friendly machine-readable format.
  - `-m 8`: BLAST-like tabular format.
- **Heuristic vs. Rigorous**: 
  - Use `fasta36` for fast, heuristic searches of large databases.
  - Use `ssearch36` when sensitivity is more important than speed.
- **Library Formats**: Ensure your database file is in FASTA format. If using a specialized library format, specify the library type with the `-t` option.
- **Statistical Estimates**: FASTA programs calculate shuffles by default to estimate significance. If a match seems "too good to be true" but has a poor E-value, check if the sequences have low-complexity regions.



## Subcommands

| Command | Description |
|---------|-------------|
| fasta36 | FASTA searches a protein or DNA sequence data bank |
| fastx36 | FASTX compares a DNA sequence to a protein sequence data bank |
| fasty36 | FASTY compares a DNA sequence to a protein sequence data bank |
| ggsearch36 | GGSEARCH performs a global/global database searches |
| glsearch36 | GLSEARCH performs a global-query/local-library search |
| ssearch36 | SSEARCH performs a Smith-Waterman search |
| tfastx36 | TFASTX compares a protein to a translated DNA data bank |
| tfasty36 | TFASTY compares a protein to a translated DNA data bank |

## Reference documentation
- [FASTA3 Overview](./references/anaconda_org_channels_bioconda_packages_fasta3_overview.md)