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

* [Update conda environment files](../workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](../workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](../workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* Scaffold Snakemake Plugins

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Scaffold Snakemake Plugins

# Scaffold Snakemake Plugins

Snakedeploy can be used to scaffold the code needed to write Snakemake plugins.
It utilizes [pixi](https://pixi.sh) for this purpose, hence you need to have it installed first.
Assuming you want to create a new Snakemake `executor` plugin with the name `something`.
First, create a corresponding pixi project with

```
$ pixi init --format pyproject snakemake-executor-plugin-something
```

thereby following the mandatory naming convention for Snakemake plugins, i.e. `snakemake-<plugin_type>-plugin-<name>`.
Enter the created directory with

```
$ cd snakemake-executor-plugin-something
```

Then, you can scaffold the plugin code with Snakedeploy via

```
$ snakedeploy scaffold-snakemake-plugin executor
```

instead of `executor`, any of the following is possible:

* `executor` - to scaffold a Snakemake executor plugin,
* `storage` - to scaffold a Snakemake storage plugin,
* `report` - to scaffold a Snakemake report plugin,
* `scheduler` - to scaffold a Snakemake scheduler plugin.

Snakedeploy will create a [pixi](https://pixi.sh) project with state-of-the-art skeleton code for the requested plugin type, including all required class implementations, test cases and even github actions for continous testing.

For details and additional options, run

```
$ snakedeploy scaffold-snakemake-plugin --help
```

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)