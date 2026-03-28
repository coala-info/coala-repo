sequenza-utils

latest

* [Installation](install.html)
* [Command line interface](commands.html)
* [User cookbook](guide.html)

* [API library interface](api.html)

sequenza-utils

* Docs »
* Sequenza-utils
* [Edit on Bitbucket](https://bitbucket.org/sequenzatools/sequenza-utils/src/master/docs/index.rst?mode=view)

---

# Sequenza-utils[¶](#sequenza-utils "Permalink to this headline")

Sequenza-utils is The supporting python library for the [sequenza](https://cran.r-project.org/web/packages/sequenza/index.html) R package.

Sequenza is a software for the estimation and quantification of purity/ploidy and copy number alteration in sequencing experiments of tumor samples.
Sequenza-utils provide command lines programs to transform common NGS file format - such as BAM, pileup and VCF - to input files for the R package

## User documentation[¶](#user-documentation "Permalink to this headline")

* [Installation](install.html)
  + [Latest release via PyPI](install.html#latest-release-via-pypi)
  + [Development version](install.html#development-version)
* [Command line interface](commands.html)
  + [CG wiggle](commands.html#cg-wiggle)
  + [BAM/mpileup to seqz](commands.html#bam-mpileup-to-seqz)
  + [Binning seqz](commands.html#binning-seqz)
  + [VCF to seqz](commands.html#vcf-to-seqz)
  + [Merge overlapping seqz](commands.html#merge-overlapping-seqz)
* [User cookbook](guide.html)
  + [Generate GC reference file](guide.html#generate-gc-reference-file)
  + [From BAM files](guide.html#from-bam-files)
  + [Binning seqz, reduce memory](guide.html#binning-seqz-reduce-memory)
  + [Seqz from VCF files](guide.html#seqz-from-vcf-files)
  + [Merge seqz files](guide.html#merge-seqz-files)

## Library reference[¶](#library-reference "Permalink to this headline")

* [API library interface](api.html)
  + [sequenza.izip](api.html#module-sequenza.izip)
  + [sequenza.wig](api.html#module-sequenza.wig)
  + [sequenza.fasta](api.html#module-sequenza.fasta)
  + [sequenza.pileup](api.html#module-sequenza.pileup)
  + [sequenza.samtools](api.html#module-sequenza.samtools)
  + [sequenza.seqz](api.html#module-sequenza.seqz)
  + [sequenza.vcf](api.html#module-sequenza.vcf)

[Next](install.html "Installation")

---

© Copyright 2016, Francesco Favero
Revision `628964e0`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).