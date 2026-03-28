---
name: hybpiper
description: HybPiper extracts target sequences and flanking intronic regions from enriched DNA sequencing libraries using a combination of read mapping and de novo assembly. Use when user asks to assemble target genes from phylogenomic data, recover exons and introns, detect paralogs, or generate gene recovery statistics.
homepage: https://github.com/mossmatters/HybPiper
---

# hybpiper

## Overview
HybPiper is a bioinformatics suite designed to extract target sequences from enriched DNA sequencing libraries. It wraps several tools (SPAdes, BLAST/DIAMOND, BWA, Exonerate) to map reads to target genes, perform de novo assembly for each gene, and extract in-frame coding sequences. It is particularly effective for phylogenomics, allowing for the recovery of both exons and flanking intronic regions (Intronerate) and providing workflows to detect and retrieve paralogous sequences.

## Core Workflow

### 1. Prepare Input Files
*   **Reads**: Cleaned FASTQ files (single-end or paired-end).
*   **Target File**: A FASTA file containing reference sequences for the genes of interest.
    *   **Protein Targets**: Required if using BLASTx or DIAMOND (default).
    *   **Nucleotide Targets**: Required if using BWA (`--bwa` flag).
    *   **Format**: Headers must be `>Source-GeneName` (e.g., `>Amborella-atpH`).

### 2. Main Assembly Pipeline
Run `hybpiper assemble` for each sample individually.

```bash
# Basic assembly using protein targets (BLASTx)
hybpiper assemble -r sample1_R1.fastq sample1_R2.fastq -t targets.fasta --prefix sample1

# Assembly using nucleotide targets and BWA
hybpiper assemble -r sample1_R1.fastq sample1_R2.fastq --targetfile_dna targets.fasta --bwa --prefix sample1

# Include intron recovery (Intronerate)
hybpiper assemble -r sample1_R1.fastq sample1_R2.fastq -t targets.fasta --prefix sample1 --run_intronerate
```

### 3. Post-Processing and Summary
After running `assemble` on all samples, use these commands to aggregate results:

```bash
# Generate recovery statistics (lengths and percentages)
hybpiper stats -t targets.fasta gene sample_names.txt

# Create a visualization of gene recovery
hybpiper recovery_heatmap stats.txt

# Retrieve sequences for all samples into a single file per gene
hybpiper retrieve_sequences dna -t targets.fasta --sample_names sample_names.txt
```

## Expert Tips and Best Practices

### Mapping Strategy
*   **DIAMOND**: Use `--diamond` for significantly faster read mapping than BLASTx, especially with large datasets.
*   **Sensitivity**: If recovery is low, increase DIAMOND sensitivity: `--diamond_sensitivity ultra-sensitive`.
*   **BWA**: Use `--bwa` only if your target file is very closely related to your samples (e.g., same species or genus).

### Handling Paralogs
HybPiper flags genes with multiple potential assemblies.
*   Check the `paralog_warnings.txt` file in the sample directory.
*   Use `hybpiper paralog_retriever` to extract all versions of a gene for phylogenetic testing.

### Chimeric Sequence Detection
If you suspect "stitched" contigs (where HybPiper joins multiple SPAdes contigs) are creating chimeras from different paralogs:
*   Run with `--chimeric_stitched_contig_check`.
*   Adjust the mismatch threshold with `--chimeric_stitched_contig_edit_distance` (default is 5).

### Performance and HPC
*   **Parallelization**: HybPiper processes genes within a sample in parallel. Use `--cpu` to specify available cores.
*   **Memory**: For memory-intensive assemblies, use `--distribute_low_mem` to reduce the number of concurrent SPAdes runs.
*   **Cleanup**: HybPiper 2.x automatically cleans up large intermediate SPAdes folders unless `--keep_intermediate_files` is specified.

## Common CLI Patterns

| Task | Command |
| :--- | :--- |
| **Check Dependencies** | `hybpiper check_dependencies` |
| **Validate Target File** | `hybpiper check_targetfile -t targets.fasta` |
| **Filter by Length** | `hybpiper filter_by_length --percentage_len 50` |
| **Recover Introns** | `hybpiper retrieve_sequences intro -t targets.fasta` |



## Subcommands

| Command | Description |
|---------|-------------|
| hybpiper assemble | HybPiper is a pipeline for assembling target-capture data. |
| hybpiper check_targetfile | Check target files for issues such as stop codons and low complexity regions. |
| hybpiper filter_by_length | Filters sequences based on length criteria. |
| hybpiper fix_targetfile | Fixes DNA and amino-acid target files by testing for open reading frames, removing stop codons, and filtering sequences. |
| hybpiper paralog_retriever | Extracts paralogous genes from HybPiper output. |
| hybpiper recovery_heatmap | Generates a heatmap of recovery based on sequence lengths. |
| hybpiper retrieve_sequences | Type of sequence to extract. |
| hybpiper stats | Sequence type (gene or supercontig) to recover lengths for. |
| hybpiper_check_dependencies | Checks for external dependencies required by HybPiper. |

## Reference documentation
- [HybPiper Wiki Home](./references/github_com_mossmatters_HybPiper_wiki.md)
- [Full Pipeline Parameters](./references/github_com_mossmatters_HybPiper_wiki_Full-pipeline-parameters.md)
- [Dealing with Paralogs](./references/github_com_mossmatters_HybPiper_wiki_Paralogs.md)
- [Detecting Chimeric Loci](./references/github_com_mossmatters_HybPiper_wiki_Detecting-putative-chimeric-loci-sequences.md)