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

# [`[ gia sample ]`](#-gia-sample-)

## [Background](#background)

This subcommand will randomly sample intervals from an input file.

> **Note:** The output of this command is **not guaranteed** to be sorted.

## [Usage](#usage)

See full arguments and options using:

```
gia sample --help
```

### [Sample a fixed number of intervals](#sample-a-fixed-number-of-intervals)

You can sample a fixed number of intervals from the dataset using the `-n` flag

```
# samples 100 intervals from the dataset
gia sample -i <input.bed> -n 100
```

### [Sample a fractional number of intervals](#sample-a-fractional-number-of-intervals)

You can sample a fractional number of intervals from the total size of the dataset
using the `-f` flag.

```
# samples 0.1 (10%) of the intervals
gia sample -i <input.bed> -f 0.1
```