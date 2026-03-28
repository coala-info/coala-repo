[![](../../_static/memote-logo.png)](../../index.html)
**0.11.1**

* [Site](../../index.html)

  - [Installation](../../installation.html)
  - [Getting Started](../../getting_started.html)
  - [Flowchart](../../flowchart.html)
  - [Understanding the reports](../../understanding_reports.html)
  - [Experimental Data](../../experimental_data.html)
  - [Custom Tests](../../custom_tests.html)
  - [Test Suite](../../test_suite.html)
  - [Contributing](../../contributing.html)
  - [Credits](../../authors.html)
  - [History](../../history.html)
  - [API Reference](../index.html)
* Page

  - `memote`
    * [Subpackages](#subpackages)
    * [Submodules](#submodules)
    * [Package Contents](#package-contents)
      + [Classes](#classes)
      + [Functions](#functions)
        - [\_\_author\_\_](#memote.__author__)
        - [\_\_email\_\_](#memote.__email__)
        - [get\_versions](#memote.get_versions)
        - [\_\_version\_\_](#memote.__version__)
        - [show\_versions](#memote.show_versions)
        - [validate\_model](#memote.validate_model)
        - [test\_model](#memote.test_model)
        - [snapshot\_report](#memote.snapshot_report)
        - [diff\_report](#memote.diff_report)
        - [history\_report](#memote.history_report)
        - [MemoteResult](#memote.MemoteResult)
          * [add\_environment\_information](#memote.MemoteResult.add_environment_information)
        - [ResultManager](#memote.ResultManager)
          * [store](#memote.ResultManager.store)
          * [load](#memote.ResultManager.load)
        - [RepoResultManager](#memote.RepoResultManager)
          * [record\_git\_info](#memote.RepoResultManager.record_git_info)
          * [get\_filename](#memote.RepoResultManager.get_filename)
          * [add\_git](#memote.RepoResultManager.add_git)
          * [store](#memote.RepoResultManager.store)
          * [load](#memote.RepoResultManager.load)
        - [SQLResultManager](#memote.SQLResultManager)
          * [store](#memote.SQLResultManager.store)
          * [load](#memote.SQLResultManager.load)
        - [HistoryManager](#memote.HistoryManager)
          * [build\_branch\_structure](#memote.HistoryManager.build_branch_structure)
          * [iter\_branches](#memote.HistoryManager.iter_branches)
          * [iter\_commits](#memote.HistoryManager.iter_commits)
          * [load\_history](#memote.HistoryManager.load_history)
          * [get\_result](#memote.HistoryManager.get_result)
          * [\_\_contains\_\_](#memote.HistoryManager.__contains__)
        - [ReportConfiguration](#memote.ReportConfiguration)
          * [load](#memote.ReportConfiguration.load)
          * [merge](#memote.ReportConfiguration.merge)
        - [Report](#memote.Report)
          * [render\_json](#memote.Report.render_json)
          * [render\_html](#memote.Report.render_html)
          * [get\_configured\_tests](#memote.Report.get_configured_tests)
          * [determine\_miscellaneous\_tests](#memote.Report.determine_miscellaneous_tests)
          * [compute\_score](#memote.Report.compute_score)
        - [LOGGER](#memote.LOGGER)
        - [SnapshotReport](#memote.SnapshotReport)
        - [HistoryReport](#memote.HistoryReport)
          * [collect\_history](#memote.HistoryReport.collect_history)
        - [DiffReport](#memote.DiffReport)
          * [format\_and\_score\_diff\_data](#memote.DiffReport.format_and_score_diff_data)
        - [MemoteExtension](#memote.MemoteExtension)
          * [tags](#memote.MemoteExtension.tags)
          * [normalize](#memote.MemoteExtension.normalize)
* [Source](../../_sources/autoapi/memote/index.rst.txt)

# [`memote`](#module-memote "memote")[¶](#module-memote "Permalink to this headline")

(me)tabolic (mo)del (te)sts.

The memote Python package is a community-driven effort towards a standardized
genome-scale metabolic model test suite.

## Subpackages[¶](#subpackages "Permalink to this headline")

* [`memote.experimental`](experimental/index.html)
  + [`memote.experimental.schemata`](experimental/schemata/index.html)
  + [`memote.experimental.checks`](experimental/checks/index.html)
  + [`memote.experimental.config`](experimental/config/index.html)
  + [`memote.experimental.essentiality`](experimental/essentiality/index.html)
  + [`memote.experimental.experiment`](experimental/experiment/index.html)
  + [`memote.experimental.experimental_base`](experimental/experimental_base/index.html)
  + [`memote.experimental.growth`](experimental/growth/index.html)
  + [`memote.experimental.medium`](experimental/medium/index.html)
  + [`memote.experimental.tabular`](experimental/tabular/index.html)
* [`memote.suite`](suite/index.html)
  + [`memote.suite.cli`](suite/cli/index.html)
    - [`memote.suite.cli.callbacks`](suite/cli/callbacks/index.html)
    - [`memote.suite.cli.config`](suite/cli/config/index.html)
    - [`memote.suite.cli.reports`](suite/cli/reports/index.html)
    - [`memote.suite.cli.runner`](suite/cli/runner/index.html)
  + [`memote.suite.reporting`](suite/reporting/index.html)
    - [`memote.suite.reporting.config`](suite/reporting/config/index.html)
    - [`memote.suite.reporting.diff`](suite/reporting/diff/index.html)
    - [`memote.suite.reporting.history`](suite/reporting/history/index.html)
    - [`memote.suite.reporting.report`](suite/reporting/report/index.html)
    - [`memote.suite.reporting.snapshot`](suite/reporting/snapshot/index.html)
  + [`memote.suite.results`](suite/results/index.html)
    - [`memote.suite.results.history_manager`](suite/results/history_manager/index.html)
    - [`memote.suite.results.models`](suite/results/models/index.html)
    - [`memote.suite.results.repo_result_manager`](suite/results/repo_result_manager/index.html)
    - [`memote.suite.results.result`](suite/results/result/index.html)
    - [`memote.suite.results.result_manager`](suite/results/result_manager/index.html)
    - [`memote.suite.results.sql_result_manager`](suite/results/sql_result_manager/index.html)
  + [`memote.suite.templates`](suite/templates/index.html)
  + [`memote.suite.api`](suite/api/index.html)
  + [`memote.suite.collect`](suite/collect/index.html)
* [`memote.support`](support/index.html)
  + [`memote.support.data`](support/data/index.html)
  + [`memote.support.annotation`](support/annotation/index.html)
  + [`memote.support.basic`](support/basic/index.html)
  + [`memote.support.biomass`](support/biomass/index.html)
  + [`memote.support.consistency`](support/consistency/index.html)
  + [`memote.support.consistency_helpers`](support/consistency_helpers/index.html)
  + [`memote.support.essentiality`](support/essentiality/index.html)
  + [`memote.support.gpr_helpers`](support/gpr_helpers/index.html)
  + [`memote.support.helpers`](support/helpers/index.html)
  + [`memote.support.matrix`](support/matrix/index.html)
  + [`memote.support.sbo`](support/sbo/index.html)
  + [`memote.support.thermodynamics`](support/thermodynamics/index.html)
  + [`memote.support.validation`](support/validation/index.html)

## Submodules[¶](#submodules "Permalink to this headline")

* [`memote._version`](_version/index.html)
* [`memote.jinja2_extension`](jinja2_extension/index.html)
* [`memote.utils`](utils/index.html)

## Package Contents[¶](#package-contents "Permalink to this headline")

### Classes[¶](#classes "Permalink to this headline")

|  |  |
| --- | --- |
| [`MemoteResult`](#memote.MemoteResult "memote.MemoteResult") | Collect the metabolic model test suite results. |
| [`ResultManager`](#memote.ResultManager "memote.ResultManager") | Manage storage of results to JSON files. |
| [`RepoResultManager`](#memote.RepoResultManager "memote.RepoResultManager") | Manage storage of results to JSON files. |
| [`SQLResultManager`](#memote.SQLResultManager "memote.SQLResultManager") | Manage storage of results to a database. |
| [`HistoryManager`](#memote.HistoryManager "memote.HistoryManager") | Manage access to results in the commit history of a git repository. |
| [`ReportConfiguration`](#memote.ReportConfiguration "memote.ReportConfiguration") | Collect the metabolic model test suite results. |
| [`Report`](#memote.Report "memote.Report") | Determine the abstract report interface. |
| [`SnapshotReport`](#memote.SnapshotReport "memote.SnapshotReport") | Render a one-time report from the given model results. |
| [`HistoryReport`](#memote.HistoryReport "memote.HistoryReport") | Render a rich report using the git repository history. |
| [`DiffReport`](#memote.DiffReport "memote.DiffReport") | Render a report displaying the results of two or more models side-by-side. |
| [`MemoteExtension`](#memote.MemoteExtension "memote.MemoteExtension") | Provide an absolute path to a file. |

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`get_versions`](#memote.get_versions "memote.get_versions")() | Get version information or return default if unable to do so. |
| [`show_versions`](#memote.show_versions "memote.show_versions")() | Print formatted dependency information to stdout. |
| [`validate_model`](#memote.validate_model "memote.validate_model")(path) | Validate a model structurally and optionally store results as JSON. |
| [`test_model`](#memote.test_model "memote.test_model")(model, sbml\_version=None, results=False, pytest\_args=None, exclusive=None, skip=None, experimental=None, solver\_timeout=10) | Test a model and optionally store results as JSON. |
| [`snapshot_report`](#memote.snapshot_report "memote.snapshot_report")(result, config=None, html=True) | Generate a snapshot report from a result set and configuration. |
| [`diff_report`](#memote.diff_report "memote.diff_report")(diff\_results, config=None, html=True) | Generate a diff report from a result set and configuration. |
| [`history_report`](#memote.history_report "memote.history_report")(history, config=None, html=True) | Test a model and save a history report. |

`memote.``__author__` *= Moritz E. Beber*[[source]](../../_modules/memote.html#__author__)[¶](#memote.__author__ "Permalink to this definition")

`memote.``__email__` *= midnighter@posteo.net*[[source]](../../_modules/memote.html#__email__)[¶](#memote.__email__ "Permalink to this definition")

`memote.``get_versions`()[[source]](../../_modules/memote/_version.html#get_versions)[¶](#memote.get_versions "Permalink to this definition")
:   Get version information or return default if unable to do so.

`memote.``__version__`[[source]](../../_modules/memote.html#__version__)[¶](#memote.__version__ "Permalink to this definition")

`memote.``show_versions`()[[source]](../../_modules/memote/utils.html#show_versions)[¶](#memote.show_versions "Permalink to this definition")
:   Print formatted dependency information to stdout.

`memote.``validate_model`(*path*)[[source]](../../_modules/memote/suite/api.html#validate_model)[¶](#memote.validate_model "Permalink to this definition")
:   Validate a model structurally and optionally store results as JSON.

    |  |  |
    | --- | --- |
    | Parameters: | **path**  Path to model file. |
    | Returns: | tuple  cobra.Model  The metabolic model under investigation.  tuple  A tuple reporting on the SBML level, version, and FBC package version used (if any) in the SBML document.  dict  A simple dictionary containing a list of errors and warnings. |

`memote.``test_model`(*model*, *sbml\_version=None*, *results=False*, *pytest\_args=None*, *exclusive=None*, *skip=None*, *experimental=None*, *solver\_timeout=10*)[[source]](../../_modules/memote/suite/api.html#test_model)[¶](#memote.test_model "Permalink to this definition")
:   Test a model and optionally store results as JSON.

    |  |  |
    | --- | --- |
    | Parameters: | **model** : cobra.Model  The metabolic model under investigation.  **sbml\_version: tuple, optional**  A tuple reporting on the level, version, and FBC use of the SBML file.  **results** : bool, optional  Whether to return the results in addition to the return code.  **pytest\_args** : list, optional  Additional arguments for the pytest suite.  **exclusive** : iterable, optional  Names of test cases or modules to run and exclude all others. Takes precedence over `skip`.  **skip** : iterable, optional  Names of test cases or modules to skip.  **solver\_timeout: int, optional**  Timeout in seconds to set on the mathematical optimization solver (default 10). |
    | Returns: | int  The return code of the pytest suite.  memote.Result, optional  A nested dictionary structure that contains the complete test results. |

`memote.``snapshot_report`(*result*, *config=None*, *html=True*)[[source]](../../_modules/memote/suite/api.html#snapshot_report)[¶](#memote.snapshot_report "Permalink to this definition")
:   Generate a snapshot report from a result set and configuration.

    |  |  |
    | --- | --- |
    | Parameters: | **result** : memote.MemoteResult  Nested dictionary structure as returned from the test suite.  **config** : dict, optional  The final test report configuration (default None).  **html** : bool, optional  Whether to render the report as full HTML or JSON (default True). |

`memote.``diff_report`(*diff\_results*, *config=None*, *html=True*)[[source]](../../_modules/memote/suite/api.html#diff_report)[¶](#memote.diff_report "Permalink to this definition")
:   Generate a diff report from a result set and configuration.

    |  |  |
    | --- | --- |
    | Parameters: | **diff\_results** : iterable of memote.MemoteResult  Nested dictionary structure as returned from the test suite.  **config** : dict, optional  The final test report configuration (default None).  **html** : bool, optional  Whether to render the report as full HTML or JSON (default True). |

`memote.``history_report`(*history*, *config=None*, *html=True*)[[source]](../../_modules/memote/suite/api.html#history_report)[¶](#memote.history_report "Permalink to this definition")
:   Test a model and save a history report.

    |  |  |
    | --- | --- |
    | Parameters: | **history** : memote.HistoryManager  The manager grants access to previous results.  **config** : dict, optional  The final test report configuration.  **html** : bool, optional  Whether to render the report as full HTML or JSON (default True). |

*class* `memote.``MemoteResult`(*\*args*, *\*\*kwargs*)[¶](#memote.MemoteResult "Permalink to this definition")
:   Bases: `dict`

    Collect the metabolic model test suite results.

    *static* `add_environment_information`(*meta*)[¶](#memote.MemoteResult.add_environment_information "Permalink to this definition")
    :   Record environment information.

*class* `memote.``ResultManager`(*\*\*kwargs*)[¶](#memote.ResultManager "Permalink to this definition")
:   Bases: `object`

    Manage storage of results to JSON files.

    `store`(*self*, *result*, *filename*, *pretty=True*)[¶](#memote.ResultManager.store "Permalink to this definition")
    :   Write a result to the given file.

        |  |  |
        | --- | --- |
        | Parameters: | **result** : memote.MemoteResult  The dictionary