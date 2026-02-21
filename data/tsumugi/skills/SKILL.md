---
name: tsumugi
description: TSUMUGI (Trait-driven Surveillance for Mutation-based Gene module Identification) is a specialized bioinformatics tool designed to extract and visualize gene modules based on phenotypic similarity.
homepage: https://github.com/akikuno/TSUMUGI-dev
---

# tsumugi

---

## Overview
TSUMUGI (Trait-driven Surveillance for Mutation-based Gene module Identification) is a specialized bioinformatics tool designed to extract and visualize gene modules based on phenotypic similarity. By leveraging knockout (KO) mouse data, it allows researchers to "weave together" genes that manifest similar clinical or biological traits. This skill provides guidance on using the TSUMUGI Command-Line Interface (CLI) to process large-scale phenotype datasets, apply rigorous biological filters, and export results for downstream network analysis in tools like Cytoscape.

## Core CLI Workflows

The TSUMUGI CLI operates primarily by streaming JSONL data through various filtering subcommands. Most commands require either `pairwise_similarity_annotations.jsonl.gz` or `genewise_phenotype_annotations.jsonl.gz` as input.

### 1. Data Processing and Filtering
TSUMUGI subcommands are designed to be piped together to refine gene networks.

*   **Filter by Phenotype (MP Terms):**
    Include or exclude specific Mammalian Phenotype Ontology terms.
    ```bash
    # Keep only pairs sharing a specific phenotype
    tsumugi mp --include "increased circulating enzyme level" --pairwise < input.jsonl.gz > filtered.jsonl
    ```

*   **Filter by Biological Context:**
    Refine networks based on the specific conditions where phenotypes were observed.
    ```bash
    # Filter for female-specific phenotypes in homozygous mice
    tsumugi sex --keep Female < input.jsonl.gz | tsumugi zygosity --keep Homo > refined.jsonl
    ```

*   **Filter by Significance and Similarity:**
    Use the `score` command to threshold the network based on Phenodigm/Resnik similarity scores (0–100).
    ```bash
    tsumugi score --min 50 < input.jsonl.gz > high_confidence_pairs.jsonl
    ```

### 2. Gene List Analysis
To extract a subnetwork from a specific set of genes of interest:
```bash
# Keep only genes listed in a text file (one symbol per line)
tsumugi genes --keep genes_of_interest.txt --pairwise < input.jsonl.gz > subnetwork.jsonl
```

### 3. Network Generation and Export
Once filtered, convert the JSONL stream into standard formats for visualization.

*   **Cytoscape Compatibility:**
    ```bash
    tsumugi build-graphml < filtered_pairs.jsonl > network.graphml
    ```

*   **Local Webapp Generation:**
    Creates a standalone HTML/JS bundle for interactive exploration.
    ```bash
    tsumugi build-webapp < filtered_pairs.jsonl
    ```

## Expert Tips and Best Practices

*   **Streaming Architecture:** Always redirect output to a file (`>`) or pipe to the next command. The CLI is designed for high-throughput streaming and does not modify input files in place.
*   **Input Requirements:** 
    *   Use `--pairwise` flags when processing `pairwise_similarity_annotations`.
    *   Use `--genewise` flags when processing `genewise_phenotype_annotations`.
*   **Recomputing Data:** Use `tsumugi run` only when you need to incorporate the latest raw IMPC statistical results (`statistical-results-ALL.csv.gz`). For most analysis tasks, using the pre-computed JSONL files from the TSUMUGI homepage is significantly faster.
*   **Memory Management:** While the web tool limits gene lists to 200 entries for performance, the CLI can handle significantly larger sets. However, for visualization purposes, aim to filter the similarity score (`--min`) to maintain a readable edge density.

## Reference documentation
- [TSUMUGI-dev Main Repository](./references/github_com_akikuno_TSUMUGI-dev.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tsumugi_overview.md)