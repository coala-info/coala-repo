[![](../../static/logo_trans.png)
![](../../static/logo_trans.png)](../../)v3.2

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

1. [Home](../../)
2. Getting Started
3. [Input Format](../../getting_started/inputformat/)

# # Input Format

## # Read length

Reads must be at least 30 base pairs in length for alignment. By default, the [qc](../../workflows/qc/) module removes reads <30bp.

## # Compression

Harpy generally doesn't require the input sequences to be in gzipped/bgzipped format, but it's good practice to compress your reads anyway.
Compressed files are expected to end with the extension
.gz
.

## # Naming conventions

Unfortunately, there are many different ways of naming FASTQ files, which makes it
difficult to accomodate every wacky iteration currently in circulation.
While Harpy tries its best to be flexible, there are limitations.
To that end, for the [deumultiplex](../../workflows/demultiplex/), [qc](../../workflows/qc/), and [align](../../workflows/align/bwa/) modules, the
most common FASTQ naming styles are supported:

* **sample names**:
  a-z

  0-9

  .

  \_

  -

  case insensitive
  + you can mix and match special characters, but that's bad practice and not recommended
  + examples: `Sample.001`, `Sample_001_year4`, `Sample-001_population1.year2` <- not recommended
* **forward**:
  \_F

  .F

  \_1

  .1

  \_R1\_001

  .R1\_001

  \_R1

  .R1
* **reverse**:
  \_R

  .R

  \_2

  .2

  \_R2\_001

  .R2\_001

  \_R2

  .R2
* **fastq extension**:
  .fq

  .fastq

  case insensitive
* **gzipped**:
  👍
  supported

  ❤️
  recommended
* **not gzipped**:
  👍
  supported

You can also mix and match different formats and styles within a given directory, although again, **this isn't recommended**.
As a good rule of thumb for any computational work, you should be deliberate and consistent in how you name things.

## See also

[Home

Using Harpy to process your linked-read data](/harpy/)
[Quality Trim Sequences

Quality trim haplotagged sequences with Harpy](/harpy/workflows/qc/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Getting_Started/inputformat.md)

[Previous
Install](../../getting_started/install/)

[Next
Linked-​Read Data](../../getting_started/linked_read_data/)

© Copyright 2026. All rights reserved.