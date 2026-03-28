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
* [File metadata](file_metadata.html)
* [Format conversion](format_conversion.html)
* Reading interactions
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

[View this page](_sources/reading_interactions.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Reading interactions[¶](#reading-interactions "Link to this heading")

`hictk` supports reading interactions from .hic and .cool files using the `hictk dump` command.

By default, interactions are dumped to stdout in COO format (row, column, count):

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp

7   7   1745
7   12  1766
7   17  1078
...
```

Use the option `--join` to instead dump interactions in bedgraph2 format:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.mcool --resolution 1kbp --join | head -n 3

chr2L 7000    8000    chr2L   7000    8000    1745
chr2L 7000    8000    chr2L   12000   13000   1766
chr2L 7000    8000    chr2L   17000   18000   1078
```

All operations work on .hic as well as .[m]cool files:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.mcool --resolution 1kbp | head -n 3

7   7   1745
7   12  1766
7   17  1078

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.mcool::/resolutions/1000 | head -n 3

7   7   1745
7   12  1766
7   17  1078
```

Dump balanced or expected interactions:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --join --balance SCALE | head -n 3

chr2L 7000    8000    chr2L   7000    8000    1681.679565429688
chr2L 7000    8000    chr2L   12000   13000   1386.554565429688
chr2L 7000    8000    chr2L   17000   18000   878.9703979492188

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --join --matrix-type expected | head -n 3

chr2L 7000    8000    chr2L   7000    8000    88.33206176757812
chr2L 7000    8000    chr2L   12000   13000   63.43805313110352
chr2L 7000    8000    chr2L   17000   18000   31.78345680236816
```

Dump interactions overlapping a region of interest:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --join --range chr3L:20,000,000-25,000,000 | head -n 3

chr3L 20002000        20003000        chr3L   20002000        20003000        2390
chr3L 20002000        20003000        chr3L   20007000        20008000        1285
chr3L 20002000        20003000        chr3L   20012000        20013000        490

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --join --range chr3L:20,000,000-25,000,000 --range2 chrX | head -n 3

chr3L 20002000        20003000        chrX    52000     53000   1
chr3L 20002000        20003000        chrX    157000  158000  1
chr3L 20002000        20003000        chrX    352000  353000  1
```

Dump tables other than pixels:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --table chroms | head -n 3

chr2L 23513712
chr2R 25286936
chr3L 28110227

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --table normalizations

SCALE
VC
VC_SQRT

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --table resolutions | head -n 3

1000
5000
10000
```

See hictk dump help message for the complete list of supported tables.

Dump cis or trans interactions only:

```
user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --cis-only --join | head -n 3

chr2L 7000    8000    chr2L   7000    8000    1745
chr2L 7000    8000    chr2L   12000   13000   1766
chr2L 7000    8000    chr2L   17000   18000   1078

user@dev:/tmp$ hictk dump data/4DNFIZ1ZVXC8.hic9 --resolution 1kbp --trans-only --join | head -n 3

chr2L 7000    8000    chr2R   27000   28000   1
chr2L 7000    8000    chr2R   322000  323000  1
chr2L 7000    8000    chr2R   397000  398000  1
```

[Next

Creating .cool and .hic files](creating_cool_and_hic_files.html)
[Previous

Format conversion](format_conversion.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)