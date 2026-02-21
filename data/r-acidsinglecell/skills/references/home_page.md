[Skip to contents](#main)

[AcidSingleCell](index.html)
0.4.4

* [Reference](reference/index.html)
* [Changelog](news/index.html)

# AcidSingleCell

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-acidsinglecell/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

Toolkit for single-cell RNA-seq analysis that extends the functionality of [SingleCellExperiment](https://bioconductor.org/packages/SingleCellExperiment/).

## Installation

This is an [R](https://www.r-project.org/) package.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "AcidSingleCell",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

### [Conda](https://docs.conda.io/) method

Configure [Conda](https://docs.conda.io/) to use the [Bioconda](https://bioconda.github.io/) channels.

```
# Don't install recipe into base environment.
name='r-acidsinglecell'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-acidsinglecell/)
* [Report a bug](https://github.com/acidgenomics/r-acidsinglecell/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing AcidSingleCell](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://mike.steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder
* [More about authors...](authors.html)

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.1.1.