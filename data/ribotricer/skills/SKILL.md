---
name: ribotricer
description: Ribotricer identifies actively translating open reading frames by analyzing the sub-codon periodicity of ribosome profiling data. Use when user asks to prepare candidate ORF indices, detect translating ORFs from BAM files, or determine optimal phase-score cutoffs for Ribo-seq analysis.
homepage: https://github.com/smithlabcode/ribotricer
---

# ribotricer

## Overview
Ribotricer is a specialized bioinformatics tool designed to identify active translation at the ORF level using Ribo-seq (Ribosome Profiling) data. Unlike tools that focus on read counts alone, ribotricer leverages the sub-codon periodicity of RPFs to distinguish between actively translating regions and background noise or non-coding occupancy. The workflow typically involves two main stages: indexing candidate ORFs from a reference genome and then scoring those candidates against experimental alignment data to determine translation status.

## Core Workflow

### 1. Preparing Candidate ORFs
Before analyzing Ribo-seq data, you must generate a candidate ORF index. This step identifies all potential start-to-stop sequences based on your annotation.

```bash
ribotricer prepare-orfs --gtf {ANNOTATION.gtf} --fasta {GENOME.fasta} --prefix {INDEX_NAME}
```

**Expert Tips:**
* **Custom Start Codons:** By default, it only uses 'ATG'. For non-canonical starts, use `--start_codons ATG,CTG,GTG`.
* **ORF Length:** The default minimum length is 60 nt. Adjust this using `--min_orf_length` if you are specifically looking for small ORFs (sORFs).
* **Output:** This generates `{INDEX_NAME}_candidate_orfs.tsv`, which is required for the detection step.

### 2. Detecting Translating ORFs
This step assesses the periodicity of RPFs within the candidate ORFs to identify those that are actively translating.

```bash
ribotricer detect-orfs --bam {ALIGNMENT.bam} --ribotricer_index {INDEX_NAME}_candidate_orfs.tsv --prefix {OUTPUT_PREFIX}
```

**Critical Parameters:**
* **Phase Score Cutoff:** The default is 0.428. However, this should be adjusted based on the species and data quality.
* **Filtering Flags:** Use these to increase stringency:
    * `--min_valid_codons_ratio`: Minimum ratio of codons with at least one read.
    * `--min_reads_per_codon`: Minimum average reads per codon.
    * `--min_read_density`: Total reads divided by ORF length.

## Species-Specific Recommended Cutoffs
Using the correct phase-score cutoff is vital for accuracy. Use the following table for the `--phase_score_cutoff` parameter:

| Species | Cutoff |
| :--- | :--- |
| Human | 0.440 |
| Mouse | 0.418 |
| Rat | 0.453 |
| Baker's Yeast | 0.318 |
| Arabidopsis | 0.330 |
| Zebrafish | 0.240 |
| C. elegans | 0.239 |
| Drosophila | 0.181 |

## Advanced Usage

### Learning Dataset-Specific Parameters
If your species is not listed or you have unique library prep conditions, use the `learn-cutoff` command to determine the optimal parameters from your data:

```bash
ribotricer learn-cutoff --ribo_bam {RIBO.bam} --rna_bam {RNA.bam} --gtf {GTF} --fasta {FASTA}
```

### Metagene Analysis
To visualize the periodicity and quality of your Ribo-seq library, you can generate metagene plots. When doing so, consider the `--meta_min_reads` parameter to filter out low-coverage transcripts that might skew the aggregate profile.

## Best Practices
* **Uniquely Mapping Reads:** Ribotricer expects uniquely mapping reads. While it will issue a warning rather than aborting for multi-mappers, it is best practice to pre-filter your BAM file for unique alignments (e.g., using the `NH:i:1` tag).
* **GTF Compatibility:** The tool is designed to handle various GTF formats, including GENCODE and Ensembl. If using a non-conventional GTF, ensure the `transcript_id` and `gene_id` attributes are correctly formatted.
* **Protein Extraction:** If you need the amino acid sequences of the detected ORFs, use the `--protein` flag during the detection or sequence extraction phase.



## Subcommands

| Command | Description |
|---------|-------------|
| ribotricer count-orfs | Count reads for detected ORFs at gene level |
| ribotricer count-orfs-codon | Count reads for detected ORFs at codon level |
| ribotricer detect-orfs | Detect translating ORFs from BAM file |
| ribotricer learn-cutoff | Learn phase score cutoff from BAM/TSV file |
| ribotricer orfs-seq | Generate sequence for ORFs in ribotricer's index |
| ribotricer prepare-orfs | Extract candidate ORFS based on GTF and FASTA files |

## Reference documentation
- [ribotricer Main Documentation](./references/github_com_smithlabcode_ribotricer.md)
- [Version History and Parameter Updates](./references/github_com_smithlabcode_ribotricer_blob_master_HISTORY.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ribotricer_overview.md)