[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

![](_static/logo.png)
![](_static/logo.png)

CHAMOIS

* [User Guide](guide/index.html)
* [Examples](examples/index.html)
* [Figures](figures/index.html)
* [CLI Reference](cli/index.html)
* [API Reference](api/index.html)
* More
  + [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

Search
`Ctrl`+`K`

* [User Guide](guide/index.html)
* [Examples](examples/index.html)
* [Figures](figures/index.html)
* [CLI Reference](cli/index.html)
* [API Reference](api/index.html)
* [Preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

* [GitHub](https://github.com/zellerlab/CHAMOIS "GitHub")
* [PyPI](https://pypi.org/project/chamois-tool "PyPI")

# CHAMOIS [![Stars](https://img.shields.io/github/stars/zellerlab/CHAMOIS.svg?style=social&maxAge=3600&label=Star)](https://github.com/zellerlab/CHAMOIS/stargazers)[#](#chamois-stars "Link to this heading")

[![_images/logo.png](_images/logo.png)](_images/logo.png)

*Chemical Hierarchy Approximation for secondary Metabolite clusters Obtained In Silico.*

[![Actions](https://img.shields.io/github/actions/workflow/status/zellerlab/CHAMOIS/test.yml?branch=main&logo=github&style=flat-square&maxAge=300)](https://github.com/zellerlab/CHAMOIS/actions) [![PyPI](https://img.shields.io/pypi/v/chamois-tool.svg?logo=pypi&style=flat-square&maxAge=3600)](https://pypi.org/project/chamois-tool) [![Bioconda](https://img.shields.io/conda/vn/bioconda/chamois?logo=anaconda&style=flat-square&maxAge=3600)](https://anaconda.org/bioconda/chamois) [![Wheel](https://img.shields.io/pypi/wheel/chamois-tool.svg?style=flat-square&maxAge=3600)](https://pypi.org/project/chamois-tool/#files) [![Versions](https://img.shields.io/pypi/pyversions/chamois-tool.svg?logo=python&style=flat-square&maxAge=3600)](https://pypi.org/project/chamois-tool/#files) [![License](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square&maxAge=2678400)](https://choosealicense.com/licenses/gpl-3.0/) [![Source](https://img.shields.io/badge/source-GitHub-303030.svg?maxAge=2678400&style=flat-square)](https://github.com/zellerlab/CHAMOIS/) [![Mirror](https://img.shields.io/badge/mirror-EMBL-009f4d?style=flat-square&maxAge=2678400)](https://git.embl.de/larralde/CHAMOIS) [![Issues](https://img.shields.io/github/issues/zellerlab/CHAMOIS.svg?style=flat-square&maxAge=600)](https://github.com/zellerlab/CHAMOIS/issues) [![Docs](https://img.shields.io/readthedocs/chamois/latest?style=flat-square&maxAge=600)](https://chamois.readthedocs.io) [![Changelog](https://img.shields.io/badge/keep%20a-changelog-8A0707.svg?maxAge=2678400&style=flat-square)](https://github.com/zellerlab/CHAMOIS/blob/main/CHANGELOG.md) [![Preprint](https://img.shields.io/badge/preprint-bioRxiv-darkblue?style=flat-square&maxAge=2678400)](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)

## Overview[#](#overview "Link to this heading")

CHAMOIS is a fast method for predicting chemical features of natural products
produced by Biosynthetic Gene Clusters (BGCs) using only their genomic
sequence. It can be used to get chemical features from BGCs predicted in
silico with tools such as [GECCO](https://gecco.embl.de) or
[antiSMASH](https://antismash.secondarymetabolites.org).

## Setup[#](#setup "Link to this heading")

Run `pip install chamois-tool` in a shell to
download the development version from GitHub, or have a look at the
[Installation page](guide/install.html) to find other ways to install CHAMOIS.

## Citation[#](#citation "Link to this heading")

CHAMOIS is scientific software, with a
[preprint](https://www.biorxiv.org/content/10.1101/2025.03.13.642868)
in [BioRxiv](https://www.biorxiv.org). Check the
[Publications page](guide/publications.html) to see how to cite CHAMOIS.

## Library[#](#library "Link to this heading")

* [User Guide](guide/index.html)
  + [Installation](guide/install.html)
  + [Publications](guide/publications.html)
  + [Contribution Guide](guide/contributing.html)
  + [Changelog](guide/changes.html)
  + [Copyright Notice](guide/copyright.html)
* [Examples](examples/index.html)
  + [Basic functionalities](examples/basic.html)
  + [Explain a prediction](examples/explain.html)
* [Figures](figures/index.html)
  + [Cross-validation](figures/cv.html)
  + [Association network](figures/network.html)
* [CLI Reference](cli/index.html)
  + [Inference](cli/index.html#inference)
  + [Training](cli/index.html#training)
  + [Compound Search](cli/index.html#compound-search)
  + [Model Interpretation](cli/index.html#model-interpretation)
* [API Reference](api/index.html)
  + [Object model (`chamois.model`)](api/model/index.html)
  + [ORF detection (`chamois.orf`)](api/orf/index.html)
  + [Domain annotation (`chamois.domains`)](api/domains/index.html)
  + [Compositions (`chamois.compositions`)](api/compositions/index.html)
  + [Ontology (`chamois.ontology`)](api/ontology/index.html)
  + [Predictor (`chamois.predictor`)](api/predictor/index.html)
  + [ClassyFire (`chamois.classyfire`)](api/classyfire/index.html)

## Feedback[#](#feedback "Link to this heading")

### Contact[#](#contact "Link to this heading")

If you have any question about CHAMOIS, if you run into any issue, or if you
would like to make a feature request, please create an
[issue in the GitHub repository](https://github.com/zellerlab/CHAMOIS/issues/new).
You can also directly contact Martin Larralde via email.

### Contributing[#](#contributing "Link to this heading")

If you want to contribute to CHAMOIS, please have a look at the
contribution guide first, and feel free to open a pull
request on the [GitHub repository](https://github.com/zellerlab/CHAMOIS).

## License[#](#license "Link to this heading")

This library is provided under the [GNU General Public License 3.0 or later](https://choosealicense.com/licenses/gpl-3.0/).
See the [Copyright Notice](guide/copyright.html) section for more information.

*This project was developed by* [Martin Larralde](https://github.com/althonos)
*during his PhD project at the* [European Molecular Biology Laboratory](https://www.embl.de/)
*and the* [Leiden University Medical Center](https://lumc.nl/en/)
*in the* [Zeller team](https://zellerlab.org).

[next

User Guide](guide/index.html "next page")

On this page

* [Overview](#overview)
* [Setup](#setup)
* [Citation](#citation)
* [Library](#library)
* [Feedback](#feedback)
  + [Contact](#contact)
  + [Contributing](#contributing)
* [License](#license)

[Edit on GitHub](https://github.com/zellerlab/CHAMOIS/edit/master/docs/index.rst)

### This Page

* [Show Source](_sources/index.rst.txt)

© Copyright 2020-2026, Martin Larralde.

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.