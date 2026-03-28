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

* Update conda environment files
* [Pin/lock conda environments](#pin-lock-conda-environments)
* [Update Snakemake wrappers](update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Update conda environment files

# Update conda environment files

Snakedeploy can be used to automatically update a set of given conda environment files to the latest feasible versions of the packages they contain.
Given that the conda environments you want to update are located e.g. under `workflow/envs`, this is done by executing

```
$ snakedeploy update-conda-envs workflow/envs/*.yaml
```

Snakedeploy will

1. internally remove the version constraints of the packages given in each selected environment file,
2. determine the latest feasible combination of the versions,
3. and update the environment file with corresponding pinned versions.

For details and additional options, run

```
$ snakedeploy update-conda-envs --help
```

# Pin/lock conda environments

Snakedeploy can also pin the conda environment files to concrete package urls of not only the packages mentioned in the environment files but also all of their dependencies.
This way, next time Snakemake deploys the environments, it will not use the actual conda environment files but the pin file with the concrete package urls of all dependencies.
This is like a frozen snapshot of the environment at the time of pinning.

To pin the conda environment files, either run above command with the `--pin-envs` option:

```
$ snakedeploy update-conda-envs workflow/envs/*.yaml --pin-envs
```

Or use the `pin-conda-envs` command after updating the conda environment files:

```
$ snakedeploy pin-conda-envs workflow/envs/*.yaml
```

On this page

* [Pin/lock conda environments](#pin-lock-conda-environments)

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)