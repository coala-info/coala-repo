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
* Downloading test datasets
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

[View this page](_sources/downloading_test_datasets.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Downloading test datasets[¶](#downloading-test-datasets "Link to this heading")

Test datasets for `hictk` are hosted on Zenodo: [doi.org/10.5281/zenodo.8121686](https://doi.org/10.5281/zenodo.8121686)

After downloading the data, move to a folder with at least ~1 GB of free space and extract the test datasets:

```
user@dev:/tmp$ mkdir data/
user@dev:/tmp$ tar -xf hictk_test_data.tar.zst         \
                   -C data --strip-components=3        \
                   test/data/hic/4DNFIZ1ZVXC8.hic9     \
                   test/data/cooler/4DNFIZ1ZVXC8.mcool \
                   test/data/interactions/4DNFIKNWM36K.subset.pairs.xz

user@dev:/tmp$ ls -lah data
total 261M
drwx------  2 dev dev   80 Sep 29 17:00 .
drwxrwxrwt 26 dev dev  960 Sep 29 17:00 ..
-rw-------  1 dev dev 125M Jun 26  2023 4DNFIKNWM36K.subset.pairs.xz
-rw-------  1 dev dev 128M Jun  8  2023 4DNFIZ1ZVXC8.hic9
-rw-------  1 dev dev 133M Jul  7  2023 4DNFIZ1ZVXC8.mcool
```

[Next

File validation](file_validation.html)
[Previous

Quickstart (API)](quickstart_api.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)