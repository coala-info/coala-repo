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

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.guards.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake.guards package[#](#cytosnake-guards-package "Permalink to this heading")

## Submodules[#](#submodules "Permalink to this heading")

## cytosnake.guards.ext\_guards module[#](#module-cytosnake.guards.ext_guards "Permalink to this heading")

module: ext\_guards.py

Checks if the correct extensions are provided

cytosnake.guards.ext\_guards.has\_parquet\_ext(*file\_name: str | Path*) → TypeGuard[str][#](#cytosnake.guards.ext_guards.has_parquet_ext "Permalink to this definition")
:   Checks if the provided file path contains parquet file extension .
    :param file\_name: path to file
    :type file\_name: str | pathlib.Path

    Returns:
    :   return True if it is a parquet file, else False

    Return type:
    :   TypeGuard[str]

cytosnake.guards.ext\_guards.has\_sqlite\_ext(*file\_name: str | Path*) → TypeGuard[str][#](#cytosnake.guards.ext_guards.has_sqlite_ext "Permalink to this definition")
:   Checks if the provided file path contains parquet file extension .

    Parameters:
    :   **file\_name** (*str* *|* *pathlib.Path*) – path to file

    Returns:
    :   return True if it is a parquet file, else False

    Return type:
    :   TypeGuard[str]

## cytosnake.guards.input\_guards module[#](#module-cytosnake.guards.input_guards "Permalink to this heading")

module: input\_guards.py

This module will handle the CytoSnake’s CLI logic mostly interacting with user defined
parameters from CytoSnake’s CLI.

There the logic establishes some rules of what inputs are required or what functionality
is or not allowed.

cytosnake.guards.input\_guards.check\_init\_parameter\_inputs(*user\_params: NameSpace*) → bool[#](#cytosnake.guards.input_guards.check_init_parameter_inputs "Permalink to this definition")
:   Main wrapper to check init mode parameter logic.

    Parameters:
    :   **user\_params** (*NameSpace*) – Argparse.NameSpace object that contains all user provided parameters.

    Returns:
    :   True if all logic checks passed

    Return type:
    :   bool

    Raises:
    :   [**BarcodeMissingError**](cytosnake.common.html#cytosnake.common.errors.BarcodeMissingError "cytosnake.common.errors.BarcodeMissingError") – Raised if a multiple platemaps are found but no barcode file was provided

cytosnake.guards.input\_guards.is\_barcode\_required(*user\_params: NameSpace*) → bool[#](#cytosnake.guards.input_guards.is_barcode_required "Permalink to this definition")
:   user\_params: NameSpace
    :   Argparse.NameSpace object that contains all user provided parameters

    Returns:
    :   With the given parameter inputs, True if barcodes are required else False

    Return type:
    :   bool

## cytosnake.guards.path\_guards module[#](#module-cytosnake.guards.path_guards "Permalink to this heading")

Module: path\_guards.py

Functions for checking paths.

This includes:
:   * existing paths
    * valid path strings

cytosnake.guards.path\_guards.is\_valid\_path(*val: object*) → TypeGuard[Path][#](#cytosnake.guards.path_guards.is_valid_path "Permalink to this definition")
:   checks if provided value is a valid path

    Returns:
    :   True if the path exists, else false

    Return type:
    :   bool

## Module contents[#](#module-cytosnake.guards "Permalink to this heading")

[Next

cytosnake.utils package](cytosnake.utils.html)
[Previous

cytosnake.common package](cytosnake.common.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake.guards package
  + [Submodules](#submodules)
  + [cytosnake.guards.ext\_guards module](#module-cytosnake.guards.ext_guards)
    - [`has_parquet_ext()`](#cytosnake.guards.ext_guards.has_parquet_ext)
    - [`has_sqlite_ext()`](#cytosnake.guards.ext_guards.has_sqlite_ext)
  + [cytosnake.guards.input\_guards module](#module-cytosnake.guards.input_guards)
    - [`check_init_parameter_inputs()`](#cytosnake.guards.input_guards.check_init_parameter_inputs)
    - [`is_barcode_required()`](#cytosnake.guards.input_guards.is_barcode_required)
  + [cytosnake.guards.path\_guards module](#module-cytosnake.guards.path_guards)
    - [`is_valid_path()`](#cytosnake.guards.path_guards.is_valid_path)
  + [Module contents](#module-cytosnake.guards)