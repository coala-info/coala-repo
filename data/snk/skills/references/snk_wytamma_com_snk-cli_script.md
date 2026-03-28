[ ]
[ ]

[Skip to content](#access-the-workflow-scripts)

snk

Script

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
  + [Profile](../profile/)
  + [Run](../run/)
  + [ ]

    Script

    [Script](./)

    Table of contents
    - [List](#list)
    - [Show](#show)
    - [Run](#run)

Table of contents

* [List](#list)
* [Show](#show)
* [Run](#run)

# Access the workflow scripts

The `script` commands allow you to interact with the workflow scripts. Scripts must be located in the `scripts` directory of the workflow.

## List

The list command will list all scripts in the workflow.

```
snk-basic-pipeline script list
```

## Show

The show command will display the contents of a script.

```
snk-basic-pipeline script show hello.py
```

## Run

The run command will run a script.

```
snk-basic-pipeline script run hello.py
```

Note

The executor used to run the script is determined by the suffix of the script file. For example, a script named `hello.py` will be run using the `python` executor.

Use the `--env` option to specify the environment to run the script in.

```
snk-basic-pipeline script run --env python hello.py
```

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)