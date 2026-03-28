PyBEL
![Logo](_static/PyBEL-square-100.png)

latest

Getting Started

* [Overview](introduction/overview.html)
* [Installation](introduction/installation.html)

Data Structure

* [Data Model](reference/struct/datamodel.html)
* [Example Networks](reference/struct/examples.html)
* [Filters](reference/struct/filters.html)
* [Grouping](reference/struct/grouping.html)
* [Operations](reference/struct/operators.html)
* [Pipeline](reference/struct/pipeline.html)
* [Query](reference/struct/query.html)
* [Summary](reference/struct/summary.html)

Mutations

* [Mutations](reference/mutations/mutations.html)
* [Collapse](reference/mutations/collapse.html)
* [Deletion](reference/mutations/deletion.html)
* [Expansion](reference/mutations/expansion.html)
* [Induction](reference/mutations/induction.html)
* [Induction and Expansion](reference/mutations/induction_expansion.html)
* [Inference](reference/mutations/inference.html)
* [Metadata](reference/mutations/metadata.html)

Conversion

* [Input and Output](reference/io.html)

Database

* [Manager](reference/database/manager.html)
* [Models](reference/database/models.html)

Topic Guide

* [Cookbook](topics/cookbook.html)
* [Command Line Interface](topics/cli.html)

Reference

* [Constants](reference/constants.html)
* [Parsers](reference/parser.html)
* [Internal Domain Specific Language](reference/dsl.html)
* [Logging Messages](reference/logging.html)

Project

* [References](meta/references.html)
* [Current Issues](meta/postmortem.html)
* [Technology](meta/technology.html)

PyBEL

