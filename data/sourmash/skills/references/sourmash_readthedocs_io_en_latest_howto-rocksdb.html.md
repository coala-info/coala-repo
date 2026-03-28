# A quickstart guide to using RocksDB indexing[¶](#a-quickstart-guide-to-using-rocksdb-indexing "Link to this heading")

This quickstart shows how to index the GTDB species representatives database for fast search using `sourmash index` with the RocksDB index type.

NOTE: You’ll need sourmash v4.9.0 or later to run this tutorial.

## Download a database[¶](#download-a-database "Link to this heading")

Let’s start by downloading the GTDB rs226 “reps” database:

```
curl -JLO https://farm.cse.ucdavis.edu/~ctbrown/sourmash-db/gtdb-rs226/gtdb-rs226-reps.k31.sig.zip
```

This database is 3.7 GB and contains sketches of the 143k genomes from [GTDB rs226](https://gtdb.ecogenomic.org/stats/r226).

If you inspect the database with sourmash, you will see:

```
% sourmash sig summarize gtdb-rs226-reps.k31.sig.zip

...
is database? yes
has manifest? yes
num signatures: 143384
** examining manifest...
total hashes: 460383140
summary of sketches:
   143384 sketches with DNA, k=31, scaled=1000        460383140 total hashes
```

## Build an index[¶](#build-an-index "Link to this heading")

Run the `sourmash index` command to build a RocksDB index:

```
sourmash index -F rocksdb gtdb-rs226-reps.k31.rocksdb gtdb-rs226-reps.k31.sig.zip
```

This will take about 2 hours and 10 GB of RAM (and may be significantly faster with an SSD). The time and memory should scale approximately with the total number of hashes in the database (460m, per the `summarize` output above). The final size of the `gtdb-rs226-reps.k31.rocksdb` directory is 12 GB - again, this should roughly scale with the total number of hashes in the database.

RocksDB indexes can only contain a single type of sketch, so if the source database contains more than one ksize, moltype, or scaled, you’ll need to specify which one to index. The command above could be modified to include `-k 31 --scaled 1000 --dna` - but, in the case of this GTDB rs226 database, there is only one type of sketch, so sourmash automatically figures out what to index.

You can now run `sourmash sig summarize` on the index:

```
% sourmash sig summarize gtdb-rs226-reps.k31.rocksdb
...
** loading from 'gtdb-rs226-reps.k31.rocksdb'
path filetype: DiskRevIndex
location: gtdb-rs226-reps.k31.rocksdb
is database? yes
has manifest? yes
num signatures: 143384
** examining manifest...
total hashes: 460383140
summary of sketches:
   143384 sketches with DNA, k=31, scaled=1000        460383140 total hashes
```

RocksDB indexes support all of the sourmash signature collection commands - they are a full equivalent to any other sourmash collection.

## Search the RocksDB index[¶](#search-the-rocksdb-index "Link to this heading")

Let’s try searching the index with `sourmash search`.

First, grab a signature with `sig grep`. I’ve chosen this one at random.

```
sourmash sig grep GCA_036718335 gtdb-rs226-reps.k31.sig.zip -o query.sig
```

now search the RocksDB index with the query:

```
sourmash search query.sig gtdb-rs226-reps.k31.rocksdb
```

You should see:

```
977 matches above threshold 0.080; showing first 3:
similarity   match
----------   -----
100.0%       GCA_036718335.1 Coriobacteriaceae bacterium
 21.5%       GCF_040098165.1 Collinsella sp. CLA-JM-H32
 21.3%       GCA_031292915.1 Collinsella sp.
```

Searching the RocksDB index takes about 15 seconds and 400 MB; by contrast, searching the `.sig.zip` database takes 10 minutes and 4.1 GB.

## Additional notes on RocksDB indexes[¶](#additional-notes-on-rocksdb-indexes "Link to this heading")

RocksDB indexes in sourmash are an *inverted index*, which store a mapping from each k-mer hash to the set of sketches that contain that k-mer. This means that query performance will scale with the size of the query, rather than with the number of signatures in the database.

RocksDB indexes are incredibly scalable; the
[branchwater petabase scale search](https://branchwater.jgi.doe.gov/)
system uses them internally.

The
[branchwater plugin](https://github.com/sourmash-bio/sourmash_plugin_branchwater)
provides a somewhat more flexible indexing command, as well. RocksDB
databases produced by sourmash and the branchwater plugin are
fully interoperable.

[![Logo](_static/logo.png)

# sourmash](index.html)

Quickly search, compare, and analyze genomic and metagenomic data sets

### Navigation

* [Tutorials and examples](sidebar.html)
* [How-To Guides](sidebar.html#how-to-guides)
* [Frequently Asked Questions](sidebar.html#frequently-asked-questions)
* [How sourmash works under the hood](sidebar.html#how-sourmash-works-under-the-hood)
* [Reference material](sidebar.html#reference-material)
* [Developing and extending sourmash](sidebar.html#developing-and-extending-sourmash)
* [Full table of contents for all docs](sidebar.html#full-table-of-contents-for-all-docs)
* [Using sourmash from the command line](command-line.html)
* [Prepared databases](databases.html)
* [`sourmash` Python API examples](api-example.html)
* [How to cite sourmash](cite.html)

### Related Topics

* [Documentation overview](index.html)

### This Page

* [Show Source](_sources/howto-rocksdb.md.txt)

### Quick search

©2016-2023, C. Titus Brown, Luiz Irber, and N. Tessa Pierce-Ward.
|
Powered by [Sphinx 9.0.4](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/howto-rocksdb.md.txt)