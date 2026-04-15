---
name: burst
description: BURST is a DNA aligner that provides provably optimal end-to-end alignments for high-throughput sequencing data. Use when user asks to align DNA sequences, perform taxonomy assignment using a Least Common Ancestor approach, or build indexed databases for microbial amplicon and shotgun sequencing.
homepage: https://github.com/knights-lab/BURST
metadata:
  docker_image: "quay.io/biocontainers/burst:v1.0--hdfd78af_1"
---

# burst

## Overview

BURST (formerly embalmer) is a specialized DNA aligner designed for high-throughput sequencing data where accuracy is paramount. Unlike many modern aligners that rely on heuristics, BURST provides provably optimal end-to-end alignments. It is particularly effective for microbial amplicon and shotgun sequencing, offering features like dual-objective scoring (edit distance and BLAST identity) and automated taxonomy assignment using a Least Common Ancestor (LCA) approach.

## Core CLI Patterns

### Basic Alignment
For small datasets where pre-indexing is not required:
```bash
burst -r references.fasta -q queries.fasta -o output.b6
```

### High-Performance Workflow (Indexing)
For large databases, always create an accelerator (`.acx`) and an index (`.edx`) first.

1. **Build Database:**
   ```bash
   burst -r database.fasta -a database.acx -o database.edx -d DNA 320 -i 0.97 -s
   ```
   *   `-d DNA 320`: Specifies DNA mode and maximum query length (320bp).
   *   `-i 0.97`: Sets the minimum identity threshold (97%).
   *   `-s`: Enables compressive database mode for faster builds and smaller files.

2. **Search Database:**
   ```bash
   burst -q queries.fasta -a database.acx -r database.edx -o results.txt
   ```

### Taxonomy Assignment
To perform LCA taxonomy assignment, provide a tab-delimited taxonomy file:
```bash
burst -q queries.fasta -a database.acx -r database.edx -b database.tax -o taxonomy_results.txt
```

## Alignment Modes (-m)

*   **CAPITALIST (Default):** Reports the smallest set of references necessary to explain all tied hits. Best for reducing redundancy in results.
*   **BEST:** Reports only the first best hit found for each query.
*   **ALLPATHS:** Reports all tied best hits for every query. Use this for downstream analysis requiring full hit distributions.

## Expert Tips and Best Practices

### Memory Management
If you encounter "Out of Memory" errors on large reference genomes:
*   Use `-dp <int>` to partition the database (e.g., `-dp 2` or `-dp 4`). This reduces memory overhead at the cost of some speed.
*   Use `-d QUICK` for a non-compressive database mode if memory is extremely limited.

### Optimization via Constraints
BURST runs significantly faster when you provide tight constraints:
*   **Query Length:** Set `-d DNA <length>` to the actual maximum length of your reads rather than a generic high number.
*   **Identity:** Higher identity thresholds (e.g., `-i 0.98` vs `-i 0.95`) result in faster search times.

### Handling Ambiguity
BURST supports full IUPAC ambiguous bases. If you wish to penalize "N" bases in the reference sequences, ensure you check the specific version documentation for penalty flags, as default behavior treats them as matches to any base.

### Heuristic Modes
If optimality is not required and you need to find lower identity matches (below 95%):
*   Use `-hr` to add heuristics to the normal engine.
*   Use `-p <effort>` (e.g., `-p 16`) to activate the fully heuristic alignment mode. Note that this invalidates the mathematical optimality guarantee.

## Reference documentation
- [BURST GitHub Repository](./references/github_com_knights-lab_BURST.md)
- [BURST Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_burst_overview.md)