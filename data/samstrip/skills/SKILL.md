---
name: samstrip
description: samstrip is a high-performance utility designed to "slim down" genomic alignment files.
homepage: https://github.com/jakobnissen/samstrip
---

# samstrip

## Overview
samstrip is a high-performance utility designed to "slim down" genomic alignment files. By default, it empties the sequence and quality fields and strips all auxiliary tags except for `NM` (edit distance). This makes it an essential tool for long-term storage of alignments or for creating lightweight versions of BAM files used in coordinate-based computations where the raw read data is no longer necessary.

## Usage Patterns

samstrip operates exclusively on SAM format via standard input (stdin) and output (stdout). To process BAM files, you must pipe data through `samtools`.

### Basic BAM Compression
To strip an existing BAM file while preserving the header and the default `NM` tag:
```bash
samtools view -h input.bam | samstrip | samtools view -b - > stripped.bam
```

### Integration with Aligners
You can strip data on-the-fly during alignment to save disk space immediately:
```bash
minimap2 -ax sr ref.fa fwd.fq rev.fq | samstrip | samtools view -b - > output.bam
```

### Customizing Auxiliary Tags
By default, only the `NM` tag is kept. You can modify this behavior using `--keep` or `--remove`.

**Keep specific tags (e.g., NM, AS, and rl):**
```bash
cat input.sam | samstrip --keep NM AS rl > output.sam
```

**Remove all auxiliary tags:**
```bash
cat input.sam | samstrip --keep > output.sam
```

**Remove only specific tags (e.g., MD):**
```bash
cat input.sam | samstrip --remove MD > output.sam
```

## Best Practices and Tips

*   **Header Requirement**: samstrip expects a SAM header by default to prevent accidental data loss (as headers are required for BAM conversion). If your input lacks a header, you must use the `--noheader` flag, though this is generally discouraged for standard bioinformatics pipelines.
*   **BAM Conversion**: Always remember to use `samtools view -h` when piping into samstrip. If you forget the `-h`, samstrip will throw an error unless `--noheader` is specified.
*   **Storage Optimization**: Use samstrip for "intermediate" alignment files or for visualization tracks (like BigWig generation or coverage plots) where the actual read sequence is redundant.
*   **Tag Conflicts**: The `--keep` and `--remove` flags are mutually exclusive. Choose the one that requires the shortest list of arguments for your specific use case.

## Reference documentation
- [samstrip GitHub Repository](./references/github_com_jakobnissen_samstrip.md)
- [samstrip Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_samstrip_overview.md)