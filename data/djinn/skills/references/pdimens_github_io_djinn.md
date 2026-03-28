![](static/djinn.png)
![](static/djinn.png)v2.0

* [![](https://raw.githubusercontent.com/pdimens/harpy/refs/heads/docs/static/logo_navbar.png)
  Harpy](https://pdimens.github.io/harpy/)
* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](https://raw.githubusercontent.com/pdimens/harpy/refs/heads/docs/static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/djinn)
* [Submit Issue](https://github.com/pdimens/djinn/issues/new/)

[Powered by](https://retype.com/)

* [![](https://raw.githubusercontent.com/pdimens/harpy/refs/heads/docs/static/logo_navbar.png)
  Harpy](https://pdimens.github.io/harpy/)
* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](https://raw.githubusercontent.com/pdimens/harpy/refs/heads/docs/static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/djinn)
* [Submit Issue](https://github.com/pdimens/djinn/issues/new/)

[Powered by](https://retype.com/)

# # Home

![](static/djinn.png)

You're here because you have linked-read data and might want to convert it between different linked-read formats. Many of the conversions
available in Djinn work for either FASTQ or BAM files. Djinn also includes other tools for *e.g.* extracting barcodes from linked-read
data, sorting by barcodes, etc. Nifty convenience things.

## # Convert files

Djinn converts between linked-read data formats. It supports:

* 10X
* haplotagging
* stLFR
* TELLseq
* standard

You can convert between these formats in terms of FASTQ type or barcode style.

## # NCBI submission

NCBI strips out sequence headers from FASTQ submissions, so it would be best to convert your linked-read
FASTQ data into an unaligned BAM file, with the linked-read barcode stored in the `BX` or `BC` tag.
Djinn provides a convenience function to convert to (or from) this format, although we make no effort to hide
the fact it's just one-liner `samtools` commands.

##### Useless trivia

The original version of these general functions was written while waiting for repairs at a mechanic shop and it was called `lr-switcheroo`.

[Edit this page](https://github.com/pdimens/djinn/edit/docs/index.md)

© Copyright 2026. All rights reserved.