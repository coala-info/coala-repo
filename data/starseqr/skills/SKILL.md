---
name: starseqr
description: STAR-SEQR is a pipeline that detects and quantifies RNA fusion events using STAR alignment and de novo assembly. Use when user asks to identify gene fusion partners, detect breakpoints, or quantify fusion transcripts from RNA-seq data.
homepage: https://github.com/ExpressionAnalysis/STAR-SEQR
metadata:
  docker_image: "quay.io/biocontainers/starseqr:0.6.7--py36h7eb728f_0"
---

# starseqr

## Overview

STAR-SEQR is a specialized pipeline for the detection and quantification of RNA fusion events. It utilizes the STAR aligner for mapping and incorporates Velvet for de novo assembly of chimeric reads to provide high-confidence fusion calls. The tool is designed for efficiency, typically completing post-alignment processing in under 20 minutes. It is ideal for researchers needing to identify gene fusion partners, breakpoints, and splice types (canonical vs. non-canonical) from paired-end RNA-seq data.

## Installation and Dependencies

Ensure the following dependencies are available in your environment:
- **Core Tools**: STAR (>2.5.3a), Velvet, samtools, Salmon.
- **Utilities**: biobambam2, gffread, UCSC utils (gtftogenepred).

Install via Bioconda for the simplest setup:
```bash
conda install -c bioconda starseqr
```

## Building the STAR Index

Before running the fusion detection pipeline, generate a STAR index specifically tuned for RNA-seq.

```bash
STAR --runMode genomeGenerate \
     --genomeFastaFiles reference.fa \
     --genomeDir STAR_INDEX_DIR \
     --sjdbGTFfile annotation.gtf \
     --runThreadN 12 \
     --sjdbOverhang 100 \
     --genomeSAsparseD 1
```

## Running the Fusion Pipeline

The primary command is `starseqr.py`. Use **Mode 1** to perform both alignment and fusion calling.

### Standard CLI Pattern
```bash
starseqr.py -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz \
            -m 1 \
            -p output_prefix \
            -t 12 \
            -i /path/to/STAR_INDEX \
            -g annotation.gtf \
            -r reference.fa \
            -vv
```

### Key Parameters
- `-m`: Mode. Use `1` for full alignment and fusion calling.
- `-p`: Output prefix or path. Note: When using Docker, this must be a fully qualified path.
- `-t`: Number of worker threads.
- `-i`: Path to the STAR index directory.
- `-g`: Path to the transcript GTF file.
- `-r`: Path to the reference genome FASTA file.

## Interpreting Outputs

The tool produces several key files in the output directory:

1.  **BEDPE File**: A standard format compatible with the SMC-RNA Dream Challenge and most genomic browsers.
2.  **Breakpoints.txt / Candidates.txt**: Tab-delimited files containing detailed fusion metadata.

### Critical Output Columns
- **NREAD_SPANS**: Number of discordant spanning paired reads supporting the fusion.
- **NREAD_JXNLEFT/RIGHT**: Number of reads anchored on the left or right side of the junction.
- **FUSION_CLASS**: Classification (e.g., TRANSLOCATION, READ_THROUGH, INTERCHROM_INVERTED).
- **SPLICE_TYPE**: Indicates if the breakpoint is CANONICAL (on exon boundary) or NON-CANONICAL.
- **TPM_FUSION**: Expression level of the most abundant fusion transcript.
- **DISPOSITION**: A "PASS" value indicates a high-confidence call; other values provide reasons for failure.

## Best Practices

- **Thread Allocation**: Use at least 8-12 threads for optimal performance during the STAR alignment and Velvet assembly phases.
- **Memory Management**: Ensure the system has enough RAM to load the STAR index (typically 30GB+ for human genomes).
- **Read Length**: Set the `--sjdbOverhang` during index generation to `ReadLength - 1` for maximum sensitivity.
- **Docker Usage**: If using the Docker container, always mount your data volumes and use absolute paths for the `-p` (prefix) argument to ensure outputs are written correctly to the host.

## Reference documentation
- [STAR-SEQR GitHub Repository](./references/github_com_ExpressionAnalysis_STAR-SEQR.md)
- [Bioconda starseqr Overview](./references/anaconda_org_channels_bioconda_packages_starseqr_overview.md)