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

# [`[ gia sort ]`](#-gia-sort-)

## [Background](#background)

This subcommand will sort intervals from an input file.

> **Note:** Chromosome Ordering
>
> If named chromosomes are provided they will be sorted by
> the **order in which they appear in the input file**.
> In the future this will likely be lexicographically ordered.

## [Usage](#usage)

See full arguments and options using:

```
gia sort --help
```

### [Sort an input BED](#sort-an-input-bed)

You can sort an input file with the following command:

```
gia sort -i <input.bed>
```

### [Sort a named input BED](#sort-a-named-input-bed)

If the chromosome names are non-integers you can run the following command:

```
gia sort -i <input.bed> -N
```