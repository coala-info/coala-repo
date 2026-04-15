---
name: ivar
description: iVar is a computational toolkit designed to process viral amplicon sequencing data by trimming primers, calling variants, and generating consensus sequences. Use when user asks to trim primer sequences from alignments, identify intrahost single nucleotide variants, generate a consensus FASTA, or filter variants across multiple replicates.
homepage: https://andersen-lab.github.io/ivar/html/
metadata:
  docker_image: "quay.io/biocontainers/ivar:1.4.4--h077b44d_0"
---

# ivar

## Overview
iVar is a specialized toolkit designed for the analysis of viral sequencing data, specifically optimized for amplicon-based approaches like PrimalSeq. It provides a streamlined workflow to transform raw alignments into high-quality genomic insights by removing technical artifacts (primers and low-quality bases) and accurately identifying both majority consensus sequences and low-frequency intrahost single nucleotide variants (iSNVs).

## Core Workflows and CLI Patterns

### 1. Primer Trimming and Quality Filtering
iVar trims primers by soft-clipping reads in an aligned BAM file based on coordinates provided in a BED file.

*   **Basic Trimming:**
    ```bash
    ivar trim -i input.bam -b primers.bed -p output_prefix -q 20 -m 30 -s 4
    ```
*   **Expert Tip:** Always sort and index your BAM file using `samtools` before running `ivar trim`. If you need to filter by amplicon pairs to ensure reads only come from valid primer sets, use the `-f` flag with a primer pair information file.
*   **Piping Pattern:** You can pipe directly from an aligner to save disk space:
    ```bash
    bwa mem ref.fa r1.fq r2.fq | ivar trim -b primers.bed -p trimmed_output
    ```

### 2. Variant Calling (iSNVs and Indels)
iVar identifies variants by processing the output of `samtools mpileup`.

*   **Standard Variant Call:**
    ```bash
    samtools mpileup -aa -A -d 600000 -B -Q 0 --reference ref.fa input.trimmed.bam | ivar variants -p output_prefix -q 20 -t 0.03 -r ref.fa
    ```
*   **Critical Requirement:** You must use the `-B` flag in `samtools mpileup` to disable Base Alignment Quality (BAQ) calculation, as BAQ can interfere with iVar's ability to process the reference base quality correctly.
*   **Translation:** To enable amino acid translation of variants, provide a GFF3 file using the `-g` flag.

### 3. Consensus Sequence Generation
Generates a consensus FASTA from an aligned BAM.

*   **Command:**
    ```bash
    samtools mpileup -aa -A -d 600000 -B -Q 0 input.trimmed.bam | ivar consensus -p consensus_prefix -q 20 -t 0.5 -m 10 -n N
    ```
*   **Parameters:**
    *   `-t`: Threshold for the majority base (e.g., 0.5 for >50%).
    *   `-m`: Minimum depth required to call a base; otherwise, the character specified by `-n` (usually 'N' or '-') is used.

### 4. Multi-Replicate Filtering
Filter variants across multiple replicates to increase confidence in low-frequency iSNVs.

*   **Command:**
    ```bash
    ivar filtervariants -p filtered_output -t 0.5 rep1.tsv rep2.tsv rep3.tsv
    ```
*   **Logic:** The `-t 0.5` flag ensures only variants present in at least 50% of the provided files are retained in the final output.

### 5. Handling Primer Mismatches
For samples where the virus has mutated at the primer binding site, use `getmasked` and `removereads` to prevent biased frequency calculations.

1.  **Identify masked amplicons:** `ivar getmasked -i input.bam -b primers.bed -f pairs.txt -p masked_primers`
2.  **Remove affected reads:** `ivar removereads -i input.bam -p filtered_bam -t masked_primers.txt`



## Subcommands

| Command | Description |
|---------|-------------|
| ivar filtervariants | Filters variant TSV files across multiple replicates. |
| ivar trim | Trim primers and quality from aligned reads in a BAM file. |
| ivar_consensus | Generates a consensus sequence from pileup data. |
| ivar_getmasked | This step is used only for amplicon-based sequencing. |
| ivar_removereads | This step is used only for amplicon-based sequencing. |
| ivar_variants | Call variants from a mpileup file |

## Reference documentation
- [iVar Manual](./references/andersen-lab_github_io_ivar_html_manualpage.html.md)
- [iVar Cookbook and Pipelines](./references/andersen-lab_github_io_ivar_html_cookbookpage.html.md)
- [iVar Installation and Dependencies](./references/andersen-lab_github_io_ivar_html_installpage.html.md)