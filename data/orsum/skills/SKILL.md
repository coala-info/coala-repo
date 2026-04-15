---
name: orsum
description: orsum summarizes and filters redundant enrichment analysis results by applying a hierarchical principle to identify representative biological terms. Use when user asks to simplify enrichment results, remove redundant pathway terms, or compare enrichment analysis results across multiple experimental conditions.
homepage: https://github.com/ozanozisik/orsum/
metadata:
  docker_image: "quay.io/biocontainers/orsum:1.8.0--hdfd78af_0"
---

# orsum

## Overview

`orsum` (over-representation summary) is a specialized tool designed to manage the complexity of enrichment analysis results. When biological pathway analyses return hundreds of significant terms, many are often redundant or highly specific descendants of broader categories. `orsum` applies a hierarchical filtering principle: a term is discarded if a more significant ancestor term exists that annotates at least the same set of genes. This process transforms overwhelming lists into a manageable set of representative terms, making it easier to identify core biological themes and compare results across multiple experimental conditions.

## CLI Usage and Best Practices

### Core Command Structure
The basic execution requires a GMT file (defining the hierarchy and gene sets) and one or more enrichment result files.

```bash
python orsum.py --gmt [PATH_TO_GMT] --files [ENRICHMENT_FILE1] [ENRICHMENT_FILE2]
```

### Input Requirements
*   **Format**: Input files must contain one term ID per line (e.g., `GO:0008150` or `REAC:R-HSA-1640170`).
*   **Sorting**: Files **must** be sorted by significance, with the most significant term at the top. `orsum` uses this order to determine which term represents another.
*   **No Headers**: Ensure input files do not contain header rows.

### Common Workflow Patterns

**1. Comparing Multiple Conditions**
When analyzing multiple datasets, use aliases to ensure the output plots and tables are readable.
```bash
python orsum.py --gmt hsapiens.GO:BP.gmt \
  --files control_enrich.txt treated_enrich.txt \
  --fileAliases "Control" "Treated" \
  --outputFolder comparison_results
```

**2. Controlling Summary Granularity**
Adjust the size thresholds to filter out terms that are too broad or too specific.
*   `--minTermSize`: Minimum genes in a term (default: 10). Increase this to ignore very specific, small gene sets.
*   `--maxRepSize`: Maximum size for a term to be a "representative." Use this to prevent extremely broad terms (like "Biological Process") from swallowing all specific results.

```bash
python orsum.py --gmt data.gmt --files results.txt --minTermSize 20 --maxRepSize 1000
```

**3. Optimizing Visualizations**
By default, `orsum` plots the top 50 terms. For publication-quality figures or very dense data, adjust this limit.
```bash
python orsum.py --gmt data.gmt --files results.txt --numberOfTermsToPlot 20
```

## Expert Tips
*   **GMT Consistency**: Always use the exact GMT file that was used during the initial enrichment analysis. If the GMT used by your enrichment tool is unavailable, g:Profiler is a recommended source for compatible Reactome and GO GMTs.
*   **Interpreting Outputs**:
    *   **Summary.tsv**: Best for a quick overview of representative terms across multiple inputs.
    *   **Detailed.tsv**: Use this to see exactly which specific terms were collapsed into each representative term.
    *   **Clustered Heatmap**: This is the most effective way to identify commonalities and differences between multiple enrichment runs.
*   **Handling Large Terms**: If your results are dominated by very general terms, use `--maxTermSize` to discard them entirely before processing begins.

## Reference documentation
- [orsum README](./references/github_com_ozanozisik_orsum.md)