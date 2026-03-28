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

* Deploy workflows
* [Register input data](input_registration.html)

Workflow developers

* [Update conda environment files](../workflow_developers/update_conda_envs.html)
* [Pin/lock conda environments](../workflow_developers/update_conda_envs.html#pin-lock-conda-environments)
* [Update Snakemake wrappers](../workflow_developers/update_snakemake_wrappers.html)

Snakemake developers

* [Scaffold Snakemake Plugins](../snakemake_developers/scaffold_snakemake_plugins.html)

API Reference

* [The Snakedeploy API](../api_reference/snakedeploy.html)
* [Internal API](../api_reference/internal/modules.html)

[Snakedeploy documentation](../index.html)

/

Deploy workflows

# Deploy workflows

Snakedeploy enables you to automatically deploy a workflow from a public git repository to your local machine, by using Snakemake’s module system.
This way, public workflow can be used and configured for your data.
For example, you can use this in combination with the standardized Snakemake workflows avalailable in the [Snakemake workflow catalog](https://snakemake.github.io/snakemake-workflow-catalog/docs/all_standardized_workflows.html).
Via the command line, deployment works as follows:

```
$ snakedeploy deploy-workflow https://github.com/snakemake-workflows/dna-seq-varlociraptor /tmp/dest --tag v1.0.0
```

Snakedeploy will then generate a workflow definition `/tmp/dest/workflow/Snakefile` that declares the given workflow as a module.
For the example above, it will have the following content

```
configfile: "config/config.yaml"

# declare https://github.com/snakemake-workflows/dna-seq-varlociraptor as a module
module dna_seq_varlociraptor:
    snakefile:
        github("snakemake-workflows/dna-seq-varlociraptor", path="workflow/Snakefile", tag="v1.0.0")
    config:
        config

# use all rules from https://github.com/snakemake-workflows/dna-seq-varlociraptor
use rule * from dna_seq_varlociraptor
```

utilizing [Snakemake’s module system](https://snakemake.readthedocs.io/en/stable/snakefiles/deployment.html#using-and-combining-pre-exising-workflows).
In addition, it will copy over the `config/` and `profiles/` directories of the given repository (and their contents) into respective directories under `/tmp/dest/`.
These should be seen as templates, and can be modified according to your needs.
Further, the workflow definition Snakefile can be arbitrarily extended and modified, thereby making any changes to the used workflow transparent (also see the [snakemake module documentation](https://snakemake.readthedocs.io/en/stable/snakefiles/modularization.html#snakefiles-modules)).

It is highly advisable to put the deployed workflow into a new (perhaps private) git repository (e.g., see [here](https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line) for instructions how to do that with Github).

For more options and details, run

```
$ snakedeploy deploy-workflow --help
```

The same interaction can be done from within Python, see [The Snakedeploy API](../api_reference/snakedeploy.html#api-reference-snakedeploy) for details.

© 2020, Johannes Koester and Vanessa Sochat Built with [Sphinx 7.3.7](https://www.sphinx-doc.org)