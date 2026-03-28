[ ]
[ ]

[Skip to content](#installation)

[![logo](../assets/icon_black.png)](.. "Shiba")

Shiba

Installation

Initializing search

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](..)
* [Installation](./)
* [Quick start](../quickstart/diff_splicing_bulk/)
* [Output](../output/shiba/)
* [Usage](../usage/shiba/)

[![logo](../assets/icon_black.png)](.. "Shiba")
Shiba

[Sika-Zheng-Lab/Shiba](https://github.com/Sika-Zheng-Lab/Shiba "Go to repository")

* [Home](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Conda](#conda)
  + [Docker](#docker)
  + [Snakemake](#snakemake)
* [ ]

  Quick start

  Quick start
  + [With bulk RNA-seq data](../quickstart/diff_splicing_bulk/)
  + [With single-cell RNA-seq data](../quickstart/diff_splicing_sc/)
* [ ]

  Output

  Output
  + [Shiba/SnakeShiba](../output/shiba/)
  + [scShiba/SnakeScShiba](../output/scshiba/)
* [ ]

  Usage

  Usage
  + [Shiba](../usage/shiba/)
  + [scShiba](../usage/scshiba/)
  + [SnakeShiba](../usage/snakeshiba/)
  + [SnakeScShiba](../usage/snakescshiba/)

Table of contents

* [Conda](#conda)
* [Docker](#docker)
* [Snakemake](#snakemake)

# Installation[¶](#installation "Permanent link")

## Conda[¶](#conda "Permanent link")

The following command will create a conda environment named `shiba` with all dependencies installed.

|  |  |
| --- | --- |
| ``` 1 2 3 ``` | ``` conda create -n shiba -c conda-forge -c bioconda shiba conda activate shiba # Activate the conda environment pip install styleframe==4.2 # optional, for generating outputs in Excel format. ``` |

You can also install minimal dependencies for **MameShiba**, a lightweight version of **Shiba** . If you want to perform only splicing analysis, this could be a good option. The following command will create a conda environment named `mameshiba` with minimal dependencies installed.

|  |  |
| --- | --- |
| ``` 1 ``` | ``` conda create -n mameshiba -c conda-forge -c bioconda mameshiba ``` |

---

## Docker[¶](#docker "Permanent link")

We provide a Docker image for **Shiba**. You can use the following command to pull the latest image from Docker Hub:

|  |  |
| --- | --- |
| ``` 1 2 3 4 5 6 7 8 ``` | ``` # Pull the latest image docker pull naotokubota/shiba:v0.8.2  # Login to the container docker run -it --rm naotokubota/shiba:v0.8.2 bash  # Run Shiba, for example, to see the help message docker run -it --rm naotokubota/shiba:v0.8.2 shiba.py -h ``` |

Memory allocation

You may need to allocate more memory to the container if you are using a large dataset. You can do this in the Docker Desktop settings:

* Go to Docker Desktop settings
* Click on the "Resources" tab
* Increase the memory limit as needed
* Click "Apply & Restart" to save the changes

![Docker Memory Setting](https://github.com/Sika-Zheng-Lab/Shiba/blob/develop/img/docker_memory_setting.png?raw=true)

---

## Snakemake[¶](#snakemake "Permanent link")

You need to install [Snakemake](https://snakemake.readthedocs.io/en/stable/) and clone the **Shiba** GitHub repository on your system:

|  |  |
| --- | --- |
| ``` 1 2 ``` | ``` # Clone the Shiba repository git clone https://github.com/Sika-Zheng-Lab/Shiba.git ``` |

And please make sure you have [Singularity](https://sylabs.io/guides/3.7/user-guide/quick_start.html) installed on your system as the snakemake workflow uses Singularity to run each step of the pipeline.

[Previous

Home](..)
[Next

With bulk RNA-seq data](../quickstart/diff_splicing_bulk/)

© 2024 Naoto Kubota

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)