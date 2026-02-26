---
name: ribotish
description: Ribotish characterizes translation activities and predicts translation initiation sites and open reading frames from ribosome profiling data. Use when user asks to estimate P-site offsets, predict translation initiation sites, identify frame-biased open reading frames, or perform differential translation initiation analysis.
homepage: https://github.com/zhpn1024/ribotish
---


# ribotish

## Overview
Ribotish (Ribo TIS Hunter) is a specialized bioinformatics tool designed to characterize translation activities from ribosome profiling data. It distinguishes itself by using statistical tests to assess the significance of translation: a negative binomial test for TIS detection and a rank sum test for frame-biased ORF prediction. It is optimized for data generated using various translation inhibitors, including Cycloheximide (CHX) for elongation and Lactimidomycin (LTM) or Harringtonine (Harr) for initiation site mapping (TI-Seq).

## Command Line Usage

### 1. Quality Control and P-site Offset Estimation
Before prediction, run the `quality` command to check frame bias and estimate P-site offsets. This generates a `.para.py` file required for accurate ORF prediction.

```bash
# For regular Ribo-seq (e.g., CHX)
ribotish quality -b sample_chx.bam -g annotation.gtf

# For TIS-enriched data (e.g., LTM or Harr)
ribotish quality -b sample_ltm.bam -g annotation.gtf -t
```

**Key Options:**
- `-b`: Path to the sorted and indexed BAM file.
- `-g`: Gene annotation file (GTF, GFF, BED, or GenePred).
- `-t`: Flag indicating the data is TIS-enriched.
- `-l`: Range of read lengths to consider (default: 25,35).
- `-p`: Number of processes for parallel execution.

### 2. ORF and TIS Prediction
The `predict` command is the core function. It works best when combining TIS-enriched data (LTM/Harr) with regular Ribo-seq data (CHX).

```bash
ribotish predict -t ltm.bam -b chx.bam -g annotation.gtf -f genome.fa -o predictions.txt
```

**Key Options:**
- `-t`: TIS-enriched BAM file.
- `-b`: Regular Ribo-seq BAM file.
- `-f`: Genome FASTA file.
- `-o`: Output text file for predictions.

### 3. Differential TIS Analysis
To compare TIS activity between two conditions (e.g., treatment vs. control), use `tisdiff`.

```bash
ribotish tisdiff -1 pred_ctrl.txt -2 pred_treat.txt -a ctrl.bam -b treat.bam -g annotation.gtf -o differential_results.txt
```

## Expert Tips and Best Practices

### Data Preprocessing Requirements
- **Read Trimming**: For optimal performance, reads should be trimmed to approximately 29 nt (the typical RPF length).
- **Alignment Strategy**: Align reads to the genome using **end-to-end mode**. Avoid soft-clipping, as it interferes with precise P-site mapping.
- **SAM Attributes**: Ensure your BAM files contain `NM`, `NH`, and `MD` attributes. If using STAR, use the flag `--outSAMattributes All`.
- **Indexing**: All BAM files must be sorted and indexed using `samtools index`.

### Handling Annotations
- **Coordinate System**: Ribotish uses 0-based, half-open coordinates (standard BED format).
- **Chromosome Mapping**: If your BAM files and GTF use different chromosome naming conventions (e.g., "1" vs "chr1"), use the `--chrmap` option with a two-column tab-separated mapping file.

### Quality Thresholds
- The `--th` option in the `quality` command sets the frame bias ratio threshold (default 0.5). If a read length group falls below this threshold, it is considered low quality and excluded from downstream analysis. If you have low-yield data, you may need to adjust this.

### Output Interpretation
- **pred.txt**: The main output contains predicted ORFs. Pay attention to the `TisType` column, which indicates whether the TIS is annotated, an alternative start in an annotated ORF, or a completely novel ORF (e.g., uORF, dORF, or overlapping ORF).

## Reference documentation
- [Ribo-seq TIS Hunter Main Documentation](./references/github_com_zhpn1024_ribotish.md)
- [Bioconda Ribotish Overview](./references/anaconda_org_channels_bioconda_packages_ribotish_overview.md)