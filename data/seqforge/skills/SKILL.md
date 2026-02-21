---
name: seqforge
description: SeqForge is a modular bioinformatics toolkit designed to scale genomic analysis from raw sequence data to refined biological insights.
homepage: https://github.com/ERBringHorvath/SeqForge
---

# seqforge

## Overview
SeqForge is a modular bioinformatics toolkit designed to scale genomic analysis from raw sequence data to refined biological insights. It provides a streamlined pipeline for managing large-scale BLAST operations, performing regex-based motif mining across protein hits, and extracting genomic context (contigs or padded sequences) based on search results. The tool is optimized for power users who need to process directories of FASTA files or compressed archives efficiently without complex dependencies.

## Core Workflow and CLI Patterns

### 1. Data Preparation (Mandatory Step)
Before running any search or database operations, input files must be sanitized to remove special characters that break BLAST+ compatibility.
- **Sanitize files in place:** `seqforge sanitize -i <input_dir_or_file> --in-place`
- **Sanitize to new directory:** `seqforge sanitize -i <input_dir> -o <output_dir>`

### 2. Genome Search Module
Manage BLAST databases and execute parallelized queries.
- **Create Databases:** `seqforge makedb -i <fasta_dir> -o <db_output_dir>`
  - Supports nucleotide and protein databases.
  - Automatically uses multiprocessing for large datasets.
- **Batch Querying:** `seqforge query -d <db_dir> -q <query_dir> -o <results_dir> -f <fasta_dir>`
  - **Filtering:** Use `--identity`, `--coverage`, or `--evalue` to threshold results.
  - **Visualization:** Add `--visualize` to generate heatmaps (for hits) or sequence logos (for motifs). PDF is the recommended output format.

### 3. Advanced Motif Mining
Perform regex-based searches on amino acid sequences during `blastp` runs.
- **Unlinked Search:** `seqforge query ... --motif GHXXGE TAXXSS` (Searches all queries for both motifs).
- **Linked Search:** `seqforge query ... --motif GHXXGE{AT_domain} TAXXSS{KS_domain}`
  - This restricts the search for `GHXXGE` only to hits associated with the `AT_domain.faa` query file.
- **Exporting Motifs:** Use `--motif-fasta-out` to save matches, and optionally `--motif-only` to extract just the motif string rather than the full sequence.

### 4. Sequence Investigation
Extract specific regions identified during the query phase.
- **Padded Extraction:** `seqforge extract -i <query_results> -f <fasta_dir> --upstream 500 --downstream 500`
  - Useful for analyzing promoter regions or flanking genes.
- **Contig Extraction:** `seqforge extract-contig -i <query_results> -f <fasta_dir>`
  - Extracts the entire contig containing a hit. For `.faa` files, it extracts the full protein sequence.

### 5. Utility Commands
- **Assembly Metrics:** `seqforge fasta-metrics -i <input_dir>`
  - Calculates N50, L50, auN, GC content, and contig size distributions.
- **Unique Headers:** `seqforge unique-headers -i <fasta_file>`
  - Appends a unique alphanumeric barcode and filename to every header to prevent collisions in merged datasets.
- **Split Multi-FASTA:** `seqforge split-fasta -i <large_file> -n 100`
  - Splits a file into chunks of 100 sequences each.

## Expert Tips
- **Input Flexibility:** SeqForge natively handles `.gz` and `.zip` files, as well as directories and `.tar.gz` archives. You do not need to decompress files manually before processing.
- **Translation:** When using `extract`, you can use the `--translate` flag to convert nucleotide hits to protein, but only do this for full gene alignments.
- **Performance:** For large-scale searches, ensure your `--fasta_dir` (passed to `query`) contains the same sanitized files used to create the database to ensure coordinate consistency during extraction.

## Reference documentation
- [SeqForge GitHub Repository](./references/github_com_ERBringHorvath_SeqForge.md)
- [SeqForge Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seqforge_overview.md)