---
name: mark-nonconverted-reads
description: The `mark-nonconverted-reads` tool is a specialized filter for epigenetic sequencing workflows.
homepage: https://github.com/nebiolabs/mark-nonconverted-reads
---

# mark-nonconverted-reads

## Overview
The `mark-nonconverted-reads` tool is a specialized filter for epigenetic sequencing workflows. In bisulfite-treated DNA, cytosines (Cs) that are not in a CpG context should be converted to uracil (and subsequently read as thymine). If a read contains multiple unconverted cytosines in these non-CpG positions, it often indicates a failure in the chemical conversion process rather than biological methylation. This tool identifies these problematic reads, adds a specific SAM tag (`XX:Z:UC`), and can optionally set the vendor-fail flag to ensure they are excluded from downstream methylation calling.

## Usage Patterns

### Basic Filtering
By default, the tool reads from `stdin` and writes to `stdout`. It looks for 3 or more nonconverted Cs to mark a read.

```bash
samtools view -h input.bam | mark-nonconverted-reads.py --reference genome.fasta > marked_output.sam
```

### Flagging Reads for Downstream Exclusion
To ensure that downstream tools (like `samtools` or methylation callers) automatically ignore these reads, use the `--flag_reads` option. This sets the "Failing platform / vendor quality check" bit (0x200) in the SAM flag.

```bash
mark-nonconverted-reads.py --bam input.bam --reference genome.fasta --flag_reads --out filtered.sam
```

### Adjusting Sensitivity
If your experiment has a higher tolerance or requires stricter filtering, adjust the `--c_count` threshold.

```bash
# Be more conservative: only mark reads with 5 or more nonconverted Cs
mark-nonconverted-reads.py --bam input.bam --reference genome.fasta --c_count 5 --out strict_filtered.sam
```

## Expert Tips and Best Practices

*   **Reference Detection**: If you used `bwameth` for alignment, the tool can often find the reference fasta path automatically by inspecting the BAM header. If not, you must provide it explicitly via `--reference`.
*   **Read Pairing**: This tool treats every read independently. It does not check if a read's mate is also nonconverted. If one read in a pair is marked, the other may still be used unless the downstream tool filters by the 0x200 flag on either mate.
*   **Performance**: The tool prints summary information, including a count of nonconverted reads per contig, to `stderr`. Monitor this output to assess the overall conversion efficiency of your library.
*   **File Formats**: While the tool can read `.bam` or `.sam` files, the output is currently written as a SAM stream. You may need to pipe the output back into `samtools view -b` to save space.

## Reference documentation
- [mark-nonconverted-reads GitHub README](./references/github_com_nebiolabs_mark-nonconverted-reads.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mark-nonconverted-reads_overview.md)