---
name: lexicmap
description: LexicMap performs base-level nucleotide alignment of sequences against massive databases of prokaryotic genomes using a hierarchical indexing strategy. Use when user asks to index large genome collections, search sequences against a genomic database, identify genes or plasmids, or convert alignment results to SAM and BLAST formats.
homepage: https://github.com/shenwei356/LexicMap
---


# lexicmap

## Overview

LexicMap is a specialized tool designed for base-level nucleotide alignment against massive databases of prokaryotic genomes (up to millions). It overcomes the memory and speed limitations of traditional tools like BLASTn by using a hierarchical indexing strategy based on LexicHash. It is particularly effective for identifying genes, plasmids, and viral sequences within fragmented or complete assemblies, providing standard metrics like identity, coverage, e-value, and bitscore.

## Core Workflows

### 1. Database Indexing
To search sequences, you must first build a LexicMap index (`.lmi`).

*   **From a directory of genomes:**
    ```bash
    lexicmap index -I /path/to/genomes/ -O database.lmi
    ```
*   **From a file list (recommended for >1M files):**
    ```bash
    lexicmap index --skip-file-check -X genome_list.txt -O database.lmi
    ```
*   **For Fungi or larger genomes:** Increase the max genome size (default 15MB):
    ```bash
    lexicmap index -g 300000000 -I fungi_dir/ -O fungi.lmi
    ```

### 2. Sequence Searching
Search queries against the generated index.

*   **Standard Gene/Short Query Search:**
    ```bash
    lexicmap search -d database.lmi query.fasta -o results.tsv
    ```
*   **Plasmid or Long Query Search:** Use lower identity and coverage thresholds to capture fragmented matches:
    ```bash
    lexicmap search -d database.lmi query.fasta -o results.tsv \
        --align-min-match-pident 70 --min-qcov-per-genome 50 --top-n-genomes 0
    ```
*   **Taxonomic Filtering:** Limit search to specific TaxIDs (requires taxdump and mapping file):
    ```bash
    lexicmap search -d database.lmi query.fasta -t 543,-561 \
        -T taxdump/ -G genome2taxid.tsv -o filtered_results.tsv
    ```

### 3. Utility Operations
*   **Extract Matched Subsequences:**
    ```bash
    lexicmap utils subseq -d database.lmi -f results.tsv -o matched_seqs.fasta
    ```
*   **Convert Output to SAM/BLAST format:**
    ```bash
    lexicmap utils 2sam -f results.tsv > results.sam
    lexicmap utils 2blast -f results.tsv > results.blast
    ```
*   **Resume Unfinished Indexing:** If a merge step was interrupted:
    ```bash
    lexicmap utils remerge -d database.lmi
    ```

## Expert Tips & Best Practices

*   **Memory Management:** If indexing crashes due to RAM limits, reduce the batch size using `-b` (e.g., `-b 2000`).
*   **Short Read Support:** LexicMap is optimized for >150bp. For shorter reads (e.g., 100bp), you must index with smaller desert parameters: `-D 50 -d 25`.
*   **Genome IDs:** Ensure your FASTA filenames contain unique identifiers. If you forget to use a regex during indexing, use `lexicmap utils edit-genome-ids` to fix the index without rebuilding.
*   **Soft-Masking:** When working with eukaryotic or repeat-heavy genomes, use the `--soft-masking` flag during indexing to treat lowercase bases as 'A's for seeding while preserving them for alignment.
*   **Performance:** For batch searching, use `--gc-interval 64` to force garbage collection and keep memory usage stable.



## Subcommands

| Command | Description |
|---------|-------------|
| lexicmap | Generate shell autocompletion scripts |
| lexicmap index | Generate an index from FASTA/Q sequences |
| lexicmap search | Search sequences against an index |
| utils | Some utilities |

## Reference documentation
- [LexicMap Introduction](./references/bioinf_shenwei_me_LexicMap_introduction.md)
- [Step 1: Building a Database](./references/bioinf_shenwei_me_LexicMap_tutorials_index.md)
- [LexicMap Usage Overview](./references/bioinf_shenwei_me_LexicMap_usage_lexicmap.md)
- [LexicMap FAQs](./references/bioinf_shenwei_me_LexicMap_faqs.md)
- [LexicMap Utilities](./references/bioinf_shenwei_me_LexicMap_usage_utils.md)