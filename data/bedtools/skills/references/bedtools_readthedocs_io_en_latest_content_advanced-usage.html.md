### Navigation

* [index](../genindex.html "General Index")
* [next](tips-and-tricks.html "Tips and Tricks") |
* [previous](example-usage.html "Example usage") |
* [bedtools v2.31.0](../index.html) »

# Advanced usage[¶](#advanced-usage "Permalink to this headline")

## Mask all regions in a genome except for targeted capture regions.[¶](#mask-all-regions-in-a-genome-except-for-targeted-capture-regions "Permalink to this headline")

Step 1. Add 500 bp up and downstream of each probe

```
bedtools slop -i probes.bed -g hg18.genome -b 500 > probes.500bp.bed
```

NB genome is two column chromosome size list - i.e. <https://genome.ucsc.edu/goldenpath/help/hg18.chrom.sizes>

Step 2. Get a BED file of all regions not covered by the probes (+500 bp up/down)

```
bedtools complement -i probes.500bp.bed -g hg18.genome > probes.500bp.complement.bed
```

Step 3. Create a masked genome where all bases are masked except for the probes +500bp

```
bedtools maskfasta -fi hg18.fa -bed probes.500bp.complement.bed \
-fo hg18.probecomplement.masked.fa
```

## Screening for novel SNPs.[¶](#screening-for-novel-snps "Permalink to this headline")

Find all SNPs that are not in dbSnp and not in the latest 1000 genomes calls

```
bedtools intersect -a snp.calls.bed -b dbSnp.bed -v | \
bedtools intersect -a - -b 1KG.bed -v | \
> snp.calls.novel.bed
```

## Computing the coverage of features that align entirely within an interval.[¶](#computing-the-coverage-of-features-that-align-entirely-within-an-interval "Permalink to this headline")

By default, bedtools `coverage` counts any feature in A that overlaps B
by >= 1 bp. If you want to require that a feature align entirely within B for
it to be counted, you can first use intersectBed with the “-f 1.0” option.

```
bedtools intersect -a features.bed -b windows.bed -f 1.0 | \
bedtools coverage -a windows.bed -b - \
> windows.bed.coverage
```

## Computing the coverage of BAM alignments on exons.[¶](#computing-the-coverage-of-bam-alignments-on-exons "Permalink to this headline")

One can combine `samtools` with `bedtools` to compute coverage directly
from the BAM data by using `bamtobed`.

```
bedtools bamtobed -i reads.bam | \
bedtools coverage -a exons.bed -b - \
> exons.bed.coverage
```

Take it a step further and require that coverage be from properly-paired reads.

```
samtools view -uf 0x2 reads.bam | \
coverageBed -abam - -b exons.bed \
> exons.bed.proper.coverage
```

## Computing coverage separately for each strand.[¶](#computing-coverage-separately-for-each-strand "Permalink to this headline")

Use grep to only look at forward strand features (i.e. those that end in “+”).

```
bedtools bamtobed -i reads.bam | \
grep \+$  | \
bedtools coverage -a - -b genes.bed \
> genes.bed.forward.coverage
```

Use grep to only look at reverse strand features (i.e. those that end in “-“).

```
bedtools bamtobed -i reads.bam | \
grep \-$ | \
bedtools coverage -a - -b genes.bed \
> genes.bed.reverse.coverage
```

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[![Logo](../_static/bedtools.swiss.png)](../index.html)

### [Table of Contents](../index.html)

* Advanced usage
  + [Mask all regions in a genome except for targeted capture regions.](#mask-all-regions-in-a-genome-except-for-targeted-capture-regions)
  + [Screening for novel SNPs.](#screening-for-novel-snps)
  + [Computing the coverage of features that align entirely within an interval.](#computing-the-coverage-of-features-that-align-entirely-within-an-interval)
  + [Computing the coverage of BAM alignments on exons.](#computing-the-coverage-of-bam-alignments-on-exons)
  + [Computing coverage separately for each strand.](#computing-coverage-separately-for-each-strand)

#### Previous topic

[Example usage](example-usage.html "previous chapter")

#### Next topic

[Tips and Tricks](tips-and-tricks.html "next chapter")

### This Page

* [Show Source](../_sources/content/advanced-usage.rst.txt)

### Quick search

### Navigation

* [index](../genindex.html "General Index")
* [next](tips-and-tricks.html "Tips and Tricks") |
* [previous](example-usage.html "Example usage") |
* [bedtools v2.31.0](../index.html) »

© Copyright 2009 - 2023, Aaron R. Quinlan.
Last updated on May 29, 2023.