* »
* PyBEL 0.15.6-dev Documentation
* [Edit on GitHub](https://github.com/pybel/pybel/blob/master/docs/source/index.rst)

---

# PyBEL 0.15.6-dev Documentation[](#pybel-release-documentation "Permalink to this headline")

Biological Expression Language (BEL) is a domain-specific language that enables the expression of complex molecular
relationships and their context in a machine-readable form. Its simple grammar and expressive power have led to its
successful use in the to describe complex disease networks with several thousands of relationships.

PyBEL is a pure Python software package that parses BEL documents, validates their semantics, and facilitates data
interchange between common formats and database systems like JSON, CSV, Excel, SQL, CX, and Neo4J. Its companion
package, [PyBEL-Tools](http://pybel-tools.readthedocs.io/), contains a library of functions for analysis of
biological networks. For result-oriented guides, see the [PyBEL-Notebooks](https://github.com/pybel/pybel-notebooks)
repository.

Installation is as easy as getting the code from [PyPI](https://pypi.python.org/pypi/pybel) with
`python3 -m pip install pybel`. See the [installation](introduction/installation.html) documentation.

For citation information, see the [references](meta/references.html) page.

PyBEL is tested on Python 3.5+ on Mac OS and Linux using
[Travis CI](https://travis-ci.org/pybel/pybel) as well as on Windows using
[AppVeyor](https://ci.appveyor.com/project/cthoyt/pybel).

See also

* Specified by [BEL 1.0](https://github.com/OpenBEL/language/raw/master/docs/version_1.0/bel_specification_version_1.0.pdf),
  [BEL 2.0](https://github.com/OpenBEL/language/raw/master/docs/version_2.0/bel_specification_version_2.0.pdf), and
  [BEL 2.0+](https://biological-expression-language.github.io)
* Documented on [Read the Docs](http://pybel.readthedocs.io/)
* Versioned on [GitHub](https://github.com/pybel/pybel)
* Tested on [Travis CI](https://travis-ci.org/pybel/pybel)
* Distributed by [PyPI](https://pypi.python.org/pypi/pybel)

Getting Started

* [Overview](introduction/overview.html)
  + [Background on Systems Biology Modeling](introduction/overview.html#background-on-systems-biology-modeling)
  + [Design Considerations](introduction/overview.html#design-considerations)
  + [Implementation](introduction/overview.html#implementation)
  + [Extensions to BEL](introduction/overview.html#extensions-to-bel)
  + [Things to Consider](introduction/overview.html#things-to-consider)
* [Installation](introduction/installation.html)
  + [Extras](introduction/installation.html#extras)
  + [Caveats](introduction/installation.html#caveats)
  + [Upgrading](introduction/installation.html#upgrading)

Data Structure

* [Data Model](reference/struct/datamodel.html)
  + [Constants](reference/struct/datamodel.html#constants)
  + [Graph](reference/struct/datamodel.html#graph)
  + [Nodes](reference/struct/datamodel.html#nodes)
  + [Unqualified Edges](reference/struct/datamodel.html#unqualified-edges)
  + [Edges](reference/struct/datamodel.html#edges)
* [Example Networks](reference/struct/examples.html)
* [Filters](reference/struct/filters.html)
* [Grouping](reference/struct/grouping.html)
* [Operations](reference/struct/operators.html)
* [Pipeline](reference/struct/pipeline.html)
  + [Transformation Decorators](reference/struct/pipeline.html#module-pybel.struct.pipeline.decorators)
  + [Exceptions](reference/struct/pipeline.html#module-pybel.struct.pipeline.exc)
* [Query](reference/struct/query.html)
* [Summary](reference/struct/summary.html)

Mutations

* [Mutations](reference/mutations/mutations.html)
* [Collapse](reference/mutations/collapse.html)
* [Deletion](reference/mutations/deletion.html)
* [Expansion](reference/mutations/expansion.html)
* [Induction](reference/mutations/induction.html)
* [Induction and Expansion](reference/mutations/induction_expansion.html)
* [Inference](reference/mutations/inference.html)
* [Metadata](reference/mutations/metadata.html)

Conversion

* [Input and Output](reference/io.html)
  + [Import](reference/io.html#import)
  + [Transport](reference/io.html#transport)
  + [Visualization](reference/io.html#visualization)
  + [Analytical Services](reference/io.html#analytical-services)
  + [Web Services](reference/io.html#web-services)
  + [Databases](reference/io.html#databases)
  + [Lossy Export](reference/io.html#lossy-export)

Database

* [Manager](reference/database/manager.html)
  + [Manager API](reference/database/manager.html#manager-api)
  + [Manager Components](reference/database/manager.html#manager-components)
* [Models](reference/database/models.html)

Topic Guide

* [Cookbook](topics/cookbook.html)
  + [Configuration](topics/cookbook.html#configuration)
* [Command Line Interface](topics/cli.html)
  + [pybel](topics/cli.html#pybel)

Reference

* [Constants](reference/constants.html)
* [Parsers](reference/parser.html)
  + [BEL Parser](reference/parser.html#bel-parser)
  + [Metadata Parser](reference/parser.html#metadata-parser)
  + [Control Parser](reference/parser.html#control-parser)
  + [Concept Parser](reference/parser.html#concept-parser)
  + [Sub-Parsers](reference/parser.html#module-pybel.parser.modifiers)
* [Internal Domain Specific Language](reference/dsl.html)
  + [Primitives](reference/dsl.html#primitives)
  + [Named Entities](reference/dsl.html#named-entities)
  + [Central Dogma](reference/dsl.html#central-dogma)
    - [Variants](reference/dsl.html#variants)
  + [Fusions](reference/dsl.html#fusions)
    - [Fusion Ranges](reference/dsl.html#fusion-ranges)
    - [List Abundances](reference/dsl.html#list-abundances)
  + [Utilities](reference/dsl.html#utilities)
* [Logging Messages](reference/logging.html)

Project

* [References](meta/references.html)
  + [Related Publications](meta/references.html#related-publications)
  + [Software using PyBEL](meta/references.html#software-using-pybel)
  + [BEL Content](meta/references.html#bel-content)
* [Current Issues](meta/postmortem.html)
  + [Speed](meta/postmortem.html#speed)
  + [Namespaces](meta/postmortem.html#namespaces)
  + [Testing](meta/postmortem.html#testing)
* [Technology](meta/technology.html)
  + [Versioning](meta/technology.html#versioning)
  + [Testing in PyBEL](meta/technology.html#testing-in-pybel)
    - [Unit Testing](meta/technology.html#unit-testing)
    - [Integration Testing](meta/technology.html#integration-testing)
    - [Tox](meta/technology.html#tox)
    - [Continuous Integration](meta/technology.html#continuous-integration)
    - [Code Coverage](meta/technology.html#code-coverage)
    - [Versioning](meta/technology.html#id2)
  + [Deployment](meta/technology.html#deployment)
    - [Steps](meta/technology.html#steps)

## Indices and Tables[](#indices-and-tables "Permalink to this headline")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

[Next](introduction/overview.html "Overview")

---

© Copyright 2016-2022, Charles Tapley Hoyt.
Revision `ed66f013`.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).