[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[mzSpecLib documentation](index.html)

* [Home](index.html)
* [Format specification](specification/index.html)
* Contributing
* [Guidelines](guidelines/index.html)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/HUPO-PSI/mzSpecLib "GitHub")

Search
`Ctrl`+`K`

* [Home](index.html)
* [Format specification](specification/index.html)
* Contributing
* [Guidelines](guidelines/index.html)

* [GitHub](https://github.com/HUPO-PSI/mzSpecLib "GitHub")

Section Navigation

* Contributing

# Contributing[#](#contributing "Link to this heading")

This document briefly describes how to contribute to
[mzSpecLib](https://github.com/hupo-psi/mzspeclib).

## Before you begin[#](#before-you-begin "Link to this heading")

If you have an idea for a feature, use case to add or an approach for a bugfix,
you are welcome to communicate it with the community by opening a
thread in [GitHub Issues](https://github.com/hupo-psi/mzspeclib/issues).

## Development setup[#](#development-setup "Link to this heading")

### Local install[#](#local-install "Link to this heading")

1. Setup Python 3, and preferably create a virtual environment.
2. Clone the [mzSpecLib repository](https://github.com/hupo-psi/mzspeclib).
3. Use pip in editable mode to setup the development environment:

```
pip install --editable .[test,docs]
```

### Unit tests[#](#unit-tests "Link to this heading")

Run tests with `pytest`:

```
pytest ./tests
```

### Documentation[#](#documentation "Link to this heading")

To work on the documentation and get a live preview, install the requirements
and run `sphinx-autobuild`:

```
pip install .[docs]
sphinx-autobuild  ./docs/ ./docs/_build/
```

Then browse to <http://localhost:8000> to watch the live preview.

## How to contribute[#](#how-to-contribute "Link to this heading")

* Fork [mzSpecLib](https://github.com/hupo-psi/mzspeclib) on GitHub to
  make your changes.
* Commit and push your changes to your
  [fork](https://help.github.com/articles/pushing-to-a-remote/).
* Ensure that the tests and documentation (both Python docstrings and files in
  `/docs/`) have been updated according to your changes. Python
  docstrings are formatted in the
  [numpydoc style](https://numpydoc.readthedocs.io/en/latest/format.html).
* Open a
  [pull request](https://help.github.com/articles/creating-a-pull-request/)
  with these changes. You pull request message ideally should include:

  > + A description of why the changes should be made.
  > + A description of the implementation of the changes.
  > + A description of how to test the changes.
* The pull request should pass all the continuous integration tests which are
  automatically run by
  [GitHub Actions](https://github.com/hupo-psi/mzspeclib/actions).

[previous

Metadata attributes](specification/metadata.html "previous page")
[next

Guidelines](guidelines/index.html "next page")

On this page

* [Before you begin](#before-you-begin)
* [Development setup](#development-setup)
  + [Local install](#local-install)
  + [Unit tests](#unit-tests)
  + [Documentation](#documentation)
* [How to contribute](#how-to-contribute)

### This Page

* [Show Source](_sources/contributing.rst.txt)

Created using [Sphinx](https://www.sphinx-doc.org/) 9.0.4.

Built with the [PyData Sphinx Theme](https://pydata-sphinx-theme.readthedocs.io/en/stable/index.html) 0.16.1.