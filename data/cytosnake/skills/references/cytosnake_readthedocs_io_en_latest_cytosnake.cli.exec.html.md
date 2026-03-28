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

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.cli.exec.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake.cli.exec package[#](#cytosnake-cli-exec-package "Permalink to this heading")

## Submodules[#](#submodules "Permalink to this heading")

## cytosnake.cli.exec.workflow\_exec module[#](#module-cytosnake.cli.exec.workflow_exec "Permalink to this heading")

workflow\_exec.py

Module containing functions to execute workflows via cytopipe’s
CLI interface

cytosnake.cli.exec.workflow\_exec.workflow\_executor(*workflow*, *n\_cores: int | None = 1*, *allow\_unlock: bool | None = False*, *force\_run: bool | None = False*) → int[#](#cytosnake.cli.exec.workflow_exec.workflow_executor "Permalink to this definition")
:   Wrapper for executing cytopipe workflows

    Parameters:
    :   * **n\_cores** (*int**,* *optional*) – max number of cores to use in the workflow, by default 1
        * **allow\_unlock** (*bool**,* *optional*) – Locks working directory when running cytopipe if
          interrupted. If set to True, cytopipe will automatically
          unlock the working directory. by default False
        * **force\_run** (*bool**,* *optional*) – If set to True, when re-running cytopipe’s workflow will
          start from the beginning. If False, the workflow will
          start where it last stopped. by default False

## Module contents[#](#module-cytosnake.cli.exec "Permalink to this heading")

[Next

cytosnake.common package](cytosnake.common.html)
[Previous

cytosnake.cli package](cytosnake.cli.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake.cli.exec package
  + [Submodules](#submodules)
  + [cytosnake.cli.exec.workflow\_exec module](#module-cytosnake.cli.exec.workflow_exec)
    - [`workflow_executor()`](#cytosnake.cli.exec.workflow_exec.workflow_executor)
  + [Module contents](#module-cytosnake.cli.exec)