---
name: fastahack
description: fastahack is a specialized utility for indexing and performing random access on FASTA-formatted sequence files.
homepage: https://github.com/ekg/fastahack
---

# fastahack

## Overview
fastahack is a specialized utility for indexing and performing random access on FASTA-formatted sequence files. It enables the rapid extraction of specific genomic regions by creating a `.fai` index, allowing the tool to seek directly to the required coordinates using `fseek64`. This makes it an efficient choice for bioinformaticians working with large reference genomes who need to extract many subsequences without loading the entire file into RAM.

## Common CLI Patterns

### Indexing a FASTA File
Before extracting sequences, you must generate an index file. This creates a `<filename>.fai` file.
```bash
fastahack -i reference.fasta
```

### Extracting a Specific Region
Regions are specified using the format `sequence_name:start..end`. Coordinates are **1-based** and the range is **inclusive**.
```bash
# Extract 20bp starting at position 323202 on chromosome 8
fastahack -r 8:323202..323221 reference.fasta
```

### Alternative Region Formats
- **Entire Sequence**: `fastahack -r chr1 reference.fasta`
- **Single Base**: `fastahack -r chr1:500 reference.fasta`
- **Range with different separator**: `fastahack -r chr1:500-600 reference.fasta` (also supports `..`)

### Batch Extraction via Stdin
For processing multiple regions efficiently, use the `-c` flag to stream line-delimited region specifiers.
```bash
cat regions.txt | fastahack -c reference.fasta
```

### Calculating Sequence Entropy
To calculate the Shannon entropy of a specific region:
```bash
fastahack -e chr1:100..500 reference.fasta
```

## Expert Tips and Best Practices
- **Sequence Naming**: fastahack identifies sequences by the first whitespace-separated field in the FASTA header. For example, a header like `>8 SN(Homo sapiens)` can be addressed simply as `8`.
- **Index Compatibility**: The `.fai` files generated are numerically equivalent to those created by `samtools`, though fastahack preserves full sequence names in the index whereas samtools may truncate them.
- **Line Length Consistency**: fastahack requires FASTA files to have self-consistent line lengths (except for the last line of a sequence). It will fail to index files with inconsistent wrapping.
- **Memory Efficiency**: Because it uses file seeking rather than loading the sequence into memory, it is safe to use on extremely large files (e.g., human whole-genome references) even on systems with limited RAM.

## Reference documentation
- [fastahack Overview and Usage](./references/github_com_ekg_fastahack.md)