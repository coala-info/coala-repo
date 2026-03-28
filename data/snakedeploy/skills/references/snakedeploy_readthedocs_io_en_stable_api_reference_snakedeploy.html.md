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

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* The Snakedeploy API
* [Internal API](internal/modules.html)

[Snakedeploy documentation](../index.html)

/

The Snakedeploy API

# The Snakedeploy API

These sections detail the internal functions for Snakedeploy.

## snakedeploy.deploy module

snakedeploy.deploy.deploy(*source\_url: str*, *name: str | None*, *tag: str | None*, *branch: str | None*, *dest\_path: Path*, *force=False*)[[source]](../_modules/snakedeploy/deploy.html#deploy)
:   Deploy a given workflow to the local machine, using the Snakemake module system.

    ### Example

    Given that you want to deploy a workflow to the path /tmp/dest:

    ```
    from snakedeploy.deploy import deploy
    deploy(
        "https://github.com/snakemake-workflows/dna-seq-varlociraptor",
        dest_path="/tmp/dest",
        name="dna_seq",
        tag="v1.0.0",
        force=True
    )
    ```

## snakedeploy.collect\_files module

*class* snakedeploy.collect\_files.Match(*rule*, *match*)
:   match
    :   Alias for field number 1

    rule
    :   Alias for field number 0

snakedeploy.collect\_files.collect\_files(*config\_sheet\_path: str*)[[source]](../_modules/snakedeploy/collect_files.html#collect_files)
:   Given a configuration sheet path with input patterns, print matches
    of samples to STDOUT

On this page

* [snakedeploy.deploy module](#module-snakedeploy.deploy)
  + [`deploy()`](#snakedeploy.deploy.deploy)
* [snakedeploy.collect\_files module](#snakedeploy-collect-files-module)
  + [`Match`](#snakedeploy.collect_files.Match)
    - [`Match.match`](#snakedeploy.collect_files.Match.match)
    - [`Match.rule`](#snakedeploy.collect_files.Match.rule)
  + [`collect_files()`](#snakedeploy.collect_files.collect_files)

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)