---
name: rsem
description: RSEM quantifies transcript abundance from RNA-Seq data by using an Expectation-Maximization algorithm to handle multi-mapping reads. Use when user asks to prepare a reference index, calculate expression levels from FASTQ or BAM files, or estimate isoform-level abundance.
homepage: https://deweylab.github.io/RSEM/
metadata:
  docker_image: "quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12"
---

# rsem

## Overview
RSEM (RNA-Seq by Expectation-Maximization) is a specialized tool for quantifying transcript abundance without a required reference genome, though it performs best when one is provided. It handles multi-mapping reads by using an Expectation-Maximization algorithm to assign them to the most likely isoform. This skill provides the necessary command patterns for the two-step RSEM workflow: preparing a reference and calculating expression.

## Reference Preparation
Before quantification, you must build RSEM-specific indices. This step extracts transcript sequences from the genome using an annotation file.

### Standard Genome + GTF/GFF3
```bash
# Using GTF (Ensembl/GENCODE)
rsem-prepare-reference --gtf annotation.gtf \
                       --bowtie2 \
                       genome.fa \
                       ref/index_name

# Using GFF3 (RefSeq)
rsem-prepare-reference --gff3 annotation.gff3 \
                       --bowtie2 \
                       genome.fa \
                       ref/index_name
```

### Expert Tips for Reference Building
- **Aligner Choice**: Always specify the aligner during preparation (e.g., `--bowtie2`, `--star`, or `--hisat2-hca`) to ensure the indices are compatible with the calculation step.
- **RefSeq GFF3**: When using RefSeq, use `--trusted-sources BestRefSeq,Curated\ Genomic` to filter for high-quality annotations.
- **Untypical Organisms**: If your GFF3 only contains gene boundaries without explicit transcript/mRNA lines, use `--gff3-genes-as-transcripts`.
- **Primary Assembly**: Always use the primary assembly of the genome (no patches/haplotypes) to avoid artificial multi-mapping.

## Expression Calculation
This step aligns reads (if FASTQ is provided) and runs the EM algorithm.

### From FASTQ (Automated Alignment)
```bash
# Paired-end with Bowtie2
rsem-calculate-expression --paired-end \
                          --bowtie2 \
                          --append-names \
                          reads_1.fq reads_2.fq \
                          ref/index_name \
                          output_prefix
```

### From BAM (Pre-aligned)
If you aligned reads externally, the BAM must be in **transcript coordinates**.
```bash
rsem-calculate-expression --alignments \
                          --paired-end \
                          input.bam \
                          ref/index_name \
                          output_prefix
```

### Critical Parameters
- `--append-names`: Highly recommended. It adds gene/transcript names to the results files alongside IDs, making them human-readable.
- `--strandedness <none|forward|reverse>`: Essential for accurate quantification if using stranded libraries.
- `--calc-ci`: Use this if you require 95% credibility intervals (note: increases runtime significantly).
- `--estimate-rspd`: Use for 3'-biased data (like some single-cell protocols) to estimate the read start position distribution.

## Visualization and Post-processing
RSEM produces results in transcript coordinates. Use these tools to convert them for standard genome browsers.

- **Genome BAM**: Use `--output-genome-bam` in `rsem-calculate-expression` to automatically generate a genome-coordinate BAM.
- **Wiggle Files**: Run `rsem-bam2wig` on the sorted BAM to create tracks for UCSC or IGV.
- **Diagnostics**: Use `rsem-plot-model output_prefix diagnostic.pdf` to visualize the learned model parameters (fragment length distribution, etc.).



## Subcommands

| Command | Description |
|---------|-------------|
| rsem-calculate-expression | Estimate gene and isoform expression from RNA-Seq data. |
| rsem-generate-data-matrix | All result files should have the same file type. The 'expected_count' columns of every result file are extracted to form the data matrix. |
| rsem-prepare-reference | Prepare transcript references for RSEM and optionally build BOWTIE/BOWTIE2/STAR/HISAT2(transcriptome) indices. |

## Reference documentation
- [README for RSEM](./references/deweylab_github_io_RSEM_README.html.md)
- [RSEM Homepage](./references/deweylab_github_io_RSEM.md)