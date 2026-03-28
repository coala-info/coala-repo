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

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.common.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake.common package[#](#cytosnake-common-package "Permalink to this heading")

## Submodules[#](#submodules "Permalink to this heading")

## cytosnake.common.errors module[#](#module-cytosnake.common.errors "Permalink to this heading")

Module: errors.py

Modules containing CytoSnake specific exceptions

Base Exceptions:
Focuses on basic error types like incorrect values or invalid
operations.

CytoSnake Specific Errors:
Exceptions that are specific to CytoSnake

*exception* cytosnake.common.errors.BarcodeMissingError[#](#cytosnake.common.errors.BarcodeMissingError "Permalink to this definition")
:   Bases: [`BaseFileNotFound`](#cytosnake.common.errors.BaseFileNotFound "cytosnake.common.errors.BaseFileNotFound")

    Raised when a barcode file is required

*exception* cytosnake.common.errors.BaseExecutorException[#](#cytosnake.common.errors.BaseExecutorException "Permalink to this definition")
:   Bases: `RuntimeError`

    Base exception related to cytosnake execution

*exception* cytosnake.common.errors.BaseFileExistsError[#](#cytosnake.common.errors.BaseFileExistsError "Permalink to this definition")
:   Bases: `FileExistsError`

    Raised if an existing file or directory is found in a directory

*exception* cytosnake.common.errors.BaseFileNotFound[#](#cytosnake.common.errors.BaseFileNotFound "Permalink to this definition")
:   Bases: `FileNotFoundError`

    Raised if a requested file is not found in cytosnake

*exception* cytosnake.common.errors.BaseValueError[#](#cytosnake.common.errors.BaseValueError "Permalink to this definition")
:   Bases: `ValueError`

    Base exception if incorrect values are passed

*exception* cytosnake.common.errors.BaseWorkflowException[#](#cytosnake.common.errors.BaseWorkflowException "Permalink to this definition")
:   Bases: `RuntimeError`

    Base exception related to cytosnake’s workflow errors in runtime

*exception* cytosnake.common.errors.ExtensionError[#](#cytosnake.common.errors.ExtensionError "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised when invalid extensions are captured

*exception* cytosnake.common.errors.InvalidArgumentException[#](#cytosnake.common.errors.InvalidArgumentException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised when arguments requirements are not met

*exception* cytosnake.common.errors.InvalidCytosnakeExec[#](#cytosnake.common.errors.InvalidCytosnakeExec "Permalink to this definition")
:   Bases: [`BaseExecutorException`](#cytosnake.common.errors.BaseExecutorException "cytosnake.common.errors.BaseExecutorException")

    Raised if invalid cytosnake executable is being called

*exception* cytosnake.common.errors.InvalidExecutableException[#](#cytosnake.common.errors.InvalidExecutableException "Permalink to this definition")
:   Bases: [`BaseExecutorException`](#cytosnake.common.errors.BaseExecutorException "cytosnake.common.errors.BaseExecutorException")

    Raised if any executables

*exception* cytosnake.common.errors.InvalidModeException[#](#cytosnake.common.errors.InvalidModeException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised if in unsupported mode was passed

*exception* cytosnake.common.errors.InvalidWorkflowException[#](#cytosnake.common.errors.InvalidWorkflowException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised if invalid workflows were specified

*exception* cytosnake.common.errors.MultipleModesException[#](#cytosnake.common.errors.MultipleModesException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised if multiple modes were provided

*exception* cytosnake.common.errors.MultipleWorkflowsException[#](#cytosnake.common.errors.MultipleWorkflowsException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised if multiple workflows are declared

*exception* cytosnake.common.errors.NoArgumentsException[#](#cytosnake.common.errors.NoArgumentsException "Permalink to this definition")
:   Bases: [`BaseValueError`](#cytosnake.common.errors.BaseValueError "cytosnake.common.errors.BaseValueError")

    Raised if no arguments were passed in the CLI interface

*exception* cytosnake.common.errors.ProjectExistsError[#](#cytosnake.common.errors.ProjectExistsError "Permalink to this definition")
:   Bases: [`BaseFileExistsError`](#cytosnake.common.errors.BaseFileExistsError "cytosnake.common.errors.BaseFileExistsError")

    Raised when .cytosnake file is found within a directory indicating
    that the current directory has already been set up for cytosnake analysis

*exception* cytosnake.common.errors.WorkflowFailedException[#](#cytosnake.common.errors.WorkflowFailedException "Permalink to this definition")
:   Bases: [`BaseWorkflowException`](#cytosnake.common.errors.BaseWorkflowException "cytosnake.common.errors.BaseWorkflowException")

    Raised if a workflow fails during runtime

*exception* cytosnake.common.errors.WorkflowNotFoundError[#](#cytosnake.common.errors.WorkflowNotFoundError "Permalink to this definition")
:   Bases: [`BaseFileNotFound`](#cytosnake.common.errors.BaseFileNotFound "cytosnake.common.errors.BaseFileNotFound")

    Raised if workflow file is not found

cytosnake.common.errors.display\_error(*error: BaseException | Exception*, *e\_msg: None | str = None*, *exit\_code: int | None = 1*) → None[#](#cytosnake.common.errors.display_error "Permalink to this definition")
:   This function takes in an error type and a custom message. If the custom
    message is None, then the default string data found within the exception
    type will be used.
    The function will print the message of the error and ensures a non-zero
    exit code.

    Parameters:
    :   * **error** (*Union**[**BaseException**,* *Exception**]*) – Takes in a python error object
        * **e\_msg** (*Optional**[**Union**[**None**,* *str**]**]*) – Custom error message. Will overwrite default message from error objects.
          [default=None]
        * **exit\_code** (*int*) – Exit code when error is raised. Cannot be lower than 1. [Default=1]

    Return type:
    :   None

    Raises:
    :   * **TypeError** – Raised if error object is not an error type
          Raised if e\_msg is not a string type
          Raised if exit\_code is not an integer type
        * **ValueError** – Raised if exit\_code is a negative number or is equal to 0

## Module contents[#](#module-cytosnake.common "Permalink to this heading")

[Next

cytosnake.guards package](cytosnake.guards.html)
[Previous

cytosnake.cli.exec package](cytosnake.cli.exec.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake.common package
  + [Submodules](#submodules)
  + [cytosnake.common.errors module](#module-cytosnake.common.errors)
    - [`BarcodeMissingError`](#cytosnake.common.errors.BarcodeMissingError)
    - [`BaseExecutorException`](#cytosnake.common.errors.BaseExecutorException)
    - [`BaseFileExistsError`](#cytosnake.common.errors.BaseFileExistsError)
    - [`BaseFileNotFound`](#cytosnake.common.errors.BaseFileNotFound)
    - [`BaseValueError`](#cytosnake.common.errors.BaseValueError)
    - [`BaseWorkflowException`](#cytosnake.common.errors.BaseWorkflowException)
    - [`ExtensionError`](#cytosnake.common.errors.ExtensionError)
    - [`InvalidArgumentException`](#cytosnake.common.errors.InvalidArgumentException)
    - [`InvalidCytosnakeExec`](#cytosnake.common.errors.InvalidCytosnakeExec)
    - [`InvalidExecutableException`](#cytosnake.common.errors.InvalidExecutableException)
    - [`InvalidModeException`](#cytosnake.common.errors.InvalidModeException)
    - [`InvalidWorkflowException`](#cytosnake.common.errors.InvalidWorkflowException)
    - [`MultipleModesException`](#cytosnake.common.errors.MultipleModesException)
    - [`MultipleWorkflowsException`](#cytosnake.common.errors.MultipleWorkflowsException)
    - [`NoArgumentsException`](#cytosnake.common.errors.NoArgumentsException)
    - [`ProjectExistsError`](#cytosnake.common.errors.ProjectExistsError)
    - [`WorkflowFailedException`](#cytosnake.common.errors.WorkflowFailedException)
    - [`WorkflowNotFoundError`](#cytosnake.common.errors.WorkflowNotFoundError)
    - [`display_error()`](#cytosnake.common.errors.display_error)
  + [Module contents](#module-cytosnake.common)