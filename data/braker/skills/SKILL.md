---
name: braker
description: BRAKER is a fully automated pipeline designed for the prediction of protein-coding gene structures in eukaryotic genomes.
homepage: https://github.com/Gaius-Augustus/BRAKER
---

# braker

## Overview

BRAKER is a fully automated pipeline designed for the prediction of protein-coding gene structures in eukaryotic genomes. It acts as a wrapper and training orchestrator for GeneMark-ES/ET/EP/ETP and AUGUSTUS. Use this skill when you need to generate high-quality gene annotations for a new genome assembly using extrinsic evidence (RNA-Seq or proteins) or ab initio methods. It is particularly effective for scaling annotation workflows where manual training of gene finders is not feasible.

## Core Command Line Usage

The primary script for all BRAKER versions (1, 2, and 3) is `braker.pl`.

### Common Execution Modes

*   **BRAKER1 (RNA-Seq evidence):**
    `braker.pl --genome=genome.fa --bam=RNAseq.bam`
*   **BRAKER2 (Protein homology evidence):**
    `braker.pl --genome=genome.fa --prot_seq=proteins.fa`
*   **BRAKER3 (RNA-Seq + Protein evidence):**
    `braker.pl --genome=genome.fa --bam=RNAseq.bam --prot_seq=proteins.fa`
*   **Ab initio (No extrinsic evidence):**
    `braker.pl --genome=genome.fa --esmode`

### Essential Options

*   `--threads=INT`: Set the number of CPU cores to use.
*   `--fungus`: Mandatory flag when annotating fungal genomes to account for specific GeneMark-ES settings.
*   `--softmasking`: Use this if your genome is softmasked (repeats in lowercase).
*   `--UTR=on`: Enables UTR prediction (requires sufficient RNA-Seq evidence).
*   `--busco_lineage=LINEAGE`: Specify a BUSCO lineage for evaluating the training set.

## Expert Tips and Best Practices

### Genome Preparation
*   **Scaffold Names:** Ensure scaffold names in your FASTA files are simple (e.g., `>scaffold_1`). Avoid special characters, spaces, or long descriptions, as these can cause failures in the underlying tools (GeneMark/AUGUSTUS).
*   **Repeat Masking:** Always use **softmasking** (lowercase letters for repeats) rather than hardmasking (replacing with Ns). Softmasking allows the gene finders to "see" through repeats if necessary while still penalizing gene starts in those regions.
*   **Assembly Quality:** Avoid including a large number of very short scaffolds (e.g., < 1000bp). They increase runtime significantly without contributing much to prediction accuracy.

### Evidence Handling
*   **RNA-Seq:** Provide RNA-Seq data as coordinate-sorted BAM files. If using multiple BAM files, provide them as a comma-separated list.
*   **Strandedness:** If your RNA-Seq data is stranded, use the `--stranded=+,-,.` option to improve splice site and UTR prediction.
*   **Protein Data:** When using protein evidence, use a diverse but relevant protein database (e.g., OrthoDB) for better results in BRAKER2/3 modes.

### Workflow Management
*   **Resuming Runs:** Use the `--useexisting` flag to attempt to resume a pipeline that was interrupted, provided the working directory is intact.
*   **Output:** The final gene set is typically found in `braker.gtf`.

## Reference documentation

- [BRAKER User Guide](./references/github_com_Gaius-Augustus_BRAKER.md)
- [BRAKER Wiki](./references/github_com_Gaius-Augustus_BRAKER_wiki.md)