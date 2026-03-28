[adVNTR](index.html)

latest

* FAQ
  + [How do I cite adVNTR?](#how-do-i-cite-advntr)
  + [Can adVNTR work with repeating units that are shorter than 6bp?](#can-advntr-work-with-repeating-units-that-are-shorter-than-6bp)
  + [Can I run adVNTR to study expansion in other organisms?](#can-i-run-advntr-to-study-expansion-in-other-organisms)
  + [What sequencing platforms does adVNTR support?](#what-sequencing-platforms-does-advntr-support)
* [Installation](installation.html)
* [Quick Start](quickstart.html)
* [Tutorial](tutorial.html)

[adVNTR](index.html)

* [Docs](index.html) »
* FAQ
* [Edit on GitHub](https://github.com/mehrdadbakhtiari/adVNTR/blob/master/docs/faq.rst)

---

# FAQ[¶](#faq "Permalink to this headline")

* [How do I cite adVNTR?](#how-do-i-cite-advntr)
* [Can adVNTR work with repeating units that are shorter than 6bp?](#can-advntr-work-with-repeating-units-that-are-shorter-than-6bp)
* [Can I run adVNTR to study expansion in other organisms?](#can-i-run-advntr-to-study-expansion-in-other-organisms)
* [What sequencing platforms does adVNTR support?](#what-sequencing-platforms-does-advntr-support)

## [How do I cite adVNTR?](#id2)[¶](#how-do-i-cite-advntr "Permalink to this headline")

> If you found adVNTR useful, we would appreciate it if you could cite our manuscript describing adVNTR:
>
> Bakhtiari, M., Shleizer-Burko, S., Gymrek, M., Bansal, V. and Bafna, V., 2018. [Targeted genotyping of variable number tandem repeats with adVNTR](https://genome.cshlp.org/content/28/11/1709/). Genome Research, 28(11), pp.1709-1719.

## [Can adVNTR work with repeating units that are shorter than 6bp?](#id3)[¶](#can-advntr-work-with-repeating-units-that-are-shorter-than-6bp "Permalink to this headline")

> Tandem repeats with period below 6bp are classified as Short Tandem Repeats (STRs). Although adVNTR can detect STRs
> expansions, we do not recommend to use it on STRs.

## [Can I run adVNTR to study expansion in other organisms?](#id4)[¶](#can-i-run-advntr-to-study-expansion-in-other-organisms "Permalink to this headline")

> You can run adVNTR for other organisms if you add custom VNTR to its database. However, it always returns diploid
> RU counts for the number of repeats and it is expected to get homozygous RU counts on haploid organisms.

## [What sequencing platforms does adVNTR support?](#id5)[¶](#what-sequencing-platforms-does-advntr-support "Permalink to this headline")

> adVNTR is designed to analyze **Illumina** or **PacBio** sequencing data. We generally do not recommend to use it on
> sequencing data from other technologies as their error model is different.

[Next](installation.html "Installation")
 [Previous](description.html "<no title>")

---

© Copyright 2018, Mehrdad Bakhtiari
Revision `87ac49e4`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).