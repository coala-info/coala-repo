[Skip to contents](#main)

[EggNOG](index.html)
0.3.1

* [Reference](reference/index.html)
* [Changelog](news/index.html)

# EggNOG

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-eggnog/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

[EggNOG](http://eggnog.embl.de/) database annotations.

## Installation

### [R](https://www.r-project.org/) method

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
install.packages(
    pkgs = "EggNOG",
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
name='r-eggnog'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-eggnog/)
* [Report a bug](https://github.com/acidgenomics/r-eggnog/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing EggNOG](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://mike.steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.1.3.