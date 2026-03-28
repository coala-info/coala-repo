[Autometa](index.html)

latest

* [Getting Started](getting-started.html)
* [🍏 Nextflow Workflow 🍏](nextflow-workflow.html)
* [🐚 Bash Workflow 🐚](bash-workflow.html)
* [📓 Bash Step by Step Tutorial 📓](bash-step-by-step-tutorial.html)
* Databases
  + [Markers](#markers)
  + [NCBI](#ncbi)
  + [Genome Taxonomy Database (GTDB)](#genome-taxonomy-database-gtdb)
* [Examining Results](examining-results.html)
* [Benchmarking](benchmarking.html)
* [Installation](installation.html)
* [Autometa Python API](autometa-python-api.html)
* [Usage](scripts/usage.html)
* [How to contribute](how-to-contribute.html)
* [Autometa modules](Autometa_modules/modules.html)
* [Legacy Autometa](legacy-autometa.html)
* [License](license.html)

[Autometa](index.html)

* Databases
* [Edit on GitHub](https://github.com/KwanLab/Autometa/blob/main/docs/source/databases.rst)

---

# Databases[](#databases "Permalink to this heading")

If you are running Autometa for the first time you will need to download and format a few databases.
You may do this manually or using a few Autometa helper scripts. If you would like to use Autometa’s
scripts for this, you will first need to install Autometa (See [Installation](nextflow-workflow.html#installation)).

The following sections use a pair of commands to configure autometa such that the database is updated
according to its respective path.

## Markers[](#markers "Permalink to this heading")

```
# Point Autometa to where you would like your markers database directory
autometa-config \
    --section databases --option markers \
    --value <path/to/your/markers/database/directory>

# Update your markers database directory
autometa-update-databases --update-markers
```

Links to these markers files and their associated cutoff values are below:

* bacteria single-copy-markers - [link](https://raw.githubusercontent.com/KwanLab/Autometa/main/autometa/databases/markers/bacteria.single_copy.hmm)
* bacteria single-copy-markers cutoffs - [link](https://raw.githubusercontent.com/KwanLab/Autometa/main/autometa/databases/markers/bacteria.single_copy.cutoffs)
* archaea single-copy-markers - [link](https://raw.githubusercontent.com/KwanLab/Autometa/main/autometa/databases/markers/archaea.single_copy.hmm)
* archaea single-copy-markers cutoffs - [link](https://raw.githubusercontent.com/KwanLab/Autometa/main/autometa/databases/markers/archaea.single_copy.cutoffs)

## NCBI[](#ncbi "Permalink to this heading")

```
# First configure where you want to download the NCBI databases
autometa-config \
    --section databases --option ncbi \
    --value <path/to/your/ncbi/database/directory>

# Now download and format the NCBI databases
autometa-update-databases --update-ncbi
```

Note

You can check the config paths using `autometa-config --print`.

See `autometa-update-databases -h` and `autometa-config -h` for full list of options.

The previous command will download the following NCBI databases:

* Non-redundant nr database
  :   + [ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz](https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/nr.gz)
* prot.accession2taxid.gz
  :   + [ftp.ncbi.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz](https://ftp.ncbi.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz)
* nodes.dmp, names.dmp, merged.dmp and delnodes.dmp - Found within
  :   + <ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump.tar.gz>

After these files are downloaded, the `taxdump.tar.gz` tarball’s files are extracted and the non-redundant protein database (`nr.gz`)
is formatted as a diamond database (i.e. `nr.dmnd`). This will significantly speed-up the `diamond blastp` searches.

## Genome Taxonomy Database (GTDB)[](#genome-taxonomy-database-gtdb "Permalink to this heading")

If you would like to incorporate the benefits of using the Genome Taxonomy Database,
you can either run the following script or manually download the respective databases.

```
# First configure where you want to download the GTDB databases
autometa-config \
    --section databases --option gtdb \
    --value <path/to/your/gtdb/database/directory>

# To use a specific GTDB release
autometa-config \
    --section gtdb --option release \
    --value latest
    # Or --value r207 or --value r202, etc.

# Download and format the configured GTDB databases release
autometa-update-databases --update-gtdb
```

Note

You can check the default config paths using `autometa-config --print`.

See `autometa-update-databases -h` and `autometa-config -h` for full list of options.

The previous command will download the following GTDB databases and format the gtdb\_proteins\_aa\_reps.tar.gz to generate gtdb.dmnd to be used by Autometa:

* Amino acid sequences of representative genome
  :   + [gtdb\_proteins\_aa\_reps.tar.gz](https://data.gtdb.ecogenomic.org/releases/latest/genomic_files_reps/gtdb_proteins_aa_reps.tar.gz)
* gtdb-taxdump.tar.gz from [shenwei356/gtdb-taxdump](https://github.com/shenwei356/gtdb-taxdump/releases)
  :   + [gtdb-taxdump.tar.gz](https://github.com/shenwei356/gtdb-taxdump/releases/latest/download/gtdb-taxdump.tar.gz)

Once unzipped gtdb-taxdump.tar.gz will have the taxdump files of all the respective GTDB releases.
Make sure that the release you use is in line with the gtdb\_proteins\_aa\_reps.tar.gz release version.
It’s better to always use the latest version.

All the taxonomy files for a specific taxonomy database should be in a single directory.
You can now copy the taxdump files of the desired release version in the sample directory as gtdb.dmnd

Alternatively if you have manually downloaded gtdb\_proteins\_aa\_reps.tar.gz and gtdb-taxdump.tar.gz you can run the
following command to format the gtdb\_proteins\_aa\_reps.tar.gz to generate gtdb.dmnd and make it ready for Autometa.

```
autometa-setup-gtdb --reps-faa <path/to/gtdb_proteins_aa_reps.tar.gz> --dbdir <path/to/output_directory> --cpus 20
```

Note

Again Make sure that the formatted gtdb\_proteins\_aa\_reps.tar.gz database and gtdb taxdump files are in the same directory.

[Previous](bash-step-by-step-tutorial.html "📓 Bash Step by Step Tutorial 📓")
[Next](examining-results.html "Examining Results")

---

© Copyright 2016 - 2024, Ian J. Miller, Evan R. Rees, Izaak Miller, Shaurya Chanana, Siddharth Uppal, Kyle Wolf, Jason C. Kwan.
Revision `0d9028cf`.
Last updated on Jun 14, 2024.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).