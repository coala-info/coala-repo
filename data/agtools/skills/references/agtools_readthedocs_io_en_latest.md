[agtools](.)

Home

* Introduction
  + [Quick install](#quick-install)
  + [Documentation](#documentation)
  + [Citation](#citation)

Getting Started

* [Installation](install/)
* [Quick Start](quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](examples/stats/)
  + [Renaming elements](examples/rename/)
  + [Concatenating multiple graphs](examples/concat/)
  + [Filtering segments](examples/filter/)
  + [Cleaning a graph file](examples/clean/)
  + [Get component of a segment](examples/component/)
  + [Format conversion](examples/formatconv/)
* [API Tutorial](tutorial/)
* [Assembler examples](assemblerexamples/)
* [More examples](moreexamples/)
* [Applications](exampleapplications/)

Reference

* [CLI Commands](cli/)
* [API Documentation](api/)
* [File Formats](fileformats/)

Support

* [FAQ](faq/)
* [Changelog](changelog/)

[agtools](.)

* Home
* Introduction
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/index.md)

---

# agtools: A Software Framework to Manipulate Assembly Graphs

*agtools* is a Python framework for manipulating assembly graphs for downstream metagenomic applications, with a focus on the [Graphical Fragment Assembly (GFA) format](https://github.com/GFA-spec/GFA-spec). It offers a command-line interface for tasks such as graph format conversion, segment filtering, and component extraction. Supported formats include [GFA](https://github.com/pmelsted/GFA-spec/blob/master/GFA-spec.md), [FASTG](https://web.archive.org/web/20211209213905/http%3A//fastg.sourceforge.net/FASTG_Spec_v1.00.pdf), [ASQG](https://github.com/jts/sga/wiki/ASQG-Format) and [GraphViz DOT](http://www.graphviz.org/content/dot-language). Additionally, it provides a Python package interface that exposes assembler-specific functionality for advanced analysis and integration based on the GFA format.

## Quick install

Install using [pip](https://pypi.org/project/agtools/):

```
pip install agtools
```

Install from the [Bioconda](https://anaconda.org/bioconda/agtools) distribution using `conda` or [`mamba`](https://mamba.readthedocs.io/en/latest/index.html):

```
mamba install -c bioconda agtools
```

Further details are available in the [Installation Guide](install/).

## Documentation

**Tutorials**

* [CLI examples](examples/stats/)
* [API tutorial](tutorial/)
* [Assembler-specific examples](assemblerexamples/)
* [More detailed examples](moreexamples/)
* [Example applications](exampleapplications/)

**References**

* [CLI reference](cli/)
* [API reference](api/)
* [File formats](fileformats/)
* [Source code](https://github.com/Vini2/agtools)

**Support**

* [Changelog](changelog/)
* [FAQ](faq/)

## Citation

*agtools* is currently under review. In the meantime, if you use `agtools` in your work, please cite the preprint as follows.

> Vijini Mallawaarachchi, George Bouras, Ryan R. Wick, Susanna R. Grigson, Bhavya Papudeshi, Robert A. Edwards; agtools: a software framework to manipulate assembly graphs; bioRxiv 2025.09.14.676178; doi: https://doi.org/10.1101/2025.09.14.676178

[Next](install/ "Installation")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).