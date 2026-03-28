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

* Conserved Spots Comparison Across Pangenomes
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Conserved Spots Comparison Across Pangenomes

# Conserved Spots Comparison Across Pangenomes[#](#conserved-spots-comparison-across-pangenomes "Link to this heading")

The compare\_spots command identifies and analyzes conserved genomic spots across multiple pangenomes by comparing their
gene family composition and genomic organization patterns.
This analysis builds upon previously
[computed spots](https://ppanggolin.readthedocs.io/en/latest/user/RGP/rgpAnalyses.html#spot-prediction) from individual
pangenomes and uses **Gene Family Relatedness Relationship (GFRR) metrics** to identify regions that are conserved
across different bacterial populations. Optionally, it can integrate systems detection results to analyze biological
systems within conserved regions.

## Conserved Spots Detection Workflow[#](#conserved-spots-detection-workflow "Link to this heading")

The conserved spots comparison process runs as follows:

1. Load and Validate Pangenomes

   * Multiple pangenomes are loaded from .h5 files based on a .tsv file.
   * Each pangenome is validated to ensure that spots and RGPs have been computed.
2. Create Spots Graph

   * All spots from all pangenomes are represented as nodes in a unified NetworkX graph.
   * Each spot is characterized by its bordering gene families.
3. Compute GFRR-based Edges

   * For each pair of spots from different pangenomes:

     + Gene families at spot borders are extracted and compared.
     + GFRR metrics (min\_gfrr and max\_gfrr) are computed based on shared families.
   * Edges are added between spots that exceed both GFRR cutoff thresholds.
4. Cluster Conserved Spots

   * Graph clustering algorithms identify groups of similar spots that represent conserved genomic regions across
     pangenomes based on the selected GFRR metric.
5. Systems Integration (Optional)

   * When [enabled](detection.html), systems analysis creates linkage graphs showing relationships between biological
     systems through their association with conserved spots.
6. Write Results to Files

   * Conserved spots are saved as detailed TSV files and optional graph formats (GEXF, GraphML) for visualization.

## Compare spots command Line Usage[#](#compare-spots-command-line-usage "Link to this heading")

Basic conserved spots comparison:

```
panorama compare_spots \
--pangenomes pangenomes.tsv \
--output conserved_spots_results \
--gfrr_metrics min_gfrr \
--gfrr_cutoff 0.8 0.8 \
--threads 8
```

With system analysis enabled:

```
panorama compare_spots \
--pangenomes pangenomes.tsv \
--output conserved_spots_results \
--systems \
--models defense_systems.tsv \
--sources defense_finder \
--gfrr_cutoff 0.8 0.8 \
--graph_formats gexf graphml \
--threads 8
```

### Key Options 📋[#](#key-options "Link to this heading")

| Shortcut | Argument | Type | Required/Optional | Description |
| --- | --- | --- | --- | --- |
| -p | –pangenomes | File path | Required | TSV file listing .h5 pangenomes with computed spots |
| -o | –output | Directory path | Required | Output directory for conserved spots results |
| — | –gfrr\_metrics | String | Optional | GFRR metric for clustering: ‘min\_gfrr’ (conservative) or ‘max\_gfrr’ (liberal) |
| — | –gfrr\_cutoff | Float Float | Optional | Two thresholds for min\_gfrr and max\_gfrr values (default: 0.8 0.8) |
| — | –seed | Int | Optional | Random seed to guarantee reproductibility (default 42) |
| — | –dup\_margin | Float | Optional | Minimum ratio for multigenic family detection (default: 0.05) |
| — | –systems | Flag | Optional | Enable systems analysis within conserved spots |
| -m | –models | File path(s) | Required with –systems | Path(s) to system model files (required with –systems) |
| -s | –sources | String(s) | Required with –systems | System source names corresponding to models (required with –systems) |
| — | –canonical | Flag | Optional with –systems | Include canonical systems in analysis |
| — | –graph\_formats | String(s) | Optional | Export graph formats: gexf, graphml |

### Advanced Configuration Arguments[#](#advanced-configuration-arguments "Link to this heading")

| Shortcut | Argument | Type | Optional | Description |
| --- | --- | --- | --- | --- |
| — | –cluster | str (file path) | True | Tab-separated file with pre-computed clustering results (cluster\_name family\_id format) |
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
If you use let PANORAMA perform the clustering, you can look at the [Clustering](clustering.html#clustering) section for more
details about options.

### GFRR Metrics[#](#gfrr-metrics "Link to this heading")

| Metric | Formula | Description |
| --- | --- | --- |
| min\_gfrr | shared\_families / min(families\_spot1, families\_spot2) | Conservative metric requiring high overlap relative to smaller set |
| max\_gfrr | shared\_families / max(families\_spot1, families\_spot2) | Liberal metric allowing partial overlap relative to larger set |

### Sensitivity Control[#](#sensitivity-control "Link to this heading")

The dual cutoff system provides fine-grained control over conservation stringency:

| Cutoff Level | min\_gfrr | max\_gfrr | Behavior |
| --- | --- | --- | --- |
| Strict | 0.8 | 0.8 | High-confidence conserved spots only |
| Moderate | 0.6 | 0.7 | Balanced sensitivity and specificity |
| Permissive | 0.4 | 0.5 | Detects distant conservation patterns |

## Output[#](#output "Link to this heading")

PANORAMA generates multiple outputs: detailed spot information files, summary tables, and optional graph visualizations.

### File Organization[#](#file-organization "Link to this heading")

```
output_directory/
├── conserved_spots/
│ ├── conserved_spot_1.tsv
│ ├── conserved_spot_2.tsv
| |── ....................
│ └── conserved_spot_N.tsv
├── all_conserved_spots.tsv
├── conserved_spots.gexf (optional)
├── conserved_spots.graphml (optional)
├── systems_link_with_conserved_spots_louvain.gexf (optional)
└── systems_link_with_conserved_spots_mst.gexf (optional)
```

## Individual Conserved Spot Files[#](#individual-conserved-spot-files "Link to this heading")

Each `conserved_spot_X.tsv` contains detailed RGP-level information:

| Column | Description |
| --- | --- |
| Spot\_ID | Original spot identifier from source pangenome |
| Pangenome | Source pangenome name |
| RGP\_Name | Region of Genomic Plasticity name within the spot |
| Gene\_Families | Comma-separated list of gene families in the RGP |

### Summary File[#](#summary-file "Link to this heading")

all\_conserved\_spots.tsv provides an overview of all conserved spots:

| Column | Description |
| --- | --- |
| Conserved\_Spot\_ID | Unique identifier for the conserved spot group |
| Spot\_ID | Individual spot identifier from source pangenome |
| Pangenome | Source pangenome name |
| Num\_RGPs | Number of RGPs in this spot |
| Num\_Gene\_Families | Total number of gene families in this spot |

### Conserved spots Graph Files (Optional)[#](#conserved-spots-graph-files-optional "Link to this heading")

When `--graph_formats` is enabled, additional graph files are generated:

* Conserved spots graph in GEXF format
* Conserved spots graph in GraphML format

Node attributes include conserved spot ID, pangenome name, spot ID, the number of gene families, and the number of
RGPs.
Edge attributes include GFRR metric and the number of shared gene families.

[PLACEHOLDER: Example conserved spots visualization across pangenomes]

### Systems Analysis Files (Optional)[#](#systems-analysis-files-optional "Link to this heading")

When `--systems` is specified, generate `systems_link_with_conserved_spots_louvain.gexf/graphml` Network graphs of
conserved system clusters. These graphs are generated using the Louvain algorithm.

[PLACEHOLDER: Systems linkage graph showing relationships through conserved spots]

[previous

System Partition Analysis](partition.html "previous page")
[next

Systems Comparison Across Pangenomes](compare_systems.html "next page")

On this page

* [Conserved Spots Detection Workflow](#conserved-spots-detection-workflow)
* [Compare spots command Line Usage](#compare-spots-command-line-usage)
  + [Key Options 📋](#key-options)
  + [Advanced Configuration Arguments](#advanced-configuration-arguments)
  + [GFRR Metrics](#gfrr-metrics)
  + [Sensitivity Control](#sensitivity-control)
* [Output](#output)
  + [File Organization](#file-organization)
* [Individual Conserved Spot Files](#individual-conserved-spot-files)
  + [Summary File](#summary-file)
  + [Conserved spots Graph Files (Optional)](#conserved-spots-graph-files-optional)
  + [Systems Analysis Files (Optional)](#systems-analysis-files-optional)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/compare_spots.md)

### This Page

* [Show Source](../_sources/user/compare_spots.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.