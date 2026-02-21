---
name: rdeval
description: `rdeval` is a high-performance, multithreaded utility designed for the rapid assessment and transformation of genomic read data.
homepage: https://github.com/vgl-hub/rdeval
---

# rdeval

## Overview
`rdeval` is a high-performance, multithreaded utility designed for the rapid assessment and transformation of genomic read data. It serves as a comprehensive tool for calculating essential quality metrics—such as read N50, total length, and GC content—while allowing for seamless conversion between common sequence formats. It is optimized for speed and can handle compressed inputs directly, making it an ideal first step in genomic assembly or QC pipelines.

## Common CLI Patterns

### Basic Summary Statistics
To generate a standard report including read counts, lengths, and N50:
```bash
rdeval input.fastq.gz
```

### Calculating Coverage
To include coverage metrics, provide the expected genome size (in bp) as the second argument:
```bash
rdeval input.bam 3100000000
```

### PacBio CiFi Processing
`rdeval` supports in-silico digestion of PacBio CiFi reads using specific enzyme motifs.

**In-silico digestion:**
```bash
rdeval --cifi-enzyme DpnII cifi_reads.fastq -o digested_output.fastq
```

**Generating all fragment combinations:**
```bash
rdeval --cifi-enzyme DpnII --cifi-out-combinations input.fastq -p output_prefix_
```

## Expert Tips and Best Practices

*   **Format Versatility**: `rdeval` supports `fa`, `fasta`, `fq`, `fastq` (and their gzipped versions), as well as `bam`, `cram`, and its native `rd` format. Use it as a fast converter between these formats by specifying the output file extension.
*   **Multithreading**: The tool is multithreaded by default. When running on high-core systems, ensure your I/O bandwidth can keep up with the processing speed, especially when handling large BAM or CRAM files.
*   **Native Binary Format**: The `.rd` format is `rdeval`'s native binary representation. If you are performing multiple analyses on the same dataset, converting to `.rd` first can speed up subsequent metadata extractions.
*   **Metric Definitions**:
    *   **N50**: The length such that 50% of the total sequence is contained in reads of this length or longer.
    *   **GC Content**: Calculated as the percentage of G and C bases relative to the total ACGT count.
*   **Testing**: Use the `-h` flag to see the full list of available metrics and flags, as the tool frequently updates to support new sequencing technologies like PacBio CiFi.

## Reference documentation
- [rdeval GitHub Repository](./references/github_com_vgl-hub_rdeval.md)
- [rdeval Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rdeval_overview.md)