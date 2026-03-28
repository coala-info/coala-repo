1. [Introduction](introduction.html)
2. [Installation](installation.html)
3. [Background](background.html)
4. [Purpose](purpose.html)
6. - Tools
   - [**1.** Closest](tools/closest.html)
   - [**2.** Complement](tools/complement.html)
   - [**3.** Extend](tools/extend.html)
   - [**4.** Get Fasta](tools/get_fasta.html)
   - [**5.** Intersect](tools/intersect.html)
   - [**6.** Merge](tools/merge.html)
   - [**7.** Random](tools/random.html)
   - [**8.** Sample](tools/sample.html)
   - [**9.** Sort](tools/sort.html)
   - [**10.** Subtract](tools/subtract.html)

* Light (default)
* Rust
* Coal
* Navy
* Ayu

# gia

# [Introduction](#introduction)

## [GIA: Genome Interval Arithmetic](#gia-genome-interval-arithmetic)

`gia` is a free and open-source command-line tool for highly efficient
and scalable set operations on genomic interval data.

It is inspired by the open source command-line tools [`bedtools`](https://bedtools.readthedocs.io/en/latest/)
and [`bedops`](https://bedops.readthedocs.io/en/latest/) and aims to be a drop-in
replacement to both.

`gia` is written in [rust](https://www.rust-lang.org/) and distributed via [`cargo`](https://rustup.rs/).
It is a command-line tool built on top of [`bedrs`](https://crates.io/crates/bedrs),
a separate and abstracted genomic interval library.

## [Issues and Contributions](#issues-and-contributions)

`gia` is a work-in-progress and under active development by [Noam Teyssier](https://noamteyssier.github.io/about/).

If you are interested in building more functionality or want to
get involved please don't hesitate to reach out!

**Please address all issues to future contributors.**

# [Installation](#installation)

`gia` is distributed using the rust package manager `cargo`.

```
cargo install gia
```

You can validate the installation by checking `gia`'s help menu:

```
gia --help
```

## [Installing `cargo`](#installing-cargo)

You can install `cargo` by following the instructions [here](https://rustup.rs/)

# [Background](#background)

## [Set Theory on the Genome](#set-theory-on-the-genome)

### [Genomic Intervals](#genomic-intervals)

The core piece of genome interval arithmetic is the `interval` object:

```
```
#![allow(unused)]
fn main() {
GenomicInterval {
    Chromosome,
    Start,
    End,
}
}
```
```

This is an abstract object with *at minimum* 3 attributes defining its **chromosome**,
**start**, and **end** positions on the genome.

### [Genomic Interval Sets](#genomic-interval-sets)

A collection of genomic intervals can be considered a [set](https://en.wikipedia.org/wiki/Set_%28mathematics%29)
which in brief is a collection of objects that match particular properties.

There is a branch of mathematics known as [set theory](https://en.wikipedia.org/wiki/Set_theory)
which describe a range of operations, such as the
[union](https://en.wikipedia.org/wiki/Union_%28set_theory%29),
[intersection](https://en.wikipedia.org/wiki/Intersection_%28set_theory%29),
[difference](https://en.wikipedia.org/wiki/Complement_%28set_theory%29#Relative_complement),
[complement](https://en.wikipedia.org/wiki/Complement_%28set_theory%29),
etc of those sets.

Some examples of these are shown below:

#### [Intersection](#intersection)

This generates all the intervals that are at the [intersection](https://en.wikipedia.org/wiki/Intersection_%28set_theory%29)
of two interval sets.

```
(a)   x---------y    x-----------y
(b)     i--j  i--------j    i--------j
========================================
        i--j  i-y    x-j    i----y
```

#### [Difference](#difference)

This generates all the intervals in `a` which are **not covered** by `b`.
This calculates the [difference / relative complement](https://en.wikipedia.org/wiki/Complement_%28set_theory%29#Relative_complement)
of a set.

```
(a)  x----------y   x------------y
(b)     i--j  i--------j    i--------j
========================================
     x--i  j--i        j----i
```

#### [Complement](#complement)

This generates all the intervals in `a` which are not covered by its span (`s`).
This is the [absolute complement](https://en.wikipedia.org/wiki/Complement_%28set_theory%29)
of the set.

```
(s)  s----------------------------s
========================================
(a)  x-----y   x------y    x------y
========================================
           y---x      y----x
```

### [Genomic Interval Arithmetic](#genomic-interval-arithmetic)

Genomic interval arithmetic revolves around performing set theoretical operations
in the context of genomic regions, and is useful for a wide range of purposes
in bioinformatics analyses.

# [Purpose - i.e. why gia?](#purpose---ie-why-gia)

`gia` was developed to split the difference between [`bedtools`](https://bedtools.readthedocs.io/en/latest/)
and [`bedops`](https://bedops.readthedocs.io/en/latest/) and be a tool that can
match both philosophies without sacrificing either efficiency or convenience.

That being said, the author of `gia` was greatly inspired by both tools and has
used them extensively for years.

`gia` would not exist if not for the work of their authors and maintainers as well
as their meticulous documentation.

## [Philosophies](#philosophies)

### [`bedtools` - utility over efficiency](#bedtools---utility-over-efficiency)

[`bedtools`](https://bedtools.readthedocs.io/en/latest/) is the original
genome interval toolkit and is the go-to for many people.

It prioritizes convenience and utility over computational efficiency, and
does that very well.

One of the major design choices for most of the tools in the toolkit is that
the genome interval sets are loaded into memory completely before processing
occurs.

This incurs a huge memory and computational overhead once genome interval sets
get larger and larger - which is increasingly the case for large high throughput
genomic datasets.

### [`bedops` - efficiency over utility](#bedops---efficiency-over-utility)

[`bedops`](https://bedops.readthedocs.io/en/latest/) came later from `bedtools`
and was built for computational efficiency.

Most of the methods within focus around pre-sorted data, and the computational
and memory efficiency comes from the fact that everything is built around [streams](https://en.wikipedia.org/wiki/Stream_%28computing%29)
(i.e. intervals are assumed sorted and only kept in memory for the abosolute minimum
amount of time required for the operation.)

This leads to highly efficient streaming operations with a constant memory overhead,
but provides some inconveniences, as all inputs must be presorted, and some functional
limitations, as most of the set operations implicitly merge intervals on input.

### [`gia` - both in a single tool](#gia---both-in-a-single-tool)

`gia` was built with the idea that both philosophies are useful for different
purposes and that the same operations and underlying implementations can be
shared.

By default, all tools are built with an **inplace** memory load, which allows
for the complete set of functionality available in `bedtools` with no expectation
that the dataset is *a priori* sorted or merged, but where relevant an argument
may be passed to allow for **streaming** operations, which perform highly performant
memory constant operations on pre-sorted inputs such as in `bedops`.

# [`[ gia closest ]`](#-gia-closest-)

## [Background](#background-1)

Similar to [intersect](tools/./intersect.html), `closest` searches for the closest
feature in `B` for each feature in `A`.

The `closest` feature is not necessarily non-overlapping and under certain
search constraints may not exist.

> **Note:** Chromosomal Distance
>
> There is no notion of interchromosomal distance, so if an interval is
> alone on an interval in `A`, then there will be no closest interval
> in `B`.

## [Usage](#usage)

See full arguments and options using:

```
gia closest --help
```

### [Default Behavior](#default-behavior)

```
(a)           x----------y
(b)   i-----j                 i-------j
=========================================
      i-----j
```

By default `closest` will return the single closest, potentially overlapping, feature in `B`
for each interval in `A`.

Ties will be given to the left-most interval with the closest start coordinate to the query.

```
gia closest -a <input.bed> -b <input.bed>
```

### [Closest Upstream](#closest-upstream)

```
(a)               x----------y
(b)   i-----j                 i-------j
=========================================
      i-----j
```

You can explicitly exclude all downstream intervals from the search, regardless
of their distance, with the upstream flag.

```
gia closest -a <input.bed> -b <input.bed> -u
```

### [Closest Downstream](#closest-downstream)

```
(a)          x----------y
(b)   i-----j                 i-------j
=========================================
                              i-------j
```

You can explicitly exclude all upstream intervals from the search, regardless
of their distance, with the downstream flag.

```
gia closest -a <input.bed> -b <input.bed> -d
```

# [`[ gia complement ]`](#-gia-complement-)

## [Background](#background-2)

Similar to [subtract](tools/./subtract.html), `complement` generates all the intervals
that are **not covered** by the input set.

This is equivalent to subtracting the interval set from its *span*, which is
an interval defined by the min and max interval of the set by chromosome.

## [Usage](#usage-1)

See full arguments and options using:

```
gia complement --help
```

### [Default Behavior](#default-behavior-1)

```
(span)        s---------------------------------s
==========================================================
(input)       x------y     x-----y    x---------y
==========================================================
(complement)         y-----x     y----x
```

By default `complement` will return all intervals that are uncovered by the
span of the incoming interval set.

The span of the interval set is calculated by chromosome.

```
gia complement -i <input.bed>
```

> **Note:** Internal vs Complete Complement
>
> The internal complement of a set necessarily excludes the the chromosomal
> start to the span start and the span end to the chromosomal end.
>
> All other potential intervals are included.

# [`[ gia extend ]`](#-gia-extend-)

## [Background](#background-3)

This subcommand is used to grow intervals from either of their terminals.
It can be used to either grow both sides, just the left, or just the right.
An optional `-g` flag can be given if the chromosome length is known, which will
be used to truncate growths to not overextend the chromosome length.

## [Usage](#usage-2)

See full arguments and options using:

```
gia extend --help
```

### [Extend Left](#extend-left)

```
(input)          x---------y    x------y
==============================================
(output)   x---------------y
                         x-------------y
```

This grows the intervals to the left but truncates to zero to avoid negatives.

```
gia extend -i <input.bed> -l 20
```

### [Extend Right](#extend-right)

```
(input)          x---------y    x------y
==============================================
(output)         x---------------y
                                x-------------y
```

This grows the intervals to the right but truncates to chromosome max
if a `.genome` file is provided.

```
gia extend -i <input.bed> -r 20
```

### [Extend Both (Equal)](#extend-both-equal)

```
(input)          x---------y    x------y
==============================================
(output)    x-------------------y
                            x---------------y
```

This grows the intervals to the left and right by an equal amount.
This will truncate to zero if a potential negative is encountered
and will truncate to the chromozome max if a `.genome` file is provided.

```
gia extend -i <input.bed> -b 20
```

### [Extend Both (Unequal)](#extend-both-unequal)

```
(input)          x---------y    x------y
==============================================
(output)    x---------------y
                            x-----------y
```

This grows the intervals to the left and right by an unequal amount.
The growth to the left is controlled by the `-l` flag and the growth
to the right is controlled by the `-r` flag separately.

This will truncate to zero if a potential negative is encountered
and will truncate to the chromozome max if a `.genome` file is provided.

```
gia extend -i <input.bed> -l 20 -r 5
```

# [`[ gia get-fasta ]`](#-gia-get-fasta-)

## [Background](#background-4)

This subcommand is used to extract sequences from intervals provided in an input BED file
from an indexed fasta.

The fasta is assumed indexed using `samtools faidx` and assumes the index is `</path/to.fasta>.fai`.

## [Usage](#usage-3)

See full arguments and options using:

```
gia get-fasta --help
```

### [Extract Sequences](#extract-sequences)

If the chromosome names are integers we can extract the sequences using the following command:

```
gia get-fasta -b <input.bed> -f <input.fa>
```

#### [Input Integer BED](#input-integer-bed)

```
1	20	30
2	30	40
```

#### [Input Integer Fasta](#input-integer-fasta)

```
>1
ACCCCTATCTATCACACTTCAGCGACTA
CGACTACGACCATCGACGATCAGCATCA
GCATCGACTACGACGATCAGCGACTACG
AGCTACGACGAGCG
>2
GGTAGTTAGTAGAGTTAGACTACGATCG
ATCGATCGATCGAGCGGCGCGCATCGAT
CGTAGCCGCGGCGTACGTAGCGCAGCAG
TCGTAGCTACGTAG
```

#### [Output Integer Fasta](#output-integer-fasta)

```
>1:20-30
AGCGACTACG
>2:30-40
CGATCGATCG
```

### [Extract Sequences with non-integer named bed and chromosome names](#extract-sequences-with-non-integer-named-bed-and-chromosome-names)

If the chromosome names are non-integers, `gia` can handle the conversion
and no extra flags are required.

```
gia get-fasta -b <input.bed> -f <input.fa>
```

#### [Input Non-Integer BED](#input-non-integer-bed)

```
chr1	20	30
chr2	30	40
```

#### [Input Non-Integer Fasta](#input-non-integer-fasta)

```
>chr1
ACCCCTATCTATCACACTTCAGCGACTA
CGACTACGACCATCGACGATCAGCATCA
GCATCGACTACGACGATCAGCGACTACG
AGCTACGACGAGCG
>chr2
GGTAGTTAGTAGAGTTAGACTACGATCG
ATCGATCGATCGAGCGGCGCGCATCGAT
CGTAGCCGCGGCGTACGTAGCGCAGCAG
TCGTAGCTACGTAG
```

#### [Output Non-Integer Fasta](#output-non-integer-fasta)

```
>chr1:20-30
AGCGACTACG
>chr2:30-40
CGATCGATCG
```

# [`[ gia intersect ]`](#-gia-intersect-)

## [Background](#background-5)

This subcommand calculates the genomic regions found at the intersection
of the first input (query) and the second input (target).

```
(query)     x-------------y        x----------y   x------y
(target)        i------j        i------j        i-----------j
=================================================================
                i------j           x---j          x------y
```

## [Usage](#usage-4)

See full arguments and options using:

```
gia intersect --help
```

### [Default Behavior](#default-behavior-2)

By default the intervals in the query and target are not assumed sorted or merged
and intersections are performed inplace.

```
gia intersect -a <query.b