[Skip to main content](#main-content)
[ ]

[ ]

`Ctrl`+`K`

[![Logo image](_static/cellsnake-logo-blue-small.png)](index.html)

Getting Started

* [Installation](installation.html)
* [Quick start example](quickstart.html)
* [Example run on Fetal Brain dataset](fetalbrain.html)
* Example run on Fetal Liver dataset
* [Metagenomics analysis](kraken.html)
* [How to draw marker plots](markers.html)
* [Config Files (Parameter Files)](configs.html)
* [Options and Arguments](options.html)
* [Downstream analysis](downstream.html)
* [Glossary](glossary.html)

* [.rst](_sources/fetalliver.rst "Download source file")
* .pdf

# Example run on Fetal Liver dataset

## Contents

* [Starting with a minimal run](#starting-with-a-minimal-run)
* [Integration](#integration)
* [Work on the integrated sample](#work-on-the-integrated-sample)
* [We can include the metadata to compare different groups](#we-can-include-the-metadata-to-compare-different-groups)
* [Visualisation of a marker gene](#visualisation-of-a-marker-gene)

# Example run on Fetal Liver dataset[#](#example-run-on-fetal-liver-dataset "Permalink to this headline")

Cellsnake can be run directly as a **snakemake** workflow. We recommend the wrapper but the snakemake workflow gives more control in some use cases.

Let’s try workflow on Fetal Liver dataset, accession number PRJEB34784. You can apply this idea to your own samples.

Since this dataset have 6 samples, rather than one MT percentage, we can make it automatic so that each sample will be trimmed accordingly.

## Starting with a minimal run[#](#starting-with-a-minimal-run "Permalink to this headline")

A minimal run is also enough, because we do not want to analyze samples separately but as an integrated sample.

```
snakemake -j 20 --config option=minimal percent_mt=auto
#cellsnake cli equivalent of this command is: cellsnake minimal data --percent_mt auto -j 20
```

## Integration[#](#integration "Permalink to this headline")

Then we can run integration.

```
snakemake -j 10 --config option=integration
#cellsnake cli equivalent of this command is: cellsnake integrate data -j 10
```

## Work on the integrated sample[#](#work-on-the-integrated-sample "Permalink to this headline")

Now it is time to work on the integrated sample. We can run full advanced run on the integrated object which is always generates at the same location.

```
snakemake -j 40 --config  datafolder=analyses_integrated/seurat/integrated.rds resolution=auto option=standard is_integrated_sample=True --rerun-incomplete
#cellsnake cli equivalent of this command is: cellsnake integrated standard analyses_integrated/seurat/integrated.rds --resolution auto  -j 40
```

[![fig1](_images/plot_dimplot_umap-orig.ident.png)](_images/plot_dimplot_umap-orig.ident.png) [![fig2](_images/plot_dimplot_umap-seurat_clusters.png)](_images/plot_dimplot_umap-seurat_clusters.png)
Integrated UMAP labelled samples and clusters

## We can include the metadata to compare different groups[#](#we-can-include-the-metadata-to-compare-different-groups "Permalink to this headline")

You can also run the workflow on the integrated object with the metadata. This will generate the plots (e.g. volcano plot) for the integrated object.

Example metadata.csv file is as follows:

```
sample,condition
FCAImmP7179363,CD45+
FCAImmP7179364,CD45-
FCAImmP7555846,CD45+
FCAImmP7555847,CD45-
FCAImmP7555856,CD45+
FCAImmP7555857,CD45-
```

The first column should be the sample names and the second column is the differential expression group.

```
snakemake -j 40 --config  datafolder=analyses_integrated/seurat/integrated.rds resolution=auto option=standard metadata=metadata.csv is_integrated_sample=True --rerun-incomplete
```

You will get volcano plots for each group vs the others.

[![_images/metaplot_volcano-condition-0.png](_images/metaplot_volcano-condition-0.png)](_images/metaplot_volcano-condition-0.png)
[![_images/metaplot_volcano-condition-1.png](_images/metaplot_volcano-condition-1.png)](_images/metaplot_volcano-condition-1.png)

## Visualisation of a marker gene[#](#visualisation-of-a-marker-gene "Permalink to this headline")

AHSP gene expression looks interesting, we can visualize it.

```
snakemake -j 40 --config  datafolder=analyses_integrated/seurat/integrated.rds resolution=auto option=standard is_integrated_sample=True gene=AHSP --rerun-incomplete
#cellsnake cli equivalent of this command is: cellsnake integrated standard analyses_integrated/seurat/integrated.rds --gene AHPS --resolution auto  -j 40
#it is also possible to give a file with a list of genes to visualize
#cellsnake cli equivalent of this command is: cellsnake integrated standard analyses_integrated/seurat/integrated.rds --gene marker.tsv --resolution auto  -j 40
#marker.tsv simple contain a gene name in each line and automatically read by workflow
```

[![_images/AHSP.png](_images/AHSP.png)](_images/AHSP.png)

[previous

Example run on Fetal Brain dataset](fetalbrain.html "previous page")
[next

Metagenomics analysis](kraken.html "next page")

Contents

* [Starting with a minimal run](#starting-with-a-minimal-run)
* [Integration](#integration)
* [Work on the integrated sample](#work-on-the-integrated-sample)
* [We can include the metadata to compare different groups](#we-can-include-the-metadata-to-compare-different-groups)
* [Visualisation of a marker gene](#visualisation-of-a-marker-gene)

By Sinan U. Umu

© Copyright 2023, Sinan U. Umu.