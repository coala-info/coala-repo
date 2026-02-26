---
name: hybpiper
description: HybPiper processes target enrichment sequencing data to produce gene-by-gene assemblies and extract orthologous sequences for phylogenetic analysis. Use when user asks to assemble loci from Hyb-Seq reads, recover introns or supercontigs, generate gene recovery statistics, or investigate paralogs.
homepage: https://github.com/mossmatters/HybPiper
---


# hybpiper

## Overview

HybPiper is a specialized bioinformatics suite designed for "target enrichment" or "Hyb-Seq" data. It transforms raw sequencing reads into gene-by-gene assemblies by first sorting reads to specific targets and then performing independent de novo assemblies for each locus. This approach is particularly effective for phylogenetic studies where researchers need to recover orthologous sequences from divergent taxa. It handles the entire workflow from raw FASTQ files to final FASTA alignments, including the recovery of "supercontigs" that contain both exons and introns.

## Core Workflow and CLI Patterns

### 1. Main Assembly (`assemble`)
The primary command to process a sample. It maps reads, runs SPAdes, and extracts sequences.

*   **Standard Paired-End Run (Protein Targets):**
    ```bash
    hybpiper assemble -r sample_R1.fastq.gz sample_R2.fastq.gz -t_aa targets.fasta --prefix sample_name
    ```
*   **Using DIAMOND for Speed:**
    If you have a large number of targets or reads, use `--diamond` instead of the default BLASTx.
    ```bash
    hybpiper assemble -r R1.fq R2.fq -t_aa targets.fasta --prefix sample_01 --diamond
    ```
*   **Nucleotide Mapping (BWA):**
    Use this if your targets are very closely related to your reads.
    ```bash
    hybpiper assemble -r R1.fq R2.fq -t_dna targets.fasta --prefix sample_01 --bwa
    ```
*   **Recovering Introns:**
    Add the `--run_intronerate` flag to extract flanking non-coding regions.
    ```bash
    hybpiper assemble -r R1.fq R2.fq -t_aa targets.fasta --prefix sample_01 --run_intronerate
    ```

### 2. Post-Processing and Summarization
After running `assemble` on all samples, use these commands from the same parent directory.

*   **Generate Statistics:**
    Creates a table showing the number of genes recovered and their lengths.
    ```bash
    hybpiper stats -t_aa targets.fasta gene namelist.txt
    ```
*   **Visualize Recovery:**
    Creates a heatmap (PNG/PDF) of gene recovery success across the dataset.
    ```bash
    hybpiper recovery_heatmap stats_table.txt
    ```
*   **Retrieve Final Sequences:**
    Extracts the recovered sequences for all samples into unaligned FASTA files (one per gene).
    ```bash
    # Extract Nucleotide CDS
    hybpiper retrieve_sequences dna -t_aa targets.fasta --sample_names namelist.txt
    
    # Extract Protein sequences
    hybpiper retrieve_sequences aa -t_aa targets.fasta --sample_names namelist.txt
    ```

### 3. Paralog Investigation
If a gene has multiple high-quality assemblies, HybPiper flags it as a putative paralog.
```bash
hybpiper paralog_retriever namelist.txt -t_aa targets.fasta
```

## Expert Tips and Best Practices

*   **Directory Consistency:** Always run `hybpiper assemble` for every sample from the same base directory. HybPiper creates a directory named after the `--prefix` for each sample. Post-processing commands (like `stats` and `retrieve_sequences`) expect this specific directory hierarchy.
*   **Target File Formatting:** In the target FASTA, use the format `>Species-GeneName`. This allows HybPiper to group multiple reference sequences for the same gene, which improves recovery when working with diverse taxa.
*   **Memory Management:** SPAdes is memory-intensive. When running on a cluster, use the `--cpu` flag to limit thread usage and ensure your job allocation matches the requirements of the assembler.
*   **Cleaning Up:** HybPiper generates many intermediate files (especially SPAdes folders). Once assembly is verified, these can be large. Use the default behavior (which cleans up) unless you specifically need to debug an assembly with `--keep_intermediate_files`.
*   **Input Quality:** While HybPiper can handle raw reads, it is highly recommended to use `fastp` or `Trimmomatic` to remove adapters and low-quality bases before running the pipeline to reduce assembly artifacts.

## Reference documentation
- [HybPiper GitHub Main](./references/github_com_mossmatters_HybPiper.md)
- [HybPiper Wiki and Tutorials](./references/github_com_mossmatters_HybPiper_wiki.md)