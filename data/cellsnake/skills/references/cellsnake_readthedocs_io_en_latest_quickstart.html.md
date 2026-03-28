[Skip to main content](#main-content)
[ ]

[ ]

`Ctrl`+`K`

[![Logo image](_static/cellsnake-logo-blue-small.png)](index.html)

Getting Started

* [Installation](installation.html)
* Quick start example
* [Example run on Fetal Brain dataset](fetalbrain.html)
* [Example run on Fetal Liver dataset](fetalliver.html)
* [Metagenomics analysis](kraken.html)
* [How to draw marker plots](markers.html)
* [Config Files (Parameter Files)](configs.html)
* [Options and Arguments](options.html)
* [Downstream analysis](downstream.html)
* [Glossary](glossary.html)

* [.rst](_sources/quickstart.rst "Download source file")
* .pdf

# Quick start example

# Quick start example[#](#quick-start-example "Permalink to this headline")

Run cellsnake in a clean directory and cellsnake will create the required directories while running.

After downloading the dataset, just point the data folder which contains the two dataset folders, this will trigger a standard cellsnake workflow:

```
cellsnake standard data
# -j argument is optional, it will speed up the pipeline via threading, for example
cellsnake standard data -j 5
```

After the pipeline finishes, you may also integrate these two samples:

```
cellsnake integrate data
```

There will be a file called integrated.rds in the analyses\_integrated/seurat folder. This file can be used for further analysis after integration.

Let’s say you want a resolution of 0.1, then you can trigger a run with this resolution.

```
cellsnake integrated standard analyses_integrated/seurat/integrated.rds --resolution 0.1
```

To determine a manual resolution parameter, you can also create only a ClusTree.

```
cellsnake integrated clustree analyses_integrated/seurat/integrated.rds
```

It is also possible to use automatic resolution selection, however this might be very slow in large datasets.

```
cellsnake integrated standard analyses_integrated/seurat/integrated.rds --resolution auto
```

[previous

Installation](installation.html "previous page")
[next

Example run on Fetal Brain dataset](fetalbrain.html "next page")

By Sinan U. Umu

© Copyright 2023, Sinan U. Umu.