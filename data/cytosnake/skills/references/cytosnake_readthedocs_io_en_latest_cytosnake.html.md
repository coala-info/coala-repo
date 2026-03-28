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

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake package[#](#cytosnake-package "Permalink to this heading")

## Subpackages[#](#subpackages "Permalink to this heading")

* [cytosnake.cli package](cytosnake.cli.html)
  + [Subpackages](cytosnake.cli.html#subpackages)
    - [cytosnake.cli.exec package](cytosnake.cli.exec.html)
      * [Submodules](cytosnake.cli.exec.html#submodules)
      * [cytosnake.cli.exec.workflow\_exec module](cytosnake.cli.exec.html#module-cytosnake.cli.exec.workflow_exec)
      * [Module contents](cytosnake.cli.exec.html#module-cytosnake.cli.exec)
  + [Submodules](cytosnake.cli.html#submodules)
  + [cytosnake.cli.args module](cytosnake.cli.html#module-cytosnake.cli.args)
    - [`CliControlPanel`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel)
      * [`CliControlPanel.cli_help`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.cli_help)
      * [`CliControlPanel.data_type`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.data_type)
      * [`CliControlPanel.exec_path`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.exec_path)
      * [`CliControlPanel.mode`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.mode)
      * [`CliControlPanel.mode_check`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.mode_check)
      * [`CliControlPanel.mode_help`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.mode_help)
      * [`CliControlPanel.modes`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.modes)
      * [`CliControlPanel.param_list`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.param_list)
      * [`CliControlPanel.parse_init_args()`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.parse_init_args)
      * [`CliControlPanel.parse_workflow_args()`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.parse_workflow_args)
      * [`CliControlPanel.workflow`](cytosnake.cli.html#cytosnake.cli.args.CliControlPanel.workflow)
    - [`WorkflowSearchPath`](cytosnake.cli.html#cytosnake.cli.args.WorkflowSearchPath)
    - [`supported_workflows()`](cytosnake.cli.html#cytosnake.cli.args.supported_workflows)
  + [cytosnake.cli.cli\_checker module](cytosnake.cli.html#module-cytosnake.cli.cli_checker)
    - [Documentation](cytosnake.cli.html#documentation)
    - [`CliProperties`](cytosnake.cli.html#cytosnake.cli.cli_checker.CliProperties)
      * [`CliProperties.modes`](cytosnake.cli.html#cytosnake.cli.cli_checker.CliProperties.modes)
      * [`CliProperties.workflows`](cytosnake.cli.html#cytosnake.cli.cli_checker.CliProperties.workflows)
      * [`CliProperties.modes`](cytosnake.cli.html#id0)
      * [`CliProperties.workflows`](cytosnake.cli.html#id1)
    - [`cli_check()`](cytosnake.cli.html#cytosnake.cli.cli_checker.cli_check)
  + [cytosnake.cli.cli\_docs module](cytosnake.cli.html#module-cytosnake.cli.cli_docs)
  + [cytosnake.cli.cmd module](cytosnake.cli.html#module-cytosnake.cli.cmd)
    - [`run_cmd()`](cytosnake.cli.html#cytosnake.cli.cmd.run_cmd)
  + [cytosnake.cli.setup\_init module](cytosnake.cli.html#module-cytosnake.cli.setup_init)
    - [`init_cp_data()`](cytosnake.cli.html#cytosnake.cli.setup_init.init_cp_data)
    - [`init_dp_data()`](cytosnake.cli.html#cytosnake.cli.setup_init.init_dp_data)
  + [Module contents](cytosnake.cli.html#module-cytosnake.cli)
* [cytosnake.common package](cytosnake.common.html)
  + [Submodules](cytosnake.common.html#submodules)
  + [cytosnake.common.errors module](cytosnake.common.html#module-cytosnake.common.errors)
    - [`BarcodeMissingError`](cytosnake.common.html#cytosnake.common.errors.BarcodeMissingError)
    - [`BaseExecutorException`](cytosnake.common.html#cytosnake.common.errors.BaseExecutorException)
    - [`BaseFileExistsError`](cytosnake.common.html#cytosnake.common.errors.BaseFileExistsError)
    - [`BaseFileNotFound`](cytosnake.common.html#cytosnake.common.errors.BaseFileNotFound)
    - [`BaseValueError`](cytosnake.common.html#cytosnake.common.errors.BaseValueError)
    - [`BaseWorkflowException`](cytosnake.common.html#cytosnake.common.errors.BaseWorkflowException)
    - [`ExtensionError`](cytosnake.common.html#cytosnake.common.errors.ExtensionError)
    - [`InvalidArgumentException`](cytosnake.common.html#cytosnake.common.errors.InvalidArgumentException)
    - [`InvalidCytosnakeExec`](cytosnake.common.html#cytosnake.common.errors.InvalidCytosnakeExec)
    - [`InvalidExecutableException`](cytosnake.common.html#cytosnake.common.errors.InvalidExecutableException)
    - [`InvalidModeException`](cytosnake.common.html#cytosnake.common.errors.InvalidModeException)
    - [`InvalidWorkflowException`](cytosnake.common.html#cytosnake.common.errors.InvalidWorkflowException)
    - [`MultipleModesException`](cytosnake.common.html#cytosnake.common.errors.MultipleModesException)
    - [`MultipleWorkflowsException`](cytosnake.common.html#cytosnake.common.errors.MultipleWorkflowsException)
    - [`NoArgumentsException`](cytosnake.common.html#cytosnake.common.errors.NoArgumentsException)
    - [`ProjectExistsError`](cytosnake.common.html#cytosnake.common.errors.ProjectExistsError)
    - [`WorkflowFailedException`](cytosnake.common.html#cytosnake.common.errors.WorkflowFailedException)
    - [`WorkflowNotFoundError`](cytosnake.common.html#cytosnake.common.errors.WorkflowNotFoundError)
    - [`display_error()`](cytosnake.common.html#cytosnake.common.errors.display_error)
  + [Module contents](cytosnake.common.html#module-cytosnake.common)
* [cytosnake.guards package](cytosnake.guards.html)
  + [Submodules](cytosnake.guards.html#submodules)
  + [cytosnake.guards.ext\_guards module](cytosnake.guards.html#module-cytosnake.guards.ext_guards)
    - [`has_parquet_ext()`](cytosnake.guards.html#cytosnake.guards.ext_guards.has_parquet_ext)
    - [`has_sqlite_ext()`](cytosnake.guards.html#cytosnake.guards.ext_guards.has_sqlite_ext)
  + [cytosnake.guards.input\_guards module](cytosnake.guards.html#module-cytosnake.guards.input_guards)
    - [`check_init_parameter_inputs()`](cytosnake.guards.html#cytosnake.guards.input_guards.check_init_parameter_inputs)
    - [`is_barcode_required()`](cytosnake.guards.html#cytosnake.guards.input_guards.is_barcode_required)
  + [cytosnake.guards.path\_guards module](cytosnake.guards.html#module-cytosnake.guards.path_guards)
    - [`is_valid_path()`](cytosnake.guards.html#cytosnake.guards.path_guards.is_valid_path)
  + [Module contents](cytosnake.guards.html#module-cytosnake.guards)
* [cytosnake.utils package](cytosnake.utils.html)
  + [Submodules](cytosnake.utils.html#submodules)
  + [cytosnake.utils.config\_utils module](cytosnake.utils.html#module-cytosnake.utils.config_utils)
    - [`load_configs()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_configs)
    - [`load_cytosnake_configs()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_cytosnake_configs)
    - [`load_data_path_configs()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_data_path_configs)
    - [`load_general_configs()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_general_configs)
    - [`load_meta_path_configs()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_meta_path_configs)
    - [`load_workflow_path()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_workflow_path)
    - [`load_workflow_paths_config()`](cytosnake.utils.html#cytosnake.utils.config_utils.load_workflow_paths_config)
    - [`update_config()`](cytosnake.utils.html#cytosnake.utils.config_utils.update_config)
  + [cytosnake.utils.cyto\_paths module](cytosnake.utils.html#module-cytosnake.utils.cyto_paths)
    - [`get_benchmarks_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_benchmarks_path)
    - [`get_config_dir_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_config_dir_path)
    - [`get_config_fpaths()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_config_fpaths)
    - [`get_cytosnake_config_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_cytosnake_config_path)
    - [`get_cytosnake_package_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_cytosnake_package_path)
    - [`get_meta_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_meta_path)
    - [`get_project_dirpaths()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_project_dirpaths)
    - [`get_project_root()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_project_root)
    - [`get_results_dir_path()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_results_dir_path)
    - [`get_workflow_fpaths()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.get_workflow_fpaths)
    - [`is_cytosnake_dir()`](cytosnake.utils.html#cytosnake.utils.cyto_paths.is_cytosnake_dir)
  + [cytosnake.utils.cytosnake\_setup module](cytosnake.utils.html#module-cytosnake.utils.cytosnake_setup)
    - [`create_cytosnake_dir()`](cytosnake.utils.html#cytosnake.utils.cytosnake_setup.create_cytosnake_dir)
    - [`generate_meta_path_configs()`](cytosnake.utils.html#cytosnake.utils.cytosnake_setup.generate_meta_path_configs)
    - [`setup_cytosnake_env()`](cytosnake.utils.html#cytosnake.utils.cytosnake_setup.setup_cytosnake_env)
    - [`transport_project_files()`](cytosnake.utils.html#cytosnake.utils.cytosnake_setup.transport_project_files)
  + [cytosnake.utils.feature\_utils module](cytosnake.utils.html#module-cytosnake.utils.feature_utils)
    - [`infer_dp_features()`](cytosnake.utils.html#cytosnake.utils.feature_utils.infer_dp_features)
  + [cytosnake.utils.file\_utils module](cytosnake.utils.html#module-cytosnake.utils.file_utils)
    - [`file_search()`](cytosnake.utils.html#cytosnake.utils.file_utils.file_search)
    - [`find_project_dir()`](cytosnake.utils.html#cytosnake.utils.file_utils.find_project_dir)
  + [Module contents](cytosnake.utils.html#module-cytosnake.utils)

## Module contents[#](#module-cytosnake "Permalink to this heading")

[Next

cytosnake.cli package](cytosnake.cli.html)
[Previous

CytoSnake API](modules.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake package
  + [Subpackages](#subpackages)
  + [Module contents](#module-cytosnake)