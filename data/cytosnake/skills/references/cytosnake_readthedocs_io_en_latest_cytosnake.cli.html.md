Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

[CytoSnake 0.0.1 documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[![Logo](_static/just-icon.svg)

CytoSnake 0.0.1 documentation](index.html)

* [CytoSnake Tutorial](tutorial.html)[ ]
* [CytoSnake Workflows](workflows.html)[ ]
* [Workflow Modules](workflow-modules.html)[ ]
* [CytoSnake API](modules.html)[x]
* [Testing Framework](testing.html)[ ]

  Toggle navigation of Testing Framework

  + [Functional Tests](func-tests.html)
  + [Unittest documentation](unit-tests.html)
  + [Workflow tests](workflow-tests.html)
* [Benchmarking Workflows](benchmarking.html)[ ]

  Toggle navigation of Benchmarking Workflows

Back to top

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.cli.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake.cli package[#](#cytosnake-cli-package "Permalink to this heading")

## Subpackages[#](#subpackages "Permalink to this heading")

* [cytosnake.cli.exec package](cytosnake.cli.exec.html)
  + [Submodules](cytosnake.cli.exec.html#submodules)
  + [cytosnake.cli.exec.workflow\_exec module](cytosnake.cli.exec.html#module-cytosnake.cli.exec.workflow_exec)
    - [`workflow_executor()`](cytosnake.cli.exec.html#cytosnake.cli.exec.workflow_exec.workflow_executor)
  + [Module contents](cytosnake.cli.exec.html#module-cytosnake.cli.exec)

## Submodules[#](#submodules "Permalink to this heading")

## cytosnake.cli.args module[#](#module-cytosnake.cli.args "Permalink to this heading")

Documentation

args.py Module

Responsible for centralizing and handling all user inputted
parameters for cytosnake.

Contains different modes with their respected parameters

*class* cytosnake.cli.args.CliControlPanel(*param\_list: list[str]*, *exec\_path: None | str = None*, *mode: None | str = None*, *data\_type: tuple[str] = ('cell\_profiler', 'deep\_profiler')*, *workflow: None | str = None*, *modes: tuple[str] = ('init', 'run', 'test', 'help')*, *\_CliControlPanel\_\_exec\_name: str = 'cytosnake'*)[#](#cytosnake.cli.args.CliControlPanel "Permalink to this definition")
:   Bases: `object`

    Returns:
    :   CliControlPanel Class contains all the parameters stored
        in the instances.
        The instance contains states of the provided parameters a user
        provides and provides easy logic flow for the CLI to work with.

    Return type:
    :   class CliControlPanel

    Raises:
    :   * [**InvalidExecutableException**](cytosnake.common.html#cytosnake.common.errors.InvalidExecutableException "cytosnake.common.errors.InvalidExecutableException") – Raised if mismatching executable paths do not match
        * [**InvalidArgumentException**](cytosnake.common.html#cytosnake.common.errors.InvalidArgumentException "cytosnake.common.errors.InvalidArgumentException") – Raised if invalid arguments are provided
        * [**InvalidModeException**](cytosnake.common.html#cytosnake.common.errors.InvalidModeException "cytosnake.common.errors.InvalidModeException") – Raised if an invalid mode is provided

    cli\_help *= False*[#](#cytosnake.cli.args.CliControlPanel.cli_help "Permalink to this definition")

    data\_type*: tuple[str]* *= ('cell\_profiler', 'deep\_profiler')*[#](#cytosnake.cli.args.CliControlPanel.data_type "Permalink to this definition")

    exec\_path*: None | str* *= None*[#](#cytosnake.cli.args.CliControlPanel.exec_path "Permalink to this definition")

    mode*: None | str* *= None*[#](#cytosnake.cli.args.CliControlPanel.mode "Permalink to this definition")

    mode\_check *= False*[#](#cytosnake.cli.args.CliControlPanel.mode_check "Permalink to this definition")

    mode\_help *= False*[#](#cytosnake.cli.args.CliControlPanel.mode_help "Permalink to this definition")

    modes*: tuple[str]* *= ('init', 'run', 'test', 'help')*[#](#cytosnake.cli.args.CliControlPanel.modes "Permalink to this definition")

    param\_list*: list[str]*[#](#cytosnake.cli.args.CliControlPanel.param_list "Permalink to this definition")

    parse\_init\_args() → Namespace[#](#cytosnake.cli.args.CliControlPanel.parse_init_args "Permalink to this definition")
    :   Parses user inputs for setting up files

        Parameters:
        :   **params** (*list*) – User defined input parameters

        Returns:
        :   * *argparse.Namespace* – parsed cli parameters
            * *Attributes*
            * *———–*
            * **mode** (*str*) – name of the mode used
            * **data** (*list[str]*) – list of plate data paths
            * **metadata** (*str*) – Path to meta data directory
            * **barcode** (*str*) – Path to barcode file
            * **platemaps** (*str*) – Path to platemap file

    parse\_workflow\_args() → Namespace[#](#cytosnake.cli.args.CliControlPanel.parse_workflow_args "Permalink to this definition")
    :   Wrapper for parsing workflow parameters

        Returns:
        :   returns parsed parameters based on workflow

        Return type:
        :   argparse.Namespace

    workflow*: None | str* *= None*[#](#cytosnake.cli.args.CliControlPanel.workflow "Permalink to this definition")

*class* cytosnake.cli.args.WorkflowSearchPath(*option\_strings*, *dest*, *nargs=None*, *const=None*, *default=None*, *type=None*, *choices=None*, *required=False*, *help=None*, *metavar=None*)[#](#cytosnake.cli.args.WorkflowSearchPath "Permalink to this definition")
:   Bases: `Action`

    This class provides more functionality

    User provided workflow names are checked to see if they exist. If found,
    the parameter will return the absolute path to the workflow. If the name
    does not exist, raise an error indicating that the provided
    workflow name does not exist within cytosnake

cytosnake.cli.args.supported\_workflows() → tuple[str][#](#cytosnake.cli.args.supported_workflows "Permalink to this definition")
:   Returns a tuple of supported workflows that run supports.

    Returns:
    :   tuple containing the names of the workflow names

    Return type:
    :   tuple[str]

## cytosnake.cli.cli\_checker module[#](#module-cytosnake.cli.cli_checker "Permalink to this heading")

### Documentation[#](#documentation "Permalink to this heading")

cli\_checker.py Module

Argument checking module that checks and validates user input
arguments from CytoSnake’s cli interface,

*class* cytosnake.cli.cli\_checker.CliProperties(*modes: tuple[str] = ('init', 'run', 'test', 'help')*, *workflows: tuple[str] = ('cp\_process', 'dp\_process')*)[#](#cytosnake.cli.cli_checker.CliProperties "Permalink to this definition")
:   Bases: `object`

    Struct object that contains information of all arguments in
    CytoSnake’s cli interface

    modes[#](#cytosnake.cli.cli_checker.CliProperties.modes "Permalink to this definition")
    :   Supported modes in CytoSnake’s CLI

        Type:
        :   tuple[str]

    workflows[#](#cytosnake.cli.cli_checker.CliProperties.workflows "Permalink to this definition")
    :   Available CytoSnake workflows

        Type:
        :   tuple[str]

    modes*: tuple[str]* *= ('init', 'run', 'test', 'help')*[#](#id0 "Permalink to this definition")

    workflows*: tuple[str]* *= ('cp\_process', 'dp\_process')*[#](#id1 "Permalink to this definition")

cytosnake.cli.cli\_checker.cli\_check(*args\_list: list[Union[str, int, bool]]*) → bool[#](#cytosnake.cli.cli_checker.cli_check "Permalink to this definition")
:   Checks arguments

    Parameters:
    :   * **mode** (*str*) – CytoSnake mode
        * **args\_list** (*list**[**Union**[**str**,* *int**,* *bool**]**]*) – list of user inputted arguments

    Returns:
    :   Passed the checking system, Raises errors if invalid
        arguments are passed.

    Return type:
    :   None

    Raises:
    :   * [**NoArgumentsException**](cytosnake.common.html#cytosnake.common.errors.NoArgumentsException "cytosnake.common.errors.NoArgumentsException") – Raised if the user provides no arguments
        * [**InvalidModeException**](cytosnake.common.html#cytosnake.common.errors.InvalidModeException "cytosnake.common.errors.InvalidModeException") – Raised if user inputs an invalid CytoSnake mode
        * [**InvalidWorkflowException**](cytosnake.common.html#cytosnake.common.errors.InvalidWorkflowException "cytosnake.common.errors.InvalidWorkflowException") – Raised if user inputs an invalid workflow name
        * [**MultipleModesException**](cytosnake.common.html#cytosnake.common.errors.MultipleModesException "cytosnake.common.errors.MultipleModesException") – Raised if user provides multiple modes

## cytosnake.cli.cli\_docs module[#](#module-cytosnake.cli.cli_docs "Permalink to this heading")

## cytosnake.cli.cmd module[#](#module-cytosnake.cli.cmd "Permalink to this heading")

Documentation

cmd.py Module

Generates CLI interface in order to interact with CytoSnake.

cytosnake.cli.cmd.run\_cmd() → None[#](#cytosnake.cli.cmd.run_cmd "Permalink to this definition")
:   obtains all parameters and executes workflows

    Parameters:
    :   **params** (*list*) – list of user provided parametersCytoSnake

    Return type:
    :   None

## cytosnake.cli.setup\_init module[#](#module-cytosnake.cli.setup_init "Permalink to this heading")

setup\_init.py

Contains functions for initializing different data structures
for processing

cytosnake.cli.setup\_init.init\_cp\_data(*data\_fp: list[str] | str*, *metadata\_fp: str*, *barcode\_fp: str*)[#](#cytosnake.cli.setup_init.init_cp_data "Permalink to this definition")
:   Sets up directory for CellProfiler datasets. Symlinks are created by taking
    the path of the inputs files and storing them into the “data” directory.

    Parameters:
    :   * **data\_fp** (*Union**[**list**[**str**]**,* *str**]*) – Plate data files
        * **metadata\_fp** (*str*) – metadata directory associated with plate data
        * **barcodes\_fp** (*str*) – barcode file associated with plate data

cytosnake.cli.setup\_init.init\_dp\_data(*data\_fp: list[str] | str*, *metadata\_fp: str*)[#](#cytosnake.cli.setup_init.init_dp_data "Permalink to this definition")
:   Sets up directory for CellProfiler datasets. Symlinks are created by
    taking the path of the inputs files and storing them into the “data” directory.

    Parameters:
    :   * **data\_fp** (*Union**[**list**[**str**]**,* *str**]*) – directory containing extracted DeepProfiler features
        * **metadata\_fp** (*str*) – metadata directory associated with DeepProfiler data

    Returns:
    :   Generates a directory containing DeepProfiler Datasets

    Return type:
    :   None

## Module contents[#](#module-cytosnake.cli "Permalink to this heading")

[Next

cytosnake.cli.exec package](cytosnake.cli.exec.html)
[Previous

cytosnake package](cytosnake.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake.cli package
  + [Subpackages](#subpackages)
  + [Submodules](#submodules)
  + [cytosnake.cli.args module](#module-cytosnake.cli.args)
    - [`CliControlPanel`](#cytosnake.cli.args.CliControlPanel)
      * [`CliControlPanel.cli_help`](#cytosnake.cli.args.CliControlPanel.cli_help)
      * [`CliControlPanel.data_type`](#cytosnake.cli.args.CliControlPanel.data_type)
      * [`CliControlPanel.exec_path`](#cytosnake.cli.args.CliControlPanel.exec_path)
      * [`CliControlPanel.mode`](#cytosnake.cli.args.CliControlPanel.mode)
      * [`CliControlPanel.mode_check`](#cytosnake.cli.args.CliControlPanel.mode_check)
      * [`CliControlPanel.mode_help`](#cytosnake.cli.args.CliControlPanel.mode_help)
      * [`CliControlPanel.modes`](#cytosnake.cli.args.CliControlPanel.modes)
      * [`CliControlPanel.param_list`](#cytosnake.cli.args.CliControlPanel.param_list)
      * [`CliControlPanel.parse_init_args()`](#cytosnake.cli.args.CliControlPanel.parse_init_args)
      * [`CliControlPanel.parse_workflow_args()`](#cytosnake.cli.args.CliControlPanel.parse_workflow_args)
      * [`CliControlPanel.workflow`](#cytosnake.cli.args.CliControlPanel.workflow)
    - [`WorkflowSearchPath`](#cytosnake.cli.args.WorkflowSearchPath)
    - [`supported_workflows()`](#cytosnake.cli.args.supported_workflows)
  + [cytosnake.cli.cli\_checker module](#module-cytosnake.cli.cli_checker)
    - [Documentation](#documentation)
    - [`CliProperties`](#cytosnake.cli.cli_checker.CliProperties)
      * [`CliProperties.modes`](#cytosnake.cli.cli_checker.CliProperties.modes)
      * [`CliProperties.workflows`](#cytosnake.cli.cli_checker.CliProperties.workflows)
      * [`CliProperties.modes`](#id0)
      * [`CliProperties.workflows`](#id1)
    - [`cli_check()`](#cytosnake.cli.cli_checker.cli_check)
  + [cytosnake.cli.cli\_docs module](#module-cytosnake.cli.cli_docs)
  + [cytosnake.cli.cmd module](#module-cytosnake.cli.cmd)
    - [`run_cmd()`](#cytosnake.cli.cmd.run_cmd)
  + [cytosnake.cli.setup\_init module](#module-cytosnake.cli.setup_init)
    - [`init_cp_data()`](#cytosnake.cli.setup_init.init_cp_data)
    - [`init_dp_data()`](#cytosnake.cli.setup_init.init_dp_data)
  + [Module contents](#module-cytosnake.cli)