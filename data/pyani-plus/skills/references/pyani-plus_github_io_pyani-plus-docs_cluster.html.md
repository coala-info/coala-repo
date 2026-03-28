1. [Cluster](./cluster.html)

[pyANI-plus](./)

* [About pyANI-plus](./index.html)
* [Requirements](./requirements.html)
* [Installation](./installation.html)
* [pyANI-plus walkthrough](./walkthrough.html)
* [pyANI-plus subcommands](./subcommands/subcommands.html)

  + [1  `anib`](./subcommands/anib.html)
  + [2  `anim`](./subcommands/anim.html)
  + [3  `dnadiff`](./subcommands/dnadiff.html)
  + [4  `external-alignment`](./subcommands/external_alignment.html)
  + [5  `fastani`](./subcommands/fastani.html)
  + [6  `sourmash`](./subcommands/sourmash.html)
  + [7  `plot-run`](./subcommands/plot_run.html)
  + [8  `plot-run-comp`](./subcommands/plot_run_comp.html)
  + [9  `list-runs`](./subcommands/list_runs.html)
  + [10  `export-run`](./subcommands/export_run.html)
  + [11  `resume`](./subcommands/resume.html)
  + [12  `delete-run`](./subcommands/delete_run.html)
  + [13  `classify`](./subcommands/classify.html)
* [Cluster](./cluster.html)
* [Contributing to `pyANI-plus`](./contributing.html)
* [Testing](./testing.html)
* [Licensing](./licensing.html)

  + [14  pyANI-plus](./pyani_licence.html)
  + [15  pyANI-plus documentation](./doc_licence.html)

## Table of contents

* [SLURM](#slurm)
  + [ARCHIE-WeSt](#archie-west)
  + [Crop Diversity](#crop-diversity)
* [Cluster Troubleshooting](#cluster-troubleshooting)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/cluster.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

# Cluster

You can run `pyANI-plus` on a High Performance Compute (HPC) cluster, and for larger datasets this is generally expected. In the original tool `pyANI` we worked directly with SGE, which became a problem when our local cluster switched the SLURM instead. For `pyANI-plus` we instead use `snakemake` internally to handle our worker jobs. This gives us a uniform platform for running jobs locally (on the same machine – the default), or using one of the [Snakemake exectutor plugins](https://snakemake.github.io/snakemake-plugin-catalog/).

To enable this all the ANI compute commands have an optional `--executor` option defaulting to `local`. The analysis and plotting commands are only ever run locally.

## SLURM

This in the recommend parrallel executor for `pyANI-plus`, which was developed and tested on two different SLURM clusters ([ARCHIE-WeSt](https://www.archie-west.ac.uk/) and the [UK Crop Diversity Bioinformatics HPC Resource](https://cropdiversity.ac.uk/)).

You need to prepare a Snakemake configuration (as a directory containing a `config.yaml` file), set an environment variable to point at your configuration (the path of that directory), and add `--executor slurm` to your `pyani-plus` command.

```
mkdir snakemake-profile-name/
emacs snakemake-profile-name/config.yaml  # see examples below
export SNAKEMAKE_PROFILE=$PWD/snakemake-profile-name
pyani-plus ... --executor slurm ...
```

If you are using version control for your analysis scripts, you should also check-in the `config.yaml` file too.

While some of the underlying tools can be run with multiple cores, we expect you to ask the cluster for lots of single-core jobs (each of which has modest memory (RAM) needs). The exception is Sourmash, which is memory demanding but very quick - this we run on a single machine (even a desktop) with the default local executor.

### ARCHIE-WeSt

This is a real configuration used on [ARCHIE-WeSt](https://www.archie-west.ac.uk/) in 2025 while developing the tool.

On this cluster we were limited to at most 400 CPUs, which we tell Snakemake to use as (up to) 400 single-core jobs.

The `precommand` is used to make sure the `pyani-plus` command is available and on the `$PATH`. This cluster used the module system for dependencies, specifically we used a conda-based module, and within that a conda environment called `pyani-plus_py312` which had Python 3.12 and the tool and dependencies installed.

```
executor: slurm
jobs: 400
cores: 1
precommand: "module purge && module load miniconda && conda activate pyani-plus_py312"

default-resources:
    slurm_partition: dev
    slurm_account: pritchard-grxiv
```

This cluster has a billing system and required explicitly setting the partition (queue) and account. Here the RAM limit is implicit (set by the cluster administrators as a multiple of the cores for billing purposes).

### Crop Diversity

This configuration was used on the [Crop Diversity Cluster](https://cropdiversity.ac.uk) in 2025. It targetted their “hicpu” queue for low-memory CPU limited jobs, which at the time was setup with older compute nodes with 6 hour runtime and 2GB RAM limits. Here we could run 1000 jobs at once.

```
executor: slurm
jobs: 1000
cores: 1

default-resources:
    slurm_partition: hicpu
    slurm_account: cropdiv-acc
    runtime: 100
```

Snakemake would give distracting warnings if the account or runtime was ommitted, although this cluster had default values setup in SLURM. Here the RAM limit per job (2GB) was implicit via the partition (queue).

## Cluster Troubleshooting

Start with a small example first, like the walkthough, to make sure the cluster intergration is working. Check the stdout/stderr logs if possible. Use the logging and debug options within the tool.

If specfic genomes appear to be a problem, try reducing the number of genomes to work out which.

If you are getting out of memory (OOM) failures, this could be from larger or more complex genomes - in which case try increasing the RAM limit. However, pathological data like genomes which have not been quality controlled can cause problems in some methods (eg excessive runs of N).

[13  `classify`](./subcommands/classify.html)

[Contributing to `pyANI-plus`](./contributing.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/cluster.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).