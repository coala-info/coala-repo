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

* [Quickstart (CLI)](quickstart_cli.html)
* [Quickstart (API)](quickstart_api.html)
* [Downloading test datasets](downloading_test_datasets.html)
* [File validation](file_validation.html)
* File metadata
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

[View this page](_sources/file_metadata.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# File metadata[¶](#file-metadata "Link to this heading")

`hictk metadata` can be used to read metadata from any Cooler file (that is, .cool, .mcool, and .scool files) as well as .hic files.

## Fetching metadata from single-resolution files[¶](#fetching-metadata-from-single-resolution-files "Link to this heading")

The following shows how to use `hictk metadata` to access metadata information stored in single-resolution Cooler files (or URIs, as shown in the example below):

```
user@dev:/tmp$ hictk metadata data/4DNFIZ1ZVXC8.mcool::/resolutions/1000

{
    "assembly": "dm6",
    "bin-size": 1000,
    "bin-type": "fixed",
    "creation-date": "2023-07-07T14:15:30.759988",
    "format": "HDF5::Cooler",
    "format-url": "https://github.com/4dn-dcic/hic2cool",
    "format-version": 3,
    "generated-by": "hic2cool-0.8.3",
    "nbins": 137572,
    "nchroms": 8,
    "nnz": 26591454,
    "storage-mode": "symmetric-upper"
}
```

By default, `hictk metadata` outputs information in JSON format.
However, the output format can be changed using the `--output-format` CLI options (currently, `json`, `toml`, and `yaml` formats are supported).

## Fetching metadata from multi-resolution files[¶](#fetching-metadata-from-multi-resolution-files "Link to this heading")

Next, we will look at how to fetch metadata from multi-resolution .hic and .mcool files.

```
user@dev:/tmp$ hictk metadata data/4DNFIZ1ZVXC8.hic9

{
    "assembly": "dm6",
    "format": "HIC",
    "format-url": "https://github.com/aidenlab/hic-format",
    "format-version": 9,
    "hicFileScalingFactor": 1.0,
    "nchroms": 8,
    "resolutions": [
        1000,
        5000,
        10000,
        25000,
        50000,
        100000,
        250000,
        500000,
        1000000,
        2500000
    ],
    "software": "Juicer Tools Version 3.30.00"
}
```

When dealing with multi-resolution and single-cell files, it is possible to also view metadata information of individual resolutions/cells by using the `--recursive` CLI flag:

```
user@dev:/tmp$ hictk metadata data/4DNFIZ1ZVXC8.mcool --recursive

{
    "1000": {
        "assembly": "dm6",
        "bin-size": 1000,
        "bin-type": "fixed",
        "creation-date": "2023-07-07T14:15:30.759988",
        "format": "HDF5::Cooler",
        "format-url": "https://github.com/4dn-dcic/hic2cool",
        "format-version": 3,
        "generated-by": "hic2cool-0.8.3",
        "nbins": 137572,
        "nchroms": 8,
        "nnz": 26591454,
        "storage-mode": "symmetric-upper"
    },
    ...
    "bin-type": "fixed",
    "format": "HDF5::MCOOL",
    "format-version": 2,
    "resolutions": [
        1000,
        5000,
        10000,
        25000,
        50000,
        100000,
        250000,
        500000,
        1000000,
        2500000
    ]
}
```

[Next

Format conversion](format_conversion.html)
[Previous

File validation](file_validation.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* File metadata
  + [Fetching metadata from single-resolution files](#fetching-metadata-from-single-resolution-files)
  + [Fetching metadata from multi-resolution files](#fetching-metadata-from-multi-resolution-files)