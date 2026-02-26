---
name: bttcmp
description: The bttcmp tool identifies and annotates toxin genes in Bacillus thuringiensis datasets by integrating assembly, gene prediction, and multi-method detection. Use when user asks to identify insecticidal proteins, process raw sequencing reads for toxin mining, or annotate toxin genes from assembled genomes and protein sequences.
homepage: https://github.com/liaochenlanruo/BTTCMP/blob/master/README.md
---


# bttcmp

## Overview
The `bttcmp` tool is a comprehensive pipeline designed to identify and annotate toxin genes specifically within *Bacillus thuringiensis* (Bt) datasets. It automates the workflow from raw data to a structured toxin profile by integrating assembly (when needed), gene prediction, and a multi-method detection approach using SVM, BLAST, and HMM. Use this skill to streamline the discovery of insecticidal proteins and generate standardized nomenclature reports.

## Core CLI Patterns

### Processing Raw Sequencing Reads
When starting from raw data, the tool performs assembly before mining. You must specify the sequencing platform and provide file suffixes.

*   **Illumina (Paired-end):**
    `bttcmp --SeqPath /path/to/reads --SequenceType reads --platform illumina --reads1 .R1.fastq.gz --reads2 .R2.fastq.gz --suffix_len 15 --threads 8`
*   **PacBio/Oxford Nanopore:**
    `bttcmp --SeqPath /path/to/reads --SequenceType reads --platform [pacbio|oxford] --reads1 .fastq.gz --suffix_len 9`
*   **Hybrid Assembly:**
    `bttcmp --SeqPath /path/to/reads --SequenceType reads --platform hybrid --short1 R1.fq --short2 R2.fq --long long_reads.fq`

### Processing Pre-assembled or Predicted Sequences
If assembly is already complete, use the following modes to save time:

*   **Assembled Genomes (Fasta):**
    `bttcmp --SeqPath /path/to/genomes --SequenceType nucl --Scaf_suffix .fasta`
*   **Protein Sequences:**
    `bttcmp --SeqPath /path/to/proteins --SequenceType prot --prot_suffix .faa`
*   **ORFs:**
    `bttcmp --SeqPath /path/to/orfs --SequenceType orfs --orfs_suffix .ffn`

## Expert Tips and Best Practices

### Managing File Suffixes
The `--suffix_len` parameter is critical when processing reads. It represents the length of the file extension including any technical strings (e.g., `_L1_I050.R1.clean.fastq.gz`). If the strain name is `StrainA` and the file is `StrainA_1.fastq`, the `--suffix_len` is 2 (for `_1`). Accurate calculation ensures the tool correctly maps pairs and names outputs.

### Resource Allocation
*   **Threads:** Use `--threads` to match your environment. Assembly and HMMER steps are CPU-intensive.
*   **Genome Size:** For PacBio or Oxford Nanopore data, provide an estimate using `--genomeSize` (e.g., `6.07m`) to improve assembly performance.

### Interpreting Results
The primary output is located in `Results/Toxins/All_Toxins.txt`. 
*   **Detection Method:** Check the `SVM`, `BLAST`, and `HMM` columns. A "Yes" in multiple columns indicates higher confidence.
*   **Nomenclature:** The `Nomenclature` column provides the standardized Bt toxin rank (e.g., Cry1Ac).
*   **Domain Analysis:** Review the `Endotoxin_N/M/C` columns to verify the presence of conserved domains in Cry proteins.

### Workflow Optimization
If you only need to verify assembly quality without running the toxin mining logic, use the `--assemble_only` flag.

## Reference documentation
- [BTTCMP README](./references/github_com_liaochenlanruo_BTTCMP_blob_master_README.md)