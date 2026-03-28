[Skip to content](#content)

![Logo](_static/logo-snake.svg)
![Logo](_static/logo-snake.svg)Snakedeploy documentation
[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Toggle navigation menu

`⌘
K`

![Logo](_static/logo-snake.svg)
![Logo](_static/logo-snake.svg)Snakedeploy documentation

[Snakemake Homepage](https://snakemake.github.io)
[Snakemake Documentation](https://snakemake.readthedocs.io)

Getting started

* [Installation](getting_started/installation.html)

Workflow users

* [Deploy workflows](workflow_users/workflow_deployment.html)
* [Register input data](workflow_users/input_registration.html)

Workflow developers

* [Update conda environment files](workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](api_reference/snakedeploy.html)
* [Internal API](api_reference/internal/modules.html)

# Snakedeploy

[![https://img.shields.io/conda/dn/bioconda/snakedeploy.svg?label=Bioconda&color=%23064e3b](https://img.shields.io/conda/dn/bioconda/snakedeploy.svg?label=Bioconda&color=%23064e3b)](https://bioconda.github.io/recipes/snakedeploy/README.html)
[![https://img.shields.io/pypi/pyversions/snakedeploy.svg?color=%23065f46](https://img.shields.io/pypi/pyversions/snakedeploy.svg?color=%23065f46)](https://www.python.org)
[![https://img.shields.io/pypi/v/snakedeploy.svg?color=%23047857](https://img.shields.io/pypi/v/snakedeploy.svg?color=%23047857)](https://pypi.python.org/pypi/snakedeploy)
[![https://img.shields.io/github/actions/workflow/status/snakemake/snakedeploy/main.yml?label=tests&color=%2310b981](https://img.shields.io/github/actions/workflow/status/snakemake/snakedeploy/main.yml?label=tests&color=%2310b981)](https://github.com/snakemake/snakedeploy/actions?query=branch%3Amain+workflow%3ACI)
[![https://img.shields.io/badge/stack-overflow-orange.svg?color=%2334d399](https://img.shields.io/badge/stack-overflow-orange.svg?color=%2334d399)](https://stackoverflow.com/questions/tagged/snakemake)
[![Discord](https://img.shields.io/discord/753690260830945390?label=discord%20chat&color=%23a7f3d0)](https://discord.gg/NUdMtmr)
[![Bluesky](https://img.shields.io/badge/bluesky-follow-%23d1fae5)](https://bsky.app/profile/johanneskoester.bsky.social)
[![Mastodon](https://img.shields.io/badge/mastodon-follow-%23ecfdf5)](https://fosstodon.org/%40johanneskoester)

Snakedeploy is a command line tool and Python library for automation of deployment and maintenance tasks around Snakemake and Snakemake workflows <https://snakemake.github.io>.

* **Workflow users** can apply it to automatically [deploy (i.e. set up for use)](workflow_users/workflow_deployment.html#deploy) public workflows for execution from machine or use it to [register input data](workflow_users/input_registration.html#input-registration) for their workflow configuration.
* **Workflow developers** can use it to automatically [update conda environment files](workflow_developers/update_conda_envs.html#update-conda-envs) or [Snakemake wrapper versions](workflow_developers/update_snakemake_wrappers.html#update-snakemake-wrappers) and [pin/lock conda environments](workflow_developers/update_conda_envs.html#pin-conda-envs) in their workflows.
* **Snakemake developers** can use it to [scaffold Snakemake plugins](snakemake_developers/scaffold_snakemake_plugins.html#scaffold-snakemake-plugins) (i.e. to obtain a skeleton codebase as a starting point for each type of possible Snakemake plugin).

## Support

* In case of **questions**, please post on [stack overflow](https://stackoverflow.com/questions/tagged/snakemake) or ask on [Discord](https://discord.gg/NUdMtmr).
* For **bugs and feature requests**, please use the [issue tracker](https://github.com/snakemake/snakedeploy/issues).
* For **contributions**, visit snakedeploy on [Github](https://github.com/snakemake/snakedeploy).

On this page

* [Support](#support)

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)