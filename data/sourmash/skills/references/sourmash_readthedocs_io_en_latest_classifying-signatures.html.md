# [Classifying signatures: `search`, `gather`, and `lca` methods.](#id1)[¶](#classifying-signatures-search-gather-and-lca-methods "Link to this heading")

sourmash provides several different techniques for doing
classification and breakdown of genomic and metagenomic signatures.
These include taxonomic classification as well as decomposition of
metagenomic data into constitutent genomes.

Contents

* [Classifying signatures: `search`, `gather`, and `lca` methods.](#classifying-signatures-search-gather-and-lca-methods)

  + [Searching for similar samples with `search`.](#searching-for-similar-samples-with-search)
  + [Analyzing metagenomic samples with `gather`](#analyzing-metagenomic-samples-with-gather)
  + [Taxonomic profiling with sourmash](#taxonomic-profiling-with-sourmash)

    - [Using `sourmash tax` to do taxonomic analysis](#using-sourmash-tax-to-do-taxonomic-analysis)
    - [Using `sourmash lca` to do taxonomic analysis](#using-sourmash-lca-to-do-taxonomic-analysis)
    - [`sourmash tax` vs `sourmash lca`](#sourmash-tax-vs-sourmash-lca)
  + [Abundance weighting](#abundance-weighting)

    - [Projecting abundances in `sourmash gather`:](#projecting-abundances-in-sourmash-gather)
    - [Computing signature similarity with angular similarity.](#computing-signature-similarity-with-angular-similarity)
    - [Estimating ANI from FracMinHash comparisons.](#estimating-ani-from-fracminhash-comparisons)
  + [What commands should I use?](#what-commands-should-i-use)
  + [Appendix A: how `sourmash gather` works.](#appendix-a-how-sourmash-gather-works)
  + [Appendix B: sourmash gather and signatures with abundance information](#appendix-b-sourmash-gather-and-signatures-with-abundance-information)

    - [Data set prep](#data-set-prep)
    - [A first experiment: 1:1 abundance ratio.](#a-first-experiment-1-1-abundance-ratio)
    - [A second experiment: 10:1 abundance ratio.](#a-second-experiment-10-1-abundance-ratio)
  + [Appendix C: sourmash gather output examples](#appendix-c-sourmash-gather-output-examples)

    - [sourmash gather with a query containing abundance information](#sourmash-gather-with-a-query-containing-abundance-information)
    - [sourmash gather with the same query, *ignoring* abundances](#sourmash-gather-with-the-same-query-ignoring-abundances)
    - [Notes and comparisons](#notes-and-comparisons)
  + [Appendix D: Gather CSV output columns](#appendix-d-gather-csv-output-columns)
  + [Appendix E: Prefetch CSV output columns](#appendix-e-prefetch-csv-output-columns)

## [Searching for similar samples with `search`.](#id2)[¶](#searching-for-similar-samples-with-search "Link to this heading")

The `sourmash search` command is most useful when you are looking for
high similarity matches to other signatures; this is the most basic use
case for MinHash searching. The command takes a query signature and one
or more search signatures, and finds all the matches it can above a particular
threshold.

By default `search` will find matches with high [*Jaccard
similarity*](https://en.wikipedia.org/wiki/Jaccard_index), which will
consider all of the k-mers in the union of the two samples.
Practically, this means that you will only find matches if there is
both high overlap between the samples *and* relatively few k-mers that
are disjoint between the samples. This is effective for finding genomes
or transcriptomes that are similar but rarely works well for samples
of vastly different sizes.

One useful modification to `search` is to calculate containment with
`--containment` instead of the (default) similarity; this will find
matches where the query is contained within the subject, but the
subject may have many other k-mers in it. For example, if you are using
a plasmid as a query, you would use `--containment` to find genomes
that contained that plasmid. `gather` (discussed below) uses containment
analysis only.

See [the main sourmash tutorial](tutorial-basic.html#make-and-search-a-database-quickly)
for information on using `search` with and without `--containment`.

## [Analyzing metagenomic samples with `gather`](#id3)[¶](#analyzing-metagenomic-samples-with-gather "Link to this heading")

Neither search option (similarity or containment) is effective when
comparing or searching with metagenomes, which typically contain a
mixture of many different genomes. While you might use containment to
see if a query genome is present in one or more metagenomes, a common
question to ask is the reverse: **what genomes are in my metagenome?**
An alternative phrasing is this: **what reference genomes should I map
my metagenomic reads to?**

The main approach we provide in sourmash is `sourmash gather`. This
constructs the shortest possible list of reference genomes that cover
all of the known k-mers in a metagenome. We call this a *minimum
metagenome cover*.

From an algorithmic perspective, `gather` generates a minimum set
cover for a query metagenome, using the reference database you give
it. The minimum set cover is calculated using a greedy approximation
algorithm. Essentially, `gather` takes a query metagenome and
searches the database for the most highly contained genome; it then
subtracts that match from the metagenome, and repeats. At the end it
reports how much of the metagenome remains unknown. The
[basic sourmash tutorial](tutorial-basic.html#what-s-in-my-metagenome)
has some sample output from using gather with GenBank. See Appendix A
at the bottom of this page for more technical details.

The `gather` method is described in
[Lightweight compositional analysis of metagenomes with FracMinHash and minimum metagenome covers, Irber et al., 2022](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2).
Our benchmarking in that paper and also in
[Evaluation of taxonomic classification and profiling methods for long-read shotgun metagenomic sequencing datasets, Portik et al., 2022](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-022-05103-0)
suggests that it is a very sensitive and specific method for
analyzing metagenomes.

## [Taxonomic profiling with sourmash](#id4)[¶](#taxonomic-profiling-with-sourmash "Link to this heading")

sourmash supports two basic kinds of taxonomic profiling, under the
`lca` and `tax` modules. **As of 2023, we strongly recommend the
`tax`-based profiling approach.**

But first, let’s back up! By default, there is no structured taxonomic
information available in sourmash signatures or collections. What
this means is that you will have to provide your own mapping from a
match to some taxonomic hierarchy. Both the `lca` and `tax` modules
support identifier-based taxonomic mappings, in which identifiers
from the signature names can be linked to the standard seven NCBI/GTDB
taxonomy ranks - superkingdom, phylum, class, order, family, genus, and
species. These are typically provided in a spreadsheet *separately* from
the signature collection. The `tax` module also supports `lins` taxonomies,
for which we have a tutorial.

There are several advantages that this approach affords sourmash. One
is that sourmash is not tied closely to a specific taxonomy - you can
use either GTDB or NCBI as you wish. Another advantage is that you can
create your own custom taxonomic ranks and even use them with private
databases of genomes to classify your own metagenomes.

The main disadvantage of sourmash’s approach to taxonomy is that
sourmash doesn’t classify individual metagenomic reads to either a
genome or a taxon. (Note that we’re not sure this can be done robustly
in practice - neither short nor long reads typically contain enough
information to uniquely identify a single genome, especially if there
are many genomes from the same species present in the database.) If
you want to do this, we suggest running `sourmash gather` first, and
then mapping the reads to the matching genomes; then you can determine
which read maps to which genome. This is the approach taken by
[the genome-grist pipeline](https://dib-lab.github.io/genome-grist/).

### [Using `sourmash tax` to do taxonomic analysis](#id5)[¶](#using-sourmash-tax-to-do-taxonomic-analysis "Link to this heading")

We recommend using the `tax` module to do taxonomic classification of
genomes (with `tax genome`) and metagenomes (with `tax metagenome`).
The `tax` module commands operate downstream of `sourmash gather`,
which builds a minimum set cover of the query against the database -
intuitively speaking, this is the shortest possible list of genomes
that the query would map to. Then, both `tax genome` and `tax metagenome` take the CSV output of `sourmash gather` and produce
taxonomic profiles. (You can read more about minimum set covers
in
[Lightweight compositional analysis of metagenomes with FracMinHash and minimum metagenome covers, Irber et al., 2022](https://www.biorxiv.org/content/10.1101/2022.01.11.475838v2).)

The `tax metagenome` approach was benchmarked in
[Evaluation of taxonomic classification and profiling methods for long-read shotgun metagenomic sequencing datasets, Portik et al., 2022](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-022-05103-0)
and appears to be both very accurate and very sensitive, unless you’re
using Nanopore data or other data types that have a high sequencing
error rate.

It’s important to note that taxonomy based on multiple k-mers is very,
very specific and if you get a match, it’s pretty reliable. On the
converse, however, k-mer identification is very brittle with respect
to evolutionary divergence, so if you don’t get a match it may only
mean that the specific species or genus you’re searching for isn’t in
the database.

### [Using `sourmash lca` to do taxonomic analysis](#id6)[¶](#using-sourmash-lca-to-do-taxonomic-analysis "Link to this heading")

The `sourmash lca` module supports taxonomic classification using
single hashes, corresponding to single k-mers, in an approach inspired
by Kraken. Briefly, you first build an LCA database using `lca index`,
which takes a taxonomy spreadsheet and a collection of sketches. Then,
you can use `lca classify` to classify single-genome sketches or
`lca summarize` to classify metagenomes.

The `lca` approach is not published anywhere, but we’re happy to discuss
it in more detail; just [post to the issue tracker](https://github.com/sourmash-bio/sourmash/issues).

While we do not recommend the `lca` approach for general taxonomic
classification purposes (see below!), it remains useful for certain
kinds of diagnostic evaluation of sequences, so we are leaving the
functionality in sourmash.

### [`sourmash tax` vs `sourmash lca`](#id7)[¶](#sourmash-tax-vs-sourmash-lca "Link to this heading")

Why do we recommend using the `tax` module over `lca`? `sourmash lca`
was the first implementation in sourmash, and over the years we’ve
found that it is prone to false positives: that is, individual k-mers
are very sensitive but are often misassigned to higher taxonomic ranks
than they need to be, either because of contamination in the reference
database or because the taxonomy is not based directly on genome
similarity. Instead of using single k-mers, `sourmash gather` estimates
the best matching genome based on combinations of k-mers, which is much
more specific than the LCA approach; only then is a taxonomy assigned
using `sourmash tax`.

The bottom line is that in our experience, `sourmash tax` is as
sensitive as `lca`, and a lot more specific. Please let us know if you
discover differently!

## [Abundance weighting](#id8)[¶](#abundance-weighting "Link to this heading")

By default, sourmash tracks k-mer presence, *not* their abundance. The
proportions and fractions reported also ignore abundance. So, if
`sourmash gather` reports that a genome is 5% of a metagenome, it is
reporting Jaccard containment of that genome in the metagenome, and it
is ignoring information like the number of reads in the metagenome
that come from that genome. Similarly, when `sourmash compare`
compares genome or metagenome signatures, it’s reporting Jaccard
similarity *without* abundance.

However, it is possible to take into account abundance information by
computing signatures with `-p abund`. The abundance
information will be used if it’s present in the signature, and it can
be ignored with `--ignore-abundance` in any signature comparison.

There are two ways that abundance weighting can be used. One is in
containment queries for metagenomes, e.g. with `sourmash gather`, and the other is in comparisons of abundance-weighted signatures,
e.g. with `sourmash search` and `sourmash compare`. Below, we refer to the
first as “abundance projection” and the second as “angular similarity”.

### [Projecting abundances in `sourmash gather`:](#id9)[¶](#projecting-abundances-in-sourmash-gather "Link to this heading")

`sourmash gather` can report approximate abundance information for
containment queries against genome databases. This will give you
numbers that (approximately) match what you get from counting the coverage
of each contig by mapping reads.

If you create your query signature with `-p abund`,
`sourmash gather` will use the resulting k-mer multiplicity information
to calculate an abundance-weighted result, weighting
each hash value match by the multiplicity of the hash value in
the query signature. You can turn off this behavior with
`--ignore-abundance`. The abundance is reported as column `avg_abund`
in the console output, and columns `average_abund`, `median_abund`, and
`std_abund` in the CSV output.

For example, if you have a metagenome composed of two equal sized genomes
A and B, with A present at 10 times the abundance of B, `gather` on
abundance-weighted signatures will report that approximately 91% of the
metagenome is A and approximately 9% is B. (If you use `--ignore-abundance`,
then `gather` will report approximately 50:50, since the genomes are equal
sized.)

You can also get count-like information from the CSV output of `sourmash gather`; the column `median_abund` contains the median abundance of the k-mers
in the match to the given genome.

Please see Appendix B, below, for some actual numbers and output.

**Buyer beware:** There are substantial challenges in doing this kind
of analysis on real metagenomic samples, relating to genome representation
and strain overlap; see [this issue](https://github.com/sourmash-bio/sourmash/issues/461) for a discussion.

### [Computing signature similarity with angular similarity.](#id10)[¶](#computing-signature-similarity-with-angular-similarity "Link to this heading")

If signatures that have abundance information are compared with
`sourmash search` or `sourmash compare`, the default comparison is
done with
[angular similarity](https://en.wikipedia.org/wiki/Cosine_similarity#Angular_distance_and_similarity). This
is a distance metric based on cosine similarity, and it is suitable
for use in clustering.

For more information on the value of this kind of comparison for
metagenomics, please see the simka paper,
[Multipl