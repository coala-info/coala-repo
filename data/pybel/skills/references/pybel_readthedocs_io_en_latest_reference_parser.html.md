[PyBEL
![Logo](../_static/PyBEL-square-100.png)](../index.html)

latest

Getting Started

* [Overview](../introduction/overview.html)
* [Installation](../introduction/installation.html)

Data Structure

* [Data Model](struct/datamodel.html)
* [Example Networks](struct/examples.html)
* [Filters](struct/filters.html)
* [Grouping](struct/grouping.html)
* [Operations](struct/operators.html)
* [Pipeline](struct/pipeline.html)
* [Query](struct/query.html)
* [Summary](struct/summary.html)

Mutations

* [Mutations](mutations/mutations.html)
* [Collapse](mutations/collapse.html)
* [Deletion](mutations/deletion.html)
* [Expansion](mutations/expansion.html)
* [Induction](mutations/induction.html)
* [Induction and Expansion](mutations/induction_expansion.html)
* [Inference](mutations/inference.html)
* [Metadata](mutations/metadata.html)

Conversion

* [Input and Output](io.html)

Database

* [Manager](database/manager.html)
* [Models](database/models.html)

Topic Guide

* [Cookbook](../topics/cookbook.html)
* [Command Line Interface](../topics/cli.html)

Reference

