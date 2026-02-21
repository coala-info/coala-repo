[Skip to contents](#main)

[AcidMarkdown](index.html)
0.3.1

* [Reference](reference/index.html)
* [Changelog](news/index.html)

# AcidMarkdown

[![Install with Bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg)](http://bioconda.github.io/recipes/r-acidmarkdown/README.html) ![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)

Toolkit for extending the functionality of [R Markdown](https://rmarkdown.rstudio.com/).

## Installation

This is an [R](https://www.r-project.org/) package.

```
install.packages(
    pkgs = "AcidMarkdown",
    repos = c(
        "https://r.acidgenomics.com",
        getOption("repos")
    ),
    dependencies = TRUE
)
```

### [Conda](https://docs.conda.io/) method

Configure [conda](https://docs.conda.io/) to use the [bioconda](https://bioconda.github.io/) channels.

```
# Don't install recipe into base environment.
name='r-acidmarkdown'
conda create --name="$name" "$name"
conda activate "$name"
R
```

## Links

* [Browse source code](https://github.com/acidgenomics/r-acidmarkdown/)
* [Report a bug](https://github.com/acidgenomics/r-acidmarkdown/issues/)

## License

* [AGPL-3](https://www.r-project.org/Licenses/AGPL-3)

## Citation

* [Citing AcidMarkdown](authors.html#citation)

## Developers

* [Michael Steinbaugh](https://mike.steinbaugh.com/)
   Author, maintainer
* [Acid Genomics](https://acidgenomics.com/)
   Copyright holder, funder

Developed by [Michael Steinbaugh](https://mike.steinbaugh.com/), [Acid Genomics](https://acidgenomics.com/).

Site built with [pkgdown](https://pkgdown.r-lib.org/) 2.1.1.