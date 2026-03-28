[methurator](.)

* Home
  + [Key features](#key-features)
  + [Installation](#installation)
    - [Pip](#pip)
    - [BioConda](#bioconda)
    - [BioContainer](#biocontainer)

* [Quick Start](quickstart/)

* [Example Workflow](workflow/)

* [Methodology](methodology/)

Commands

* [gt-estimator](commands/gt_estimator/)
* [downsample](commands/downsample/)
* [plot](commands/plot/)

[methurator](.)

* Home
* [Edit on VIBTOBIlab/methurator](https://github.com/VIBTOBIlab/methurator/edit/master/docs/index.md)

---

# 🧬 methurator

**methurator** is a Python package to estimate **CpG sequencing saturation**
for DNA methylation sequencing data. It supports two complementary approaches:

1. Chao's estimator (recommended)
2. Empirical downsampling

---

## Key features

* Extrapolate CpG discovery beyond observed sequencing depth
* Compute theoretical asymptotes
* Optional bootstrap confidence intervals
* Interactive HTML plots
* BioConda and BioContainer support

---

## Installation

### Pip

Dependencies

If you install *methurator* via pip, be sure to install its dependencies
[SAMtools](https://www.htslib.org/) and
[MethylDackel](https://github.com/dpryan79/MethylDackel).

```
pip install methurator
```

### BioConda

```
conda create -n methurator_env conda::methurator
conda activate methurator_env
```

### BioContainer

```
docker pull quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
docker run quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0 methurator -h
```

[Next](quickstart/ "Quick Start")

---

Copyright (c) 2025 Edoardo Giuili, TOBI lab

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[VIBTOBIlab/methurator](https://github.com/VIBTOBIlab/methurator)
[Next »](quickstart/)