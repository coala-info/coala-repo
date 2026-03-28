[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](simgenotype.html)
* [simphenotype](simphenotype.html)
* [karyogram](karyogram.html)
* [transform](transform.html)
* index
  + [Usage](#usage)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [index](#haptools-index)
* [clump](clump.html)
* [ld](ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* index
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/index.rst)

---

# index[](#index "Link to this heading")

Index a set of haplotypes specified as a [.hap file](../formats/haplotypes.html).

The `index` command creates a sorted `.hap.gz` and a `.hap.gz.tbi` index file from a `.hap` (or `.hap.gz`) file.

By default, the `index` command will also sort your haplotypes, since this is a prerequisite for indexing.

## Usage[](#usage "Link to this heading")

```
haptools index \
--sort \
--output PATH \
--verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET] \
HAPLOTYPES
```

## Examples[](#examples "Link to this heading")

```
haptools index tests/data/basic.hap
```

You may also specify a custom output path for the compressed file to be written to.

```
haptools index --output tests/data/sorted.basic.hap.gz tests/data/basic.hap
```

You can use the `--no-sort` flag to skip the sorting step if your file is already sorted.

```
haptools index --no-sort --output tests/data/basic.hap.gz tests/data/basic.hap.gz
```

Warning

If the `--no-sort` flag *isn’t* used, the `index` command will ignore all extra fields when processing your `.hap` file. To retain them, just sort the file manually first.

```
awk '$0 ~ /^#/ {print; next} {print | "sort -k2,4"}' tests/data/simphenotype.hap | \
haptools index --no-sort --output tests/data/simphenotype.hap.gz /dev/stdin
```

All files used in these examples are described [here](../project_info/example_files.html).

## Detailed Usage[](#detailed-usage "Link to this heading")

### haptools[](#haptools "Link to this heading")

haptools: A toolkit for simulating and analyzing genotypes and
phenotypes while taking into account haplotype information

```
haptools [OPTIONS] COMMAND [ARGS]...
```

Options

--version[](#cmdoption-haptools-version "Link to this definition")
:   Show the version and exit.

#### index[](#haptools-index "Link to this heading")

Takes in an unsorted .hap file and outputs it as a .gz and a .tbi file

```
haptools index [OPTIONS] HAPLOTYPES
```

Options

--sort, --no-sort[](#cmdoption-haptools-index-sort "Link to this definition")
:   Sorting of the file will not be performed

    Default:
    :   `True`

-o, --output <output>[](#cmdoption-haptools-index-o "Link to this definition")
:   A .hap file containing sorted and indexed haplotypes and variants

    Default:
    :   `'input file'`

-v, --verbosity <verbosity>[](#cmdoption-haptools-index-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

Arguments

HAPLOTYPES[](#cmdoption-haptools-index-arg-HAPLOTYPES "Link to this definition")
:   Required argument

[Previous](transform.html "transform")
[Next](clump.html "clump")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).