[ganon2](..)

* [ganon2](..)

* Quick Start
  + [Install](#install)
  + [Download and Build a database](#download-and-build-a-database)
  + [Classify and generate a tax. profile](#classify-and-generate-a-tax-profile)
  + [Important parameters](#important-parameters)
    - [ganon build](#ganon-build)
    - [ganon classify](#ganon-classify)
    - [ganon report](#ganon-report)

* [Parameters](../params/)

* [Databases (ganon build)](../default_databases/)

* [Custom databases (ganon build-custom)](../custom_databases/)

* [Classification (ganon classify)](../classification/)

* [Reports (ganon report)](../reports/)

* [Table (ganon table)](../table/)

* [Output files](../outputfiles/)

* [Tutorials](../tutorials/)

[ganon2](..)

* Quick Start

---

# Quick Start Guide[:)](#quick-start-guide "Permanent link")

## Install[:)](#install "Permanent link")

```
conda install -c conda-forge -c bioconda ganon
```

## Download and Build a database[:)](#download-and-build-a-database "Permanent link")

* Bacteria - NCBI RefSeq - representative genomes

```
ganon build --db-prefix bac_rs_rg --source refseq --organism-group bacteria --reference-genomes --threads 24
```

* If you want to test ganon functionalities with a smaller database, use `archaea` instead of `bacteria` in the example above.

## Classify and generate a tax. profile[:)](#classify-and-generate-a-tax-profile "Permanent link")

* [Download test reads](https://github.com/pirovc/ganon_benchmark/raw/master/files/reads/cami/toy/H01_1M_0.1.fq.gz)

```
ganon classify --db-prefix bac_rs_rg --output-prefix classify_results --single-reads H01_1M_0.1.fq.gz --threads 24
```

* `classify_results.tre` -> taxonomic profile

---

## Important parameters[:)](#important-parameters "Permanent link")

The most important parameters and trade-offs to be aware of when using ganon:

### ganon build[:)](#ganon-build "Permanent link")

* `--level`: Highest level to build the database. Can be a taxonomic rank [species, genus, ...], 'leaves' for taxonomic leaves or 'assembly' for a assembly/strain based analysis. The more specific the level, the bigger the database will be.
* `--max-fp`: controls the false positive of the bloom filters. The higher the `--max-fp`, the smaller the databases at a cost of sensitivity in classification.
* `--window-size --kmer-size`: the *window* value should always be the same or larger than the *k-mer* value. The larger the difference between them, the smaller the database will be. However, some sensitivity/precision loss in classification is expected with small *k-mer* and/or large *window*. Larger *k-mer* values (e.g. `31`) will improve classification, specially read binning, at a cost of larger databases.

### ganon classify[:)](#ganon-classify "Permanent link")

* `--rel-cutoff`: defines the min. percentage of k-mers shared to a reference to consider a match. Higher values will improve precision and decrease sensitivity. For taxonomic profiling, a higher value between `0.4` and `0.8` may provide better results. For read binning, lower values between `0.2` and `0.4` are recommended.
  + **lower** values -> **more read matches**
  + **higher** values -> **less read matches**
* `--rel-filter`: filter matches in relation to the best and worst after the cutoff is applied. `0` means only matches with top score (# of *k-mers*) as the best match will be kept.
  + **lower** values -> **more unique matching reads**
  + **higher** values -> **more multi-matching reads**
* `--multiple-matches`: defines how ganon treats multiple-matching reads. Either by an EM-algorithm based on unique matches or a taxonomy-based LCA algorithm.

### ganon report[:)](#ganon-report "Permanent link")

* `--report-type`: reports either taxonomic, sequence or matches abundances. Use `corr` or `abundance` for taxonomic profiling, `reads` or `dist` for sequence profiling and `matches` to report a summary of all matches.
* `--min-count`: cutoff to discard underrepresented taxa. Useful to remove the common long tail of spurious matches and false positives when performing classification. Values between `0.0001` (0.01%) and `0.001` (0.1%) improved sensitivity and precision in our evaluations. The higher the value, the more precise the outcome, with a sensitivity loss. Alternatively `--top-percentile` can be used to keep a relative amount of taxa instead a hard cutoff.

The numeric values above are averages from several experiments with different sample types and database contents. They may not work as expected for your data. If you are not sure which values to use or see something unexpected, please open an [issue](https://github.com/pirovc/ganon/issues).

[Previous](.. "ganon2")
[Next](../params/ "Parameters")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[« Previous](..)
[Next »](../params/)