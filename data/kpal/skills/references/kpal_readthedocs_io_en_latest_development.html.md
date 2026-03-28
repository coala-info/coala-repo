[kPAL](index.html)

latest

* [Introduction](intro.html)
* [Installation](install.html)
* [Methodology](method.html)
* [Tutorial](tutorial.html)
* [Using the Python library](library.html)

* [API reference](api.html)

* Development
  + [Contributing](#contributing)
  + [Documentation](#documentation)
  + [Unit tests](#unit-tests)
  + [Coding style](#coding-style)
  + [Versioning](#versioning)
    - [Release procedure](#release-procedure)
* [*k*-mer profile file format](fileformat.html)
* [Changelog](changelog.html)
* [Copyright](copyright.html)

[kPAL](index.html)

* [Docs](index.html) »
* Development
* [Edit on GitHub](https://github.com/LUMC/kPAL/blob/master/doc/development.rst)

---

# Development[¶](#development "Permalink to this headline")

Development of kPAL happens on GitHub:
<https://github.com/LUMC/kPAL>

## Contributing[¶](#contributing "Permalink to this headline")

Contributions to kPAL are very welcome! They can be feature requests, bug
reports, bug fixes, unit tests, documentation updates, or anything els you may
come up with.

Start by installing all kPAL development dependencies:

```
$ pip install -r requirements.txt
```

This installs dependencies for building the documentation and running unit
tests.

After that you’ll want to install kPAL in *development mode*:

```
$ pip install -e .
```

Note

Instead of copying the source code to the installation directory,
this only links from the installation directory to the source code
such that any changes you make to it are directly available in the
environment.

## Documentation[¶](#documentation "Permalink to this headline")

The [latest documentation](http://kpal.readthedocs.org/) with user guide and
API reference is hosted at Read The Docs.

You can also compile the documentation directly from the source code by
running `make html` from the `doc/` subdirectory. This requires [Sphinx](http://sphinx-doc.org/)
to be installed.

## Unit tests[¶](#unit-tests "Permalink to this headline")

To run the unit tests with [pytest](http://pytest.org/), just run:

```
$ py.test
```

Use [tox](https://testrun.org/) to run the unit tests in all supported Python environments
automatically:

```
$ tox
```

## Coding style[¶](#coding-style "Permalink to this headline")

In general, try to follow the [PEP 8](http://www.python.org/dev/peps/pep-0008/) guidelines for Python code and [PEP
257](http://www.python.org/dev/peps/pep-0257/) for docstrings.

You can use the [flake8](http://flake8.readthedocs.org/en/latest/) tool to assist in style and error checking.

## Versioning[¶](#versioning "Permalink to this headline")

A normal version number takes the form X.Y.Z where X is the major version, Y
is the minor version, and Z is the patch version. Development versions take
the form X.Y.Z.dev where X.Y.Z is the closest future release version.

Note that this scheme is not 100% compatible with [SemVer](http://semver.org/) which would
require X.Y.Z-dev instead of X.Y.Z.dev but [compatibility with setuptools](http://peak.telecommunity.com/DevCenter/setuptools#specifying-your-project-s-version)
is more important for us. Other than that, version semantics are as described
by SemVer.

Releases are [published at PyPI](https://pypi.python.org/pypi/kPAL) and
available from the git repository as tags.

### Release procedure[¶](#release-procedure "Permalink to this headline")

Releasing a new version is done as follows:

1. Make sure the section in the `CHANGES.rst` file for this release is
   complete and there are no uncommitted changes.

   Note

   Commits since release X.Y.Z can be listed with `git log vX.Y.Z..` for
   quick inspection.
2. Update the `CHANGES.rst` file to state the current date for this release
   and edit `kpal/__init__.py` by updating \_\_date\_\_ and removing the
   `dev` value from \_\_version\_info\_\_.

   Commit and tag the version update:

   ```
   git commit -am 'Bump version to X.Y.Z'
   git tag -a 'vX.Y.Z'
   git push --tags
   ```
3. Upload the package to PyPI:

   ```
   python setup.py sdist upload
   ```
4. Add a new entry at the top of the `CHANGES.rst` file like this:

   ```
   Version X.Y.Z+1
   ---------------

   Release date to be decided.
   ```

   Increment the patch version and add a `dev` value to \_\_version\_info\_\_
   in `kpal/__init__.py` and commit these changes:

   ```
   git commit -am 'Open development for X.Y.Z+1'
   ```

[Next](fileformat.html "k-mer profile file format")
 [Previous](api.html "API reference")

---

© [Copyright](copyright.html) 2013-2014, LUMC, Jeroen F.J. Laros, Martijn Vermaat.
Revision `79b2ff97`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).