# [Picard](index.html)

[![Build Status](https://travis-ci.org/broadinstitute/picard.svg?branch=master)](https://travis-ci.org/broadinstitute/picard)

A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

[View the Project on GitHub broadinstitute/picard](https://github.com/broadinstitute/picard)

* [Latest Jar **Release**](https://github.com/broadinstitute/picard/releases/latest)
* [Source Code **ZIP File**](https://github.com/broadinstitute/picard/zipball/master)
* [Source Code **TAR Ball**](https://github.com/broadinstitute/picard/tarball/master)
* [View On **GitHub**](https://github.com/broadinstitute/picard)

## Decoding Base Qualities

This utility makes it easy to convert between base quality values encoded in ASCII (as recorded in a FASTQ or SAM file) and their integer values representing the Phred-scaled probability that each base call is correct (as explained [here](https://www.broadinstitute.org/gatk/documentation/article?id=4260)).

**Select encoding scale:**
Sanger
Solexa
Illumina 1.3+
Illumina 1.5+
Illumina 1.8+

See the [FASTQ format](https://en.wikipedia.org/wiki/FASTQ_format#Encoding) documentation for more details on encoding scales.

#### Enter the ASCII string or Phred value you want to convert in the box below: Multiple Phred values can be entered separated by commas.

---

Project maintained by [broadinstitute](https://github.com/broadinstitute)

Hosted on GitHub Pages — Theme by [orderedlist](https://github.com/orderedlist)