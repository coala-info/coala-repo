[ganon2](..)

* [ganon2](..)

* [Quick Start](../start/)

* [Parameters](../params/)

* [Databases (ganon build)](../default_databases/)

* [Custom databases (ganon build-custom)](../custom_databases/)

* [Classification (ganon classify)](../classification/)

* [Reports (ganon report)](../reports/)

* Table (ganon table)
  + [Examples](#examples)
    - [Counts of species](#counts-of-species)
    - [Abundance of species](#abundance-of-species)
    - [Top 10 species (among all samples)](#top-10-species-among-all-samples)
    - [Top 10 species (from each samples)](#top-10-species-from-each-samples)
    - [Filtering results](#filtering-results)

* [Output files](../outputfiles/)

* [Tutorials](../tutorials/)

[ganon2](..)

* Table (ganon table)

---

# Table[:)](#table "Permanent link")

`ganon table` filters and summarizes several reports obtained with `ganon report` into a table. Filters for each sample or for averages among all samples can also be applied.

## Examples[:)](#examples "Permanent link")

Given several `.tre` from `ganon report`:

### Counts of species[:)](#counts-of-species "Permanent link")

```
ganon table --input *.tre --output-file table.tsv --rank species
```

### Abundance of species[:)](#abundance-of-species "Permanent link")

```
ganon table --input *.tre --output-file table.tsv --output-value percentage --rank species
```

### Top 10 species (among all samples)[:)](#top-10-species-among-all-samples "Permanent link")

```
ganon table --input *.tre --output-file table.tsv --output-value percentage --rank species --top-all 10
```

### Top 10 species (from each samples)[:)](#top-10-species-from-each-samples "Permanent link")

```
ganon table --input *.tre --output-file table.tsv --output-value percentage --rank species --top-sample 10
```

### Filtering results[:)](#filtering-results "Permanent link")

```
ganon table --input *.tre --output-file table.tsv --output-value percentage --rank species --min-count 0.0005
```

This will keep only results with a min. abundance of `0.05%`.

[Previous](../reports/ "Reports (ganon report)")
[Next](../outputfiles/ "Output files")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).

[« Previous](../reports/)
[Next »](../outputfiles/)