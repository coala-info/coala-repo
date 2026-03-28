---
name: ribotish
description: Ribo-TISH is a statistical framework for characterizing the translatome by identifying translation initiation sites and open reading frames from ribosome profiling data. Use when user asks to perform quality control on Ribo-seq data, predict translation initiation sites and ORFs, or compare differential TIS usage between conditions.
homepage: https://github.com/zhpn1024/ribotish
---

# ribotish

## Overview

Ribo-TISH (Ribo TIS Hunter) is a statistical framework for characterizing the translatome using ribosome profiling data. It identifies significant translation initiation sites using a negative binomial test and detects frame-biased ORFs via rank sum tests. The tool is designed to handle both regular Ribo-seq (using Cycloheximide) and Translation Initiation Sequencing (TI-seq) using inhibitors like Lactimidomycin (LTM) or Harringtonine (Harr) to precisely map start codons.

## Usage Guidelines

### Data Preparation Requirements
* **BAM Files**: Reads should be trimmed (typically to ~29 nt) and aligned to the genome in **end-to-end** mode (no soft-clipping).
* **Alignment Attributes**: If using STAR, ensure `--outSAMattributes All` is set to include NM, NH, and MD tags.
* **Indexing**: BAM files must be sorted and indexed using `samtools`.
* **Coordinates**: All reported positions are 0-based, half-open (BED format).

### Quality Control (`quality`)
Perform QC to check frame bias and estimate P-site offsets.
* **Regular Ribo-seq**: `ribotish quality -b chx.bam -g gene.gtf`
* **TI-seq (LTM/Harr)**: `ribotish quality -b ltm.bam -g gene.gtf -t`
* **Key Output**: The `.para.py` file contains P-site offsets for different read lengths, which are essential for downstream prediction.
* **Tip**: Use `--nom0` to disable grouping by 5' end mismatch if the library preparation doesn't produce specific 5' end patterns.

### ORF and TIS Prediction (`predict`)
Predict translation activities by combining TIS-enriched data and regular Ribo-seq.
* **Standard Command**: `ribotish predict -t ltm.bam -b chx.bam -g gene.gtf -f genome.fa -o pred.txt`
* **Reporting Sequences**: Use `--seq` and `--aaseq` to include nucleotide and amino acid sequences in the output.
* **In-frame Counts**: Use `--inframecount` to report RPF counts specifically within the reading frame.

### Differential TIS Analysis (`tisdiff`)
Compare TIS activities between two conditions.
* **Command**: `ribotish tisdiff -1 pred1.txt -2 pred2.txt -a qti1.bam -b qti2.bam -g gene.gtf -o diff.txt`

## Expert Tips
* **Chromosome Mapping**: If your BAM and GTF files use different chromosome naming conventions (e.g., "1" vs "chr1"), use the `--chrmap` option with a tab-separated mapping file.
* **Low Quality Groups**: By default, read length groups with a frame bias ratio < 0.5 are excluded. Adjust this using `--th` if working with lower-quality datasets.
* **Performance**: Use `-p` to specify the number of processes for multi-threaded execution.
* **Visualization**: The `quality` command generates a PDF figure; check the "TIS enrich score" in the lower panel to verify the success of LTM/Harr enrichment.



## Subcommands

| Command | Description |
|---------|-------------|
| ribotish quality | Quality control for Riboseq data. |
| ribotish tisdiff | Compares TIS usage between two groups of samples. |
| ribotish_predict | Predicts ORFs using riboseq data. |
| ribotish_transplot | Plotting tool for riboseq and rnaseq data aligned to transcripts. |

## Reference documentation
- [README for Ribo-TISH](./references/github_com_zhpn1024_ribotish_blob_master_README.rst.md)
- [Ribo-TISH Changelog and Version History](./references/github_com_zhpn1024_ribotish_blob_master_CHANGELOG.md)