[EsViritu](.)

* Home
  + [Why use EsViritu?](#why-use-esviritu)
  + [Getting started](#getting-started)
  + [Citation](#citation)

* [Installation](installation/)

* [Pipeline Description](pipeline-description/)

* [Using EsViritu](esviritu-usage/)

* [Data Directory](data-directory/)

* [Interpretting Outputs](interpretting-outputs/)

* [Making Custom Databases](custom-database/)

* [Notable Changes in v1](notable-changes/)

[EsViritu](.)

* Home
* [Edit on cmmr/EsViritu](https://github.com/cmmr/EsViritu/blob/main/docs/index.md)

---

# EsViritu

EsViritu is a read mapping pipeline for detection and measurement of human and animal virus pathogens using sequencing reads from metagenomic environmental or clinical samples.

* Source code: <https://github.com/cmmr/EsViritu>
* Project README: <https://github.com/cmmr/EsViritu/blob/main/README.md>

## Why use `EsViritu`?

This approach is sensitive, specific, and ideal for exploring virus presence/absence/diversity within and between metagenomic or clinical samples. Interactive reports make it easy to see the breadth of read coverage for each detected virus. This tool should reliably detect virus reads with 80% ANI or greater to reference genomes.

Note

The database used by `Esviritu` should cover all human and animal viruses in GenBank as of October 2025 (EsViritu DB v3.2.4). However, the genomes are dereplicated at 95% ANI so that only one genome from a nearly identical group is used. Please open an issue to report any omissions.

## Getting started

If [installed](installation/) as a package, command-line entry points are available:

* `EsViritu --help`
* `summarize_esv_runs --help`

Tip

Read the other pages of the documentation to understand what `EsViritu` does and how to interpret its outputs.

* [Usage](esviritu-usage/)
* [Interpretting Outputs](interpretting-outputs/)
* [Making Custom Databases](custom-database/)

## Citation

**Wastewater sequencing reveals community and variant dynamics of the collective human virome**

Michael Tisza, Sara Javornik Cregeen, Vasanthi Avadhanula, Ping Zhang, Tulin Ayvaz, Karen Feliz, Kristi L. Hoffman, Justin R. Clark, Austen Terwilliger, Matthew C. Ross, Juwan Cormier, David Henke, Catherine Troisi, Fuqing Wu, Janelle Rios, Jennifer Deegan, Blake Hansen, John Balliew, Anna Gitter, Kehe Zhang, Runze Li, Cici X. Bauer, Kristina D. Mena, Pedro A. Piedra, Joseph F. Petrosino, Eric Boerwinkle, Anthony W. Maresso

https://doi.org/10.1038/s41467-023-42064-1

[Next](installation/ "Installation")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).