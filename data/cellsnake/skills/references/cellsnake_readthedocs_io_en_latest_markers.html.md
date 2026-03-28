[Skip to main content](#main-content)
[ ]

[ ]

`Ctrl`+`K`

[![Logo image](_static/cellsnake-logo-blue-small.png)](index.html)

Getting Started

* [Installation](installation.html)
* [Quick start example](quickstart.html)
* [Example run on Fetal Brain dataset](fetalbrain.html)
* [Example run on Fetal Liver dataset](fetalliver.html)
* [Metagenomics analysis](kraken.html)
* How to draw marker plots
* [Config Files (Parameter Files)](configs.html)
* [Options and Arguments](options.html)
* [Downstream analysis](downstream.html)
* [Glossary](glossary.html)

* [.rst](_sources/markers.rst "Download source file")
* .pdf

# How to draw marker plots

# How to draw marker plots[#](#how-to-draw-marker-plots "Permalink to this headline")

As explained for fetal-liver example, it is possible to visualize selected genes.

For this, you need to provide a list of genes in a file or a single gene name. Just save how you run the workflow and rerun it with the same parameters.

You can visuzalize any gene after the workflow completes.

```
cellsnake standard data --resolution auto  -j 10

#or on an integrated dataset
cellsnake integrated standard analyses_integrated/seurat/integrated.rds --gene AHPS --resolution auto  -j 10

#it is also possible to give a file with a list of genes to visualize
cellsnake integrated standard analyses_integrated/seurat/integrated.rds --gene markers.tsv --resolution auto  -j 10
```

[previous

Metagenomics analysis](kraken.html "previous page")
[next

Config Files (Parameter Files)](configs.html "next page")

By Sinan U. Umu

© Copyright 2023, Sinan U. Umu.