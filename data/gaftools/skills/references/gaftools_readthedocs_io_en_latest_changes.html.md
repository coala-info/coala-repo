[gaftools](index.html)

* [Installation](installation.html)
* [User Guide](guide.html)
* [Developing](develop.html)
* Changes
  + [v1.3.2 (25/03/2026)](#v1-3-2-25-03-2026)
  + [v1.3.1 (27/01/2026)](#v1-3-1-27-01-2026)
  + [v1.3.0 (06/11/2025)](#v1-3-0-06-11-2025)
  + [v1.2.1 (08/09/2025)](#v1-2-1-08-09-2025)
  + [v1.2.0 (03/07/2025)](#v1-2-0-03-07-2025)
  + [v1.1.3 (30/05/2025)](#v1-1-3-30-05-2025)
  + [v1.1.2 (30/05/2025)](#v1-1-2-30-05-2025)
  + [v1.1.1 (23/01/2025)](#v1-1-1-23-01-2025)
  + [v1.1.0 (09/10/2024)](#v1-1-0-09-10-2024)
  + [v1.0.0 (24/06/2024)](#v1-0-0-24-06-2024)

[gaftools](index.html)

* Changes
* [View page source](_sources/changes.rst.txt)

---

# Changes[](#changes "Link to this heading")

## v1.3.2 (25/03/2026)[](#v1-3-2-25-03-2026 "Link to this heading")

* Updated `realign` to support reads in FASTA/FASTQ, including gzipped inputs by adding the pyfastx dependency to the project.

## v1.3.1 (27/01/2026)[](#v1-3-1-27-01-2026 "Link to this heading")

* Fixed issue with inclusion of terminal bubbles on components for proper tagging in `order_gfa`.
* Added more checks for GAF file formats in subcommands `realign` and `sort`.

## v1.3.0 (06/11/2025)[](#v1-3-0-06-11-2025 "Link to this heading")

* Minor updates to `find_path` for improved error handling when given paths are invalid.
* Fixed timer issue in `gfa2rgfa` subcommand. Now reports more accurate time.
* Minor fixes to `gfa2rgfa` regarding parsing of S lines and handling of temporary files.
* Major addition to `order_gfa` subcommand to allow handling of branched graphs. Now users can provide `--ignore-branching` flag to create a ordering even when the graph has a branched structure.
* Addition of `--output-scaffold` flag in `order_gfa` subcommand to output the scaffold graph in GFA format. This graph has bubbles collapsed into single nodes to better visualise the scaffold structure.

## v1.2.1 (08/09/2025)[](#v1-2-1-08-09-2025 "Link to this heading")

* Updated `gaftools gfa2rgfa` subcommand to no longer require `seqfile` by default. The default behaviour is to use the order of assemblies as given in the GFA file.
* Fixing the time logger issue with `gaftools realign` subcommand.
* Bug fix in the index file created by `gaftools sort` subcommand. The index file was incorrectly skipping the first alignment record.
* Minor updates to documentation regarding `seqfile` in `gaftools gfa2rgfa` subcommand.

## v1.2.0 (03/07/2025)[](#v1-2-0-03-07-2025 "Link to this heading")

* Version push intended for manuscript revision submission.
* Minor updates to documentation includes better explanation of sort and view index structure, and minor error handling changes to `order_gfa`.
* Better error handling regarding the `--chromosome-order` option in `order_gfa`.
* Fixed error in sort index creation when sorted GAF file is directed to standard output.

## v1.1.3 (30/05/2025)[](#v1-1-3-30-05-2025 "Link to this heading")

* Minor updates to documentation.
* Due to the CI/CD issues, this version just consists of minor documentation changes which were implemented in the previous version (v1.1.2). Due to PyPI restrictions regarding version names, the documentation are being released as a new version release.

## v1.1.2 (30/05/2025)[](#v1-1-2-30-05-2025 "Link to this heading")

* Better BGZF compatibility for all subcommands.
* Formatting updates with logger.
* [#34](https://github.com/marschall-lab/gaftools/issues/34): Added subcommand `gfa2rgfa` to convert GFA to rGFA format. Tested with HPRC Minigraph-Cactus Graph (v1.1).
* Updated documentation to include `gfa2rgfa` subcommand.
* Fixing [#38](https://github.com/marschall-lab/gaftools/issues/38) regarding GitHub CI/CD (that is why this version’s date has been changed to 30/05/2025).
* Updating python requirement to >=3.9 and adding SPDX expression for MIT license.

## v1.1.1 (23/01/2025)[](#v1-1-1-23-01-2025 "Link to this heading")

* Updated documentation to include conda installation instructions.
* Updated documentation to include preprint link and citation text.
* [#33](https://github.com/marschall-lab/gaftools/issues/33): Fixed error when viewing regions spanning multiple nodes.
* [#32](https://github.com/marschall-lab/gaftools/issues/32): Fixed error when trying to extract whole chromosomes.

## v1.1.0 (09/10/2024)[](#v1-1-0-09-10-2024 "Link to this heading")

* Adding `find_path` subcommand to take node path information as input and outputting the sequences.
* Updated `order_gfa` subcommand to output chromosome-wise graphs only with `--by-chrom` flag.
* Bug fix in `view` subcommand and minor changes to make it faster.
* Updated documentation.

## v1.0.0 (24/06/2024)[](#v1-0-0-24-06-2024 "Link to this heading")

* Initial commit.

[Previous](develop.html "Developing")

---

© Copyright 2022.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).