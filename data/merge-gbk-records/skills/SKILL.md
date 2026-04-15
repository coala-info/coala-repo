---
name: merge-gbk-records
description: This tool concatenates multiple GenBank records into a single continuous record with customizable spacer sequences. Use when user asks to merge fragmented genomic data, create scaffolds from contigs, or unify multi-record GenBank files.
homepage: http://github.com/kblin/merge-gbk-records
metadata:
  docker_image: "quay.io/biocontainers/merge-gbk-records:0.2.0--pyhdfd78af_0"
---

# merge-gbk-records

## Overview
The `merge-gbk-records` utility is a specialized tool for unifying fragmented genomic data. It takes multiple GenBank records—whether they are stored in separate files or within a single multi-record file—and concatenates them into a single, continuous record. This is essential for creating scaffolds from contigs or preparing data for downstream analysis tools that require a single-record input. The tool automatically handles the insertion of spacer sequences to maintain biological context and prevent artificial ORF creation across junctions.

## Usage Patterns

### Basic Merging
To merge multiple files and output to a new file:
`merge-gbk-records input1.gbk input2.gbk -o merged.gbk`

If no output file is specified with `-o`, the tool writes to `stdout`, which is useful for piping:
`merge-gbk-records input1.gbk input2.gbk > merged.gbk`

### Customizing Spacers
By default, the tool inserts a 20 kbp spacer of 'N' characters. You can modify this behavior using the following flags:

- **Adjust Length**: Use `-l` or `--length` to specify the spacer size in kilobases (kbp).
  `merge-gbk-records --length 5 input1.gbk input2.gbk`
- **Stop Codon Spacers**: To ensure no read-through between merged records, use all-frame stop codons instead of 'N's.
  `merge-gbk-records --spacer stop input1.gbk input2.gbk`

### Expert Tips
- **Small Gaps**: In version 0.2.0 and later, you can use non-integer values for length. For example, `-l 0.1` creates a 100 bp spacer. Note that values are rounded down to the next integer base pair (e.g., 0.0001 would result in a 0 bp spacer).
- **Multi-record Files**: The tool can accept a single file containing multiple GenBank records (multi-GenBank format) and will merge all internal records into one.
- **Concatenation Order**: Records are merged in the order they are provided in the command line arguments. Ensure your file list is sorted if genomic orientation is important.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_merge-gbk-records_overview.md)
- [GitHub Repository README](./references/github_com_kblin_merge-gbk-records.md)
- [Release Tags and Version History](./references/github_com_kblin_merge-gbk-records_tags.md)