* [Constants](constants.html)
* Parsers
  + [BEL Parser](#bel-parser)
  + [Metadata Parser](#metadata-parser)
  + [Control Parser](#control-parser)
  + [Concept Parser](#concept-parser)
  + [Sub-Parsers](#module-pybel.parser.modifiers)
* [Internal Domain Specific Language](dsl.html)
* [Logging Messages](logging.html)

Project

* [References](../meta/references.html)
* [Current Issues](../meta/postmortem.html)
* [Technology](../meta/technology.html)

[PyBEL](../index.html)

* »
* Parsers
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/reference/parser.rst)

---

# Parsers[](#parsers "Permalink to this headline")

This page is for users who want to squeeze the most bizarre possibilities out of PyBEL. Most users will not need this
reference.

PyBEL makes extensive use of the PyParsing module. The code is organized to different modules to reflect
the different faces ot the BEL language. These parsers support BEL 2.0 and have some backwards compatibility
for rewriting BEL v1.0 statements as BEL v2.0. The biologist and bioinformatician using this software will likely never
need to read this page, but a developer seeking to extend the language will be interested to see the inner workings
of these parsers.

See: <https://github.com/OpenBEL/language/blob/master/version_2.0/MIGRATE_BEL1_BEL2.md>

## BEL Parser[](#bel-parser "Permalink to this headline")

*class* pybel.parser.parse\_bel.BELParser(*graph=None*, *namespace\_to\_term\_to\_encoding=None*, *namespace\_to\_pattern=None*, *annotation\_to\_term=None*, *annotation\_to\_pattern=None*, *annotation\_to\_local=None*, *allow\_naked\_names=False*, *disallow\_nested=False*, *disallow\_unqualified\_translocations=False*, *citation\_clearing=True*, *skip\_validation=False*, *autostreamline=True*, *required\_annotations=None*)[[source]](../_modules/pybel/parser/parse_bel.html#BELParser)[](#pybel.parser.parse_bel.BELParser "Permalink to this definition")
:   Build a parser backed by a given dictionary of namespaces.

    Build a BEL parser.

    Parameters
    :   * **graph** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`BELGraph`](struct/datamodel.html#pybel.BELGraph "pybel.struct.graph.BELGraph")]) – The BEL graph to use to store the network
        * **namespace\_to\_term\_to\_encoding** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`Tuple`](https://docs.python.org/3/library/typing.html#typing.Tuple "(in Python v3.10)")[[`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")], [`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]]) – A dictionary of {namespace: {name: encoding}}. Delegated to
          `pybel.parser.parse_identifier.IdentifierParser`
        * **namespace\_to\_pattern** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Pattern`](https://docs.python.org/3/library/typing.html#typing.Pattern "(in Python v3.10)")]]) – A dictionary of {namespace: compiled regular expression}. Delegated to
          `pybel.parser.parse_identifier.IdentifierParser`
        * **annotation\_to\_term** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]]) – A dictionary of {annotation: set of values}. Delegated to
          `pybel.parser.ControlParser`
        * **annotation\_to\_pattern** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Pattern`](https://docs.python.org/3/library/typing.html#typing.Pattern "(in Python v3.10)")]]) – A dictionary of {annotation: regular expression strings}. Delegated to
          `pybel.parser.ControlParser`
        * **annotation\_to\_local** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Set`](https://docs.python.org/3/library/typing.html#typing.Set "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]]) – A dictionary of {annotation: set of values}. Delegated to
          `pybel.parser.ControlParser`
        * **allow\_naked\_names** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, turn off naked namespace failures. Delegated to
          `pybel.parser.parse_identifier.IdentifierParser`
        * **disallow\_nested** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, turn on nested statement failures. Delegated to
          `pybel.parser.parse_identifier.IdentifierParser`
        * **disallow\_unqualified\_translocations** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – If true, allow translocations without TO and FROM clauses.
        * **citation\_clearing** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should `SET Citation` statements clear evidence and all annotations?
          Delegated to `pybel.parser.ControlParser`
        * **autostreamline** ([`bool`](https://docs.python.org/3/library/functions.html#bool "(in Python v3.10)")) – Should the parser be streamlined on instantiation?
        * **required\_annotations** ([`Optional`](https://docs.python.org/3/library/typing.html#typing.Optional "(in Python v3.10)")[[`List`](https://docs.python.org/3/library/typing.html#typing.List "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)")]]) – Optional list of required annotations

    pmod[](#pybel.parser.parse_bel.BELParser.pmod "Permalink to this definition")
    :   [2.2.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_protein_modifications)

    location[](#pybel.parser.parse_bel.BELParser.location "Permalink to this definition")
    :   [2.2.4](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_cellular_location)

    gmod[](#pybel.parser.parse_bel.BELParser.gmod "Permalink to this definition")
    :   PyBEL BEL Specification variant

    fusion[](#pybel.parser.parse_bel.BELParser.fusion "Permalink to this definition")
    :   [2.6.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_fusion_fus)

    general\_abundance[](#pybel.parser.parse_bel.BELParser.general_abundance "Permalink to this definition")
    :   [2.1.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XcomplexA)

    gene[](#pybel.parser.parse_bel.BELParser.gene "Permalink to this definition")
    :   [2.1.4](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XgeneA)

    mirna[](#pybel.parser.parse_bel.BELParser.mirna "Permalink to this definition")
    :   [2.1.5](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XmicroRNAA)

    protein[](#pybel.parser.parse_bel.BELParser.protein "Permalink to this definition")
    :   [2.1.6](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XproteinA)

    rna[](#pybel.parser.parse_bel.BELParser.rna "Permalink to this definition")
    :   [2.1.7](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XrnaA)

    complex\_singleton[](#pybel.parser.parse_bel.BELParser.complex_singleton "Permalink to this definition")
    :   [2.1.2](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XcomplexA)

    composite\_abundance[](#pybel.parser.parse_bel.BELParser.composite_abundance "Permalink to this definition")
    :   [2.1.3](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XcompositeA)

    molecular\_activity[](#pybel.parser.parse_bel.BELParser.molecular_activity "Permalink to this definition")
    :   [2.4.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#XmolecularA)

    biological\_process[](#pybel.parser.parse_bel.BELParser.biological_process "Permalink to this definition")
    :   [2.3.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_biologicalprocess_bp)

    pathology[](#pybel.parser.parse_bel.BELParser.pathology "Permalink to this definition")
    :   [2.3.2](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_pathology_path)

    activity[](#pybel.parser.parse_bel.BELParser.activity "Permalink to this definition")
    :   [2.3.3](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#Xactivity)

    translocation[](#pybel.parser.parse_bel.BELParser.translocation "Permalink to this definition")
    :   [2.5.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_translocations)

    degradation[](#pybel.parser.parse_bel.BELParser.degradation "Permalink to this definition")
    :   [2.5.2](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_degradation_deg)

    reactants[](#pybel.parser.parse_bel.BELParser.reactants "Permalink to this definition")
    :   [2.5.3](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_reaction_rxn)

    rate\_limit[](#pybel.parser.parse_bel.BELParser.rate_limit "Permalink to this definition")
    :   [3.1.5](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_ratelimitingstepof)

    subprocess\_of[](#pybel.parser.parse_bel.BELParser.subprocess_of "Permalink to this definition")
    :   [3.4.6](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_subprocessof)

    transcribed[](#pybel.parser.parse_bel.BELParser.transcribed "Permalink to this definition")
    :   [3.3.2](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_transcribedto)

    translated[](#pybel.parser.parse_bel.BELParser.translated "Permalink to this definition")
    :   [3.3.3](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_translatedto)

    has\_member[](#pybel.parser.parse_bel.BELParser.has_member "Permalink to this definition")
    :   [3.4.1](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_hasmember)

    abundance\_list[](#pybel.parser.parse_bel.BELParser.abundance_list "Permalink to this definition")
    :   [3.4.2](http://openbel.org/language/version_2.0/bel_specification_version_2.0.html#_hasmembers)

    parse(*s*)[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.parse)[](#pybel.parser.parse_bel.BELParser.parse "Permalink to this definition")
    :   Parse the string.

        Return type
        :   [`Mapping`](https://docs.python.org/3/library/typing.html#typing.Mapping "(in Python v3.10)")[[`str`](https://docs.python.org/3/library/stdtypes.html#str "(in Python v3.10)"), [`Any`](https://docs.python.org/3/library/typing.html#typing.Any "(in Python v3.10)")]

    get\_annotations()[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.get_annotations)[](#pybel.parser.parse_bel.BELParser.get_annotations "Permalink to this definition")
    :   Get the current annotations in this parser.

        Return type
        :   [`Dict`](https://docs.python.org/3/library/typing.html#typing.Dict "(in Python v3.10)")

    clear()[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.clear)[](#pybel.parser.parse_bel.BELParser.clear "Permalink to this definition")
    :   Clear the graph and all control parser data (current citation, annotations, and statement group).

    handle\_nested\_relation(*line*, *position*, *tokens*)[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.handle_nested_relation)[](#pybel.parser.parse_bel.BELParser.handle_nested_relation "Permalink to this definition")
    :   Handle nested statements.

        If `self.disallow_nested` is True, raises a `NestedRelationWarning`.

        Raises
        :   NestedRelationWarning

    check\_function\_semantics(*line*, *position*, *tokens*)[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.check_function_semantics)[](#pybel.parser.parse_bel.BELParser.check_function_semantics "Permalink to this definition")
    :   Raise an exception if the function used on the tokens is wrong.

        Raises
        :   InvalidFunctionSemantic

        Return type
        :   `ParseResults`

    handle\_term(*\_*, *\_\_*, *tokens*)[[source]](../_modules/pybel/parser/parse_bel.html#BELParser.handle_term)[](#pybel.parser.parse_bel.BELParser.handle_term "Permalink to this definition")
    :   Handle BEL terms (the subject and object of BEL relations).

        Return type
        :   `Parse