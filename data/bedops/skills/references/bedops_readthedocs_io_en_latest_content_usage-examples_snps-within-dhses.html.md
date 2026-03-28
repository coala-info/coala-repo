# [BEDOPS v2.4.41](../../index.html%20)

* ←
  [4.3. Measuring the frequency of signed distances between SNPs and nearest DHSes](distance-frequencies.html "Previous document")
* [4.5. Smoothing raw tag count data across the genome](smoothing-tags.html "Next document")
  →

* [Home](../../index.html)
* [4. Usage examples](../usage-examples.html)

# 4.4. Finding the subset of SNPs within DHSes[¶](#finding-the-subset-of-snps-within-dhses "Permalink to this headline")

In this example, we would like to identify the set of SNPs that are within a DHS, printing out both the SNP element *and* the DHS it is contained within.

## 4.4.1. BEDOPS tools in use[¶](#bedops-tools-in-use "Permalink to this headline")

We use [bedmap](../reference/statistics/bedmap.html#bedmap) to answer this question, as it traverses a *reference* BED file (in this example, SNPs), and identifies overlapping elements from the *mapping* BED file (in this example, DHSs).

## 4.4.2. Script[¶](#script "Permalink to this headline")

SNPs are in a BED-formatted file called `SNPs.bed` sorted lexicographically with [sort-bed](../reference/file-management/sorting/sort-bed.html#sort-bed). The DNase-hypersensitive sites are stored in a sorted BED-formatted file called `DHSs.bed`. These two files are available in the [Downloads](#snps-within-dhses-downloads) section.

```
bedmap --skip-unmapped --echo --echo-map SNPs.bed DHSs.bed \
  > subsetOfSNPsWithinAssociatedDHS.bed
```

## 4.4.3. Discussion[¶](#discussion "Permalink to this headline")

The output of this [bedmap](../reference/statistics/bedmap.html#bedmap) statement might look something like this:

```
chr1    10799576    10799577    rs12.4.418  Systolic_blood_pressure Cardiovascular|chr1 10799460    10799610    MCV-1   9.18063
```

The output is delimited by pipe symbols (`|`), showing the reference element (SNP) and the mapped element (DHS).

If multiple elements are mapped onto a single reference element, the mapped elements are further separated by semicolons, by default.

## 4.4.4. Downloads[¶](#downloads "Permalink to this headline")

* [`SNP`](../../_downloads/3c764ac9ca916872b063106160b2a7dc/Frequencies-SNPs.bed.starch) elements
* [`DNase-hypersensitive`](../../_downloads/21ef6331246b51d311bb9b565a01e59a/Frequencies-DHSs.bed.starch) elements

The [bedmap](../reference/statistics/bedmap.html#bedmap) tool can operate directly on Starch-formatted archives. Alternatively, use the [unstarch](../reference/file-management/compression/unstarch.html#unstarch) tool to decompress Starch data files to sorted BED format.

[![Logo](../../_static/logo_with_label_v3.png)](../../index.html)

### [Table of Contents](../../index.html)

* 4.4. Finding the subset of SNPs within DHSes
  + [4.4.1. BEDOPS tools in use](#bedops-tools-in-use)
  + [4.4.2. Script](#script)
  + [4.4.3. Discussion](#discussion)
  + [4.4.4. Downloads](#downloads)

* ←
  [4.3. Measuring the frequency of signed distances between SNPs and nearest DHSes](distance-frequencies.html "Previous document")
* [4.5. Smoothing raw tag count data across the genome](smoothing-tags.html "Next document")
  →

* [Home](../../index.html)
* [4. Usage examples](../usage-examples.html)

© 2011-2022, Shane Neph, Alex Reynolds.
Created using [Sphinx](http://sphinx-doc.org/)
1.8.6
with the [better](http://github.com/irskep/sphinx-better-theme) theme.