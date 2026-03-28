[ ]
[ ]

[Skip to content](#getting-started)

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")

TAXPASTA

Getting Started

Initializing search

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

[![logo](../../assets/images/taxpasta-logo-white-pastaonly.svg)](../.. "TAXPASTA")
TAXPASTA

[taxprofiler/taxpasta](https://github.com/taxprofiler/taxpasta "Go to repository")

* [Home](../..)
* [x]

  Tutorials

  Tutorials
  + [ ]

    Getting Started

    [Getting Started](./)

    Table of contents
    - [Preparation](#preparation)

      * [Software](#software)
      * [Data](#data)
    - [Profiles](#profiles)

      * [Raw Output](#raw-output)
    - [Standardisation and Merging](#standardisation-and-merging)

      * [taxpasta standardise](#taxpasta-standardise)
      * [taxpasta merge](#taxpasta-merge)
    - [Additional functionality](#additional-functionality)
    - [Clean Up](#clean-up)
  + [Deep Dive](../deepdive/)
* [ ]

  How-tos

  How-tos
  + [How-to Add Taxa Names to Output](../../how-tos/how-to-add-names/)
  + [How-to Customise Sample Names](../../how-tos/how-to-customise-sample-names/)
  + [How-to Merge Across Profilers](../../how-tos/how-to-merge-across-profilers/)
* [ ]

  [Commands](../../commands/)

  Commands
  + [standardise](../../commands/standardise/)
  + [merge](../../commands/merge/)
* [ ]

  [Quick reference](../../quick_reference/)

  Quick reference
  + [standardise](../../quick_reference/standardise/)
  + [merge](../../quick_reference/merge/)
* [ ]

  [Supported profilers](../../supported_profilers/)

  Supported profilers
  + [Terminology](../../supported_profilers/terminology/)
  + [Bracken](../../supported_profilers/bracken/)
  + [Centrifuge](../../supported_profilers/centrifuge/)
  + [DIAMOND](../../supported_profilers/diamond/)
  + [ganon](../../supported_profilers/ganon/)
  + [Kaiju](../../supported_profilers/kaiju/)
  + [KMCP](../../supported_profilers/kmcp/)
  + [Kraken2](../../supported_profilers/kraken2/)
  + [KrakenUniq](../../supported_profilers/krakenuniq/)
  + [MEGAN6/MALT](../../supported_profilers/megan6/)
  + [MetaPhlAn](../../supported_profilers/metaphlan/)
  + [mOTUs](../../supported_profilers/motus/)
* [FAQ](../../faq/)
* [ ]

  Design Decisions

  Design Decisions
  + [1. Record architecture decisions](../../adr/0001-record-architecture-decisions/)
  + [2. Use Integer Taxonomy Identifiers](../../adr/0002-use-integer-taxonomy-identifiers/)
* [ ]

  API Reference

  API Reference
  + [Application](../../api/application/)
  + [Domain](../../api/domain/)
  + [Infrastructure](../../api/infrastructure/)
* [ ]

  [Contributing](../../contributing/)

  Contributing
  + [Supporting New Taxonomic Profilers](../../contributing/supporting_new_profiler/)

Table of contents

* [Preparation](#preparation)

  + [Software](#software)
  + [Data](#data)
* [Profiles](#profiles)

  + [Raw Output](#raw-output)
* [Standardisation and Merging](#standardisation-and-merging)

  + [taxpasta standardise](#taxpasta-standardise)
  + [taxpasta merge](#taxpasta-merge)
* [Additional functionality](#additional-functionality)
* [Clean Up](#clean-up)

# Getting Started[¶](#getting-started "Permanent link")

In this getting started tutorial we will show you how to generate standardised
taxonomic profiles from the diverse outputs of two popular taxonomic profilers:
[Kraken2](https://ccb.jhu.edu/software/kraken2/) and
[mOTUs](https://motu-tool.org/) using `taxpasta`.

If you want a more detailed walkthrough of *why* standardising the profiles is
useful, please see the [Deep Dive](../deepdive/) tutorial.

## Preparation[¶](#preparation "Permanent link")

### Software[¶](#software "Permanent link")

For this tutorial you will need an internet connection, an [installation of
taxpasta](../../#install).

### Data[¶](#data "Permanent link")

First we will make a ‘scratch’ directory where we can run the tutorial and
delete again afterwards.

```
mkdir taxpasta-tutorial
cd taxpasta-tutorial
```

We will also need to download some example taxonomic profiles from Kraken2 and
mOTUs. We can download test data from the taxpasta repository using, for
example, `curl` (OSX, Linux) or `wget` (generally Linux Only).

Info

The following test data are from [ancient DNA
samples](https://doi.org/10.1016/j.cub.2021.09.031) against standard
databases, thus have a high unclassified rate due to uncharacterised
environmental contamination and extinct species.

We should now see three files with contents in the `taxpasta-tutorial` directory

```
ls
```

```
2612_pe-ERR5766176-db1.kraken2.report.txt  2612_se-ERR5766180-db_mOTU.out
2612_pe-ERR5766176-db_mOTU.out
```

## Profiles[¶](#profiles "Permanent link")

### Raw Output[¶](#raw-output "Permanent link")

To begin, let’s look at the contents of the output from each profiler.

These look quite different. Neither of them is in a nice "pure" tabular format
that is convenient for analysis software or spreadsheet tools such as Microsoft
Excel or LibreOffice Calc to load. They also have different types columns and,
in the case of Kraken2, it has an interesting "indentation" way of showing the
taxonomic rank of each taxon.

## Standardisation and Merging[¶](#standardisation-and-merging "Permanent link")

### taxpasta standardise[¶](#taxpasta-standardise "Permanent link")

This is where `taxpasta` comes to the rescue!

With `taxpasta`, you can standardise and combine profiles into multi-sample
taxon tables for you already at the command-line; rather than having to do this
with custom scripts and a lot of manual data munging.

If you want to standardise a single profile you need three things:

* The name of the taxonomic profiler used to generate the input file
  (`--profiler` or `-p`)
* The requested output file name with a valid suffix that will tell `taxpasta`
  which format to save the output in (`--output` or `-o`)
* The input profile file itself

```
taxpasta standardise -p kraken2 -o 2612_pe-ERR5766176-db1_kraken2.tsv 2612_pe-ERR5766176-db1.kraken2.report.txt
```

```
[INFO] Write result to '2612_pe-ERR5766176-db1_kraken2.tsv'.
```

Let's look at the result:

```
head 2612_pe-ERR5766176-db1_kraken2.tsv
```

```
taxonomy_id count
0   627680
1   0
131567  0
2759    0
33154   0
33208   0
6072    0
33213   0
33511   0
```

This looks much more tidy!

You can see that we did not have to specify any additional column names or other
arguments. `taxpasta` has created a suitable table for you.

### taxpasta merge[¶](#taxpasta-merge "Permanent link")

What about the more complicated mOTUs case, where we not only have unusual
comment headers but also profiles from *multiple* samples to be standardised?

In this case, we can instead use `taxpasta merge`, which will both standardise
*and* merge the profiles of different samples into one for you - all through the
command-line.

Again, We need to specify the profiler, the output name and
format (via the suffix), and the input profiles themselves.

```
taxpasta merge -p motus -o dbMOTUs_motus.tsv 2612_pe-ERR5766176-db_mOTU.out 2612_se-ERR5766180-db_mOTU.out
```

```
[WARNING] The merged profiles contained different taxa. Additional zeroes were introduced for missing taxa.
[INFO] Write result to 'dbMOTUs_motus.tsv'.
```

Let's peek at the result.

```
head dbMOTUs_motus.tsv
```

```
taxonomy_id 2612_pe-ERR5766176-db_mOTU  2612_se-ERR5766180-db_mOTU
40518   20  2
216816  1   0
1680    6   1
1262820 1   0
74426   2   1
1907654 1   0
1852370 3   1
39491   3   0
33039   2   0
```

As with Kraken2, this looks much more tabular, and we can see references to
*both* input files.

Danger

We do not (directly) support merging *across* different
classifiers/profilers, as each tool may have its own database, metric, *and*
taxonomy ID system,. This can risk making naïve assumptions and
false-positive interpretations, thus `taxpasta` is designed to help
*prepare* data for cross-classifier without doing it itself. We rather
highly recommend doing this mindfully in an exploratory fashion. We provide
examples of how to do this carefully using R and Python in the corresponding
[How to merge across
profilers](../../how-tos/how-to-merge-across-profilers/) section.

However if you really want this functionality, please let the developers
know via a [feature
request](https://github.com/taxprofiler/taxpasta/issues/new?assignees=&labels=enhancement&template=03-feature-request.yml&title=%5BFeature%5D+).

## Additional functionality[¶](#additional-functionality "Permanent link")

* If you want to learn how to use `taxpasta` to add taxonomic names (rather than
  IDs) to your profiles, see [here](../../how-tos/how-to-add-names/).
* Want to customise the sample names in the columns? See
  [here](../../how-tos/how-to-customise-sample-names/).

## Clean Up[¶](#clean-up "Permanent link")

Once you’re happy that you’ve completed the tutorial you can clean up your
workspace by removing the tutorial directory.

```
cd ..
rm -rf taxpasta-tutorial
```

Back to top

Copyright © 2022 Moritz E. Beber, Maxime Borry, James A. Fellows Yates, and Sofia Stamouli

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)