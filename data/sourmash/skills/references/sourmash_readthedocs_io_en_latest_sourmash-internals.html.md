# [A guide to the internal design and structure of sourmash](#id1)[¶](#a-guide-to-the-internal-design-and-structure-of-sourmash "Link to this heading")

Contents

* [A guide to the internal design and structure of sourmash](#a-guide-to-the-internal-design-and-structure-of-sourmash)

  + [Signatures and sketches](#signatures-and-sketches)

    - [Making sketches](#making-sketches)
    - [Compatibility checking](#compatibility-checking)
    - [Scaled (FracMinHash) sketches support similarity and containment](#scaled-fracminhash-sketches-support-similarity-and-containment)
    - [Num (MinHash) sketches support Jaccard similarity](#num-minhash-sketches-support-jaccard-similarity)
    - [Conversion between Scaled (FracMinHash) and Num (MinHash) signatures with `downsample`](#conversion-between-scaled-fracminhash-and-num-minhash-signatures-with-downsample)
    - [Operations you can do safely with FracMinHash sketches](#operations-you-can-do-safely-with-fracminhash-sketches)
  + [K-mer sizes](#k-mer-sizes)
  + [Molecule types - DNA, protein, Dayhoff, and hydrophobic-polar](#molecule-types-dna-protein-dayhoff-and-hydrophobic-polar)
  + [Manifests](#manifests)
  + [Index implementations](#index-implementations)

    - [In-memory storage and search.](#in-memory-storage-and-search)
    - [Zipfile collections](#zipfile-collections)
    - [Sequence Bloom Trees (SBTs)](#sequence-bloom-trees-sbts)
    - [Lowest common ancestor (LCA) databases](#lowest-common-ancestor-lca-databases)
    - [SqliteIndex](#sqliteindex)
    - [Standalone manifests](#standalone-manifests)
    - [Pathlists and `--from-file`](#pathlists-and-from-file)
    - [Extensions for outputting index classes](#extensions-for-outputting-index-classes)
  + [Speeding up `gather` and `search`](#speeding-up-gather-and-search)

    - [Running `search` many times on the same database](#running-search-many-times-on-the-same-database)
    - [Running `gather` once](#running-gather-once)
    - [Using `prefetch` and `gather` together](#using-prefetch-and-gather-together)
    - [Using a higher scaled value](#using-a-higher-scaled-value)
    - [Running `gather` many times - `multigather`](#running-gather-many-times-multigather)
    - [Much faster search and gather with branchwater](#much-faster-search-and-gather-with-branchwater)
  + [Taxonomy and assigning lineages](#taxonomy-and-assigning-lineages)

    - [Identifier handling](#identifier-handling)
    - [Taxonomies, or lineage spreadsheets](#taxonomies-or-lineage-spreadsheets)
    - [`LCA_SqliteDatabase` - a special case](#lca-sqlitedatabase-a-special-case)
  + [Picklists](#picklists)

    - [Differing internal behavior](#differing-internal-behavior)
    - [Taxonomy / lineage spreadsheets as picklists](#taxonomy-lineage-spreadsheets-as-picklists)
  + [Online and streaming; and adding to collections of sketches.](#online-and-streaming-and-adding-to-collections-of-sketches)

    - [Gather on multiple collections, and order of search and reporting](#gather-on-multiple-collections-and-order-of-search-and-reporting)
  + [Formats natively understood by sourmash](#formats-natively-understood-by-sourmash)

    - [Reading and writing gzipped CSV files](#reading-and-writing-gzipped-csv-files)

sourmash was created in 2015, and has been repeatedly reorganized,
refactored, and optimized to support ever larger databases, faster
queries, and new use cases. We’ve also regularly added new
functionality and features. So sourmash can be pretty complicated
internally, and our user-facing documentation only covers a fraction
of its potential!

This document is a brain dump intended for expert users and sourmash
developers who want to understand how, why, and when to use various
sourmash features. It is unlikely ever to be comprehensive, so the
information you are interested in may not yet exist in this document,
but we are always happy to add to it -
[just ask in an issue!](https://github.com/sourmash-bio/sourmash/issues)

## [Signatures and sketches](#id2)[¶](#signatures-and-sketches "Link to this heading")

sourmash operates on sketches. Each sketch is a collection of hashes,
which are in turn built from k-mers by applying a hash function
(currently always murmurhash) and a filtering function. Each sketch
is contained in a signature wrapper that contains some metadata.

Internally, sketches (class `MinHash`) contain the following information:

* a set of hashes;
* an optional abundance for each hash (when `track_abund` is True);
* a seed;
* a k-mer size;
* a molecule type;
* either a `num` (for MinHash) or a `scaled` value (for FracMinHash);

Signature objects (class `SourmashSignature`) contain a sketch (property `.minhash`) as well as additional information:

* an optional `name`
* an optional `filename`
* a license (currently must be CC0);
* an `md5sum(...)` method that returns a hash of the sketch.

For now, we tend to refer to signatures and sketches interchangeably,
because they are almost entirely 1:1 in the code base (but see [sourmash#616](https://github.com/sourmash-bio/sourmash/issues/616)).

The default signature interchange/serialization format is JSON, optionally
gzipped. This format is written and read by Rust code.

In general, a lot of effort in sourmash is spent managing collections of
signatures *before* actually doing comparisons with them; see manifests,
and `Index` objects, below.

### [Making sketches](#id3)[¶](#making-sketches "Link to this heading")

Sketches are produced by hashing k-mers with murmurhash and then
keeping either the lowest `num` hashes (for MinHashes sketches) or
keeping all hashes below `2**64 / scaled` (for FracMinHash sketches).
This has the effect of selecting approximately one hash for every
`scaled` k-mers - so, when sketching a set of 100,000 distinct k-mers,
a scaled value of 1,000 would yield approximately 100 hashes to be
retained in the sketch.

The default MinHash sketches use parameters so that they are
compatible with mash sketches.

See [utils/compute-dna-mh-another-way.py](https://github.com/sourmash-bio/sourmash/blob/latest/utils/compute-dna-mh-another-way.py) for details on how k-mers are
hashed.

Note that if hashes are produced some other way (with a different hash
function) or from some source other than DNA, sourmash can still work
with them; only `sourmash sketch` actually cares about DNA sequences,
everything else works with hashes.

### [Compatibility checking](#id4)[¶](#compatibility-checking "Link to this heading")

The point of the signatures and sketches is to enable certain kinds of
rapid comparisons - Jaccard similarity and number of overlapping k-mers,
specifically. However, these comparisons can only be done between
compatible sketches.

Here, “compatible” means -

* the same MurmurHash seed (default 42);
* the same k-mer size/ksize (see k-mer sizes, below);
* the same molecule type (see molecule types, below);
* the same `num` or `scaled` (although see [this downsampling discussion](api-example.html#downsampling-signatures), and the next two sections);

sourmash uses selectors (`Index.select(...)`) to select sketches with
compatible ksizes, molecule types, and sketch types.

### [Scaled (FracMinHash) sketches support similarity and containment](#id5)[¶](#scaled-fracminhash-sketches-support-similarity-and-containment "Link to this heading")

Per our discussion in [Irber et al., 2022](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2), FracMinHash sketches can always be compared
by downsampling to the max of the two scaled values. (This is not always
indexed collections of sketches, e.g. SBTs; see [sourmash#1799](https://github.com/sourmash-bio/sourmash/issues/1799).)

In practice, sourmash does all necessary downsampling dynamically, but
returns the original sketches. This means that (for example) you can
do a low-resolution/high-scaled search quickly by specifying a
high `scaled` value, and then use a higher resolution comparison with
the resulting matches for a more refined and accurate analysis (see
below, [Speeding up gather and search](#speeding-up-gather-and-search).)

### [Num (MinHash) sketches support Jaccard similarity](#id6)[¶](#num-minhash-sketches-support-jaccard-similarity "Link to this heading")

“Regular” MinHash (or “num MinHash”) sketches are implemented the same
way as in mash. However, they are less well supported in sourmash,
because they don’t offer the same opportunities for metagenome
analysis. (See also [sourmash#1354](https://github.com/sourmash-bio/sourmash/issues/1354).)

Num MinHash sketches can always be compared by downsampling to a
common `num` value. This may need to be done manually using `sourmash sig downsample`, however.

### [Conversion between Scaled (FracMinHash) and Num (MinHash) signatures with `downsample`](#id7)[¶](#conversion-between-scaled-fracminhash-and-num-minhash-signatures-with-downsample "Link to this heading")

As discussed in the previous sections, it is possible to adjust the `scaled` and `num` values to compare two FracMinHash signatures or two Num MinHash signatures. However, it is also possible to covert between the `scaled` and `num` signatures with the `sourmash sig downsample` command. For more details, review the [command line docs for `sig downsample`](https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-signature-downsample-decrease-the-size-of-a-signature).

### [Operations you can do safely with FracMinHash sketches](#id8)[¶](#operations-you-can-do-safely-with-fracminhash-sketches "Link to this heading")

As described in
[Lightweight compositional analysis of metagenomes with FracMinHash and minimum metagenome covers](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2),
FracMinHash sketches support a wide range of operations that mirror
actions taken on the underlying data set *without* revisiting the
underlying data. This allows users to build sketches once (requiring
the original data) and then do all sorts of manipulations on the
sketches, and know that the results of the sketch manipulations
represent what would happen if they did the same thing on the original
data. For example,

* set unions, intersections, and subtractions all perform the same
  when done on the sketches as when applied to the underling data.
  So, for example, you can sketch two files separately and merge
  the sketches (with `sig merge`), and get the same result as if you’d
  concatenated the files first and then sketched them.
* if you filter hashes on abundance with `sig filter`, you get the
  same result as if you filtered the data set on k-mer abundance and
  then sketched it.
* downsampling: you can sketch the original data set at a high resolution
  (e.g. scaled=100) and then downsample it later (to e.g. scaled=1000),
  and get the same result as if you’d sketched the data set at scaled=1000.

## [K-mer sizes](#id9)[¶](#k-mer-sizes "Link to this heading")

There is no explicit restriction on k-mer sizes built into sourmash.

For highly specific genome and metagenome comparisons, we typically
use k=21, k=31, or k=51. For a longer discussion, see [Assembly Free Analysis with K-mers](https://github.com/mblstamps/stamps2022/blob/main/kmers_and_sourmash/2022-stamps-assembly-free%20class.pdf) from STAMPS 2022
and a more general overview at [Using sourmash:a practical guide](using-sourmash-a-guide.html).

## [Molecule types - DNA, protein, Dayhoff, and hydrophobic-polar](#id10)[¶](#molecule-types-dna-protein-dayhoff-and-hydrophobic-polar "Link to this heading")

sourmash supports four different sequence encodings, which we refer to
as “molecule”: DNA (`--dna`), protein (`--protein`), [Dayhoff encoding](https://en.wikipedia.org/wiki/Margaret_Oakley_Dayhoff#Table_of_Dayhoff_encoding_of_amino_acids),
(`--dayhoff`), and [hydrophobic-polar](sourmash-sketch.html#protein-encodings) (`--hp`).

All FracMinHash sketches have exactly one molecule type, and can only
be compared to the same molecule type (and ksize).

DNA moltype sketches can be constructed from DNA input sequences using
`sourmash sketch dna`.

Protein, Dayhoff, and HP moltype sketches can be constructed from
protein input sequences using `sourmash sketch protein`, or from DNA
input sequences using `sourmash sketch translate`; `translate` will
translate in all six reading frames (see also
[orpheum](https://github.com/czbiohub/orpheum) from
[Botvinnik et al., 2021](https://www.biorxiv.org/content/10.1101/2021.07.09.450799v1)).
By default protein sketches will be created; dayhoff sketches can be
created by including `dayhoff` in the param string, e.g. `sourmash sketch protein -p dayhoff`, and hydrophobic-polar sketches can be
built with `hp` in the param string, e.g. `sourmash sketch protein -p hp`.

## [Manifests](#id11)[¶](#manifests "Link to this heading")

Manifests are catalogs of sketches: they include most of the information
about a sketch, except for the actual hashes. The idea of manifests is
that you can use them to identify *which* sketches you are interested
in before actually working with them (loading them, for example).

sourmash makes extensive use of signature manifests to support rapid
selection and lazy loading of signatures based on signature metadata
(name, ksize, moltype, etc.) See
[Blog post: Scaling sourmash to millions of samples](http://ivory.idyll.org/blog/2021-sourmash-scaling-to-millions.html)
for some of the motivation.

Manifests are an internal format that is not meant to be particularly
human readable, but the CSV format can be loaded into a spreadsheet
program if you’re curious :).

If a collection of signatures is in a zipfile (`.zip`) or SBT zipfile (`.sbt.zip`), manifests must
be named `SOURMASH-MANIFEST.csv`. They can also be stored directly on
disk in CSV/gzipped CSV, or in a sqlite database; see
`sourmash sig manifest`, `sourmash sig check`, and `sourmash sig collect`
for manifest creation, management, and export utilities.

Where signatures are stored individually in `Index` collections,
e.g. as separate files in a zipfile, manifests may be stored alongside
them; for other subclasses of `Index` such as the inverted indices,
manifests are generated dynamically by the class itself.

Currently (sourmash 4.x) manifests do not contain information about the
hash seed or sketch license. This will be fixed in the future - see [sourmash#1849](https://github.com/sourmash-bio/sourmash/issues/1849).

Manifests are very flexible and, especially when stored in a sqlite
database, can be extremely performant for organizing hundreds of
thousands to millions of sketches. Please see `StandaloneManifestIndex`
for a lazy-loading `Index` class that supports such massive-scale
organization.

## [Index implementations](#id12)[¶](#index-implementations "Link to this heading")

The `Index` class and its various subclasses (in `sourmash.index`) are
containers that provide an API for organizing, selecting, and
searching (potentially) large numbers of signatures.

`sourmash sig summarize` is a good way to determine what type of 