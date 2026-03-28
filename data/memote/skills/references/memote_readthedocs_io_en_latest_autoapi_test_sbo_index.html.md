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

  - `test_sbo`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_metabolite\_sbo\_presence](#test_sbo.test_metabolite_sbo_presence)
        - [test\_reaction\_sbo\_presence](#test_sbo.test_reaction_sbo_presence)
        - [test\_gene\_sbo\_presence](#test_sbo.test_gene_sbo_presence)
        - [test\_metabolic\_reaction\_specific\_sbo\_presence](#test_sbo.test_metabolic_reaction_specific_sbo_presence)
        - [test\_transport\_reaction\_specific\_sbo\_presence](#test_sbo.test_transport_reaction_specific_sbo_presence)
        - [test\_metabolite\_specific\_sbo\_presence](#test_sbo.test_metabolite_specific_sbo_presence)
        - [test\_gene\_specific\_sbo\_presence](#test_sbo.test_gene_specific_sbo_presence)
        - [test\_exchange\_specific\_sbo\_presence](#test_sbo.test_exchange_specific_sbo_presence)
        - [test\_demand\_specific\_sbo\_presence](#test_sbo.test_demand_specific_sbo_presence)
        - [test\_sink\_specific\_sbo\_presence](#test_sbo.test_sink_specific_sbo_presence)
        - [test\_biomass\_specific\_sbo\_presence](#test_sbo.test_biomass_specific_sbo_presence)
* [Source](../../_sources/autoapi/test_sbo/index.rst.txt)

# [`test_sbo`](#module-test_sbo "test_sbo")[¶](#module-test_sbo "Permalink to this headline")

Tests for SBO terms performed on an instance of `cobra.Model`.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_metabolite_sbo_presence`](#test_sbo.test_metabolite_sbo_presence "test_sbo.test_metabolite_sbo_presence")(model) | Expect all metabolites to have a some form of SBO-Term annotation. |
| [`test_reaction_sbo_presence`](#test_sbo.test_reaction_sbo_presence "test_sbo.test_reaction_sbo_presence")(model) | Expect all reactions to have a some form of SBO-Term annotation. |
| [`test_gene_sbo_presence`](#test_sbo.test_gene_sbo_presence "test_sbo.test_gene_sbo_presence")(model) | Expect all genes to have a some form of SBO-Term annotation. |
| [`test_metabolic_reaction_specific_sbo_presence`](#test_sbo.test_metabolic_reaction_specific_sbo_presence "test_sbo.test_metabolic_reaction_specific_sbo_presence")(model) | Expect all metabolic reactions to be annotated with SBO:0000176. |
| [`test_transport_reaction_specific_sbo_presence`](#test_sbo.test_transport_reaction_specific_sbo_presence "test_sbo.test_transport_reaction_specific_sbo_presence")(model) | Expect all transport reactions to be annotated properly. |
| [`test_metabolite_specific_sbo_presence`](#test_sbo.test_metabolite_specific_sbo_presence "test_sbo.test_metabolite_specific_sbo_presence")(model) | Expect all metabolites to be annotated with SBO:0000247. |
| [`test_gene_specific_sbo_presence`](#test_sbo.test_gene_specific_sbo_presence "test_sbo.test_gene_specific_sbo_presence")(model) | Expect all genes to be annotated with SBO:0000243. |
| [`test_exchange_specific_sbo_presence`](#test_sbo.test_exchange_specific_sbo_presence "test_sbo.test_exchange_specific_sbo_presence")(model) | Expect all exchange reactions to be annotated with SBO:0000627. |
| [`test_demand_specific_sbo_presence`](#test_sbo.test_demand_specific_sbo_presence "test_sbo.test_demand_specific_sbo_presence")(model) | Expect all demand reactions to be annotated with SBO:0000627. |
| [`test_sink_specific_sbo_presence`](#test_sbo.test_sink_specific_sbo_presence "test_sbo.test_sink_specific_sbo_presence")(model) | Expect all sink reactions to be annotated with SBO:0000632. |
| [`test_biomass_specific_sbo_presence`](#test_sbo.test_biomass_specific_sbo_presence "test_sbo.test_biomass_specific_sbo_presence")(model) | Expect all biomass reactions to be annotated with SBO:0000629. |

`test_sbo.``test_metabolite_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_metabolite_sbo_presence)[¶](#test_sbo.test_metabolite_sbo_presence "Permalink to this definition")
:   Expect all metabolites to have a some form of SBO-Term annotation.

    The Systems Biology Ontology (SBO) allows researchers to annotate a model
    with terms which indicate the intended function of its individual
    components. The available terms are controlled and relational and can be
    viewed here <http://www.ebi.ac.uk/sbo/main/tree>.

    Implementation:
    Check if each cobra.Metabolite has a non-zero “annotation”
    attribute that contains the key “sbo”.

`test_sbo.``test_reaction_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_reaction_sbo_presence)[¶](#test_sbo.test_reaction_sbo_presence "Permalink to this definition")
:   Expect all reactions to have a some form of SBO-Term annotation.

    The Systems Biology Ontology (SBO) allows researchers to annotate a model
    with terms which indicate the intended function of its individual
    components. The available terms are controlled and relational and can be
    viewed here <http://www.ebi.ac.uk/sbo/main/tree>.

    Implementation:
    Check if each cobra.Reaction has a non-zero “annotation”
    attribute that contains the key “sbo”.

`test_sbo.``test_gene_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_gene_sbo_presence)[¶](#test_sbo.test_gene_sbo_presence "Permalink to this definition")
:   Expect all genes to have a some form of SBO-Term annotation.

    The Systems Biology Ontology (SBO) allows researchers to annotate a model
    with terms which indicate the intended function of its individual
    components. The available terms are controlled and relational and can be
    viewed here <http://www.ebi.ac.uk/sbo/main/tree>.

    Check if each cobra.Gene has a non-zero “annotation”
    attribute that contains the key “sbo”.

`test_sbo.``test_metabolic_reaction_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_metabolic_reaction_specific_sbo_presence)[¶](#test_sbo.test_metabolic_reaction_specific_sbo_presence "Permalink to this definition")
:   Expect all metabolic reactions to be annotated with SBO:0000176.

    SBO:0000176 represents the term ‘biochemical reaction’. Every metabolic
    reaction that is not a transport or boundary reaction should be annotated
    with this. The results shown are relative to the total amount of pure
    metabolic reactions.

    Implementation:
    Check if each pure metabolic reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being the SBO term above.

`test_sbo.``test_transport_reaction_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_transport_reaction_specific_sbo_presence)[¶](#test_sbo.test_transport_reaction_specific_sbo_presence "Permalink to this definition")
:   Expect all transport reactions to be annotated properly.

    ‘SBO:0000185’, ‘SBO:0000588’, ‘SBO:0000587’, ‘SBO:0000655’, ‘SBO:0000654’,
    ‘SBO:0000660’, ‘SBO:0000659’, ‘SBO:0000657’, and ‘SBO:0000658’ represent
    the terms ‘transport reaction’ and ‘translocation reaction’, in addition
    to their children (more specific transport reaction labels). Every
    transport reaction that is not a pure metabolic or boundary reaction should
    be annotated with one of these terms. The results shown are relative to the
    total of all transport reactions.

    Implementation:
    Check if each transport reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_metabolite_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_metabolite_specific_sbo_presence)[¶](#test_sbo.test_metabolite_specific_sbo_presence "Permalink to this definition")
:   Expect all metabolites to be annotated with SBO:0000247.

    SBO:0000247 represents the term ‘simple chemical’. Every metabolite should
    be annotated with this.

    Implementation:
    Check if each cobra.Metabolite has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_gene_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_gene_specific_sbo_presence)[¶](#test_sbo.test_gene_specific_sbo_presence "Permalink to this definition")
:   Expect all genes to be annotated with SBO:0000243.

    SBO:0000243 represents the term ‘gene’. Every gene should
    be annotated with this.

    Implementation:
    Check if each cobra.Gene has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_exchange_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_exchange_specific_sbo_presence)[¶](#test_sbo.test_exchange_specific_sbo_presence "Permalink to this definition")
:   Expect all exchange reactions to be annotated with SBO:0000627.

    SBO:0000627 represents the term ‘exchange reaction’. The Systems Biology
    Ontology defines an exchange reaction as follows: ‘A modeling process to
    provide matter influx or efflux to a model, for example to replenish a
    metabolic network with raw materials (eg carbon / energy sources). Such
    reactions are conceptual, created solely for modeling purposes, and do not
    have a physical correspondence. Exchange reactions, often represented as
    ‘[R\_EX\_](#id1)’, can operate in the negative (uptake) direction or positive
    (secretion) direction. By convention, a negative flux through an exchange
    reaction represents uptake of the corresponding metabolite, and a positive
    flux represent discharge.’ Every exchange reaction should be annotated with
    this. Exchange reactions differ from demand reactions in that the
    metabolites are removed from or added to the extracellular
    environment only.

    Implementation:
    Check if each exchange reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_demand_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_demand_specific_sbo_presence)[¶](#test_sbo.test_demand_specific_sbo_presence "Permalink to this definition")
:   Expect all demand reactions to be annotated with SBO:0000627.

    SBO:0000628 represents the term ‘demand reaction’. The Systems Biology
    Ontology defines a demand reaction as follows: ‘A modeling process
    analogous to exchange reaction, but which operates upon “internal”
    metabolites. Metabolites that are consumed by these reactions are assumed
    to be used in intra-cellular processes that are not part of the model.
    Demand reactions, often represented ‘[R\_DM\_](#id3)’, can also deliver metabolites
    (from intra-cellular processes that are not considered in the model).’
    Every demand reaction should be annotated with
    this. Demand reactions differ from exchange reactions in that the
    metabolites are not removed from the extracellular environment, but from
    any of the organism’s compartments. Demand reactions differ from sink
    reactions in that they are designated as irreversible.

    Implementation:
    Check if each demand reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_sink_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_sink_specific_sbo_presence)[¶](#test_sbo.test_sink_specific_sbo_presence "Permalink to this definition")
:   Expect all sink reactions to be annotated with SBO:0000632.

    SBO:0000632 represents the term ‘sink reaction’. The Systems Biology
    Ontology defines a sink reaction as follows: ‘A modeling process to
    provide matter influx or efflux to a model, for example to replenish a
    metabolic network with raw materials (eg carbon / energy sources). Such
    reactions are conceptual, created solely for modeling purposes, and do not
    have a physical correspondence. Unlike the analogous demand (SBO:….)
    reactions, which are usually designated as irreversible, sink reactions
    always represent a reversible uptake/secretion processes, and act as a
    metabolite source with no cost to the cell. Sink reactions, also referred
    to as [R\_SINK\_](#id5), are generally used for compounds that are metabolized by
    the cell but are produced by non-metabolic, un-modeled cellular processes.’
    Every sink reaction should be annotated with
    this. Sink reactions differ from exchange reactions in that the metabolites
    are not removed from the extracellular environment, but from any of the
    organism’s compartments.

    Implementation:
    Check if each sink reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

`test_sbo.``test_biomass_specific_sbo_presence`(*model*)[[source]](../../_modules/test_sbo.html#test_biomass_specific_sbo_presence)[¶](#test_sbo.test_biomass_specific_sbo_presence "Permalink to this definition")
:   Expect all biomass reactions to be annotated with SBO:0000629.

    SBO:0000629 represents the term ‘biomass production’. The Systems Biology
    Ontology defines an exchange reaction as follows: ‘Biomass production,
    often represented ‘[R\_BIOMASS\_](#id7)’, is usually the optimization target reaction
    of constraint-based models, and can consume multiple reactants to produce
    multiple products. It is also assumed that parts of the reactants are also
    consumed in unrepresented processes and hence products do not have to
    reflect all the atom composition of the reactants. Formulation of a
    biomass production process entails definition of the macromolecular
    content (eg. cellular protein fraction), metabolic constitution of
    each fraction (eg. amino acids), and subsequently the atomic composition
    (eg. nitrogen atoms). More complex biomass functions can additionally
    incorporate details of essential vitamins and cofactors required for
    growth.’
    Every reaction representing the biomass production should be annotated with
    this.

    Implementation:
    Check if each biomass reaction has a non-zero “annotation”
    attribute that contains the key “sbo” with the associated
    value being one of the SBO terms above.

Back to top

© Copyright 2017, Novo Nordisk Foundation Center for Biosust