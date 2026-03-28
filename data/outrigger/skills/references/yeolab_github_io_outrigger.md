# Welcome to outrigger’s documentation![¶](#welcome-to-outrigger-s-documentation "Permalink to this headline")

[![OutriggerLogo](http://yeolab.github.io/outrigger/_static/logo-400px.png)](https://github.com/YeoLab/outrigger)

[![BuildStatus](https://travis-ci.org/YeoLab/outrigger.svg?branch=master)](https://travis-ci.org/YeoLab/outrigger)[![codecov](https://codecov.io/gh/YeoLab/outrigger/branch/master/graph/badge.svg)](https://codecov.io/gh/YeoLab/outrigger)[![PyPIVersions](https://img.shields.io/pypi/v/outrigger.svg)](https://pypi.python.org/pypi/outrigger)[![PythonVersionCompatibility](https://img.shields.io/pypi/pyversions/outrigger.svg)](https://pypi.python.org/pypi/outrigger)

# Fast detection and accurate calculation of alternative splicing with `outrigger`[¶](#fast-detection-and-accurate-calculation-of-alternative-splicing-with-outrigger "Permalink to this headline")

[outrigger](https://github.com/YeoLab/outrigger) is a program which uses junction reads from RNA seq data, and
a graph database to create a *de novo* alternative splicing annotation
with a graph database, and quantify percent spliced-in (Psi) of the
events.

* Free software: BSD license
* Documentation is available here: <http://yeolab.github.io/outrigger/>

## Features[¶](#features "Permalink to this headline")

* Finds novel splicing events, including novel exons!
  (`outrigger index`) from `.bam` files
* (optional) Validates that exons have correct splice sites, e.g. GT/AG
  and AT/AC for mammalian systems (`outrigger validate`)
* Calculate “percent spliced-in” (Psi/Ψ) scores for all your samples
  given the validated events (or the original events if you opted not
  to validate) via `outrigger psi`

[![OutriggerOverview](http://yeolab.github.io/outrigger/_static/outrigger_overview-1x.png)](http://yeolab.github.io/outrigger/_static/outrigger_overview-300ppi.png)

## Installation[¶](#installation "Permalink to this headline")

To install `outrigger`, we recommend using the [Anaconda Python
Distribution](http://anaconda.org/) and creating an environment.

You’ll want to add the [bioconda](https://bioconda.github.io/) channel to make installing [bedtools](http://bedtools.readthedocs.io) and its
Python wrapper, [pybedtools](https://daler.github.io/pybedtools/) easy, as these programs are necessary for both
`outrigger index` and `outrigger validate`.

```
conda config --add channels r
conda config --add channels bioconda
```

Create an environment called `outrigger-env`. Python 2.7, Python 3.4,
Python 3.5, and Python 3.6 are supported.

```
conda create --name outrigger-env outrigger
```

Now activate that environment:

```
source activate outrigger-env
```

To check that it installed properly, try the command with the help
option (`-h`), `outrigger -h`. The output should look like this:

```
$ outrigger -h
usage: outrigger [-h] [--version] {index,validate,psi} ...

outrigger (1.0.0dev). Calculate "percent-spliced in" (Psi) scores of
alternative splicing on a *de novo*, custom-built splicing index -- just for
you!

positional arguments:
  {index,validate,psi}  Sub-commands
    index               Build an index of splicing events using a graph
                        database on your junction reads and an annotation
    validate            Ensure that the splicing events found all have the
                        correct splice sites
    psi                 Calculate "percent spliced-in" (Psi) values using the
                        splicing event index built with "outrigger index"

optional arguments:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
```

### Bleeding edge code from Github (here)[¶](#bleeding-edge-code-from-github-here "Permalink to this headline")

For advanced users, if you have [git](https://git-scm.com) and
[Anaconda Python](https://www.continuum.io/downloads) installed, you
can:

1. Clone this repository
2. Change into that directory
3. Create an environment named `outrigger-env` with the necessary packages
   from Anaconda and the Python Package Index (PyPI).
4. Activate the environment

These steps are shown in code below.

```
git clone https://github.com/YeoLab/outrigger.git
cd outrigger
conda env create --file environment.yml
source activate outrigger-env
```

## Quick start[¶](#quick-start "Permalink to this headline")

If you just want to know how to run this on your data with the default
parameters, start here. Let’s say you performed your alignment in the
folder called `~/projects/tasic2016/analysis/tasic2016_v1`, and that’s
where your `SJ.out.tab` files from the STAR aligner are (they’re
output into the same folder as the `.bam` files). First you’ll need to
change directories to that folder with `cd`.

```
cd ~/projects/tasic2016/analysis/tasic2016_v1
```

Then you need find all alternative splicing events, which you do by
running `outrigger index` on the splice junction files and the gtf.

Note

We highly recommend to use `outrigger index` on a supercomputer with
multiple processors (at least 4) as the indexing process takes a long time
– over 24 hours, and by using multiple threads, the program will run much
faster.

Here is an example command:

### Input: `.SJ.out.tab` files (faster)[¶](#input-sj-out-tab-files-faster "Permalink to this headline")

This is faster than using `.bam` files because the junction counts are
already aggregated.

```
outrigger index --sj-out-tab *SJ.out.tab \
    --gtf /projects/ps-yeolab/genomes/mm10/gencode/m10/gencode.vM10.annotation.gtf
```

### Input: `.bam` files (slower)[¶](#input-bam-files-slower "Permalink to this headline")

If you’re using `.bam` files instead of `SJ.out.tab` files, never despair!
This will be slightly slower because `outrigger` needs to count every time a read
spans an exon-exon junction.

Below is an example command. Keep in mind that for this program to work, the
`bams` must be sorted and indexed.

```
outrigger index --bam *sorted.bam \
    --gtf /projects/ps-yeolab/genomes/mm10/gencode/m10/gencode.vM10.annotation.gtf
```

Next, you’ll want to validate that the splicing events you found follow
biological rules, such as being containing GT/AG (mammalian major
spliceosome) or AT/AC (mammalian minor splicesome) sequences. To do
that, you’ll need to provide the genome name (e.g. `mm10`) and the
genome sequences. An example command is below:

```
outrigger validate --genome mm10 \
    --fasta /projects/ps-yeolab/genomes/mm10/GRCm38.primary_assembly.genome.fa
```

Finally, you can calculate percent spliced in (Psi) of your splicing
events! Thankfully this is very easy:

```
outrigger psi
```

It should be noted that ALL of these commands should be performed in the
same directory, so no moving.

### Quick start summary[¶](#quick-start-summary "Permalink to this headline")

Here is a summary the commands in the order you would use them for
outrigger!

```
cd ~/projects/tasic2016/analysis/tasic2016_v1
outrigger index --sj-out-tab *SJ.out.tab \
    --gtf /projects/ps-yeolab/genomes/mm10/gencode/m10/gencode.vM10.annotation.gtf
outrigger validate --genome mm10 \
    --fasta /projects/ps-yeolab/genomes/mm10/GRCm38.primary_assembly.genome.fa
outrigger psi
```

This will create a folder called `outrigger_output`, which at the end
should look like the one below. Each file and folder is annotated with which command
produced it.

```
$ tree outrigger_output
outrigger_output...................................................index
├── index..........................................................index
│   ├── gtf........................................................index
│   │   ├── gencode.vM10.annotation.gtf............................index
│   │   ├── gencode.vM10.annotation.gtf.db.........................index
│   │   └── novel_exons.gtf........................................index
│   ├── exon_direction_junction_triples.csv........................index
│   ├── mxe........................................................index
│   │   ├── event.bed..............................................index
│   │   ├── events.csv.............................................index
│   │   ├── exon1.bed..............................................index
│   │   ├── exon2.bed..............................................index
│   │   ├── exon3.bed..............................................index
│   │   ├── exon4.bed..............................................index
│   │   ├── intron.bed.............................................index
│   │   ├── splice_sites.csv....................................validate
│   │   └── validated...........................................validate
│   │       └── events.csv......................................validate
│   └── se.........................................................index
│       ├── event.bed..............................................index
│       ├── events.csv.............................................index
│       ├── exon1.bed..............................................index
│       ├── exon2.bed..............................................index
│       ├── exon3.bed..............................................index
│       ├── intron.bed.............................................index
│       ├── splice_sites.csv....................................validate
│       └── validated...........................................validate
│           └── events.csv......................................validate
├── junctions......................................................index
│   ├── metadata.csv...............................................index
│   └── reads.csv..................................................index
└── psi..............................................................psi
    ├── mxe..........................................................psi
    |   ├── psi.csv..................................................psi
    │   └── summary.csv..............................................psi
    ├── outrigger_psi.csv............................................psi
    └── se...........................................................psi
        ├── psi.csv..................................................psi
        └── summary.csv..............................................psi

10 directories, 26 files
```

## Approximate runtimes[¶](#approximate-runtimes "Permalink to this headline")

Here are the expected runtimes for the different steps of `outrigger`. In all
:   cases, we **strongly recommend** using a supercomputer with at least 4 cores, ideally 8-16.

* `outrigger index`: This will run for 24-48 hours.
* `outrigger validate`: This will take 2-4 hours.
* `outrigger psi`: This will run for 4-8 hours.

Contents:

* [Installation](installation.html)
* [Usage](usage.html)
  + [`index`: Build a *de novo* splicing annotation index of events custom to **your** data](subcommands/outrigger_index.html)
  + [`validate`: Check that the found exons are real](subcommands/outrigger_validate.html)
  + [`psi`: Calculate percent spliced-in (Psi/Ψ) scores for your data from the splicing events you created](subcommands/outrigger_psi.html)
* [Contributing](contributing.html)
  + [Types of Contributions](contributing.html#types-of-contributions)
  + [Tips for writing documentation](contributing.html#tips-for-writing-documentation)
  + [Get Started!](contributing.html#get-started)
  + [Pull Request Guidelines](contributing.html#pull-request-guidelines)
  + [Tips](contributing.html#tips)
* [Credits](authors.html)
  + [Development Lead](authors.html#development-lead)
  + [Contributors](authors.html#contributors)
* [History](history.html)
  + [v1.0.0 (April 3rd, 2017)](history.html#v1-0-0-april-3rd-2017)
  + [v0.2.9 (November 11th, 2016)](history.html#v0-2-9-november-11th-2016)
  + [v0.2.8 (October 23rd, 2016)](history.html#v0-2-8-october-23rd-2016)
  + [v0.2.7 (October 23rd, 2016)](history.html#v0-2-7-october-23rd-2016)
  + [v0.2.6 (September 15th, 2016)](history.html#v0-2-6-september-15th-2016)
  + [v0.2.5 (September 14th, 2016)](history.html#v0-2-5-september-14th-2016)
  + [v0.2.4 (September 14th, 2016)](history.html#v0-2-4-september-14th-2016)
  + [v0.2.3 (September 13th, 2016)](history.html#v0-2-3-september-13th-2016)
  + [v0.2.2 (September 12th, 2016)](history.html#v0-2-2-september-12th-2016)
  + [v0.2.1 (September 12th, 2016)](history.html#v0-2-1-september-12th-2016)
  + [v0.2.0 (September 9th, 2016)](history.html#v0-2-0-september-9th-2016)
  + [v0.1.0 (May 25, 2016)](history.html#v0-1-0-may-25-2016)

# Indices and tables[¶](#indices-and-tables "Permalink to this headline")

* [Index](genindex.html)
* [Module Index](py-modindex.html)
* [Search Page](search.html)

![Logo](_static/logo-150px.png)

### About outrigger

outrigger is an RNA-seq analysis tool that helps
you be confident in your alternative exon inclusion calculations.

### Table Of Contents

* Home
* [Contents](contents.html)
* [Install](installation.html)
* [Usage](Usage.html)
* [`index`: Detect exons](subcommands/outrigger_index.html)
* [`validate`: Remove non-canonical splice sites](subcommands/outrigger_validate.html)
* [`psi`: Quantify exon inclusion](subcommands/outrigger_psi.html)
* [Changelog](history.html)
* [License](license.html)

---

* Welcome to outrigger’s documentation!
* [Fast detection and accurate calculation of alternative splicing with `outrigger`](#fast-detection-and-accurate-calculation-of-alternative-splicing-with-outrigger)
  + [Features](#features)
  + [Installation](#installation)
    - [Bleeding edge code from Github (here)](#bleeding-edge-code-from-github-here)
  + [Quick start](#quick-start)
    - [Input: `.SJ.out.tab` files (faster)](#input-sj-out-tab-files-faster)
    - [Input: `.bam` files (slower)](#input-bam-files-slower)
    - [Quick start summary](#quick-start-summary)
  + [Approximate runtimes](#approximate-runtimes)
* [Indices and tables](#indices-and-tables)

### Quick search

©2015-2017, Olga Botvinnik.
|
Powered by [Sphinx 1.4.8](http://sphinx-doc.org/)
& [Alabaster 0.7.9](https://github.com/bitprophet/alabaster)
|
[Page source](_sources/index.txt)