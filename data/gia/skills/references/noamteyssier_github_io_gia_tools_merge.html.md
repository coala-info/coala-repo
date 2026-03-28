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

# [`[ gia merge ]`](#-gia-merge-)

## [Background](#background)

This subcommand will merge all **overlapping** and **bordering** intervals
within the input set.

It can accept either a presorted input (which can be streamed) or an unsorted
input which will first be sorted in-place before merging.

## [Usage](#usage)

See full arguments and options using:

```
gia merge --help
```

### [Default Behavior (Inplace)](#default-behavior-inplace)

```
(e)                    q----r
(b)      k----l
(a)    i----j
(c)           l----m
(d)                  o----p
===============================
(1)    i-----------m
(2)                  o------r
```

This will merge all overlapping and bordering intervals into their sub-spans.

It **does not assume presorted input** and will sort the input inplace on load.

```
gia merge -i <input.bed>
```

### [Streamable Input](#streamable-input)

```
(a)    i----j
(b)      k----l
(c)           l----m
(d)                  o----p
(e)                    q----r
===============================
(1)    i-----------m
(2)                  o------r
```

This will merge all overlapping and bordering intervals into their sub-spans.

This **assumes presorted input** and will have undefined behavior is input is not-sorted.

```
gia merge -i <input.bed> -S
```