Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

PopPUNK 2.7.0 documentation

![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation

Contents:

* PopPUNK documentation
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

[View this page](_sources/index.rst.txt "View this page")

# PopPUNK documentation[¶](#poppunk-documentation "Link to this heading")

PopPUNK is a tool for clustering genomes. We refer to the clusters as
variable-length-k-mer clusters, or **VLKCs**. Biologically, these clusters
typically represent distinct strains. We refer to subclusters of strains as lineages.

If you are new to PopPUNK, we’d recommend starting on [Installation](installation.html), then
by reading the [Overview](overview.html).

![PopPUNK (Population Partitioning Using Nucleotide K-mers)](_images/poppunk_v2.png)

The first version was targeted specifically
as bacterial genomes, but the current version has also been used for viruses
(e.g. enterovirus, influenza, SARS-CoV-2) and eukaryotes (e.g. *Candida* sp.,
*P. falciparum*). Under the hood, PopPUNK uses
[pp-sketchlib](https://github.com/johnlees/pp-sketchlib) to rapidly calculate
core and accessory distances, and machine learning tools written in python to
use these to cluster genomes. A detailed description of the method can be found
in the [paper](https://doi.org/10.1101/gr.241455.118).

Important

Looking for older versions of the documentation? For previous versions with
the old API (`--assign-query`, `--refine-fit` etc) see [v2.2.0](https://poppunk.readthedocs.io/en/v2.2.0-docs/).
For older versions which used mash, see [v1.2.0](https://poppunk.readthedocs.io/en/v1.2.2-docs/).

Contents:

* PopPUNK documentation
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

## Why use PopPUNK?[¶](#why-use-poppunk "Link to this heading")

The advantages of PopPUNK are broadly that:

* It is fast, and scalable to over \(10^{5}\) genomes in a single run.
* Assigning new query sequences to a cluster using an existing database is scalable even beyond this.
* Cluster names remain consistent between studies, and other cluster labels such as MLST
  can be appended. **Please note that when used as documented PopPUNK outputs stable nomenclature**.
* Databases can be updated online (as sequences arrive).
* Online updating is equivalent to building databases from scratch.
* Databases can be kept small and managable by only keeping representative isolates.
* Databases naturally allow in-depth analysis of single clusters,
  but keeping the full context of the whole database.
* There is no bin cluster. Outlier isolates will be in their own cluster.
* Pre-processing, such as generation of an alignment, is not required.
* Raw sequence reads can be used as input, while being filtered for sequencing errors.
* The definition of clusters are biologically relevant.
* Many quantitative and graphical outputs are provided.
* A direct import into [microreact](https://microreact.org/) is
  available, as well as [cytoscape](http://www.cytoscape.org/),
  [grapetree](http://dx.doi.org/10.1101/gr.232397.117) and
  [phandango](http://jameshadfield.github.io/phandango/).
* Everything is available within a single python executable.

## Citation[¶](#citation "Link to this heading")

If you find PopPUNK useful, please cite as:

Lees JA, Harris SR, Tonkin-Hill G, Gladstone RA, Lo SW, Weiser JN, Corander J, Bentley SD, Croucher NJ. Fast and flexible
bacterial genomic epidemiology with PopPUNK. *Genome Research* **29**:1-13 (2019).
doi:[10.1101/gr.241455.118](https://dx.doi.org/10.1101/gr.241455.118)

See [Citing PopPUNK](citing.html) for more details.

## Index[¶](#index "Link to this heading")

* [Index](genindex.html)
* [Search Page](search.html)

[Next

Installation](installation.html)

Copyright © 2018-2025, John Lees and Nicholas Croucher

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* PopPUNK documentation
  + [Why use PopPUNK?](#why-use-poppunk)
  + [Citation](#citation)
  + [Index](#index)