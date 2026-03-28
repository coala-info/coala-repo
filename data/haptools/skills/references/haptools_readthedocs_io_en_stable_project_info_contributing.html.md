[haptools](../index.html)

Overview

* [Installation](installation.html)
* [Example files](example_files.html)
* Contributing
  + [Types of Contributions](#types-of-contributions)
    - [Report a bug](#report-a-bug)
    - [Fix a bug](#fix-a-bug)
    - [Implement a new feature](#implement-a-new-feature)
  + [How to fix a bug or implement a new feature](#how-to-fix-a-bug-or-implement-a-new-feature)
  + [Dev Setup](#dev-setup)
  + [Managing Dependencies](#managing-dependencies)
  + [Modifying our command line interface (CLI)](#modifying-our-command-line-interface-cli)
    - [Add or modify a command-line option](#add-or-modify-a-command-line-option)
    - [Add a new command](#add-a-new-command)
    - [Documentating our CLI](#documentating-our-cli)
      * [For command-line option changes](#for-command-line-option-changes)
      * [For new commands](#for-new-commands)
  + [Modifying the `.hap` format](#modifying-the-hap-format)
  + [Code Checks](#code-checks)
  + [Publish a new version](#publish-a-new-version)
  + [Style](#style)
    - [Code](#code)
    - [Errors](#errors)
    - [Git commit messages](#git-commit-messages)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Contributing
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/project_info/contributing.rst)

---

# Contributing[](#contributing "Link to this heading")

Contributions are welcome and greatly appreciated!

## Types of Contributions[](#types-of-contributions "Link to this heading")

### Report a bug[](#report-a-bug "Link to this heading")

If you have found a bug, please report it on [our issues page](https://github.com/CAST-genomics/haptools/issues) rather than emailing us directly. Others may have the same issue and this helps us get that information to them.

Before you submit a bug, please search through our issues to ensure it hasn’t already been reported. If you encounter an issue that has already been reported, please upvote it by reacting with a thumbs-up emoji. This helps us prioritize the issue.

The most helpful Github issues include
:   * the version of haptools you are using, although it’s best to use the latest version
    * detailed steps to help us reproduce your error, ideally with the example datasets in the `tests/data` directory

### Fix a bug[](#fix-a-bug "Link to this heading")

Look through our issues page for bugs. We especially need help with bugs labeled “help wanted”. If you want to start working on a bug then please write a message within the thread for that issue on our issues page, so that no one is duplicating work.

Please add a test reproducing the bug in our [tests/ directory](https://github.com/CAST-genomics/haptools/tree/main/tests).

### Implement a new feature[](#implement-a-new-feature "Link to this heading")

Our issues page will almost always have features on our wishlist. Once again, if you want to start working on a feature then please write a message within the thread for that feature on our issues page, so that no one is duplicating work.

Have an idea for a new feature that isn’t on our wishlist? We’d love to hear about it! Before getting to work, please create a Github issue for it, so that you can make sure we’re in agreement about what it should do. After you finish the feature, please add tests and documentation for it, as well.

## How to fix a bug or implement a new feature[](#how-to-fix-a-bug-or-implement-a-new-feature "Link to this heading")

Please create a pull request! A PR is a collection of changes that you have made to the code that we can review and potentially integrate into haptools.

To create a pull request you need to do these steps:
:   1. Create a Github account
    2. [Fork the repository](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository)
       :   * Click the “Fork” button in the top, right corner
           * Or, if you had already forked the repository a while ago, [sync your fork](https://docs.github.com/en/github/collaborating-with-pull-requests/working-with-forks/syncing-a-fork) to make sure you’re working with the latest version of haptools
    3. [Clone your fork locally](https://docs.github.com/en/get-started/quickstart/fork-a-repo#cloning-your-forked-repository)
    4. `cd haptools` into the new directory
    5. Create a new branch off of the `main` branch with `git checkout -b <descriptive_branch_name>`. Please follow [best practices](https://www.conventionalcommits.org/) when naming your branch
    6. Setup our development environment by following the instructions in [Dev Setup](#dev-setup-instructions) below
    7. Make your changes to the code
    8. Add additional tests to the `tests/` directory and add comments to the documentation to explain how to use your new code. We use pytest for testing and sphinx/numpydoc for documentation. If you add example code or an example command to the documentation, you should make sure to create an automated test that executes it, as well.
    9. Run the automated code-checking steps detailed in [Code Checks](#code-check-instructions) below
    10. Commit your changes. Please use informative commit messages and do your best to ensure the commit history is clean and easy to interpret
    11. Now you can push your changes to your Github copy of haptools by running `git push origin <descriptive_branch_name>`
    12. Go to your Github copy of haptools in your browser and create a pull request titled according to the [conventional commits spec](https://www.conventionalcommits.org/). Be sure to change the pull request target branch to `main` on this original repository.
    13. Please write an informative pull request detailing the changes you have made and why you made them. Tag any related issues by referring to them by a hashtag followed by their ID

## Dev Setup[](#dev-setup "Link to this heading")

Follow these steps to set up a development environment.

1. Create a conda environment with `poetry`

   > ```
   > conda env create -n haptools -f dev-env.yml
   > ```
2. Install haptools and its dependencies into a separate environment managed by `poetry`

   > ```
   > conda run -n haptools poetry install
   > ```
3. Now, whenever you’d like to run/import `haptools` or `pytest`, you will first need to activate both environments

   > ```
   > conda activate haptools
   > poetry shell
   > ```

## Managing Dependencies[](#managing-dependencies "Link to this heading")

Run `poetry help` to read about the suite of commands it offers for managing dependencies.

For example, to add a pypi dependency to our list and install it, just run

> ```
> poetry add <dependency>
> ```

You should specify a [version constraint](https://python-poetry.org/docs/master/dependency-specification) when adding a dependency. Use the oldest version compatible with your code. Don’t worry if you’re not sure at first – you can (and should!) always update it later. For example, to specify a version of `click` >= 8.0.4:

> ```
> poetry add 'click>=8.0.4'
> ```

Afterward, double-check that the `pyproject.toml` file has been changed appropriately. Our minimum version constraints should be listed in the `[project.dependencies]` section and the locked versions should appear in the `[tool.poetry.dependencies]` section.
Ideally, the `[tool.poetry.dependencies]` section should contain at least 1) the minimum supported version and 2) the latest version of each dependency.
After making any changes to the `pyproject.toml` file, you must run the `poetry lock` command to sync it with the `poetry.lock` file.

We try to keep the oldest version of python that is not [end-of-life](https://devguide.python.org/versions) in our development environment (`dev-env.yml` file), so that developers do not inadvertently make any changes that break support for that version of python.
If, at any time, the minimum supported version of a dependency does not work with the version of python in our development environment, then you should also add the minimum working version of that dependency to our locked versions in the `[tool.poetry.dependencies]` section. See [this discussion thread](https://github.com/orgs/python-poetry/discussions/10142#discussioncomment-12050625) for an example.

Only PyPI packages can be added to our `pyproject.toml` file.
So if a dependency is only available on conda, then you can add it to our `dev-env.yml` file instead.
Please note that anyone who installs TRTools from PyPI will not be guaranteed to have your dependency installed, so you should design your code accordingly.

Please note that any changes to our dependencies must also added to our bioconda recipe at the time of publication.

## Modifying our command line interface (CLI)[](#modifying-our-command-line-interface-cli "Link to this heading")

We use the [click library](https://click.palletsprojects.com/) to define `haptools`’s command line interface as [nested commands](https://click.palletsprojects.com/quickstart/#nesting-commands). All of the CLI logic is defined in [\_\_main\_\_.py](https://github.com/CAST-genomics/haptools/blob/main/haptools/__main__.py).

### Add or modify a command-line option[](#add-or-modify-a-command-line-option "Link to this heading")

First, locate the definition of the command in [\_\_main\_\_.py](https://github.com/CAST-genomics/haptools/blob/main/haptools/__main__.py)

You can add a `@click.option` or `@click.argument` line if you want to add a new option or argument. Please follow [click’s convention](https://click.palletsprojects.com/parameters/#parameters) and only use `@click.argument` for required arguments and `@click.option` for optional ones. See [the click documentation](https://click.palletsprojects.com/#documentation) for directions on modifying or adding parameters like options/arguments.

Please note that any modifications to our CLI represent a BREAKING change to haptools. To note this, please add an exclamation point `!` to your pull request prefix as described in the [conventional commits spec](https://www.conventionalcommits.org/).

### Add a new command[](#add-a-new-command "Link to this heading")

To add a new command, you only have to define a new function in [\_\_main\_\_.py](https://github.com/CAST-genomics/haptools/blob/main/haptools/__main__.py). Within that function, you can import and call the rest of your code. For example, to add a command called `mycommand` which takes a single required file called `arg1`, you might do the following.

```
@main.command(short_help="A short description of my command")
@click.argument("arg1", type=click.Path(exists=True, path_type=Path))
@click.option(
    "-o",
    "--output",
    type=click.Path(path_type=Path),
    default=Path("/dev/stdout"),
    show_default="stdout",
    help="The output of my command",
)
@click.option(
    "-v",
    "--verbosity",
    type=click.Choice(["CRITICAL", "ERROR", "WARNING", "INFO", "DEBUG", "NOTSET"]),
    default="INFO",
    show_default=True,
    help="The level of verbosity desired",
)
def mycommand(
    arg1: Path,
    output: Path = None,
    verbosity: str = "INFO",
):
    """
    A longer description of mycommand
    """

    from .mycommand import run_things
    from .logging import getLogger

    log = getLogger(name="mycommand", level=verbosity)

    run_things(arg1, output, log)
```

Notice that we usually define a logging object here to use throughout our code. For more information about logging, see the [section about it below](#contributing-style-errors). All `haptools` commands should use a default verbosity of `INFO`.

### Documentating our CLI[](#documentating-our-cli "Link to this heading")

#### For command-line option changes[](#for-command-line-option-changes "Link to this heading")

Any new or modified command-line options will be automatically documented via **click**. The changes should appear in the *Detailed Usage* section of the documentation for the command that you changed.

In addition to the auto-documented changes, you might want to consider adding a new example of the usage of your option to the *Examples* section of the documentation for the command that you changed. All examples in our documentation should also be executed within a file in our [tests/ directory](https://github.com/CAST-genomics/haptools/tree/main/tests).

#### For new commands[](#for-new-commands "Link to this heading")

After you add a new command, you should make sure to create tests for it in the [tests/ directory](https://github.com/CAST-genomics/haptools/tree/main/tests). You should also create a new page in the *Commands* section of our documentation with sections for a short description, an abbreviated usage, example commands, and a detailed usage (which is auto-generated). You can refer to [the index command](../commands/index.html#commands-index) as an example. To ensure your new documentation page appears in our table of contents, add the name of the page to the list at the bottom of our [index.rst file](https://github.com/CAST-genomics/haptools/blob/main/docs/index.rst).

## Modifying the `.hap` format[](#modifying-the-hap-format "Link to this heading")

If you modify the [.hap file format](../formats/haplotypes.html), you should bump the version number, which is listed at the top of the [haptools/data/haplotypes.py](https://github.com/CAST-genomics/haptools/blob/main/haptools/data/haplotypes.py) module and follows [semantic versioning](https://semver.org/).

Please describe any modifications or new features in [the .hap docs](../formats/haplotypes.html) and in the [Changelog at the bottom of that page](../formats/haplotypes.html#formats-haplotypes-changelog).

After bumping the version number, you should also update all `.hap` and `.hap.gz` files in the [tests/data/ directory](https://github.com/CAST-genomics/haptools/tree/main/tests/data) to use the new version number.

## Code Checks[](#code-checks "Link to this heading")

Before creating your pull request, please run each of our code checks.

1. Format the code correctly

   > ```
   > black .
   > ```
2. If you made changes to the docs, check that they appear correctly.

   > ```
   > sphinx-build docs docs/_build
   > open docs/_build/index.html