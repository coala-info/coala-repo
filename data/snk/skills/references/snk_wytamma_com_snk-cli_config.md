[ ]
[ ]

[Skip to content](#show-the-workflow-configuration)

snk

Config

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
  + [ ]
    [Config](./)
  + [Env](../env/)
  + [Info](../info/)
  + [Profile](../profile/)
  + [Run](../run/)
  + [Script](../script/)

# Show the Workflow Configuration

The config subcommand will display the workflow configuration file contents. You can use the `--pretty` (`-p`) flag to display the configuration in a more readable format.

```
snk-basic-pipeline config
```

```
genome: data/genome.fa
samples_dir: data/samples
sample:
- A
- B
- C
```

You can pipe the output to a file to save the configuration.

```
snk-basic-pipeline config > config.yaml
```

You can then edit the configuration file and use it to run the workflow.

```
snk-basic-pipeline run --config config.yaml
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)