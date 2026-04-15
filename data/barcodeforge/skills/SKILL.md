---
name: barcodeforge
description: BarcodeForge automates the extraction of lineage-defining mutations from phylogenetic trees and alignments to create standardized barcode files for the Freyja demixing tool. Use when user asks to generate custom barcodes for pathogen variants, extract lineage mutations from genomic data, or prepare input files for wastewater demixing analysis.
homepage: https://github.com/andersen-lab/BarcodeForge
metadata:
  docker_image: "quay.io/biocontainers/barcodeforge:1.1.2--pyhdfd78af_0"
---

# barcodeforge

## Overview

BarcodeForge is a specialized CLI tool designed to bridge the gap between genomic surveillance data and the Freyja demixing tool. It automates the extraction of lineage-defining mutations from phylogenetic trees and alignments, producing the standardized barcode formats required for identifying specific pathogen variants in mixed samples (like wastewater). This skill provides the procedural knowledge to prepare inputs and execute the barcode generation pipeline effectively.

## Workflow and Best Practices

### 1. Input Preparation
Ensure all four required input files are present and correctly formatted:
- **Reference Genome**: A FASTA file containing the single reference sequence used for the alignment.
- **Multiple Sequence Alignment (MSA)**: A FASTA file containing all sequences that represent the lineages you wish to barcode.
- **Phylogenetic Tree**: A Newick or Nexus file. The leaf names in this tree must match the sequence IDs in your alignment and lineage table.
- **Lineage Table**: A TSV file with two columns: `lineage<TAB>sequence_id`. This maps specific sequences to their broader lineage designations.

### 2. Command Execution
The primary command is `barcodeforge barcode`. Use the following pattern for standard execution:

```bash
barcodeforge barcode \
    REFERENCE_GENOME.fasta \
    ALIGNMENT.fasta \
    TREE.nwk \
    LINEAGES.tsv \
    --tree_format newick \
    --threads 4 \
    --prefix PATHOGEN_NAME
```

### 3. Advanced Configuration
- **Tree Formats**: Explicitly set `--tree_format nexus` if your tree is not in Newick format to avoid parsing errors.
- **Lineage Prefixes**: Use the `--prefix` flag (e.g., `--prefix RSVa`) to ensure the output files and the internal lineage names are easily distinguishable when combined with other barcode sets.
- **Performance**: Increase `--threads` based on available CPU cores to speed up the mutation annotation process.
- **UShER Integration**: If specific tree-processing behavior is required, pass extra flags to the underlying UShER engine using `--usher-args "<args>"`.

### 4. Output Management
Upon successful completion, the tool generates:
- `[prefix]-barcodes.csv`: The machine-readable barcode file for Freyja.
- `[prefix]-barcodes.html`: An interactive visualization of the mutations defining each lineage.
- `barcodeforge_workdir/`: A directory containing intermediate files. It is recommended to delete this folder after verifying results to save disk space.



## Subcommands

| Command | Description |
|---------|-------------|
| barcodeforge barcode | Process barcode data, including VCF generation, tree formatting, USHER placement, matUtils annotation, and matUtils extraction. |
| barcodeforge extract-auspice-data | Extract metadata and tree from an Auspice JSON file. Inspired by Dr. John Huddleston's Gist on processing Auspice JSON files. Source: https://gist.github.com/huddlej/5d7bd023d3807c698bd18c706974f2db |

## Reference documentation
- [Creating custom barcodes](./references/andersen-lab_github_io_Freyja_src_wiki_custom_barcodes.html.md)
- [BarcodeForge Project Overview](./references/github_com_andersen-lab_BarcodeForge_blob_main_README.md)
- [CLI Dependencies and Requirements](./references/github_com_andersen-lab_BarcodeForge_blob_main_pyproject.toml.md)