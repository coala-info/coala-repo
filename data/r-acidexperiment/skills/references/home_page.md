[Skip to contents](#main)

[AcidExperiment](index.html)
0.5.5

* [Reference](reference/index.html)
* [Changelog](news/index.html)

# AcidExperiment

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-acidexperiment/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

Toolkit to extend the functionality of [SummarizedExperiment](https://bioconductor.org/packages/SummarizedExperiment/).

## Installation

This is an [R](https://www.r-project.org/) package.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "AcidExperiment",
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
name='r-acidexperiment'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-acidexperiment/)
* [Report a bug](https://github.com/acidgenomics/r-acidexperiment/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing AcidExperiment](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://mike.steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder
* [More about authors...](authors.html)

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.1.1.