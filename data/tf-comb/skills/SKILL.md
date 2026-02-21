---
name: tf-comb
description: tf-comb (Transcription Factor Co-Occurrence using Market Basket analysis) is a Python-based framework designed to discover and analyze TF-TF interactions within regulatory elements.
homepage: https://tf-comb.readthedocs.io/
---

# tf-comb

## Overview

tf-comb (Transcription Factor Co-Occurrence using Market Basket analysis) is a Python-based framework designed to discover and analyze TF-TF interactions within regulatory elements. By treating genomic regions as "baskets" and TF binding sites (TFBS) as "items," it calculates association rules to identify significant co-binding events. This skill provides the procedural knowledge to manage the `CombObj` lifecycle, from initial site loading to advanced network and orientation analysis.

## Core Workflow

The standard tf-comb pipeline follows a specific sequence of operations on the `CombObj`.

### 1. Initialization and Data Loading
You can populate a `CombObj` using either experimental ChIP-seq data or by scanning for motifs in specific regions.

```python
from tfcomb import CombObj

# Option A: From ChIP-seq BED file
C = CombObj()
C.TFBS_from_bed("path/to/chipseq.bed")

# Option B: From motif scanning (requires genome FASTA and motif PWMs)
C.TFBS_from_motifs(regions="peaks.bed", 
                   motifs="motifs.txt", 
                   genome="genome.fa.gz", 
                   threads=8)
```

### 2. Co-occurrence Counting
Before running the market basket analysis, you must count the occurrences.

*   **Standard counting**: `C.count_within(max_distance=100)`
*   **Binarized counting**: Use `binarize=True` if you want to count a TF pair only once per window, regardless of multiple sites.
*   **Stranded counting**: Use `stranded=True` if you intend to perform orientation analysis later.

### 3. Market Basket Analysis
This step calculates the `cosine` and `zscore` metrics for all identified pairs.

```python
C.market_basket()
# Results are stored in C.rules (a pandas DataFrame)
```

### 4. Rule Selection and Simplification
Market basket analysis often generates thousands of rules. Filtering is essential for biological interpretation.

*   **Simplify**: Use `C.simplify_rules()` to remove redundant symmetric rules (e.g., keeping only TF1-TF2 and removing TF2-TF1 if the measure is symmetric).
*   **Significant Rules**: `C.select_significant_rules()` automatically calculates thresholds for z-score and cosine.
*   **Specific TFs**: `C.select_TF_rules(["CTCF", "RAD21"])` filters for rules involving specific factors.

## Advanced Analysis Patterns

### Orientation Analysis
To determine if TFs prefer specific relative orientations (e.g., convergent, divergent, or same-strand), ensure data was counted with `stranded=True`.

```python
# Analyze orientation preferences
orientation_df = C.analyze_orientation()

# Visualize as a heatmap
orientation_df.plot_heatmap()
```

### Network Analysis
tf-comb can transform co-occurrence rules into a graph where nodes are TFs and edges represent significant co-occurrence.

```python
# Build and plot the network
C.plot_network(color_node_by="cluster", engine="sfdp")

# Cluster TFs into modules
C.cluster_network(method="louvain") # or "blockmodel"
```

## Expert Tips

*   **Pickling**: `CombObj` can be large. Save your progress using `C.to_pickle("analysis.pkl")` and reload with `CombObj().from_pickle("analysis.pkl")`.
*   **Memory Management**: When scanning motifs across large genomes, use the `threads` parameter in `TFBS_from_motifs` and `count_within` to speed up processing.
*   **Overlap Handling**: By default, tf-comb handles overlapping TFBS. If you want to allow all overlaps (e.g., for nested motifs), set `max_overlap=1` in `count_within`.
*   **Visualization**: Most plotting functions (`plot_heatmap`, `plot_bubble`, `plot_network`) return matplotlib/seaborn objects that can be further customized.

## Reference documentation
- [ChIP-seq analysis example](./references/tf-comb_readthedocs_io_en_latest_examples_chipseq_analysis.html.md)
- [TFBS from motifs example](./references/tf-comb_readthedocs_io_en_latest_examples_TFBS_from_motifs.html.md)
- [Network analysis example](./references/tf-comb_readthedocs_io_en_latest_examples_Network_analysis.html.md)
- [Orientation analysis example](./references/tf-comb_readthedocs_io_en_latest_examples_Orientation_analysis.html.md)
- [Rule selection guide](./references/tf-comb_readthedocs_io_en_latest_examples_Select_rules.html.md)