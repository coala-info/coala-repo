---
name: mlst
description: The mlst tool performs Multi-Locus Sequence Typing by scanning genomic contigs against PubMLST schemes to identify sequence types. Use when user asks to perform MLST analysis, identify bacterial sequence types from assembly files, or list supported typing schemes.
homepage: https://github.com/tseemann/mlst
---


# mlst

## Overview
The `mlst` tool provides a rapid method for Multi-Locus Sequence Typing (MLST) by scanning contig files against traditional PubMLST schemes. It is designed to automatically detect the appropriate typing scheme for a given genome, though users can manually specify schemes for targeted analysis. It supports compressed inputs and offers various output formats, including a detailed "full" mode that provides quality scores and allele statuses.

## Core CLI Patterns

### Basic Usage
Scan one or more assembly files. The tool automatically detects the species and scheme.
```bash
mlst contigs.fasta
mlst genomes/*.fna.gz
```

### Recommended Output Format
Use the `--full` flag to get a comprehensive, labeled report including the quality status and scoring.
```bash
mlst --full assembly.fasta
```

### Batch Processing
For large numbers of files, use a "File of Filenames" (FOFN) and save the results to a CSV.
```bash
mlst --full --fofn sample_list.txt --csv --outfile results.csv
```

### Scheme Management
List all supported schemes and their metadata (loci count, number of types, etc.):
```bash
mlst --info
```
Force a specific scheme (e.g., when auto-detection is ambiguous or for specific reporting requirements):
```bash
mlst --scheme neisseria sample.fasta
```

## Expert Tips and Best Practices

### Interpreting Allele Symbols
`mlst` uses specific notation to describe the quality of the match:
- **n**: Exact match to an intact allele (100% identity/coverage).
- **~n**: Novel full-length allele (100% coverage, but identity is below 100% but above `--minid`).
- **n?**: Partial match (identity and coverage are above thresholds, but not full length).
- **-**: Allele is missing (below coverage/identity thresholds).
- **n,m**: Multiple different alleles for the same locus were detected.

### Filtering for High Confidence
The default `--minscore` is 50. For strict reporting of known Sequence Types only, increase the threshold:
- **--minscore 100**: Reports only perfect matches to known STs.
- **--minscore 90**: Includes novel combinations of existing alleles (NOVEL STs).

### Handling Path Clutter
When processing files from deep directory structures, use `--nopath` to keep the output clean by stripping the directory prefix from the filename column.
```bash
mlst --nopath /path/to/very/long/directory/structure/*.fasta
```

### Input Flexibility
`mlst` natively handles compressed files. There is no need to decompress `.gz`, `.bz2`, or `.zip` files before running the analysis, which saves disk space and I/O time.

## Reference documentation
- [mlst GitHub Repository](./references/github_com_tseemann_mlst.md)
- [mlst Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mlst_overview.md)