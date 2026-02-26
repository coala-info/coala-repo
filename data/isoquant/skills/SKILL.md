---
name: isoquant
description: IsoQuant is a bioinformatics pipeline for the genome-based reconstruction and quantification of long-read transcriptomic data. Use when user asks to reconstruct transcript models, quantify isoform abundance, or perform de novo transcript discovery from long RNA reads.
homepage: https://github.com/ablab/IsoQuant
---


# isoquant

## Overview

IsoQuant is a bioinformatics pipeline specifically engineered for the genome-based analysis of long RNA reads. It addresses the challenges of transcriptomic complexity by reconstructing and quantifying transcript models with high precision. While it can perform de novo discovery, it is most effective when provided with a reference annotation to assign reads to known isoforms based on intron and exon structures. It supports various long-read technologies, including PacBio CCS and Oxford Nanopore (dRNA and cDNA), and can optionally utilize Illumina data to refine splice site accuracy.

## Installation and Verification

Install via Conda for the most stable environment:

```bash
conda create -c conda-forge -c bioconda -n isoquant python=3.8 isoquant
```

Verify the installation and dependencies (minimap2, samtools) using the built-in test suite:

```bash
isoquant.py --test
```

## Common CLI Patterns

### Standard Reference-Based Quantification (FASTQ)
Use this pattern when you have raw reads and a known gene annotation.

```bash
isoquant.py --reference genome.fasta \
  --genedb annotation.gtf \
  --fastq sample_1.fq.gz sample_2.fq.gz \
  --data_type nanopore \
  -o output_folder
```

### Analysis from Aligned BAM
If reads are already aligned, ensure the BAM is sorted and indexed. This skips the internal mapping step.

```bash
isoquant.py --reference genome.fasta \
  --genedb annotation.gtf \
  --bam aligned_reads.sorted.bam \
  --data_type pacbio_ccs \
  -o output_folder
```

### De Novo Transcript Discovery
Omit the `--genedb` parameter to discover novel transcripts without a guide annotation.

```bash
isoquant.py --reference genome.fasta \
  --fastq reads.fastq.gz \
  --data_type nanopore \
  -o output_folder
```

## Expert Tips and Best Practices

- **PolyA Tails**: Do not trim polyA tails from your reads before running IsoQuant. The tool uses polyA information for more reliable transcript model construction.
- **Annotation Speed**: When using official, comprehensive annotations (like GENCODE or Ensembl) that contain explicit gene and transcript features, always add the `--complete_genedb` flag to significantly reduce processing time.
- **Data Type Selection**: Ensure `--data_type` matches your library:
  - `nanopore`: For ONT dRNA or cDNA.
  - `pacbio_ccs`: For PacBio HiFi/CCS reads.
  - `assembly`: For pre-assembled or corrected transcript sequences.
- **Short-Read Correction**: While IsoQuant is a long-read tool, you can provide aligned Illumina BAMs to improve the accuracy of long-read spliced alignments, though they won't be used for discovery or abundance calculations.
- **Output Interpretation**: IsoQuant generates a single output annotation and unified expression tables even when multiple input files are provided, facilitating multi-sample comparisons.

## Reference documentation

- [IsoQuant Main Documentation](./references/github_com_ablab_IsoQuant.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_isoquant_overview.md)