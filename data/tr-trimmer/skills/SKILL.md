---
name: tr-trimmer
description: tr-trimmer detects and removes terminal repeats from FASTA sequences. Use when user asks to trim terminal repeats, identify direct or inverted terminal repeats, check for circularity, filter repeats by quality, or report repeat information.
homepage: https://github.com/apcamargo/tr-trimmer
metadata:
  docker_image: "quay.io/biocontainers/tr-trimmer:0.4.0--h4349ce8_0"
---

# tr-trimmer

## Overview

The `tr-trimmer` tool is a specialized utility for bioinformaticians working with FASTA files. It detects and removes terminal repeats—sequences that appear at both ends of a linear sequence. This is essential for identifying circular genomes (which often show Direct Terminal Repeats or DTRs in assemblies) and characterizing viral or transposon ends (which often feature Inverted Terminal Repeats or ITRs).

## Command Line Usage

### Basic Trimming
By default, the tool identifies and trims Direct Terminal Repeats (DTRs).
```bash
tr-trimmer input.fasta > trimmed.fasta
```

### Identifying Inverted Repeats (ITRs)
To detect ITRs (common in many viruses and transposons), you must explicitly enable the identification flag.
```bash
tr-trimmer --enable-itr-identification input.fasta
```

### Filtering and Quality Control
Use these flags to avoid false positives caused by low-complexity regions or sequencing artifacts:
- **Min Length**: Set the minimum repeat size (default is 21bp).
  `tr-trimmer -l 50 input.fasta`
- **Complexity**: Ignore repeats that are mostly low-complexity sequences.
  `tr-trimmer --ignore-low-complexity --max-low-complexity-frac 0.3 input.fasta`
- **Ambiguity**: Filter out repeats containing too many 'N' bases.
  `tr-trimmer --ignore-ambiguous --max-ambiguous-frac 0.05 input.fasta`

### Reporting and Metadata
If you want to analyze the repeats without modifying the original sequences:
- **Add Info**: Append repeat type and length to the FASTA headers.
  `tr-trimmer --include-tr-info input.fasta`
- **Dry Run**: Identify repeats and report them in headers but do NOT trim the sequence.
  `tr-trimmer --include-tr-info --disable-trimming input.fasta`
- **Filter Only**: Keep only the sequences where a terminal repeat was actually found.
  `tr-trimmer --exclude-non-tr-seqs input.fasta`

## Expert Tips
- **Circularization Check**: When checking if a contig is circular, use `--include-tr-info`. If a DTR is found that matches the expected overlap of your assembler, it is a strong signal of circularity.
- **ITR vs DTR**: If you enable ITR identification (`-i`), the tool will still look for DTRs unless you specifically disable them with `-d`.
- **Piping**: The tool supports stdin/stdout, making it easy to integrate into shell pipelines:
  `cat sequences.fasta | tr-trimmer -l 30 - > cleaned.fasta`

## Reference documentation
- [tr-trimmer GitHub Repository](./references/github_com_apcamargo_tr-trimmer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tr-trimmer_overview.md)