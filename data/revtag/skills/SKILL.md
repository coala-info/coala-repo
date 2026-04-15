---
name: revtag
description: revtag corrects the orientation of custom SAM tags in BAM files to ensure they match the genomic orientation for negative-strand alignments. Use when user asks to reverse or reverse-complement custom SAM tags, correct tag orientation for single-cell or long-read data, or process per-base metrics in alignment files.
homepage: https://github.com/clintval/revtag
metadata:
  docker_image: "quay.io/biocontainers/revtag:1.0.0--h3ab6199_0"
---

# revtag

## Overview
`revtag` is a specialized bioinformatics utility designed to correct the orientation of custom SAM tags. While standard fields like SEQ and QUAL are typically handled by alignment software, custom tags—often used in single-cell protocols or long-read chemistries to store per-base information—frequently remain in their original physical orientation regardless of the mapping strand. This tool ensures these tags match the genomic orientation by selectively reversing or reverse-complementing them for negative-strand alignments.

## Command Line Usage

### Basic Syntax
The tool requires an input BAM, an output path, and a list of tags to transform.

```bash
revtag -i input.bam -o output.bam --rev [TAGS] --revcomp [TAGS]
```

### Key Arguments
- `-i, --input`: Path to the input SAM/BAM file.
- `-o, --output`: Path to the output SAM/BAM file.
- `--rev`: A space-separated list of two-letter SAM tags that should be reversed (e.g., quality scores, per-base error probabilities).
- `--revcomp`: A space-separated list of two-letter SAM tags that should be reverse-complemented (e.g., nucleotide sequences).
- `-t, --threads`: Number of threads to use for compression and decompression (highly recommended for large BAM files).

## Common Patterns and Best Practices

### Processing Single-Cell or Long-Read Tags
When working with data that stores per-base metrics in tags (like those produced by PacBio or specific single-cell pipelines), use the following pattern:

```bash
revtag -i in.bam -o out.bam \
  --rev 'ad' 'ae' 'aq' \
  --revcomp 'ac' 'bc'
```

### Identifying Tag Types
- **Use `--rev`** for tags containing quality strings (like `aq`) or numeric arrays where only the order matters.
- **Use `--revcomp`** for tags containing DNA sequences (like `ac`) where the base identity must be complemented to match the reference strand.

### Performance Optimization
Since BAM processing is I/O and compression intensive, always specify threads if the environment allows:
```bash
revtag -i input.bam -o output.bam -t 8 --rev 'bd' --revcomp 'bc'
```

## Expert Tips
- **Strand Specificity**: `revtag` only modifies records where the alignment is on the negative strand (SAM flag 16). Positive strand alignments are passed through unchanged.
- **Tag Validation**: Ensure the tags provided are exactly two characters long. Common tags include `bd` (base delay), `bq` (base quality), and `bc` (barcode sequence).
- **Compatibility**: The tool is written in Rust and is available via Bioconda, making it suitable for high-performance pipeline integration.

## Reference documentation
- [revtag Overview](./references/anaconda_org_channels_bioconda_packages_revtag_overview.md)
- [revtag GitHub Repository](./references/github_com_clintval_revtag.md)