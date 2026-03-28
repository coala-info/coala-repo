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