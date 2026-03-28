[Ephemeris](index.html)

* [Introduction](readme.html)
* [Installation](installation.html)
* [Commands](commands.html)
* [Code of conduct](conduct.html)
* [Contributing](contributing.html)
* [Project Governance](organization.html)
* [Release Checklist](developing.html)
* History
  + [0.10.11 (2025-09-26)](#id1)
  + [0.10.10 (2024-02-01)](#id2)
  + [0.10.9 (2024-01-31)](#id3)
  + [0.10.8 (2023-04-18)](#id4)
  + [0.10.7 (2021-06-08)](#id5)
  + [0.10.6 (2020-05-04)](#id6)
  + [0.10.5 (2020-02-29)](#id7)
  + [0.10.4 (2019-10-05)](#id8)
  + [0.10.3 (2019-07-18)](#id9)
  + [0.10.2 (2019-06-04)](#id10)
  + [0.10.1 (2019-06-04)](#id11)
  + [0.10.0 (2019-05-29)](#id12)
  + [0.9.0 (2018-05-23)](#id13)
  + [0.8.0 (2017-12-29)](#id14)
  + [0.7.0 (2017-06-27)](#id15)
  + [0.6.1 (2017-04-17)](#id16)
  + [0.6.0 (2017-04-10)](#id17)
  + [0.5.1 (2017-04-07)](#id18)
  + [0.5.0 (2017-04-06)](#id19)
  + [0.4.0 (2016-09-07)](#id24)
  + [0.3.0 (2016-08-26)](#id25)
  + [0.2.0 (2016-08-15)](#id26)
  + [0.1.0 (2016-06-15)](#id27)

[Ephemeris](index.html)

* History
* [View page source](_sources/history.rst.txt)

---

# History[¶](#history "Link to this heading")

## 0.10.11 (2025-09-26)[¶](#id1 "Link to this heading")

* remove the duplicated argument for installing resolver deps (thanks to
  [@martenson](https://github.com/martenson)). [Pull Request 222](https://github.com/galaxyproject/ephemeris/pull/222)
* Test python 3.12 (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 220](https://github.com/galaxyproject/ephemeris/pull/220)

## 0.10.10 (2024-02-01)[¶](#id2 "Link to this heading")

* Use None default value where items are optional (thanks to [@mvdbeek](https://github.com/mvdbeek)).
  [Pull Request 212](https://github.com/galaxyproject/ephemeris/pull/212)

## 0.10.9 (2024-01-31)[¶](#id3 "Link to this heading")

* Fix CI tests (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 208](https://github.com/galaxyproject/ephemeris/pull/208)
* Add black, ruff, isort and mypy (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 209](https://github.com/galaxyproject/ephemeris/pull/209)
* Add now mandatory readthedocs config file (thanks to [@nsoranzo](https://github.com/nsoranzo)). [Pull
  Request 210](https://github.com/galaxyproject/ephemeris/pull/210)
* Enhancements to the IDC scripts (thanks to [@jmchilton](https://github.com/jmchilton)). [Pull Request
  201](https://github.com/galaxyproject/ephemeris/pull/201)

## 0.10.8 (2023-04-18)[¶](#id4 "Link to this heading")

* Prefer dashes instead of underscores in flags (thanks to [@natefoo](https://github.com/natefoo)). [Pull
  Request 191](https://github.com/galaxyproject/ephemeris/pull/191)
* Remove folder id from get\_folders function call in setup-data-libraries
  (thanks to [@sanjaysrikakulam](https://github.com/sanjaysrikakulam)). [Pull Request 196](https://github.com/galaxyproject/ephemeris/pull/196)
* Standardize CLI commands on - instead of \_ (thanks to [@hexylena](https://github.com/hexylena)). [Pull
  Request 195](https://github.com/galaxyproject/ephemeris/pull/195)
* Add partial type annotations (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 193](https://github.com/galaxyproject/ephemeris/pull/193)
* Rename configuration option removed in tox 4.0 (thanks to [@nsoranzo](https://github.com/nsoranzo)).
  [Pull Request 190](https://github.com/galaxyproject/ephemeris/pull/190)
* Set Library Permissions (thanks to [@mira-miracoli](https://github.com/mira-miracoli)). [Pull Request 187](https://github.com/galaxyproject/ephemeris/pull/187)
* delete the extra random sleep lines from sleep.py (thanks to [@cat-bro](https://github.com/cat-bro)).
  [Pull Request 171](https://github.com/galaxyproject/ephemeris/pull/171)

## 0.10.7 (2021-06-08)[¶](#id5 "Link to this heading")

* Add option to shed-tools test for specifying a history name (thanks to
  [@natefoo](https://github.com/natefoo)). [Pull Request 173](https://github.com/galaxyproject/ephemeris/pull/173)
* workflow-to-tools: get tools from subworkflows (thanks to [@cat-bro](https://github.com/cat-bro)).
  [Pull Request 170](https://github.com/galaxyproject/ephemeris/pull/170)
* Add pysam and continue if test fetching errors (thanks to [@mvdbeek](https://github.com/mvdbeek)).
  [Pull Request 128](https://github.com/galaxyproject/ephemeris/pull/128)
* Various updates to testing and CI infrastructure (thanks to [@jmchilton](https://github.com/jmchilton)).
  [Pull Request 165](https://github.com/galaxyproject/ephemeris/pull/165)
* Handle terminal states in wait for install (thanks to [@mvdbeek](https://github.com/mvdbeek)).
  [Pull Request 161](https://github.com/galaxyproject/ephemeris/pull/161)
* Get all tools when searching for tool ids for testing
  (thanks to [@cat-bro](https://github.com/cat-bro)). [Pull Request 159](https://github.com/galaxyproject/ephemeris/pull/159)

## 0.10.6 (2020-05-04)[¶](#id6 "Link to this heading")

* Wait for the correct repository (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull
  Request 158](https://github.com/galaxyproject/ephemeris/pull/158)
* Update dependencies

## 0.10.5 (2020-02-29)[¶](#id7 "Link to this heading")

* Fix shed-tools test -t workflow\_tools.yml (thanks to [@nsoranzo](https://github.com/nsoranzo)). [Pull
  Request 155](https://github.com/galaxyproject/ephemeris/pull/155)
* Fix installing tool dependencies from yaml list (thanks to [@mvdbeek](https://github.com/mvdbeek)).
  [Pull Request 154](https://github.com/galaxyproject/ephemeris/pull/154)
* Cast exceptions to string using unicodify (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull
  Request 150](https://github.com/galaxyproject/ephemeris/pull/150)
* Add description when creating folders with setup\_data\_libraries (thanks to
  [@abretaud](https://github.com/abretaud)). [Pull Request 149](https://github.com/galaxyproject/ephemeris/pull/149)

## 0.10.4 (2019-10-05)[¶](#id8 "Link to this heading")

* When polling for repo install status, ensure the correct revision is being
  checked (thanks to [@natefoo](https://github.com/natefoo)). [Pull Request 146](https://github.com/galaxyproject/ephemeris/pull/146)
* Add install\_tool\_deps command (thanks to [@innovate-invent](https://github.com/innovate-invent)). [Pull Request
  145](https://github.com/galaxyproject/ephemeris/pull/145)

## 0.10.3 (2019-07-18)[¶](#id9 "Link to this heading")

* Add install-tool-deps command that will install tool dependencies
  (thanks to [@innovate-invent](https://github.com/innovate-invent)). [Pull Request 130](https://github.com/galaxyproject/ephemeris/pull/130)
* Require galaxy-tool-util instead of galaxy-lib (thanks to [@nsoranzo](https://github.com/nsoranzo)).
  [Pull Request 143](https://github.com/galaxyproject/ephemeris/pull/143)
* Release to PyPI on tag (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 142](https://github.com/galaxyproject/ephemeris/pull/142)
* Make Data library creation more robust
  (thanks to [@erasche](https://github.com/erasche)). [Pull Request 138](https://github.com/galaxyproject/ephemeris/pull/138)
* Make tool testing more robust (thanks to
  [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 137](https://github.com/galaxyproject/ephemeris/pull/137), [Pull Request 136](https://github.com/galaxyproject/ephemeris/pull/136)

## 0.10.2 (2019-06-04)[¶](#id10 "Link to this heading")

* Fix default message check (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 135](https://github.com/galaxyproject/ephemeris/pull/135)

## 0.10.1 (2019-06-04)[¶](#id11 "Link to this heading")

* Fix timeout handling when installing repositories
  (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 134](https://github.com/galaxyproject/ephemeris/pull/134)

## 0.10.0 (2019-05-29)[¶](#id12 "Link to this heading")

* fix doc building and regenerate (thanks to [@martenson](https://github.com/martenson)). [Pull Request
  129](https://github.com/galaxyproject/ephemeris/pull/129)
* fix default for ‘parallel\_tests’ typo (thanks to [@martenson](https://github.com/martenson)). [Pull
  Request 127](https://github.com/galaxyproject/ephemeris/pull/127)
* Include some additional stats for xunit reporting (thanks to [@mvdbeek](https://github.com/mvdbeek)).
  [Pull Request 126](https://github.com/galaxyproject/ephemeris/pull/126)
* Handle timeout gracefully for UWSGI connection (thanks to [@pcm32](https://github.com/pcm32)). [Pull
  Request 123](https://github.com/galaxyproject/ephemeris/pull/123)
* Update Docs for User Name (Should be Email) (thanks to [@rdvelazquez](https://github.com/rdvelazquez)).
  [Pull Request 122](https://github.com/galaxyproject/ephemeris/pull/122)
* remove the python invocation from usage examples (thanks to [@martenson](https://github.com/martenson)).
  [Pull Request 121](https://github.com/galaxyproject/ephemeris/pull/121)
* Fix crash when too\_with\_panel is empty (thanks to [@jvanbraekel](https://github.com/jvanbraekel)). [Pull
  Request 120](https://github.com/galaxyproject/ephemeris/pull/120)
* Test tools in parallel, with regular user permissions, without a shared
  filesystem (thanks to [@mvdbeek](https://github.com/mvdbeek)). [Pull Request 118](https://github.com/galaxyproject/ephemeris/pull/118)
* use latest documentation dependencies to fix documentation build issue
  (thanks to [@rhpvorderman](https://github.com/rhpvorderman)). [Pull Request 114](https://github.com/galaxyproject/ephemeris/pull/114)
* Refactor shed tool functionality. Removed deprecated options from
  shed-tools CLI.
  shed-tools update now also accepts tool list, so tools in galaxy can
  be selectively updated. Improved algorithm leads to much faster
  skipping of already installed tools, which makes the installation
  of tools much faster on an already populated galaxy.
  (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 104](https://github.com/galaxyproject/ephemeris/pull/104)
* Add `pytest`, enable coverage testing (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 105](https://github.com/galaxyproject/ephemeris/pull/105)
* Make `setup_data_libraries.py` check for existence before recreation of
  libraries.
  (thanks to [@Slugger70](https://github.com/Slugger70)).
  [Pull Request 103](https://github.com/galaxyproject/ephemeris/pull/103)
* Catch failures on requests to the installed repo list when doing post-
  timeout spinning on installation in `shed-tools` (thanks to [@natefoo](https://github.com/natefoo)).
  [Pull Request 97](https://github.com/galaxyproject/ephemeris/pull/97)
* Fix coverage reporting on codacy (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 106](https://github.com/galaxyproject/ephemeris/pull/106)
* Run-data-managers now outputs stderr of failed jobs (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 110](https://github.com/galaxyproject/ephemeris/pull/110)

## 0.9.0 (2018-05-23)[¶](#id13 "Link to this heading")

* Update data managers when updating tools (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 78](https://github.com/galaxyproject/ephemeris/pull/78), [Issue 69](https://github.com/galaxyproject/ephemeris/issues/69)
* Run data managers aggressive parallelization and refactoring (thanks to
  [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 79](https://github.com/galaxyproject/ephemeris/pull/79)
* Makes publishing of imported workflows available (thanks to [@pcm32](https://github.com/pcm32)).
  [Pull Request 74](https://github.com/galaxyproject/ephemeris/pull/74)
* Add option to test tools on update/install for Galaxy 18.05 (thanks to [@jmchilton](https://github.com/jmchilton)).
  [Pull Request 81](https://github.com/galaxyproject/ephemeris/pull/81)
* Upload 2.0 support for data library creation (thanks to [@jmchilton](https://github.com/jmchilton)).
  [Pull Request 89](https://github.com/galaxyproject/ephemeris/pull/89)
* Fixes to revision parsing in tools.yaml (thanks to [@bgruening](https://github.com/bgruening)).
  [Pull Request 70](https://github.com/galaxyproject/ephemeris/pull/70)
* Add Codacy monitoring and badge (thanks to [@jmchilton](https://github.com/jmchilton)).
  [Pull Request 73](https://github.com/galaxyproject/ephemeris/pull/73)
* Fix typo in project organization document (thanks to [@blankenberg](https://github.com/blankenberg)).
  [Pull Request 86](https://github.com/galaxyproject/ephemeris/pull/86)
* Fix hardcoded log paths (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 85](https://github.com/galaxyproject/ephemeris/pull/85)
* Fix `shed-tools` update argparse handling (thanks to [@rhpvorderman](https://github.com/rhpvorderman)).
  [Pull Request 88](https://github.com/galaxyproject/ephemeris/pull/88)
* Fix a few lint issues (thanks to [@jmchilton](https://github.com/jmchilton)).
  [Pull Request 90](https://github.com/galaxyproject/ephemeris/pull/90)

## 0.8.0 (2017-12-29)[¶](#id14 "Link to this heading")

* Many new documentation enhancements (thanks to @rhpvorderman, and others)
* rename of shed-install to shed-tools and add a new –latest and –revision argument (thanks to @rhpvorderman)
* many fixes and new tests by (thanks to @mvdbeek)
* Parallelization of run-data-managers (thanks to @rhpvorderman)
* run-data-managers now uses more advanced templating for less repetitive input yamls (thanks to @rhpvorderman)
* run-data-managers now checks if a genome index is already present before running the data manager (thanks to @rhpvorderman)
* ephemeris will now use https by default instead of http (thanks to @bgruening)

## 0.7.0 (2017-06-27)[¶](#id15 "Link to this heading")

* Many new documentation enhancements (thanks to @rhpvorderman, @erasche, and others) -
  docs are now published to <https://readthedocs.org/projects/ephemeris/>.
* Fix problem with empty list options related to running data managers (thanks to @rhpvorderman).
* Enable data managers to run with API keys (thanks to @rhpvorderman).
* Add sleep command to wait for a Galaxy API to become available (thanks to @erasche).
* Preserve readable order of keys while processing tool lists (thanks to @drosofff).

## 0.6.1 (2017-04-17)[¶](#id16 "Link to this heading")

* Add Python 2 and 3 testing for all scripts against galaxy-docker-stable along with various
  refactoring to reduce code duplication and Python 3 fixes. [#36](https://github.com/galaxyproject/ephemeris/pull/36)

## 0.6.0 (2017-04-10)[¶](#id17 "Link to this heading")

* Add new connection options for setting up data libraries.

## 0.5.1 (2017-04-07)[¶](#id18 "Link to this heading")

* Fix new `run-data-managers` CLI entrypoint.

## 0.5.0 (2017-04-06)[¶](#id19 "Link to this heading")

* Add `run-data-managers` tool to trigger DM with multiple values and in order. [#30](https://github.com/galaxyproject/ephemeris/pull/30)
* The workflow install tool now supports a directory of workflows.