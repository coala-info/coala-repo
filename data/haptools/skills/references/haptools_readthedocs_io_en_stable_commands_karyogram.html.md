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
* karyogram
  + [Basic Usage](#basic-usage)
  + [Additional Options](#additional-options)
  + [Example](#example)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [karyogram](#haptools-karyogram)
* [transform](transform.html)
* [index](index.html)
* [clump](clump.html)
* [ld](ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* karyogram
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/karyogram.rst)

---

# karyogram[](#karyogram "Link to this heading")

Takes as input a [breakpoints file](../formats/breakpoints.html) (e.g. as output by [simgenotype](simgenotype.html)) and a sample name, and plots a karyogram depicting local ancestry tracks.

## Basic Usage[](#basic-usage "Link to this heading")

```
haptools karyogram \
--bp BREAKPOINTS \
--sample SAMPLE \
--out PNG
```

See details of the breakpoints file [here](../formats/breakpoints.html). If you specify `--sample $SAMPLE`, the breakpoints file must have breakpoints for `$SAMPLE_1` and `$SAMPLE_2` (the two haplotypes of `$SAMPLE`).

## Additional Options[](#additional-options "Link to this heading")

You may also specify the following options:

* `--centromeres <FILE>` - Path to a file describing the locations of chromosome ends and centromeres. An example file is given here: `tests/data/centromeres_hg19.txt`. The columns are: chromosome, chrom\_start, centromere, chrom\_end. For acrocentric chromosomes, the centromere field is ommitted. This file format was taken from [here](https://github.com/armartin/ancestry_pipeline).
* `--colors "pop1:color1,pop2:color2..."` - You can optionally specify which colors should be used for each population. These colors entered can be the matplotlib [colors](https://matplotlib.org/stable/gallery/color/named_colors.html) or inputted as hexcode. If colors are not given, the script chooses reasonable defaults.
* `--title <TITLE>` - Title for the resulting karyogram.
* `--verbosity <LEVEL>` - What level of output the logger should print to stdout. Please see [logging levels](https://docs.python.org/3/library/logging.html) for output levels. Default = INFO [Optional]

## Example[](#example "Link to this heading")

```
haptools karyogram \
--bp tests/data/5gen.bp \
--sample Sample_1 \
--out test_karyogram.png \
--centromeres tests/data/centromeres_hg19.txt \
--title "5 Generation Karyogram" \
--colors 'CEU:blue,YRI:red'
```

This will output a file `test_karyogram.png`. The example is shown below.

![Example karyogram](../_images/test_karyogram.png)

All files used in this example are described [here](../project_info/example_files.html).

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

#### karyogram[](#haptools-karyogram "Link to this heading")

Visualize a karyogram of local ancestry tracks

```
haptools karyogram [OPTIONS]
```

Options

--bp <bp>[](#cmdoption-haptools-karyogram-bp "Link to this definition")
:   **Required** Path to .bp file with breakpoints

--sample <sample>[](#cmdoption-haptools-karyogram-sample "Link to this definition")
:   **Required** Sample ID to plot

--out <out>[](#cmdoption-haptools-karyogram-out "Link to this definition")
:   **Required** Name of output file

--title <title>[](#cmdoption-haptools-karyogram-title "Link to this definition")
:   Optional plot title

--centromeres <centromeres>[](#cmdoption-haptools-karyogram-centromeres "Link to this definition")
:   Optional file with telomere/centromere cM positions

--colors <colors>[](#cmdoption-haptools-karyogram-colors "Link to this definition")
:   Optional color dictionary. Input can be from the matplotlib list of colors or in hexcode. Format is e.g. ‘YRI:blue,CEU:green’

-v, --verbosity <verbosity>[](#cmdoption-haptools-karyogram-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

[Previous](simphenotype.html "simphenotype")
[Next](transform.html "transform")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).