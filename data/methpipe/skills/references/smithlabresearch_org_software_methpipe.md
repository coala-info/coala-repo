# [The Smith Lab](https://smithlabresearch.org/)

## Computational Genomics Research

Menu
[Skip to content](#content)

* [Home](https://smithlabresearch.org/)
* [Publications](https://smithlabresearch.org/publications/)
* [MethBase](https://smithlabresearch.org/software/methbase/)
* [Software](https://smithlabresearch.org/software/)
* [Login](http://smithlabresearch.org/wp-login.php)
* [GitHub](https://github.com/smithlabcode)

# MethPipe

# MethPipe: a computational pipeline for analyzing bisulfite sequencing data

The MethPipe software package is a computational pipeline for analyzing bisulfite sequencing data (WGBS and RRBS).
**Update July 2021**: MethPipe now accepts SAM input after the read-mapping phase. Our old mr format is no longer supported. For short-read bisulfite mapping, we have a new tool called [abismal](https://github.com/smithlabcode/abismal/). Download abismal-0.3.0 [here](https://github.com/smithlabcode/abismal/releases/download/v0.3.0/abismal-0.3.0.tar.gz).

## Quick start

* Download source code: [methpipe-5.0.0.tar.bz2](https://smithlabresearch.org/downloads/methpipe-5.0.0.tar.gz) ([release history](https://smithlabresearch.org/software/methpipe/methpipe-release-history/))
* Read the manual: [methpipe-manual.pdf](https://smithlabresearch.org/downloads/methpipe-manual.pdf)
* Give it a try: [Test data](https://smithlabresearch.org/downloads/methpipe-data.tar.bz2) (17MB)
* View pre-analyzed methylomes: [MethBase](https://smithlabresearch.org/software/methbase/)
* Check the latest development branch at [GitHub Repo](https://github.com/smithlabcode/methpipe/ "GitHub Repo")

### Tools

| Program | Description |
| --- | --- |
| abismal | map bisulfite treated short reads. See the [Github repo](https://github.com/smithlabcode/abismal) for more details. |
| duplicate-remover | remove duplicate reads |
| methcounts | calculate methylation level and read coverage at individual sites |
| bsrate | estimate bisulfite conversion rate |
| hmr | identify hypo-methylated regions |
| hypermr | identify hyper-methylation in plants and organisms showing mosaic methylation |
| pmd | identify large partially methylated domains |
| amrfinder | identify allele-specific methylated regions |
| roimethstat | compute methylation level by genomic region of interest |
| mlml | consistently estimate 5-mC and 5-hmC levels. See [MLML homepage](https://smithlabresearch.org/software/mlml/ "Simultaneous estimation of methylation levels"). |

Table 1: List of tools in the MethPipe package

---

## Workflow

[![Workflow for analyzing bisulfite sequencing data (WGBS)](https://smithlabresearch.org/images/methpipe-flowchart.png)](https://smithlabresearch.org/images/methpipe-flowchart.png)

Figure 1: Workflow of the MethPipe package for analyzing bisulfite sequencing datasets

---

## Contact

Please send emails to the methpipe mailing list at
methpipe@googlegroups.com if you have any questions,
suggestions or comments.

To join the mailing list, send an email to methpipe+subscribe@googlegroups.com

View previous messages at [MethPipe and MethBase Users’ Mailing List.](http://groups.google.com/group/methpipe?hl=en "MethPipe and MethBase Users' Mailling List")

## References

Song Q, Decato B, Hong E, Zhou M, Fang F, Qu J, Garvin T, Kessler M, Zhou J, Smith AD (2013) A reference methylome database and analysis pipeline to facilitate integrative and comparative epigenomics. PLOS ONE 8(12): e81148 [[PDF](https://smithlabresearch.org/papers/Song_PONE_2013.pdf)] [[Publisher Site](http://www.plosone.org/article/info%3Adoi/10.1371/journal.pone.0081148)]