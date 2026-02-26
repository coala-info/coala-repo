---
name: transcriptm
description: The transcriptm tool processes raw metatranscriptomic reads to generate normalized gene expression counts against a reference metagenome. Use when user asks to 'process metatranscriptomic data', 'quantify gene expression in microbial populations', 'map metatranscriptomic reads to a metagenome', or 'normalize gene expression counts'.
homepage: https://github.com/elfrouin/transcriptM
---


# transcriptm

## Overview
The transcriptm tool is a specialized pipeline designed to process metatranscriptomic data in the context of a reference metagenome. It automates the transition from raw paired-end Illumina reads to normalized gene expression counts. The workflow includes quality trimming, removal of non-coding RNA (rRNA, tRNA, tmRNA) and contaminants (PhiX), and high-stringency mapping against metagenomic assembly contigs. It is particularly useful for researchers looking to quantify the activity of specific microbial populations (bins) within a community.

## CLI Usage and Best Practices

### Core Command Structure
To run a standard analysis, provide the paired-end reads, the reference metagenome assembly, and the directory containing the annotated bins (GFF format).

```bash
transcriptm --paired_end sample1_R1.fq.gz sample1_R2.fq.gz \
            --metaG_contigs assembly.fa \
            --dir_bins ./gff_bins/ \
            --db_path ./databases/ \
            --output_dir ./results/
```

### Input Requirements
- **Paired-end Reads**: Must be in `.fq.gz` format. List multiple samples sequentially; the tool handles them as pairs.
- **Metagenome Contigs**: A single FASTA file containing all contigs from the reference metagenome.
- **Bins Directory**: A directory containing GFF files. Each GFF should represent an annotated population genome (bin). Files in other formats in this directory are ignored.
- **Databases**: Ensure the `--db_path` contains the required adapter sequences, PhiX genome, and SortMeRNA-indexed ribosomal sequences.

### Tuning Mapping Stringency
By default, transcriptm uses high stringency to ensure reads are correctly assigned to their source genomes. You can adjust these parameters based on the evolutionary distance between your metatranscriptome and metagenome:
- Use `--percentage_id` (default 0.97) to set the minimum base identity.
- Use `--percentage_aln` (default 0.95) to set the minimum percentage of the read that must be aligned.
- Use `--no_mapping_filter` if you wish to skip the BamM-based alignment filtering entirely.

### Performance Optimization
- **Threading**: Use `--threads` (default 20) to match your hardware capabilities.
- **Working Directory**: Use `--working_dir` to point to a high-speed local scratch disk (e.g., `/tmp` or an NVMe drive) to reduce I/O bottlenecks during intermediate file processing.

### Quality Control and Trimming
The tool uses Trimmomatic internally. You can pass specific flags to refine the cleaning process:
- `--adapters`: Choose between `truseq` (default) or `nextera`.
- `--min_len`: Set the minimum read length (default 30).
- `--min_avg_qc`: Set the sliding window quality threshold (default 25).

## Interpreting Outputs
- **TranscriptM_output_COUNT.csv**: Contains raw mapped read counts per gene. Use this for downstream differential expression tools like DESeq2.
- **TranscriptM_output_NORM_COVERAGE.csv**: Provides average coverage per gene normalized by the total number of mapped reads. This is useful for comparing expression levels across different samples.
- **summary_reads**: Review this file to see the distribution of reads after each step (trimming, rRNA removal, mapping). It is the primary resource for troubleshooting low mapping rates.

## Reference documentation
- [transcriptm - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_transcriptm_overview.md)
- [GitHub - elfrouin/transcriptM](./references/github_com_elfrouin_transcriptM.md)