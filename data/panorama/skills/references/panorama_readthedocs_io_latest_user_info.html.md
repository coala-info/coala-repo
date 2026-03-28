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
* [Systems Comparison Across Pangenomes](compare_systems.html)

PANORAMA utilities:

* Extract and Visualize Pangenome Information ℹ️
* [Gene Family Alignment Across Pangenomes](align.html)
* [Gene Family Clustering Across Pangenomes](clustering.html)

Indices

* [General Index](../genindex.html)
* [Python Module Index](../py-modindex.html)

* [User Documentation](user_guide.html)
* Extract and Visualize Pangenome Information ℹ️

# Extract and Visualize Pangenome Information ℹ️[#](#extract-and-visualize-pangenome-information-i "Link to this heading")

The info subcommand extracts summary information from PPanGGOLiN **.h5 pangenome files** and generates interactive HTML
reports. These reports support quick content comparison of each pangenome.

## Info command line usage ️[#](#info-command-line-usage "Link to this heading")

```
panorama info -i <pangenome_list.tsv> -o <output_directory> [--status] [--content]
```

## Output[#](#output "Link to this heading")

* [**status\_info.html**](#status-info) — Status of pangenome processing steps (annotation, clustering, etc.)
* [**content\_info.html**](#content-info) — Numerical summary: genomes, genes, gene families, modules, etc.

## Key options[#](#key-options "Link to this heading")

| Option | Description |
| --- | --- |
| –status | Extract and export the status (booleans) of each pangenome. |
| –content | Extract and export structural and numerical content metrics. |

default If no flags are provided, all (status, content, parameters, metadata) are extracted.

Warning

`--parameters` and `--metadata` outputs are not settled yet. We are currently working on a useful output.
Please add `--status` and/or `--content` to don’t get an error.

## Exploring the Reports[#](#exploring-the-reports "Link to this heading")

### Status info[#](#status-info "Link to this heading")

Shows whether each processing step was completed:

Example columns: Genomes\_Annotated, Genes\_Clustered, RGP\_Predicted, etc.

Features:

* Radio button filters for boolean values.
* TSV download of filtered results.

### Content info[#](#content-info "Link to this heading")

Displays statistics such as:

* Number of genes, genomes, gene families, modules.
* Frequencies and standard deviations.
* Partition composition (persistent, shell, cloud).

Features:

* Column visibility toggles.
* Range sliders for numeric filtering.
* TSV export of filtered view.

[previous

Systems Comparison Across Pangenomes](compare_systems.html "previous page")
[next

Gene Family Alignment Across Pangenomes](align.html "next page")

On this page

* [Info command line usage ️](#info-command-line-usage)
* [Output](#output)
* [Key options](#key-options)
* [Exploring the Reports](#exploring-the-reports)
  + [Status info](#status-info)
  + [Content info](#content-info)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/user/info.md)

### This Page

* [Show Source](../_sources/user/info.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.