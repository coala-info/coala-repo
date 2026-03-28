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

# [`[ gia subtract ]`](#-gia-subtract-)

## [Background](#background)

This subcommand calculates the genomic regions found within the
first input (query) while excluding regions in the second (target).

```
(query)     x-------------y        x----------y   x------y
(target)        i------j        i------j        i-----------j
=================================================================
            x---i      j--y     i--x   j------y i-x      y--j
```

## [Usage](#usage)

See full arguments and options using:

```
gia subtract --help
```

### [Default Behavior (Merging)](#default-behavior-merging)

By default the intervals in the query and target are merged before
subtraction to calculate the difference across the subspans.

```
(query)            x-------y
                       x-------y
                          x----------y

(target)               i----j
                            i------j
=============================================
(merged_q)        x------------------y
(merged_t)             i-----------j
=============================================
(subtraction)     x----i           j-y
```

```
gia subtract -a <query.bed> -b <target.bed>
```

### [Unmerged Subtraction](#unmerged-subtraction)

If you would like to keep the intervals separate on merging then
you can supply the `-u` flag to keep the intervals separate.

```
(query)            x---------y
                       x-------y
                          x----------y

(target)               i---j
                           i-------j
=============================================
(subtraction)     x----i
                           j-y
                                   j-y
```

This is useful in cases where the intervals are separate classes
and it doesn't make sense biologically to merge their interval spans.

```
gia subtract -a <query.bed> -b <target.bed> -u
```

### [Fractional Overlap](#fractional-overlap)

We can also define conditional subtraction operations on fractional overlaps
of the query, target, or both.

This means that the subtraction will only be done on query-target pairs which
meet the fractional overlap predicate provided.

#### [On Query](#on-query)

```
(query)       x------------------------y    x------y
(target)                 i--j                  i---j
======================================================
(-f 0.5)
(sub)         x------------------------y    x--i
```

We can supply a minimum overlap requirement on the query with the `-f` flag.

This will only apply subtraction operations on query-target pairs in which the
target overlaps the query by the amount required in the `-f` argument.

In the example case, only the second query-target pair was operated upon since
the first did not overlap the query by 50%.

```
gia subtract -a <query.bed> -b <target.bed> -f 0.5
```

#### [On Target](#on-target)

```
(query)       x------------------------y    x------y
(target)                 i--j                  i--------------j
======================================================
(-F 0.5)
(sub)         x----------i  j----------y    x------y
```

We can supply a minimum overlap requirement on the target with the `-F` flag.

This will only apply subtraction operations on query-target pairs in which the
query overlaps the target by the amount required in the `-F` argument.

In the example case, only the first query-target pair was operated upon since
the second did not overlap the target by 50%.

```
gia subtract -a <query.bed> -b <target.bed> -f 0.5
```

#### [Reciprocal](#reciprocal)

We can introduce a reciprocal argument (`-r`) which requires the `-f` flag
and requires that both query and target meet the same requirements of the flag.

```
gia subtract -a <query.bed> -b <target.bed> -f 0.5 -r
```

#### [Either](#either)

We can introduce the either flag (`-e`) which is used with **both** the `-f` and `-F` flags.
This will require that **either** condition is met and include those subtraction operations.

```
gia subtract -a <query.bed> -b <target.bed> -f 0.5 -F 0.3 -e
```