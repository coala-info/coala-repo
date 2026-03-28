[Skip to main content](#main-content)

[ ]
[ ]

Open Navigation

Close Navigation

[![](/LexicMap/logo.svg)
LexicMap: efficient sequence alignment against millions of prokaryotic genomes​](https://bioinf.shenwei.me/LexicMap/)

[GitHub](https://github.com/shenwei356/LexicMap)

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

Toggle Dark/Light/Auto mode

[Back to homepage](https://bioinf.shenwei.me/LexicMap/)

Close Menu Bar

Open Menu Bar

## Navigation

* [ ]

  [Introduction](/LexicMap/introduction/)
* [ ]

  [Installation](/LexicMap/installation/)
* [ ]

  [Releases](/LexicMap/releases/)
* [ ]

  Tutorials
  + [ ]

    [Step 1. Building a database](/LexicMap/tutorials/index/)
  + [ ]

    [Step 2. Searching](/LexicMap/tutorials/search/)
  + [ ]

    More

    - [ ]

      [Indexing GTDB](/LexicMap/tutorials/misc/index-gtdb/)
    - [ ]

      [Indexing GenBank+RefSeq](/LexicMap/tutorials/misc/index-genbank/)
    - [ ]

      [Indexing AllTheBacteria](/LexicMap/tutorials/misc/index-allthebacteria/)
    - [ ]

      [Indexing GlobDB](/LexicMap/tutorials/misc/index-globdb/)
    - [ ]

      [Indexing UHGG](/LexicMap/tutorials/misc/index-uhgg/)
* [ ]

  Usage
  + [ ]

    [lexicmap](/LexicMap/usage/lexicmap/)
  + [ ]

    [index](/LexicMap/usage/index/)
  + [ ]

    [search](/LexicMap/usage/search/)
  + [ ]

    [utils](/LexicMap/usage/utils/)

    - [ ]

      [2blast](/LexicMap/usage/utils/2blast/)
    - [ ]

      [2sam](/LexicMap/usage/utils/2sam/)
    - [ ]

      [merge-search-results](/LexicMap/usage/utils/merge-search-results/)
    - [ ]

      [masks](/LexicMap/usage/utils/masks/)
    - [ ]

      [kmers](/LexicMap/usage/utils/kmers/)
    - [ ]

      [genomes](/LexicMap/usage/utils/genomes/)
    - [ ]

      [subseq](/LexicMap/usage/utils/subseq/)
    - [ ]

      [seed-pos](/LexicMap/usage/utils/seed-pos/)
    - [ ]

      [reindex-seeds](/LexicMap/usage/utils/reindex-seeds/)
    - [ ]

      [remerge](/LexicMap/usage/utils/remerge/)
    - [ ]

      [edit-genome-ids](/LexicMap/usage/utils/edit-genome-ids/)
* [ ]

  [FAQs](/LexicMap/faqs/)
* [ ]

  Notes
  + [ ]

    [Motivation](/LexicMap/notes/motivation/)

## More

* [ ]

  [More tools](https://github.com/shenwei356)

2. /
3. Introduction

# Introduction

[![Latest Version](https://img.shields.io/github/release/shenwei356/LexicMap.svg?style=flat?maxAge=86400)](https://github.com/shenwei356/LexicMap/releases)
[![Anaconda Cloud](https://anaconda.org/bioconda/lexicmap/badges/version.svg)](https://anaconda.org/bioconda/lexicmap)
[![Cross-platform](https://img.shields.io/badge/platform-any-ec2eb4.svg?style=flat)](http://bioinf.shenwei.me/LexicMap/installation/)
[![license](https://img.shields.io/github/license/shenwei356/taxonkit.svg?maxAge=2592000)](https://github.com/shenwei356/taxonkit/blob/master/LICENSE)

LexicMap is a **nucleotide sequence alignment** tool for efficiently querying **gene, plasmid, viral, or long-read sequences (>150 bp)** against up to **millions of prokaryotic genomes**.

Source code: <https://github.com/shenwei356/LexicMap>

For the latest features and improvements, please download the [pre-release binaries](https://github.com/shenwei356/LexicMap/issues/10).

Please cite:

> Wei Shen, John A. Lees, Zamin Iqbal.
> (2025) Efficient sequence alignment against millions of prokaryotic genomes with LexicMap.
> Nature Biotechnology. <https://doi.org/10.1038/s41587-025-02812-8>

## Table of contents

* [Features](#features)
* [Introduction](#introduction)
* [Quick start](#quick-start)
* [Performance](#performance)
* [Installation](#installation)
* [Algorithm overview](#algorithm-overview)
* [Citation](#citation)
* [Limitations](#limitations)
* [Terminology differences](#terminology-differences)
* [Support](#support)
* [License](#license)
* [Related projects](#related-projects)

## Features

1. **The accuracy of LexicMap is comparable with Blastn, MMseqs2, and Minimap2**. It
   * **performs base-level alignment**, with `qcovGnm`, `qcovHSP`, `pident`, `evalue` and `bitscore` returned,
     both in TSV and pairwise alignment format ([output format](https://bioinf.shenwei.me/LexicMap/tutorials/search/#output)).
     + provides a genome-wide query coverage metric (`qcovGnm`),
       which enables accurate interpretation of search results - particularly for [circular queries (such as plasmid, virus, and mtDNA)](https://bioinf.shenwei.me/LexicMap/tutorials/search/#searching-with-plasmids-or-other-longer-queries)
       against both complete and fragmented assemblies.
   * **returns all possible matches**, including multiple copies of a gene in a genome.
2. **The alignment is fast and memory-efficient, scalable to up to millions of prokaryotic genomes**.
3. LexicMap is **easy to [install](http://bioinf.shenwei.me/LexicMap/installation/),
   we provide [binary files](https://github.com/shenwei356/LexicMap/releases/)** with no dependencies for Linux, Windows, MacOS (x86 and arm CPUs).
4. LexicMap is **easy to use** (see [tutorials](http://bioinf.shenwei.me/LexicMap/tutorials/index/), [usages](http://bioinf.shenwei.me/LexicMap/usage/lexicmap/), and [FAQs](https://bioinf.shenwei.me/LexicMap/faqs/)).
   * [Database building](https://bioinf.shenwei.me/LexicMap/tutorials/index/) requires only a simple command, accepting input from files, a file list, or even a directory.
   * [Sequence searching](https://bioinf.shenwei.me/LexicMap/tutorials/search/) supports limiting search by TaxId(s), provides a progress bar.
   * [Several utility commands](https://bioinf.shenwei.me/LexicMap/usage/utils/) are available to resume unfinished indexing, explore the index data, merge search results, extract matched subsequences and more.

## Introduction

**Motivation**: Alignment against a database of genomes is a fundamental operation in bioinformatics, popularised by BLAST.
However, given the increasing rate at which genomes are sequenced, **existing tools struggle to scale**.

1. Existing full alignment tools face challenges of high memory consumption and slow speeds.
2. Alignment-free large-scale sequence searching tools only return the matched genomes,
   without the vital positional information for downstream analysis.
3. Mapping tools, or those utilizing compressed full-text indexes, return only the most similar matches.
4. Prefilter+Align strategies have the sensitivity issue in the prefiltering step.

**Methods**: ([algorithm overview](#algorithm-overview))

1. A [rewritten and improved version](https://github.com/shenwei356/lexichash) of the sequence sketching method [LexicHash](https://doi.org/10.1093/bioinformatics/btad652) is adopted to compute alignment seeds accurately and efficiently.
   * **We solved the [sketching deserts](https://www.biorxiv.org/content/10.1101/2024.01.25.577301v1) problem of LexicHash seeds to provide a [window guarantee](https://doi.org/10.1093/bioinformatics/btab790)**.
   * **We added the support of suffix matching of seeds, making seeds much more tolerant to mutations**. Any 31-bp seed with a common ≥15 bp prefix or suffix can be matched.
2. **A hierarchical index enables fast and low-memory variable-length seed matching** (prefix + suffix matching).
3. A pseudo alignment algorithm is used to find similar sequence regions from chaining results for alignment.
4. A [reimplemented](https://github.com/shenwei356/wfa) [Wavefront alignment algorithm](https://doi.org/10.1093/bioinformatics/btaa777) is used for base-level alignment.

**Results**:

1. LexicMap enables efficient indexing and searching of both RefSeq+GenBank and the [AllTheBacteria](https://www.biorxiv.org/content/10.1101/2024.03.08.584059v1) datasets (**2.3 and 1.9 million prokaryotic assemblies** respectively).
2. When searching in all **2,340,672 Genbank+Refseq prokaryotic genomes**, *Blastn is unable to run with this dataset on common servers as it requires >2000 GB RAM*. (see [performance](#performance)).

   **With LexicMap v0.7.0** (48 CPUs, indexes and queries queries in HDDs),

   | Query | Genome hits | Genome hits (high-similarity) | Genome hits (medium-similarity) | Genome hits (low-similarity) | Time | RAM |
   | --- | --- | --- | --- | --- | --- | --- |
   | A 1.3-kb marker gene | 41,718 | 11,746 | 115 | 29,857 | 3m:06s | 3.97 GB |
   | A 1.5-kb 16S rRNA | 1,955,167 | 245,884 | 501,691 | 1,207,592 | 32m:59s | 11.09 GB |
   | A 52.8-kb plasmid | 560,330 | 96 | 15,370 | 544,864 | 52m:22s | 14.48 GB |
   | 1003 AMR genes | 30,967,882 | 7,636,386 | 4,858,063 | 18,473,433 | 15h:52m:08s | 24.86 GB |

   Notes:

   1. Default paramters are used, for returning all possible matches.
   2. Only the best alignment of a genome is used to evaluate alignment similarity:
      * high-similarity: (a) qcov >= 90% (genes) or 70% (plasmids), (b) pident>=90%.
      * medium-similarity: (a) not belong to high-similarity, (b) qcov >= 50% (genes) or 30% (plasmids), (c) pident>=80%.
      * low-similarity: the remaining.
   3. **The search time varies in different computing environments and mainly depends on the I/O speed and the number of threads.**
   4. **The memory use is lower since v0.8.0.**

## Quick start

Building an index (see the tutorial of [building an index](http://bioinf.shenwei.me/LexicMap/tutorials/index/)).

```
# From a directory with multiple genome files
lexicmap index -I genomes/ -O db.lmi

# From a file list with one file per line
lexicmap index -S -X files.txt -O db.lmi
```

Querying (see the tutorial of [searching](http://bioinf.shenwei.me/LexicMap/tutorials/search/)).

```
# For short queries like genes or long reads, returning top N hits.
lexicmap search -d db.lmi query.fasta -o query.fasta.lexicmap.tsv \
    --align-min-match-pident 80 --min-qcov-per-hsp 70 --min-qcov-per-genome 70 \
    --top-n-genomes 10000

# For longer queries like plasmids, returning all hits.
lexicmap search -d db.lmi query.fasta -o query.fasta.lexicmap.tsv \
    --align-min-match-pident 70 --min-qcov-per-hsp 0  --min-qcov-per-genome 50 \
    --align-min-match-len 1000 \
    --top-n-genomes 0
```

Sample output (queries are a few Nanopore Q20 reads). See [output format details](http://bioinf.shenwei.me/LexicMap/tutorials/search/#output-format).

```
query                qlen   hits   sgenome           sseqid              qcovGnm   cls   hsp   qcovHSP   alenHSP   pident   gaps   qstart   qend   sstart    send      sstr   slen      evalue      bitscore
------------------   ----   ----   ---------------   -----------------   -------   ---   ---   -------   -------   ------   ----   ------   ----   -------   -------   ----   -------   ---------   --------
ERR5396170.1000004   190    1      GCF_000227465.1   NC_016047.1         84.211    1     1     84.211    165       89.091   5      14       173    4189372   4189536   -      4207222   1.93e-63    253
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    1     1     99.623    801       97.628   9      4        796    1138907   1139706   +      1887974   0.00e+00    1431
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    2     2     99.623    801       97.628   9      4        796    32607     33406     +      1887974   0.00e+00    1431
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    3     3     99.623    801       97.628   9      4        796    134468    135267    -      1887974   0.00e+00    1431
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    4     4     99.623    801       97.503   9      4        796    1768896   1769695   +      1887974   0.00e+00    1427
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    5     5     99.623    801       97.378   9      4        796    242012    242811    -      1887974   0.00e+00    1422
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    6     6     99.623    801       96.879   12     4        796    154380    155176    -      1887974   0.00e+00    1431
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    7     7     57.915    469       95.736   9      4        464    1280313   1280780   +      1887974   3.71e-236   829
ERR5396170.1000006   796    3      GCF_013394085.1   NZ_CP040910.1       99.623    8     8     42.839    341       99.120   0      456      796    1282477   1282817   +      1887974   6.91e-168   601
ERR5396170.1000006   796    3      GCF_009663775.1   NZ_RDBR01000008.1   99.623    1     1     99.623    801       93.383   9      4        796    21391     22190     -      52610     0.00e+00    1278
ERR5396170.1000006   796    3      GCF_003344625.1   NZ_QPKJ02000188.1   97.362    1     1     87.437    700       98.143   5      22       717    1         699       -      826       0.00e+00    1249
ERR5396170.1000006   796    3      GCF_003344625.1   NZ_QPKJ02000423.1   97.362    2     2     27.889    222       99.550   0      575      796    1         222       +      510       3.47e-106   396
ERR5396170.1000000   698    2      GCF_001457615.1   NZ_LN831024.1       92.264    1     1     92.264    656       96.341   13     53       696    4452083   4452737   +      6316979   0.00e+00    1169
ERR5396170.1000000   698    2      GCF_000949385.2   NZ_JYKO02000001.1   91.977    1     1     91.977    654       78.135   13     55       696    5638788   5639440   -      5912440   2.68e-176   630
ERR5396170.1000001   2505   3      GCF_000307025.1   NC_018584.1         67.066    1     1     67.066    1690      97.633   16     47       1726   1905511   1907194   -      2951805   0.00e+00    2985
ERR5396170.1000001   2505   3      GCF_900187225.1   NZ_LT906436.1       65.070    1     1     65.070    1641      93.723   20     95       1724   1869503   1871134   -      2864663   0.00e+00    2626
ERR5396170.1000001   2505   3      GCF_013394085.1   NZ_CP040910.1       30.858    1     1     30.858    780       97.692   9      1726     2498   183873    184650    +      1887974   0.00e+00    1384
ERR5396170.1000001   2505   3      GCF_013394085.1   NZ_CP040910.1       30.858    2     2     5.030     127       87.402   1      2233     2358   1236170   1236296   +      1887974   1.73e-37    167
ERR5396170.1000001   2505   3      GCF_013394085.1   NZ_CP040910.1       30.858    3     3     5.150     130       80.769   12     2233     2361   930381    930499    -      1887974   6.61e-43    185
ERR5396170.1000001   2505   3      GCF_013394085.1   NZ_CP040910.1       30.858    4     4     3.713     93        93.548   0      2257     2349   1104581   1104673   -      1887974   5.09e-30    141
```

CIGAR string, aligned query and subject sequences can be outputted as extra columns via the flag `-a/--all`.

Extracting matched sequences:

```
# Extracting similar sequences for a query gene.

# search matches with query coverage >= 90%
lexicmap search -d demo.lmi/ bench/b.gene_E_faecalis_SecY.fasta -o results.tsv \
    --min-qcov-per-hsp 90

# extract matched sequences as FASTA format
lex