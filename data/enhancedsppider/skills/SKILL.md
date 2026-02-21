---
name: enhancedsppider
description: EnhancedSppIDer is a bioinformatics suite designed to resolve the taxonomic composition of sequencing libraries.
homepage: https://github.com/JohnnyChen1113/EnhancedSppIDer
---

# enhancedsppider

## Overview

EnhancedSppIDer is a bioinformatics suite designed to resolve the taxonomic composition of sequencing libraries. It works by mapping reads against a combined reference genome composed of multiple candidate species. This approach allows for the precise identification of hybrids and the quantification of genomic contributions from different parents. Unlike its predecessor, this version supports long-read technologies (PacBio/ONT) and provides optimized workflows for extracting reads belonging to specific species after identification.

## Reference Preparation

Before running the pipeline, you must combine individual species FASTA files into a single indexed reference.

1.  **Create a Key File**: A tab-separated file with two columns: `SpeciesName` and `PathToFasta`.
2.  **Combine Genomes**:
    ```bash
    python scripts/combineRefGenomes.py --key species_key.txt --out combined_ref
    ```
    *   **Tip**: Use the `--trim` flag to exclude very short contigs (e.g., `< 1000bp`) which can reduce mapping noise in highly fragmented assemblies.

## Main Pipeline Usage

### Illumina Paired-End (Standard)
```bash
python scripts/sppIDer.py \
  --out output_prefix \
  --ref combined_ref \
  --r1 reads_R1.fastq.gz \
  --r2 reads_R2.fastq.gz \
  --cores 8
```

### Long-Read Mapping (PacBio/ONT)
For long reads, you must switch the mapping tool to `minimap2`.
```bash
python scripts/sppIDer.py \
  --out long_read_output \
  --ref combined_ref \
  --r1 reads.fastq.gz \
  --seq-type ONT \
  --mapping-tool minimap2 \
  --cores 12
```

### Integrated Species Extraction
To identify species and immediately save their specific reads to separate files:
```bash
python scripts/sppIDer.py \
  --out hybrid_analysis \
  --ref combined_ref \
  --r1 R1.fq.gz --r2 R2.fq.gz \
  --extract-species SpeciesA,SpeciesB \
  --extract-mq 30 \
  --extract-format fastq.gz
```

## Standalone Read Extraction

If you have already completed a run and want to extract reads without re-mapping, use the standalone extraction script. This is significantly faster than re-running the pipeline.

```bash
python scripts/extractReadsBySpecies.py \
  --mq-file output_prefix_MQ.txt \
  --fastq reads_R1.fastq.gz \
  --fastq2 reads_R2.fastq.gz \
  --species SpeciesName \
  --mq-min 30 \
  --output-format fastq.gz
```

## Expert Tips and Best Practices

*   **Performance Optimization**: Use the `--skip-plot` flag if you are running the tool in a high-throughput environment or on a server without R-plotting capabilities. This skips the generation of PDF summaries and focuses only on data processing.
*   **Mapping Quality (MQ)**: The default `--mq-threshold` for the main pipeline is 3. However, for species extraction, a higher threshold (e.g., `--extract-mq 30`) is recommended to minimize cross-species contamination in the resulting FASTQ files.
*   **Disk Space**: Use `--keep-sam false` and `--keep-intermediate false` (defaults) to prevent the pipeline from filling up storage with large intermediate alignment files.
*   **Coverage Analysis**: If you are specifically looking for aneuploidy or CNVs, ensure `--byBP true` (default) is active to get base-pair resolution depth, which is necessary for the depth plots to show fine-grained copy number changes.

## Reference documentation
- [EnhancedSppIDer Overview](./references/anaconda_org_channels_bioconda_packages_enhancedsppider_overview.md)
- [EnhancedSppIDer GitHub Repository](./references/github_com_JohnnyChen1113_EnhancedSppIDer.md)