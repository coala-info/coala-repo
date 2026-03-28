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

## Publications

Original samtools variant calling (`bcftools call -c`)
:   Li H. A statistical framework for SNP calling, mutation discovery, association mapping and
    population genetical parameter estimation from sequencing data. *Bioinformatics* (2011) 27(21)
    2987-93.
    [link](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198575)

BAQ calculation
:   Li H. Improving SNP discovery by base alignment quality. *Bioinformatics* (2011) 27(8):1157-8.
    [link](http://www.ncbi.nlm.nih.gov/pubmed/21320865)

Detecting runs of homozygozity (`bcftools roh`)
:   Narasimhan V, Danecek P, Scally A, Xue Y, Tyler-Smith C, and Durbin R. BCFtools/RoH: a
    hidden Markov model approach for detecting autozygosity from next-generation sequencing data.
    *Bioinformatics* (2016) 32(11) 1749-51
    [link](https://pubmed.ncbi.nlm.nih.gov/26826718)

CNV calling (`bcftools cnv` and `bcftools polysomy`)
:   Danecek P, McCarthy SA, HipSci Consortium, and Durbin R.
    A Method for Checking Genomic Integrity in Cultured Cell Lines from SNP Genotyping Data, *PLoS One* (2016) 11(5) e0155014
    [link](https://pubmed.ncbi.nlm.nih.gov/27176002)

Consequence calling (`bcftools csq`)
:   Danecek P, McCarthy SA.
    BCFtools/csq: Haplotype-aware variant consequences. *Bioinformatics* (2017) 33(13) 2037-39
    [link](https://pubmed.ncbi.nlm.nih.gov/28205675)

All of BCFtools, file manipuplation, `-m` calling, etc
:   Danecek P, Bonfield JK, *et al*. Twelve years of SAMtools and BCFtools. *Gigascience* (2021) 10(2):giab008
    [link](https://pubmed.ncbi.nlm.nih.gov/33590861)

### Various math notes

* Multiallelic calling (`bcftools call -m`) [pdf](http://samtools.github.io/bcftools/call-m.pdf)
* BCFtools/trio-dnm calling (`bcftools +trio-dnm2`) [pdf](http://samtools.github.io/bcftools/trio-dnm.pdf)
* SAMtools math notes [pdf](http://samtools.github.io/bcftools/samtools.pdf)
* SegBias calculation [pdf](http://samtools.github.io/bcftools/rd-SegBias.pdf)

### Feedback

We welcome your feedback, please help us improve this page by
either opening an [issue on github](https://github.com/samtools/bcftools/issues) or [editing it directly](https://github.com/samtools/bcftools/tree/gh-pages/howtos) and sending
a pull request.