[Skip to content](#content)

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)
[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Toggle navigation menu

`⌘
K`

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)

[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Getting started

* [Installation](../getting_started/installation.html)

Workflow users

* [Deploy workflows](workflow_deployment.html)
* Register input data

Workflow developers

* [Update conda environment files](../workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](../workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](../workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Register input data

# Register input data

Snakedeploy can help with generating sample/unit sheets from files on the filesystem.
These can then be used to configure a Snakemake workflow.
Let’s say that we have a tab separated sheet of inputs called `unit-patterns.tsv`:

```
S743_Nr(?P<nr>[0-9]+)       S743_1/01_fastq/S743Nr{nr}.*.fastq.gz
S839_Nr(?P<nr>[0-9]+)       S839_*/01_fastq/S839Nr{nr}.*.fastq.gz
S888_Nr(?P<nr>[0-9]+)       S888/S888_1/01_fastq/S888Nr{nr}.*.fastq.gz
```

And then a file of samples, `samples.tsv` where the first column contains the sample ids. If we want to collect files on the system based on a glob
pattern of interest and print them to STDOUT (along with the sample id) we can do:

```
cut -f1 samples.tsv | tail -n+2 | snakedeploy collect-files --config unit-patterns.tsv
```

More specifically, the config sheet above lets us select, for each sample, a glob pattern, which is then used to obtain the files on disk that correspond to this sample, which are then printed tab separated to STDOUT, along with the sample id that we put in.
This allows us to obtain the path to the raw data of the given samples.

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)