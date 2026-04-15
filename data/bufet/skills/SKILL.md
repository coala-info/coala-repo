---
name: bufet
description: BUFET performs high-performance unbiased functional enrichment analysis to identify biological pathways associated with specific miRNA profiles. Use when user asks to perform miRNA enrichment analysis, calculate empirical p-values for biological pathways, or identify overrepresented gene ontologies from miRNA-gene interactions.
homepage: https://github.com/diwis/BUFET/
metadata:
  docker_image: "quay.io/biocontainers/bufet:1.0--py35h470a237_0"
---

# bufet

## Overview
BUFET (Boosting the Unbiased Functional Enrichment Analysis) is a high-performance bioinformatics tool designed to identify biological pathways significantly associated with specific miRNA profiles. It implements the unbiased enrichment algorithm proposed by Bleazard et al., but optimizes the execution using C++ bitsets. This allows researchers to perform millions of random iterations—necessary for robust empirical p-value calculation—in a fraction of the time required by standard implementations. The tool supports standard gene ontologies (GO, KEGG, PANTHER) and handles gene synonym matching to ensure data consistency.

## Execution Workflow

### 1. Preparation
Before running the Python wrapper, you must compile the C++ core. Navigate to the BUFET directory and run:
```bash
make
```
This generates a `.bin` file which must remain in the same directory as `bufet.py`.

### 2. Required Input Files
*   **miRNA File**: A plain text file with one miRNA name per line (e.g., `hsa-miR-132-5p`).
*   **Interactions File**: CSV format: `miRNA_name|gene_name`.
*   **Ontology File**: CSV format: `gene_name|pathway_id|pathway_name`.
*   **Synonyms File**: NCBI `All_Mammalia.gene_info` file (required unless `--no-synonyms` is used).

### 3. Common CLI Patterns

**Standard Enrichment Analysis**
Perform a basic run with default iterations (10,000) and automatic core detection:
```bash
python bufet.py -miRNA de_mirnas.txt -interactions interactions.csv -synonyms gene_info.txt -ontology pathways.csv -output results.txt
```

**High-Precision Analysis (1 Million Iterations)**
For publication-quality p-values, increase the iteration count:
```bash
python bufet.py -miRNA de_mirnas.txt -interactions interactions.csv -synonyms gene_info.txt -ontology pathways.csv -iterations 1000000 -processors 8
```

**Using Ensembl GO Annotations**
If your ontology file is exported from BioMart (Ensembl), use the specific flag to handle the format:
```bash
python bufet.py -miRNA de_mirnas.txt -interactions interactions.csv -synonyms gene_info.txt -ontology ensembl_go.csv --ensGO
```

**Using miRanda Predictions**
If using raw miRanda output instead of a validated interaction list:
```bash
python bufet.py -miRNA de_mirnas.txt -interactions miranda_output.txt -synonyms gene_info.txt -ontology pathways.csv --miRanda -miScore 150 -miFree -25.0
```

## Expert Tips and Best Practices
*   **Performance**: Always use the `-processors` flag to specify the number of CPU cores. BUFET scales linearly with available cores.
*   **File Validation**: By default, BUFET verifies input file formats. While `--disable-file-check` speeds up the start time, it is risky; only use it if you have pre-validated your CSV delimiters (`|`).
*   **Synonym Matching**: If your interaction and ontology files use consistent gene symbols (e.g., all HGNC symbols), use `--no-synonyms` to reduce memory overhead and execution time.
*   **Memory Requirements**: Ensure the system has at least 4GB of RAM, especially when processing the full NCBI synonym file.
*   **Species Support**: While "human" and "mouse" are defaults, you can use other species by providing the corresponding NCBI gene info file and interaction data.

## Reference documentation
- [BUFET Overview and Installation](./references/anaconda_org_channels_bioconda_packages_bufet_overview.md)
- [BUFET GitHub Documentation and Usage](./references/github_com_diwis_BUFET.md)