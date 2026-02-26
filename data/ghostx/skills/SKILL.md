---
name: ghostx
description: GHOSTX is a bioinformatics tool designed for rapid sequence homology searches using suffix arrays to achieve high throughput. Use when user asks to build a sequence database, perform protein or DNA alignments, or search for remote homologues.
homepage: http://www.bi.cs.titech.ac.jp/ghostx/
---


# ghostx

## Overview

GHOSTX is a specialized bioinformatics tool designed for rapid sequence homology searches. It bridges the gap between the sensitivity of BLAST and the need for massive throughput in modern genomics. By utilizing suffix arrays for both the query and the database, it achieves a 100-fold speed increase over traditional BLAST while maintaining the ability to detect remote homologues. This skill provides the necessary command-line patterns to build GHOSTX databases and execute alignments for both protein and DNA sequences.

## Database Construction

Before searching, you must convert FASTA files into the GHOSTX binary format. This process partitions the database into chunks to manage memory usage.

```bash
# Basic database construction (Protein)
ghostx db -i database.fasta -o dbname

# DNA database construction
ghostx db -i database.fasta -o dbname -t d

# Memory-optimized construction (adjusting chunk size in bytes)
# Default is 1GB; smaller chunks reduce memory but may impact search efficiency
ghostx db -i database.fasta -o dbname -l 536870912
```

## Homology Search (Alignment)

The `aln` command performs the actual search. It requires a pre-formatted database.

```bash
# Standard protein-protein search
ghostx aln -i queries.fasta -d dbname -o results.txt

# DNA-DNA search
ghostx aln -i queries.fasta -d dbname -o results.txt -q d -t d

# Multi-threaded execution for speed
ghostx aln -i queries.fasta -d dbname -o results.txt -a 8
```

### Search Parameters and Tuning

| Option | Description | Default | Recommendation |
| :--- | :--- | :--- | :--- |
| `-b` | Max output hits per query | 10 | Increase for diverse metagenomic samples. |
| `-v` | Max alignments per subject | 1 | Keep low unless looking for internal repeats. |
| `-s` | Seed search lower cutoff | 4 | Increase to improve speed/specificity. |
| `-T` | Seed search upper cutoff | 30 | Decrease to find more distant homologues. |
| `-F` | Complexity filter (T/F) | T | Disable (F) if searching highly repetitive regions. |

## Output Format

GHOSTX produces a tab-delimited format compatible with BLAST tabular output (outfmt 6). The columns are:
1. Query Name
2. Subject Name
3. % Identity
4. Alignment Length
5. Mismatches
6. Gap Openings
7. Query Start
8. Query End
9. Subject Start
10. Subject End
11. E-value
12. Bit Score

## Expert Tips

- **Memory Requirements**: For a standard 1GB chunk size, GHOSTX requires approximately 10GB of RAM for database construction and 13GB for searching. If you are working on a memory-constrained system, reduce the `-l` parameter during the `db` step.
- **Sequence Types**: Ensure the `-q` (query type) and `-t` (database type) flags match your data. While the default is protein (`p`), failing to set `-t d` for DNA databases will result in execution errors.
- **Performance Scaling**: The `-a` flag for threads scales well. Match this to the number of physical cores available on your system for optimal throughput.

## Reference documentation
- [GHOSTX Homepage and Usage](./references/www_bi_cs_titech_ac_jp_ghostx.md)
- [Bioconda GHOSTX Package Overview](./references/anaconda_org_channels_bioconda_packages_ghostx_overview.md)