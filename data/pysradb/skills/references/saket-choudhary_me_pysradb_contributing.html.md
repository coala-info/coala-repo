Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[pysradb 3.0.0.dev0 documentation](index.html)

[![Logo](_static/pysradb_v3.png)

pysradb 3.0.0.dev0 documentation](index.html)

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [CLI](cmdline.html)
* [Python API](python-api-usage.html)
* [Case Studies](case_studies.html)
* [Tutorials & Notebooks](notebooks.html)
* [API Documentation](commands.html)
* Contributing
* [Credits](authors.html)
* [History](history.html)
* [pysradb](modules.html)[ ]

Back to top

[View this page](_sources/contributing.md.txt "View this page")

# Contributing[¶](#contributing "Link to this heading")

Contributions are welcome, and they are greatly appreciated! Every
little bit helps, and credit will always be given.

You can contribute in many ways:

## Types of Contributions[¶](#types-of-contributions "Link to this heading")

### Report Bugs[¶](#report-bugs "Link to this heading")

Report bugs at <https://github.com/saketkc/pysradb/issues>.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in
  troubleshooting.
* Detailed steps to reproduce the bug.

### Fix Bugs[¶](#fix-bugs "Link to this heading")

Look through the GitHub issues for bugs. Anything tagged with “bug”
and “help wanted” is open to whoever wants to implement it.

### Implement Features[¶](#implement-features "Link to this heading")

Look through the GitHub issues for features. Anything tagged with
“enhancement” and “help wanted” is open to whoever wants to
implement it.

### Write Documentation[¶](#write-documentation "Link to this heading")

pysradb could always use more documentation, whether as part of the
official pysradb docs, in docstrings, or even on the web in blog posts,
articles, and such.

### Submit Feedback[¶](#submit-feedback "Link to this heading")

The best way to send feedback is to file an issue at
<https://github.com/saketkc/pysradb/issues>.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to
  implement.
* Remember that this is a volunteer-driven project, and that
  contributions are welcome :)

## Get Started![¶](#get-started "Link to this heading")

Ready to contribute? Here’s how to set up [pysradb]{.title-ref} for
local development.

1. Fork the [pysradb]{.title-ref} repo on GitHub.
2. Clone your fork locally:

   ```
   $ git clone git@github.com:your_name_here/pysradb.git
   ```
3. Install your local copy into a virtualenv. Assuming you have
   virtualenvwrapper installed, this is how you set up your fork for
   local development (If python –version is less than 3.0, run [$
   mkvirtualenv pysradb –python=py3]{.title-ref} instead):

   ```
   $ mkvirtualenv pysradb
   $ cd pysradb/
   $ python setup.py develop
   ```
4. Create a branch for local development:

   ```
   $ git checkout -b name-of-your-bugfix-or-feature
   ```

   Now you can make your changes locally.
5. When you’re done making changes, check that your changes pass
   flake8 and the tests, including testing other Python versions with
   tox:

   ```
   $ flake8 pysradb tests
   $ python setup.py test or py.test
   $ tox
   ```

   To get flake8 and tox, just pip install them into your virtualenv.
6. Commit your changes and push your branch to GitHub:

   ```
   $ git add .
   $ git commit -m "Your detailed description of your changes."
   $ git push origin name-of-your-bugfix-or-feature
   ```
7. Submit a pull request through the GitHub website.

## Pull Request Guidelines[¶](#pull-request-guidelines "Link to this heading")

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated.
   Put your new functionality into a function with a docstring, and add
   the feature to the list in README.rst.
3. The pull request should work for Python 2.7, 3.4, 3.5 and 3.6, and
   for PyPy. Make sure that the tests pass for all supported Python
   versions.

## Tips[¶](#tips "Link to this heading")

To run a subset of tests:

```
$ py.test tests.test_pysradb
```

## Deploying[¶](#deploying "Link to this heading")

A reminder for the maintainers on how to deploy. Make sure all your
changes are committed (including an entry in HISTORY.rst). Then run:

```
$ bumpversion patch # possible: major / minor / patch
$ git push
$ git push --tags
```

CI will then deploy to PyPI if tests pass.

[Next

Credits](authors.html)
[Previous

API Documentation](commands.html)

Copyright © 2023, Saket Choudhary

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Contributing
  + [Types of Contributions](#types-of-contributions)
    - [Report Bugs](#report-bugs)
    - [Fix Bugs](#fix-bugs)
    - [Implement Features](#implement-features)
    - [Write Documentation](#write-documentation)
    - [Submit Feedback](#submit-feedback)
  + [Get Started!](#get-started)
  + [Pull Request Guidelines](#pull-request-guidelines)
  + [Tips](#tips)
  + [Deploying](#deploying)