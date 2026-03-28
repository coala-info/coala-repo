[sequenza-utils](index.html)

latest

* [Installation](install.html)
* [Command line interface](commands.html)
* [User cookbook](guide.html)

* API library interface
  + [sequenza.izip](#module-sequenza.izip)
  + [sequenza.wig](#module-sequenza.wig)
  + [sequenza.fasta](#module-sequenza.fasta)
  + [sequenza.pileup](#module-sequenza.pileup)
  + [sequenza.samtools](#module-sequenza.samtools)
  + [sequenza.seqz](#module-sequenza.seqz)
  + [sequenza.vcf](#module-sequenza.vcf)

[sequenza-utils](index.html)

* [Docs](index.html) »
* API library interface
* [Edit on Bitbucket](https://bitbucket.org/sequenzatools/sequenza-utils/src/master/docs/api.rst?mode=view)

---

# API library interface[¶](#api-library-interface "Permalink to this headline")

## sequenza.izip[¶](#module-sequenza.izip "Permalink to this headline")

*class* `sequenza.izip.``zip_coordinates`(*item1*, *item2*)[[source]](_modules/sequenza/izip.html#zip_coordinates)[¶](#sequenza.izip.zip_coordinates "Permalink to this definition")
:   Merge two object that have coordinate chromosome/position.
    The format of the objects must be a tuple with (coordinates, data)
    where coordinate is a tuple with chromosome,position\_start, position\_end
    and data is a tuple with the data. The data of the two object will be
    merged for matching lines.
    For the first object only the start coordinate is taken into account.

`sequenza.izip.``zip_fast`(*item1*, *item2*)[[source]](_modules/sequenza/izip.html#zip_fast)[¶](#sequenza.izip.zip_fast "Permalink to this definition")
:   Use the native implementation of the heapq algorithm to sort
    and merge files chromosome-coordinate ordered.
    It assumes that the two files are position ordered and both
    files have the same chromosome order.
    It differs from zip\_coordinates by the fact that this return
    all the position present in both files, group together the lines
    present in both

## sequenza.wig[¶](#module-sequenza.wig "Permalink to this headline")

*class* `sequenza.wig.``Wiggle`(*wig*)[[source]](_modules/sequenza/wig.html#Wiggle)[¶](#sequenza.wig.Wiggle "Permalink to this definition")
:   Read/write wiggle files as iterable objects.

*exception* `sequenza.wig.``WiggleError`(*message*)[[source]](_modules/sequenza/wig.html#WiggleError)[¶](#sequenza.wig.WiggleError "Permalink to this definition")

## sequenza.fasta[¶](#module-sequenza.fasta "Permalink to this headline")

*class* `sequenza.fasta.``Fasta`(*file*, *n=60*)[[source]](_modules/sequenza/fasta.html#Fasta)[¶](#sequenza.fasta.Fasta "Permalink to this definition")
:   Creates an iterable with genomic coordinates from a fasta file

## sequenza.pileup[¶](#module-sequenza.pileup "Permalink to this headline")

`sequenza.pileup.``acgt`(*pileup*, *quality*, *depth*, *reference*, *qlimit=53*, *noend=False*, *nostart=False*)[[source]](_modules/sequenza/pileup.html#acgt)[¶](#sequenza.pileup.acgt "Permalink to this definition")
:   Parse the mpileup format and return the occurrence of
    each nucleotides in the given positions.

`sequenza.pileup.``pileup_acgt`(*pileup*, *quality*, *depth*, *reference*, *qlimit=53*, *noend=False*, *nostart=False*)[[source]](_modules/sequenza/pileup.html#pileup_acgt)[¶](#sequenza.pileup.pileup_acgt "Permalink to this definition")
:   Yet another version of the pileup parser. Used as a template
    for the C implementation, the old function still runs slightly
    faster, to my surprise…

## sequenza.samtools[¶](#module-sequenza.samtools "Permalink to this headline")

*class* `sequenza.samtools.``bam_mpileup`(*bam*, *fasta*, *q=20*, *Q=20*, *samtools\_bin='samtools'*, *regions=[]*)[[source]](_modules/sequenza/samtools.html#bam_mpileup)[¶](#sequenza.samtools.bam_mpileup "Permalink to this definition")
:   Use samtools via subprocess and return an iterable
    object.

*class* `sequenza.samtools.``indexed_pileup`(*pileup*, *tabix\_bin='tabix'*, *regions=[]*)[[source]](_modules/sequenza/samtools.html#indexed_pileup)[¶](#sequenza.samtools.indexed_pileup "Permalink to this definition")
:   Use tabix via subprocess to slice the pileup data and return
    an iterable object

`sequenza.samtools.``program_version`(*program*)[[source]](_modules/sequenza/samtools.html#program_version)[¶](#sequenza.samtools.program_version "Permalink to this definition")
:   Parse tabix or samtools help message in attempt to
    retrieve the software version: return format: [major, minor, [\*](#id1)]

`sequenza.samtools.``tabix_seqz`(*file\_name*, *tabix\_bin='tabix'*, *seq=1*, *begin=2*, *end=2*, *skip=1*)[[source]](_modules/sequenza/samtools.html#tabix_seqz)[¶](#sequenza.samtools.tabix_seqz "Permalink to this definition")
:   Index a seqz file with tabix

## sequenza.seqz[¶](#module-sequenza.seqz "Permalink to this headline")

`sequenza.seqz.``acgt_genotype`(*acgt\_dict*, *freq\_list*, *strand\_list*, *hom\_t*, *het\_t*, *het\_f*, *bases\_list*)[[source]](_modules/sequenza/seqz.html#acgt_genotype)[¶](#sequenza.seqz.acgt_genotype "Permalink to this definition")
:   Return the alleles in the genotype

`sequenza.seqz.``unpack_data`(*data*)[[source]](_modules/sequenza/seqz.html#unpack_data)[¶](#sequenza.seqz.unpack_data "Permalink to this definition")
:   Unpack normal, tumor and gc info from the
    specific touple structure and remove redundant information

## sequenza.vcf[¶](#module-sequenza.vcf "Permalink to this headline")

`sequenza.vcf.``vcf_headline_content`(*line*)[[source]](_modules/sequenza/vcf.html#vcf_headline_content)[¶](#sequenza.vcf.vcf_headline_content "Permalink to this definition")
:   Try to get the string enclosed by “< … >” in the VCF header

`sequenza.vcf.``vcf_parse`(*vcf\_file, sample\_order='n/t', field='FORMAT', depth=['DP', 'DP'], alleles=['AD', 'AD'], preset=None*)[[source]](_modules/sequenza/vcf.html#vcf_parse)[¶](#sequenza.vcf.vcf_parse "Permalink to this definition")
:   Parse the specified tags of a vcf file to retrieve total
    and per-allele depth information.

[Previous](guide.html "User cookbook")

---

© Copyright 2016, Francesco Favero
Revision `628964e0`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).