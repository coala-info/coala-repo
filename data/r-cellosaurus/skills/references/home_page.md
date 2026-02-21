[Skip to contents](#main)

[Cellosaurus](index.html)
0.8.2

* [Get started](articles/Cellosaurus.html)
* [Reference](reference/index.html)
* [Changelog](news/index.html)

# Cellosaurus

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-cellosaurus/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

[Cellosaurus](https://www.cellosaurus.org/) identifier mapping toolkit.

## Installation

### [R](https://www.r-project.org/) method

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "Cellosaurus",
    repos = c(
        "https://r.acidgenomics.com",
        BiocManager::repositories()
    ),
    dependencies = TRUE
)
```

### [Conda](https://conda.io/) method

Configure [Conda](https://conda.io/) to use the [Bioconda](https://bioconda.github.io/) channels.

```
# Don't install recipe into base environment.
name='r-cellosaurus'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-cellosaurus/)
* [Report a bug](https://github.com/acidgenomics/r-cellosaurus/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing Cellosaurus](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://mike.steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.