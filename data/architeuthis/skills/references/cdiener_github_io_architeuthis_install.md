[ ]
[ ]

[Skip to content](#conda-or-mamba)

[![logo](../architeuthis.webp)](.. "Documentation")

Documentation

Installation

Initializing search

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [Installation](./)
* [User Guide](../lineage/)
* [Releases](../release_notes/)

[![logo](../architeuthis.webp)](.. "Documentation")
Documentation

[cdiener/architeuthis](https://github.com/cdiener/architeuthis "Go to repository")

* [Home](..)
* [ ]

  Installation

  [Installation](./)

  Table of contents
  + [Conda or Mamba](#conda-or-mamba)
  + [Binary release](#binary-release)
  + [Choose a NCBI Taxonomy version](#choose-a-ncbi-taxonomy-version)
* [ ]

  User Guide

  User Guide
  + [Lineage annotation](../lineage/)
  + [Merging](../merge/)
  + [Mapping Analysis](../mapping/)
  + [Filtering](../filter/)
* [Releases](../release_notes/)

Table of contents

* [Conda or Mamba](#conda-or-mamba)
* [Binary release](#binary-release)
* [Choose a NCBI Taxonomy version](#choose-a-ncbi-taxonomy-version)

# Installation

Architeuthis is a standalone binary. Some of its installation requires [taxonkit](https://bioinf.shenwei.me/taxonkit/)
I recommend you install this as well (already done when using conda).

## Conda or Mamba

`architeuthis` is provided within bioconda and can be installed via

```
conda install -c conda-forge -c bioconda architeuthis
```

## Binary release

You can also simply download a binary for your system from the
[releases page](https://github.com/cdiener/architeuthis/release). Either execute it in the
containing folder order add it to your `$PATH`.

## Choose a NCBI Taxonomy version

This will also install taxonkit. If you want to use a new or custom version of the
NCBI taxonomy you need to [set that up with taxonkit](https://bioinf.shenwei.me/taxonkit/#dataset).

In case you have built your own Kraken database it is also possible to use the taxonomy
directly from there. For this simply add the `--db` option to your `architeuthis` calls.
For instance:

```
architeuthis --db /path/to/my/kraken_db lineage my_file.b2
```

Which Taxonomy to use?

Unless you specifically want to reclassify under a different taxonomy, I recommend
to always use the taxonomy from the Kraken DB if available.

[Previous

Home](..)
[Next

Lineage annotation](../lineage/)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)