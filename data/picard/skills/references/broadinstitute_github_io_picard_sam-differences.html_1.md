# [Picard](index.html)

[![Build Status](https://travis-ci.org/broadinstitute/picard.svg?branch=master)](https://travis-ci.org/broadinstitute/picard)

A set of command line tools (in Java) for manipulating high-throughput sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

[View the Project on GitHub broadinstitute/picard](https://github.com/broadinstitute/picard)

* [Latest Jar **Release**](https://github.com/broadinstitute/picard/releases/latest)
* [Source Code **ZIP File**](https://github.com/broadinstitute/picard/zipball/master)
* [Source Code **TAR Ball**](https://github.com/broadinstitute/picard/tarball/master)
* [View On **GitHub**](https://github.com/broadinstitute/picard)

## SAM Differences in Picard

Picard attempts to conform to the [SAM format specification](http://samtools.github.io/hts-specs/SAMv1.pdf), but there are a few areas in which it diverges.

### Strictness

In many cases Picard complains about constructs that are allowed in the SAM spec. In some cases passing VALIDATION\_STRINGENCY=LENIENT or SILENT will allow the program to continue, but in other cases the requirement is essential to the program's correct execution. Typically a Picard tool will fail in these cases.

### Multi-segment Reads

Picard can handle unpaired reads (i.e. single-end), or paired reads, but is not prepared to handle more than two segments for a read.

### Secondary Alignments

A number of Picard tools can handle secondary alignments, but typically these tools either ignore these alignments or pass them from input to output unchanged. MergeBamAlignment has the PRIMARY\_ALIGNMENT\_STRATEGY that can be used to determine how the program will select a primary alignment among multiple alignments for a segment in an aligner's output.

### TLEN

The original definition of the TLEN field of a SAM record was the distance between the 5' ends, with leftmost segment having positive value and rightmost segment negative. This is what Picard implements. At some point, the spec was changed to define TLEN as the distance between the leftmost mapped base to the rightmost mapped base, with leftmost segment having positive value and rightmost segment having negative value.

### CIGAR Validation

Picard's validation of CIGAR strings is more stringent than that prescribed by the SAM spec. Picard's CIGAR validation is oriented toward resequencing data rather than assembly. If these validations get in your way, you can turn down VALIDATION\_STRINGENCY, or for ValidateSamFile, use the IGNORE option to turn off validations you don't want.

### Queryname Sort Order

Queryname sort order is not clearly defined in the SAM spec. Picard implements queryname order as a simple lexical ordering. Samtools implements queryname sort order differently than Picard.

Project maintained by [broadinstitute](https://github.com/broadinstitute)

Hosted on GitHub Pages — Theme by [orderedlist](https://github.com/orderedlist)