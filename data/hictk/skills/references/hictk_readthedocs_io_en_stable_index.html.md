Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

[Skip to content](#furo-main-content)

Toggle site navigation sidebar

hictk documentation

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

hictk documentation

Installation

* [Installation](installation.html)
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* [Quickstart (CLI)](quickstart_cli.html)
* [Quickstart (API)](quickstart_api.html)
* [Downloading test datasets](downloading_test_datasets.html)
* [File validation](file_validation.html)
* [File metadata](file_metadata.html)
* [Format conversion](format_conversion.html)
* [Reading interactions](reading_interactions.html)
* [Creating .cool and .hic files](creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](creating_multires_files.html)
* [Balancing Hi-C matrices](balancing_matrices.html)

How-Tos

* [Reorder chromosomes](tutorials/reordering_chromosomes.html)
* [Dump interactions to .cool or .hic file](tutorials/dump_interactions_to_cool_hic_file.html)

CLI and API Reference

* [CLI Reference](cli_reference.html)
* [C++ API Reference](cpp_api/index.html)[ ]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](telemetry.html)

Back to top

[View this page](_sources/index.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Introduction[¶](#introduction "Link to this heading")

hictk is a blazing fast toolkit to work with .hic and .cool files.

hictk is capable of reading and writing files in .cool, .mcool, .scool, and .hic format (including hic v9).

## Documentation formats[¶](#documentation-formats "Link to this heading")

You are reading the HTML version of the documentation. An alternative [PDF
version](https://hictk.readthedocs.io/_/downloads/en/stable/pdf/) is
also available.

## Installation[¶](#installation "Link to this heading")

hictk is developed on Linux and tested on Linux, macOS, and Windows. CLI tools can be installed in several different ways. Refer to [Installation](installation.html) for more details.

hictk can be compiled on most UNIX-like systems (including many Linux distributions and macOS) as well as Windows. See the [build instructions](installation_src.html) for more details.

hictk can be used from languages other than C++ through the following bindings:

* Python bindings through [hictkpy](https://github.com/paulsengroup/hictkpy)
* R bindings through [hictkR](https://github.com/paulsengroup/hictkR)

## How to cite this project?[¶](#how-to-cite-this-project "Link to this heading")

Please use the following BibTeX template to cite hictk in scientific
discourse:

```
@article{hictk,
    author = {Rossini, Roberto and Paulsen, Jonas},
    title = "{hictk: blazing fast toolkit to work with .hic and .cool files}",
    journal = {Bioinformatics},
    volume = {40},
    number = {7},
    pages = {btae408},
    year = {2024},
    month = {06},
    issn = {1367-4811},
    doi = {10.1093/bioinformatics/btae408},
    url = {https://doi.org/10.1093/bioinformatics/btae408},
    eprint = {https://academic.oup.com/bioinformatics/article-pdf/40/7/btae408/58385157/btae408.pdf},
}
```

## Table of contents[¶](#table-of-contents "Link to this heading")

Installation

* [Installation](installation.html)
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* [Quickstart (CLI)](quickstart_cli.html)
* [Quickstart (API)](quickstart_api.html)
* [Downloading test datasets](downloading_test_datasets.html)
* [File validation](file_validation.html)
* [File metadata](file_metadata.html)
* [Format conversion](format_conversion.html)
* [Reading interactions](reading_interactions.html)
* [Creating .cool and .hic files](creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](creating_multires_files.html)
* [Balancing Hi-C matrices](balancing_matrices.html)

How-Tos

* [Reorder chromosomes](tutorials/reordering_chromosomes.html)
  + [TLDR](tutorials/reordering_chromosomes.html#tldr)
  + [Why is this needed?](tutorials/reordering_chromosomes.html#why-is-this-needed)
  + [Walkthrough](tutorials/reordering_chromosomes.html#walkthrough)
  + [Tips and tricks](tutorials/reordering_chromosomes.html#tips-and-tricks)
* [Dump interactions to .cool or .hic file](tutorials/dump_interactions_to_cool_hic_file.html)
  + [TLDR](tutorials/dump_interactions_to_cool_hic_file.html#tldr)
  + [Why is this needed?](tutorials/dump_interactions_to_cool_hic_file.html#why-is-this-needed)
  + [Walkthrough](tutorials/dump_interactions_to_cool_hic_file.html#walkthrough)
  + [Tips and tricks](tutorials/dump_interactions_to_cool_hic_file.html#tips-and-tricks)

CLI and API Reference

* [CLI Reference](cli_reference.html)
  + [Subcommands](cli_reference.html#subcommands)
  + [hictk balance](cli_reference.html#hictk-balance)
  + [hictk balance ice](cli_reference.html#hictk-balance-ice)
  + [hictk balance scale](cli_reference.html#hictk-balance-scale)
  + [hictk balance vc](cli_reference.html#hictk-balance-vc)
  + [hictk convert](cli_reference.html#hictk-convert)
  + [hictk dump](cli_reference.html#hictk-dump)
  + [hictk fix-mcool](cli_reference.html#hictk-fix-mcool)
  + [hictk load](cli_reference.html#hictk-load)
  + [hictk merge](cli_reference.html#hictk-merge)
  + [hictk metadata](cli_reference.html#hictk-metadata)
  + [hictk rename-chromosomes](cli_reference.html#hictk-rename-chromosomes)
  + [hictk validate](cli_reference.html#hictk-validate)
  + [hictk zoomify](cli_reference.html#hictk-zoomify)
* [C++ API Reference](cpp_api/index.html)
  + [Generic API](cpp_api/generic.html)
  + [Cooler API](cpp_api/cooler.html)
  + [Hi-C API](cpp_api/hic.html)
  + [Shared Types](cpp_api/shared.html)
  + [Pixel transformers](cpp_api/transformers.html)
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](telemetry.html)

[Next

Installation](installation.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Introduction
  + [Documentation formats](#documentation-formats)
  + [Installation](#installation)
  + [How to cite this project?](#how-to-cite-this-project)
  + [Table of contents](#table-of-contents)