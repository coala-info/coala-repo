---
name: metamlst
description: MetaMLST is a computational pipeline designed to provide strain-level resolution for microbial species within complex metagenomic datasets.
homepage: https://github.com/SegataLab/metamlst
---

# metamlst

## Overview

MetaMLST is a computational pipeline designed to provide strain-level resolution for microbial species within complex metagenomic datasets. Unlike traditional MLST which requires bacterial isolates, MetaMLST works directly on raw shotgun sequencing reads (e.g., Illumina). It identifies the most abundant strain of a species by reconstructing its MLST-specific loci and comparing them against the PubMLST database. This tool is essential for researchers tracking specific pathogens or studying microbial population dynamics across multiple samples where assembly-based methods might fail due to low coverage or high complexity.

## Core Workflow

The MetaMLST process follows a four-step sequence: database preparation, read mapping, loci reconstruction, and sample merging.

### 1. Database and Index Building
Before processing samples, you must prepare the reference database and a Bowtie2 index. By default, the tool downloads the latest pre-computed database (e.g., metamlstDB_2021).

```bash
metamlst-index.py -i bowtie_index_prefix
```

### 2. Read Mapping
Align your raw shotgun reads to the MetaMLST index. Use the specific Bowtie2 parameters recommended by the developers to ensure maximum sensitivity for loci reconstruction.

```bash
bowtie2 --very-sensitive-local -a --no-unal -x bowtie_index_prefix -U input_reads.fastq | samtools view -bS - > sample_alignment.bam
```
*Note: MetaMLST requires the `-a` (report all alignments) and `--very-sensitive-local` flags for optimal performance.*

### 3. Loci Reconstruction and Typing
Process the resulting BAM file to detect microbial targets and reconstruct the sample-specific MLST loci.

```bash
metamlst.py sample_alignment.bam
```
*   **Output**: Results are saved in `./out` by default.
*   **Novelty**: The tool identifies new loci or STs. Novel STs are assigned a progressive ID starting at 100001.

### 4. Multi-Sample Merging
To compare results across a cohort, merge the individual output files.

```bash
metamlst-merge.py ./out
```
*   **Output**: Merged typing tables and updated sequence type lists are saved in `./out/merged`.

## Expert Tips and Best Practices

*   **Data Compatibility**: MetaMLST is strictly for shotgun metagenomic data. It cannot be used with 16S rRNA gene sequencing datasets.
*   **Database Updates**: The tool attempts to download the latest database automatically. If working in an offline environment, manually download the database from the Segata Lab repository and specify it using the appropriate flags.
*   **Output Formats**: Use the `--outseqformat` option in `metamlst.py` to toggle between FASTA and CSV formats for the reconstructed loci sequences.
*   **Resource Management**: Mapping with the `-a` flag in Bowtie2 can generate very large BAM files. Ensure sufficient disk space or pipe the output directly into `metamlst.py` if the environment supports it.
*   **Python Version**: Ensure `mlst.py` is executed using Python 3.7 or higher, as it is a requirement for the typing logic.

## Reference documentation
- [MetaMLST Wiki - Home](./references/github_com_SegataLab_metamlst_wiki.md)
- [MetaMLST GitHub Repository Overview](./references/github_com_SegataLab_metamlst.md)