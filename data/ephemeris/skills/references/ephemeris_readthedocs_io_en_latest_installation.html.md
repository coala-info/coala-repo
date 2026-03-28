[Ephemeris](index.html)

* [Introduction](readme.html)
* Installation
  + [pip](#pip)
  + [Conda](#conda)
* [Commands](commands.html)
* [Code of conduct](conduct.html)
* [Contributing](contributing.html)
* [Project Governance](organization.html)
* [Release Checklist](developing.html)
* [History](history.html)

[Ephemeris](index.html)

* Installation
* [View page source](_sources/installation.rst.txt)

---

# Installation[¶](#installation "Link to this heading")

## [pip](https://pip.pypa.io/)[¶](#pip "Link to this heading")

For a traditional Python installation of Ephemeris, first set up a virtualenv
for `ephemeris` (this example creates a new one in `.venv`) and then
install with `pip`.

```
$ virtualenv .venv; . .venv/bin/activate
$ pip install ephemeris
```

When installed this way, ephemeris can be upgraded as follows:

```
$ . .venv/bin/activate
$ pip install -U ephemeris
```

To install or update to the latest development branch of Ephemeris with `pip`,
use the following `pip install` idiom instead:

```
$ pip install -U git+git://github.com/galaxyproject/ephemeris.git
```

## [Conda](http://conda.pydata.org/docs/)[¶](#conda "Link to this heading")

Another approach for installing Ephemeris is to use [Conda](http://conda.pydata.org/docs/)
(most easily obtained via the
[Miniconda Python distribution](http://conda.pydata.org/miniconda.html)).
Afterwards run the following commands.

```
$ conda config --add channels bioconda
$ conda install ephemeris
```

[Previous](readme.html "Introduction")
[Next](commands.html "Commands")

---

© Copyright 2017.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).