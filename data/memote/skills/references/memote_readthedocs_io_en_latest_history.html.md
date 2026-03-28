[![](_static/memote-logo.png)](index.html)
**0.11.1**

* [Site](index.html)

  - [Installation](installation.html)
  - [Getting Started](getting_started.html)
  - [Flowchart](flowchart.html)
  - [Understanding the reports](understanding_reports.html)
  - [Experimental Data](experimental_data.html)
  - [Custom Tests](custom_tests.html)
  - [Test Suite](test_suite.html)
  - [Contributing](contributing.html)
  - [Credits](authors.html)
  - History
  - [API Reference](autoapi/index.html)
* Page

  - History
    * [Next Release](#next-release)
    * [0.14.0 (2023-09-13)](#id1)
    * [0.13.0 (2021-06-12)](#id2)
    * [0.12.1 (2021-06-12)](#id3)
    * [0.12.0 (2020-10-20)](#id4)
    * [0.11.1 (2020-08-10)](#id5)
    * [0.11.0 (2020-06-26)](#id6)
    * [0.10.2 (2020-03-24)](#id7)
    * [0.10.1 (2020-03-24)](#id8)
    * [0.10.0 (2020-03-24)](#id9)
    * [0.9.13 (2019-12-04)](#id10)
    * [0.9.11 (2019-04-23)](#id11)
    * [0.9.10 (2019-04-23)](#id12)
    * [0.9.9 (2019-04-17)](#id13)
    * [0.9.8 (2019-04-01)](#id14)
    * [0.9.7 (2019-03-29)](#id15)
    * [0.9.6 (2019-03-06)](#id16)
    * [0.9.5 (2019-02-21)](#id17)
    * [0.9.4 (2019-02-20)](#id18)
    * [0.9.3 (2019-01-30)](#id19)
    * [0.9.2 (2019-01-28)](#id20)
    * [0.9.1 (2019-01-28)](#id21)
    * [0.9.0 (2019-01-28)](#id22)
    * [0.8.11 (2019-01-07)](#id23)
    * [0.8.10 (2018-12-21)](#id24)
    * [0.8.9 (2018-12-11)](#id25)
    * [0.8.8 (2018-12-10)](#id26)
    * [0.8.7 (2018-11-21)](#id27)
    * [0.8.6 (2018-09-13)](#id28)
    * [0.8.5 (2018-08-20)](#id29)
    * [0.8.4 (2018-07-18)](#id30)
    * [0.8.3 (2018-07-16)](#id31)
    * [0.8.2 (2018-07-16)](#id32)
    * [0.8.1 (2018-06-27)](#id33)
    * [0.8.0 (2018-06-22)](#id34)
    * [0.7.6 (2018-05-28)](#id35)
    * [0.7.5 (2018-05-25)](#id36)
    * [0.7.4 (2018-05-23)](#id37)
    * [0.7.3 (2018-05-23)](#id38)
    * [0.7.2 (2018-05-22)](#id39)
    * [0.7.1 (2018-05-16)](#id40)
    * [0.7.0 (2018-05-15)](#id41)
    * [0.6.2 (2018-03-12)](#id42)
    * [0.6.1 (2018-03-01)](#id43)
    * [0.6.0 (2018-02-27)](#id44)
    * [0.5.0 (2018-01-16)](#id45)
    * [0.4.6 (2017-10-31)](#id46)
    * [0.4.5 (2017-10-09)](#id47)
    * [0.4.4 (2017-09-26)](#id48)
    * [0.4.3 (2017-09-25)](#id49)
    * [0.4.2 (2017-08-22)](#id50)
    * [0.4.1 (2017-08-22)](#id51)
    * [0.4.0 (2017-08-21)](#id52)
    * [0.3.6 (2017-08-15)](#id53)
    * [0.3.4 (2017-08-12)](#id54)
    * [0.3.3 (2017-08-12)](#id55)
    * [0.3.2 (2017-08-12)](#id56)
    * [0.3.0 (2017-08-12)](#id57)
    * [0.2.0 (2017-02-09)](#id58)
    * [0.1.0 (2017-01-30)](#id59)
* [« Credits](authors.html "Previous Chapter: Credits")
* [Source](_sources/history.rst.txt)

# History[¶](#history "Permalink to this headline")

## Next Release[¶](#next-release "Permalink to this headline")

## 0.14.0 (2023-09-13)[¶](#id1 "Permalink to this headline")

* Fix problems with the deprecated API of `importlib_resources`. Update to either use
  standard library or newer version of the package.

## 0.13.0 (2021-06-12)[¶](#id2 "Permalink to this headline")

* Fix logic errors with orphan and dead-end metabolite detection. This problem
  could occur with irreversible reactions whose bounds constrain flux to the
  reverse direction.

## 0.12.1 (2021-06-12)[¶](#id3 "Permalink to this headline")

* Fix problems with spreadsheet parser. Now supports `.xls`, `.xlsx`, and `.ods`.
* Fix a bug with models whose biomass optimization is infeasible.

## 0.12.0 (2020-10-20)[¶](#id4 "Permalink to this headline")

* Fix bug caused from upstream changes -> cobrapy -> pandas.
* Refactor stoichiometric consistency test into 3 separate ones.

## 0.11.1 (2020-08-10)[¶](#id5 "Permalink to this headline")

* Change the logic for identifying biomass reactions to be less eager.
* Fix failing excel reader.

## 0.11.0 (2020-06-26)[¶](#id6 "Permalink to this headline")

* Fix an issue where experimental growth was incorrectly not reported.
* Allow the user to set a threshold value for growth in experimental data.
* Fix and enable the consistency test for minimal unconservable sets.

## 0.10.2 (2020-03-24)[¶](#id7 "Permalink to this headline")

* Correct the names of parametrized experiments.

## 0.10.1 (2020-03-24)[¶](#id8 "Permalink to this headline")

* Make the confusion matrix computation more robust.

## 0.10.0 (2020-03-24)[¶](#id9 "Permalink to this headline")

* Fix an issue where experimental data was not loaded.
* Enable command line options for solver timeouts.
* Setting the log level to DEBUG now also enables the solver log output.

## 0.9.13 (2019-12-04)[¶](#id10 "Permalink to this headline")

* Improve the biomass reaction finding logic.
* Explicitly register custom markers biomass, essentiality and growth
  used for custom test parametrization in pytest.
* Fix logic for consistency tests of production and consumption of
  metabolites with open bounds. It allows multiprocessing, currently relying on
  cobra.Configuration to select the number of processors.

## 0.9.11 (2019-04-23)[¶](#id11 "Permalink to this headline")

* Pin cobrapy version to <= 0.14.2 (because cobra==0.15.1,0.15.2 SBML parsing
  is broken).

## 0.9.10 (2019-04-23)[¶](#id12 "Permalink to this headline")

* Pin cobrapy version to 0.14.2 (because cobra==0.15.1,0.15.2 SBML parsing
  is broken).

## 0.9.9 (2019-04-17)[¶](#id13 "Permalink to this headline")

* Include memote’s requirement for git on installation instructions.
* Check for the presence of git in CLI commands that require it.
* Replace vega with taucharts in all reports.
* Fix plots to be large enough.
* Fix responsive behaviour.
* Add clear axis labels and understandable titles.
* Add an option to save all plots to png, json and csv.
* Color code the category plots just like the results buttons
  on the snapshot report.
* Fix the data that is displayed in the independent an specific sections
  of the history report.
* Invert metrices and display as percentages.
* Add hover-over tooltips for all plots.
* Implement lazy loading for all the reports, meaning that the content of
  an expansion panel in any of the reports is only rendered when it is open.
* Fix the reactions with identical genes test case to not group all reactions
  without any GPR together.
* Enable CI on Appveyor (unit tests on Windows as opposed to linux which we do
  on Travis).
* Replace any commit operations through gitpython with direct subprocess
  invocations of git.
* Regenerate the mock repo we use in some tests so that filemode changes are
  ignored by default.

## 0.9.8 (2019-04-01)[¶](#id14 "Permalink to this headline")

* Repair memote online which would not get the most up-to-date status when
  checking whether a repo had already been activate for testing on Travis CI.
* Pin travis-encode due to conflicts in dependency on click with
  goodtables and jsonschema.

## 0.9.7 (2019-03-29)[¶](#id15 "Permalink to this headline")

* Repair the experimental testing and add a test case for the runner with
  experimental data.
* Update docstring of test\_find\_duplicate\_reactions.
* Add a guide explaining the structure of and how to interpret the memote
  reports.
* Add guidelines on writing custom tests to the documentation.
* Add unit tests to the CLI workflow.
* Remove dependency on GitHub and Travis API wrappers, make calls through
  python requests.
* Fix bugs in memote

## 0.9.6 (2019-03-06)[¶](#id16 "Permalink to this headline")

* The number of duplicated reactions is now reported uniquely rather than all
  duplicate pairs.

## 0.9.5 (2019-02-21)[¶](#id17 "Permalink to this headline")

* Add missing parametrized metric on `test_biomass_open_production`.

## 0.9.4 (2019-02-20)[¶](#id18 "Permalink to this headline")

* Add metrics, i.e., model-size independent test outcomes to almost all test
  cases.
* Repair auto generation of API docs and update section on test suite.
* Remove our dependecy on PyGithub and TravisPy by reimplementing all the
  necessary steps with requests
* Add unit and integration tests for runner.py and reports.py, except
  for memote online.
* Debug memote online - could only be tested manually, CI is impossible
  without a secure way of storing github credentials.
* Add logging statements to all CLI functions to facilitate future debugging.

## 0.9.3 (2019-01-30)[¶](#id19 "Permalink to this headline")

* Enhance the function for finding unique metabolites and make it more robust.
* Improve logging output when there is a problem with serializing a result to
  JSON.
* Fix some test cases that got broken by cobrapy’s new boundary identification.

## 0.9.2 (2019-01-28)[¶](#id20 "Permalink to this headline")

* Fix bug that would lead to biomass SBO annotations not being reported.

## 0.9.1 (2019-01-28)[¶](#id21 "Permalink to this headline")

* Add `seed.reaction` namespace to the reaction annotation databases.

## 0.9.0 (2019-01-28)[¶](#id22 "Permalink to this headline")

* Change SBO annotation tests to check for multiple terms until we can properly
  handle the ontology.
* Remove ‘Steady-state flux solution vectors’ test case.
* Improve the descriptions of stoichiometric matrix test cases.
* Fix the discovery or orphan and dead-end metabolites.
* Improve detection of metabolites that are not consumed or not produced by
  only opening exchange reactions not other boundary reactions.
* Thematically reorganize the test cases in the config.
* Instead of min/max bounds consider the median bounds for testing (un-)bounded
  fluxes.
* Use a model context for every test case.
* Fix bug which involved find\_transport\_reactions to ignore compartments.
* Internal change to use model context rather than copy.
* Internal changes to JSON structure.
* Remove tests for metabolite inconsistency with closed bounds. The results
  are a subset only of the unconserved metabolites.
* Make the consistency tests account better for numeric instability.
* Add the GLPK exact solver as a possible option.
* Update memote-report-app from Angular 5.1.0 to 7.2.0.
* Reduce the prominence of the total score in the reports.
* Provide partial calculations for each section.
* Show overall formula of how the total score is calculated.
* Clearly indicate weights/ multipliers by introducing margenta badges next to each test in the report.
* In the reports, improve the descriptions of the ‘Help’ section and rename this section to ‘Readme’.
* Rename the principal sections and include a brief explanation for each.
* Fix bug that would show a test as ‘Errored’ although it only failed. Fixed by making condition in errorFailsafe
  in test-result.model.ts more specific for cases where data is undefined or null.
* Fix bug that would make parametrized tests disappear from the report if they had errored or if for some reason their ‘data’ attribute
  was undefined.
* Unpin pytest (require >= 4.0) and adjust some internal mechanics accordingly.
* Display an alternative message if some biomass components do not contain a
  formula.
* Extend the annotations tests by a check for full length InChI strings.
* Fix a bug in `Unrealistic Growth Rate In Default Medium` which reported the
  opposite of what was the case.
* Extend the description of each test by a description of how it is
  implemented.
* Refactor test that identifies duplicate reactions to take into metabolites,
  reaction directionality and compartments into account.
* Add additional tests that identify reactions having identical annotations and
  identical genes.
* Refactor test that identifies duplicate metabolites to use for inchi
  strings in addition to inchikeys.
* Round score to and display a single decimal value.
* Fix bug that would show a test as errored whenever it was marked as skipped.
* Read SBML files with modified parser that can collect the level, version and
  whether the FBC package is used.
* Validate the SBML structure with the libSBML python API if the parser errors
  and produce a simple SBML validation report.
* Add test cases that report on the level and version, and FBC availability
  through the memote reports.

## 0.8.11 (2019-01-07)[¶](#id23 "Permalink to this headline")

* Temporarily pin pytest to <4.1 in order to avoid a breaking API change on their part.

## 0.8.10 (2018-12-21)[¶](#id24 "Permalink to this headline")

* Refactor the test for enzyme complexes to only return an estimated size.

## 0.8.9 (2018-12-11)[¶](#id25 "Permalink to this headline")

* Compress JSON and SQLite storage of results using gzip by default. JSON
  continues to work either compressed or uncompressed. At the moment we
  offer no database migration, please contact us if you need help in
  migrating a large existing SQLite database rather than just re-computing it.

## 0.8.8 (2018-12-10)[¶](#id26 "Permalink to this headline")

* Adjust the reversibility index test to not use name matching and increase
  the threshold slightly. Also adjust the description of the test.
* Adjust tests to the change in the `add_boundary` interface.
* Identify blocked reactions using the cobrapy built-in function.

## 0.8.7 (2018-11-21)[¶](#id27 "Permalink to this headline")

* Add a feature to allow suppling a commit range to `memote history`.
* Add a test that checks if reactions are annotated with reactome identifiers.
* Add a feature that allows identifying specific metabolites by matching
  annotation information against the metabolite shortlist for a given MNX ID.
* Change every usage of SBO key to lower case to conform to the identifiers.org
  namespace for the Systems Biology Ontology.
* Remove that metabolite SBO terms are used when identifying transport
  reactions as this may lead to false positives.
* Return metabolite IDs when finding duplicate metabolites to avoid
  serialization errors.
* Identify transport reactions first by formula then by annotation.
* For the diff report, run pytest in different processes to avoid accidentally
  overwriting the results of the former with the results of the later runs.
* In the diff report, fix a typo that allowed the diff button to depart the
  defined colour scheme (blue -> red) to cyan.
* Fix the snapshot report not showing environment information.
* Allow `memote run` to skip commits where the model was not
  changed, if the flag `--skip-unchanged` is provided.
* Fix the default value of the overall score to be zero instead of one and
  make sure that the calculation is ensured with unit tests.
* Fix medium and experiment loading
* Add a test to check reaction directionality with thermodynamic estimation
  from eQuilibrator API.

## 0.8.6 (2018-09-13)[¶](#id28 "Permalink to this headline")

* Fix test titles and descriptions.

## 0.8.5 (2018-08-20)[¶](#id29 "Permalink to this headline")

* Unpin cobra dependency and set it to >0.13.3.
* Set ruamel.yaml to >=0.15 to keep up with cobra.

## 0.8.4 (2018-07-18)[¶](#id30 "Permalink to this headline")

* Handle various pytest verbosity options better.
* Improve `memote new` behavior.

## 0.8.3 (2018-07-16)[¶](#id31 "Permalink to this headline")

* `memote run` in a repository now immediately 