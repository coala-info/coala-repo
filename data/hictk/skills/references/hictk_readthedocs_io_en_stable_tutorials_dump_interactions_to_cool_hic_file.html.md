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

[hictk documentation](../index.html)

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

[hictk documentation](../index.html)

Installation

* [Installation](../installation.html)
* [Installation (source)](../installation_src.html)

FAQ

* [Frequently Asked Questions (FAQ)](../faq.html)

Getting Started

* [Quickstart (CLI)](../quickstart_cli.html)
* [Quickstart (API)](../quickstart_api.html)
* [Downloading test datasets](../downloading_test_datasets.html)
* [File validation](../file_validation.html)
* [File metadata](../file_metadata.html)
* [Format conversion](../format_conversion.html)
* [Reading interactions](../reading_interactions.html)
* [Creating .cool and .hic files](../creating_cool_and_hic_files.html)
* [Creating multi-resolution files (.hic and .mcool)](../creating_multires_files.html)
* [Balancing Hi-C matrices](../balancing_matrices.html)

How-Tos

* [Reorder chromosomes](reordering_chromosomes.html)
* Dump interactions to .cool or .hic file

CLI and API Reference

* [CLI Reference](../cli_reference.html)
* [C++ API Reference](../cpp_api/index.html)[ ]
* [Python API](https://hictkpy.readthedocs.io/en/stable/index.html)
* [R API](https://paulsengroup.github.io/hictkR/reference/index.html)

Telemetry

* [Telemetry](../telemetry.html)

Back to top

[View this page](../_sources/tutorials/dump_interactions_to_cool_hic_file.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Dump interactions to .cool or .hic file[¶](#dump-interactions-to-cool-or-hic-file "Link to this heading")

## TLDR[¶](#tldr "Link to this heading")

```
# Important! --bin-size should be the same resolution as matrix.cool
user@dev:/tmp hictk load - \
                         output.cool \
                         --chrom-sizes=<(hictk dump --table=chroms matrix.cool) \
                         --format=bg2 \
                         --bin-size=1kbp \
                         < <(hictk dump --join
                                        --range=2L:0-10,000,000
                                        --range2=3R:0-10,000,000
                                        matrix.cool)
```

## Why is this needed?[¶](#why-is-this-needed "Link to this heading")

`hictk dump` can read interactions from .cool, .mcool, and .hic files and write them in text format to stdout.
Additionally, `hictk dump` supports fetching interactions overlapping a pair of regions of interest through the `--range` and `--range2` CLI options.
However, instead of writing interactions to stdout, we may want to write them to a new .cool or .hic file.
This tutorial shows how this can be accomplished using `hictk dump` and `hictk load`.

## Walkthrough[¶](#walkthrough "Link to this heading")

For this tutorial, we will use file `4DNFIOTPSS3L.hic` as an example, which can be downloaded from [here](https://4dn-open-data-public.s3.amazonaws.com/fourfront-webprod/wfoutput/7386f953-8da9-47b0-acb2-931cba810544/4DNFIOTPSS3L.hic).

First, we extract the list of chromosomes from the input file:

```
user@dev:/tmp hictk dump 4DNFIOTPSS3L.hic --table=chroms | tee chrom.sizes

2L  23513712
2R  25286936
3L  28110227
3R  32079331
4   1348131
X   23542271
Y   3667352
```

Second, we dump pixels in bedGraph2 format (see below for how to make this step more efficient):

```
user@dev:/tmp hictk dump 4DNFIOTPSS3L.hic \
                         --join \
                         --resolution=1kbp \
                         --range=2L:5,000,000-10,000,000 \
                         --range2=3R:7,500,000-10,000,000 > pixels.bg2

user@dev:/tmp head pixels.bg2

2L  5000000 5001000 3R      7506000 7507000 1
2L  5000000 5001000 3R      7624000 7625000 1
2L  5000000 5001000 3R      7943000 7944000 1
2L  5000000 5001000 3R      8014000 8015000 1
2L  5000000 5001000 3R      8130000 8131000 1
2L  5000000 5001000 3R      8245000 8246000 1
2L  5000000 5001000 3R      8855000 8856000 1
2L  5000000 5001000 3R      9032000 9033000 1
2L  5000000 5001000 3R      9171000 9172000 1
2L  5000000 5001000 3R      9380000 9381000 1
```

Finally, we load pixels into a new .cool file

```
user@dev:/tmp hictk load pixels.bg2 \
                         output.cool \
                         --chrom-sizes=chrom.sizes \
                         --format=bg2 \
                         --bin-size=1kbp

[2024-09-27 18:54:58.532] [info]: Running hictk v1.0.0-fbdcb591
[2024-09-27 18:54:58.540] [info]: begin loading unsorted pixels into a .cool file...
[2024-09-27 18:54:58.629] [info]: writing chunk #1 to intermediate file "/tmp/hictk-tmp-XXXXatmfuM/output.cool.tmp"...
[2024-09-27 18:54:58.641] [info]: done writing chunk #1 to tmp file "/tmp/hictk-tmp-XXXXatmfuM/output.cool.tmp".
[2024-09-27 18:54:58.642] [info]: merging 1 chunks into "output.cool"...
[2024-09-27 18:54:58.672] [info]: ingested 26214 interactions (25085 nnz) in 0.139864314s!
```

### Removing empty chromosomes from the reference genome[¶](#removing-empty-chromosomes-from-the-reference-genome "Link to this heading")

This can be easily achieved by grepping `2L` and `3R` when generating the `chrom.sizes` file.

```
user@dev:/tmp hictk dump 4DNFIOTPSS3L.hic --table=chroms |
              grep -e '2L' -e '3R' |
              tee chrom.sizes

2L  23513712
3R  32079331
```

## Tips and tricks[¶](#tips-and-tricks "Link to this heading")

There is one potential problem with the above solution, and that is the size of file `pixels.bg2`
Luckily, we can completely avoid generating this file by using output redirection and process substitutions:

```
user@dev:/tmp hictk load - \
                         output.cool \
                         --chrom-sizes=chrom.sizes \
                         --format=bg2 \
                         --bin-size=1kbp \
                         < <(hictk dump 4DNFIOTPSS3L.hic \
                                        --join \
                                        --resolution=1kbp \
                                        --range=2L:0-10,000,000 \
                                        --range2=3R:0-10,000,000)
```

Note that hictk still needs to generate some temporary file to load interactions into a new .cool or .hic file.
When processing large files, it is a good idea to specify custom folder where to create temporary files through the `--tmpdir` flag:

```
user@dev:/tmp hictk load - \
                         output.cool \
                         --chrom-sizes=chrom.sizes \
                         --format=bg2 \
                         --bin-size=1kbp \
                         --tmpdir=/var/tmp/ \
                         < <(hictk dump 4DNFIOTPSS3L.hic \
                                        --join \
                                        --resolution=1kbp \
                                        --range=2L:0-10,000,000 \
                                        --range2=3R:0-10,000,000)
```

Another option you may want to consider when working with .hic files, is the `--threads` option, which can significantly reduce the time required to load interactions into .hic files.

[Next

CLI Reference](../cli_reference.html)
[Previous

Reorder chromosomes](reordering_chromosomes.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Dump interactions to .cool or .hic file
  + [TLDR](#tldr)
  + [Why is this needed?](#why-is-this-needed)
  + [Walkthrough](#walkthrough)
    - [Removing empty chromosomes from the reference genome](#removing-empty-chromosomes-from-the-reference-genome)
  + [Tips and tricks](#tips-and-tricks)