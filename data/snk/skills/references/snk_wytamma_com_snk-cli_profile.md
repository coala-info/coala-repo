[ ]
[ ]

[Skip to content](#access-the-workflow-profiles)

snk

Profile

Initializing search

[GitHub](https://github.com/Wytamma/snk "Go to repository")

snk

[GitHub](https://github.com/Wytamma/snk "Go to repository")

* [Home](../..)
* [Managing Workflows](../../managing_workflows/)
* [Snk Config File](../../snk_config_file/)
* [Workflow Packages](../../workflow_packages/)
* [ ]

  Reference

  Reference
  + [Nest](../../reference/nest/)
* [x]

  Snk cli

  Snk cli
  + [The Snk CLI](../)
  + [Config](../config/)
  + [Env](../env/)
  + [Info](../info/)
  + [ ]

    Profile

    [Profile](./)

    Table of contents
    - [List](#list)
    - [Show](#show)

      * [Load a profile](#load-a-profile)
    - [Edit](#edit)
  + [Run](../run/)
  + [Script](../script/)

Table of contents

* [List](#list)
* [Show](#show)

  + [Load a profile](#load-a-profile)
* [Edit](#edit)

# Access the workflow profiles

The `profile` subcommand provides several commands to manage the workflow profiles. Profiles are used to define different configurations for the workflow e.g. you can configure how the workflow will run on a HPC. You can read more about profiles in the [Snakemake documentation](https://snakemake.readthedocs.io/en/stable/executing/cli.html#profiles).

Note

For snk to be able to access the profiles, the profiles must be located in the `profiles` directory of the workflow.

## List

List the profiles in the workflow.

```
snk-basic-pipeline profile list
```

## Show

The show command will display the contents of a profile.

```
snk-basic-pipeline profile show slurm
```

You can save the profiles by piping the output to a file.

```
snk-basic-pipeline profile show slurm > profile/config.yaml
```

Note

You must save the profile as config.yaml in a directory so that it can be accessed by the workflow.

### Load a profile

You can load a profile by using the `--profile` option in the run command.

```
snk-basic-pipeline run --profile profile/config.yaml
```

## Edit

The edit command will open the profile in the default editor. Changes saved will modify the default profile settings for the installation.

```
snk-basic-pipeline profile edit slurm
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)