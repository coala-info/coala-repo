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
3. [Align](../../workflows/align/)

# # Align Sequences to a Genome

Align haplotagged sequences

After your sequences (in FASTQ format) have been checked for quality, you
will need to align them to a reference genome before you can call variants.
Harpy offers several aligners for this purpose:

| aligner | speed | repository | publication |
| --- | --- | --- | --- |
| [BWA](bwa/) | fast ⚡ | [github](https://github.com/lh3/bwa) | [paper](http://arxiv.org/abs/1303.3997) |
| [strobealign](strobe/) | super fast ⚡⚡ | [github](https://github.com/ksahlin/strobealign) | [paper](https://doi.org/10.1186/s13059-022-02831-7) |

Neither of these are linked-read aware aligners, but Harpy transfers the barcode information from the sequence headers into the alignments and will
assign molecule identifiers (`MI:i` SAM tags) based on these barcodes and the [molecule distance threshold](../../getting_started/linked_read_data/#barcode-thresholds).

## # Non linked-read WGS data

Starting with Harpy `v2.x`, you can skip the workflow
routines that do things specific to linked reads, meaning you can comfortably use
[harpy align bwa](bwa/) and [harpy align strobe](strobe/) to align your WGS sequence data.

* version `2.0-2.7` : `--ignore-bx`
* version `>2.7` : `--lr-type none`
* version `>=3.0`: autodetected or forced with `--unlinked`

##### RADseq data

RADseq data will probably work fine too, however you may need to post-process the
BAM files to unset the duplicate flag, as marking duplicates in RADseq (without UMIs) [may cause issues](https://www.researchgate.net/post/How_to_exclude_PCR_duplicates_in_ddRAD) with SNP calling:

```
samtools view -b -h --remove-flags 1024 -o output.bam input.bam
```

## See also

[Call SNPs and small indels

Call SNPs and small indels](/harpy/workflows/snp/)
[Common Harpy Options

Each of the main Harpy modules (e.g. or ) follows the format of](/harpy/getting_started/common_options/)
[Home

Using Harpy to process your linked-read data](/harpy/)
[Quality Trim Sequences

Quality trim haplotagged sequences with Harpy](/harpy/workflows/qc/)
[Resolve barcodes shared by different molecules

Resolve barcodes shared by different molecules](/harpy/workflows/deconvolve/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/Align/Align.md)

[Previous
View](../../getting_started/troubleshooting/view/)

[Next
BWA](../../workflows/align/bwa/)

© Copyright 2026. All rights reserved.