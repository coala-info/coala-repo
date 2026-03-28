---
name: ribocode
description: RiboCode identifies translated open reading frames by analyzing the periodic patterns of ribosome-protected fragments in Ribo-seq data. Use when user asks to identify translated ORFs, determine P-site offsets, prepare transcriptome annotations, or quantify ribosome-protected fragments for predicted ORFs.
homepage: https://github.com/xryanglab/RiboCode
---


# ribocode

## Overview
RiboCode is a computational framework designed to detect translated ORFs by analyzing the periodic patterns of ribosome-protected fragments (RPFs). It transforms raw sequencing alignments into high-confidence translation maps by identifying the specific P-site locations for different read lengths and applying statistical tests to distinguish true translation from background noise. It is particularly useful for discovering non-canonical ORFs, such as those in lncRNAs, uORFs, or alternative frames.

## Core Workflow

### 1. Annotation Preparation
Before analysis, convert genomic GTF and FASTA files into a RiboCode-optimized format.
```bash
prepare_transcripts -g annotation.gtf -f genome.fa -o RiboCode_annot
```
*Note: If your GTF lacks 'gene' or 'transcript' features (common in non-GENCODE/Ensembl files), use `GTFupdate original.gtf > updated.gtf` first.*

### 2. Metaplot Analysis & P-site Identification
Identify the P-site offset for each RPF read length. This step is critical for capturing the 3-nucleotide periodicity of the ribosome.
```bash
metaplots -a RiboCode_annot -r alignment.toTranscriptome.bam -o output_metaplots
```
*   **Input**: Must be a BAM file aligned to the **transcriptome**.
*   **Output**: A config file (usually `config.txt`) containing the optimal read lengths and their corresponding P-site offsets.

### 3. ORF Detection
Run the main engine to identify translated ORFs based on the periodicity of the P-sites.
```bash
RiboCode -a RiboCode_annot -c config.txt -l long -o final_results
```
*   **-l**: Use 'long' for the longest ORF strategy or 'all' to report all potential ORFs.
*   **-p**: Set a p-value cutoff (default is 0.05).

### 4. One-Step Execution
For standard pipelines, use the wrapper command to run the entire process (excluding annotation prep).
```bash
RiboCode_onestep -a RiboCode_annot -r alignment.bam -o output_dir
```

## Advanced CLI Patterns

### Statistical Adjustments
For more stringent ORF detection, especially in complex transcriptomes:
*   `--pval_adj`: Apply multiple testing correction to p-values.
*   `--stouffer_adj`: Adjust combined p-values to account for dependence between frame tests (F0 vs F1 and F0 vs F2).
*   `--dependence_test`: Measure density dependence between frames to determine if p-value adjustment is necessary.

### Quantifying RPFs
To count reads aligned to the predicted ORFs for downstream differential translation analysis:
```bash
ORFcount -a RiboCode_annot -c config.txt -r alignment.bam -f final_results.txt -o ORF_counts.txt
```

### Output Formats
By default, results are tabular. Use the following to generate genome-browser compatible files:
*   `--gtf`: Output predicted ORFs in GTF format.
*   `--plot-annotated-orf`: Generate plots for specific annotated ORFs to visually inspect periodicity.

## Expert Tips
*   **Alignment Requirements**: Ensure Ribo-seq reads are aligned with `EndToEnd` mapping (no soft-clipping) and mapped to the transcriptome for `metaplots`. STAR is the recommended aligner.
*   **rRNA Depletion**: Always perform an initial alignment to rRNA sequences (using Bowtie) before mapping to the genome to reduce noise.
*   **Periodicity Check**: Review the PDF output from `metaplots`. If you do not see a clear peak at a specific offset for a given read length, exclude that length from the `config.txt` to improve signal-to-noise ratio.



## Subcommands

| Command | Description |
|---------|-------------|
| GTFupdate | This script is designed for preparing the appropriate GTF file from custom GTF file (or those not from ENSEMBL/GENCODE database) |
| RiboCode | The main function designed for detecting ORF using ribosome-profiling data. |
| metaplots | This script create aggregate plots of distances from the 5'end of reads to start or stop codons, which help determine the length range of the PRF reads that are most likely originated from the translating ribosomes and identify the P-site locations for each reads lengths. |
| prepare_transcripts | This script is designed for preparing transcripts annotation files. |

## Reference documentation
- [RiboCode GitHub README](./references/github_com_xryanglab_RiboCode_blob_master_README.rst.md)
- [GTF Preparation Guide](./references/github_com_xryanglab_RiboCode_blob_master_data_GTF_update.rst.md)
- [ChangeLog and Version History](./references/github_com_xryanglab_RiboCode_blob_master_ChangeLog.rst.md)