---
name: dr-disco
description: dr-disco identifies fusion genes and genomic breakpoints from RNA-sequencing data by analyzing both exonic and intronic reads. Use when user asks to identify fusion genes, pinpoint genomic breakpoints, detect fusions from RNA-seq data, or classify and annotate transcriptomic structural variations.
homepage: https://github.com/yhoogstrate/dr-disco
---

# dr-disco

## Overview

dr-disco is a computational framework designed to identify fusion genes and their underlying genomic breakpoints using RNA-sequencing data. Unlike standard fusion callers that focus primarily on exonic splice junctions, dr-disco utilizes intronic reads (often present in rRNA-depleted libraries) to pinpoint the exact location of DNA breaks. It employs a graph-based analysis to handle sequencing fragments, multiple exon boundaries, and fusions to non-annotated regions, making it highly effective for discovering complex structural variations from transcriptomic data alone.

## Workflow and CLI Usage

The dr-disco pipeline follows a specific five-step sequence. Ensure you have STAR and samtools installed in your environment.

### 1. Initial Alignment (STAR)
Generate chimeric reads using STAR in fusion mode. Recommended parameters for compatibility:
- `--chimSegmentMin 12`
- `--chimJunctionOverhangMin 12`
- `--outSAMstrandField intronMotif`

### 2. Fix Chimeric SAM
Prepare the STAR output for analysis. This step standardizes the chimeric SAM/BAM file.
```bash
# Convert SAM to BAM if necessary
samtools view -bhS Chimeric.out.sam > Chimeric.out.bam

# Run the fix command
dr-disco fix Chimeric.out.bam Chimeric.fixed.bam
```

### 3. Detect Fusion Events
Identify potential fusion junctions and merge similar transcripts.
```bash
dr-disco detect --input Chimeric.fixed.bam --output junctions.bed
```

### 4. Classify and Filter
Apply statistical filters and reference-specific blacklists to remove artifacts and false positives.
```bash
dr-disco classify --input junctions.bed --output junctions.classified.txt --blacklist blacklist_folder/
```
*Tip: Use the `--ffpe` flag if working with FFPE samples to adjust mismatch stringency.*

### 5. Integrate and Annotate
Merge results from the same genomic event and annotate with gene names using a GTF file.
```bash
dr-disco integrate --input junctions.classified.txt --gtf genes.gtf --fasta reference.fa --output final_fusions.txt
```

## Expert Tips and Best Practices

- **Mate Pair Orientation**: STAR requires `FR` orientation (_R1: forward, _R2: reverse). If your data is different, use `fastx_reverse_complement` to adjust the strands before running STAR.
- **NextSeq Data**: Illumina NextSeq platforms often produce poly-G artifacts. Pre-clean your FASTQ files with `fastp` to remove poly-G suffixes, as these can cause false discordant alignments.
- **Intronic Coverage**: This tool is most powerful when used with rRNA-depleted (ribo-minus) RNA-seq data, as this library type contains pre-mRNA that covers intronic regions where most DNA breaks occur.
- **Blacklist Sensitivity**: Ensure your blacklist files match your reference genome's 'chr' prefixing (e.g., "chr1" vs "1"). Recent versions of dr-disco are prefix-insensitive, but consistency is recommended.
- **Visualization**: The `fix` command resolves issues with `SA:Z:` tags that previously caused panels to disappear in older versions of IGV.



## Subcommands

| Command | Description |
|---------|-------------|
| dr-disco | Command-line tool for disco identification and analysis. |
| dr-disco bam-extract | Extracts reads from BAM files that overlap with specified regions. |
| dr-disco classify | Classify junctions based on alignment data. |
| dr-disco detect | Detects potential discoidin domains in BAM input files. |
| dr-disco fix | Fixes an alignment file by removing duplicate reads. |
| dr-disco integrate | Integrates gene annotation and reference sequences for fusion gene estimation and classification. |
| dr-disco is-blacklisted | When only a single position is given, only matches with blacklisted regions from blacklist_regions will be reported. |
| dr-disco logo-sequence | Generate logo sequences for regions. |
| dr-disco subtract | Subtracts alignments from another alignment file. |
| dr-disco unfix | Unfixes alignment files. |

## Reference documentation
- [Dr. Disco README](./references/github_com_yhoogstrate_dr-disco_blob_master_README.md)
- [Dr. Disco Changelog](./references/github_com_yhoogstrate_dr-disco_blob_master_Changelog.md)