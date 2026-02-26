---
name: fasta3
description: "fasta3 is a suite of programs used for comparing biological sequences through various heuristic and rigorous alignment algorithms. Use when user asks to perform protein or DNA sequence searches, conduct Smith-Waterman local alignments, or compare translated DNA sequences against protein databases."
homepage: http://faculty.virginia.edu/wrpearson/fasta
---


# fasta3

## Overview
The FASTA3 package is a comprehensive suite of programs designed for biological sequence comparison. Unlike BLAST, which uses a seed-and-extend heuristic, the FASTA suite provides a range of algorithms from the rapid heuristic `fasta36` to the rigorous Smith-Waterman implementation `ssearch36`. It is particularly valued for its accurate statistical estimates (E-values) and its ability to perform various alignment types, including global-local and global-global comparisons.

## Common Programs
- **fasta36**: The standard heuristic search for protein or DNA.
- **ssearch36**: Rigorous Smith-Waterman local alignment (slower but more sensitive).
- **ggsearch36**: Global-global alignment (Needleman-Wunsch).
- **glsearch36**: Global-local alignment (global in the query, local in the library).
- **tfastx36/tfasty36**: Compares a protein query against a DNA database translated in three frames.
- **fastx36/fasty36**: Compares a DNA query (translated) against a protein database.

## Command Line Usage

### Basic Search Syntax
The standard syntax for most programs in the suite is:
```bash
program_name [options] query_file library_file
```

### Common CLI Patterns
- **Standard Protein Search**:
  `fasta36 query.pro proteins.lib`
- **Rigorous Smith-Waterman Search**:
  `ssearch36 query.pro proteins.lib`
- **DNA Search with E-value threshold**:
  `fasta36 -E 0.001 query.fna dna.lib`
- **Specify Scoring Matrix**:
  `fasta36 -s BL62 query.pro proteins.lib` (Uses BLOSUM62)

### Output Formatting (`-m`)
- `-m 0`: Default text alignment.
- `-m 8`: BLAST-like tabular output (Query, Subject, %id, length, etc.).
- `-m 9`: Tabular output with comment lines.
- `-m 10`: Parsable format for scripts.

## Expert Tips and Best Practices
- **Sensitivity vs. Speed**: Use `fasta36` for initial high-throughput screening. Use `ssearch36` when looking for distant homologs (twilight zone) where heuristic methods might fail.
- **Statistical Significance**: Always pay attention to the E-value. FASTA3 programs calculate these based on the distribution of scores in the actual library search, making them highly reliable.
- **Library Formats**: FASTA3 supports various formats. If using a large database, ensure it is indexed or in a standard FASTA format.
- **Translation Searches**: When searching DNA against protein, `fasty36` is generally preferred over `fastx36` as it allows for frameshifts within a codon, making it more robust for sequencing errors.
- **Gap Penalties**: For protein searches, the default is usually `-10` for gap opening and `-2` for extension. Adjust these using `-f` (open) and `-g` (extend) if you expect many indels.

## Reference documentation
- [fasta3 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fasta3_overview.md)