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
* [Reading interactions](reading_interactions.html)
* Creating .cool and .hic files
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

[View this page](_sources/creating_cool_and_hic_files.rst.txt "View this page")

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# Creating .cool and .hic files[¶](#creating-cool-and-hic-files "Link to this heading")

hictk supports creating .cool and .hic files from text files in the following formats:

* [pairs (4DN-DCIC)](https://github.com/4dn-dcic/pairix/blob/master/pairs_format_specification.md#example-pairs-file)
* [validPairs (nf-core/hic)](https://nf-co.re/hic/2.1.0/docs/output/#valid-pairs-detection-with-hic-pro)
* [bedGraph2 (BG2)](https://cooler.readthedocs.io/en/latest/datamodel.html#genomically-labeled-arrays)
* [COO](https://cooler.readthedocs.io/en/latest/datamodel.html#genomically-labeled-arrays)

The section below show some examples of what files in the above formats look like

Tip

**4DN-DCIC pairs**

```
## pairs format v1.0.0
#sorted: chr1-chr2-pos1-pos2
#shape: upper triangle
#genome_assembly: unknown
#chromsize: chr2L 23513712
#chromsize: chr2R 25286936
#chromsize: chr3L 28110227
#chromsize: chr3R 32079331
#chromsize: chr4 1348131
#chromsize: chrX 23542271
#chromsize: chrY 3667352
#columns: readID chrom1 pos1 chrom2 pos2 strand1 strand2 pair_type mapq1 mapq2
NS500537:79:HFYYWBGX2:3:13607:23885:10200	chr2L	5094	chr2L	13096	+	+	UU	12	60
NS500537:79:HFYYWBGX2:4:11606:23060:8702	chr2L	5102	chr2L	7512	+	+	UU	13	60
NB500947:283:HHKN3BGX2:4:12603:11442:19845	chr2L	5142	chr2L	5424	+	-	UU	56	60
NS500537:79:HFYYWBGX2:3:21602:25370:1188	chr2L	5158	chr2L	5579343	+	+	UU	27	60
NB500947:283:HHKN3BGX2:1:12310:9917:10061	chr2L	5161	chr2L	13625	-	-	UU	54	60
NB500947:283:HHKN3BGX2:4:11510:19146:13622	chr2L	5164	chr2L	24518	-	-	UU	60	60
NB500947:283:HHKN3BGX2:4:21609:3786:9179	chr2L	5169	chr2L	5304	+	-	UU	33	60
NB500947:283:HHKN3BGX2:4:21512:6352:4317	chr2L	5181	chr2L	5836	-	+	UU	27	60
```

**validPairs**

```
NS500537:79:HFYYWBGX2:3:13607:23885:10200	chr2L	5094	+	chr2L	13096	+	1	frag1	frag2	1	1	allele-info
NS500537:79:HFYYWBGX2:4:11606:23060:8702	chr2L	5102	+	chr2L	7512	+	1	frag1	frag2	1	1	allele-info
NB500947:283:HHKN3BGX2:4:12603:11442:19845	chr2L	5142	+	chr2L	5424	-	1	frag1	frag2	1	1	allele-info
NS500537:79:HFYYWBGX2:3:21602:25370:1188	chr2L	5158	+	chr2L	5579343	+	1	frag1	frag2	1	1	allele-info
NB500947:283:HHKN3BGX2:1:12310:9917:10061	chr2L	5161	-	chr2L	13625	-	1	frag1	frag2	1	1	allele-info
NB500947:283:HHKN3BGX2:4:11510:19146:13622	chr2L	5164	-	chr2L	24518	-	1	frag1	frag2	1	1	allele-info
NB500947:283:HHKN3BGX2:4:21609:3786:9179	chr2L	5169	+	chr2L	5304	-	1	frag1	frag2	1	1	allele-info
NB500947:283:HHKN3BGX2:4:21512:6352:4317	chr2L	5181	-	chr2L	5836	+	1	frag1	frag2	1	1	allele-info
```

**BG2**

```
chr2L	0	10000	chr2L	0	10000	155
chr2L	0	10000	chr2L	10000	20000	248
chr2L	0	10000	chr2L	20000	30000	43
chr2L	0	10000	chr2L	30000	40000	12
chr2L	0	10000	chr2L	40000	50000	20
chr2L	0	10000	chr2L	50000	60000	15
chr2L	0	10000	chr2L	60000	70000	9
chr2L	0	10000	chr2L	70000	80000	10
```

**COO**

```
0	0	155
0	1	248
0	2	43
0	3	12
0	4	20
0	5	15
0	6	9
0	7	10
```

Important

The following files are required to follow along with the examples below:

* `dm6.chrom.sizes` - [download](https://hgdownload.cse.ucsc.edu/goldenpath/dm6/bigZips/dm6.chrom.sizes)
* `4DNFIKNWM36K.pairs.gz` - [download](https://4dn-open-data-public.s3.amazonaws.com/fourfront-webprod/wfoutput/930ba072-05ac-4382-9a92-369517184ec7/4DNFIKNWM36K.pairs.gz)

## Ingesting pairwise interactions into a 10kbp .cool file[¶](#ingesting-pairwise-interactions-into-a-10kbp-cool-file "Link to this heading")

Loading interactions in pairs (4DN-DCIC) format into a .cool/hic file is straightforward:

```
user@dev:/tmp$ hictk load --format 4dn --bin-size 10kbp 4DNFIKNWM36K.pairs.gz 4DNFIKNWM36K.10000.cool

[2024-09-26 16:51:28.059] [info]: Running hictk v1.0.0-fbdcb591
[2024-09-26 16:51:28.068] [info]: begin loading pairwise interactions into a .cool file...
[2024-09-26 16:51:28.137] [info]: writing chunk #1 to intermediate file "/tmp/hictk-tmp-XXXXQPdOSn/4DNFIKNWM36K.10000.cool.tmp"...
[2024-09-26 16:51:45.281] [info]: done writing chunk #1 to tmp file "/tmp/hictk-tmp-XXXXQPdOSn/4DNFIKNWM36K.10000.cool.tmp".
[2024-09-26 16:51:45.281] [info]: writing chunk #2 to intermediate file "/tmp/hictk-tmp-XXXXQPdOSn/4DNFIKNWM36K.10000.cool.tmp"...
[2024-09-26 16:52:04.969] [info]: done writing chunk #2 to tmp file "/tmp/hictk-tmp-XXXXQPdOSn/4DNFIKNWM36K.10000.cool.tmp".
[2024-09-26 16:52:04.970] [info]: merging 2 chunks into "4DNFIKNWM36K.10000.cool"...
[2024-09-26 16:52:06.430] [info]: processing chr3L:1030000-1040000 chr3R:30240000-30250000 at 6882312 pixels/s...
[2024-09-26 16:52:08.478] [info]: ingested 119208613 interactions (18122865 nnz) in 40.418916003s!
```

To ingest interactions in a .hic file, simply change the extension of the output file (or use the `--output-fmt` option).

hictk has native support for reading compressed interactions in the following formats: bzip2, lz4, lzo, gzip, xz, and zstd.

By default, the list of chromosomes is read from the file header.
The reference genome used to build the .cool or .hic file can be provided explicitly using the `--chrom-sizes` option.
Note that `--chrom-sizes` is a mandatory option when ingesting interactions in formats other than `--format=4dn`.
In case the input file contains interactions mapping on chromosomes missing from the reference genome provided through `--chrom-sizes`, the `--drop-unknown-chroms` flag can be used to instruct hictk to ignore said interactions.

When loading interactions using `--format=pairs` or `--format=validPairs` into a .cool file, tables of variable bins are supported.
To load interactions into a .cool with a variable bin size, provide the table of bins using the `--bin-table` option.

**Tips:**

* When creating large .cool/hic files, `hictk` needs to create potentially large temporary files. When this is the case, use option `--tmpdir` to set the temporary folder to a path with sufficient space.
* When loading interactions into .hic files, some of the steps can be run in parallel by increasing the number of processing threads using the `--threads` option.
* When loading pre-binned interactions into a .cool file, if the interactions are already sorted by genomic coordinates, the `--assume-sorted` option can be used to load interactions at once, without using temporary files.
* Interaction loading performance can be improved by processing interactions in larger chunks. This can be controlled using the `--chunk-size` option. In fact, when `--chunk-size` is greater than the number of interactions to be loaded, .hic and .cool files can be created without the use of temporary files.

## Merging multiple files[¶](#merging-multiple-files "Link to this heading")

Multiple .cool and .hic files using the same reference genome and resolution can be merged using `hictk merge`:

```
# Merge multiple cooler files

user@dev:/tmp$ hictk merge data/4DNFIZ1ZVXC8.mcool::/resolutions/10000 data/4DNFIZ1ZVXC8.mcool::/resolutions/10000 -o 4DNFIZ1ZVXC8.merged.10000.cool

[2024-09-26 17:07:57.101] [info]: Running hictk v1.0.0-fbdcb591
[2024-09-26 17:07:57.101] [info]: begin merging 2 files into one .cool file...
[2024-09-26 17:07:58.978] [info]: processing chr3L:1030000-1040000 chr3R:29720000-29730000 at 5571031 pixels/s...
[2024-09-26 17:08:01.224] [info]: DONE! Merging 2 files took 4.12s!
[2024-09-26 17:08:01.224] [info]: data/4DNFIZ1ZVXC8.merged.10000.cool size: 19.64 MB
```

Merging .hic files as well as a mix of .hic and .cool files is also supported (as long as all files have the same resolution and reference genome).
When all input files contain data for multiple resolutions, the `--resolution` option is mandatory.

**Tips:**

Refer to the list of Tips from the previous section.

[Next

Creating multi-resolution files (.hic and .mcool)](creating_multires_files.html)
[Previous

Reading interactions](reading_interactions.html)

Copyright © 2023, Roberto Rossini

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)

On this page

* Creating .cool and .hic files
  + [Ingesting pairwise interactions into a 10kbp .cool file](#ingesting-pairwise-interactions-into-a-10kbp-cool-file)
  + [Merging multiple files](#merging-multiple-files)