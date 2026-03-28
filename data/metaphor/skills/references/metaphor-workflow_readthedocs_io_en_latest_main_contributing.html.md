# Contributing[¶](#contributing "Link to this heading")

So you want to contribute to Metaphor? That’s great! Contributions of all scopes are welcome.

There are many ways to contribute:

## Types of Contributions[¶](#types-of-contributions "Link to this heading")

### Report Bugs[¶](#report-bugs "Link to this heading")

Report bugs at https://github.com/vinisalazar/metaphor/issues.

If you are reporting a bug, please include:

* Your operating system name and version.
* Any details about your local setup that might be helpful in troubleshooting.
* Detailed steps to reproduce the bug.
* The full error log! Please format it by wrapping it around “```” as it makes it more readable.

### Write Documentation[¶](#write-documentation "Link to this heading")

We could always use more documentation, whether as part of the official docs, in docstrings, or even as articles and use cases.

Saw a function or class in the source code without a docstring? Write it!
Take other functions as examples of how to write docstrings.

Want to write a new tutorial for a functionality of Metaphor you frequently use? Do it!

### Request a new feature[¶](#request-a-new-feature "Link to this heading")

The best way to do so is to file an issue at https://github.com/vinisalazar/metaphor/issues.

If you are proposing a feature:

* Explain in detail how it would work.
* Keep the scope as narrow as possible, to make it easier to implement.
* Remember that this is a volunteer-driven project, so don’t take it the wrong way if we take a while to respond :)
* Feeling like you could tackle writing it yourself? Go ahead!

## Get Started![¶](#get-started "Link to this heading")

Ready to contribute? Here’s how to set up Metaphor for local development.

* Fork the Metaphor repo on GitHub. (Top right)
* Clone your fork locally:

```
git clone git@github.com:your_name_here/metaphor.git
```

* Create a development environment. If you aren’t yet familiar, get to know [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html), the software used to manage our environment.

```
conda env create --file environment-dev.yaml
```

In case you’ve already created the environment and changes have been made to it, run:

```
conda activate metaphor-dev
conda env update --file environment-dev.yaml
```

* Assuming you’ve created the environment, install the package locally:

```
pip install -e .
```

This will make an “editable” version of the local installation.

* Update the repository to its latest version:

```
git pull origin main
```

* Create a branch for local development:

```
git checkout -b name-of-your-bugfix-or-feature
```

Now you can make your changes locally.

* When you’re done making changes, check that your changes pass the Snakefmt tool and linter:

```
snakefmt metaphor/workflow
snakemake --lint \
        --snakefile metaphor/workflow/Snakefile \
        --configfile metaphor/config/default-config.yaml \
        --config samples="metaphor/config/samples.csv"
```

* Commit your changes and push your branch to GitHub:

```
git add .
git commit -m "Your detailed description of your changes."
git push origin name-of-your-bugfix-or-feature
```

* Submit a pull request through the GitHub website.

## Pull Request Guidelines[¶](#pull-request-guidelines "Link to this heading")

Before you submit a pull request, if your pull request includes code changes check that it meets these guidelines:

* If the pull request adds functionality:

  + Put your new functionality into a function or class with a docstring;
  + Make a new test for said functionality.
* Add a one-line description of the contribution to the CHANGELOG.md file under the current development version.
* Make sure your code changes were formatted with the Black styling tool.

# [Metaphor](../index.html)

### Navigation

* [Tutorial](tutorial.html)
* [Output](output.html)
* [Advanced](advanced.html)
* [Configuration](configuration.html)
* [Troubleshooting](troubleshooting.html)
* Contributing
  + [Types of Contributions](#types-of-contributions)
  + [Get Started!](#get-started)
  + [Pull Request Guidelines](#pull-request-guidelines)
* [Reference](reference.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Troubleshooting](troubleshooting.html "previous chapter")
  + Next: [Reference](reference.html "next chapter")

### Quick search

© The University of Melbourne 2023 — This documentation is public domain under a CC0 license.
|
Powered by [Sphinx 7.4.7](https://www.sphinx-doc.org/)
& [Alabaster 0.7.16](https://alabaster.readthedocs.io)
|
[Page source](../_sources/main/contributing.md.txt)