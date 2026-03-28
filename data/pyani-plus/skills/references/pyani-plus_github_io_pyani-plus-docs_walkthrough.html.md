1. [pyANI-plus walkthrough](./walkthrough.html)

[pyANI-plus](./)

* [About pyANI-plus](./index.html)
* [Requirements](./requirements.html)
* [Installation](./installation.html)
* [pyANI-plus walkthrough](./walkthrough.html)
* [pyANI-plus subcommands](./subcommands/subcommands.html)

  + [1  `anib`](./subcommands/anib.html)
  + [2  `anim`](./subcommands/anim.html)
  + [3  `dnadiff`](./subcommands/dnadiff.html)
  + [4  `external-alignment`](./subcommands/external_alignment.html)
  + [5  `fastani`](./subcommands/fastani.html)
  + [6  `sourmash`](./subcommands/sourmash.html)
  + [7  `plot-run`](./subcommands/plot_run.html)
  + [8  `plot-run-comp`](./subcommands/plot_run_comp.html)
  + [9  `list-runs`](./subcommands/list_runs.html)
  + [10  `export-run`](./subcommands/export_run.html)
  + [11  `resume`](./subcommands/resume.html)
  + [12  `delete-run`](./subcommands/delete_run.html)
  + [13  `classify`](./subcommands/classify.html)
* [Cluster](./cluster.html)
* [Contributing to `pyANI-plus`](./contributing.html)
* [Testing](./testing.html)
* [Licensing](./licensing.html)

  + [14  pyANI-plus](./pyani_licence.html)
  + [15  pyANI-plus documentation](./doc_licence.html)

## Table of contents

