---
name: finaletoolkit
description: FinaleToolkit is a computational suite designed to extract and analyze fragmentation features such as fragment lengths, end motifs, and nucleosome positioning from cell-free DNA alignment data. Use when user asks to calculate motif diversity scores, generate DELFI profiles, compute windowed protection scores, or analyze fragment length distributions and cleavage patterns.
homepage: https://github.com/epifluidlab/FinaleToolkit
---


# finaletoolkit

## Overview

FinaleToolkit (FragmentatIoN AnaLysis of cEll-free DNA Toolkit) is a high-performance computational suite designed to standardize the extraction of biological signals from cfDNA. It transforms raw alignment data into interpretable fragmentation features such as Motif Diversity Scores (MDS), DELFI profiles, and cleavage patterns. This skill provides the necessary CLI patterns and procedural knowledge to execute these complex genomic analyses efficiently.

## Core Workflows

### 1. Fragment Length Analysis
To extract fragment length distributions across the genome or specific bins:

```bash
# Generate fragment length bins for plotting a distribution
finaletoolkit frag-length-bins <input.bam> \
    --min 50 --max 300 --bin-size 1 \
    -q 30 --output_file output_lengths.tsv
```

### 2. Motif Analysis
Extracting end motifs (the sequences at the ends of fragments) is critical for identifying nuclease activity:

*   **End Motifs**: Calculates the frequency of k-mers at fragment ends.
*   **MDS (Motif Diversity Score)**: Measures the complexity of end motifs.

```bash
# Calculate end motifs for 4-mers
finaletoolkit end-motifs <input.bam> --kmer 4 --output_file motifs.tsv
```

### 3. Windowed Protection Score (WPS)
WPS is used to infer nucleosome positioning by calculating the number of fragments spanning a window minus those ending within it.

```bash
# Calculate WPS for a specific region
finaletoolkit wps <input.bam> --interval <chr:start-stop> --window 120 --output_file wps_output.tsv
```

### 4. DELFI and Cleavage Profiles
*   **DELFI**: Calculates the ratio of short to long fragments across large genomic windows.
*   **Cleavage Profile**: Analyzes the frequency of fragment ends at specific genomic coordinates.

## Input Requirements & Best Practices

*   **File Formats**: Supports `.bam` (requires `.bai`), `.cram` (requires `.crai`), and block-gzipped BED3+2 `.frag.gz` (requires `.tbi`).
*   **Fragment Files**: For high-speed processing, use `.frag.gz` files. These should contain columns: `chrom`, `start`, `stop`, `mapq`, `strand`.
*   **Quality Filtering**: Always use the `-q` (mapping quality) flag (typically `-q 30`) to ensure results are not skewed by poorly mapped reads.
*   **Parallelization**: Many commands support multi-threading or chromosome-level parallelization to handle large WGS datasets.

## Common CLI Patterns

| Task | Command | Key Parameters |
| :--- | :--- | :--- |
| **Summary Stats** | `frag-length-bins` | `--summary-stats`, `--short-fraction` |
| **Breakpoint Motifs** | `breakpoint-motifs` | `--kmer` (default 6) |
| **Coverage** | `coverage` | `--bin-size` |
| **Filtering** | `filter-file` | `--blacklist` (to remove problematic regions) |



## Subcommands

| Command | Description |
|---------|-------------|
| finaletoolkit frag-length-intervals | Retrieves fragment length summary statistics over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file. |
| finaletoolkit-adjust-wps | Adjusts raw Windowed Protection Score (WPS) by applying a median filter and Savitsky-Golay filter. |
| finaletoolkit-agg-wps | Aggregates a bigWig signal over constant-length intervals defined in a BED file. |
| finaletoolkit-breakpoint-motifs | Measures frequency of k-mer breakpoint motifs. |
| finaletoolkit-cleavage-profile | Calculates cleavage proportion over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file. |
| finaletoolkit-delfi | Calculates DELFI features over genome, returning information about (GC-corrected) short fragments, long fragments, DELFI ratio, and total fragments. |
| finaletoolkit-delfi-gc-correct | Performs gc-correction on raw delfi data. This command is deprecated and will be removed in a future version of FinaleToolkit. The delfi command has gc correction on by default. |
| finaletoolkit-end-motifs | Measures frequency of k-mer 5' end motifs. |
| finaletoolkit-filter-file | Filters a BED/BAM/CRAM file so that all reads/intervals, when applicable,are in mapped pairs, exceed a certain MAPQ, are not flagged for quality, are read1, are not secondary or supplementary alignments, are within/excluding specified intervals, and are on the same reference sequence as the mate. |
| finaletoolkit-frag-length-bins | Retrieves fragment lengths grouped in bins given a BAM/CRAM/Fragment file. |
| finaletoolkit-gap-bed | Creates a BED4 file containing centromeres, telomeres, and short-arm intervals, similar to the gaps annotation track for hg19 found on the UCSC Genome Browser (Kent et al 2002). Currently only supports hg19, b37, human_g1k_v37, hg38, and GRCh38 |
| finaletoolkit-interval-ebreakpointnd-motifs | Measures frequency of k-mer 5' breakpoint motifs in each region specified in a BED file and writes data into a table. |
| finaletoolkit-interval-end-motifs | Measures frequency of k-mer 5' end motifs in each region specified in a BED file and writes data into a table. |
| finaletoolkit-interval-mds | Reads k-mer frequencies from a file and calculates a motif diversity score (MDS) for each interval using normalized Shannon entropy as described by Jiang et al (2020). |
| finaletoolkit-wps | Calculates Windowed Protection Score (WPS) over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file. |
| finaletoolkit_coverage | Calculates fragmentation coverage over intervals defined in a BED file based on alignment data from a BAM/CRAM/Fragment file. |
| mds | Calculate the frequency of end motifs in fragments. |

## Reference documentation
- [FinaleToolkit GitHub Overview](./references/github_com_epifluidlab_FinaleToolkit.md)
- [Quick Start Guide](./references/github_com_epifluidlab_FinaleToolkit_wiki_Quick-Start.md)
- [CLI/API Documentation](./references/github_com_epifluidlab_FinaleToolkit_wiki_CLI-API-Documentation.md)
- [Fragment Length Tutorial](./references/github_com_epifluidlab_FinaleToolkit_wiki_2a.md)
- [Windowed Protection Score Details](./references/github_com_epifluidlab_FinaleToolkit_wiki_Windowed-Protection-Score.md)