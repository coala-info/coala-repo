[ ]
[ ]

[Skip to content](#snakescshiba-usage)

[![logo](../../assets/icon_black.png)](../.. "Shiba")

Shiba

SnakeScShiba

Initializing search

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Quick start](../../quickstart/diff_splicing_bulk/)
* [Output](../../output/shiba/)
* [Usage](../shiba/)

[![logo](../../assets/icon_black.png)](../.. "Shiba")
Shiba

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [ ]

  Quick start

  Quick start
  + [With bulk RNA-seq data](../../quickstart/diff_splicing_bulk/)
  + [With single-cell RNA-seq data](../../quickstart/diff_splicing_sc/)
* [ ]

  Output

  Output
  + [Shiba/SnakeShiba](../../output/shiba/)
  + [scShiba/SnakeScShiba](../../output/scshiba/)
* [x]

  Usage

  Usage
  + [Shiba](../shiba/)
  + [scShiba](../scshiba/)
  + [SnakeShiba](../snakeshiba/)
  + [ ]
    [SnakeScShiba](./)

# SnakeScShiba Usage[¶](#snakescshiba-usage "Permanent link")

This **snakescshiba.smk** script is written for use with Snakemake, a workflow management system that allows for the creation of reproducible and scalable data analyses. Snakemake uses a Python-based domain-specific language to define rules that specify how to generate output files from input files. These rules are executed in a directed acyclic graph (DAG) to ensure efficient and correct execution.

Key Features of Snakemake:

* Automatically determines the order of execution based on dependencies.
* Supports parallel execution on local machines, clusters, and cloud environments.
* Provides built-in support for logging, benchmarking, and resource management.

Tip

For more information about Snakemake, visit:

* Official Documentation: <https://snakemake.readthedocs.io/>
* GitHub Repository: <https://github.com/snakemake/snakemake>
* Tutorials and Examples: <https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html>

You can run the script using the following command:

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 ``` | ``` snakemake -s snakescshiba.smk \ --configfile config.yaml \ --cores 4 \ --use-singularity \ --singularity-args "--bind $HOME:$HOME" \ --rerun-incomplete ``` |

Please check the [Quick Start](../../quickstart/diff_splicing_sc/#1-prepare-inputs_1) to learn how to prepare the `config.yaml`.

![SnakeScShiba rulegraph](https://github.com/Sika-Zheng-Lab/Shiba/blob/mkdocs/img/SnakeScShiba_rulegraph.svg?raw=true)

This rulegraph was made by [snakevision](https://github.com/OpenOmics/snakevision).

[Previous

SnakeShiba](../snakeshiba/)

© 2024 Naoto Kubota

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)