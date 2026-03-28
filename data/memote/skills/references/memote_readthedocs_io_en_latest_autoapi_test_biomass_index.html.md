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

  - `test_biomass`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [LOGGER](#test_biomass.LOGGER)
        - [test\_biomass\_presence](#test_biomass.test_biomass_presence)
        - [test\_biomass\_consistency](#test_biomass.test_biomass_consistency)
        - [test\_biomass\_default\_production](#test_biomass.test_biomass_default_production)
        - [test\_biomass\_open\_production](#test_biomass.test_biomass_open_production)
        - [test\_biomass\_precursors\_default\_production](#test_biomass.test_biomass_precursors_default_production)
        - [test\_biomass\_precursors\_open\_production](#test_biomass.test_biomass_precursors_open_production)
        - [test\_gam\_in\_biomass](#test_biomass.test_gam_in_biomass)
        - [test\_fast\_growth\_default](#test_biomass.test_fast_growth_default)
        - [test\_direct\_metabolites\_in\_biomass](#test_biomass.test_direct_metabolites_in_biomass)
        - [test\_essential\_precursors\_not\_in\_biomass](#test_biomass.test_essential_precursors_not_in_biomass)
* [Source](../../_sources/autoapi/test_biomass/index.rst.txt)

# [`test_biomass`](#module-test_biomass "test_biomass")[¶](#module-test_biomass "Permalink to this headline")

Biomass tests performed on an instance of `cobra.Model`.

N.B.: We parametrize each function here with the identified biomass reactions.
In the storage of test results we rely on the order of the biomass fixtures
to remain the same as the parametrized test cases.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_biomass_presence`](#test_biomass.test_biomass_presence "test_biomass.test_biomass_presence")(model) | Expect the model to contain at least one biomass reaction. |
| [`test_biomass_consistency`](#test_biomass.test_biomass_consistency "test_biomass.test_biomass_consistency")(model, reaction\_id) | Expect biomass components to sum up to 1 g[CDW]. |
| [`test_biomass_default_production`](#test_biomass.test_biomass_default_production "test_biomass.test_biomass_default_production")(model, reaction\_id) | Expect biomass production in default medium. |
| [`test_biomass_open_production`](#test_biomass.test_biomass_open_production "test_biomass.test_biomass_open_production")(model, reaction\_id) | Expect biomass production in complete medium. |
| [`test_biomass_precursors_default_production`](#test_biomass.test_biomass_precursors_default_production "test_biomass.test_biomass_precursors_default_production")(model, reaction\_id) | Expect production of all biomass precursors in default medium. |
| [`test_biomass_precursors_open_production`](#test_biomass.test_biomass_precursors_open_production "test_biomass.test_biomass_precursors_open_production")(model, reaction\_id) | Expect precursor production in complete medium. |
| [`test_gam_in_biomass`](#test_biomass.test_gam_in_biomass "test_biomass.test_gam_in_biomass")(model, reaction\_id) | Expect the biomass reactions to contain ATP and ADP. |
| [`test_fast_growth_default`](#test_biomass.test_fast_growth_default "test_biomass.test_fast_growth_default")(model, reaction\_id) | Expect the predicted growth rate for each BOF to be below 2.81. |
| [`test_direct_metabolites_in_biomass`](#test_biomass.test_direct_metabolites_in_biomass "test_biomass.test_direct_metabolites_in_biomass")(model, reaction\_id) | Expect the ratio of direct metabolites to be below 0.5. |
| [`test_essential_precursors_not_in_biomass`](#test_biomass.test_essential_precursors_not_in_biomass "test_biomass.test_essential_precursors_not_in_biomass")(model, reaction\_id) | Expect the biomass reaction to contain all essential precursors. |

`test_biomass.``LOGGER`[[source]](../../_modules/test_biomass.html#LOGGER)[¶](#test_biomass.LOGGER "Permalink to this definition")

`test_biomass.``test_biomass_presence`(*model*)[[source]](../../_modules/test_biomass.html#test_biomass_presence)[¶](#test_biomass.test_biomass_presence "Permalink to this definition")
:   Expect the model to contain at least one biomass reaction.

    The biomass composition aka biomass formulation aka biomass reaction
    is a common pseudo-reaction accounting for biomass synthesis in
    constraints-based modelling. It describes the stoichiometry of
    intracellular compounds that are required for cell growth. While this
    reaction may not be relevant to modeling the metabolism of higher
    organisms, it is essential for single-cell modeling.

    Implementation:
    Identifies possible biomass reactions using two principal steps:

    > 1. Return reactions that include the SBO annotation “SBO:0000629” for
    > biomass.

    If no reactions can be identifies this way:
    :   1. Look for the `buzzwords` “biomass”, “growth” and “bof” in reaction
        IDs.
        2. Look for metabolite IDs or names that contain the `buzzword`
        “biomass” and obtain the set of reactions they are involved in.
        3. Remove boundary reactions from this set.
        4. Return the union of reactions that match the buzzwords and of the
        reactions that metabolites are involved in that match the buzzword.

    This test checks if at least one biomass reaction is present.

`test_biomass.``test_biomass_consistency`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_biomass_consistency)[¶](#test_biomass.test_biomass_consistency "Permalink to this definition")
:   Expect biomass components to sum up to 1 g[CDW].

    This test only yields sensible results if all biomass precursor
    metabolites have chemical formulas assigned to them.
    The molecular weight of the biomass reaction in metabolic models is
    defined to be equal to 1 g/mmol. Conforming to this is essential in order
    to be able to reliably calculate growth yields, to cross-compare models,
    and to obtain valid predictions when simulating microbial consortia. A
    deviation from 1 - 1E-03 to 1 + 1E-06 is accepted.

    Implementation:
    Multiplies the coefficient of each metabolite of the biomass reaction with
    its molecular weight calculated from the formula, then divides the overall
    sum of all the products by 1000.

`test_biomass.``test_biomass_default_production`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_biomass_default_production)[¶](#test_biomass.test_biomass_default_production "Permalink to this definition")
:   Expect biomass production in default medium.

    Using flux balance analysis this test optimizes the model for growth in
    the medium that is set by default. Any non-zero growth rate is accepted to
    pass this test.

    Implementation:
    Calculate the solution of FBA with the biomass reaction set as objective
    function and the model’s default constraints.

`test_biomass.``test_biomass_open_production`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_biomass_open_production)[¶](#test_biomass.test_biomass_open_production "Permalink to this definition")
:   Expect biomass production in complete medium.

    Using flux balance analysis this test optimizes the model for growth using
    a complete medium i.e. unconstrained boundary reactions. Any non-zero
    growth rate is accepted to pass this test.

    Implementation:
    Calculate the solution of FBA with the biomass reaction set as objective
    function and after removing any constraints from all boundary reactions.

`test_biomass.``test_biomass_precursors_default_production`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_biomass_precursors_default_production)[¶](#test_biomass.test_biomass_precursors_default_production "Permalink to this definition")
:   Expect production of all biomass precursors in default medium.

    Using flux balance analysis this test optimizes for the production of each
    metabolite that is a substrate of the biomass reaction with the exception
    of atp and h2o. Optimizations are carried out using the default
    conditions. This is useful when reconstructing the precursor biosynthesis
    pathways of a metabolic model. To pass this test, the model should be able
    to synthesis all the precursors.

    Implementation:
    For each biomass precursor (except ATP and H2O) add a temporary demand
    reaction, then carry out FBA with this reaction as the objective. Collect
    all metabolites for which this optimization is equal to zero or
    infeasible.

`test_biomass.``test_biomass_precursors_open_production`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_biomass_precursors_open_production)[¶](#test_biomass.test_biomass_precursors_open_production "Permalink to this definition")
:   Expect precursor production in complete medium.

    Using flux balance analysis this test optimizes for the production of each
    metabolite that is a substrate of the biomass reaction with the exception
    of atp and h2o. Optimizations are carried out using a complete
    medium i.e. unconstrained boundary reactions. This is useful when
    reconstructing the precursor biosynthesis pathways of a metabolic model.
    To pass this test, the model should be able to synthesis all the
    precursors.

    Implementation:
    First remove any constraints from all boundary reactions, then for each
    biomass precursor (except ATP and H2O) add a temporary demand
    reaction, then carry out FBA with this reaction as the objective. Collect
    all metabolites for which this optimization is below or equal to zero or is
    infeasible.

`test_biomass.``test_gam_in_biomass`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_gam_in_biomass)[¶](#test_biomass.test_gam_in_biomass "Permalink to this definition")
:   Expect the biomass reactions to contain ATP and ADP.

    The growth-associated maintenance (GAM) term accounts for the energy in
    the form of ATP that is required to synthesize macromolecules such as
    Proteins, DNA and RNA, and other processes during growth. A GAM term is
    therefore a requirement for any well-defined biomass reaction. There are
    different ways to implement this term depending on
    what kind of experimental data is available and the preferred
    way of implementing the biomass reaction:
    - Chemostat growth experiments yield a single GAM value representing the

    > required energy per gram of biomass (Figure 6 of [R3f60bc5e84c5-1]). This can be
    > implemented in a lumped biomass reaction or in the final term of a split
    > biomass reaction.

    * Experimentally delineating or estimating the GAM requirements
      for each macromolecule separately is possible, yet requires either
      data from multi-omics experiments [[2]](#r3f60bc5e84c5-2) or detailed resources [R3f60bc5e84c5-1] ,
      respectively. Individual energy requirements can either be implemented
      in a split biomass equation on the term for each macromolecule, or, on
      the basis of the biomass composition, they can be summed into a single
      GAM value for growth and treated as mentioned above.

    This test is only able to detect if a lumped biomass reaction or the final
    term of a split biomass reaction contains this term. Hence, it will
    only detect the use of a single GAM value as opposed to individual energy
    requirements of each macromolecule. Both approaches, however, have
    its merits.

    Implementation:
    Determines the metabolite identifiers of ATP, ADP, H2O, HO4P and H+ based
    on an internal mapping table. Checks if ATP and H2O are a subset of the
    reactants and ADP, HO4P and H+ a subset of the products of the biomass
    reaction.

    References:
    .. [R3f60bc5e84c5-1] Thiele, I., & Palsson, B. Ø. (2010, January). A protocol for

    > generating a high-quality genome-scale metabolic reconstruction.
    > Nature protocols. Nature Publishing Group.
    > <http://doi.org/10.1038/nprot.2009.203>

    |  |  |
    | --- | --- |
    | [[2]](#id2) | Hackett, S. R., Zanotelli, V. R. T., Xu, W., Goya, J., Park, J. O., Perlman, D. H., Gibney, P. A., Botstein, D., Storey, J. D., Rabinowitz, J. D. (2010, January). Systems-level analysis of mechanisms regulating yeast metabolic flux Science <http://doi.org/10.1126/science.aaf2786> |

`test_biomass.``test_fast_growth_default`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_fast_growth_default)[¶](#test_biomass.test_fast_growth_default "Permalink to this definition")
:   Expect the predicted growth rate for each BOF to be below 2.81.

    The growth rate of a metabolic model should not be faster than that of the
    fastest growing organism. This is based on a doubling time of Vibrio
    natriegens which was reported to be 14.8 minutes by: Henry H. Lee, Nili
    Ostrov, Brandon G. Wong, Michaela A. Gold, Ahmad S. Khalil,
    George M. Church
    in <https://www.biorxiv.org/content/biorxiv/early/2016/06/12/058487.full.pdf>

    The calculation ln(2)/(14.8/60) ~ 2.81 yields the corresponding growth
    rate.

    Implementation:
    Calculate the solution of FBA with the biomass reaction set as objective
    function and a model’s default constraints. Then check if the objective
    value is higher than 2.81.

`test_biomass.``test_direct_metabolites_in_biomass`(*model*, *reaction\_id*)[[source]](../../_modules/test_biomass.html#test_direct_metabolites_in_biomass)[¶](#test_biomass.test_direct_metabolites_in_biomass "Permalink to this definition")
:   Expect the ratio of direct metabolites to be below 0.5.

    Some biomass precursors are taken from the media and directly consumed by
    the biomass reaction. It might not be a problem for ions or
    metabolites for which the organism in question is auxotrophic. However,
    too many of these metabolites may be artifacts of automated gap-filling
    procedures. Many gap-filling algorithms attempt to minimise the number of
    added reactions. This can lead to many biomass precursors being
    “direct metabolites”.

    This test reports the ratio of direct metabolites to the total amount of
    precursors to a given biomass reaction. It specifically looks for
    metabolites that are only in either exchange, transport or biomass
    reactions. Bear in mind that this may lead to false positives in heavily
    compartimentalized models.

    To pass this test, the ratio of direct metab