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

# [`[ gia extend ]`](#-gia-extend-)

## [Background](#background)

This subcommand is used to grow intervals from either of their terminals.
It can be used to either grow both sides, just the left, or just the right.
An optional `-g` flag can be given if the chromosome length is known, which will
be used to truncate growths to not overextend the chromosome length.

## [Usage](#usage)

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