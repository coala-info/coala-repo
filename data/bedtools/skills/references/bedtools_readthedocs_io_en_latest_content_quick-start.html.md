### Navigation

* [index](../genindex.html "General Index")
* [next](general-usage.html "General usage") |
* [previous](installation.html "Installation") |
* [bedtools v2.31.0](../index.html) »

# Quick start[¶](#quick-start "Permalink to this headline")

## Install bedtools[¶](#install-bedtools "Permalink to this headline")

```
curl http://bedtools.googlecode.com/files/BEDTools.<version>.tar.gz > BEDTools.tar.gz
tar -zxvf BEDTools.tar.gz
cd BEDTools
make
sudo cp bin/* /usr/local/bin/
```

## Use bedtools[¶](#use-bedtools "Permalink to this headline")

Below are examples of typical bedtools usage. Using the “-h” option with any
bedtools will report a list of all command line options.

Report the base-pair overlap between the features in two BED files.

```
bedtools intersect -a reads.bed -b genes.bed
```

Report those entries in A that overlap NO entries in B. Like “grep -v”

```
bedtools intersect  -a reads.bed -b genes.bed -v
```

Read BED A from STDIN. Useful for stringing together commands. For example,
find genes that overlap LINEs but not SINEs.

```
bedtools intersect -a genes.bed -b LINES.bed | \
  bedtools intersect -a stdin -b SINEs.bed -v
```

Find the closest ALU to each gene.

```
bedtools closest -a genes.bed -b ALUs.bed
```

Merge overlapping repetitive elements into a single entry, returning the number of entries merged.

```
bedtools merge -i repeatMasker.bed -n
```

Merge nearby repetitive elements into a single entry, so long as they are within 1000 bp of one another.

```
bedtools merge -i repeatMasker.bed -d 1000
```

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[![Logo](../_static/bedtools.swiss.png)](../index.html)

### [Table of Contents](../index.html)

* Quick start
  + [Install bedtools](#install-bedtools)
  + [Use bedtools](#use-bedtools)

#### Previous topic

[Installation](installation.html "previous chapter")

#### Next topic

[General usage](general-usage.html "next chapter")

### This Page

* [Show Source](../_sources/content/quick-start.rst.txt)

### Quick search

### Navigation

* [index](../genindex.html "General Index")
* [next](general-usage.html "General usage") |
* [previous](installation.html "Installation") |
* [bedtools v2.31.0](../index.html) »

© Copyright 2009 - 2023, Aaron R. Quinlan.
Last updated on May 29, 2023.