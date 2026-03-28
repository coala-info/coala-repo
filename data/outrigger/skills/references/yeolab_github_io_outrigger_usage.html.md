# Usage[¶](#usage "Permalink to this headline")

To use `outrigger`, you must perform at least steps 1 and 3:

1. `outrigger index` to read all your junctions in and create a database of alternatively spliced exons.
2. `outrigger validate` to filter your splicing events for only those with valid introns. (optional)
3. `outrigger psi` to calculate percent spliced in on your splicing events.

[![OutriggerOverview](_images/outrigger_overview-300ppi.png)](_static/outrigger_overview-300ppi.png)

Each of these commands deserves its own page of explanation, so look at the links below.

Contents:

* [`index`: Build a *de novo* splicing annotation index of events custom to **your** data](subcommands/outrigger_index.html)
  + [Overview](subcommands/outrigger_index.html#overview)
  + [Inputs](subcommands/outrigger_index.html#inputs)
  + [Outputs](subcommands/outrigger_index.html#outputs)
* [`validate`: Check that the found exons are real](subcommands/outrigger_validate.html)
  + [Overview](subcommands/outrigger_validate.html#overview)
  + [Inputs](subcommands/outrigger_validate.html#inputs)
  + [Outputs](subcommands/outrigger_validate.html#outputs)
* [`psi`: Calculate percent spliced-in (Psi/Ψ) scores for your data from the splicing events you created](subcommands/outrigger_psi.html)
  + [Overview](subcommands/outrigger_psi.html#overview)
  + [Inputs](subcommands/outrigger_psi.html#inputs)
  + [Outputs](subcommands/outrigger_psi.html#outputs)

[![Logo](_static/logo-150px.png)](index.html)

### [Table Of Contents](index.html)

* [Home](index.html)
* [Contents](contents.html)
* [Install](installation.html)
* [Usage](Usage.html)
* [`index`: Detect exons](subcommands/outrigger_index.html)
* [`validate`: Remove non-canonical splice sites](subcommands/outrigger_validate.html)
* [`psi`: Quantify exon inclusion](subcommands/outrigger_psi.html)
* [Changelog](history.html)
* [License](license.html)

### Quick search

©2015-2017, Olga Botvinnik.
|
Powered by [Sphinx 1.4.8](http://sphinx-doc.org/)
& [Alabaster 0.7.9](https://github.com/bitprophet/alabaster)
|
[Page source](_sources/usage.txt)