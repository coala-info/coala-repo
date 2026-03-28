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

[Edit this page](https://github.com/WayScience/CytoSnake/edit/master/docs/cytosnake.utils.md "Edit this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# cytosnake.utils package[#](#cytosnake-utils-package "Permalink to this heading")

## Submodules[#](#submodules "Permalink to this heading")

## cytosnake.utils.config\_utils module[#](#module-cytosnake.utils.config_utils "Permalink to this heading")

Module: config\_utils.py

config\_uitls.py serves as a utility module, that manages configuration files
within the CytoSnake workflow framework. This module offers an array of
functions that aids in loading, parsing, and dynamic modification of
configuration files.

cytosnake.utils.config\_utils.load\_configs(*config\_path: str | Path*) → dict[#](#cytosnake.utils.config_utils.load_configs "Permalink to this definition")
:   Returns a dictionary of given configurations

    Parameters:
    :   **config\_path** (*str* *|* *Path*) – path to config file

    Returns:
    :   configuration dictionary

    Return type:
    :   dict

    Raises:
    :   **FileNotFoundError** – raised if provided config file paths is invalid

cytosnake.utils.config\_utils.load\_cytosnake\_configs() → dict[#](#cytosnake.utils.config_utils.load_cytosnake_configs "Permalink to this definition")
:   Loads in CytoSnake’s general configuration

    Returns:
    :   CytoSnake configs

    Return type:
    :   dict

cytosnake.utils.config\_utils.load\_data\_path\_configs()[#](#cytosnake.utils.config_utils.load_data_path_configs "Permalink to this definition")
:   Returns path pointing where the data folder is

    Returns:
    :   Path to data folder in project directory

    Return type:
    :   Path

cytosnake.utils.config\_utils.load\_general\_configs() → dict[#](#cytosnake.utils.config_utils.load_general_configs "Permalink to this definition")
:   Loads cytosnake’s general configurations

    ### Returns:[#](#returns "Permalink to this heading")

    dict
    :   dictionary containing the cytosnake general configs

cytosnake.utils.config\_utils.load\_meta\_path\_configs() → dict[#](#cytosnake.utils.config_utils.load_meta_path_configs "Permalink to this definition")
:   Loads the metadata path from .cytosnake/\_paths.yaml file

    Returns:
    :   meta path contents from the \_paths.yaml file

    Return type:
    :   dict

cytosnake.utils.config\_utils.load\_workflow\_path(*wf\_name: str*) → Path[#](#cytosnake.utils.config_utils.load_workflow_path "Permalink to this definition")
:   Loads in configurations and returns path pointing to
    workflow

    Parameters:
    :   **wf\_name** (*str*) – workflow name

    Returns:
    :   Path to workflow

    Return type:
    :   pathlib.PosixPath

    Raises:
    :   **WorkFlowNotFound** – Raised if the desired workflow is not found.

cytosnake.utils.config\_utils.load\_workflow\_paths\_config() → dict[#](#cytosnake.utils.config_utils.load_workflow_paths_config "Permalink to this definition")

cytosnake.utils.config\_utils.update\_config(*config\_file\_path: str | Path*, *new\_key: str*, *new\_value: str | Any*, *update: bool | None = False*) → None[#](#cytosnake.utils.config_utils.update_config "Permalink to this definition")
:   This updates config level in the upper level.

    Parameters:
    :   * **key** (*str*) – key to add into the config
        * **value** (*str* *|* *Number*) – Value to add to the given key.
        * **update** (*bool*) – Update value to existing key

    Raises:
    :   * **ValueError** – raised if the key value cannot be converted into a string
        * **TypeError** – raised if there is a type error with any parameter
        * **FileNotFoundError** – raised if the config file is not found
        * **KeyError** – raised if given key exists within the config file

## cytosnake.utils.cyto\_paths module[#](#module-cytosnake.utils.cyto_paths "Permalink to this heading")

module: cyto\_paths.py

This module will contain functions that handles cytosnake’s pathing

cytosnake.utils.cyto\_paths.get\_benchmarks\_path() → Path[#](#cytosnake.utils.cyto_paths.get_benchmarks_path "Permalink to this definition")
:   Get the path to the benchmarks directory.

    This function retrieves the path to the ‘benchmarks’ directory within the project
    root directory.
    If the directory does not exist, it will be created.

    Returns:
    :   The path to the ‘benchmarks’ directory.

    Return type:
    :   pathlib.Path

cytosnake.utils.cyto\_paths.get\_config\_dir\_path() → Path[#](#cytosnake.utils.cyto_paths.get_config_dir_path "Permalink to this definition")
:   Returns path to configuration folder

    Returns:
    :   Path to config directory

    Return type:
    :   Path

cytosnake.utils.cyto\_paths.get\_config\_fpaths() → dict[#](#cytosnake.utils.cyto_paths.get_config_fpaths "Permalink to this definition")
:   Obtains all file paths located in the configs folder as a dictionary.

    Returns:
    :   structured dictionary with directory name and file paths as key value pairs

    Return type:
    :   dict

cytosnake.utils.cyto\_paths.get\_cytosnake\_config\_path() → Path[#](#cytosnake.utils.cyto_paths.get_cytosnake_config_path "Permalink to this definition")
:   Returns absolute path to CytoSnake’s general config file .

    Returns:
    :   path to cytosnake general config file

    Return type:
    :   pathlib.Path

cytosnake.utils.cyto\_paths.get\_cytosnake\_package\_path() → Path[#](#cytosnake.utils.cyto_paths.get_cytosnake_package_path "Permalink to this definition")
:   Returns paths where the package is installed

    Returns:
    :   Returns absolute path of where the package is installed

    Return type:
    :   Path

    Raises:
    :   **FileNotFoundError** – Raised if CytoSnake Package is not found

cytosnake.utils.cyto\_paths.get\_meta\_path() → Path[#](#cytosnake.utils.cyto_paths.get_meta_path "Permalink to this definition")
:   returns meta path configurational file path.

    Returns:
    :   Path object pointing to \_paths.yaml config file

    Return type:
    :   Path

cytosnake.utils.cyto\_paths.get\_project\_dirpaths(*args: Namespace*) → dict[#](#cytosnake.utils.cyto_paths.get_project_dirpaths "Permalink to this definition")
:   returns a dictionary containing directory name and path as key value
    pairs.

    Parameters:
    :   **args** (*Namespace*) – Uses argparse’s Namespace object to add additional information into the
        data section in \_path.yaml

    Returns:
    :   directory name and path as key value pairs.

    Return type:
    :   dict

cytosnake.utils.cyto\_paths.get\_project\_root() → Path[#](#cytosnake.utils.cyto_paths.get_project_root "Permalink to this definition")
:   Returns complete path where cytosnake performs the analysis. The function
    will check if .cytosnake folder exists, if not an error will be raised.

    Returns:
    :   Returns absolute path of the project folder

    Return type:
    :   Path

    Raises:
    :   **FileNotFoundError** – Raised with the current directory is not a project folder

cytosnake.utils.cyto\_paths.get\_results\_dir\_path() → Path[#](#cytosnake.utils.cyto_paths.get_results_dir_path "Permalink to this definition")
:   Returns path to results directory. This is where all the outputs generated
    from the workflow will be placed.

    Returns:
    :   absolute path to results directory

    Return type:
    :   pathlib.Path

cytosnake.utils.cyto\_paths.get\_workflow\_fpaths() → dict[#](#cytosnake.utils.cyto_paths.get_workflow_fpaths "Permalink to this definition")
:   Obtains all file paths located in the workflows folder as a dictionary.

    Returns:
    :   Structured dictionary containing directory names and paths are key value
        pairs

    Return type:
    :   dict

    Raises:
    :   **FileNotFoundError** – Raised if the file workflows directory is not found

cytosnake.utils.cyto\_paths.is\_cytosnake\_dir(*dir\_path: str | Path | None = None*) → bool[#](#cytosnake.utils.cyto_paths.is_cytosnake_dir "Permalink to this definition")
:   Checks if the current directory has been set up for cytosnake. Searches
    for the .cytosnake file in current or specified directory.

    Parameters:
    :   **dir\_path** (*Optional**[**str* *|* *Path**]*) – Path to directory. If None, current directory will be used.
        [Default=None]

    Returns:
    :   True if directory has been initialized for cytosnake, else False

    Return type:
    :   bool

## cytosnake.utils.cytosnake\_setup module[#](#module-cytosnake.utils.cytosnake_setup "Permalink to this heading")

Module: cytosnake\_setup.py

This modules sets up the current directory as a project directory. Project
directories are dictated by the presence of .cytosnake, which contains
meta data for cytosnake to use.

cytosnake.utils.cytosnake\_setup.create\_cytosnake\_dir() → None[#](#cytosnake.utils.cytosnake_setup.create_cytosnake_dir "Permalink to this definition")
:   Sets up a .cytosnake folder that contains meta information that helps
    cytosnake’s cli functionality. This will include configurations that
    contains states, paths and settings.

    Returns:
    :   * *None* – Generates a .cytosnake file in current directory
        * *Raises*
        * *FileExistsError* – Raised by pathlib.Path if [`](#id1).cytosnake’ already exists

cytosnake.utils.cytosnake\_setup.generate\_meta\_path\_configs(*args: Namespace*) → None[#](#cytosnake.utils.cytosnake_setup.generate_meta_path_configs "Permalink to this definition")
:   constructs a \_paths.yaml file that contains the necessary path
    information for file handling. this allows cytosnake to know which folders
    to look for when performing tasks.

    Returns:
    :   creates a \_paths.yaml file in the .cytosnake project directory

    Return type:
    :   none

cytosnake.utils.cytosnake\_setup.setup\_cytosnake\_env(*args: Namespace*) → None[#](#cytosnake.utils.cytosnake_setup.setup_cytosnake_env "Permalink to this definition")
:   main wrapper function that sets up current directory into a cytosnake
    project directory. this means that all the analysis being conducted within
    the current directory will allow

cytosnake.utils.cytosnake\_setup.transport\_project\_files() → None[#](#cytosnake.utils.cytosnake_setup.transport_project_files "Permalink to this definition")
:   obtains the necessary files from software package and transport them into
    current working directory

## cytosnake.utils.feature\_utils module[#](#module-cytosnake.utils.feature_utils "Permalink to this heading")

cytosnake.utils.feature\_utils.infer\_dp\_features(*dp\_profile*) → list[str][#](#cytosnake.utils.feature_utils.infer_dp_features "Permalink to this definition")
:   Returns a list of Deep profiler features found within the single cell
    dataframe

    Parameters:
    :   **dp\_profile** (*pd.DataFrame*) – dataframe features captured from deep profiler

    Returns:
    :   list of deep profiler features

    Return type:
    :   list[str]

    Raises:
    :   **ValueError** – Raised if no Deep profiler features are found within the given DataFrame

## cytosnake.utils.file\_utils module[#](#module-cytosnake.utils.file_utils "Permalink to this heading")

Module: file\_utils.py

Contains functions that involves file manipulations like:
:   * searching
    * transferring
    * creating symbolic links
    * creating and deleting files

cytosnake.utils.file\_utils.file\_search(*fpath: str | Path*) → dict[#](#cytosnake.utils.file_utils.file_search "Permalink to this definition")
:   Returns a list of all the files inside a directory

    Parameters:
    :   **fpath** (*str* *|* *Path*) – path to specific directory

    Returns:
    :   Returns a list of dir names and file paths as key value pairs

    Return type:
    :   dict

cytosnake.utils.file\_utils.find\_project\_dir(*steps: int | None = 10*) → Path | None[#](#cytosnake.utils.file_utils.find_project_dir "Permalink to this definition")
:   Recursively searches for project directory`.cytosnake` directory. If the
    directory is not found, None is returned.

    steps: Optional[int]
    :   number of recursive steps for searching. [default=10]

    Returns:
    :   * *Path* – returns path to project folder
        * *None* – if the path is unable to be found

    Raises:
    :   **FileNotFoundError** – When recursive steps are exceeded and is unable to find .cytosnake
        folder

## Module contents[#](#module-cytosnake.utils "Permalink to this heading")

[Next

generate\_sample\_inputs module](generate_sample_inputs.html)
[Previous

cytosnake.guards package](cytosnake.guards.html)

Copyright © 2022, Way Lab

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* cytosnake.utils package
  + [Submodules](#submodules)
  + [cytosnake.utils.config\_utils module](#module-cytosnake.utils.config_utils)
    - [`load_configs()`](#cytosnake.utils.config_utils.load_configs)
    - [`load_cytosnake_configs()`](#cytosnake.utils.config_utils.load_cytosnake_configs)
    - [`load_data_path_configs()`](#cytosnake.utils.config_utils.load_data_path_configs)
    - [`load_general_configs()`](#cytosnake.utils.config_utils.load_general_configs)
    - [`load_meta_path_configs()`](#cytosnake.utils.config_utils.load_meta_path_configs)
    - [`load_workflow_path()`](#cytosnake.utils.config_utils.load_workflow_path)
    - [`load_workflow_paths_config()`](#cytosnake.utils.config_utils.load_workflow_paths_config)
    - [`update_config()`](#cytosnake.utils.config_utils.update_config)
  + [cytosnake.utils.cyto\_paths module](#module-cytosnake.utils.cyto_paths)
    - [`get_benchmarks_path()`](#cytosnake.utils.cyto_paths.get_benchmarks_path)
    - [`get_config_dir_path()`](#cytosnake.utils.cyto_paths.get_config_dir_path)
    - [`get_config_fpaths()`](#cytosnake.utils.cyto_paths.get_config_fpaths)
    - [`get_cytosnake_config_path()`](#cytosnake.utils.cyto_paths.get_cytosnake_config_path)
    - [`get_cytosnake_package_path()`](#cytosnake.utils.cyto_paths.get_cytosnake_package_path)
    - [`get_meta_path()`](#cytosnak