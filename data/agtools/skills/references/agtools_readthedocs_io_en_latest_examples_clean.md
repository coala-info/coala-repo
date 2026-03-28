[agtools](../..)

Home

* [Introduction](../..)

Getting Started

* [Installation](../../install/)
* [Quick Start](../../quickstart/)

Guides

* CLI Examples
  + [Obtaining stats](../stats/)
  + [Renaming elements](../rename/)
  + [Concatenating multiple graphs](../concat/)
  + [Filtering segments](../filter/)
  + Cleaning a graph file
  + [Get component of a segment](../component/)
  + [Format conversion](../formatconv/)
* [API Tutorial](../../tutorial/)
* [Assembler examples](../../assemblerexamples/)
* [More examples](../../moreexamples/)
* [Applications](../../exampleapplications/)

Reference

* [CLI Commands](../../cli/)
* [API Documentation](../../api/)
* [File Formats](../../fileformats/)

Support

* [FAQ](../../faq/)
* [Changelog](../../changelog/)

[agtools](../..)

* Guides
* CLI Examples
* Cleaning a graph file
* [Edit on GitHub](https://github.com/Vini2/agtools/edit/master/docs/examples/clean.md)

---

## Cleaning an assembly graph file

*agtools* can clean a GFA file given a FASTA file of the segments. It will remove any segments that are not found in the FASTA file, along with other elements that contain the segments. It will also add the segment sequences to the GFA file if they are missing, to be consistent with the [GFA specification](https://gfa-spec.github.io/GFA-spec/GFA1.html). You can use the `clean` subcommand provided through the command-line interface. Please refer to the [CLI reference](../../cli/) for further details on the `clean` subcommand.

Here is an [example GFA file](https://github.com/Vini2/agtools/tree/main/docs/data/clean_ex_graph.gfa). The lines starting with the `S` tags are missing the segment sequences.

```
# GFA file: 10 seqments (20 bp) and 1 short seqment (10 bp: seqX)
H   VN:Z:1.0
# Segments
S   seq1        DP:f:1.0
S   seq2        DP:f:1.0
S   seq3        DP:f:1.0
S   seq4        DP:f:1.0
S   seq5        DP:f:1.0
S   seq6        DP:f:1.0
S   seq7        DP:f:1.0
S   seq8        DP:f:1.0
S   seq9        DP:f:1.0
S   seq10       DP:f:1.0
S   seqX        DP:f:1.0
L   seqX    +   seq2    -   5M
L   seq4    +   seq5    +   10M
L   seq6    -   seq7    +   7M
L   seq9    +   seq10   -   5M
J   seq5    +   seqX    -   *
J   seq3    -   seq8    +   *
J   seq7    +   seq2    +   *
C   seq1    +   seqX    -   10M 5   0
C   seq2    +   seqX    +   10M 2   0
P   seqpath1    seq1+,seqX+,seq3-   20M,10M,20M
P   seqpath2    seq4+,seq5+,seq6+   20M,20M,20M
W   seqread1    0   *   <seq6<seqX>seq9
W   seqread2    0   *   <seq1>seq2<seq3
```

We have the following [segments file in FASTA format](https://github.com/Vini2/agtools/tree/main/docs/data/clean_ex_segments.fasta). It is missing `segX`.

```
>seq1
ATGCGTATGCGTATGCGTAA
>seq2
CGTACTGACTGACTGACTGA
>seq3
TGCATGCATGCATGCATGCA
>seq4
ACGTACGTACGTACGTACGT
>seq5
GTACGTACGTACGTACGTAC
>seq6
CGTACGTACGTACGTACGTA
>seq7
TACGTACGTACGTACGTACG
>seq8
ATCGATCGATCGATCGATCG
>seq9
GCGTGCGTGCGTGCGTGCGT
>seq10
TTGCTTGCTTGCTTGCTTGC
```

You can run the following command to clean up the GFA file.

```
agtools clean -g test_graph.gfa -f test_fasta.fasta -o ./
```

The cleaned graph would look like below. Note that the segment sequences are added back and `segX` is removed.

```
# GFA file: 10 seqments (20 bp) and 1 short seqment (10 bp: seqX)
H   VN:Z:1.0
# Segments
S   seq1    ATGCGTATGCGTATGCGTAA    DP:f:1.0
S   seq2    CGTACTGACTGACTGACTGA    DP:f:1.0
S   seq3    TGCATGCATGCATGCATGCA    DP:f:1.0
S   seq4    ACGTACGTACGTACGTACGT    DP:f:1.0
S   seq5    GTACGTACGTACGTACGTAC    DP:f:1.0
S   seq6    CGTACGTACGTACGTACGTA    DP:f:1.0
S   seq7    TACGTACGTACGTACGTACG    DP:f:1.0
S   seq8    ATCGATCGATCGATCGATCG    DP:f:1.0
S   seq9    GCGTGCGTGCGTGCGTGCGT    DP:f:1.0
S   seq10   TTGCTTGCTTGCTTGCTTGC    DP:f:1.0
L   seq4    +   seq5    +   10M
L   seq6    -   seq7    +   7M
L   seq9    +   seq10   -   5M
J   seq3    -   seq8    +   *
J   seq7    +   seq2    +   *
P   seqpath1    seq1+,seqX+,seq3-   20M,10M,20M
P   seqpath2    seq4+,seq5+,seq6+   20M,20M,20M
W   seqread2    0   *   <seq1>seq2<seq3
```

[Previous](../filter/ "Filtering segments")
[Next](../component/ "Get component of a segment")

---

Built with [MkDocs](https://www.mkdocs.org/) using a [theme](https://github.com/readthedocs/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).