# [Using sourmash from the command line](#id4)[¶](#using-sourmash-from-the-command-line "Link to this heading")

Contents

* [Using sourmash from the command line](#using-sourmash-from-the-command-line)

  + [An example](#an-example)
  + [The `sourmash` command and its subcommands](#the-sourmash-command-and-its-subcommands)

    - [`sourmash sketch` - make sourmash signatures from sequence data](#sourmash-sketch-make-sourmash-signatures-from-sequence-data)
    - [`sourmash compute` - make sourmash signatures from sequence data](#sourmash-compute-make-sourmash-signatures-from-sequence-data)
    - [`sourmash compare` - compare many signatures](#sourmash-compare-compare-many-signatures)
    - [`sourmash plot` - cluster and visualize comparisons of many signatures](#sourmash-plot-cluster-and-visualize-comparisons-of-many-signatures)
    - [`sourmash search` - search for signatures in collections or databases](#sourmash-search-search-for-signatures-in-collections-or-databases)
    - [`sourmash gather` - find metagenome members](#sourmash-gather-find-metagenome-members)
    - [`sourmash index` - build an index of signatures](#sourmash-index-build-an-index-of-signatures)
    - [`sourmash prefetch` - select subsets of very large databases for more processing](#sourmash-prefetch-select-subsets-of-very-large-databases-for-more-processing)
    - [`sourmash multigather` - do gather with many queries](#sourmash-multigather-do-gather-with-many-queries)
  + [`sourmash tax` subcommands for integrating taxonomic information into gather results](#sourmash-tax-subcommands-for-integrating-taxonomic-information-into-gather-results)

    - [`sourmash tax metagenome` - summarize metagenome content from `gather` results](#sourmash-tax-metagenome-summarize-metagenome-content-from-gather-results)
    - [`sourmash tax genome` - classify a genome using `gather` results](#sourmash-tax-genome-classify-a-genome-using-gather-results)
    - [`sourmash tax annotate` - annotates gather output with taxonomy](#sourmash-tax-annotate-annotates-gather-output-with-taxonomy)
    - [`sourmash tax prepare` - prepare and/or combine taxonomy files](#sourmash-tax-prepare-prepare-and-or-combine-taxonomy-files)
    - [`sourmash tax grep` - subset taxonomies and create picklists based on taxonomy string matches](#sourmash-tax-grep-subset-taxonomies-and-create-picklists-based-on-taxonomy-string-matches)
    - [`sourmash tax summarize` - print summary information for lineage spreadsheets or taxonomy databases](#sourmash-tax-summarize-print-summary-information-for-lineage-spreadsheets-or-taxonomy-databases)
  + [`sourmash lca` subcommands for in-memory taxonomy integration](#sourmash-lca-subcommands-for-in-memory-taxonomy-integration)

    - [`sourmash lca classify` - classify a genome using an LCA database](#sourmash-lca-classify-classify-a-genome-using-an-lca-database)
    - [`sourmash lca summarize` - summarize a metagenome’s contents using an LCA database](#sourmash-lca-summarize-summarize-a-metagenome-s-contents-using-an-lca-database)
    - [`sourmash lca index` - build an LCA database](#sourmash-lca-index-build-an-lca-database)
    - [`sourmash lca rankinfo` - examine an LCA database](#sourmash-lca-rankinfo-examine-an-lca-database)
    - [`sourmash lca compare_csv` - compare taxonomic spreadsheets](#sourmash-lca-compare-csv-compare-taxonomic-spreadsheets)
  + [`sourmash signature` subcommands for signature manipulation](#sourmash-signature-subcommands-for-signature-manipulation)

    - [`sourmash signature cat` - combine signatures into one file](#sourmash-signature-cat-combine-signatures-into-one-file)
    - [`sourmash signature describe` - display detailed information about signatures](#sourmash-signature-describe-display-detailed-information-about-signatures)
    - [`sourmash signature fileinfo` - display a summary of the contents of a sourmash collection](#sourmash-signature-fileinfo-display-a-summary-of-the-contents-of-a-sourmash-collection)
    - [`sourmash signature grep` - extract matching signatures using pattern matching](#sourmash-signature-grep-extract-matching-signatures-using-pattern-matching)
    - [`sourmash signature split` - split signatures into individual files](#sourmash-signature-split-split-signatures-into-individual-files)
    - [`sourmash signature merge` - merge two or more signatures into one](#sourmash-signature-merge-merge-two-or-more-signatures-into-one)
    - [`sourmash signature rename` - rename a signature](#sourmash-signature-rename-rename-a-signature)
    - [`sourmash signature subtract` - subtract other signatures from a signature](#sourmash-signature-subtract-subtract-other-signatures-from-a-signature)
    - [`sourmash signature intersect` - intersect two (or more) signatures](#sourmash-signature-intersect-intersect-two-or-more-signatures)
    - [`sourmash signature inflate` - transfer abundances from one signature to others](#sourmash-signature-inflate-transfer-abundances-from-one-signature-to-others)
    - [`sourmash signature downsample` - decrease the size of a signature](#sourmash-signature-downsample-decrease-the-size-of-a-signature)
    - [`sourmash signature extract` - extract signatures from a collection](#sourmash-signature-extract-extract-signatures-from-a-collection)
    - [`sourmash signature flatten` - remove abundance information from signatures](#sourmash-signature-flatten-remove-abundance-information-from-signatures)
    - [`sourmash signature filter` - remove hashes based on abundance](#sourmash-signature-filter-remove-hashes-based-on-abundance)
    - [`sourmash signature import` - import signatures from mash.](#sourmash-signature-import-import-signatures-from-mash)
    - [`sourmash signature export` - export signatures to mash.](#sourmash-signature-export-export-signatures-to-mash)
    - [`sourmash signature overlap` - detailed comparison of two signatures’ overlap](#sourmash-signature-overlap-detailed-comparison-of-two-signatures-overlap)
    - [`sourmash signature kmers` - extract k-mers and/or sequences that match to signatures](#sourmash-signature-kmers-extract-k-mers-and-or-sequences-that-match-to-signatures)
    - [`sourmash signature manifest` - output a manifest for a file](#sourmash-signature-manifest-output-a-manifest-for-a-file)
    - [`sourmash signature check` - compare picklists and manifests](#sourmash-signature-check-compare-picklists-and-manifests)
    - [`sourmash signature collect` - collect manifests across databases](#sourmash-signature-collect-collect-manifests-across-databases)
  + [Advanced command-line usage](#advanced-command-line-usage)

    - [Loading signatures and databases](#loading-signatures-and-databases)
    - [Selecting signatures](#selecting-signatures)
    - [Using picklists to subset large collections of signatures](#using-picklists-to-subset-large-collections-of-signatures)
    - [Storing (and searching) signatures](#storing-and-searching-signatures)
    - [Zip files](#zip-files)
    - [Choosing signature output formats](#choosing-signature-output-formats)
    - [Loading many signatures](#loading-many-signatures)
    - [Combining search databases on the command line](#combining-search-databases-on-the-command-line)
    - [Using stdin](#using-stdin)
    - [Using standalone manifests to explicitly refer to collections of files](#using-standalone-manifests-to-explicitly-refer-to-collections-of-files)
  + [Using sourmash plugins](#using-sourmash-plugins)

    - [The `branchwater` plugin - multithreaded and optimized sourmash operations](#the-branchwater-plugin-multithreaded-and-optimized-sourmash-operations)
    - [The `betterplot` plugin - improved plotting and visualization](#the-betterplot-plugin-improved-plotting-and-visualization)
    - [The `directsketch` plugin - streaming download and sketch](#the-directsketch-plugin-streaming-download-and-sketch)

From the command line, sourmash can be used to create
[FracMinHash sketches](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2) from DNA and protein sequences, compare them
to each other, and plot the results; these sketches are saved into
“signature files”. These signatures allow you to estimate sequence
similarity and containment quickly and accurately in large
collections, among other capabilities.

sourmash also provides a suite of metagenome functionality. This
includes genome search in metagenomes, metagenome decomposition into a
list of genomes from a database, and taxonomic classification
functionality.

The sourmash team provides a collection of prepared
[databases](databases.html) for GTDB and GenBank. There is an
increasingly large ecosystem of plugins that support
[high-performance search and sketching](https://github.com/sourmash-bio/sourmash_plugin_branchwater),
[more advanced plotting capabilities](https://github.com/sourmash-bio/sourmash_plugin_betterplot/),
and
[streaming sketching of large collections of genomes](https://github.com/sourmash-bio/sourmash_plugin_directsketch).

Please see the [mash software](http://mash.readthedocs.io/en/latest/) and the
[mash paper (Ondov et al., 2016)](http://biorxiv.org/content/early/2015/10/26/029827) for background information on
how and why MinHash sketches work. The [FracMinHash preprint (Irber et al,
2022)](https://www.biorxiv.org/content/10.1101/2022.01.11.475838) describes
FracMinHash sketches as well as the metagenome-focused features of sourmash.

sourmash uses a subcommand syntax, so all commands start with
`sourmash` followed by a subcommand specifying the action to be
taken.

## [An example](#id5)[¶](#an-example "Link to this heading")

Download three bacterial genomes from NCBI:

```
curl -L -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/017/325/GCF_000017325.1_ASM1732v1/GCF_000017325.1_ASM1732v1_genomic.fna.gz
curl -L -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/021/665/GCF_000021665.1_ASM2166v1/GCF_000021665.1_ASM2166v1_genomic.fna.gz
curl -L -O https://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/Escherichia_coli/reference/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
```

Compute sourmash signatures for them all:

```
sourmash sketch dna -p k=31 *.fna.gz
```

This will produce three `.sig` files containing MinHash signatures using a k-mer size of 31.

Next, compare all the signatures to each other:

```
sourmash compare *.sig -o cmp.dist
```

Finally, plot a dendrogram:

```
sourmash plot cmp.dist --labels
```

This will output three files, `cmp.dist.dendro.png`,
`cmp.dist.matrix.png`, and `cmp.dist.hist.png`, containing a
clustering & dendrogram of the sequences, a similarity matrix and
heatmap, and a histogram of the pairwise similarities between the three
genomes.

Matrix:

![Matrix](_images/cmp.matrix.png)

Here, the two genomes that cluster together are strains of the same
species, while the third is from a completely different genus.

## [The `sourmash` command and its subcommands](#id6)[¶](#the-sourmash-command-and-its-subcommands "Link to this heading")

To get a list of subcommands, run `sourmash` without any arguments.

Please use the command line option `--help` to get more detailed usage
information for each command.

All signature saving commands can save to a variety of formats (we
suggest `.zip` files) and all signature loading commands can load
signatures from any of these formats.

There are seven main subcommands: `sketch`, `compare`, `plot`,
`search`, `gather`, `index`, and `prefetch`. See
[the tutorial](tutorials.html) for a walkthrough of these commands.

* `sketch` creates signatures.
* `compare` compares signatures and builds a similarity matrix.
* `plot` plots similarity matrices created by `compare`.
* `search` finds matches to a query signature in a collection of signatures.
* `gather` finds the best reference genomes for a metagenome, using the provided collection of signatures.
* `index` builds fast indexes for searching many (thousands to millions) of signatures.
* `prefetch` selects signatures of interest from a very large collection of signatures, for later processing.

There are also a number of commands that work with taxonomic
information; these are grouped under the `sourmash tax` and
`sourmash lca` subcommands.

`sourmash tax` commands:

* `tax metagenome` - summarize metagenome gather results at each taxonomic rank.
* `tax genome` - summarize single-genome gather results and report most likely classification.
* `tax annotate` - annotate gather results with lineage information (no summarization or classification).
* `tax prepare` - prepare and/or combine taxonomy files.
* `tax grep` - subset taxonomies and create picklists based on taxonomy string matches.
* `tax summarize` - print summary information (counts of lineages) for a taxonomy lineages file or database.

`sourmash lca` commands:

Attention

We do not recommend using the `lca` subcommands for taxonomic analysis
any more; please use `sourmash tax` instead. See
[taxonomic profiling with sourmash](classifying-signatures.html#taxonomic-profiling-with-sourmash)
for more information.

* `lca classify` classifies many signatures against an LCA database.
* `lca summarize` summarizes the content of metagenomes using an LCA database.
* `lca index` creates a database for use with LCA subcommands.
* `lca rankinfo` summarizes the content of a database.
* `lca compare_csv` compares lineage spreadsheets, e.g. those output by `lca classify`.

See [the LCA tutorial](tutorials-lca.html) for a
walkthrough of some of these commands.

Finally, there are a number of utility and information commands:

* `info` shows version and software information.
* `sbt_combine` combines multiple SBT indexes.
* `categorize` is an experimental command to categorize many signatures.
* `watch` is an experimental command to classify a stream of sequencing data.
* `multigather` is an experimental command to run multiple gathers against the same collection of databases.

Please use the command line option `--help` to get more detailed usage
information for each command.

### [`sourmash sketch` - make sourmash signatures from sequence data](#id7)[¶](#sourmash-sketch-make-sourmash-signatures-from-sequence-data "Link to this heading")

Most of the commands in sourmash work with **signatures**, which contain information about genomic or proteomic sequences. Each signature contains one or more **sketches**, which are compressed versions of these sequences. Using sourmash, you can search, compare, and analyze these sequences in various ways.

To create a signature with one or more sketches, you use the `sourmash sketch` command. There are four main commands:

```
sourmash sketch dna
sourmash sketch protein
sourmash sketch translate
sourmash sketch fromfile
```

The `sketch dna` command reads in **DNA sequences** and outputs **DNA sketches**.

The `sketch protein` command reads in **protein sequences** and outputs **protein sketches**.

The `sketch translate` command reads in **DNA sequences**, translates them in all six frames, and outputs **protein sketches**