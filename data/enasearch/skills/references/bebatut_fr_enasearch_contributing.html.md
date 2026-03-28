[ENASearch](index.html)

0.2.0

ENASearch documentation

* [Installation](installation.html)
* [Some example of usage](use_case.html)
* [Interacting with ENA Database](ena.html)
* [Usage with command-line](cli_usage.html)
* [Usage within Python](api_usage.html)
* Contributing
  + [What should I know before I get started?](#what-should-i-know-before-i-get-started)
  + [How can I contribute?](#how-can-i-contribute)
    - [Reporting mistakes or errors](#reporting-mistakes-or-errors)
    - [Your first content contribution](#your-first-content-contribution)
  + [Tests](#tests)
  + [Documentation](#documentation)
  + [Update the data](#update-the-data)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

[ENASearch](index.html)

* [Docs](index.html) »
* Contributing

---

# Contributing[¶](#contributing "Permalink to this headline")

First off, thanks for taking the time to contribute!

## What should I know before I get started?[¶](#what-should-i-know-before-i-get-started "Permalink to this headline")

This project is there to offer a Python library for interacting with [ENA](http://www.ebi.ac.uk/ena/browse/programmatic-access)‘s API.

The project is developed on GitHub at <https://github.com/bebatut/enasearch>.

## How can I contribute?[¶](#how-can-i-contribute "Permalink to this headline")

### Reporting mistakes or errors[¶](#reporting-mistakes-or-errors "Permalink to this headline")

The easiest way to start contributing is to file an issue to tell us about a spelling mistake or a factual error.

### Your first content contribution[¶](#your-first-content-contribution "Permalink to this headline")

Once you are feeling more comfortable, you can propose changes via Pull Request.

Indeed, to manage changes, we use [GitHub flow](https://guides.github.com/introduction/flow/) based on Pull Requests:

1. [Create a fork](https://help.github.com/articles/fork-a-repo/) of this repository on GitHub
2. Clone your fork of this repository to create a local copy on your computer
3. Create a new branch in your local copy for each significant change
4. Commit the changes in that branch
5. Push that branch to your fork on GitHub
6. Submit a pull request from that branch to the [master repository](https://github.com/bebatut/enasearch)
7. If you receive feedback, make changes in your local clone and push them to your branch on GitHub: the pull request will update automatically

For beginners, the GitHub interface will help you in the process of editing a file. It will automatically create a fork of this repository where you can safely work and then submit the changes as a pull request without having to touch the command line.

## Tests[¶](#tests "Permalink to this headline")

The code of ENASearch is covered by tests. They are run automatically on Travis. You can [activate Travis on your fork](https://docs.travis-ci.com/user/getting-started/#To-get-started-with-Travis-CI) to run also the tests automatically.

We also recommend to run them locally before pushing to GitHub with:

```
$ make test
```

## Documentation[¶](#documentation "Permalink to this headline")

Documentation about ENASearch is available online at <http://bebatut.fr/enasearch>

To update it:

1. Make the changes in src/docs
2. Generate the doc with

> ```
> $ make doc
> ```

3. Check it by opening the docs/index.html file in a web browser
4. Propose the changes via a Pull Request

## Update the data[¶](#update-the-data "Permalink to this headline")

The fields and their description, the formats, etc were extracted manually and stored in CSV files in enasearch\_data. They were then serialized to be quickly imported in enasearch script.

To update them:

1. Extract the information from tables on ENA website

   > For example for the display\_options has been extracted from [“Display options” on “REST URLs for data retrieval” page](http://www.ebi.ac.uk/ena/browse/data-retrieval-rest#display_options)
2. Format the table into a CSV file
3. Update the corresponding file in enasearch\_data directory
4. Serialize the data with

   > ```
   > $ make data
   > ```
5. Commit the changes

[Previous](api_usage.html "Usage within Python")

---

© Copyright 2017, Bérénice Batut.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).