* [Collect genomes for analysis](#collect-genomes-for-analysis)
* [Conducting ANI analysis](#conducting-ani-analysis)
  + [Conduct ANIm analysis](#conduct-anim-analysis)
  + [Conduct ANIb analysis](#conduct-anib-analysis)
  + [Conduct `dnadiff` analysis](#conduct-dnadiff-analysis)
  + [Conduct `fastani` analysis](#conduct-fastani-analysis)
  + [Conduct `sourmash` analysis](#conduct-sourmash-analysis)
* [Reporting Analyses and Analysis Results](#reporting-analyses-and-analysis-results)
  + [List all runs in the database](#list-runs)
  + [Exporting ANI results in tabular format](#exporting-ani-results-in-tabular-format)
  + [Graphical output](#graphical-output)
* [Plotting comparisons between runs](#plotting-comparisons-between-runs)

* [Edit this page](https://github.com/pyani-plus/pyani-plus-docs/edit/main/walkthrough.qmd)
* [Report an issue](https://github.com/pyani-plus/pyani-plus-docs/issues/new)

# pyANI-plus walkthrough

This section walks through how `pyANI-plus` can be applied to calculate Average Nucleotide Identity, render graphical and tabular summary output, and perform other related measures for whole genome comparisons. The general procedure for any `pyANI-plus` analysis is:

1. Collect genomes for analysis
2. Perform ANI analysis using a chosen method such as ANIb, ANIm, etc.
3. Report as tabular output and/or generate a graphical visualisation
4. Use the analysis results to classify input genomes and generate species hypotheses

Tip

Before using `pyANI-plus`, make sure to install it on a local machine like a laptop, desktop, server, or cluster. Please see section [installation](./installation.html#installation) for installation instructions.

Use the command below to generate the help message for `pyani-plus`:

```
pyani-plus -h
```

Note

This is a command-line tool, meaning you type commands into a terminal window to run it. To view avaliable options type `pyani-plus` (in lower case), space, then `-h` (minus lower-case H) for the help option, and finally enter or return to run the command.

This should output the following (or similar) - hopefully in colour depending on your terminal setup:

```
 Usage: pyani-plus [OPTIONS] COMMAND [ARGS]...

╭─ Options ────────────────────────────────────────────────────────────────╮
│ --version             -v        Show tool version (on stdout) and quit.  │
│ --install-completion            Install completion for the current       │
│                                 shell.                                   │
│ --show-completion               Show completion for the current shell,   │
│                                 to copy it or customize the              │
│                                 installation.                            │
│ --help                -h        Show this message and exit.              │
╰──────────────────────────────────────────────────────────────────────────╯
╭─ Commands ───────────────────────────────────────────────────────────────╮
│ resume               Resume any (partial) run already logged in the      │
│                      database.                                           │
│ list-runs            List the runs defined in a given pyANI-plus SQLite3 │
│                      database.                                           │
│ delete-run           Delete any single run from the given pyANI-plus     │
│                      SQLite3 database.                                   │
│ export-run           Export any single run from the given pyANI-plus     │
│                      SQLite3 database.                                   │
│ plot-run             Plot heatmaps and distributions for any single run. │
│ plot-run-comp        Plot comparisons between multiple runs.             │
│ classify             Classify genomes into clusters based on ANI         │
│                      results.                                            │
╰──────────────────────────────────────────────────────────────────────────╯
╭─ ANI methods ────────────────────────────────────────────────────────────╮
│ anim                 Execute ANIm calculations, logged to a pyANI-plus   │
│                      SQLite3 database.                                   │
│ dnadiff              Execute mumer-based dnadiff calculations, logged to │
│                      a pyANI-plus SQLite3 database.                      │
│ anib                 Execute ANIb calculations, logged to a pyANI-plus   │
│                      SQLite3 database.                                   │
│ fastani              Execute fastANI calculations, logged to a           │
│                      pyANI-plus SQLite3 database.                        │
│ sourmash             Execute sourmash-plugin-branchwater ANI             │
│                      calculations, logged to a pyANI-plus SQLite3        │
│                      database.                                           │
│ external-alignment   Compute pairwise ANI from given                     │
│                      multiple-sequence-alignment (MSA) file.             │
╰──────────────────────────────────────────────────────────────────────────╯
```

To see the options for a specific subcommand, use `pyani-plus <subcommand> -h`. For example, to view options for the ANIb method:

```
pyani-plus anib -h
```

Expected output:

```
 Usage: pyani-plus anib [OPTIONS] FASTA

 Execute ANIb calculations, logged to a pyANI-plus SQLite3 database.

╭─ Arguments ──────────────────────────────────────────────────────────────╮
│ *    fasta      PATH  Directory of FASTA files (extensions .fas, .fasta, │
│                       .fna).                                             │
│                       [required]                                         │
╰──────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────╮
│ *  --database   -d      FILE           Path to pyANI-plus SQLite3        │
│                                        database.                         │
│                                        [required]                        │
│    --name               TEXT           Run name. Default is 'N genomes   │
│                                        using METHOD'.                    │
│    --create-db                         Create database if does not       │
│                                        exist.                            │
│    --executor           [local|slurm]  How should the internal tools be  │
│                                        run?                              │
│                                        [default: local]                  │
│    --help       -h                     Show this message and exit.       │
╰──────────────────────────────────────────────────────────────────────────╯
╭─ Method parameters ──────────────────────────────────────────────────────╮
│ --fragsize        INTEGER RANGE [x>=1]  Comparison method fragment size. │
│                                         [default: 1020]                  │
╰──────────────────────────────────────────────────────────────────────────╯
╭─ Debugging ──────────────────────────────────────────────────────────────╮
│ --temp         DIRECTORY  Directory to use for intermediate files, which │
│                           for debugging purposes will not be deleted.    │
│                           For clusters this must be on a shared drive.   │
│                           Default behaviour is to use a system specified │
│                           temporary directory (specific to the           │
│                           compute-node when using a cluster) and remove  │
│                           this afterwards.                               │
│ --wtemp        DIRECTORY  Directory to use for temporary workflow        │
│                           coordination files, which for debugging        │
│                           purposes will not be deleted. For clusters     │
│                           this must be on a shared drive. Default        │
│                           behaviour is to use a system specified         │
│                           temporary directory (for the local executor)   │
│                           or a temporary directory under the present     │
│                           direct (for clusters), and remove this         │
│                           afterwards.                                    │
│ --log          FILE       Where to record log(s). Use '-' for no         │
│                           logging.                                       │
│                           [default: pyani-plus.log]                      │
│ --debug                   Show debugging level logging at the terminal   │
│                           (in addition to the log file).                 │
╰──────────────────────────────────────────────────────────────────────────╯
```

## Collect genomes for analysis

While you can work with your choice of genomes as FASTA files placed in a local directory, we suggest using the ten genomes provided in the compressed folder linked below when first following this walkthrough, to ensure the output matches the expected results.

* [Walkthrough genome files (compressed) `walkthrough_data.zip`](./assets/walkthrough_data.zip)

Note

To uncompress this folder, either use your operating system’s built-in tools in the file explorer, or use a command like:

```
unzip walkthrough_data.zip
```

`pyANI-plus` accepts FASTA files with the extensions `.fasta`, `.fas`, and `.fna`, and gzip compressed formats like `.fasta.gz`, `.fas.gz`, and `.fna.gz`. Please make sure that your input files match these extensions to ensure that `pyANI-plus` works.

## Conducting ANI analysis

`pyANI-plus` enables genome comparison using various ANI methods.

In this walkthrough, we will demonstrate methods including ANIm, ANIb, dnadiff, fastANI, and sourmash. We recommend trying several of these methods on the walkthrough dataset, so their results can be compared using the `plot-run-comp` command.

Running any ANI method on requires that you specify the directory containing the genome data (e.g., `walkthrough_data/`), and the path to the pyANI-plus SQLite3 database (`walkthrough.db` for this walkthrough).

Important

If this is your first analysis and the SQLite3 database does not yet exist, you must use the `--create-db` option; otherwise, you will encounter the following error:

```
ERROR: Database walkthrough.db does not exist, but not using --create-db
```

Optionally, you can provide a custom name for the analysis with the `--name` option for easier reference.

If you want to run the ANI analysis on a cluster using SLURM, you must set the execution method using `--executor slurm` (the default is `--executor local`).

### Conduct ANIm analysis

We first run ANIm analysis on the downloaded genomes, and creating the local database, using the command line:

```
pyani-plus anim walkthrough_data/ --database walkthrough.db --create-db --name "walkthrough ANIm"
```

With the walkthrough dataset this should take about 2-5 minutes on a recent multi-core desktop or laptop computer.

In ANIm analysis, the default setting uses anchor matches that are unique in the reference but not necessarily unique in the query (`--mode mum`). You can change this to include all anchor matches, regardless of their uniqueness, by setting the `--mode` option to `maxmatch`.

### Conduct ANIb analysis

To run ANIb analysis on the downloaded genomes use the command line:

```
pyani-plus anib walkthrough_data/ --database walkthrough.db --name "walkthrough ANIb"
```

With the suggested ten genomes this should take about 5-10 minutes on a recent multi-core desktop or laptop computer. The other methods should all be considerably faster.

If you wish you can select a different fragment size for the comparison method using the `--fragsize` option. The default fragment size is 1020bp (listed in the help output shown earlier), which is typically used for ANIb.

### Conduct `dnadiff` analysis

To compare genomes in the input `walkthrough_data` directory using the `dnadiff` method use the following command line:

```
pyani-plus dnadiff walkthrough_data/ --database walkthrough.db --name "walkthrough dnadiff"
```

With the walkthrough dataset this should take about 2-5 minutes on a recent multi-core desktop or laptop computer.

### Conduct `fastani` analysis

To run `fastani` analysis on the genomes in the input `walkthrough_data` directory use the following command line:

```
pyani-plus fastani walkthrough_data/ --database walkthrough.db --name "walkthrough fastani"
```

With the walkthrough dataset this should take less than 30 seconds on a recent multi-core desktop or laptop computer.

In `fastani` analysis, additional method parameters can be changed by the user. These include:

* `--fragsize`: Fragment length used in the analysis (default: `3000`).
* `--kmersize`: *k*-mer size, set to `16` by default. It can be set to any value smaller than 16.
* `--minmatch`: Minimum fraction of the genome that must be shared for ANI to be considered reliable. If the reference and query genome sizes differ, the smaller genome is used. (Default: `0.2`).

### Conduct `sourmash` analysis

Lastly, we can run `sourmash` analysis with the following command line:

```
pyani-plus sourmash walkthrough_data/ --database walkthrough.db --name "walkthrough sourmash"
```

With the walkthrough dataset this should take less than 15 seconds on a recent multi-core desktop or laptop computer.

For `sourmash` analysis, additional method parameters can be changed by the user. These include: - `--scaled`: Compression ration (defult: `1000`) - `--kmersize`: *k*-mer size (default: `31`)

## Reporting Analyses and Analysis Results

### List all runs in 