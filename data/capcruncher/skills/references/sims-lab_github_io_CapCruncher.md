[ ]
[ ]

[Skip to content](#quick-start)

CapCruncher Documentation

Home

Initializing search

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

CapCruncher Documentation

[GitHub](https://github.com/sims-lab/CapCruncher "Go to repository")

* [ ]

  Home

  [Home](.)

  Table of contents
  + [Quick Start](#quick-start)

    - [Installation](#installation)
    - [Usage](#usage)
    - [Pipeline](#pipeline)

      * [Pipeline Configuration](#pipeline-configuration)
      * [Running the pipeline](#running-the-pipeline)
* [Installation](installation/)
* [Pipeline](pipeline/)
* [Cluster Setup](cluster_config/)
* [Hints and Tips](tips/)
* [Plotting CapCruncher output](plotting/)
* [CLI Reference](cli/)
* [ ]

  API Reference

  API Reference
  + [ ]

    capcruncher

    capcruncher
    - [ ]

      api

      api
      * [annotate](reference/capcruncher/api/annotate/)
      * [deduplicate](reference/capcruncher/api/deduplicate/)
      * [filter](reference/capcruncher/api/filter/)
      * [io](reference/capcruncher/api/io/)
      * [pileup](reference/capcruncher/api/pileup/)
      * [plotting](reference/capcruncher/api/plotting/)
      * [statistics](reference/capcruncher/api/statistics/)
      * [storage](reference/capcruncher/api/storage/)

Table of contents

* [Quick Start](#quick-start)

  + [Installation](#installation)
  + [Usage](#usage)
  + [Pipeline](#pipeline)

    - [Pipeline Configuration](#pipeline-configuration)
    - [Running the pipeline](#running-the-pipeline)

# Home

![CapCruncher Logo](img/capcruncher_logo.png)

CapCruncher is a package explicitly designed for processing Capture-C, Tri-C and Tiled-C data. Unlike other pipelines that are designed to process Hi-C or Capture-HiC data, the filtering steps in CapCruncher are specifically optimised for these datasets.

The package consists of a configurable data processing pipeline and a supporting command line interface to enable fine-grained control over the analysis.

The pipeline is fast, robust and scales from a single workstation to a large HPC cluster. The pipeline is designed to be run on a HPC cluster and can be configured to use a variety of package management systems e.g. conda and singularity.

## Quick Start[¶](#quick-start "Permanent link")

### Installation[¶](#installation "Permanent link")

Warning

CapCruncher is currently only availible for linux. MacOS support is planned for the future.

CapCruncher is available on conda and PyPI. To install the latest version, run:

It is highly recommended to install CapCruncher in a conda environment. If you do not have conda installed, please follow the instructions [here](https://github.com/conda-forge/miniforge#mambaforge) to install mambaforge.

```
pip install capcruncher
```

or

```
mamba install -c bioconda capcruncher
```

See the [installation guide](installation/) for more detailed instructions.

### Usage[¶](#usage "Permanent link")

CapCruncher commands are run using the `capcruncher` command. To see a list of available commands, run:

```
capcruncher --help
```

To see a list of available options for a command, run:

```
capcruncher <command> --help
```

See the [usage guide](usage/) for more detailed instructions.

### Pipeline[¶](#pipeline "Permanent link")

The CapCruncher pipeline handles the processing of raw data from the sequencer to the generation of a contact matrix, generation of plots and production of a UCSC genome browser track hub.

See the [pipeline guide](pipeline/) for more detailed instructions including how to configure the pipeline to run on HPC clusters and using various package management systems e.g. conda and singularity.

#### Pipeline Configuration[¶](#pipeline-configuration "Permanent link")

The pipeline is configured using a YAML file. It is strongly recommended to use the `capcruncher pipeline-config` command to generate a template configuration file. This command will generate a template configuration file with all available options and descriptions of each option.

```
capcruncher pipeline-config --help
```

#### Running the pipeline[¶](#running-the-pipeline "Permanent link")

The pipeline is run using the `capcruncher pipeline` command. Ensure that you have a configuration file and the fastq files to process are in the current working directory.

```
capcruncher pipeline --cores <NUMBER OF CORES TO USE>
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)