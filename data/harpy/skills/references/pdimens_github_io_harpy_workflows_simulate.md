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
3. [Simulate](../../workflows/simulate/)

# # Simulate Genomic Data

Simulate genomic data

You may be interested in benchmarking variant detection or maybe just trying out
haplotagging data without any financial commitment-- that's where simulations
come in handy.

## # Simulate Genomic Variants

Harpy lets you simulate genomic variants via [simulate {snpindel,inversion,...}](simulate-variants/) for different variant
types such as single nucleotide polymorphisms (SNP), indels, inversions, copy number variants (CNV), and translocations. All you need is to provide a genome to simulate
those variants onto.

## # Simulate Haplotag Linked-Reads being deprecated

You can also simulate haplotag-style linked reads from an existing genome using [simulate linkedreads](simulate-linkedreads/). Harpy
incorporates [LRSIM](https://github.com/aquaskyline/LRSIM) to generate linked reads
from a diploid genomic. If you only have a haploid genome, then you can create a diploid genome by simulating variants into it with [simulate {snpindel,inversion,...}](simulate-variants/).

## See also

[Home

Using Harpy to process your linked-read data](/harpy/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/Simulate/Simulate.md)

[Previous
QC](../../workflows/qc/)

[Next
Linked Reads](../../workflows/simulate/simulate-linkedreads/)

© Copyright 2026. All rights reserved.