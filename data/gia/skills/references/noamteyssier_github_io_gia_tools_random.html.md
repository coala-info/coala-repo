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

# [`[ gia random ]`](#-gia-random-)

## [Background](#background)

This subcommand will generate a random set of intervals.

## [Usage](#usage)

See full arguments and options using:

```
gia random --help
```

### [Parameterization](#parameterization)

This generates intervals given:

* Number of Intervals
* Length of Intervals
* Number of Chromosomes
* Max Chromosome Length

The intervals are drawn randomly from a random chromosome and are each
equally sized to the length provided.

An optional `*.genome` file can be given to provide multiple and potentially
differently sized chromosome lengths.

```
# will randomly generate intervals given default params
gia random

# sets the number of chromosomes to 10
gia random -c 10

# generates 100 random intervals
gia random -n 100

# generates 100 random intervals each with a length of 500
gia random -n 100 -l 500

# generates 100 random intervals with a length of 500 using a prior genome
gia random -n 100 -l 500 -g <my.genome>
```