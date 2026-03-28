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
2. Workflows
3. [Deconvolve](../../workflows/deconvolve/)

# # Resolve barcodes shared by different molecules

In

[linked-read](../../categories/linked-read/)

Resolve barcodes shared by different molecules

 You will need

* paired-end reads from an Illumina sequencer in FASTQ format
  ❤️
  gzipped recommended
  + **sample name**:
    a-z

    0-9

    .

    \_

    -

    case insensitive
  + **forward**:
    \_F

    .F

    .1

    \_1

    \_R1\_001

    .R1\_001

    \_R1

    .R1
  + **reverse**:
    \_R

    .R

    .2

    \_2

    \_R2\_001

    .R2\_001

    \_R2

    .R2
  + **fastq extension**:
    .fq

    .fastq

    case insensitive

Running
deconvolve
 is **optional**. In the alignment
workflows ([align bwa](../align/bwa/)
[align strobe](../align/strobe/)), Harpy already uses a distance-based approach to
deconvolve barcodes and assign `MI` tags (Molecular Identifier). This workflow uses a reference-free method,
[QuickDeconvolution](https://github.com/RolandFaure/QuickDeconvolution), which uses k-mers to look at "read clouds" (all reads with the same linked-read barcode)
and decide which ones likely originate from different molecules. Regardless of whether you run
this workflow or not, [harpy align](../align/) will still perform its own deconvolution.

usage

```
harpy deconvolve OPTIONS... INPUTS...
```

example | deconvolve with default parameters

```
harpy deconvolve path/to/data/*.fq
```

## # Running Options

| argument | default | description |
| --- | --- | --- |
| `INPUTS` |  | required  Files or directories containing [input FASTQ files](../../getting_started/common_options/#input-arguments) |
| `--density` `-d` | `3` | On average, \frac{1}{2^d} kmers are indexed |
| `--dropout` `-a` | `0` | Minimum cloud size to deconvolve |
| `--kmer-length` `-k` | `21` | Size of k-mers to search for similarities |
| `--window-size` `-w` | `40` | Size of window guaranteed to contain at least one kmer |

## # Resulting Barcodes

After deconvolution, some barcodes may have a hyphenated suffix like `-1` or `-2` (e.g. `A01C33B41D93-1`).
This is how deconvolution methods create unique variants of barcodes to denote that identical barcodes
do not come from the same original molecules. QuickDeconvolution adds the `-0` suffix to barcodes it was unable
to deconvolve.

## # Harpy Deconvolution Nuances

Some of the downstream linked-read tools Harpy uses expect linked read barcodes to either look like the 16-base 10X
variety or a standard haplotag (AxxCxxBxxDxx). Their pattern-matching would not recognize barcodes deconvoluted with
hyphens. To remedy this, `MI` assignment in [align bwa](../align/bwa/)
and [align strobe](../align/strobe/) will assign the deconvolved (hyphenated) barcode to a `DX:Z`
tag and restore the original barcode as the `BX:Z` tag.

## See also

[Create a Genome Assembly

Create a genome assembly from linked reads](/harpy/workflows/assembly/)
[Create a Metagenome Assembly

Create a metagenome assembly from linked reads](/harpy/workflows/metassembly/)
[Home

Using Harpy to process your linked-read data](/harpy/)

[linked-read](../../tags/linked-read/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/deconvolve.md)

[Previous
Convert](../../workflows/convert/)

[Next
Downsample](../../workflows/downsample/)

© Copyright 2026. All rights reserved.