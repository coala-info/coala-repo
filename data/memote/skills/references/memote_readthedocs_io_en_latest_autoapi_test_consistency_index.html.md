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

  - `test_consistency`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_stoichiometric\_consistency](#test_consistency.test_stoichiometric_consistency)
        - [test\_unconserved\_metabolites](#test_consistency.test_unconserved_metabolites)
        - [test\_inconsistent\_min\_stoichiometry](#test_consistency.test_inconsistent_min_stoichiometry)
        - [test\_detect\_energy\_generating\_cycles](#test_consistency.test_detect_energy_generating_cycles)
        - [test\_reaction\_charge\_balance](#test_consistency.test_reaction_charge_balance)
        - [test\_reaction\_mass\_balance](#test_consistency.test_reaction_mass_balance)
        - [test\_blocked\_reactions](#test_consistency.test_blocked_reactions)
        - [test\_find\_stoichiometrically\_balanced\_cycles](#test_consistency.test_find_stoichiometrically_balanced_cycles)
        - [test\_find\_orphans](#test_consistency.test_find_orphans)
        - [test\_find\_deadends](#test_consistency.test_find_deadends)
        - [test\_find\_disconnected](#test_consistency.test_find_disconnected)
        - [test\_find\_metabolites\_not\_produced\_with\_open\_bounds](#test_consistency.test_find_metabolites_not_produced_with_open_bounds)
        - [test\_find\_metabolites\_not\_consumed\_with\_open\_bounds](#test_consistency.test_find_metabolites_not_consumed_with_open_bounds)
        - [test\_find\_reactions\_unbounded\_flux\_default\_condition](#test_consistency.test_find_reactions_unbounded_flux_default_condition)
* [Source](../../_sources/autoapi/test_consistency/index.rst.txt)

# [`test_consistency`](#module-test_consistency "test_consistency")[¶](#module-test_consistency "Permalink to this headline")

Stoichiometric consistency tests for an instance of `cobra.Model`.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_stoichiometric_consistency`](#test_consistency.test_stoichiometric_consistency "test_consistency.test_stoichiometric_consistency")(model) | Expect that the stoichiometry is consistent. |
| [`test_unconserved_metabolites`](#test_consistency.test_unconserved_metabolites "test_consistency.test_unconserved_metabolites")(model) | Report number all unconserved metabolites. |
| [`test_inconsistent_min_stoichiometry`](#test_consistency.test_inconsistent_min_stoichiometry "test_consistency.test_inconsistent_min_stoichiometry")(model) | Report inconsistent min stoichiometries. |
| [`test_detect_energy_generating_cycles`](#test_consistency.test_detect_energy_generating_cycles "test_consistency.test_detect_energy_generating_cycles")(model, met) | Expect that no energy metabolite can be produced out of nothing. |
| [`test_reaction_charge_balance`](#test_consistency.test_reaction_charge_balance "test_consistency.test_reaction_charge_balance")(model) | Expect all reactions to be charge balanced. |
| [`test_reaction_mass_balance`](#test_consistency.test_reaction_mass_balance "test_consistency.test_reaction_mass_balance")(model) | Expect all reactions to be mass balanced. |
| [`test_blocked_reactions`](#test_consistency.test_blocked_reactions "test_consistency.test_blocked_reactions")(model) | Expect all reactions to be able to carry flux in complete medium. |
| [`test_find_stoichiometrically_balanced_cycles`](#test_consistency.test_find_stoichiometrically_balanced_cycles "test_consistency.test_find_stoichiometrically_balanced_cycles")(model) | Expect no stoichiometrically balanced loops to be present. |
| [`test_find_orphans`](#test_consistency.test_find_orphans "test_consistency.test_find_orphans")(model) | Expect no orphans to be present. |
| [`test_find_deadends`](#test_consistency.test_find_deadends "test_consistency.test_find_deadends")(model) | Expect no dead-ends to be present. |
| [`test_find_disconnected`](#test_consistency.test_find_disconnected "test_consistency.test_find_disconnected")(model) | Expect no disconnected metabolites to be present. |
| [`test_find_metabolites_not_produced_with_open_bounds`](#test_consistency.test_find_metabolites_not_produced_with_open_bounds "test_consistency.test_find_metabolites_not_produced_with_open_bounds")(model) | Expect metabolites to be producible in complete medium. |
| [`test_find_metabolites_not_consumed_with_open_bounds`](#test_consistency.test_find_metabolites_not_consumed_with_open_bounds "test_consistency.test_find_metabolites_not_consumed_with_open_bounds")(model) | Expect metabolites to be consumable in complete medium. |
| [`test_find_reactions_unbounded_flux_default_condition`](#test_consistency.test_find_reactions_unbounded_flux_default_condition "test_consistency.test_find_reactions_unbounded_flux_default_condition")(model) | Expect the fraction of unbounded reactions to be low. |

`test_consistency.``test_stoichiometric_consistency`(*model*)[[source]](../../_modules/test_consistency.html#test_stoichiometric_consistency)[¶](#test_consistency.test_stoichiometric_consistency "Permalink to this definition")
:   Expect that the stoichiometry is consistent.

    Stoichiometric inconsistency violates universal constraints:
    1. Molecular masses are always positive, and
    2. On each side of a reaction the mass is conserved.
    A single incorrectly defined reaction can lead to stoichiometric
    inconsistency in the model, and consequently to unconserved metabolites.
    Similar to insufficient constraints, this may give rise to cycles which
    either produce mass from nothing or consume mass from the model.

    Implementation:
    This test uses an implementation of the algorithm presented in
    section 3.1 by Gevorgyan, A., M. G Poolman, and D. A Fell.
    “Detection of Stoichiometric Inconsistencies in Biomolecular Models.”
    Bioinformatics 24, no. 19 (2008): 2245.
    doi: 10.1093/bioinformatics/btn425

`test_consistency.``test_unconserved_metabolites`(*model*)[[source]](../../_modules/test_consistency.html#test_unconserved_metabolites)[¶](#test_consistency.test_unconserved_metabolites "Permalink to this definition")
:   Report number all unconserved metabolites.

    The list of unconserved metabolites is computed using the algorithm described
    in section 3.2 of
    “Detection of Stoichiometric Inconsistencies in Biomolecular Models.”
    Bioinformatics 24, no. 19 (2008): 2245.
    doi: 10.1093/bioinformatics/btn425.

`test_consistency.``test_inconsistent_min_stoichiometry`(*model*)[[source]](../../_modules/test_consistency.html#test_inconsistent_min_stoichiometry)[¶](#test_consistency.test_inconsistent_min_stoichiometry "Permalink to this definition")
:   Report inconsistent min stoichiometries.

    Only 10 unconserved metabolites are reported and considered to
    avoid computing for too long.

    Implementation:
    Algorithm described in section 3.3 of
    “Detection of Stoichiometric Inconsistencies in Biomolecular Models.”
    Bioinformatics 24, no. 19 (2008): 2245.
    doi: 10.1093/bioinformatics/btn425.

`test_consistency.``test_detect_energy_generating_cycles`(*model*, *met*)[[source]](../../_modules/test_consistency.html#test_detect_energy_generating_cycles)[¶](#test_consistency.test_detect_energy_generating_cycles "Permalink to this definition")
:   Expect that no energy metabolite can be produced out of nothing.

    When a model is not sufficiently constrained to account for the
    thermodynamics of reactions, flux cycles may form which provide reduced
    metabolites to the model without requiring nutrient uptake. These cycles
    are referred to as erroneous energy-generating cycles. Their effect on the
    predicted growth rate in FBA may account for an increase of up to 25%,
    which makes studies involving the growth rates predicted from such models
    unreliable.

    Implementation:
    This test uses an implementation of the algorithm presented by:
    Fritzemeier, C. J., Hartleb, D., Szappanos, B., Papp, B., & Lercher,
    M. J. (2017). Erroneous energy-generating cycles in published genome scale
    metabolic networks: Identification and removal. PLoS Computational
    Biology, 13(4), 1–14. <http://doi.org/10.1371/journal.pcbi.1005494>

    First attempt to identify the main compartment (cytosol), then attempt to
    identify each metabolite of the referenced list of energy couples via an
    internal mapping table. Construct a dissipation reaction for each couple.
    Carry out FBA with each dissipation reaction as the objective and report
    those reactions that non-zero carry flux.

`test_consistency.``test_reaction_charge_balance`(*model*)[[source]](../../_modules/test_consistency.html#test_reaction_charge_balance)[¶](#test_consistency.test_reaction_charge_balance "Permalink to this definition")
:   Expect all reactions to be charge balanced.

    This will exclude biomass, exchange and demand reactions as they are
    unbalanced by definition. It will also fail all reactions where at
    least one metabolite does not have a charge defined.

    In steady state, for each metabolite the sum of influx equals the sum
    of efflux. Hence the net charges of both sides of any model reaction have
    to be equal. Reactions where at least one metabolite does not have a
    charge are not considered to be balanced, even though the remaining
    metabolites participating in the reaction might be.

    Implementation:
    For each reaction that isn’t a boundary or biomass reaction check if each
    metabolite has a non-zero charge attribute and if so calculate if the
    overall sum of charges of reactants and products is equal to zero.

`test_consistency.``test_reaction_mass_balance`(*model*)[[source]](../../_modules/test_consistency.html#test_reaction_mass_balance)[¶](#test_consistency.test_reaction_mass_balance "Permalink to this definition")
:   Expect all reactions to be mass balanced.

    This will exclude biomass, exchange and demand reactions as they are
    unbalanced by definition. It will also fail all reactions where at
    least one metabolite does not have a formula defined.

    In steady state, for each metabolite the sum of influx equals the sum
    of efflux. Hence the net masses of both sides of any model reaction have
    to be equal. Reactions where at least one metabolite does not have a
    formula are not considered to be balanced, even though the remaining
    metabolites participating in the reaction might be.

    Implementation:
    For each reaction that isn’t a boundary or biomass reaction check if each
    metabolite has a non-zero elements attribute and if so calculate if the
    overall element balance of reactants and products is equal to zero.

`test_consistency.``test_blocked_reactions`(*model*)[[source]](../../_modules/test_consistency.html#test_blocked_reactions)[¶](#test_consistency.test_blocked_reactions "Permalink to this definition")
:   Expect all reactions to be able to carry flux in complete medium.

    Universally blocked reactions are reactions that during Flux Variability
    Analysis cannot carry any flux while all model boundaries are open.
    Generally blocked reactions are caused by network gaps, which can be
    attributed to scope or knowledge gaps.

    Implementation:
    Use flux variability analysis (FVA) implemented in
    cobra.flux\_analysis.find\_blocked\_reactions with open\_exchanges=True.
    Please refer to the cobrapy documentation for more information:
    <https://cobrapy.readthedocs.io/en/stable/autoapi/cobra/flux_analysis/>
    variability/index.html#cobra.flux\_analysis.variability.
    find\_blocked\_reactions

`test_consistency.``test_find_stoichiometrically_balanced_cycles`(*model*)[[source]](../../_modules/test_consistency.html#test_find_stoichiometrically_balanced_cycles)[¶](#test_consistency.test_find_stoichiometrically_balanced_cycles "Permalink to this definition")
:   Expect no stoichiometrically balanced loops to be present.

    Stoichiometrically Balanced Cycles are artifacts of insufficiently
    constrained networks resulting in reactions that can carry flux when
    all the boundaries have been closed.

    Implementation:
    Close all model boundary reactions and then use flux variability analysis
    (FVA) to identify reactions that carry flux.

`test_consistency.``test_find_orphans`(*model*)[[source]](../../_modules/test_consistency.html#test_find_orphans)[¶](#test_consistency.test_find_orphans "Permalink to this definition")
:   Expect no orphans to be present.

    Orphans are metabolites that are only consumed but not produced by
    reactions in the model. They may indicate the presence of network and
    knowledge gaps.

    Implementation:
    Find orphan metabolites structurally by considering only reaction
    equations and bounds. FBA is not carried out.

`test_consistency.``test_find_deadends`(*model*)[[source]](../../_modules/test_consistency.html#test_find_deadends)[¶](#test_consistency.test_find_deadends "Permalink to this definition")
:   Expect no dead-ends to be present.

    Dead-ends are metabolites that can only be produced but not consumed by
    reactions in the model. They may indicate the presence of network and
    knowledge gaps.

    Implementation:
    Find dead-end metabolites structurally by considering only reaction
    equations and bounds. FBA is not carried out.

`test_consistency.``test_find_disconnected`(*model*)[[source]](../../_modules/test_consistency.html#test_find_disconnected)[¶](#test_consistency.test_find_disconnected "Permalink to this definition")
:   Expect no disconnected metabolites to be present.

    Disconnected metabolites are not part of any reaction in the model. They
    are most likely left-over from the reconstruction process, but may also
    point to network and knowledge gaps.

    Implementation:
    Check for any metabolites of the cobra.Model object with emtpy reaction
    attribute.

`test_consistency.``test_find_metabolites_not_produced_with_open_bounds`(*model*)[[source]](../../_modules/test_consistency.html#test_find_metabolites_not_produced_with_open_bounds)[¶](#test_consistency.test_find_metabolites_not_produced_with_open_bounds "Permalink to this definition")
:   Expect metabolites to be producible in complete medium.

    In complete medium, a model should be able to divert flux to every
    metabolite. This test opens all the boundary reactions i.e. simulates a
    complete medium