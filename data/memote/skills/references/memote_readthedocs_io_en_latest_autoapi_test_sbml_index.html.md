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

  - `test_sbml`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_sbml\_level](#test_sbml.test_sbml_level)
        - [test\_fbc\_presence](#test_sbml.test_fbc_presence)
* [Source](../../_sources/autoapi/test_sbml/index.rst.txt)

# [`test_sbml`](#module-test_sbml "test_sbml")[¶](#module-test_sbml "Permalink to this headline")

Tests the level, version and FBC usage of the loaded SBML file.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_sbml_level`](#test_sbml.test_sbml_level "test_sbml.test_sbml_level")(sbml\_version) | Expect the SBML to be at least level 3 version 2. |
| [`test_fbc_presence`](#test_sbml.test_fbc_presence "test_sbml.test_fbc_presence")(sbml\_version) | Expect the FBC plugin to be present. |

`test_sbml.``test_sbml_level`(*sbml\_version*)[[source]](../../_modules/test_sbml.html#test_sbml_level)[¶](#test_sbml.test_sbml_level "Permalink to this definition")
:   Expect the SBML to be at least level 3 version 2.

    This test reports if the model file is represented in the latest edition
    (level) of the Systems Biology Markup Language (SBML) which is Level 3,
    and at least version 1.

    Implementation:
    The level and version are parsed directly from the SBML document.

`test_sbml.``test_fbc_presence`(*sbml\_version*)[[source]](../../_modules/test_sbml.html#test_fbc_presence)[¶](#test_sbml.test_fbc_presence "Permalink to this definition")
:   Expect the FBC plugin to be present.

    The Flux Balance Constraints (FBC) Package extends SBML with structured
    and semantic descriptions for domain-specific model components such as
    flux bounds, multiple linear objective functions, gene-protein-reaction
    associations, metabolite chemical formulas, charge and related annotations
    which are relevant for parameterized GEMs and FBA models. The SBML and
    constraint-based modeling communities collaboratively develop this package
    and update it based on user input.

    Implementation:
    Parse the state of the FBC plugin from the SBML document.

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.