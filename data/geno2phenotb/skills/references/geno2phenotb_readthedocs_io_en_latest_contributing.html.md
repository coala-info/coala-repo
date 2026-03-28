latest

* [Overview](readme.html)
* [Installation](installation.html)
* [Command Line Interface](cli.html)
* [Python Interface](api/modules.html)
* Contributing & Help
  + [Issue Reports](#issue-reports)
  + [Code and Documentation Contributions](#code-and-documentation-contributions)
    - [Submit an issue](#submit-an-issue)
    - [Clone and set up the repository](#clone-and-set-up-the-repository)
    - [Documentation Improvements](#documentation-improvements)
    - [Code Contributions](#code-contributions)
    - [Isolated build testing](#isolated-build-testing)
    - [Submit your contribution](#submit-your-contribution)
* [Acknowledgments](acknowledgments.html)
* [Authors](authors.html)
* [Release Notes](changelog.html)
* [License](license.html)
* [References](references.html)

[geno2phenoTB](index.html)

* Contributing
* [Edit on GitHub](https://github.com/msmdev/geno2phenoTB/blob/main/docs/contributing.rst)

---

# Contributing[](#contributing "Permalink to this heading")

Welcome to `geno2phenoTB` contributor’s guide.

This document focuses on getting any potential contributor familiarized
with the development processes, but [other kinds of contributions](https://opensource.guide/how-to-contribute) are also
appreciated.

If you are new to using [git](https://git-scm.com) or have never collaborated in a project previously,
please have a look at [contribution-guide.org](https://www.contribution-guide.org/). Other resources are also
listed in the excellent [guide by FreeCodeCamp](https://github.com/FreeCodeCamp/how-to-contribute-to-open-source).

Please notice, all users and contributors are expected to be **open,
considerate, reasonable, and respectful**. When in doubt, [Python Software
Foundation’s Code of Conduct](https://www.python.org/psf/conduct/) is a good reference in terms of behavior
guidelines.

## Issue Reports[](#issue-reports "Permalink to this heading")

If you experience bugs or general issues with `geno2phenoTB`, please have a look
on the [issue tracker](https://github.com/msmdev/geno2phenoTB/issues). If you don’t see anything useful there, please feel
free to fire an issue report.

> Tip
>
> Please don’t forget to include the closed issues in your search.
> Sometimes a solution was already reported, and the problem is considered
> **solved**.

New issue reports should include information about your programming environment
(e.g., operating system, Python version) and steps to reproduce the problem.
Please try also to simplify the reproduction steps to a very minimal example
that still illustrates the problem you are facing. By removing other factors,
you help us to identify the root cause of the issue.

## Code and Documentation Contributions[](#code-and-documentation-contributions "Permalink to this heading")

### Submit an issue[](#submit-an-issue "Permalink to this heading")

Before you work on any non-trivial code contribution it’s best to first create
a report in the [issue tracker](https://github.com/msmdev/geno2phenoTB/issues) to start a discussion on the subject.
This often provides additional considerations and avoids unnecessary work.

### Clone and set up the repository[](#clone-and-set-up-the-repository "Permalink to this heading")

1. Create an user account on GitHub if you do not already have one.
2. Fork the project [repository](https://github.com/msmdev/geno2phenoTB): click on the *Fork* button near the top of the
   page. This creates a copy of the code under your account on GitHub.
3. Clone this copy to your local disk:

   ```
   git clone git@github.com:YourLogin/geno2phenoTB.git
   cd geno2phenoTB
   ```
4. Create an isolated conda environment with the required dependencies to avoid any problems with
   your installed Python packages:

   ```
   conda env create -f tests/g2p-test.yaml
   conda rename -n g2p-test g2p-dev
   conda activate g2p-dev
   ```
5. Next, run:

   ```
   pip install -U pip setuptools -e ".[dev]"
   ```

   to install further packages required for development and to enable importing the package under development in the Python REPL.
6. Install [`pre-commit`](https://pre-commit.com/):

   ```
   pre-commit install
   ```

   `geno2phenoTB` comes with a lot of hooks configured to help the
   developer to check the code being written automatically.

### Documentation Improvements[](#documentation-improvements "Permalink to this heading")

You can help to improve the `geno2phenoTB` docs by making them more readable and coherent, or
by adding missing information and correcting mistakes.

The `geno2phenoTB` documentation uses [Sphinx](https://www.sphinx-doc.org/en/master/) as its main documentation compiler.
This means that the docs are kept in the same repository as the project code, and
that any documentation update is done in the same way was a code contribution.

[reStructuredText](https://www.sphinx-doc.org/en/master/usage/restructuredtext/) is used.

> Tip
>
> Please notice that the [GitHub web interface](https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files) provides a quick way of
> propose changes in `geno2phenoTB`’s files. While this mechanism can
> be tricky for normal code contributions, it works perfectly fine for
> contributing to the docs, and can be quite handy.
>
> If you are interested in trying this method out, please navigate to the
> `docs` folder in the source [repository](https://github.com/msmdev/geno2phenoTB), select the file for which you
> would like to propose changes, and click in the little pencil icon at the
> top, to open [GitHub’s code editor](https://docs.github.com/en/repositories/working-with-files/managing-files/editing-files). Once you finished editing the file,
> please write a message in the description field at the bottom of the page
> describing the changes you made and the motivations behind them
> and submit your proposal.

When working on documentation changes in your local machine, you can
compile them using:

```
cd docs
make html
```

while being in the docs directory.
Use Python’s built-in web server for a preview in your web browser (`http://localhost:8000`):

```
python3 -m http.server --directory 'docs/_build/html'
```

When you’re done editing, do:

```
git add <MODIFIED FILES>
git commit
```

to record your changes in [git](https://git-scm.com).

Please make sure to see the validation messages from [`pre-commit`](https://pre-commit.com/) and fix
any potential issues.

### Code Contributions[](#code-contributions "Permalink to this heading")

1. Create a branch to hold your changes:

   ```
   git checkout -b my-feature-name
   ```

   and start making changes. **Never work on the main branch!**
2. Start your work on this branch. Don’t forget to add [docstrings](https://www.sphinx-doc.org/en/master/usage/extensions/napoleon.html) to new
   functions, modules, and classes, especially if they are part of public APIs.

   > Important
   >
   > Don’t forget to add unit tests and documentation in case your
   > contribution adds an additional feature and is not simply a bugfix.
3. Add yourself to the list of contributors in `AUTHORS.rst`.
4. While developing, you should regularly check that your changes don’t break unit tests with:

   ```
   pytest .
   ```
5. Finally, check that your changes pass all unit and self tests with:

   ```
   geno2phenotb test -f # fast test
   geno2phenotb test -c # complete test
   ```
6. When you’re done editing, do:

   ```
   git add <MODIFIED FILES>
   git commit
   ```

   to record your changes in [git](https://git-scm.com).

   Please make sure to inspect the validation messages from [`pre-commit`](https://pre-commit.com/) and fix
   any eventual issues.

   Moreover, writing a [descriptive commit message](https://cbea.ms/git-commit/) is highly recommended.
   In case of doubt, you can check the commit history with:

   ```
   git log --graph --decorate --pretty=oneline --abbrev-commit --all
   ```

   to look for recurring communication patterns.

### Isolated build testing[](#isolated-build-testing "Permalink to this heading")

In order to test that everything works in an isolated build, this project uses [act](https://github.com/nektos/act) to run
GitHub Actions locally.

Download and install Act from here: <https://github.com/nektos/act> and run:

```
act --artifact-server-path ./build/
```

The first run takes a while, since a clean docker container has to be be downloaded (~12GB).

### Submit your contribution[](#submit-your-contribution "Permalink to this heading")

1. If everything works fine, push your local branch to GitHub with:

   ```
   git push -u origin my-feature-name
   ```
2. Go to the web page of your fork and click “Create pull request”
   to submit your changes for review.

[Previous](api/geno2phenotb.html "geno2phenotb package")
[Next](acknowledgments.html "Acknowledgments")

---

© Copyright 2023, Bernhard Reuter, Jules Kreuer.
Revision `d0de6e0a`.