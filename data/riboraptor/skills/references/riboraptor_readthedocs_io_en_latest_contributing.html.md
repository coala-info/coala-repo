### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](authors.html "Credits") |
* [previous](history.html "History") |
* [riboraptor 0.2.2 documentation](index.html) »

## Contents

* [Installation](installation.html)
* [Example Workflow](example_workflow.html)
* [Manual](cmd-manual.html)
* [API Usage](api-usage.html)
* [Scores](scores.html)
* [riboraptor](modules.html)
* [History](history.html)
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
* [Credits](authors.html)

#### Previous topic

[History](history.html "previous chapter")

#### Next topic

[Credits](authors.html "next chapter")

### This Page

* [Show Source](_sources/contributing.rst.txt)

1. [Docs](index.html)
2. Contributing

# Contributing[¶](#contributing "Permalink to this headline")

Contributions are welcome, and they are greatly appreciated! Every
little bit helps, and credit will always be given.

You can contribute in many ways:

## Types of Contributions[¶](#types-of-contributions "Permalink to this headline")

### Report Bugs[¶](#report-bugs "Permalink to this headline")

Report bugs at <https://github.com/saketkc/riboraptor/issues>.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.

### Fix Bugs[¶](#fix-bugs "Permalink to this headline")

Look through the GitHub issues for bugs. Anything tagged with “bug”
and “help wanted” is open to whoever wants to implement it.

### Implement Features[¶](#implement-features "Permalink to this headline")

Look through the GitHub issues for features. Anything tagged with “enhancement”
and “help wanted” is open to whoever wants to implement it.

### Write Documentation[¶](#write-documentation "Permalink to this headline")

riboraptor could always use more documentation, whether as part of the
official riboraptor docs, in docstrings, or even on the web in blog posts,
articles, and such.

### Submit Feedback[¶](#submit-feedback "Permalink to this headline")

The best way to send feedback is to file an issue at <https://github.com/saketkc/riboraptor/issues>.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions
  are welcome :)

## Get Started![¶](#get-started "Permalink to this headline")

Ready to contribute? Here’s how to set up riboraptor for local development.

1. Fork the riboraptor repo on GitHub.
2. Clone your fork locally:

   ```
   $ git clone git@github.com:your_name_here/riboraptor.git
   ```
3. Install your local copy into a virtualenv. Assuming you have virtualenvwrapper installed, this is how you set up your fork for local development:

   ```
   $ mkvirtualenv riboraptor
   $ cd riboraptor/
   $ python setup.py develop
   ```
4. Create a branch for local development:

   ```
   $ git checkout -b name-of-your-bugfix-or-feature
   ```

   Now you can make your changes locally.
5. When you’re done making changes, check that your changes pass flake8 and the tests, including testing other Python versions with tox:

   ```
   $ flake8 riboraptor tests
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

## Pull Request Guidelines[¶](#pull-request-guidelines "Permalink to this headline")

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated. Put
   your new functionality into a function with a docstring, and add the
   feature to the list in README.rst.
3. The pull request should work for Python 2.6, 2.7, 3.3, 3.4 and 3.5, and for PyPy. Check
   <https://travis-ci.org/saketkc/riboraptor/pull_requests>
   and make sure that the tests pass for all supported Python versions.

## Tips[¶](#tips "Permalink to this headline")

To run a subset of tests:

```
$ py.test tests.test_riboraptor
```

[History](history.html "previous chapter (use the left arrow)")

[Credits](authors.html "next chapter (use the right arrow)")

### Navigation

* [index](genindex.html "General Index")
* [modules](py-modindex.html "Python Module Index") |
* [next](authors.html "Credits") |
* [previous](history.html "History") |
* [riboraptor 0.2.2 documentation](index.html) »

© Copyright 2017, Saket Choudhary. Created using [Sphinx](http://sphinx.pocoo.org/).