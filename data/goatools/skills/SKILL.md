---
name: goatools
description: "goatools is a Python suite for analyzing Gene Ontology data through enrichment analysis and DAG manipulation. Use when user asks to perform gene ontology enrichment analysis, visualize GO hierarchies, map terms to GOslim, or explore the gene ontology DAG."
homepage: https://github.com/tanghaibao/goatools
---


# goatools

## Overview

`goatools` is a specialized Python suite for bioinformaticians to analyze Gene Ontology data. It provides robust statistical methods for enrichment analysis (GOEA) and utilities for manipulating the GO DAG. It is particularly useful for interpreting high-throughput genomic data by identifying significant biological themes and visualizing the relationships between specific GO terms.

## Core Workflows

### 1. Gene Ontology Enrichment Analysis (GOEA)

Use `find_enrichment.py` to identify significantly over- or under-represented GO terms in a study set compared to a population background.

**Basic Command Pattern:**
```bash
python scripts/find_enrichment.py --pval=0.05 [study_file] [population_file] [association_file]
```

**Key Parameters:**
- `--pval`: Set the p-value threshold (default is 0.05).
- `--indent`: Format the output with indentation to show hierarchy.
- `--no_propagate_counts`: By default, counts are propagated to all parent terms. Use this flag to disable propagation if only direct annotations are needed.
- `--method`: Specify multiple testing correction (e.g., `bonferroni`, `fdr_bh`, `sidak`).

### 2. Visualizing GO Hierarchies

`goatools` uses Graphviz to generate visual representations of the GO DAG.

- **Plot a specific term's lineage:**
  ```bash
  python scripts/plot_go_term.py --term=GO:0008135
  ```
- **Plot multiple terms up to the root:**
  ```bash
  python scripts/go_plot.py --go_file=[list_of_go_ids.txt] -o output.png
  ```
- **Generate GML for Cytoscape:**
  Use the `--gml` flag with `plot_go_term.py` to export a file compatible with external graph editing software.

### 3. Mapping to GOslim

GOslim provides a high-level summary of the ontology by mapping specific terms to a subset of broader parent terms.

- **Map a single term:**
  ```bash
  python scripts/map_to_slim.py --term=GO:0008135 go-basic.obo goslim_generic.obo
  ```
- **Map an entire association file:**
  ```bash
  python scripts/map_to_slim.py --association_file=[data/association] go-basic.obo goslim_generic.obo
  ```

### 4. Text-based Hierarchy Exploration

- **Write hierarchy to text:** Use `wr_hier.py` to output an ASCII representation of the DAG.
  - `python scripts/wr_hier.py GO:0008135` (Downstream/Children)
  - `python scripts/wr_hier.py GO:0008135 --up` (Upstream/Ancestors)

## Expert Tips and Best Practices

- **Data Preparation**: Ensure you have the latest `.obo` file from the Gene Ontology website (`go-basic.obo`) before running analyses.
- **Association Formats**: `goatools` supports GAF, GPAD, and NCBI's `gene2go` formats. Ensure your association file matches the identifiers used in your study and population files.
- **Multiple Testing**: For large datasets, always use False Discovery Rate (`fdr_bh`) or Bonferroni corrections to minimize Type I errors.
- **Obsolete Terms**: If your data contains old GO IDs, use the `--obsolete` flag (where supported) or update your association files, as `goatools` focuses on the current DAG structure.
- **Environment**: Ensure `graphviz` and `pygraphviz` (or `pydot`) are installed in your environment if you intend to generate image files; otherwise, stick to text-based outputs.

## Reference documentation
- [GOATOOLS: A Python library for Gene Ontology analyses](./references/github_com_tanghaibao_goatools.md)
- [goatools - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_goatools_overview.md)