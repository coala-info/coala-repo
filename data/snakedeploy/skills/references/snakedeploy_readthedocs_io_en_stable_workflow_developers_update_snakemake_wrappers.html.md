[Skip to content](#content)

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)
[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Toggle navigation menu

`⌘
K`

[![Logo](../_static/logo-snake.svg)
![Logo](../_static/logo-snake.svg)Snakedeploy documentation](../index.html)

[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Getting started

* [Installation](../getting_started/installation.html)

Workflow users

* [Deploy workflows](../workflow_users/workflow_deployment.html)
* [Register input data](../workflow_users/input_registration.html)

Workflow developers

* [Update conda environment files](update_conda_envs.html)
* [Pin/lock conda environments](update_conda_envs.html#pin-lock-conda-environments)
* Update Snakemake wrappers

Snakemake developers

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Update Snakemake wrappers

# Update Snakemake wrappers

Snakedeploy can be used to automatically update the versions of Snakemake wrappers in a workflow.
Given that your workflow snakefiles are located e.g. under `workflow/Snakefile` (main entrypoint) and `workflow/rules/`, this is done by executing

```
$ snakedeploy update-snakemake-wrappers workflow/Snakefile workflow/rules/*.smk
```

Snakedeploy will then

1. detemine the latest Snakemake wrapper release version,
2. find all rules in the given snakefiles that use a Snakemake wrapper,
3. set the wrapper release version in each of those rules to that latest version.

For details and additional options, run

```
$ snakedeploy update-snakemake-wrappers --help
```

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)