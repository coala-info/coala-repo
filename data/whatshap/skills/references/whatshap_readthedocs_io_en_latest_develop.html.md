[whatshap](index.html)

* [Installation](installation.html)
* [User guide](guide.html)
* [Questions and Answers](faq.html)
* Contributing
  + [Code style](#code-style)
  + [Developing WhatsHap](#developing)
  + [Development installation](#development-installation)
  + [Development installation when using Conda](#development-installation-when-using-conda)
  + [Running tests](#running-tests)
  + [Code style](#id1)
  + [Installing other Python versions in Ubuntu](#installing-other-python-versions-in-ubuntu)
  + [Debugging](#debugging)
  + [Wrapping C++ classes](#wrapping-c-classes)
  + [Writing documentation](#writing-documentation)
  + [Making a release](#making-a-release)
  + [Adding a new subcommand](#adding-a-new-subcommand)
  + [Structure](#structure)
  + [Download count statistics](#download-count-statistics)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* [Changes](changes.html)

[whatshap](index.html)

* Contributing
* [View page source](_sources/develop.rst.txt)

---

# Contributing[](#contributing "Link to this heading")

Contributions to WhatsHap are welcome! Some ways in which you can help are,
for example:

* Fixing a bug
* Adding new feature
* Improving the documentation
* Responding to issues on GitHub
* Reviewing a pull request

For changes affecting the source code, it is easiest to send in a pull request
(PR) on GitHub.
Here are some guidelines for how to do this. They are not strict rules.
When in doubt, send in a PR and we will sort it out.

* Limit a PR to a single topic. Submit multiple PRs if necessary. This way, it
  is easier to discuss the changes individually, and in case we find that one
  of them should not go in, the others can still be accepted.
* For larger changes, consider opening an issue first to plan what you want to
  do.
* Include appropriate unit or integration tests. Sometimes, tests are hard to
  write or don’t make sense. If you think this is the case, just leave the tests
  out initially and we can discuss whether to add any.
* Add documentation and a changelog entry if appropriate.

## Code style[](#code-style "Link to this heading")

* The source code (`.py` files only) needs to be formatted with
  [black](https://black.readthedocs.io/).
  If you install [pre-commit](https://pre-commit.com),
  the formatting will be done for you.
* There are inconsistencies in the current code base since it’s a few years old
  already. New code should follow the current rules, however.
* Using an IDE is beneficial (PyCharm, for example). It helps to catch lots of
  style issues early (unused imports, spacing etc.).
* Use [Google-style docstrings](https://www.sphinx-doc.org/en/master/usage/extensions/example_google.html)
  (this is not PyCharm’s default setting).
* Avoid unnecessary abbreviations for variable names.
  Code is more often read than written.
* When writing a help text for a new command-line option,
  look at the existing `--help` output and follow the style.
  Try to make it look nice and short.
  Complete documentation should be in the online guide.

## Developing WhatsHap[](#developing "Link to this heading")

The [WhatsHap source code is on GitHub](https://github.com/whatshap/whatshap/).
WhatsHap is developed in Python 3, Cython and C++.

## Development installation[](#development-installation "Link to this heading")

For development, make sure that you install Cython and tox. We also recommend
using a virtualenv. This sequence of commands should work (use
`https://github.com/whatshap/whatshap.git` as URL if you do not have a
GitHub account):

```
git clone git@github.com:whatshap/whatshap.git
cd whatshap
python3 -m venv .venv
source .venv/bin/activate
pip install -e .[dev]
```

The last command installs also all the development dependencies.
Omit the `[dev]` to leave them out.

Install also [pre-commit](https://pre-commit.com/) and run `pre-commit install`.

## Development installation when using Conda[](#development-installation-when-using-conda "Link to this heading")

If you are familiar with [Conda](https://docs.conda.io/en/latest/), you can
also use a Conda environment for developing WhatsHap. We recommend that you
use Conda only to install Python itself and let the rest of the dependencies
be handled by `pip`:

```
conda create -n whatshap-dev python=3.10
conda activate whatshap-dev
pip install -e .[dev]
```

## Running tests[](#running-tests "Link to this heading")

While in the virtual (or Conda) environment, you can run the tests for the
current Python version like this:

```
pytest
```

Whenever you change any Cython code (`.pyx` files), you need to re-run the
`pip install -e .` step in order to compile it.

Optionally, to run tests for all supported Python versions, you can run
[tox](https://tox.readthedocs.io/). It creates separate virtual environments for each Python
version, installs WhatsHap into it and then runs the tests. It also tests documentation generation
with `sphinx`. Run it like this:

```
tox
```

If `tox` is installed on the system, you do not need to be inside a virtual environment for this.
Run `tox --skip-missing-interpreters` if you do not have all tested Python versions installed.
See one way below for how to install them on Ubuntu.

## Code style[](#id1 "Link to this heading")

Python code needs to be formatted with [Black](https://github.com/psf/black).
Either run `black whatshap tests` manually before you commit or use the
[pre-commit](https://pre-commit.com/) framework to automate this.

To check other style issues, run

```
tox -e flake8
```

## Installing other Python versions in Ubuntu[](#installing-other-python-versions-in-ubuntu "Link to this heading")

Ubuntu comes with one default Python 3 version, and in order to test WhatsHap
with older or newer Python versions, follow the instructions for enabling the
[“deadsnakes” repository](https://launchpad.net/~deadsnakes/%2Barchive/ubuntu/ppa).
After you have done so, ensure you have the following packages:

```
sudo apt install build-essential python-software-properties
```

Then get and install the desired Python versions. Make sure you install the `-dev` package.
For example, for Python 3.10:

```
sudo apt update
sudo apt install python3.10-dev
```

## Debugging[](#debugging "Link to this heading")

Here is one way to get a backtrace from gdb (assuming the bug occurs while
running the tests):

```
$ gdb python3
(gdb) run -m pytest
```

After you get a SIGSEGV, let gdb print a backtrace:

> (gdb) bt

Another way is to set `PYTHONFAULTHANDLER=1`:

```
PYTHONFAULTHANDLER=1 pytest -vxs tests/test_run_whatshap.py
```

## Wrapping C++ classes[](#wrapping-c-classes "Link to this heading")

The WhatsHap phasing algorithm is written in C++, as are many of the core
data structures such as the “Read” class. To make the C++ classes usable from
Python, we use Cython to wrap the classes. All these definitions are spread
across multiple files. To add new attributes or methods to an existing class
or to add a new class, changes need to be made in different places.

Let us look at the “Read” class. The following places in the code may need to
be changed if the Read class is changed or extended:

* `src/read.cpp`: Implementation of the class (C++).
* `src/read.h`: Header with the class declaration (also normal C++).
* `whatshap/cpp.pxd`: Cython declarations of the class. This repeats – using
  the Cython syntax this time – a subset of the information from the
  `src/read.h` file. This duplication is required because Cython
  cannot read `.h` files (it would need a full C++ parser for that).

  Note that the `cpp.pxd` file contains definitions for *all* the `.h`
  headers. (It would be cleaner to have them in separate `.pxd` files, but
  this leads to problems when linking the compiled files.)
* `whatshap/core.pxd`: This contains declarations of all *Cython* classes
  wrapping C++ classes. Note that the class `Read` in this file has the
  same name as the C++ class, but that it is not the same as the C++ one!
  The distinction is made by prefixing the C++ class with `cpp.`, which is
  the name of the module in which it is declared in (that is, the C++ class
  `Read` is declared in `cpp.pxd`). The wrapping (Cython) class `Read`
  stores the C++ class in an attribute named `thisptr`. If you add a new
  class, it needs to be added to this file. If you only modify an existing one,
  you probably do not need to change this file.
* `whatshap/core.pyx`: The Cython implementation of the wrapper classes.
  Again, the name `Read` by itself is the Python wrapper class and
  `cpp.Read` is the name for the C++ class.

Before adding yet more C++ code, which then requires extra code for wrapping it,
consider writing an implementation in Cython instead. See `readselect.pyx`,
for example, which started out as a Python module and was then transferred to
Cython to make it faster. Here, the Cython code is not merely a wrapper, but
contains the implementation itself.

## Writing documentation[](#writing-documentation "Link to this heading")

Documentation is located in the `doc/` subdirectory. It is written in
[reStructuredText format](http://docutils.sourceforge.net/docs/user/rst/quickref.html)
and is translated by [Sphinx](http://www.sphinx-doc.org/) into HTML format.

Documentation is hosted on [Read the Docs](https://readthedocs.org/).
It is built automatically whenever a commit is made. The documentation in the
`main` branch should be visible at
<https://whatshap.readthedocs.io/en/latest/>
and documentation for the most recent released version should be visible at
<https://whatshap.readthedocs.io/en/stable/>.

To generate documentation locally, ensure that you installed sphinx and the
add-ons necessary to build documentation (running `pip install -e .[docs]` will
take care of this). Then go into the `doc/` directory and run `make`. You can
then open `doc/_build/html/index.html` in your browser. The theme that is
used is a bit different from the one used on Read the Docs.

## Making a release[](#making-a-release "Link to this heading")

1. Update `CHANGES.rst`: Set the correct version number and ensure that
   all nontrivial, user-visible changes are listed.
2. Ensure you have no uncommitted changes in the working copy.
3. Run `tox`.
4. Tag the current commit with the version number (there must be a `v` prefix):

   ```
   git tag -a -m "Version 0.1" v0.1
   ```

   To release a development version, use an `rc` version number such as
   `v0.17rc1`.
   Users will only get these when they use `pip install --pre`.
5. Push the tag:

   ```
   git push --tags
   ```
6. Wait for the GitHub Action to finish. It will deploy the sdist and wheels to
   PyPI if everything worked correctly.
7. To update the [Bioconda recipe](https://github.com/bioconda/bioconda-recipes/blob/master/recipes/whatshap/meta.yaml),
   wait for the Bioconda bot to open a PR (in the `bioconda-recipes` repository).
   Ensure that the list of dependencies (the `requirements:`
   section in the recipe) is in sync with the `setup.py` file. If changes are
   necessary to the bot-generated PR, just add your own commits to that PR.

If something went wrong, fix the problem and follow the above instructions again,
but with an incremented revision in the version number. That is, go from version
x.y to x.y.1. PyPI will not allow you to change a version that has already been
uploaded.

## Adding a new subcommand[](#adding-a-new-subcommand "Link to this heading")

Use one of the modules in `whatshap/cli/` as a template. All modules in
that directory are automatically used as subcommands.

## Structure[](#structure "Link to this heading")

The code is logically split into two parts:
Everything in the `cli` submodule is the “application” code
(or perhaps: “frontend”) that implements the command-line interface.
The other, non-`cli` modules is the library (or “backend”).

Any errors occurring in the library part should raise specific exceptions that
indicate what exactly the problem is (e.g. `FastaNotIndexedError`).
The frontend catches all the expected errors and converts them to
`CommandLineError`, which end up as user-visible error messages.

## Download count statistics[](#download-count-statistics "Link to this heading")

Some statistics for the PyPI package are available at
[pypistats.org](https://pypistats.org/packages/whatshap).

Here is a query for Google BigQuery that shows download counts (from PyPI)
since a given date, broken down by version

```
SELECT
    file.project,
    file.version,
    COUNT(*) as total_downloads,
FROM
    TABLE_DATE_RANGE(
        [the-psf:pypi.downloads],
        TIMESTAMP("20170101"),
        CURRENT_TIMESTAMP()
    )
WHERE
    file.project = 'whatshap'
GROUP BY
    file.project, file.version
```

Statistics for the Conda package are available on the
[WhatsHap package detail page](https://anaconda.org/bioconda/whatshap/).

[Previous](faq.html "Questions and Answers")
[Next](notes.html "Various notes")

---

© Copyright 2014.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).