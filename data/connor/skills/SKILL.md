---
name: connor
description: connor deduplicates paired-end BAM files by using inline Universal Molecular Tags to group reads into consensus alignments. Use when user asks to deduplicate BAM files using UMTs, generate consensus sequences from read families, or reduce technical noise in deep-sequencing data.
homepage: https://github.com/umich-brcf-bioinf/Connor
---


# connor

## Overview

connor is a specialized command-line tool for the deduplication of paired-end BAM files containing custom, inline barcodes. Unlike standard deduplication tools that rely solely on mapping coordinates, connor utilizes Universal Molecular Tags (UMTs) to group reads into "families." It then generates a single consensus alignment for each family, resolving base-call discrepancies through a majority-vote system. This process is essential for deep-sequencing applications where differentiating rare variants from technical noise is critical.

## Common CLI Patterns

### Basic Deduplication
The simplest usage requires only an input and output path. By default, connor assumes a 6bp UMT and a minimum family size of 3.
```bash
connor input.bam output.bam
```

### Adjusting UMT Parameters
If your library preparation uses a different barcode length or requires stricter matching (e.g., no mismatches allowed in the barcode), use the following:
```bash
connor input.bam output.bam --umt_length 8 --umt_distance_threshold 0
```

### Increasing Stringency for Rare Variant Detection
To reduce false positives in ultra-deep sequencing, increase the minimum family size and the consensus frequency threshold (the percentage of reads in a family that must agree on a base).
```bash
connor input.bam output.bam --min_family_size_threshold 5 --consensus_freq_threshold 0.8
```

### Generating Annotated BAMs for Debugging
To keep the original alignments while adding BAM tags that describe the family grouping, use the annotated output flag:
```bash
connor input.bam output.bam --annotated_output_bam annotated_original.bam
```

## Tool-Specific Best Practices

*   **Alignment Requirements**: connor assumes that the UMT barcode is still present at the beginning of the aligned sequences. Ensure your alignment pipeline does not trim these barcodes before running connor.
*   **Input Validation**: The tool expects properly paired alignments. If your BAM contains secondary alignments or is not sorted by coordinate, connor may issue warnings or produce suboptimal results.
*   **Handling Ambiguity**: The `--consensus_freq_threshold` (default 0.6) determines how base-call conflicts are handled. If the majority percentage is below this threshold, the consensus base is emitted as an `N`. Increase this value if you prioritize specificity over sensitivity.
*   **Family Size Filtering**: By default, families with fewer than 3 read pairs are excluded from the output. This is a critical step for removing PCR duplicates that lack sufficient evidence. If your library complexity is very low, you may need to lower `--min_family_size_threshold`, though this increases the risk of including errors.
*   **Log Analysis**: Always check the log file (generated at `{output_filename}.log` by default). It provides a summary of how many reads were filtered and the distribution of family sizes, which is a key metric for library complexity and sequencing depth efficiency.

## Reference documentation
- [Connor GitHub Repository](./references/github_com_umich-brcf-bioinf_Connor.md)
- [Connor Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_connor_overview.md)