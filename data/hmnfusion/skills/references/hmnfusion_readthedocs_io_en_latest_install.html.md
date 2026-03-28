[hmnfusion](index.html)

* Install
  + [Conda](#conda)
  + [Pip](#pip)
  + [Docker](#docker)
  + [Dependencies](#dependencies)
* [Usage](usage.html)
* [FAQ](faq.html)
* [Code of Conduct](conduct.html)
* [Contributing](contributing.html)
* [Changelog](change.html)

[hmnfusion](index.html)

* Install
* [View page source](_sources/install.rst.txt)

---

# Install[¶](#install "Link to this heading")

## Conda[¶](#conda "Link to this heading")

```
$ conda install -c bioconda hmnfusion
```

## Pip[¶](#pip "Link to this heading")

```
 $ wget https://github.com/guillaume-gricourt/HmnFusion/releases/download/1.5.1/pip.zip
 $ unzip pip.zip
 $ pip install hmnfusion-1.5.1-py3-none-any.whl
 $ rm pip.zip hmnfusion-1.5.1-py3-none-any.whl hmnfusion-1.5.1.tar.gz
```

## Docker[¶](#docker "Link to this heading")

Pull `hmnfusion`. It contains Genefuse, Lumpy and HmnFusion.

```
 $ docker pull ghcr.io/guillaume-gricourt/hmnfusion:1.5.1
```

Pull `hmmnfusion-align` to create BAM files

```
 $ docker pull ggricourt/hmnfusion-align:1.5.1
```

The reference files used to build BAM files refer to the DOI 10.5281/zenodo.6619597

Warning

The size of the image is almost 15Go

## Dependencies[¶](#dependencies "Link to this heading")

Genefuse and Lumpy are available in the `docker` image.
But they are not installed with `conda` and `pip`.
You can install them in the current environment with this:

```
$ hmnfusion install-software
```

[Previous](index.html "Welcome to HmnFusion’s documentation!")
[Next](usage.html "Usage")

---

© Copyright 2021-2024.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).