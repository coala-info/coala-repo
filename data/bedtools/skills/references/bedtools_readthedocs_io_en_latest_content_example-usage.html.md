### Navigation

* [index](../genindex.html "General Index")
* [next](advanced-usage.html "Advanced usage") |
* [previous](tools/window.html "window") |
* [bedtools v2.31.0](../index.html) »

# Example usage[¶](#example-usage "Permalink to this headline")

Below are several examples of basic bedtools usage. Example BED files are
provided in the /data directory of the bedtools distribution.

## bedtools intersect[¶](#bedtools-intersect "Permalink to this headline")

Report the base-pair overlap between sequence alignments and genes.

```
bedtools intersect -a reads.bed -b genes.bed
```

Report whether each alignment overlaps one or more genes. If not, the alignment is not reported.

```
bedtools intersect -a reads.bed -b genes.bed -u
```

Report those alignments that overlap NO genes. Like “grep -v”

```
bedtools intersect -a reads.bed -b genes.bed -v
```

Report the number of genes that each alignment overlaps.

```
bedtools intersect -a reads.bed -b genes.bed -c
```

Report the entire, original alignment entry for each overlap with a gene.

```
bedtools intersect -a reads.bed -b genes.bed -wa
```

Report the entire, original gene entry for each overlap with a gene.

```
bedtools intersect -a reads.bed -b genes.bed -wb
```

Report the entire, original alignment and gene entries for each overlap.

```
bedtools intersect -a reads.bed -b genes.bed -wa -wb
```

Only report an overlap with a repeat if it spans at least 50% of the exon.

```
bedtools intersect -a exons.bed -b repeatMasker.bed -f 0.50
```

Only report an overlap if comprises 50% of the structural variant and 50% of the segmental duplication. Thus, it is reciprocally at least a 50% overlap.

```
bedtools intersect -a SV.bed -b segmentalDups.bed -f 0.50 -r
```

Read BED A from stdin. For example, find genes that overlap LINEs but not SINEs.

```
bedtools intersect -a genes.bed -b LINES.bed | intersectBed -a stdin -b SINEs.bed -v
```

Retain only single-end BAM alignments that overlap exons.

```
bedtools intersect -abam reads.bam -b exons.bed > reads.touchingExons.bam
```

Retain only single-end BAM alignments that do not overlap simple sequence
repeats.

```
bedtools intersect -abam reads.bam -b SSRs.bed -v > reads.noSSRs.bam
```

## bedtools bamtobed[¶](#bedtools-bamtobed "Permalink to this headline")

Convert BAM alignments to BED format.

```
bedtools bamtobed -i reads.bam > reads.bed
```

Convert BAM alignments to BED format using the BAM edit distance (NM) as the
BED “score”.

```
bedtools bamtobed -i reads.bam -ed > reads.bed
```

Convert BAM alignments to BEDPE format.

```
bedtools bamtobed -i reads.bam -bedpe > reads.bedpe
```

## bedtools window[¶](#bedtools-window "Permalink to this headline")

Report all genes that are within 10000 bp upstream or downstream of CNVs.

```
bedtools window -a CNVs.bed -b genes.bed -w 10000
```

Report all genes that are within 10000 bp upstream or 5000 bp downstream of
CNVs.

```
bedtools window -a CNVs.bed -b genes.bed -l 10000 -r 5000
```

Report all SNPs that are within 5000 bp upstream or 1000 bp downstream of genes.
Define upstream and downstream based on strand.

```
bedtools window -a genes.bed -b snps.bed -l 5000 -r 1000 -sw
```

## bedtools closest[¶](#bedtools-closest "Permalink to this headline")

Note: By default, if there is a tie for closest, all ties will be reported. **closestBed** allows overlapping
features to be the closest.

Find the closest ALU to each gene.

```
bedtools closest -a genes.bed -b ALUs.bed
```

Find the closest ALU to each gene, choosing the first ALU in the file if there is a
tie.

```
bedtools closest -a genes.bed -b ALUs.bed -t first
```

Find the closest ALU to each gene, choosing the last ALU in the file if there is a
tie.

