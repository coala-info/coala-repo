General

* [Main page](index.html)
* [Manual page](../bcftools.html)
* [Installation](install.html)
* [Publications](publications.html)

Calling

* [CNV calling](cnv-calling.html)
* [Consequence calling](csq-calling.html)
* [Consensus calling](consensus-sequence.html)
* [ROH calling](roh-calling.html)
* [Variant calling and filtering](variant-calling.html)

Tips and Tricks

* [Converting formats](convert.html)
* [Adding annotation](annotate.html)
* [Extracting information](query.html)
* [Filtering expressions](filtering.html)
* [Performance and Scaling](scaling.html)
* [Plugins](plugins.html)
* [FAQ](FAQ.html)

## BCFtools HowTo

### About this document

Please help us improve this documentation by either editing
it and sending a pull request or by opening an issue on
[github](https://github.com/samtools/bcftools/issues).

### About BCFtools

BCFtools is a program for variant calling and manipulating files in the
Variant Call Format (VCF) and its binary counterpart BCF. All commands work
transparently with both VCFs and BCFs, both uncompressed and BGZF-compressed.
In order to avoid tedious repetition, throughout this document we will use
"VCF" and "BCF" interchangeably, unless specifically noted.

Most commands accept VCF, bgzipped VCF and BCF with filetype detected
automatically even when streaming from a pipe. Indexed VCF and BCF
work in all situations. Unindexed VCF and BCF and streams
work in most, but not all situations. In general, whenever multiple VCFs are
read simultaneously, they must be indexed and therefore also compressed.

### Feedback

We welcome your feedback, please help us improve this page by
either opening an [issue on github](https://github.com/samtools/bcftools/issues) or [editing it directly](https://github.com/samtools/bcftools/tree/gh-pages/howtos) and sending
a pull request.