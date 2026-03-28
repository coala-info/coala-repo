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

# [`[ gia closest ]`](#-gia-closest-)

## [Background](#background)

Similar to [intersect](./intersect.html), `closest` searches for the closest
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