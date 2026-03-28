latest

* [Overview](readme.html)
* [Installation](installation.html)
* Command Line Interface
  + [Run Mode](#run-mode)
    - [-h, --help](#h-help)
    - [--skip-mtbseq](#skip-mtbseq)
    - [-p, --preprocess](#p-preprocess)
    - [-i DIR, --fastq-dir DIR](#i-dir-fastq-dir-dir)
    - [-o DIR, --output DIR](#o-dir-output-dir)
    - [--sample-id SampleID](#sample-id-sampleid)
    - [-d DrugCode, --drug DrugCode](#d-drugcode-drug-drugcode)
  + [Examples](#examples)
  + [Self-test mode](#self-test-mode)
    - [-h, --help](#id1)
    - [-f, --fast](#f-fast)
    - [-c, --complete](#c-complete)
  + [Examples](#id2)
* [Python Interface](api/modules.html)
* [Contributing & Help](contributing.html)
* [Acknowledgments](acknowledgments.html)
* [Authors](authors.html)
* [Release Notes](changelog.html)
* [License](license.html)
* [References](references.html)

[geno2phenoTB](index.html)

* Command Line Interface
* [Edit on GitHub](https://github.com/msmdev/geno2phenoTB/blob/main/docs/cli.rst)

---

# [Command Line Interface](#id3)[](#command-line-interface "Permalink to this heading")

The command-line interface (CLI) offers two modes: a self-test mode and a run mode.

Table of Contents

* [Command Line Interface](#command-line-interface)

  + [Run Mode](#run-mode)

    - [-h, --help](#h-help)
    - [--skip-mtbseq](#skip-mtbseq)
    - [-p, --preprocess](#p-preprocess)
    - [-i DIR, --fastq-dir DIR](#i-dir-fastq-dir-dir)
    - [-o DIR, --output DIR](#o-dir-output-dir)
    - [--sample-id SampleID](#sample-id-sampleid)
    - [-d DrugCode, --drug DrugCode](#d-drugcode-drug-drugcode)
  + [Examples](#examples)
  + [Self-test mode](#self-test-mode)

    - [-h, --help](#id1)
    - [-f, --fast](#f-fast)
    - [-c, --complete](#c-complete)
  + [Examples](#id2)

## [Run Mode](#id4)[](#run-mode "Permalink to this heading")

This mode is used to predict antibiotic resistance of Mycobacterium tuberculosis.
The primary run command has several options:

```
geno2phenotb run [-h] [--skip-mtbseq] [-p] -i DIR -o DIR
                --sample-id SampleID
                [-d DrugCode]
```

Options:

> * -h, --help
> * --skip-mtbseq
> * -p, --preprocess
> * -i, --fastq-dir
> * -o, --output
> * --sample-id
> * -d, --drug

Below is a description of each option:

### [-h, --help](#id5)[](#h-help "Permalink to this heading")

Show the help message and exit.

### [--skip-mtbseq](#id6)[](#skip-mtbseq "Permalink to this heading")

Skip the MTBseq step. Precomputed output must be present in the specified FASTQ directory.

### [-p, --preprocess](#id7)[](#p-preprocess "Permalink to this heading")

Run only the preprocessing steps. The FASTQ reads will be assembled using MTBseq and features
extracted. This will skip the prediction.

### [-i DIR, --fastq-dir DIR](#id8)[](#i-dir-fastq-dir-dir "Permalink to this heading")

Path to the input directory where the FASTQ files are located.

As input, a directory with FASTQ files is required.
The FASTQ files must follow this naming scheme:

```
[SampleID]_[LibID]_[*]_[Direction].f(ast)q.gz
                    ^- Optional values.
Direction must be one of R1, R2.
```

### [-o DIR, --output DIR](#id9)[](#o-dir-output-dir "Permalink to this heading")

Path to the directory where the final output files should be stored.

### [--sample-id SampleID](#id10)[](#sample-id-sampleid "Permalink to this heading")

SampleID (i.e., ERR/SRR run accession). The ID should match with the ID of the FASTQ files.

### [-d DrugCode, --drug DrugCode](#id11)[](#d-drugcode-drug-drugcode "Permalink to this heading")

The drug for which resistance should be predicted. If you want predictions for several drugs,
use the argument several times, i.e., –d AMK –d DCS –d STR. If the flag is not set,
predictions for all drugs will be performed.

The DrugCode is a 2 / 3 letter code and can be one of:

```
AMK, CAP, DCS, EMB, ETH, FQ, INH, KAN, PAS, PZA, RIF, STR
```

## [Examples](#id12)[](#examples "Permalink to this heading")

Predict the resistance of the sample (ERR551304) against all drugs:

```
$ geno2phenotb run -i dir_to_ERR551304/ -o output_dir/ --sample-id ERR551304
```

Predict only the resistance against AMK and RIF:

```
$ geno2phenotb run -i dir_to_ERR551304/ -o output_dir/ --sample-id ERR551304 -d AMK -d RIF
```

Skip the MTBseq steps and use the precomputed output:

```
$ geno2phenotb run -i dir_to_precomputed/ -o output_dir/ --sample-id ERR551304 --skip-mtbseq
```

## [Self-test mode](#id13)[](#self-test-mode "Permalink to this heading")

To check the integrity of the installation and dependencies, a self-test can be executed.
It does NOT guarantee that everything is okay, but is strong evidence:

```
geno2phenotb test [-h] (-f | -c)
```

The available options for the self-test mode are:

> * -h, --help
> * -f, --fast
> * -c, --complete

Descriptions of the self-test mode options:

### [-h, --help](#id14)[](#id1 "Permalink to this heading")

Show the help message and exit.

### [-f, --fast](#id15)[](#f-fast "Permalink to this heading")

Fast test of the installation. This will not test the preprocessing / MTBSeq steps.

### [-c, --complete](#id16)[](#c-complete "Permalink to this heading")

Complete test of the installation. This will download ~170 MB from the ENA and start a complete
run. Depending on your bandwidth / hardware, this may take a few (5-30) minutes.

## [Examples](#id17)[](#id2 "Permalink to this heading")

To run the complete test (recommended) run:

```
$ geno2phenotb test -c
```

[Previous](installation.html "Installation")
[Next](api/modules.html "geno2phenotb")

---

© Copyright 2023, Bernhard Reuter, Jules Kreuer.
Revision `d0de6e0a`.