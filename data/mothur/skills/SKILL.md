---
name: mothur
description: mothur is a comprehensive bioinformatics suite used to process amplicon sequencing data and analyze microbial communities. Use when user asks to process 16S/18S/ITS rRNA gene sequences, align reads to reference databases, remove chimeras, assign taxonomy, or cluster sequences into operational taxonomic units.
homepage: https://www.mothur.org
---

# mothur

## Overview
mothur is a comprehensive bioinformatics suite used to describe and compare microbial communities. It is primarily utilized for processing amplicon sequencing data, such as 16S, 18S, or ITS rRNA genes. The tool provides a unified environment to take raw FASTQ files through a rigorous quality control pipeline, align sequences to reference databases, and perform downstream ecological analyses. It is designed to be a "one-stop-shop" for microbial ecology, offering tools for both sequence processing and statistical community analysis.

## Command Line Usage
mothur can be operated in three primary modes:
- **Interactive Mode**: Run `mothur` to enter the mothur shell environment.
- **Command Line Mode**: Execute single commands directly from the terminal: `mothur "#make.contigs(file=stability.files, processors=8)"`.
- **Batch Mode**: Run a script containing a sequence of commands: `mothur stability.batch`.

## Core Workflow (MiSeq SOP)
The following sequence represents the standard operating procedure (SOP) for processing Illumina MiSeq data:

1. **Data Preparation**: Combine paired-end reads into contigs using a `.files` file.
   `make.contigs(file=stability.files, processors=8)`
2. **Quality Filtering**: Remove sequences with ambiguities or incorrect lengths.
   `screen.seqs(fasta=current, count=current, maxambig=0, maxlength=275)`
3. **Dereplication**: Consolidate identical sequences to reduce computational overhead.
   `unique.seqs(fasta=current)`
   `count.seqs(name=current, group=current)`
4. **Alignment**: Align sequences to a reference database (e.g., SILVA).
   `align.seqs(fasta=current, reference=silva.v4.fasta)`
5. **Denoising**: Merge sequences that are likely due to sequencing error (typically 1-2 bp difference).
   `pre.cluster(fasta=current, count=current, diffs=2)`
6. **Chimera Removal**: Identify and remove PCR artifacts using VSEARCH or UCHIME.
   `chimera.vsearch(fasta=current, count=current, dereplicate=t)`
   `remove.seqs(fasta=current, accnos=current)`
7. **Classification**: Assign taxonomy using a Bayesian classifier against a training set.
   `classify.seqs(fasta=current, count=current, reference=trainset.fasta, taxonomy=trainset.tax)`
8. **OTU Clustering**: Cluster sequences into Operational Taxonomic Units (typically at 97% similarity).
   `cluster.split(fasta=current, count=current, taxonomy=current, splitmethod=classify, taxlevel=4)`

## Expert Tips
- **The "current" Keyword**: mothur tracks the most recently generated files. Use `fasta=current`, `count=current`, or `taxonomy=current` to simplify commands and reduce filename errors.
- **Processors**: Always specify the `processors` parameter in computationally intensive steps (align, pre.cluster, chimera, cluster.split) to utilize multi-core systems.
- **Count Tables**: Modern mothur workflows use `.count_table` files instead of `.names` and `.groups` files. This is more efficient for tracking sequence abundance across samples.
- **Reference Formatting**: Reference databases like SILVA must be customized for mothur (e.g., removing gaps, screening to the specific V-region) to ensure alignment accuracy.
- **Memory Management**: If `cluster()` fails due to RAM limitations, use `cluster.split()`, which breaks the dataset into smaller taxonomic bins before clustering.



## Subcommands

| Command | Description |
|---------|-------------|
| mothur | mothur v.1.48.5 |
| mothur | mothur v.1.48.5 |
| mothur | Check for chimeras in sequences. |
| mothur | Classify sequences into OTUs |
| mothur | Classifies sequences using the SVM algorithm. |
| mothur | Degaps sequences. |
| mothur | mothur v.1.48.5 |
| mothur | mothur v.1.48.5 |
| mothur | Performs Kruskal-Wallis test on the data. |
| mothur | mothur v.1.48.5 |
| mothur | This tool appears to be a command-line interface for the mothur software, specifically designed to process a 'merge.count' batch file. The provided text indicates an error in opening this file, suggesting it's a core input for the operation. |
| mothur | mothur v.1.48.5 |
| mothur | mothur v.1.48.5 |
| mothur | Performs Principal Component Analysis (PCA) on microbial community data. |
| mothur | Remove distances from a distance matrix. |
| mothur | Remove groups from a data file. |
| mothur | Remove lineage information from sequences. |
| mothur | Remove OTUs from a dataset. |
| mothur | Remove sequences from a dataset. |
| mothur | Rename sequences in a FASTA file. |
| mothur | mothur v.1.48.5 |
| mothur | mothur v.1.48.5 |
| mothur | Sorts sequences based on their labels. |

## Reference documentation
- [MiSeq SOP](./references/mothur_org_wiki_miseq_sop.md)
- [mothur Manual](./references/mothur_org_wiki_mothur_manual.md)
- [Analysis Examples](./references/mothur_org_wiki_analysis_examples.md)
- [Frequently Asked Questions](./references/mothur_org_wiki_frequently_asked_questions.md)