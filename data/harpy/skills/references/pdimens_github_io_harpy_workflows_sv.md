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
3. [SV](../../workflows/sv/)

# # Find structural variants

Find structural variants

The [snp](../snp/) module identifies single nucleotide
polymorphisms (SNP) and small indels, but you may want to (and should!) leverage the linked-read
data to identify larger structural variants (SV) like large deletions, duplications, and
inversions. Harpy provides two linked-read variant callers to do exactly that:

| Caller | variants it detects | caveats | link |
| --- | --- | --- | --- |
| [LEVIATHAN](leviathan/) | inversion, duplication, deletion, breakend | requires supplementary alignments | [repo](https://github.com/morispi/LEVIATHAN), [paper](https://doi.org/10.1101/2021.03.25.437002) |
| [NAIBR](naibr/) | inversion, duplication, deletion | requires phased alignments | [original repo](https://github.com/raphael-group/NAIBR), [fork repo](https://github.com/pontushojer/NAIBR), [paper](https://doi.org/10.1093/bioinformatics/btx712) |

## # LEVIATHAN

LEVIATHAN relies on split-read information in the sequence alignments to call variants. It requires less
preprocessing work to get it up and running, so it's a great place to start.

## # NAIBR

While our testing shows that NAIBR tends to find known inversions that LEVIATHAN misses, the program requires haplotype
**phased** bam files as input. That means the alignments have a `PS` or `HP` tag that indicate
which haplotype the read/alignment belongs to. If your alignments don't have phasing tags (none of the current aligners in Harpy do this),
then you will need to use the [phase](../phase/) module to phase your SNPs into haplotypes so
the [sv naibr](naibr/) module can use that to phase your input alignments and proceed as planned.

## See also

[Home

Using Harpy to process your linked-read data](/harpy/)
[Pooling samples for SV calling

Why pool samples for SV calling and when to do it](/harpy/getting_started/guides/sv_pooling/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/SV/SV.md)

[Previous
SNP](../../workflows/snp/)

[Next
Leviathan](../../workflows/sv/leviathan/)

© Copyright 2026. All rights reserved.