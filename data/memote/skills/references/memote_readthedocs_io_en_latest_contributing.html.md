[![](_static/memote-logo.png)](index.html)
**0.11.1**

* [Site](index.html)

  - [Installation](installation.html)
  - [Getting Started](getting_started.html)
  - [Flowchart](flowchart.html)
  - [Understanding the reports](understanding_reports.html)
  - [Experimental Data](experimental_data.html)
  - [Custom Tests](custom_tests.html)
  - [Test Suite](test_suite.html)
  - Contributing
  - [Credits](authors.html)
  - [History](history.html)
  - [API Reference](autoapi/index.html)
* Page

  - Contributing
    * [Report Bugs](#report-bugs)
    * [Fix Bugs](#fix-bugs)
    * [Implement Features](#implement-features)
    * [Write Documentation](#write-documentation)
    * [Submit Feedback](#submit-feedback)
    * [Get Started!](#get-started)
    * [Pull Request Guidelines](#pull-request-guidelines)
* [« Experimental Tests](experimental.html "Previous Chapter: Experimental Tests")
* [Credits »](authors.html "Next Chapter: Credits")
* [Source](_sources/contributing.rst.txt)

# Contributing[¶](#contributing "Permalink to this headline")

Contributions are welcome, and they are greatly appreciated! Every
little bit helps, and credit will always be given.

You can contribute in many ways:

## Report Bugs[¶](#report-bugs "Permalink to this headline")

Report bugs at <https://github.com/opencobra/memote/issues>.

If you are reporting a bug, please follow the template guidelines. The more
detailed your report, the easier and thus faster we can help you.

## Fix Bugs[¶](#fix-bugs "Permalink to this headline")

Look through the GitHub issues for bugs. Anything tagged with “bug”
and “help wanted” is open to whoever wants to implement it.

## Implement Features[¶](#implement-features "Permalink to this headline")

Look through the GitHub issues for features. Anything tagged with “enhancement”
and “help wanted” is open to whoever wants to implement it.

## Write Documentation[¶](#write-documentation "Permalink to this headline")

memote could always use more documentation, whether as part of the
official documentation, in docstrings, or even on the web in blog posts,
articles, and such.

## Submit Feedback[¶](#submit-feedback "Permalink to this headline")

The best way to send feedback is to file an issue at
<https://github.com/opencobra/memote/issues>.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, and that contributions
  are welcome :)

## Get Started![¶](#get-started "Permalink to this headline")

Ready to contribute? Here’s how to set up memote for
local development.

1. Fork the <https://github.com/opencobra/memote>
   repository on GitHub.
2. Clone your fork locally

   ```
   git clone git@github.com:your_name_here/memote.git
   ```
3. Install your local copy into a a Python virtual environment.
   You can [read this guide to learn more](https://realpython.com/python-virtual-environments-a-primer/)
   about them and how to create one. Alternatively, particularly if you are a
   Windows or Mac user, you can also use
   [Anaconda](https://docs.anaconda.com/anaconda/). Assuming you have
   virtualenvwrapper installed, this is how you set up your fork for local development

   ```
   mkvirtualenv my-env
   cd memote/
   pip install -e .[development]
   ```
4. Create a branch for local development using the `devel` branch as a
   starting point. Use `fix` or `feat` as a prefix

   ```
   git checkout devel
   git checkout -b fix-name-of-your-bugfix
   ```

   Now you can make your changes locally.
5. When you’re done making changes, apply the quality assurance tools and check
   that your changes pass our test suite. This is all included with tox

   ```
   make qa
   tox
   ```
6. Commit your changes and push your branch to GitHub. Please use [semantic
   commit messages](http://karma-runner.github.io/2.0/dev/git-commit-msg.html).

   ```
   git add .
   git commit -m "fix: Your summary of changes"
   git push origin fix-name-of-your-bugfix
   ```
7. Open the link displayed in the message when pushing your new branch
   in order to submit a pull request.

## Pull Request Guidelines[¶](#pull-request-guidelines "Permalink to this headline")

Before you submit a pull request, check that it meets these guidelines:

1. The pull request should include tests.
2. If the pull request adds functionality, the docs should be updated. Put
   your new functionality into a function with a docstring.

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.