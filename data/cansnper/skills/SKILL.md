---
name: cansnper
description: CanSNPer is a specialized tool for the hierarchical genotype classification of clonal bacterial pathogens.
homepage: https://github.com/adrlar/CanSNPer/
---

# cansnper

## Overview

CanSNPer is a specialized tool for the hierarchical genotype classification of clonal bacterial pathogens. It identifies canonical Single Nucleotide Polymorphisms (canSNPs) within query FASTA sequences and maps them to a known phylogenetic structure. By utilizing a local SQLite database containing reference sequences and tree definitions, it provides rapid lineage assignment and can generate visual phylogenetic trees (PDF) and detailed SNP lists.

## Common CLI Patterns

### Standard Classification
The most common use case is classifying a query FASTA file against a specific reference organism.
```bash
CanSNPer -i query.fa -r Yersinia_pestis -b CanSNPerDB.db
```

### Comprehensive Analysis
To generate all available outputs—including a tab-separated summary, a SNP list, and a visual phylogenetic tree—use the combined flags:
```bash
CanSNPer -i query.fa -r Yersinia_pestis -tldv -b CanSNPerDB.db
```
*   `-t`: Tab-separated output.
*   `-l`: List all identified SNPs in a text file.
*   `-d`: Draw a canSNP tree and save as a PDF.
*   `-v`: Verbose mode for progress tracking.

### Handling Low-Quality or Fragmented Data
If a sequence is missing specific regions, CanSNPer might fail to reach a leaf node. Use `--allow_differences` to permit a specific number of non-derived states in the tree path:
```bash
CanSNPer -i fragmented_sample.fa --allow_differences 1 -b CanSNPerDB.db
```

### Performance Tuning
CanSNPer uses threading for alignments when multiple reference strains are available (e.g., for *Francisella tularensis*). Control the thread count with `-n`:
```bash
CanSNPer -i query.fa -r Francisella_tularensis -b CanSNPerDB.db -n 4
```

## Database Management

### Initializing a New Organism
Before adding data, the organism must be initialized in the SQLite database:
```bash
CanSNPer -initialise_organism -r New_Pathogen -b CanSNPerDB.db
```

### Importing Reference Data
Populating the database requires three components: the SNP list, the tree structure, and the reference FASTA sequences.

1.  **Import SNPs**:
    ```bash
    CanSNPer -r New_Pathogen --import_snp_file snps.txt -b CanSNPerDB.db
    ```
2.  **Import Tree**:
    ```bash
    CanSNPer -r New_Pathogen --import_tree_file tree.txt -b CanSNPerDB.db
    ```
3.  **Import Reference Sequence**:
    ```bash
    CanSNPer -r New_Pathogen -b CanSNPerDB.db --import_seq_file reference.fa --strain_name RefStrain1
    ```

## Expert Tips

*   **Successor Tool**: Note that CanSNPer (v1.0.10) is the final release of the original tool. For active development and updated features, consider transitioning to **CanSNPer2**.
*   **Interactive Prompts**: If required arguments like `-r` (reference) are omitted, CanSNPer will prompt for them interactively. Type `exit` to abort a prompt.
*   **Tree Formatting**: When creating custom tree files for import, the first line must contain the root. Subsequent lines must list the node with all ancestors separated by semi-colons (e.g., `Root;SNP1;SNP2`).
*   **Reference Alignment**: For organisms with multiple reference strains, CanSNPer aligns the query to each. Ensure all reference sequences are imported into the database to avoid classification gaps.

## Reference documentation
- [CanSNPer Overview](./references/anaconda_org_channels_bioconda_packages_cansnper_overview.md)
- [CanSNPer GitHub Repository](./references/github_com_adrlar_CanSNPer.md)