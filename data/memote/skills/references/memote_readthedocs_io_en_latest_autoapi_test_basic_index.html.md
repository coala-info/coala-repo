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

  - `test_basic`
    * [Module Contents](#module-contents)
      + [Functions](#functions)
        - [test\_model\_id\_presence](#test_basic.test_model_id_presence)
        - [test\_genes\_presence](#test_basic.test_genes_presence)
        - [test\_reactions\_presence](#test_basic.test_reactions_presence)
        - [test\_metabolites\_presence](#test_basic.test_metabolites_presence)
        - [test\_metabolites\_formula\_presence](#test_basic.test_metabolites_formula_presence)
        - [test\_metabolites\_charge\_presence](#test_basic.test_metabolites_charge_presence)
        - [test\_gene\_protein\_reaction\_rule\_presence](#test_basic.test_gene_protein_reaction_rule_presence)
        - [test\_ngam\_presence](#test_basic.test_ngam_presence)
        - [test\_metabolic\_coverage](#test_basic.test_metabolic_coverage)
        - [test\_compartments\_presence](#test_basic.test_compartments_presence)
        - [test\_protein\_complex\_presence](#test_basic.test_protein_complex_presence)
        - [test\_find\_pure\_metabolic\_reactions](#test_basic.test_find_pure_metabolic_reactions)
        - [test\_find\_constrained\_pure\_metabolic\_reactions](#test_basic.test_find_constrained_pure_metabolic_reactions)
        - [test\_find\_transport\_reactions](#test_basic.test_find_transport_reactions)
        - [test\_find\_constrained\_transport\_reactions](#test_basic.test_find_constrained_transport_reactions)
        - [test\_transport\_reaction\_gpr\_presence](#test_basic.test_transport_reaction_gpr_presence)
        - [test\_find\_reversible\_oxygen\_reactions](#test_basic.test_find_reversible_oxygen_reactions)
        - [test\_find\_unique\_metabolites](#test_basic.test_find_unique_metabolites)
        - [test\_find\_duplicate\_metabolites\_in\_compartments](#test_basic.test_find_duplicate_metabolites_in_compartments)
        - [test\_find\_reactions\_with\_partially\_identical\_annotations](#test_basic.test_find_reactions_with_partially_identical_annotations)
        - [test\_find\_duplicate\_reactions](#test_basic.test_find_duplicate_reactions)
        - [test\_find\_reactions\_with\_identical\_genes](#test_basic.test_find_reactions_with_identical_genes)
        - [test\_find\_medium\_metabolites](#test_basic.test_find_medium_metabolites)
* [Source](../../_sources/autoapi/test_basic/index.rst.txt)

# [`test_basic`](#module-test_basic "test_basic")[¶](#module-test_basic "Permalink to this headline")

Perform basic tests on an instance of `cobra.Model`.

## Module Contents[¶](#module-contents "Permalink to this headline")

### Functions[¶](#functions "Permalink to this headline")

|  |  |
| --- | --- |
| [`test_model_id_presence`](#test_basic.test_model_id_presence "test_basic.test_model_id_presence")(model) | Expect that the model has an identifier. |
| [`test_genes_presence`](#test_basic.test_genes_presence "test_basic.test_genes_presence")(model) | Expect that at least one gene is defined in the model. |
| [`test_reactions_presence`](#test_basic.test_reactions_presence "test_basic.test_reactions_presence")(model) | Expect that at least one reaction is defined in the model. |
| [`test_metabolites_presence`](#test_basic.test_metabolites_presence "test_basic.test_metabolites_presence")(model) | Expect that at least one metabolite is defined in the model. |
| [`test_metabolites_formula_presence`](#test_basic.test_metabolites_formula_presence "test_basic.test_metabolites_formula_presence")(model) | Expect all metabolites to have a formula. |
| [`test_metabolites_charge_presence`](#test_basic.test_metabolites_charge_presence "test_basic.test_metabolites_charge_presence")(model) | Expect all metabolites to have charge information. |
| [`test_gene_protein_reaction_rule_presence`](#test_basic.test_gene_protein_reaction_rule_presence "test_basic.test_gene_protein_reaction_rule_presence")(model) | Expect all non-exchange reactions to have a GPR rule. |
| [`test_ngam_presence`](#test_basic.test_ngam_presence "test_basic.test_ngam_presence")(model) | Expect a single non growth-associated maintenance reaction. |
| [`test_metabolic_coverage`](#test_basic.test_metabolic_coverage "test_basic.test_metabolic_coverage")(model) | Expect a model to have a metabolic coverage >= 1. |
| [`test_compartments_presence`](#test_basic.test_compartments_presence "test_basic.test_compartments_presence")(model) | Expect that two or more compartments are defined in the model. |
| [`test_protein_complex_presence`](#test_basic.test_protein_complex_presence "test_basic.test_protein_complex_presence")(model) | Expect that more than one enzyme complex is present in the model. |
| [`test_find_pure_metabolic_reactions`](#test_basic.test_find_pure_metabolic_reactions "test_basic.test_find_pure_metabolic_reactions")(model) | Expect at least one pure metabolic reaction to be defined in the model. |
| [`test_find_constrained_pure_metabolic_reactions`](#test_basic.test_find_constrained_pure_metabolic_reactions "test_basic.test_find_constrained_pure_metabolic_reactions")(model) | Expect zero or more purely metabolic reactions to have fixed constraints. |
| [`test_find_transport_reactions`](#test_basic.test_find_transport_reactions "test_basic.test_find_transport_reactions")(model) | Expect >= 1 transport reactions are present in the model. |
| [`test_find_constrained_transport_reactions`](#test_basic.test_find_constrained_transport_reactions "test_basic.test_find_constrained_transport_reactions")(model) | Expect zero or more transport reactions to have fixed constraints. |
| [`test_transport_reaction_gpr_presence`](#test_basic.test_transport_reaction_gpr_presence "test_basic.test_transport_reaction_gpr_presence")(model) | Expect a small fraction of transport reactions not to have a GPR rule. |
| [`test_find_reversible_oxygen_reactions`](#test_basic.test_find_reversible_oxygen_reactions "test_basic.test_find_reversible_oxygen_reactions")(model) | Expect zero or more oxygen-containing reactions to be reversible. |
| [`test_find_unique_metabolites`](#test_basic.test_find_unique_metabolites "test_basic.test_find_unique_metabolites")(model) | Expect there to be less metabolites when removing compartment tag. |
| [`test_find_duplicate_metabolites_in_compartments`](#test_basic.test_find_duplicate_metabolites_in_compartments "test_basic.test_find_duplicate_metabolites_in_compartments")(model) | Expect there to be zero duplicate metabolites in the same compartments. |
| [`test_find_reactions_with_partially_identical_annotations`](#test_basic.test_find_reactions_with_partially_identical_annotations "test_basic.test_find_reactions_with_partially_identical_annotations")(model) | Expect there to be zero duplicate reactions. |
| [`test_find_duplicate_reactions`](#test_basic.test_find_duplicate_reactions "test_basic.test_find_duplicate_reactions")(model) | Expect there to be zero duplicate reactions. |
| [`test_find_reactions_with_identical_genes`](#test_basic.test_find_reactions_with_identical_genes "test_basic.test_find_reactions_with_identical_genes")(model) | Expect there to be zero duplicate reactions. |
| [`test_find_medium_metabolites`](#test_basic.test_find_medium_metabolites "test_basic.test_find_medium_metabolites")(model) | Expect zero or more metabolites to be set as medium. |

`test_basic.``test_model_id_presence`(*model*)[[source]](../../_modules/test_basic.html#test_model_id_presence)[¶](#test_basic.test_model_id_presence "Permalink to this definition")
:   Expect that the model has an identifier.

    The MIRIAM guidelines require a model to be identified via an ID.
    Further, the ID will be displayed on the memote snapshot
    report, which helps to distinguish the output clearly.

    Implementation:
    Check if the cobra.Model object has a non-empty “id”
    attribute, this value is parsed from the “id” attribute of the <model> tag
    in the SBML file e.g. <model fbc:strict=”true” id=”iJO1366”>.

`test_basic.``test_genes_presence`(*model*)[[source]](../../_modules/test_basic.html#test_genes_presence)[¶](#test_basic.test_genes_presence "Permalink to this definition")
:   Expect that at least one gene is defined in the model.

    A metabolic model can still be a useful tool without any
    genes, however there are certain methods which rely on the presence of
    genes and, more importantly, the corresponding gene-protein-reaction
    rules. This test requires that there is at least one gene defined.

    Implementation:
    Check if the cobra.Model object has non-empty “genes”
    attribute, this list is populated from the list of fbc:listOfGeneProducts
    which should contain at least one fbc:geneProduct.

`test_basic.``test_reactions_presence`(*model*)[[source]](../../_modules/test_basic.html#test_reactions_presence)[¶](#test_basic.test_reactions_presence "Permalink to this definition")
:   Expect that at least one reaction is defined in the model.

    To be useful a metabolic model should consist at least of a few reactions.
    This test simply checks if there are more than zero reactions.

    Implementation:
    Check if the cobra.Model object has non-empty “reactions”
    attribute, this list is populated from the list of sbml:listOfReactions
    which should contain at least one sbml:reaction.

`test_basic.``test_metabolites_presence`(*model*)[[source]](../../_modules/test_basic.html#test_metabolites_presence)[¶](#test_basic.test_metabolites_presence "Permalink to this definition")
:   Expect that at least one metabolite is defined in the model.

    To be useful a metabolic model should consist at least of a few
    metabolites that are converted by reactions.
    This test simply checks if there are more than zero metabolites.

    Implementation:
    Check if the cobra.Model object has non-empty
    “metabolites” attribute, this list is populated from the list of
    sbml:listOfSpecies which should contain at least one sbml:species.

`test_basic.``test_metabolites_formula_presence`(*model*)[[source]](../../_modules/test_basic.html#test_metabolites_formula_presence)[¶](#test_basic.test_metabolites_formula_presence "Permalink to this definition")
:   Expect all metabolites to have a formula.

    To be able to ensure that reactions are mass-balanced, all model
    metabolites ought to be provided with a chemical formula. Since it may be
    difficult to obtain formulas for certain metabolites this test serves as a
    mere report. Models can still be stoichiometrically consistent even
    when chemical formulas are not defined for each metabolite.

    Implementation:
    Check if each cobra.Metabolite has a non-empty “formula”
    attribute. This attribute is set by the parser if there is an
    fbc:chemicalFormula attribute for the corresponding species in the
    SBML.

`test_basic.``test_metabolites_charge_presence`(*model*)[[source]](../../_modules/test_basic.html#test_metabolites_charge_presence)[¶](#test_basic.test_metabolites_charge_presence "Permalink to this definition")
:   Expect all metabolites to have charge information.

    To be able to ensure that reactions are charge-balanced, all model
    metabolites ought to be provided with a charge. Since it may be
    difficult to obtain charges for certain metabolites this test serves as a
    mere report. Models can still be stoichiometrically consistent even
    when charge information is not defined for each metabolite.

    Implementation:
    Check if each cobra.Metabolite has a non-empty “charge”
    attribute. This attribute is set by the parser if there is an
    fbc:charge attribute for the corresponding species in the
    SBML.

`test_basic.``test_gene_protein_reaction_rule_presence`(*model*)[[source]](../../_modules/test_basic.html#test_gene_protein_reaction_rule_presence)[¶](#test_basic.test_gene_protein_reaction_rule_presence "Permalink to this definition")
:   Expect all non-exchange reactions to have a GPR rule.

    Gene-Protein-Reaction rules express which gene has what function.
    The presence of this annotation is important to justify the existence
    of reactions in the model, and is required to conduct in silico gene
    deletion studies. However, reactions without GPR may also be valid:
    Spontaneous reactions, or known reactions with yet undiscovered genes
    likely lack GPR.

    Implementation:
    Check if each cobra.Reaction has a non-empty
    “gene\_reaction\_rule” attribute, which is set by the parser if there is an
    fbc:geneProductAssociation defined for the corresponding reaction in the
    SBML.

`test_basic.``test_ngam_presence`(*model*)[[source]](../../_modules/test_basic.html#test_ngam_presence)[¶](#test_basic.test_ngam_presence "Permalink to this definition")
:   Expect a single non growth-associated maintenance reaction.

    The Non-Growth Associated Maintenance reaction (NGAM) is an
    ATP-hydrolysis reaction added to metabolic models to represent energy
    expenses that the cell invests in continuous processes independent of
    the growth rate. Memote tries to infer this reaction from a list of
    buzzwords, and the stoichiometry and components of a simple ATP-hydrolysis
    reaction.

    Implementation:
    From the list of all reactions that convert ATP to ADP select the reactions
    that match the irreversible reaction “ATP + H2O -> ADP + HO4P + H+”,
    whose metabolites are situated within the main model compartment.
    The main model compartment is assumed to be the cytosol, yet, if that
    cannot be identified, it is assumed to be the compartment with the most
    metabolites. The resulting list of reactions is then filtered further by
    attempting to match the reaction name with any of the following buzzwords
    (‘maintenance’, ‘atpm’, ‘requirement’, ‘ngam’, ‘non-growth’, ‘associated’).
    If this is possible only the filtered reactions are returned, if not the
    list is returned as is.

`test_basic.``test_metabolic_coverage`(*model*)[[source]](../../_modules/test_basic.html#test_metabolic_coverage)[¶](#test_basic.test_metabolic_coverage "Permalink to this definition")
:   Expect a model to have a metabolic coverage >= 1.

    The degree of metabolic coverage indicates the modeling detail of a
    given reconstruction calculated by dividing the total amount of
    reactions by the amount of genes. Models with a ‘high level of modeling
    detail have ratios >1, and models with a low level of detail have
    ratios <1. This difference arises 