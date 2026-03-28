ENASearch

0.2.0

ENASearch documentation

* [Installation](installation.html)
* [Some example of usage](use_case.html)
* [Interacting with ENA Database](ena.html)
* [Usage with command-line](cli_usage.html)
* [Usage within Python](api_usage.html)
* [Contributing](contributing.html)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

ENASearch

* Docs »
* Welcome to ENASearch’s documentation!

---

# Welcome to ENASearch’s documentation![¶](#welcome-to-enasearch-s-documentation "Permalink to this headline")

The [European Nucleotide Archive (ENA)](https://www.ebi.ac.uk/ena) is a database with a comprehensive record of nucleotide sequencing information (raw sequencing data, sequence assembly information and functional annotation). The data contained in ENA can be accessed manually or programmatically via [REST URLs](http://www.ebi.ac.uk/ena/browse/programmatic-access). However, building HTTP-based REST requests is not always straightforward - a user friendly, high-level access is needed to make it easier to interact with ENA programmatically.

We developed ENASearch, a Python library to search and retrieve data from ENA database. It also allows for rich querying support by accessing different fields, filters or functions offered by ENA. ENASearch can be used as a Python package, through a command-line interface or inside Galaxy.

ENASearch documentation

* [Installation](installation.html)
  + [Via pip](installation.html#via-pip)
  + [Via Conda](installation.html#via-conda)
  + [On Galaxy](installation.html#on-galaxy)
* [Some example of usage](use_case.html)
  + [Original use case](use_case.html#original-use-case)
  + [Search and retrieve data](use_case.html#search-and-retrieve-data)
* [Interacting with ENA Database](ena.html)
  + [Data](ena.html#data)
  + [Programmatic access](ena.html#programmatic-access)
* [Usage with command-line](cli_usage.html)
  + [Commands](cli_usage.html#commands)
    - [enasearch](cli_usage.html#enasearch)
      * [get\_analysis\_fields](cli_usage.html#enasearch-get-analysis-fields)
      * [get\_display\_options](cli_usage.html#enasearch-get-display-options)
      * [get\_download\_options](cli_usage.html#enasearch-get-download-options)
      * [get\_filter\_fields](cli_usage.html#enasearch-get-filter-fields)
      * [get\_filter\_types](cli_usage.html#enasearch-get-filter-types)
      * [get\_results](cli_usage.html#enasearch-get-results)
      * [get\_returnable\_fields](cli_usage.html#enasearch-get-returnable-fields)
      * [get\_run\_fields](cli_usage.html#enasearch-get-run-fields)
      * [get\_sortable\_fields](cli_usage.html#enasearch-get-sortable-fields)
      * [get\_taxonomy\_results](cli_usage.html#enasearch-get-taxonomy-results)
      * [retrieve\_analysis\_report](cli_usage.html#enasearch-retrieve-analysis-report)
      * [retrieve\_data](cli_usage.html#enasearch-retrieve-data)
      * [retrieve\_run\_report](cli_usage.html#enasearch-retrieve-run-report)
      * [retrieve\_taxons](cli_usage.html#enasearch-retrieve-taxons)
      * [search\_data](cli_usage.html#enasearch-search-data)
* [Usage within Python](api_usage.html)
  + [Functions](api_usage.html#module-enasearch)
  + [Data](api_usage.html#data)
* [Contributing](contributing.html)
  + [What should I know before I get started?](contributing.html#what-should-i-know-before-i-get-started)
  + [How can I contribute?](contributing.html#how-can-i-contribute)
    - [Reporting mistakes or errors](contributing.html#reporting-mistakes-or-errors)
    - [Your first content contribution](contributing.html#your-first-content-contribution)
  + [Tests](contributing.html#tests)
  + [Documentation](contributing.html#documentation)
  + [Update the data](contributing.html#update-the-data)
* [Source code on GitHub](https://github.com/bebatut/enasearch)

[Next](installation.html "Installation")

---

© Copyright 2017, Bérénice Batut.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).