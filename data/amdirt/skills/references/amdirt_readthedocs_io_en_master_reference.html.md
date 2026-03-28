[amdirt](index.html)

Contents:

* [Install](README.html)
* [Cite](README.html#cite)
* [More information](README.html#more-information)
* [Tutorials](tutorials/index.html)
* [How Tos](how_to/index.html)
* Quick Reference
  + [amdirt](#amdirt)
    - [autofill](#amdirt-autofill)
    - [convert](#amdirt-convert)
    - [download](#amdirt-download)
    - [merge](#amdirt-merge)
    - [validate](#amdirt-validate)
    - [viewer](#amdirt-viewer)
* [Python API](API.html)

[amdirt](index.html)

* Quick Reference
* [View page source](_sources/reference.rst.txt)

---

# Quick Reference[](#quick-reference "Link to this heading")

To access the help menu:

```
$ amdirt --help
```

The list of arguments of options is detailed below

## amdirt[](#amdirt "Link to this heading")

amdirt: Performs validity check of AncientMetagenomeDir datasets

Authors: amdirt development team and the SPAAM community

Homepage & Documentation: <https://github.com/SPAAM-community/amdirt>

Usage

```
amdirt [OPTIONS] COMMAND [ARGS]...
```

Options

--version[](#cmdoption-amdirt-version "Link to this definition")
:   Show the version and exit.

--verbose[](#cmdoption-amdirt-verbose "Link to this definition")
:   Verbose mode

### autofill[](#amdirt-autofill "Link to this heading")

Autofills library and/or sample table(s) using ENA API and accession numbers

ACCESSION: ENA accession(s). Multiple accessions can be space separated (e.g. PRJNA123 PRJNA456)

Usage

```
amdirt autofill [OPTIONS] [ACCESSION]...
```

Options

-n, --table\_name <table\_name>[](#cmdoption-amdirt-autofill-n "Link to this definition")
:   Default:
    :   `'ancientmetagenome-hostassociated'`

    Options:
    :   ancientmetagenome-environmental | ancientmetagenome-hostassociated | ancientsinglegenome-hostassociated | test

-t, --output\_ena\_table <output\_ena\_table>[](#cmdoption-amdirt-autofill-t "Link to this definition")
:   path to ENA table output file

-l, --library\_output <library\_output>[](#cmdoption-amdirt-autofill-l "Link to this definition")
:   path to library output table file

-s, --sample\_output <sample\_output>[](#cmdoption-amdirt-autofill-s "Link to this definition")
:   path to sample output table file

Arguments

ACCESSION[](#cmdoption-amdirt-autofill-arg-ACCESSION "Link to this definition")
:   Optional argument(s)

### convert[](#amdirt-convert "Link to this heading")

Converts filtered samples and libraries tables to eager, ameta, taxprofiler, and fetchNGS input tables

Note: When supplying a pre-filtered libraries table with –libraries, the corresponding sample table is still required!

SAMPLES: path to filtered AncientMetagenomeDir samples tsv file

TABLE\_NAME: name of table to convert

Usage

```
amdirt convert [OPTIONS] SAMPLES TABLE_NAME
```

Options

-t, --tables <tables>[](#cmdoption-amdirt-convert-t "Link to this definition")
:   (Optional) JSON file listing AncientMetagenomeDir tables

--libraries <libraries>[](#cmdoption-amdirt-convert-libraries "Link to this definition")
:   (Optional) Path to a pre-filtered libraries table NOTE: This argument is mutually exclusive with arguments: [librarymetadata].

--librarymetadata[](#cmdoption-amdirt-convert-librarymetadata "Link to this definition")
:   Generate AncientMetagenomeDir libraries table of all samples in input table NOTE: This argument is mutually exclusive with arguments: [libraries].

-o, --output <output>[](#cmdoption-amdirt-convert-o "Link to this definition")
:   conversion output directory

    Default:
    :   `'.'`

--bibliography[](#cmdoption-amdirt-convert-bibliography "Link to this definition")
:   Generate BibTeX file of all publications in input table

--dates[](#cmdoption-amdirt-convert-dates "Link to this definition")
:   Generate AncientMetagenomeDir dates table of all samples in input table

--curl[](#cmdoption-amdirt-convert-curl "Link to this definition")
:   Generate bash script with curl-based download commands for all libraries of samples in input table

--aspera[](#cmdoption-amdirt-convert-aspera "Link to this definition")
:   Generate bash script with Aspera-based download commands for all libraries of samples in input table

--fetchngs[](#cmdoption-amdirt-convert-fetchngs "Link to this definition")
:   Convert filtered samples and libraries tables to nf-core/fetchngs input tables

--sratoolkit[](#cmdoption-amdirt-convert-sratoolkit "Link to this definition")
:   Generate bash script with SRA Toolkit fasterq-dump based download commands for all libraries of samples in input table

--eager[](#cmdoption-amdirt-convert-eager "Link to this definition")
:   Convert filtered samples and libraries tables to eager input tables

--ameta[](#cmdoption-amdirt-convert-ameta "Link to this definition")
:   Convert filtered samples and libraries tables to aMeta input tables

--mag[](#cmdoption-amdirt-convert-mag "Link to this definition")
:   Convert filtered samples and libraries tables to nf-core/mag input tables

--taxprofiler[](#cmdoption-amdirt-convert-taxprofiler "Link to this definition")
:   Convert filtered samples and libraries tables to nf-core/taxprofiler input tables

Arguments

SAMPLES[](#cmdoption-amdirt-convert-arg-SAMPLES "Link to this definition")
:   Required argument

TABLE\_NAME[](#cmdoption-amdirt-convert-arg-TABLE_NAME "Link to this definition")
:   Required argument

### download[](#amdirt-download "Link to this heading")

Download a table from the amdirt repository

Usage

```
amdirt download [OPTIONS]
```

Options

-t, --table <table>[](#cmdoption-amdirt-download-t "Link to this definition")
:   AncientMetagenomeDir table to download

    Default:
    :   `'ancientmetagenome-hostassociated'`

    Options:
    :   ancientmetagenome-environmental | ancientmetagenome-hostassociated | ancientsinglegenome-hostassociated | test

-y, --table\_type <table\_type>[](#cmdoption-amdirt-download-y "Link to this definition")
:   Type of table to download

    Default:
    :   `'samples'`

    Options:
    :   samples | libraries | dates

-r, --release <release>[](#cmdoption-amdirt-download-r "Link to this definition")
:   Release tag to download

    Default:
    :   `'v25.12.2'`

    Options:
    :   v25.12.2 | v25.12.0 | v25.09.0 | v25.06.0 | v25.03.0 | v24.12.0 | v24.09.0 | v24.06.0 | v24.03.0 | v23.12.0 | v23.09.0 | v23.06.0 | v23.03.0 | v22.12.0 | v22.09.2 | v22.09.1 | v22.09

-o, --output <output>[](#cmdoption-amdirt-download-o "Link to this definition")
:   Output directory

    Default:
    :   `'.'`

### merge[](#amdirt-merge "Link to this heading")

Merges new dataset with existing table

DATASET: path to tsv file of new dataset to merge

Usage

```
amdirt merge [OPTIONS] DATASET
```

Options

-n, --table\_name <table\_name>[](#cmdoption-amdirt-merge-n "Link to this definition")
:   Default:
    :   `'ancientmetagenome-hostassociated'`

    Options:
    :   ancientmetagenome-environmental | ancientmetagenome-hostassociated | ancientsinglegenome-hostassociated | test

-t, --table\_type <table\_type>[](#cmdoption-amdirt-merge-t "Link to this definition")
:   Default:
    :   `'libraries'`

    Options:
    :   samples | libraries

-m, --markdown[](#cmdoption-amdirt-merge-m "Link to this definition")
:   Output is in markdown format

-o, --outdir <outdir>[](#cmdoption-amdirt-merge-o "Link to this definition")
:   path to sample output table file

    Default:
    :   `'.'`

Arguments

DATASET[](#cmdoption-amdirt-merge-arg-DATASET "Link to this definition")
:   Required argument

### validate[](#amdirt-validate "Link to this heading")

Run validity check of AncientMetagenomeDir datasets

DATASET: path to tsv file of dataset to check

SCHEMA: path to JSON schema file

Usage

```
amdirt validate [OPTIONS] DATASET SCHEMA
```

Options

-s, --schema\_check[](#cmdoption-amdirt-validate-s "Link to this definition")
:   Turn on schema checking.

-d, --line\_dup[](#cmdoption-amdirt-validate-d "Link to this definition")
:   Turn on line duplicate line checking.

-c, --columns[](#cmdoption-amdirt-validate-c "Link to this definition")
:   Turn on column presence/absence checking.

-i, --doi[](#cmdoption-amdirt-validate-i "Link to this definition")
:   Turn on DOI duplicate checking.

--multi\_values <multi\_values>[](#cmdoption-amdirt-validate-multi_values "Link to this definition")
:   Check multi-values column for duplicate values.

-a, --online\_archive[](#cmdoption-amdirt-validate-a "Link to this definition")
:   Turn on ENA accession validation

--remote <remote>[](#cmdoption-amdirt-validate-remote "Link to this definition")
:   [Optional] Path/URL to remote reference sample table for archive accession validation

-l, --local\_json\_schema <local\_json\_schema>[](#cmdoption-amdirt-validate-l "Link to this definition")
:   path to folder with local JSON schemas

-m, --markdown[](#cmdoption-amdirt-validate-m "Link to this definition")
:   Output is in markdown format

Arguments

DATASET[](#cmdoption-amdirt-validate-arg-DATASET "Link to this definition")
:   Required argument

SCHEMA[](#cmdoption-amdirt-validate-arg-SCHEMA "Link to this definition")
:   Required argument

### viewer[](#amdirt-viewer "Link to this heading")

Launch interactive filtering tool

Usage

```
amdirt viewer [OPTIONS]
```

Options

-t, --tables <tables>[](#cmdoption-amdirt-viewer-t "Link to this definition")
:   JSON file listing AncientMetagenomeDir tables

[Previous](how_to/miscellaneous.html "miscellaneous")
[Next](API.html "Python API")

---

© Copyright 2022, Maxime Borry.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).