```
bedtools closest -a genes.bed -b ALUs.bed -t last
```

## bedtools subtract[¶](#bedtools-subtract "Permalink to this headline")

Note

If a feature in A is entirely “spanned” by any feature in B, it will not be reported.

Remove introns from gene features. Exons will (should) be reported.

```
bedtools subtract -a genes.bed -b introns.bed
```

## bedtools merge[¶](#bedtools-merge "Permalink to this headline")

Note

`merge` requires that the input is sorted by chromosome and then by start
coordinate. For example, for BED files, one would first sort the input
as follows: `sort -k1,1 -k2,2n input.bed > input.sorted.bed`

Merge overlapping repetitive elements into a single entry.

```
bedtools merge -i repeatMasker.bed
```

Merge overlapping repetitive elements into a single entry, returning the number of
entries merged.

```
bedtools merge -i repeatMasker.bed -n
```

Merge nearby (within 1000 bp) repetitive elements into a single entry.

```
bedtools merge -i repeatMasker.bed -d 1000
```

## bedtools coverage[¶](#bedtools-coverage "Permalink to this headline")

Compute the coverage of aligned sequences on 10 kilobase “windows” spanning the
genome.

```
bedtools coverage -a reads.bed -b windows10kb.bed | head
chr1 0     10000 0  10000 0.00
chr1 10001 20000 33 10000 0.21
chr1 20001 30000 42 10000 0.29
chr1 30001 40000 71 10000 0.36
```

Compute the coverage of aligned sequences on 10 kilobase “windows” spanning the
genome and created a BEDGRAPH of the number of aligned reads in each window for
display on the UCSC browser.

```
bedtools coverage -a reads.bed -b windows10kb.bed | cut -f 1-4 > windows10kb.cov.bedg
```

Compute the coverage of aligned sequences on 10 kilobase “windows” spanning the
genome and created a BEDGRAPH of the fraction of each window covered by at least
one aligned read for display on the UCSC browser.

```
bedtools coverage -a reads.bed -b windows10kb.bed | \
   awk '{OFS="\t"; print $1,$2,$3,$6}' \
   > windows10kb.pctcov.bedg
```

## bedtools complement[¶](#bedtools-complement "Permalink to this headline")

Report all intervals in the human genome that are not covered by repetitive
elements.

```
bedtools complement -i repeatMasker.bed -g hg18.genome
```

## bedtools shuffle[¶](#bedtools-shuffle "Permalink to this headline")

Randomly place all discovered variants in the genome. However, prevent them
from being placed in know genome gaps.

```
bedtools shuffle -i variants.bed -g hg18.genome -excl genome_gaps.bed
```

Randomly place all discovered variants in the genome. However, prevent them
from being placed in know genome gaps and require that the variants be randomly
placed on the same chromosome.

```
bedtools shuffle -i variants.bed -g hg18.genome -excl genome_gaps.bed -chrom
```

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[![Logo](../_static/bedtools.swiss.png)](../index.html)

### [Table of Contents](../index.html)

* Example usage
  + [bedtools intersect](#bedtools-intersect)
  + [bedtools bamtobed](#bedtools-bamtobed)
  + [bedtools window](#bedtools-window)
  + [bedtools closest](#bedtools-closest)
  + [bedtools subtract](#bedtools-subtract)
  + [bedtools merge](#bedtools-merge)
  + [bedtools coverage](#bedtools-coverage)
  + [bedtools complement](#bedtools-complement)
  + [bedtools shuffle](#bedtools-shuffle)

#### Previous topic

[*window*](tools/window.html "previous chapter")

#### Next topic

[Advanced usage](advanced-usage.html "next chapter")

### This Page

* [Show Source](../_sources/content/example-usage.rst.txt)

### Quick search

### Navigation

* [index](../genindex.html "General Index")
* [next](advanced-usage.html "Advanced usage") |
* [previous](tools/window.html "window") |
* [bedtools v2.31.0](../index.html) »

© Copyright 2009 - 2023, Aaron R. Quinlan.
Last updated on May 29, 2023.