# [BEDOPS v2.4.41](../../index.html%20)

* ←
  [4.2. Collapsing multiple BED files into a master list by signal](master-list.html "Previous document")
* [4.4. Finding the subset of SNPs within DHSes](snps-within-dhses.html "Next document")
  →

* [Home](../../index.html)
* [4. Usage examples](../usage-examples.html)

# 4.3. Measuring the frequency of signed distances between SNPs and nearest DHSes[¶](#measuring-the-frequency-of-signed-distances-between-snps-and-nearest-dhses "Permalink to this headline")

In this example, we would like to find the **signed** distance between a single nucleotide repeat and the DNase-hypersensitive site nearest to it, as measured in base pairs (bp).

## 4.3.1. BEDOPS tools in use[¶](#bedops-tools-in-use "Permalink to this headline")

To find nearest elements, we will use [closest-features](../reference/set-operations/closest-features.html#closest-features) with the `--dist`, `--closest`, and `--no-ref` options.

## 4.3.2. Script[¶](#script "Permalink to this headline")

SNPs are in a BED-formatted file called `SNPs.bed` sorted lexicographically with [sort-bed](../reference/file-management/sorting/sort-bed.html#sort-bed). The DNase-hypersensitive sites are stored in a sorted BED-formatted file called `DHSs.bed`. These two files are available in the [Downloads](#distance-frequencies-downloads) section.

```
# author : Eric Rynes
closest-features --dist --closest --no-ref SNPs.bed DHSs.bed \
    | cut -f2 -d '|' \
    | grep -w -F -v -e "NA" \
    > answer.bed
```

## 4.3.3. Discussion[¶](#discussion "Permalink to this headline")

The `--dist` option returns signed distances between input elements and reference elements, `--closest` chooses the single closest element, and `--no-ref` keeps SNP coordinates from being printed out.

The output from [closest-features](../reference/set-operations/closest-features.html#closest-features) contains coordinates and the signed distance to the closest DHS, separated by the pipe (`|`) character. Such output might look something like this:

```
chr1    2513240 2513390 MCV-11  97.201400|25
```

This type of result is chopped up with the standard UNIX utility `cut` to get at the distances to the closest elements. Finally, we use `grep -v` to throw out any non-distance, denoted by `NA`. This can occur if there exists some chromosome in the SNP dataset that does not exist in the DHSs.

Thus, for every SNP, we have a corresponding distance to nearest DHS. As an example, from this data we could build a histogram showing the frequencies of distances-to-nearest-DHS.

## 4.3.4. Downloads[¶](#downloads "Permalink to this headline")

* [`SNP`](../../_downloads/3c764ac9ca916872b063106160b2a7dc/Frequencies-SNPs.bed.starch) elements
* [`DNase-hypersensitive`](../../_downloads/21ef6331246b51d311bb9b565a01e59a/Frequencies-DHSs.bed.starch) elements

The [closest-features](../reference/set-operations/closest-features.html#closest-features) tool can operate directly on Starch-formatted archives. Alternatively, use the [unstarch](../reference/file-management/compression/unstarch.html#unstarch) tool to decompress Starch data files to sorted BED format.

[![Logo](../../_static/logo_with_label_v3.png)](../../index.html)

### [Table of Contents](../../index.html)

* 4.3. Measuring the frequency of signed distances between SNPs and nearest DHSes
  + [4.3.1. BEDOPS tools in use](#bedops-tools-in-use)
  + [4.3.2. Script](#script)
  + [4.3.3. Discussion](#discussion)
  + [4.3.4. Downloads](#downloads)

* ←
  [4.2. Collapsing multiple BED files into a master list by signal](master-list.html "Previous document")
* [4.4. Finding the subset of SNPs within DHSes](snps-within-dhses.html "Next document")
  →

* [Home](../../index.html)
* [4. Usage examples](../usage-examples.html)

© 2011-2022, Shane Neph, Alex Reynolds.
Created using [Sphinx](http://sphinx-doc.org/)
1.8.6
with the [better](http://github.com/irskep/sphinx-better-theme) theme.