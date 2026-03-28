1. [Contributing to `pyANI-plus`](./contributing.html)

[pyANI-plus](./)

* [About pyANI-plus](./index.html)
* [Requirements](./requirements.html)
* [Installation](./installation.html)
* [pyANI-plus walkthrough](./walkthrough.html)
* [pyANI-plus subcommands](./subcommands/subcommands.html)

  + [1  `anib`](./subcommands/anib.html)
  + [2  `anim`](./subcommands/anim.html)
  + [3  `dnadiff`](./subcommands/dnadiff.html)
  + [4  `external-alignment`](./subcommands/external_alignment.html)
  + [5  `fastani`](./subcommands/fastani.html)
  + [6  `sourmash`](./subcommands/sourmash.html)
  + [7  `plot-run`](./subcommands/plot_run.html)
  + [8  `plot-run-comp`](./subcommands/plot_run_comp.html)
  + [9  `list-runs`](./subcommands/list_runs.html)
  + [10  `export-run`](./subcommands/export_run.html)
  + [11  `resume`](./subcommands/resume.html)
  + [12  `delete-run`](./subcommands/delete_run.html)
  + [13  `classify`](./subcommands/classify.html)
* [Cluster](./cluster.html)
* [Contributing to `pyANI-plus`](./contributing.html)
* [Testing](./testing.html)
* [Licensing](./licensing.html)

  + [14  pyANI-plus](./pyani_licence.html)
  + [15  pyANI-plus documentation](./doc_licence.html)

## Table of contents

* [Reporting bugs and errors](#reporting-bugs-and-errors)
* [Contributing code or documentation](#contributing-code-or-documentation)
  + [Making changes and pull requests](#making-changes-and-pull-requests)
* [Suggestions for improvement](#suggestions-for-improvement)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/contributing.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

# Contributing to `pyANI-plus`

## Reporting bugs and errors

If you find a bug, or an error in the code or documentation, please report this by raising an issue at the [GitHub issue page](https://github.com/pyani-plus/pyani-plus/issues) for `pyANI-plus`.

## Contributing code or documentation

We welcome contributions of all kinds! Check out the GitHub contributors link for a list of those who have helped shape the project.

Whether you’d like to develop `pyANI-plus`, fix a bug, or improve documentation, your help is appreciated! To help maintain an efficient workflow, please adhere to the developer guidelines below:

### Making changes and pull requests

1. Fork the `pyANI-plus` [repository](https://github.com/pyani-plus/pyani-plus) under your [GitHub](https://github.com/) account.
2. Clone the forked repository to your local development machine.

   * To edit `pyANI-plus` and see changes take effect immediately (without reinstalling), run:

     ```
     pip install -e .
     ```

     inside the cloned repository. This is useful for testing.
3. Create a new branch in your forked repository with an informative name such as `fix_issue_107`, by running:

   ```
   git checkout -b fix_issue_107
   ```
4. Make the changes you need and commit them to your local branch.
5. Run the `pytests` in the respoitory to ensure your changes work and do not intriduce any bugs or errors (see the [testing documentation](./testing.html#testing))
6. If the tests all pass, push the changes to your fork, and submit a pull request against the original repository.
7. Indicate one of the `pyANI-plus` developers as an assignee in your pull request. A developer will review your pull request and either merge it or provide feedback for further improvements.

## Suggestions for improvement

We appreciate your feedback on `pyANI-plus`. If you have a specific issue or proposal, please submit it through [GitHub Issues](https://github.com/pyani-plus/pyani-plus/issues). To discuss ideas with the maintainers and community, join the conversation on [GitHub Discussions](https://github.com/pyani-plus/pyani-plus/discussions/landing).

[Cluster](./cluster.html)

[Testing](./testing.html)

pyANI-plus documentation

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/contributing.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

This book was built with [Quarto](https://quarto.org/).