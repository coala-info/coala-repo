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
* System Detection Based on Models
* [Systems analysis output 📊](write_systems.html)
  + [System Projection on Genomes](projection.html)
  + [System Association with Pangenome Elements](association.html)
  + [System Partition Analysis](partition.html)

Pangenomes comparison:

* [Conserved Spots Comparison Across Pangenomes](compare_spots.html)
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* [Extract and Visualize Pangenome Information ℹ️](info.html)
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* System Detection Based on Models

# System Detection Based on Models[#](#system-detection-based-on-models "Link to this heading")

The `systems` command enables the detection of biological systems in pangenomes using predefined functional models.

This detection relies on gene family [annotations](annotation.html#gene-family-annotation),
and a [model](../modeler/modeling.html#models) file defining the presence/absence of a specific function and the genomic organization.

## Model Detection Workflow[#](#model-detection-workflow "Link to this heading")

The detection process runs as follows:

1. Load Pangenomes

   Based on a `.tsv` file, `.h5` pangenomes are loaded with the required annotation and metadata sources.
2. Load System Models

   The models are parsed from a list provided by `--models`.
3. Search for System Units

   For each functional unit of each model:

   1. Gene families are matched based on annotation metadata.
   2. A context graph is built based on the gene neighborhood (window, transitivity).
   3. Jaccard similarity filters edges in the graph.
   4. Connected components are checked for necessary and forbidden families.
4. Assemble Systems

   Functional units are grouped into systems if they satisfy:

   * presence/abscence rules
   * restrain distance
5. Write Systems to File

   Detected systems are saved back into the pangenome `.h5` file, under the given source name.

## Command Line Usage[#](#command-line-usage "Link to this heading")

System detection command is used as such:

```
panorama systems \
--pangenomes pangenomes.tsv \
--models models.tsv \
--source defense_finder \
--annotation_sources  defense_finder CasFinder\
--jaccard 0.8 \
--sensitivity 3 \
--threads 8
```

## Key Options[#](#key-options "Link to this heading")

| Shortcut | Argument | Description |
| --- | --- | --- |
| -p | –pangenomes | TSV file listing .h5 pangenomes |
| -m | –models | Path to the models list file (see panorama utils –models) |
| -s | –source | Name of the source used to annotate and detect systems |
| — | –annotation\_sources | List of annotation sources to use (defaults to the one from –source) |
| — | –jaccard | Minimum Jaccard similarity to keep an edge in context graph (default: 0.8) |
| — | –sensitivity | Sensitivity mode: 1, 2, or 3. Higher = more precise, slower (default: 3) |
| — | –threads | Number of threads to use for parallel model evaluation |

## Output[#](#output "Link to this heading")

PANORAMA integrates multiple outputs: textual, graph-based representations and figures to summarize results.

See the [write\_systems](write_systems.html#systems-analysis-output)

[previous

Gene Family annotation](annotation.html "previous page")
[next

Systems analysis output 📊](write_systems.html "next page")

On this page

* [Model Detection Workflow](#model-detection-workflow)
* [Command Line Usage](#command-line-usage)
* [Key Options](#key-options)
* [Output](#output)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/detection.md)

### This Page

* [Show Source](../_sources/user/detection.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.