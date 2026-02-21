---
name: cell-types-analysis
description: The `cell-types-analysis` suite is a collection of R scripts designed to process the results of scRNA-seq cell type classifiers.
homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis
---

# cell-types-analysis

## Overview

The `cell-types-analysis` suite is a collection of R scripts designed to process the results of scRNA-seq cell type classifiers. It supports two primary workflows:
1.  **Evaluation**: Benchmarking classification tools by comparing their predictions against labeled reference data using metrics like F1-score, accuracy, and semantic similarity.
2.  **Production**: Aggregating predictions from multiple independent tools to derive a high-confidence consensus for novel, unlabeled datasets.

The tool is essential for handling the semantic complexity of cell type nomenclature by mapping labels to the Cell Ontology (CL).

## Tool-Specific Best Practices

### Input Data Preparation
*   **Standard Format**: Ensure tool outputs are tab-separated files with three columns: `cell_id`, `predicted_label`, and `score`.
*   **Metadata Headers**: For performance tracking, include metadata at the top of your output files:
    ```text
    # tool <tool_name>
    # dataset <dataset_name>
    ```
*   **File Naming**: When evaluating multiple tools, store outputs in a single directory and prefix filenames with the tool name (e.g., `toolA_output.tsv`, `toolB_output.tsv`).

### Reference Data Requirements
*   Evaluation requires a reference table with `cell_id`, `reference_label`, and `cell_ontology_term` (CL ID).
*   Use `build_cell_ontology_dict.R` to create the necessary mapping between text labels and ontology terms before running performance metrics.

## Common CLI Patterns

### 1. Building an Ontology Dictionary
Map your labels to ontology terms using metadata from SDRF files.
```bash
build_cell_ontology_dict.R \
  --input-dir <path_to_sdrf_dir> \
  --barcode-col-name "barcode" \
  --cell-label-col-name "cell_type" \
  --cell-ontology-col-name "ontology_term" \
  --output-dict-path "cl_dict.rds"
```

### 2. Evaluating Tool Performance
Generate a comprehensive table of metrics (Accuracy, F1, Semantic Similarity) for all tools in a directory.
```bash
get_tool_performance_table.R \
  --input-dir <predictions_dir> \
  --ref-file <reference_labels.tsv> \
  --ontology-graph <cl_graph.obj> \
  --lab-cl-mapping "cl_dict.rds" \
  --barcode-col-ref "cell_id" \
  --barcode-col-pred "cell_id" \
  --label-column-ref "reference_label" \
  --label-column-pred "predicted_label" \
  --num-cores 4
```

### 3. Generating Consensus Predictions
For novel data, first combine outputs from different tools, then calculate the consensus.
```bash
# Step 1: Combine outputs
combine_tool_outputs.R --input-dir <predictions_dir> --output-table "combined_results.tsv"

# Step 2: Get consensus
get_consensus_output.R \
  --input-table "combined_results.tsv" \
  --ontology-graph <cl_graph.obj> \
  --output-table "consensus_final.tsv"
```

## Expert Tips
*   **Semantic Similarity**: Use the `--semantic-sim-metric` flag in performance scripts to choose between different similarity measures (e.g., Resnik, Lin) depending on how strictly you want to penalize "near-miss" classifications in the ontology tree.
*   **Handling Unlabeled Cells**: Use the `--exclusions` flag with a YAML file to define terms that should be treated as "unlabelled" (e.g., "unknown", "unclassified") to avoid skewing accuracy metrics.
*   **P-Value Calculation**: If you need statistical confidence for your scores, run `get_empirical_dist.R` followed by `get_tool_pvals.R` to estimate the significance of the observed classification performance.

## Reference documentation
- [cell-types-analysis GitHub Repository](./references/github_com_ebi-gene-expression-group_cell-types-analysis.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cell-types-analysis_overview.md)