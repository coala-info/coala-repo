---
name: phyluce
description: Phyluce is a suite of tools designed for ultraconserved element phylogenomics and the preparation of alignment matrices. Use when user asks to assemble reads, match contigs to probes, extract UCE loci, align sequences, or format data for phylogenetic analysis.
homepage: https://github.com/faircloth-lab/phyluce
metadata:
  docker_image: "quay.io/biocontainers/phyluce:1.6.8--py_0"
---

# phyluce

## Overview

Phyluce is a specialized suite of tools designed for UCE (Ultraconserved Element) phylogenomics. It provides a modular workflow to transform raw sequencing reads into curated alignment matrices suitable for downstream phylogenetic software like RAxML, IQ-TREE, or ExaML. While originally built for UCEs, its methods for assembly, locus identification, and parallel alignment are applicable to various conserved genomic markers across species, populations, and individuals.

## Core Workflows and CLI Patterns

### 1. Quality Control and Assembly
Before assembly, always verify read counts and perform adapter trimming. Phyluce typically interfaces with external assemblers like SPAdes or Velvet.

*   **Assemble reads with SPAdes:**
    ```bash
    phyluce_assembly_assemblo_spades \
        --config assembly.conf \
        --output out_folder \
        --cores 12
    ```
    *Note: The config file should follow the standard INI format mapping sample names to their respective FASTQ paths.*

### 2. Identifying and Extracting UCE Loci
This stage involves matching assembled contigs against a known probe set to identify conserved regions.

*   **Match contigs to probes:**
    ```bash
    phyluce_assembly_match_contigs_to_probes \
        --contigs /path/to/contigs \
        --probes probes.fasta \
        --output uce-search-results
    ```

*   **Generate match counts and extract FASTA:**
    After matching, create a relational database of matches and extract the sequences.
    ```bash
    # Create the match database
    phyluce_assembly_get_match_counts \
        --locus-db uce-search-results/probe.matches.sqlite \
        --output uce-sample-matches.conf \
        --status-check

    # Extract FASTA files for each locus
    phyluce_assembly_get_fastas_from_match_counts \
        --contigs /path/to/contigs \
        --locus-db uce-search-results/probe.matches.sqlite \
        --match-conf uce-sample-matches.conf \
        --output extracted-uce-loci.fasta
    ```

### 3. Alignment and Trimming
Phyluce automates parallel alignment of hundreds or thousands of loci.

*   **Align sequences (using MAFFT):**
    ```bash
    phyluce_align_seqcap_align \
        --input extracted-uce-loci.fasta \
        --output aligned-uce-loci \
        --taxa 20 \
        --aligner mafft \
        --cores 8
    ```

*   **Trim alignments (using Gblocks or Trimal):**
    ```bash
    phyluce_align_get_gblocks_trimmed_alignments_from_untrimmed \
        --alignments aligned-uce-loci \
        --output trimmed-uce-loci \
        --b2 0.5
    ```

### 4. Final Matrix Preparation
Filter loci based on taxon occupancy and format for phylogenetic analysis.

*   **Filter for minimum taxon occupancy:**
    ```bash
    phyluce_align_get_only_loci_with_min_taxa \
        --alignments trimmed-uce-loci \
        --taxa 20 \
        --percent 0.75 \
        --output filtered-alignments
    ```

*   **Format for RAxML/IQ-TREE:**
    ```bash
    phyluce_align_format_nexus_files_for_raxml \
        --alignments filtered-alignments \
        --output raxml-ready-matrix
    ```

## Expert Tips

*   **Conda Environment:** Always run phyluce within a dedicated Conda environment to avoid dependency conflicts with Python versions or bioinformatics libraries.
*   **Memory Management:** Assembly (SPAdes) and parallel alignment are RAM-intensive. Monitor your system resources and adjust the `--cores` parameter accordingly.
*   **Phasing Data:** For population-level studies, use the phasing workflow (`phyluce_assembly_phase_data`) to resolve allelic variation by mapping reads back to UCE contigs.
*   **Locus Names:** Ensure your probe FASTA headers are clean. Phyluce uses these headers to track loci across the entire pipeline.



## Subcommands

| Command | Description |
|---------|-------------|
| phyluce_align_get_trimmed_alignments_from_untrimmed | Use the PHYLUCE trimming algorithm to trim existing alignments in parallel |
| phyluce_assembly_assemblo_spades | Assemble raw reads using SPAdes |
| phyluce_assembly_get_fastas_from_match_counts | Given an input SQL database of UCE locus matches, a config file containing the loci in your data matrix, and the contigs you have assembled, extract the fastas for each locus for each taxon in the assembled contigs, and rename those to the appropriate UCE loci, outputting the results as a single monolithic FASTA file containing all records. Can also incorporate data from genome-enabled taxa or other studies using the --extend-db and --extend- contigs parameters. |
| phyluce_assembly_get_match_counts | Given an SQL database of UCE loci and a taxon-set file, output those taxa and those loci in complete and incomplete data matrices. |
| phyluce_phyluce_align_get_align_summary_data | Compute summary statistics for alignments in parallel |
| phyluce_phyluce_align_get_only_loci_with_min_taxa | Screen a directory of alignments, only returning those containing >= --percent of taxa |
| phyluce_phyluce_align_seqcap_align | Align and possibly trim records in a monolithic UCE FASTA file with MAFFT or MUSCLE |

## Reference documentation
- [Phyluce ReadTheDocs Overview](./references/phyluce_readthedocs_io_en_latest.md)
- [Tutorial I: UCE Phylogenomics](./references/phyluce_readthedocs_io_en_latest_tutorials_tutorial-1.html.md)
- [Tutorial II: Phasing UCE data](./references/phyluce_readthedocs_io_en_latest_tutorials_tutorial-2.html.md)
- [List of Programs](./references/phyluce_readthedocs_io_en_latest_daily-use_list-of-programs.html.md)