1. [Introduction](../introduction.html)
2. [Installation](../installation.html)
3. [Background](../background.html)
4. [Purpose](../purpose.html)
6. - Tools
   - [**1.** Closest](../tools/closest.html)
   - [**2.** Complement](../tools/complement.html)
   - [**3.** Extend](../tools/extend.html)
   - [**4.** Get Fasta](../tools/get_fasta.html)
   - [**5.** Intersect](../tools/intersect.html)
   - [**6.** Merge](../tools/merge.html)
   - [**7.** Random](../tools/random.html)
   - [**8.** Sample](../tools/sample.html)
   - [**9.** Sort](../tools/sort.html)
   - [**10.** Subtract](../tools/subtract.html)

* Light (default)
* Rust
* Coal
* Navy
* Ayu

# gia

# [`[ gia complement ]`](#-gia-complement-)

## [Background](#background)

Similar to [subtract](./subtract.html), `complement` generates all the intervals
that are **not covered** by the input set.

This is equivalent to subtracting the interval set from its *span*, which is
an interval defined by the min and max interval of the set by chromosome.

## [Usage](#usage)

See full arguments and options using:

```
gia complement --help
```

### [Default Behavior](#default-behavior)

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