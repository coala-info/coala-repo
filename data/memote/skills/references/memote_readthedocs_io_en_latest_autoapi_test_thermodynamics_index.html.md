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

  - `test_thermodynamics`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_find\_candidate\_irreversible\_reactions](#test_thermodynamics.test_find_candidate_irreversible_reactions)
* [Source](../../_sources/autoapi/test_thermodynamics/index.rst.txt)

# [`test_thermodynamics`](#module-test_thermodynamics "test_thermodynamics")[¶](#module-test_thermodynamics "Permalink to this headline")

Perform tests using eQuilibrator API on an instance of `cobra.Model`.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_find_candidate_irreversible_reactions`](#test_thermodynamics.test_find_candidate_irreversible_reactions "test_thermodynamics.test_find_candidate_irreversible_reactions")(model) | Identify reversible reactions that could be irreversible. |

`test_thermodynamics.``test_find_candidate_irreversible_reactions`(*model*)[[source]](../../_modules/test_thermodynamics.html#test_find_candidate_irreversible_reactions)[¶](#test_thermodynamics.test_find_candidate_irreversible_reactions "Permalink to this definition")
:   Identify reversible reactions that could be irreversible.

    If a reaction is neither a transport reaction, a biomass reaction nor a
    boundary reaction, it is counted as a purely metabolic reaction.
    This test checks if the reversibility attribute of each reaction
    agrees with a thermodynamics-based
    calculation of reversibility.

    Implementation:
    To determine reversibility we calculate
    the reversibility index ln\_gamma (natural logarithm of gamma) of each
    reaction
    using the eQuilibrator API. We consider reactions, whose reactants’
    concentrations would need to change by more than three orders of
    magnitude for the reaction flux to reverse direction, to be likely
    candidates of irreversible reactions. This assume default concentrations
    around 100 μM (~3 μM—3 mM) at pH = 7, I = 0.1 M and T = 298 K. The
    corresponding reversibility index is approximately 7. For
    further information on the thermodynamic and implementation details
    please refer to
    <https://doi.org/10.1093/bioinformatics/bts317> and
    <https://pypi.org/project/equilibrator-api/>.

    Please note that currently eQuilibrator can only determine the
    reversibility index for chemically and redox balanced reactions whose
    metabolites can be mapped to KEGG compound identifiers (e.g. C00001). In
    addition
    to not being mappable to KEGG or the reaction not being balanced,
    there is a possibility that the metabolite cannot be broken down into
    chemical groups which is essential for the calculation of Gibbs energy
    using group contributions. This test collects each erroneous reaction
    and returns them as a tuple containing each list in the following order:

    > 1. Reactions with reversibility index
    > 2. Reactions with incomplete mapping to KEGG
    > 3. Reactions with metabolites that are problematic during calculation
    > 4. Chemically or redox unbalanced Reactions (after mapping to KEGG)

    This test simply reports the number of reversible reactions that, according
    to the reversibility index, are likely to be irreversible.

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosustainability, Technical University of Denmark.
Last updated on Sep 13, 2023.