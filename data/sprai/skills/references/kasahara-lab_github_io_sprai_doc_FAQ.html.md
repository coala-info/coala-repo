### Navigation

* [index](genindex.html "General Index")
* [next](Contact.html "Contact") |
* [previous](Download.html "Download The Latest Version") |
* [sprai 0.9.x documentation](index.html) »
* FAQ

# FAQ[¶](#faq "Link to this heading")

## Q. How much sequencing coverage depth would be required?[¶](#q-how-much-sequencing-coverage-depth-would-be-required "Link to this heading")

A. It depends. If you can afford to sequence 100x of the estimated genome size, that would be the best.
When the genome is large (e.g., 400Mbp or larger), you may reduce the depth to 30x or 40x.
If you want to sequence less than 20x, you might consider hybrid assembly in which you combine Illumina reads and PacBio reads.
Higher sequencing depth than 200x does not usually improve the assembled result.
Note that the sequencing depth itself is not a good predictor of the assembly result.
What matters is the sequencing depth of reads longer than repetitive elements in a target genome.
If reads are short and only few of them are longer than some threshold, namely 2kbp (for bacteria), even 100x data would be beated by 20x data with longer reads.
We strongly recommend the use of the size selection protocol using Blue Pippin, which is highly recommended by PacBio.

## Q. How large genomes can Sprai assemble?[¶](#q-how-large-genomes-can-sprai-assemble "Link to this heading")

A. The largest genome we tested is 2Gbp, but there is no theoretical limit for Sprai (although you need more computational resources as the target genome gets larger).
Error-correction process is highly scalable, so most probably, Celera assembler would be the bottleneck.

## Q. Can Sprai assemble both PacBio CLRs and other reads such as Illumina short reads?[¶](#q-can-sprai-assemble-both-pacbio-clrs-and-other-reads-such-as-illumina-short-reads "Link to this heading")

A. No. Sprai is designed to take only PacBio long reads.
If you want to combine both reads, you may first correct errors in PacBio long reads by Sprai, and then you can use whatever genome assembler that accepts both error-corrected long reads and Illumina reads.

## Q. Why is the number of the output nucleotides by Sprai smaller than the number of the nucleotides in the input file?[¶](#q-why-is-the-number-of-the-output-nucleotides-by-sprai-smaller-than-the-number-of-the-nucleotides-in-the-input-file "Link to this heading")

A. Sprai trims nucleotides that will not be useful for subsequent analysis such as de novo assembly or mapping to a reference genome. Such nucleotides include low coverage regions (valid\_depth paramter; default = 4), regions of too short reads (valid read length: default = 500 bp), and both ends of reads (default = 42 bp).
The exact ratio of such nucleotides depends on input data, but however, it usually falls between 10% to 50% in our experience.

### [Table of Contents](index.html)

* FAQ
  + [Q. How much sequencing coverage depth would be required?](#q-how-much-sequencing-coverage-depth-would-be-required)
  + [Q. How large genomes can Sprai assemble?](#q-how-large-genomes-can-sprai-assemble)
  + [Q. Can Sprai assemble both PacBio CLRs and other reads such as Illumina short reads?](#q-can-sprai-assemble-both-pacbio-clrs-and-other-reads-such-as-illumina-short-reads)
  + [Q. Why is the number of the output nucleotides by Sprai smaller than the number of the nucleotides in the input file?](#q-why-is-the-number-of-the-output-nucleotides-by-sprai-smaller-than-the-number-of-the-nucleotides-in-the-input-file)

#### Previous topic

[Download The Latest Version](Download.html "previous chapter")

#### Next topic

[Contact](Contact.html "next chapter")

### This Page

* [Show Source](_sources/FAQ.rst.txt)

### Quick search

### Navigation

* [index](genindex.html "General Index")
* [next](Contact.html "Contact") |
* [previous](Download.html "Download The Latest Version") |
* [sprai 0.9.x documentation](index.html) »
* FAQ

© Copyright 2013, Takamasa Imai.
Created using [Sphinx](https://www.sphinx-doc.org/) 7.3.7.