Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

[Snakebids 0.15.0 documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[Snakebids 0.15.0 documentation](../index.html)

User Guide

* [Why use snakebids?](../general/why_snakebids.html)
* [Tutorial](../tutorial/tutorial.html)
* [Bids Function](../bids_function/overview.html)
* [Bids Apps](../bids_app/overview.html)[ ]
* [Running Snakebids](../running_snakebids/overview.html)
* [Migrations](../migration/index.html)[ ]

Reference

* [API](main.html)[ ]
* [Internals](internals.html)
* Plugins

Back to top

[View this page](https://github.com/khanlab/snakebids/blob/main/docs/api/plugins.rst?plain=true "View this page")

[Edit this page](https://github.com/khanlab/snakebids/edit/main/docs/api/plugins.rst "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Plugins[¶](#plugins "Link to this heading")

Note

This page consists of plugins distributed with Snakebids. Externally developed and distributed plugins may be missing from this page.

## Core[¶](#core "Link to this heading")

These plugins provide essential bids app features and will be needed by most apps.

*class* snakebids.plugins.BidsArgs(*argument\_group=''*, *bids\_dir=True*, *output\_dir=True*, *analysis\_level=True*, *analysis\_level\_choices=None*, *analysis\_level\_choices\_config=None*, *participant\_label=True*, *exclude\_participant\_label=True*, *derivatives=True*)[¶](#snakebids.plugins.BidsArgs "Link to this definition")
:   Add basic BIDSApp arguments.

    Parameters:
    :   * **argument\_group** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Specify title of the group to which arguments should be added
        * **bids\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if bids\_dir (first bids argument) should be defined
        * **output\_dir** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if output\_dir (second bids argument) should be defined
        * **analysis\_level** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if output\_dir (third bids argument) should be defined
        * **analysis\_level\_choices** ([*list*](https://docs.python.org/3/library/stdtypes.html#list "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*]* *|* *None*) – List of valid analysis levels
        * **analysis\_level\_choices\_config** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Configuration key containing analysis level choices
        * **participant\_label** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if `participant_label` should be defined. Used to filter specific
          subjects for processesing
        * **exclude\_participant\_label** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if `exclude_participant_label` should be defined. Used to excluded
          specific subjects from processesing
        * **derivatives** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Indicate if `derivatives` should be defined. Used to allow automatic
          derivative indexing or specify paths to derivatives.

    ### CLI Arguments[¶](#cli-arguments "Link to this heading")

    All arguments are added by default, but can be disabled using their respective
    parameters. Additionally, arguments can be directly overridden by adding arguments
    to the parser before the plugin runs, using the following `dests`:

    * `bids_dir`: The input bids directory
    * `output_dir`: The output bids directory
    * `analysis_level`: The level of analysis to perform (usually `participant` or
      `group`)
    * `participant_label`: Collection of subject labels to include in analysis
    * `exclude_participant_label`: Collection of subject labels to exclude from
      analysis
    * `derivatives`: Collection of derivative folder paths to include in bids
      indexing.

    Note that only the `dest` field matters when overriding arguments, all other
    feature, including positional versus optional, are incidental. Other than adding
    arguments for the above `dests`, `BidsArgs` makes no assumptions about these
    arguments. Other plugins, however, may expect to find data in the parser namespace
    or config corresponding to the `dest` names.

    Warning

    Overriding just one or two of the positional arguments may alter the order,
    preventing the app from being called correctly. Thus, if any of the positional
    args are being overridden, they all should be.

    ### Analysis levels[¶](#analysis-levels "Link to this heading")

    Valid analysis levels can be set using the `analysis_level_choices` key or the
    `analysis_level_choices_config` key. If both are set, an error will be raised. If
    neither are set, the config will first be searched for the `analysis_levels` key.
    If this is not found, analysis levels will be set to `["participant", "group"]`.

    add\_cli\_arguments(*parser*, *argument\_groups*, *config*)[¶](#snakebids.plugins.BidsArgs.add_cli_arguments "Link to this definition")
    :   Add arguments from config.

        Parameters:
        :   * **parser** ([*argparse.ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)"))
            * **argument\_groups** (*ArgumentGroups*)
            * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* *Any**]*)

*class* snakebids.plugins.ComponentEdit(*components\_key='pybids\_inputs'*)[¶](#snakebids.plugins.ComponentEdit "Link to this definition")
:   Use CLI arguments to edit the filters, wildcards, and paths of components.

    Arguments are added based on the components specified in `config`. For each
    component, a `--filter-<comp_name>`, `--wildcards-<comp_name>`, and a
    `--path-<comp_name>` argument will be added to the CLI. After parsing, these
    arguments are read and used to update the original component specification within
    config.

    Filters are specified on the CLI using `ENTITY[:METHOD][=VALUE]`, as follows:

    1. `ENTITY=VALUE` selects paths based on an exact value match.
    2. `ENTITY:match=REGEX` and `ENTITY:search=REGEX` selects paths using regex
       with [`re.match()`](https://docs.python.org/3/library/re.html#re.match "(in Python v3.14)") and [`re.search()`](https://docs.python.org/3/library/re.html#re.search "(in Python v3.14)") respectively. This syntax can be used
       to select multiple values (e.g. `'session:match=01|02'`).
    3. `ENTITY:required` selects all paths with the entity, regardless of value.
    4. `ENTITY:none` selects all paths without the entity.
    5. `ENTITY:any` removes filters for the entity.

    CLI arguments created by this plugin cannot be overridden.

    Parameters:
    :   **components\_key** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Key of component specification within the config dictionary.

    add\_cli\_arguments(*parser*, *config*)[¶](#snakebids.plugins.ComponentEdit.add_cli_arguments "Link to this definition")
    :   Add filter, wildcard, and path override arguments for each component.

        Parameters:
        :   * **parser** ([*ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)"))
            * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)

    update\_cli\_namespace(*namespace*, *config*)[¶](#snakebids.plugins.ComponentEdit.update_cli_namespace "Link to this definition")
    :   Apply provided overrides to the component configuration.

        Parameters:
        :   * **namespace** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)
            * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)

*class* snakebids.plugins.CliConfig(*cli\_key='parse\_args'*)[¶](#snakebids.plugins.CliConfig "Link to this definition")
:   Configure CLI arguments directly in config.

    Arguments are provided in config in a dictionary stored under `cli_key`. Each
    entry maps the name of the argument to a set of valid arguments for
    [`add_argument()`](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser.add_argument "(in Python v3.14)").

    This plugin will attempt to be the first to add arguments, and thus can be used
    to override arguments from other compatible plugins, such as
    [`BidsArgs`](#snakebids.plugins.BidsArgs "snakebids.plugins.bidsargs.BidsArgs")

    Parameters:
    :   **cli\_key** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")) – Key of dict containing arguments

    Example

    ```
    parse_args:
        --tunable-parameter:
            help: |
                A parameter important to the analysis that you can be set from the
                commandline. If not set, a sensible default will be used
            default: 5
            type: float
        --alternate-mode:
            help: |
                A flag activating a secondary feature of the workflow
            action: store_true
        --derivatives:
            help: |
                An alternate help message for --derivatives, which will override
                the help message from argument given by ``BidsArgs``. Note that we
                must again specify the ``nargs`` and ``type`` for the param
            type: Path
            nargs: "*"
    ```

    add\_cli\_arguments(*parser*, *config*)[¶](#snakebids.plugins.CliConfig.add_cli_arguments "Link to this definition")
    :   Add arguments from config.

        Parameters:
        :   * **parser** ([*ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)"))
            * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)

*class* snakebids.plugins.Pybidsdb(*argument\_group=None*)[¶](#snakebids.plugins.Pybidsdb "Link to this definition")
:   Add CLI parameters to specify and reset a pybids database.

    Parameters:
    :   **argument\_group** ([*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)") *|* *None*) – Specify title of the group to which arguments should be added

    ### CLI Arguments[¶](#id1 "Link to this heading")

    Two arguments are added to the CLI. These can be overridden by adding arguments
    with corresponding `dests` before this plugin is run:

    * `plugins.pybidsdb.dir`: ([`Path`](https://docs.python.org/3/library/pathlib.html#pathlib.Path "(in Python v3.14)")) Path of the database
    * `plugins.pybidsdb.reset`: ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) Boolean indicating the database should
      be reset.

    After parsing, the above dests will be moved into `config` under the following
    names:

    * `plugins.pybidsdb.dir` → `pybidsdb_dir`
    * `plugins.pybidsdb.reset` → `pybidsdb_reset`

    This plugin only handles the CLI arguments, it does not do any actions with the
    database. The above config entries can be consumed by downstream processes.

    add\_cli\_arguments(*parser*, *argument\_groups*)[¶](#snakebids.plugins.Pybidsdb.add_cli_arguments "Link to this definition")
    :   Add database parameters.

        Parameters:
        :   * **parser** ([*argparse.ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.ArgumentParser "(in Python v3.14)"))
            * **argument\_groups** (*ArgumentGroups*)

    update\_cli\_namespace(*namespace*, *config*)[¶](#snakebids.plugins.Pybidsdb.update_cli_namespace "Link to this definition")
    :   Assign database parameters to config.

        Parameters:
        :   * **namespace** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)
            * **config** ([*dict*](https://docs.python.org/3/library/stdtypes.html#dict "(in Python v3.14)")*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.14)")*,* [*Any*](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.14)")*]*)

## Utility[¶](#utility "Link to this heading")

These plugins add additional features that may be helpful to most bids apps.

*class* snakebids.plugins.BidsValidator(*raise\_invalid\_bids=True*)[¶](#snakebids.plugins.BidsValidator "Link to this definition")
:   Perform validation of a BIDS dataset using the bids-validator.

    If the dataset is not valid according to the BIDS specifications, an
    InvalidBidsError is raised.

    An argument –skip-bids-validation is added to the CLI. This argument can be
    overridden by adding an argument with dest `plugins.validator.skip` before this
    plugin runs.

    Two entries are added to config:
    - `"plugins.validator.skip"`: Indicates if validation was skipped
    - `"plugins.validator.success"`: Indicates if validation succeeded

    Parameters:
    :   **raise\_invalid\_bids** ([*bool*](https://docs.python.org/3/library/functions.html#bool "(in Python v3.14)")) – Flag to indicate whether InvalidBidsError should be raised if BIDS
        validation fails. Default to True.

    add\_cli\_arguments(*parser*)[¶](#snakebids.plugins.BidsValidator.add_cli_arguments "Link to this definition")
    :   Add option to skip validation.

        Parameters:
        :   **parser** ([*ArgumentParser*](https://docs.python.org/3/library/argparse.html#argparse.Ar