---
name: cell-types-analysis
description: The cell-types-analysis suite benchmarks single-cell RNA sequencing cell type classifiers and generates consensus labels from multiple classification outputs. Use when user asks to map cell labels to ontologies, evaluate tool performance against ground truth, or aggregate multiple classifier results into consensus labels.
homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis
metadata:
  docker_image: "quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1"
---

# cell-types-analysis

## Overview

The cell-types-analysis suite provides a standardized framework for processing and benchmarking single-cell RNA sequencing (scRNA-seq) cell type labels. It bridges the gap between raw classification tool outputs and biological interpretation by enabling rigorous performance evaluation and the generation of high-confidence consensus labels from disparate classification methods. The toolset is particularly useful for researchers needing to validate new classification methods or harmonize results across multiple pre-trained classifiers for novel datasets.

## Core Workflows

### 1. Ontology Mapping
Before analysis, map free-text cell labels to formal Cell Ontology (CL) terms to enable semantic similarity metrics.
- **Script**: `build_cell_ontology_dict.R`
- **Input**: Directory of (condensed) SDRF metadata files.
- **Key Arguments**:
  - `--input-dir`: Path to SDRF files.
  - `--cell-label-col-name`: Column name for inferred labels (default: "inferred cell type").
  - `--cell-ontology-col-name`: Column name for CL terms (default: "cell.type.ontology").
  - `--output-dict-path`: Path for the resulting `.rds` dictionary.

### 2. Tool Evaluation
Benchmark classification tools against a "ground truth" reference dataset.
- **Script**: `get_tool_performance_table.R`
- **Metrics Calculated**: Accuracy, Median F1-score, percentage of unlabelled cells, exact/partial matching, and semantic similarity.
- **Input Requirements**: 
  - Standardized TSV files (cell_id, predicted_label, score).
  - A reference table with cell_id, reference_label, and CL terms.
- **Metadata**: Tool output files must include headers:
  ```text
  # tool <tool_name>
  # dataset <training_dataset_name>
  ```

### 3. Production Consensus
Aggregate predictions from multiple tools to improve label confidence for novel data.
- **Step A**: Run `combine_tool_outputs.R` to aggregate individual tool predictions into a single table.
- **Step B**: Run `get_consensus_output.R` to calculate agreement rates and semantic consistency across tools.
- **Output**: A table containing top labels, weighted scores, and an `agreement_rate`.

## CLI Best Practices

- **Standardized Input**: Ensure all tool output files are in a single directory and prefixed with the tool name (e.g., `toolX_output.tsv`).
- **Parallelization**: Use the `--num-cores` flag in `get_tool_performance_table.R` to speed up semantic similarity calculations on large datasets.
- **P-Value Calculation**: For robust evaluation, use `get_empirical_dist.R` followed by `get_tool_pvals.R` to assign statistical significance to performance scores.
- **Validation**: Always run `label_analysis_run_post_install_tests.sh` after installation to verify the R environment and dependencies (e.g., `dropletutils-scripts`, `bioconductor-onassis`).



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/get_empirical_dist.R | Computes empirical distributions for cell type analysis. |
| /usr/local/bin/get_tool_performance_table.R | Generates a performance table for cell type annotation tools. |
| build_cell_ontology_dict.R | Builds a dictionary mapping cell labels to cell ontology terms from SDRF files. |
| cell-types-analysis_get_consensus_output.R | Generates consensus output for cell type analysis. |
| combine_tool_outputs.R | Combines standardized output TSV files from multiple classifiers. |
| get_tool_pvals.R | Calculate p-values for tool performance statistics. |

## Reference documentation
- [Main README](./references/github_com_ebi-gene-expression-group_cell-types-analysis_blob_develop_README.md)
- [Ontology Dictionary Builder](./references/github_com_ebi-gene-expression-group_cell-types-analysis_blob_develop_build_cell_ontology_dict.R.md)
- [Performance Table Generator](./references/github_com_ebi-gene-expression-group_cell-types-analysis_blob_develop_get_tool_performance_table.R.md)