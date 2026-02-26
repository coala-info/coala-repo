---
name: prophyle
description: "ProPhyle accurately classifies DNA sequences for metagenomic analysis using phylogenetic relationships. Use when user asks to classify DNA sequences for metagenomic analysis, identify microbial communities, or classify viruses."
homepage: https://github.com/karel-brinda/prophyle
---


# prophyle

prophyle/SKILL.md
---
name: prophyle
description: Accurate, resource-frugal, and deterministic phylogeny-based metagenomic classifier. Use when Claude needs to classify DNA sequences for metagenomic analysis, specifically when identifying microbial communities or viruses based on phylogenetic relationships. This skill is ideal for tasks requiring high accuracy and efficient resource utilization in phylogenetic classification.
---

## Overview

ProPhyle is a powerful tool for metagenomic classification, leveraging phylogenetic relationships to accurately identify microbial communities and viruses within DNA sequence data. It is designed to be both resource-efficient and deterministic, making it suitable for large-scale analyses where precision and speed are critical. Use ProPhyle when you need to understand the composition of a microbial sample by classifying its constituent DNA sequences based on their evolutionary history.

## Usage Instructions

ProPhyle operates primarily through its command-line interface. The core functionality involves building an index and then classifying sequences against that index.

### Core Commands and Workflow

1.  **Building an Index:**
    Before classifying, you need to build a ProPhyle index from a reference database. This is a one-time process for a given database.

    ```bash
    prophyle build-index -d <reference_database_directory> -o <output_index_prefix>
    ```

    *   `-d <reference_database_directory>`: Path to the directory containing reference sequences (e.g., FASTA files).
    *   `-o <output_index_prefix>`: Prefix for the output index files. ProPhyle will generate multiple files (e.g., `.bwt`, `.nodes`, `.tree`).

2.  **Classifying Sequences:**
    Once an index is built, you can classify your query sequences.

    ```bash
    prophyle classify -i <query_sequences.fasta> -o <output_classification.tsv> -p <output_index_prefix>
    ```

    *   `-i <query_sequences.fasta>`: Path to the FASTA file containing the DNA sequences to classify.
    *   `-o <output_classification.tsv>`: Path for the output classification results in TSV format.
    *   `-p <output_index_prefix>`: The prefix of the ProPhyle index files created in the `build-index` step.

### Expert Tips and Best Practices

*   **Reference Database Quality:** The accuracy of ProPhyle's classification is highly dependent on the quality and completeness of your reference database. Ensure your reference sequences are well-curated and representative of the organisms you expect to find.
*   **Index Management:** Keep track of your index prefixes and the reference databases they were built from. For large projects, consider organizing your indices in dedicated directories.
*   **Output Format:** The default output of `classify` is a TSV file. This format is easily parsable by other bioinformatics tools and scripting languages for downstream analysis.
*   **Resource Management:** ProPhyle is designed to be resource-frugal. However, for very large datasets or reference databases, ensure you have sufficient RAM and disk space. The `build-index` step can be memory-intensive.
*   **Deterministic Output:** ProPhyle's deterministic nature means that running the same classification with the same index and input sequences will always yield the identical results, which is crucial for reproducibility.
*   **Command-Line Arguments:** Familiarize yourself with all available command-line arguments for `build-index` and `classify` to fine-tune performance and output. Use `prophyle build-index --help` and `prophyle classify --help` for detailed options.

## Reference documentation
- [ProPhyle README](./references/github_com_prophyle_prophyle.md)
- [ProPhyle Documentation](./references/github_com_prophyle_prophyle_tree_master_docs.md)
- [ProPhyle Anaconda Overview](./references/anaconda_org_channels_bioconda_packages_prophyle_overview.md)