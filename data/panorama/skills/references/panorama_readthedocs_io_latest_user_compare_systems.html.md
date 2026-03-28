[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

[![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA](../index.html)

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](user_guide.html)
* [Modeler Documentation](../modeler/modeler_guide.html)
* [Developer documentation](../developer/developer_guide.html)
* [API Reference](../api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Section Navigation

Get Started:

* [Installation Guide 🦮](install.html)
* [Quick usage 🦅](quick_usage.html)
  + [Complete Biological Systems Prediction Workflow](pansystems.html)
  + [Pangenome Comparison Analysis](quick_compare.html)
* [Reporting Issues and Suggesting Features 💬](issues.html)

Biological system Prediction:

* [Gene Family annotation](annotation.html)
* [System Detection Based on Models](detection.html)
* [Systems analysis output 📊](write_systems.html)
  + [System Projection on Genomes](projection.html)
  + [System Association with Pangenome Elements](association.html)
  + [System Partition Analysis](partition.html)

Pangenomes comparison:

* [Conserved Spots Comparison Across Pangenomes](compare_spots.html)
* Systems Comparison Across Pangenomes

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Systems Comparison Across Pangenomes

# Systems Comparison Across Pangenomes[#](#systems-comparison-across-pangenomes "Link to this heading")

The `compare_systems` command identifies and analyzes conserved biological systems across multiple pangenomes by
comparing their gene family composition and computing similarity metrics.
This analysis builds upon previously [detected systems from individual pangenomes](detection.html) and uses **Gene
Family Relatedness Relationship (GFRR) metrics** to identify systems that are conserved across different bacterial
populations. The analysis generates visualizations showing system distribution patterns and creates graphs of conserved
system clusters.

## Systems Comparison Workflow[#](#systems-comparison-workflow "Link to this heading")

The systems comparison process runs as follows:

1. **Load and Validate Pangenomes**

   * Multiple pangenomes are loaded from .h5 files based on a .tsv file.
   * Each pangenome is validated to ensure that systems have been detected for the specified sources.
2. **Create Systems**

   * All systems from all pangenomes are represented as nodes in a
     unified [NetworkX](https://networkx.org/documentation/stable/) graph.
   * Each system is characterized by its gene families and model families for similarity assessment.
3. Compute GFRR-based Edges

   * For each pair of systems from different pangenomes:

     + Model gene families are compared using GFRR metrics.
     + If model families exceed thresholds, all gene families are compared.
   * Edges are added between systems that exceed both GFRR cutoff thresholds.
4. Cluster Conserved Systems

   Graph clustering algorithms
   ([Louvain](https://networkx.org/documentation/stable/reference/algorithms/community.html#module-networkx.algorithms.community.louvain))
   identify groups of similar systems that represent conserved biological systems across pangenomes based on the
   selected GFRR metric.
5. Generate Visualizations

   Heatmaps showing system distribution patterns across pangenomes are generated in HTML format for interactive
   exploration.
6. Write Results to Files

   Conserved systems are saved as graph files (GEXF, GraphML) and summary tables for further analysis and visualization.

## System comparison command Line Usage[#](#system-comparison-command-line-usage "Link to this heading")

Basic systems comparison with heatmap generation:

```
panorama compare_systems \
--pangenomes pangenomes.tsv \
--models defense_systems.tsv \
--sources defense_finder \
--output systems_comparison_results \
--heatmap \
--threads 8
```

Full analysis with conserved systems clustering:

```
panorama compare_systems \
--pangenomes pangenomes.tsv \
--models defense_systems.tsv cas_systems.tsv \
--sources defense_finder CasFinder \
--output systems_comparison_results \
--heatmap \
--gfrr_metrics min_gfrr_models \
--gfrr_cutoff 0.8 0.8 \
--gfrr_models_cutoff 0.2 0.2 \
--graph_formats gexf graphml \
--threads 8
```

### Key Options[#](#key-options "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| -p | –pangenomes | str (file path) | False | TSV file listing .h5 pangenomes with detected systems |
| -m | –models | List[str] (file paths) | False | Path(s) to system model files (must match –sources order) |
| -s | –sources | List[str] | False | Name(s) of systems sources (must match –models order) |
| -o | –output | str (directory path) | False | Output directory for comparison results |
| — | –gfrr\_cutoff | List[float] (2 values) | True | Two thresholds for min\_gfrr and max\_gfrr values (default: 0.5 0.8) |
| — | –seed | Int | Optional | Random seed to guarantee reproductibility (default 42) |
| — | –heatmap | bool (flag) | True | Generate heatmaps showing system distribution across pangenomes |
| — | –gfrr\_metrics | str (choice) | True | GFRR metric for clustering conserved systems (min\_gfrr\_models, max\_gfrr\_models, min\_gfrr, max\_gfrr) |
| — | –gfrr\_models\_cutoff | List[float] (2 values) | True | GFRR thresholds for model gene families (default: 0.4 0.6) |
| — | –graph\_formats | List[str] | True | Export graph formats: gexf, graphml |
| — | –canonical | bool (flag) | True | Include canonical system versions in analysis |

### Advanced Configuration Arguments[#](#advanced-configuration-arguments "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –cluster | str (file path) | True | Tab-separated file with pre-computed clustering results (cluster\_name\tfamily\_id format) |
| — | –method | str (choice) | True | MMSeqs2 clustering method: linclust or cluster (default: linclust) |
| — | –tmpdir | str (directory path) | True | Directory for temporary files (default: /tmp) |
| — | –keep\_tmp | bool (flag) | True | Keep temporary files after completion |
| -c | –cpus | int | True | Number of CPU threads for parallel processing (default: 1) |
| — | –verbose | int (choice) | True | Verbose level: 0 (warnings/errors), 1 (info), 2 (debug) (default: 1) |
| — | –log | str (file path) | True | Log output file (default: stdout) |
| -d | –disable\_prog\_bar | bool (flag) | True | Disable the progress bars |
| — | –force | bool (flag) | True | Force writing in output directory and pangenome file |

Note

PANORAMA can perform the clustering step first thing, but it’s also possible to use pre-computed clustering results with
the `--cluster` argument.
If you use let PANORAMA perform the clustering, you can look at the [Clustering](#../clustering.md) section for more
details about options.

### GFRR Metrics for Systems[#](#gfrr-metrics-for-systems "Link to this heading")

| Metric | Target Families | Description |
| --- | --- | --- |
| min\_gfrr\_models | Model families only | Conservative metric using core functional families |
| max\_gfrr\_models | Model families only | Liberal metric using core functional families |
| min\_gfrr | All families | Conservative metric using complete gene repertoire |
| max\_gfrr | All families | Liberal metric using complete gene repertoire |

### Cutoff Configuration[#](#cutoff-configuration "Link to this heading")

The dual-cutoff system provides hierarchical filtering:

| Filtering Stage | Cutoffs | Purpose |
| --- | --- | --- |
| Model families | gfrr\_models\_cutoff | Primary filter using core functional genes |
| All families | gfrr\_cutoff | Secondary filter using complete gene repertoire |

### Recommended settings[#](#recommended-settings "Link to this heading")

* Strict: gfrr\_models\_cutoff=[0.5, 0.5], gfrr\_cutoff=[0.8, 0.8]
* Moderate: gfrr\_models\_cutoff=[0.3, 0.3], gfrr\_cutoff=[0.6, 0.7]
* Permissive: gfrr\_models\_cutoff=[0.2, 0.2], gfrr\_cutoff=[0.4, 0.5]

## Output[#](#output "Link to this heading")

PANORAMA generates multiple outputs: interactive heatmaps, network graphs, and summary tables for comprehensive systems
analysis.

### File Organization[#](#file-organization "Link to this heading")

```
output_directory/
├── heatmap_number_systems.html
├── heatmap_normalized_systems.html
├── conserved_systems.gexf (optional)
└── conserved_systems.graphml (optional)
```

### Files description[#](#files-description "Link to this heading")

#### Heatmap Visualizations[#](#heatmap-visualizations "Link to this heading")

Interactive HTML heatmaps showing system distribution patterns:

| File | Description |
| --- | --- |
| heatmap\_number\_systems.html | Raw counts of each system type per pangenome |
| heatmap\_normalized\_systems.html | Normalized percentages showing relative abundance |

[PLACEHOLDER: Heatmap showing system distribution across multiple pangenomes]

[PLACEHOLDER: Normalized heatmap showing relative system abundance patterns]

#### Conserved System Clustering[#](#conserved-system-clustering "Link to this heading")

##### Network Graphs[#](#network-graphs "Link to this heading")

When `--gfrr_metrics` and `--graph_formats` are specified, generate `conserved_systems.gexf/graphml` Network graphs of
conserved system clusters.
Node attributes include system metadata, pangenome information, and cluster assignments
Edge attributes contain GFRR similarity scores and the number of shared gene families.

[PLACEHOLDER: Network graph of conserved systems clusters with different colors]

[previous

Conserved Spots Comparison Across Pangenomes](compare_spots.html "previous page")
[next

Extract and Visualize Pangenome Information ℹ️](info.html "next page")

On this page

* [Systems Comparison Workflow](#systems-comparison-workflow)
* [System comparison command Line Usage](#system-comparison-command-line-usage)
  + [Key Options](#key-options)
  + [Advanced Configuration Arguments](#advanced-configuration-arguments)
  + [GFRR Metrics for Systems](#gfrr-metrics-for-systems)
  + [Cutoff Configuration](#cutoff-configuration)
  + [Recommended settings](#recommended-settings)
* [Output](#output)
  + [File Organization](#file-organization)
  + [Files description](#files-description)
    - [Heatmap Visualizations](#heatmap-visualizations)
    - [Conserved System Clustering](#conserved-system-clustering)
      * [Network Graphs](#network-graphs)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/compare_systems.md)

### This Page

* [Show Source](../_sources/user/compare_systems.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.