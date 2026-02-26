---
name: samcut
description: "samcut is a utility that extracts specific fields and tags from SAM files by name and decomposes bitwise flags into readable formats. Use when user asks to select SAM fields by name, extract optional tags, convert bitwise flags to human-readable strings, or expand flags into individual boolean columns."
homepage: https://github.com/gshiba/samcut
---


# samcut

## Overview
samcut is a specialized utility designed to function like the Unix `cut` command but with native awareness of the SAM (Sequence Alignment/Map) format. It eliminates the need to remember column positions by allowing you to select fields by name. It also provides advanced features for decomposing bitwise flags into readable strings or individual boolean columns, making it an essential tool for quick data exploration and preparation of alignment data for downstream analysis in tools like R or Python.

## Command Line Usage

### Basic Field Selection
Pipe the output of `samtools view` into `samcut` followed by the desired field names.
```bash
samtools view input.bam | samcut qname flag rname pos cigar
```

### Working with Headers
Use the `-H` flag to include a header row in the output, which is helpful when piping into `column -t` for readability.
```bash
samtools view input.bam | samcut -H qname pos cigar | column -t
```

### Extracting SAM Tags
samcut can extract optional tags by their two-letter codes. If a tag is missing for a record, it defaults to a dot (`.`).
```bash
samtools view input.bam | samcut qname MD NM AS
```

### Flag Decomposition
One of samcut's most powerful features is its ability to handle the bitwise FLAG field:
- **`flags`**: Converts the integer flag into a comma-separated list of human-readable strings (e.g., "paired,proper_pair,read1").
- **`flagss`**: Expands the flag into 12 individual columns (one for each bit), which is ideal for statistical analysis of alignment properties.

```bash
# Get readable flag descriptions
samtools view input.bam | samcut qname flags

# Expand all flag bits into separate columns
samtools view input.bam | samcut -H flagss
```

### Special Keywords
- **`std`**: Expands to the standard 11 SAM columns (qname, flag, rname, pos, mapq, cigar, rnext, pnext, tlen, seq, qual).
- **`n`**: Adds a 1-based line index to the output.

```bash
# Get standard columns plus a specific tag
samtools view input.bam | samcut std MD
```

## Best Practices and Tips

- **Missing Values**: If you are working with sparse tags, use `-i <string>` to change the default fill character from a dot to something else (e.g., `NA` or `0`).
- **Custom Delimiters**: Use `-d` to change the output delimiter if you need to generate CSVs or other formats.
- **Combining with Unix Tools**: samcut is designed for pipes. Use it with `sort | uniq -c` to quickly generate histograms of flags or tags.
  ```bash
  # Count occurrences of different flag combinations
  samtools view input.bam | samcut flags | sort | uniq -c | sort -nr
  ```
- **Standard Field Names**:
  - Core: `qname`, `flag`, `rname`, `pos`, `mapq`, `cigar`, `rnext`, `pnext`, `tlen`, `seq`, `qual`.
  - Flag bits: `paired`, `proper_pair`, `unmap`, `munmap`, `reverse`, `mreverse`, `read1`, `read2`, `secondary`, `qcfail`, `dup`, `supplementary`.

## Reference documentation
- [samcut Overview](./references/anaconda_org_channels_bioconda_packages_samcut_overview.md)
- [samcut GitHub Repository](./references/github_com_gshiba_samcut.md)