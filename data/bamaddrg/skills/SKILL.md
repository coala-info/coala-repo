---
name: bamaddrg
description: bamaddrg is a specialized tool for injecting Read Group metadata into BAM files on the fly.
homepage: https://github.com/ekg/bamaddrg
---

# bamaddrg

## Overview
bamaddrg is a specialized tool for injecting Read Group metadata into BAM files on the fly. In bioinformatics workflows, downstream analysis tools often require specific `@RG` tags to differentiate between samples, libraries, and sequencing runs. bamaddrg allows you to "fix up" these tags while merging multiple files into a single stream, eliminating the need for creating large, temporary intermediate BAM files. It reads one or more BAM files and outputs a single, merged BAM stream to stdout.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::bamaddrg
```

## Common CLI Patterns

### Standard Tagging
To add a specific sample name and read group ID to a single BAM file:
```bash
bamaddrg -b input.bam -s SampleA -r Group1 > output.bam
```

### Merging Multiple Samples for Streaming
This is the primary use case for the tool. You can specify multiple `-b` flags, each followed by its specific metadata. The output is a merged stream.
```bash
bamaddrg -b file1.bam -s jill -r group.s1.1 \
         -b file2.bam -s jill -r group.s1.2 \
         -b file3.bam -s bill \
         | freebayes -f ref.fa --stdin > variants.vcf
```
*   **file1 & file2**: Both assigned to sample "jill" but with distinct read groups.
*   **file3**: Assigned to sample "bill". Since no `-r` was provided, the read group ID defaults to "bill".

### Removing Existing Read Groups
If the input BAM files already contain incorrect or conflicting Read Group information, use the `--clear` flag to strip them before adding new ones:
```bash
bamaddrg --clear -b input.bam -s NewSample -r NewGroup > cleaned.bam
```

### Region-Specific Processing
To process only a specific genomic region across the input files:
```bash
bamaddrg -region chr20:1000000-2000000 -b file1.bam -s S1 -b file2.bam -s S2 > region.bam
```

## Expert Tips
- **Streaming Efficiency**: Always prefer piping the output of `bamaddrg` directly into your next tool (like `samtools` or `freebayes`) to save disk space and reduce I/O overhead.
- **Default Behavior**: If you omit the `-s` (sample) or `-r` (read group) flags, `bamaddrg` will use the input file's name as the default value for those tags.
- **Uncompressed Output**: If you are piping into another tool on the same machine, check if your version supports uncompressed BAM output to save CPU cycles on compression.
- **Header Merging**: The tool automatically handles the merging of BAM headers, ensuring that the resulting stream has a valid header containing all new `@RG` entries.

## Reference documentation
- [bamaddrg GitHub Repository](./references/github_com_ekg_bamaddrg.md)
- [Bioconda bamaddrg Overview](./references/anaconda_org_channels_bioconda_packages_bamaddrg_overview.md)
- [bamaddrg Commit History](./references/github_com_ekg_bamaddrg_commits_master.md)