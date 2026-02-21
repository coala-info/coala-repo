[Skip to contents](#main)

[WormBase](index.html)
0.5.0

* [Reference](reference/index.html)
* [Changelog](news/index.html)

# WormBase

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-wormbase/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

*Caenorhabditis elegans* genome annotations from [WormBase](https://wormbase.org/).

## Installation

### [R](https://www.r-project.org/) method

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "WormBase",
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
name='r-wormbase'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-wormbase/)
* [Report a bug](https://github.com/acidgenomics/r-wormbase/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing WormBase](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder

Developed by [Michael Steinbaugh](https://steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.0.7.