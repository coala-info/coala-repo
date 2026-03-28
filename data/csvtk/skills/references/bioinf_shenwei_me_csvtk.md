[ ]
[ ]

[Skip to content](#csvtk-a-cross-platform-efficient-and-practical-csvtsv-toolkit)

csvtk - CSV/TSV Toolkit

Home

Initializing search

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

csvtk - CSV/TSV Toolkit

[GitHub](https://github.com/shenwei356/csvtk "Go to repository")

* [ ]

  Home

  [Home](.)

  Table of contents
  + [Introduction](#introduction)
  + [Table of Contents](#table-of-contents)
  + [Features](#features)
  + [Subcommands](#subcommands)
  + [Installation](#installation)

    - [Method 1: Download binaries (latest stable/dev version)](#method-1-download-binaries-latest-stabledev-version)
    - [Method 2: Install via Pixi](#method-2-install-via-pixi)
    - [Method 3: Install via conda (latest stable version)](#method-3-install-via-conda-latest-stable-version)
    - [Method 4: Install via homebrew](#method-4-install-via-homebrew)
    - [Method 5: For Go developer (latest stable/dev version)](#method-5-for-go-developer-latest-stabledev-version)
    - [Method 6: For ArchLinux AUR users (may be not the latest)](#method-6-for-archlinux-aur-users-may-be-not-the-latest)
  + [Command-line completion](#command-line-completion)
  + [Compared to csvkit](#compared-to-csvkit)
  + [Examples](#examples)
  + [Acknowledgements](#acknowledgements)
  + [Contact](#contact)
  + [License](#license)
  + [Starchart](#starchart)
* [Download](download/)
* [Usage](usage/)
* [FAQs](faq/)
* [Tutorial](tutorial/)
* [中文介绍](chinese/)
* [More tools](https://github.com/shenwei356)

Table of contents

* [Introduction](#introduction)
* [Table of Contents](#table-of-contents)
* [Features](#features)
* [Subcommands](#subcommands)
* [Installation](#installation)

  + [Method 1: Download binaries (latest stable/dev version)](#method-1-download-binaries-latest-stabledev-version)
  + [Method 2: Install via Pixi](#method-2-install-via-pixi)
  + [Method 3: Install via conda (latest stable version)](#method-3-install-via-conda-latest-stable-version)
  + [Method 4: Install via homebrew](#method-4-install-via-homebrew)
  + [Method 5: For Go developer (latest stable/dev version)](#method-5-for-go-developer-latest-stabledev-version)
  + [Method 6: For ArchLinux AUR users (may be not the latest)](#method-6-for-archlinux-aur-users-may-be-not-the-latest)
* [Command-line completion](#command-line-completion)
* [Compared to csvkit](#compared-to-csvkit)
* [Examples](#examples)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)
* [License](#license)
* [Starchart](#starchart)

# csvtk - a cross-platform, efficient and practical CSV/TSV toolkit

* **Documents:** [http://bioinf.shenwei.me/csvtk](http://bioinf.shenwei.me/csvtk/)
  ( [**Usage**](http://bioinf.shenwei.me/csvtk/usage/), [**Tutorial**](http://bioinf.shenwei.me/csvtk/tutorial/) and [**FAQs**](http://bioinf.shenwei.me/csvtk/faq/)).
  [中文介绍](http://bioinf.shenwei.me/csvtk/chinese)
* **Source code:** <https://github.com/shenwei356/csvtk> [![GitHub stars](https://img.shields.io/github/stars/shenwei356/csvtk.svg?style=social&label=Star&?maxAge=2592000)](https://github.com/shenwei356/csvtk)
  [![license](https://img.shields.io/github/license/shenwei356/csvtk.svg?maxAge=2592000)](https://github.com/shenwei356/csvtk/blob/master/LICENSE)
* **Latest version:** [![Latest Stable Version](https://img.shields.io/github/release/shenwei356/csvtk.svg?style=flat)](https://github.com/shenwei356/csvtk/releases)
  [![Github Releases](https://img.shields.io/github/downloads/shenwei356/csvtk/latest/total.svg?maxAge=3600)](http://bioinf.shenwei.me/csvtk/download/)
  [![Cross-platform](https://img.shields.io/badge/platform-any-ec2eb4.svg?style=flat)](http://bioinf.shenwei.me/csvtk/download/)
  [![Anaconda Cloud](https://anaconda.org/conda-forge/csvtk/badges/version.svg)](https://anaconda.org/conda-forge/csvtk)

## Introduction

Similar to FASTA/Q format in field of Bioinformatics,
CSV/TSV formats are basic and ubiquitous file formats in both Bioinformatics and data science.

People usually use spreadsheet software like MS Excel to process table data.
However this is all by clicking and typing, which is **not
automated and is time-consuming to repeat**, especially when you want to
apply similar operations with different datasets or purposes.

***You can also accomplish some CSV/TSV manipulations using shell commands,
but more code is needed to handle the header line. Shell commands do not
support selecting columns with column names either.***

`csvtk` is **convenient for rapid data investigation
and also easy to integrate into analysis pipelines**.
It could save you lots of time in (not) writing Python/R scripts.

## Table of Contents

* [Introduction](#introduction)
* [Table of Contents](#table-of-contents)
* [Features](#features)
* [Subcommands](#subcommands)
* [Installation](#installation)
  + [Method 1: Download binaries (latest stable/dev version)](#method-1-download-binaries-latest-stabledev-version)
  + [Method 2: Install via Pixi](#method-2-install-via-pixi)
  + [Method 3: Install via conda (latest stable version)](#method-3-install-via-conda-latest-stable-version--)
  + [Method 4: Install via homebrew](#method-4-install-via-homebrew)
  + [Method 5: For Go developer (latest stable/dev version)](#method-5-for-go-developer-latest-stabledev-version)
  + [Method 6: For ArchLinux AUR users (may be not the latest)](#method-6-for-archlinux-aur-users-may-be-not-the-latest)
* [Command-line completion](#command-line-completion)
* [Compared to `csvkit`](#compared-to-csvkit)
* [Examples](#examples)
* [Acknowledgements](#acknowledgements)
* [Contact](#contact)
* [License](#license)
* [Starchart](#starchart)

## Features

* **Cross-platform** (Linux/Windows/Mac OS X/OpenBSD/FreeBSD)
* **Light weight and out-of-the-box, no dependencies, no compilation, no configuration**
* **Fast**, **multiple-CPUs supported** (some commands)
* **Practical functions provided by N subcommands**
* **Support STDIN and gzipped input/output file, easy being used in pipe**
* Most of the subcommands support ***unselecting fields*** and ***fuzzy fields***,
  e.g. `-f "-id,-name"` for all fields except "id" and "name",
  `-F -f "a.*"` for all fields with prefix "a.".
* **Support some common plots** (see [usage](http://bioinf.shenwei.me/csvtk/usage/#plot))
* ~~Seamless support for data with meta line (e.g., `sep=,`) of separator declaration used by MS Excel~~

## Subcommands

56 subcommands in total.

**Information**

* [`headers`](https://bioinf.shenwei.me/csvtk/usage/#headers): prints headers
* [`dim`](https://bioinf.shenwei.me/csvtk/usage/#dim/nrow/ncol): dimensions of CSV file
* [`nrow`](https://bioinf.shenwei.me/csvtk/usage/#dim/nrow/ncol): print number of records
* [`ncol`](https://bioinf.shenwei.me/csvtk/usage/#dim/nrow/ncol): print number of columns
* [`summary`](https://bioinf.shenwei.me/csvtk/usage/#summary): summary statistics of selected numeric or text fields (groupby group fields)
* [`watch`](https://bioinf.shenwei.me/csvtk/usage/#watch): online monitoring and histogram of selected field
* [`corr`](https://bioinf.shenwei.me/csvtk/usage/#corr): calculate Pearson correlation between numeric columns

**Format conversion**

* [`pretty`](https://bioinf.shenwei.me/csvtk/usage/#pretty): converts CSV to a readable aligned table
* [`csv2tab`](https://bioinf.shenwei.me/csvtk/usage/#csv2tab): converts CSV to tabular format
* [`tab2csv`](https://bioinf.shenwei.me/csvtk/usage/#tab2csv): converts tabular format to CSV
* [`space2tab`](https://bioinf.shenwei.me/csvtk/usage/#space2tab): converts space delimited format to TSV
* [`csv2md`](https://bioinf.shenwei.me/csvtk/usage/#csv2md): converts CSV to markdown format
* [`csv2rst`](https://bioinf.shenwei.me/csvtk/usage/#csv2rst): converts CSV to reStructuredText format
* [`csv2json`](https://bioinf.shenwei.me/csvtk/usage/#csv2json): converts CSV to JSON format
* [`csv2xlsx`](https://bioinf.shenwei.me/csvtk/usage/#csv2xlsx): converts CSV/TSV files to XLSX file
* [`xlsx2csv`](https://bioinf.shenwei.me/csvtk/usage/#xlsx2csv): converts XLSX to CSV format

**Set operations**

* [`head`](https://bioinf.shenwei.me/csvtk/usage/#head): prints first N records
* [`concat`](https://bioinf.shenwei.me/csvtk/usage/#concat): concatenates CSV/TSV files by rows
* [`sample`](https://bioinf.shenwei.me/csvtk/usage/#sample): sampling by proportion
* [`cut`](https://bioinf.shenwei.me/csvtk/usage/#cut): select and arrange fields
* [`grep`](https://bioinf.shenwei.me/csvtk/usage/#grep): greps data by selected fields with patterns/regular expressions
* [`uniq`](https://bioinf.shenwei.me/csvtk/usage/#uniq): unique data without sorting
* [`freq`](https://bioinf.shenwei.me/csvtk/usage/#freq): frequencies of selected fields
* [`inter`](https://bioinf.shenwei.me/csvtk/usage/#inter): intersection of multiple files
* [`filter`](https://bioinf.shenwei.me/csvtk/usage/#filter): filters rows by values of selected fields with arithmetic expression
* [`filter2`](https://bioinf.shenwei.me/csvtk/usage/#filter2): filters rows by awk-like arithmetic/string expressions
* [`join`](https://bioinf.shenwei.me/csvtk/usage/#join): join files by selected fields (inner, left and outer join)
* [`split`](https://bioinf.shenwei.me/csvtk/usage/#split) splits CSV/TSV into multiple files according to column values
* [`splitxlsx`](https://bioinf.shenwei.me/csvtk/usage/#splitxlsx): splits XLSX sheet into multiple sheets according to column values
* [`comb`](https://bioinf.shenwei.me/csvtk/usage/#comb): compute combinations of items at every row

**Edit**

* [`fix`](https://bioinf.shenwei.me/csvtk/usage/#fix): fix CSV/TSV with different numbers of columns in rows
* [`fix-quotes`](https://bioinf.shenwei.me/csvtk/usage/#fix-quotes): fix malformed CSV/TSV caused by double-quotes
* [`del-quotes`](https://bioinf.shenwei.me/csvtk/usage/#del-quotes): remove extra double-quotes added by `fix-quotes`
* [`add-header`](https://bioinf.shenwei.me/csvtk/usage/#add-header): add column names
* [`del-header`](https://bioinf.shenwei.me/csvtk/usage/#del-header): delete column names
* [`rename`](https://bioinf.shenwei.me/csvtk/usage/#rename): renames column names with new names
* [`rename2`](https://bioinf.shenwei.me/csvtk/usage/#rename2): renames column names by regular expression
* [`replace`](https://bioinf.shenwei.me/csvtk/usage/#replace): replaces data of selected fields by regular expression
* [`round`](https://bioinf.shenwei.me/csvtk/usage/#round): round float to n decimal places
* [`comma`](https://bioinf.shenwei.me/csvtk/usage/comma): make numbers more readable by adding commas
* [`mutate`](https://bioinf.shenwei.me/csvtk/usage/#mutate): creates new columns from selected fields by regular expression
* [`mutate2`](https://bioinf.shenwei.me/csvtk/usage/#mutate2): creates a new column from selected fields by awk-like arithmetic/string expressions
* [`mutate3`](https://bioinf.shenwei.me/csvtk/usage/#mutate3): create a new column from selected fields with Go-like expressions
* [`fmtdate`](https://bioinf.shenwei.me/csvtk/usage/#fmtdate): format date of selected fields

**Transform**

* [`transpose`](https://bioinf.shenwei.me/csvtk/usage/#transpose): transposes CSV data
* [`sep`](https://bioinf.shenwei.me/csvtk/usage/#sep): separate column into multiple columns
* [`gather`](https://bioinf.shenwei.me/csvtk/usage/#gather): gather columns into key-value pairs, like `tidyr::gather/pivot_longer`
* [`spread`](https://bioinf.shenwei.me/csvtk/usage/#spread): spread a key-value pair across multiple columns, like `tidyr::spread/pivot_wider`
* [`unfold`](https://bioinf.shenwei.me/csvtk/usage/#unfold): unfold multiple values in cells of a field
* [`fold`](https://bioinf.shenwei.me/csvtk/usage/#fold): fold multiple values of a field into cells of groups

**Ordering**

* [`sort`](https://bioinf.shenwei.me/csvtk/usage/#sort): sorts by selected fields

**Ploting**

* [`plot`](https://bioinf.shenwei.me/csvtk/usage/#plot) see [usage](http://bioinf.shenwei.me/csvtk/usage/#plot)
  + [`plot hist`](https://bioinf.shenwei.me/csvtk/usage/#plot-hist) histogram
  + [`plot box`](https://bioinf.shenwei.me/csvtk/usage/#plot-box) boxplot
  + [`plot line`](https://bioinf.shenwei.me/csvtk/usage/#plot-line) line plot and scatter plot
  + [`plot bar`](https://bioinf.shenwei.me/csvtk/usage/#plot-bar) plot bar chart

**Misc**

* [`cat`](https://bioinf.shenwei.me/csvtk/usage/#cat) stream file and report progress
* [`version`](https://bioinf.shenwei.me/csvtk/usage/#version) print version information and check for update
* [`genautocomplete`](https://bioinf.shenwei.me/csvtk/usage/#genautocomplete) generate shell autocompletion script (bash|zsh|fish|powershell)

## Installation

[Download Page](https://github.com/shenwei356/csvtk/releases)

`csvtk` is implemented in [Go](https://golang.org/) programming language,
executable binary files **for most popular operating systems** are freely available
in [release](https://github.com/shenwei356/csvtk/releases) page.

#### Method 1: Download binaries (latest stable/dev version)

Just [download](https://github.com/shenwei356/csvtk/releases) compressed
executable file of your operating system,
and decompress it with `tar -zxvf *.tar.gz` command or other tools.
And then:

1. **For Linux-like systems**

   1. If you have root privilege simply copy it to `/usr/local/bin`:

      ```
      sudo cp csvtk /usr/local/bin/
      ```
   2. Or copy to anywhere in the environment variable `PATH`:

      ```
      mkdir -p $HOME/bin/; cp csvtk $HOME/bin/
      ```
2. **For windows**, just copy `csvtk.exe` to `C:\WINDOWS\system32`.

#### Method 2: Install via Pixi

```
pixi global install csvtk
```

#### Method 3: Install via conda (latest stable version) [![Anaconda Cloud](https://anaconda.org/conda-forge/csvtk/badges/version.svg)](https://anaconda.org/conda-forge/csvtk)

```
# >= v0.31.0
conda install -c conda-forge csvtk

# <= v0.31.0
conda install -c bioconda csvtk
```

#### Method 4: Install via homebrew

```
brew install csvtk
```

#### Method 5: For Go developer (latest stable/dev version)

```
go install github.com/shenwei356/csvtk/csvtk@latest
```

#### Method 6: For ArchLinux AUR users (may be not the latest)

```
yaourt -S csvtk
```

## Command-line completion

Bash:

```
# generate completion shell
csvtk genautocomplete --shell bash

# configure if never did.
# install bash-completion if the "complete" command is not found.
echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
echo "source ~/.bash_completion" >> ~/.bashrc
```

Zsh:

```
# generate completion shell
csvtk genautocomplete --shell zsh --file ~/.zfunc/_csvtk

# configure if never did
echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
echo "autoload -U compinit; compinit" >> ~/.zshrc
```

fish:

```
csvtk genautocomplete --shell fish --file ~/.config/fish/completions/csvtk.fish
```

## Compared to `csvkit`

[csvkit](http://csvkit.readthedocs.org/), attention: this table wasn't updated for many years.

| Features | csvtk | csvkit | Note |
| --- | --