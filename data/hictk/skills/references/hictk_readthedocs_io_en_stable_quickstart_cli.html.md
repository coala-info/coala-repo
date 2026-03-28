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

[hictk documentation](index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](index.html)

Installation

* [Installation](installation.html)
* [Installation (source)](installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](faq.html)

Getting Started

* Quickstart (CLI)
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

[View this page](_sources/quickstart_cli.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Quickstart (CLI)[¶](#quickstart-cli "Link to this heading")

First, install hictk with one of the methods listed in the [Installation](installation.html) section.

Next, verify that hictk was installed correctly with:

```
user@dev:/tmp$ hictk --version
hictk-v2.2.0
```

## Command line interface[¶](#command-line-interface "Link to this heading")

hictk CLI supports performing common operations on .hic and .cool files directly from the shell.

### Verifying file integrity[¶](#verifying-file-integrity "Link to this heading")

```
hictk validate interactions.cool --validate-index

hictk validate interactions.hic
```

For more detailed examples refer to [File validation](file_validation.html)

### Reading interactions[¶](#reading-interactions "Link to this heading")

hictk supports reading interactions from .hic and .cool files through the `hictk dump` command:

```
user@dev:/tmp$ hictk dump interactions.cool
0     0       1745
0     1       2844
0     2       409
...

user@dev:/tmp$ hictk dump interactions.cool --join
chr2L 0       10000   chr2L   0       10000   1745
chr2L 0       10000   chr2L   10000   20000   2844
chr2L 0       10000   chr2L   20000   30000   409
...
```

For more detailed examples refer to [Reading interactions](reading_interactions.html)

### Other operations[¶](#other-operations "Link to this heading")

* [Balancing Hi-C matrices](balancing_matrices.html)
* [Converting single-resolution files to multi-resolution](creating_multires_files.html)
* [Creating .cool and .hic files](creating_cool_and_hic_files.html)
* [Dumping tabular information to stdout](reading_interactions.html)
* [File validation](file_validation.html)
* [Format conversion](format_conversion.html)
* [Reading file metadata](file_metadata.html)

## API[¶](#api "Link to this heading")

Refer to [Quickstart (API)](quickstart_api.html).

[Next

Quickstart (API)](quickstart_api.html)
[Previous

Frequently Asked Questions (FAQ)](faq.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Quickstart (CLI)
  + [Command line interface](#command-line-interface)
    - [Verifying file integrity](#verifying-file-integrity)
    - [Reading interactions](#reading-interactions)
    - [Other operations](#other-operations)
  + [API](#api)