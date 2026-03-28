[whatshap](index.html)

* [Installation](installation.html)
* [User guide](guide.html)
* Questions and Answers
* [Contributing](develop.html)
* [Various notes](notes.html)
* [How to cite](howtocite.html)
* [Changes](changes.html)

[whatshap](index.html)

* Questions and Answers
* [View page source](_sources/faq.rst.txt)

---

# Questions and Answers[](#questions-and-answers "Link to this heading")

> * **Can WhatsHap use a reference panel?** Reference panels are used by population-based phasers (like Beagle or ShapeIt). Although we are considering integrating this, WhatsHap cannot take advantage of reference panels right now. In case you have population data, we suggest to produce a population-based phasing (using [Beagle](https://faculty.washington.edu/browning/beagle/beagle.html), [ShapeIt](https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.html), etc.) and a read-based phasing using WhatsHap separately and then compare/integrate results in a postprocessing step.
> * **Will Illumina data lead to a good read-based phasing?** Illumina paired-end data is not ideal for read-based phasing, since most pairs of heterozygous SNPs will not be bridged by a read pair. However, WhatsHap will attempt to produce as long haplotype blocks as possible. Running WhatsHap will hence tell you how phase-informative your input data is. Just take a look at the number (and sizes) of produced haplotype blocks.
> * **How large can/should a pedigree be for pedigree-aware read-based phasing (i.e. using option** `--ped` **)?** The pedigree mode in WhatsHap is intended for intermediate-size pedigrees. The runtime of the core phasing step will be linear in \(2^{2t}\), where \(t\) is the number of trio relationships (= number of children) in your pedigree. We do not recommend to use pedigrees with \(t>5\). For such pedigrees, read-data is unnecessary in most cases anyway and a very high-quality phasing can be obtained by genetic haplotyping methods (like [MERLIN](http://csg.sph.umich.edu/abecasis/Merlin/tour/haplotyping.html)).

[Previous](guide.html "User guide")
[Next](develop.html "Contributing")

---

© Copyright 2014.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).