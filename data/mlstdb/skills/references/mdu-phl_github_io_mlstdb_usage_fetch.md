[ ]
[ ]

[Skip to content](#fetch-advanced)

mlstdb

Fetch (Advanced)

Initializing search

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Getting Started](../../getting-started/)
* [Usage](../overview/)
* [Disclaimer](../../disclaimer/)
* [Changelog](../../changelog/)

mlstdb

[MDU-PHL/mlstdb](https://github.com/MDU-PHL/mlstdb "Go to repository")

* [Home](../..)
* [Installation](../../installation/)
* [Getting Started](../../getting-started/)
* [x]

  Usage

  Usage
  + [Overview](../overview/)
  + [Connect](../connect/)
  + [Update](../update/)
  + [Purge](../purge/)
  + [ ]

    Fetch (Advanced)

    [Fetch (Advanced)](./)

    Table of contents
    - [Basic Usage](#basic-usage)
    - [Options](#options)
    - [Examples](#examples)

      * [Explore all MLST schemes on PubMLST](#explore-all-mlst-schemes-on-pubmlst)
      * [Filter for a specific species](#filter-for-a-specific-species)
      * [Find all schemes (including cgMLST)](#find-all-schemes-including-cgmlst)
      * [Resume an interrupted fetch](#resume-an-interrupted-fetch)
      * [Speed up with parallel processing](#speed-up-with-parallel-processing)
    - [Output](#output)

      * [Using fetch output with update](#using-fetch-output-with-update)
    - [How it works](#how-it-works)

      * [Scheme name resolution](#scheme-name-resolution)
    - [Troubleshooting](#troubleshooting)

      * ["No resources found"](#no-resources-found)
      * [Missing schemes in output](#missing-schemes-in-output)
      * [Progress tracking](#progress-tracking)
* [Disclaimer](../../disclaimer/)
* [Changelog](../../changelog/)

Table of contents

* [Basic Usage](#basic-usage)
* [Options](#options)
* [Examples](#examples)

  + [Explore all MLST schemes on PubMLST](#explore-all-mlst-schemes-on-pubmlst)
  + [Filter for a specific species](#filter-for-a-specific-species)
  + [Find all schemes (including cgMLST)](#find-all-schemes-including-cgmlst)
  + [Resume an interrupted fetch](#resume-an-interrupted-fetch)
  + [Speed up with parallel processing](#speed-up-with-parallel-processing)
* [Output](#output)

  + [Using fetch output with update](#using-fetch-output-with-update)
* [How it works](#how-it-works)

  + [Scheme name resolution](#scheme-name-resolution)
* [Troubleshooting](#troubleshooting)

  + ["No resources found"](#no-resources-found)
  + [Missing schemes in output](#missing-schemes-in-output)
  + [Progress tracking](#progress-tracking)

# Fetch (Advanced)

Advanced command

Most users don't need `fetch`. The `update` command already includes a curated list of ~170 validated MLST schemes. Use `fetch` only if you need to explore all available schemes or build a custom scheme list.

The `fetch` command discovers and lists all available MLST schemes from PubMLST or Pasteur, with flexible filtering options. Its output can be used as input to `mlstdb update --input`.

---

## Basic Usage

```
mlstdb fetch --db pubmlst
```

This scans all databases on PubMLST, finds schemes matching "MLST" (excluding "cgMLST"), and writes the results to `mlst_schemes_pubmlst.tab`.

---

## Options

| Option | Description | Default |
| --- | --- | --- |
| `--db`, `-d` | Database to explore: `pubmlst` or `pasteur` | Prompted |
| `--match`, `-m` | Scheme name must include this term | `MLST` |
| `--exclude`, `-e` | Scheme name must NOT include this term | `cgMLST` |
| `--filter`, `-f` | Wildcard filter on species/scheme names | None |
| `--scheme-uris`, `-s` | Path to custom scheme name mapping file | Built-in |
| `--resume`, `-r` | Resume from where it stopped | Off |
| `--no-auth` | Use unauthenticated access | Off |
| `--threads`, `-t` | Parallel threads for fetching (max: 4) | `1` |
| `--verbose`, `-v` | Show detailed debug output | Off |
| `-h`, `--help` | Show help message |  |

---

## Examples

### Explore all MLST schemes on PubMLST

```
mlstdb fetch --db pubmlst
```

### Filter for a specific species

```
mlstdb fetch --db pubmlst --filter "*klebsiella*"
```

### Find all schemes (including cgMLST)

```
mlstdb fetch --db pubmlst --match "" --exclude ""
```

### Resume an interrupted fetch

```
mlstdb fetch --db pubmlst --resume
```

### Speed up with parallel processing

```
mlstdb fetch --db pubmlst --threads 4
```

---

## Output

`fetch` creates a tab-delimited file named `mlst_schemes_<db>.tab`:

```
database    species scheme_description  scheme  URI
pubmlst Klebsiella pneumoniae   MLST    klebsiella  https://rest.pubmlst.org/db/pubmlst_klebsiella_seqdef/schemes/1
pubmlst Listeria monocytogenes  MLST    listeria    https://rest.pubmlst.org/db/pubmlst_listeria_seqdef/schemes/1
```

### Using fetch output with update

After reviewing and curating the scheme list, use it as input to `update`:

```
# 1. Fetch schemes
mlstdb fetch --db pubmlst --filter "*listeria*"

# 2. Review the output
cat mlst_schemes_pubmlst.tab

# 3. Edit if needed (remove unwanted schemes)
# nano mlst_schemes_pubmlst.tab

# 4. Use as input to update
mlstdb update --input mlst_schemes_pubmlst.tab
```

---

## How it works

1. **Connects** to the BIGSdb API for the chosen database
2. **Scans** all available databases and their schemes
3. **Filters** schemes by the `--match` and `--exclude` patterns
4. **Sanitises** scheme names using the built-in `scheme_uris.tab` mapping
5. **Writes** matching schemes to the output file

### Scheme name resolution

`fetch` needs to map API URLs to short scheme names (e.g., `klebsiella`) that the `mlst` tool uses as directory names. It tries to:

1. Match against the existing scheme name mapping (from `scheme_uris.tab`)
2. If no match is found, either:
   * Mark it as `missing` in the output, or
   * Auto-generate a name from the URL (e.g., `https://rest.pubmlst.org/db/pubmlst_borrelia_seqdef/schemes/1` → `borrelia`)

You'll be prompted to choose when unresolved schemes are found.

---

## Troubleshooting

### "No resources found"

* Check your internet connection
* Verify credentials: `mlstdb connect --db pubmlst`
* Try with `--verbose` for more detail

### Missing schemes in output

* Some databases may require individual registration on the website
* Use `--verbose` to see which databases were skipped and why

### Progress tracking

When using `--resume`, progress is tracked in `processed_dbs_<db>.tab`. This file is automatically deleted once all databases have been processed successfully.

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)