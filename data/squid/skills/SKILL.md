---
name: squid
description: SQUID identifies structural variations in transcriptomic data by modeling the transcriptome as a segment graph and using integer linear programming to determine optimal genomic arrangements. Use when user asks to detect transcriptomic structural variations, identify gene fusions, or reconstruct rearranged sequences from RNA-seq alignments.
homepage: https://github.com/Kingsford-Group/squid
metadata:
  docker_image: "quay.io/biocontainers/squid:1.5--hd6d6473_10"
---

# squid

## Overview
SQUID is a computational tool designed to identify structural variations within transcriptomic data. It goes beyond simple fusion detection by modeling the transcriptome as a segment graph and using integer linear programming (ILP) to determine the optimal arrangement of genomic segments. It is compatible with major aligners like STAR and BWA and can output both the predicted breakpoints and the reconstructed rearranged sequences.

## Installation
SQUID is available via Bioconda:
```bash
conda install bioconda::squid
```

## Common CLI Patterns

### STAR Alignment Workflow
When using STAR, concordant and chimeric alignments are often separated. SQUID requires the concordant BAM to be sorted.
```bash
squid -b sorted_concordant_alignment.bam -c chimeric.bam -o output_prefix
```

### BWA or SpeedSeq Workflow
For aligners that produce a single combined BAM file containing both concordant and discordant alignments, use the `--bwa` flag:
```bash
squid --bwa -b combined_alignment.bam -o output_prefix
```

### Generating Rearranged Sequences
To obtain the FASTA sequence of the rearranged genome based on detected variations, enable the rearranged genome flag:
```bash
squid -b input.bam -o output_prefix -RG 1 -TO 1
```

## Parameter Tuning and Best Practices

### Filtering and Quality Control
*   **Mapping Quality (`-mq`)**: Default is 1. Increase this (e.g., `-mq 20`) to reduce false positives from multi-mapping reads.
*   **Edge Weight (`-w`)**: This defines the minimum number of supporting reads required for a structural variation. Increase this for higher confidence in high-depth datasets.
*   **Phred Score (`-pt`)**: Ensure the correct Phred type is set (0 for Phred33, 1 for Phred64). Most modern Illumina data uses Phred33.

### Output Files
*   **`[prefix]_sv.txt`**: The primary output in BEDPE format. Positions are 0-based.
    *   Columns 1-3: First breakpoint (Chr, Start, End).
    *   Columns 4-6: Second breakpoint (Chr, Start, End).
    *   Column 8: Number of supporting reads.
    *   Columns 9-10: Strands of the segments.
*   **`[prefix]_graph.txt`**: Contains the genome segment graph (nodes and edges) if `-G 1` is set.
*   **`[prefix]_genome.fa`**: The rearranged sequence, generated only if `-RG 1` is set.

### Expert Tips
*   **Memory Management**: For very large BAM files, SQUID's ILP step can be resource-intensive. Ensure the system has sufficient RAM or pre-filter the BAM for discordant reads if necessary.
*   **Read-throughs**: The `-di` parameter (default 20) controls the maximum distance of segment indexes to be counted as a read-through. Adjust this if you are specifically looking for or trying to filter out local read-through events.

## Reference documentation
- [SQUID GitHub Repository](./references/github_com_Kingsford-Group_squid.md)
- [Bioconda SQUID Overview](./references/anaconda_org_channels_bioconda_packages_squid_overview.md)