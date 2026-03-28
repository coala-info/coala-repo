[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

PANORAMA just released!

![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)
![PANORAMA documentation - Home](https://labgem.genoscope.cns.fr/wp-content/uploads/2021/06/GENOSCOPE-LABGeM.jpg)

PANORAMA

* [User Documentation](user/user_guide.html)
* [Modeler Documentation](modeler/modeler_guide.html)
* [Developer documentation](developer/developer_guide.html)
* [API Reference](api/api_ref.html)
* More
  + [PANORAMA](https://github.com/labgem/PANORAMA)
  + [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
  + [LABGeM](https://labgem.genoscope.cns.fr/)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Search
`Ctrl`+`K`

* [User Documentation](user/user_guide.html)
* [Modeler Documentation](modeler/modeler_guide.html)
* [Developer documentation](developer/developer_guide.html)
* [API Reference](api/api_ref.html)
* [PANORAMA](https://github.com/labgem/PANORAMA)
* [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
* [LABGeM](https://labgem.genoscope.cns.fr/)

* [GitHub](https://github.com/labgem/PANORAMA "GitHub")

Indices

* [General Index](genindex.html)
* [Python Module Index](py-modindex.html)

# PANORAMA: A robust pangenome-based method for predicting and comparing biological systems across species[#](#panorama-a-robust-pangenome-based-method-for-predicting-and-comparing-biological-systems-across-species "Link to this heading")

[![Actions](https://img.shields.io/github/actions/workflow/status/labgem/PANORAMA/main.yml?branch=main&event=pull_request&label=build&logo=github)](https://github.com/labgem/PANORAMA/actions/workflows/main.yml)
[![License](https://anaconda.org/bioconda/ppanggolin/badges/license.svg)](http://www.cecill.info/licences.fr.html)
[![Bioconda](https://img.shields.io/conda/vn/bioconda/panorama?style=flat-square&maxAge=3600&logo=anaconda)](https://anaconda.org/bioconda/panorama)
[![Source](https://img.shields.io/badge/source-GitHub-303030.svg?maxAge=2678400&style=flat-square)](https://github.com/labgem/PANORAMA/)
[![GitHub issues](https://img.shields.io/github/issues/labgem/panorama.svg?style=flat-square&maxAge=600)](https://github.com/labgem/panorama/issues)
[![Docs](https://img.shields.io/readthedocs/panorama/latest?style=flat-square&maxAge=600)](https://panorama.readthedocs.io)
[![Downloads](https://anaconda.org/bioconda/panorama/badges/downloads.svg)](https://bioconda.github.io/recipes/panorama/README.html#download-stats)

PANORAMA is a software suite used to analyze and compare partitioned pangenomes graph provided. It benefits from
methods for the reconstruction and analysis of pangenome graphs, thanks to
the [PPanGGOLiN](https://github.com/labgem/PPanGGOLiN)
software suite. It is designed to perform pangenome comparison at high-throughtup level.

---

# Quick Installation[#](#quick-installation "Link to this heading")

PANORAMA is easily installed with [conda](https://docs.conda.io/projects/conda/en/latest/index.html) and
[pip](https://pip.pypa.io/en/stable/). Follow the next step to install panorama.

```
# 1. Clone the Repository
git clone https://github.com/labgem/PANORAMA.git
cd PANORAMA

# 2. Create and Configure the Conda Environment
conda create -n panorama
conda config --add channels bioconda
conda config --add channels conda-forge
conda activate panorama
conda env update --file panorama.yml
```

---

# PANORAMA overview[#](#panorama-overview "Link to this heading")

## Input files[#](#input-files "Link to this heading")

PANORAMA can process multiple pangenomes at a time.
The common input file of most of the commands is a *TSV* file with two columns.
In the following we will name this file *pangenomes.tsv*

| Name | Path |
| --- | --- |
| Pangenome1 | path/to/pangenome1 |
| … | … |
| PangenomeX | path/to/pangenomeX |

Note

We recommend using an absolute path in this file to avoid errors.
You can use the path from your current directory or the path from the input file as a relative path to find pangenomes

## Biological systems detection[#](#biological-systems-detection "Link to this heading")

PANORAMA allows detecting systems in pangenomes by using models.
A model is an exhaustive and specific representation of a system.
PANORAMA models are flexible to describe any models provided by the user.
PANORAMA provides a command to perform the complete detection workflow as follows:

```
panorama pansystems \
-p pangenomes.tsv \
--hmm /PATH/TO/HMM/LIST/FILE/hmm_list.tsv \
 -m /PATH/TO/MODELS/LIST/FILE/models_list.tsv \
 -s system_model_source_name \
-o PATH/TO/OUPUT/DIRECTORY \
--projection \
--association all \
--partition
```

## Pangenome comparison[#](#pangenome-comparison "Link to this heading")

PANORAMA allows comparing pangenomes based on pangenome structure previously detected.

### Pangenome comparison based on spots[#](#pangenome-comparison-based-on-spots "Link to this heading")

Basic conserved spots comparison:

```
panorama compare_spots \
--pangenomes pangenomes.tsv \
--output conserved_spots_results \
--gfrr_metrics min_gfrr \
--gfrr_cutoff 0.8 0.8 \
--threads 8
```

### Pangenome comparison based on systems[#](#pangenome-comparison-based-on-systems "Link to this heading")

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

## Utilities[#](#utilities "Link to this heading")

### info Command — Extract and Visualize Pangenome Information[#](#info-command-extract-and-visualize-pangenome-information "Link to this heading")

The info subcommand extracts summary information from PPanGGOLiN **.h5 pangenome files** and generates interactive HTML
reports. These reports support quick content comparison of each pangenome.

## Info command line usage[#](#info-command-line-usage "Link to this heading")

```
panorama info -i <pangenome_list.tsv> -o <output_directory> [--status] [--content]
```

### Alignment & clustering of gene families[#](#alignment-clustering-of-gene-families "Link to this heading")

To perform the comparison of pangenomes, gene families are aligned and cluster.
PANORAMA provides commands to perform the alignment and clustering of gene families before the comparison of pangenomes.

Comprehensive all-against-all alignment:

```
panorama align \
--pangenomes pangenomes.tsv \
--output alignment_results \
--all_against_all \
--align_identity 0.5 \
--align_coverage 0.8 \
--align_cov_mode 0 \
--threads 8 \
--keep_tmp
```

Fast clustering with linclust:

```
panorama cluster \
--pangenomes pangenomes.tsv \
--output clustering_results \
--method linclust \
--cluster_identity 0.8 \
--cluster_coverage 0.8 \
--threads 8
```

---

# 💬 Feedback & Contribution[#](#feedback-contribution "Link to this heading")

**Give us feedback**
PANORAMA is still in early development.

Have suggestions, ideas, or bug reports?
👉 [Open an issue on GitHub](https://github.com/labgem/PANORAMA/issues)

Important

We cannot correct bugs if we do not know about them and will try to help you the best we can

---

User Guide:

* [User Documentation](user/user_guide.html)
  + [Installation Guide 🦮](user/install.html)
  + [Quick usage 🦅](user/quick_usage.html)
  + [Reporting Issues and Suggesting Features 💬](user/issues.html)
  + [Gene Family annotation](user/annotation.html)
  + [System Detection Based on Models](user/detection.html)
  + [Systems analysis output 📊](user/write_systems.html)
  + [Conserved Spots Comparison Across Pangenomes](user/compare_spots.html)
  + [Systems Comparison Across Pangenomes](user/compare_systems.html)
  + [Extract and Visualize Pangenome Information ℹ️](user/info.html)
  + [Gene Family Alignment Across Pangenomes](user/align.html)
  + [Gene Family Clustering Across Pangenomes](user/clustering.html)

Modeler Guide:

* [Modeler Documentation](modeler/modeler_guide.html)
  + [PANORAMA Models Overview 🔭](modeler/overview.html)
  + [PANORAMA System Modeling](modeler/modeling.html)
  + [PANORAMA – Model Translation Guide](modeler/translate.html)

Developer Guide:

* [Developer documentation](developer/developer_guide.html)

API Reference:

* [API Reference](api/api_ref.html)

TODO: Add the citation to MyST

[next

User Documentation](user/user_guide.html "next page")

On this page

* PANORAMA: A robust pangenome-based method for predicting and comparing biological systems across species
* [Quick Installation](#quick-installation)
* [PANORAMA overview](#panorama-overview)
  + [Input files](#input-files)
  + [Biological systems detection](#biological-systems-detection)
  + [Pangenome comparison](#pangenome-comparison)
    - [Pangenome comparison based on spots](#pangenome-comparison-based-on-spots)
    - [Pangenome comparison based on systems](#pangenome-comparison-based-on-systems)
  + [Utilities](#utilities)
    - [info Command — Extract and Visualize Pangenome Information](#info-command-extract-and-visualize-pangenome-information)
  + [Info command line usage](#info-command-line-usage)
    - [Alignment & clustering of gene families](#alignment-clustering-of-gene-families)
* [💬 Feedback & Contribution](#feedback-contribution)

[Edit on GitHub](https://github.com/labgem/PANORAMA/edit/dev/docs/index.md)

### This Page

* [Show Source](_sources/index.md.txt)

© Copyright 2025, LABGeM, Jérôme Arnoux.

Created using [Sphinx](https://www.sphinx-doc.org/) 8.2.3.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.