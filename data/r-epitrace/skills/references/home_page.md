EpiTrace

Main

* [About EpiTrace](about.html)
* [Installation](installation.html)
* [Release Notes](release_notes.html)
* [Interpreting EpiTrace Age](interpreting_epitrace_age.html)
* [Understanding Bulk vs Single-Cell EpiTrace Age](interpreting_epitrace_age.html#understanding-bulk-vs-single-cell-epitrace-age)
* [Why the Difference?](interpreting_epitrace_age.html#why-the-difference)
* [How EpiTrace Functions Handle This](interpreting_epitrace_age.html#how-epitrace-functions-handle-this)
* [Practical Examples](interpreting_epitrace_age.html#practical-examples)
* [When to Use Transformation](interpreting_epitrace_age.html#when-to-use-transformation)
* [Common Pitfalls](interpreting_epitrace_age.html#common-pitfalls)
* [References](interpreting_epitrace_age.html#references)
* [Clock Reference Options](clock_reference_options.html)
* [Available Clock Sets](clock_reference_options.html#available-clock-sets)
* [Which Clock Should You Use?](clock_reference_options.html#which-clock-should-you-use)
* [Why is solo\_WCGW Not Used in Tutorials?](clock_reference_options.html#why-is-solo-wcgw-not-used-in-tutorials)
* [When to Consider solo\_WCGW](clock_reference_options.html#when-to-consider-solo-wcgw)
* [Example Comparative Analysis](clock_reference_options.html#example-comparative-analysis)
* [References](clock_reference_options.html#references)
* [Known issues and workarounds](using_notes.html)
* [References](references.html)

Tutorials

* [Overview of tutorial](tutorial_overview.html)
* [Most simple example with bulk ATAC](Bulk_ATAC.html)
* [Chemical induction of pluripotency](scATAC_cIPSC.html)
* [Mouse T cell aging in chronic viral infection](MSscATAC.html)
* [Single cell age in fly development](scATAC_drosophila.html)
* [Hematopoietic cell expansion potential](mtscATAC_CD34.html)

Functions

* [Init\_Peakset](Init_Peakset.html)
* [Init\_Matrix](Init_Matrix.html)
* [EpiTrace\_prepare\_object](EpiTrace_prepare_object.html)
* [EpiTraceAge](EpiTraceAge.html)
* [RunEpiTraceAge](RunEpiTraceAge.html)
* [EpiTraceAge\_Convergence](EpiTraceAge_Convergence.html)
* [AssociationOfPeaksToAge](AssociationOfPeaksToAge.html)
* [RunEpiTracePhylogeny](RunEpiTracePhylogeny.html)

EpiTrace

* EpiTrace - Estimating cell age from single-cell ATAC data
* [View page source](_sources/index.rst.txt)

---

# EpiTrace - Estimating cell age from single-cell ATAC data[](#epitrace-estimating-cell-age-from-single-cell-atac-data "Link to this heading")

[![_images/Cortex.svg](_images/Cortex.svg)](_images/Cortex.svg)

**EpiTrace** is an R package for estimating cell age from single-cell ATAC-seq data. It takes an approximation approach to infer the relative mitosis (replicative) age – the number of mitosis a cell has undergone. It does so by measuring the total opened reference “clock-like” genomic loci. On these loci, heterogeneity of chromatin accessibility decreases as the cell ages. The chromatin accessibility-based mitosis age inferred by EpiTrace adds a time domain to the single-cell sequencing data. It complements somatic mutation, RNA velocity and stemness predictions to predict the cell evolution trajectory with improved precision and power [[Xiao *et al.*, 2024](references.html#id15 "Yu Xiao, Wan Jin, Lingao Ju, Jie Fu, Gang Wang, Mengxue Yu, Fangjin Chen, Kaiyu Qian, Xinghuan Wang, and Yi Zhang. Tracking single-cell evolution using clock-like chromatin accessibility loci. Nat Biotech, 2024. URL: https://doi.org/10.1038/s41587-024-02241-z, doi:10.1038/s41587-024-02241-z.")].

## EpiTrace’s key applications[](#epitrace-s-key-applications "Link to this heading")

* estimate the mitosis age of single cell or bulk sample.
* identify age-dependent biological events including shifts in chromatin accessibility, transcription factor activity, and transcriptomic changes.
* timing developmental and mutational events.

## Citing EpiTrace[](#citing-epitrace "Link to this heading")

If you include or rely on EpiTrace when publishing research, please adhere to the
following citation guide:

**EpiTrace algorithm and the ClockDML**

If you use the *algorithm* and/or *ClockDML* (*clock-like differential methylated loci*), including cross-species lift-over clock-like loci generated from the ClockDML, cite

```
@article {Xiao2024,
    author = {Xiao, Yu and Jin, Wan and Ju, Lingao and Fu, Jie and Wang, Gang and Yu, Mengxue and Chen, Fangjin and Qian, Kaiyu and Wang, Xinghuan and Zhang, Yi},
    title = {Tracking single-cell evolution using clock-like chromatin accessibility loci},
    year = {2024},
    doi = {10.1038/s41587-024-02241-z},
    URL = {https://doi.org/10.1038/s41587-024-02241-z},
    journal = {Nat Biotech}}
```

**G-quadruplex region**

If you use the *G-quadruplex region* for cell/sample age estimation, cite

```
@article {Jin2024.01.06.574476,
    author = {Wan Jin and Jing Zheng and Yu Xiao and Lingao Ju and Fangjin Chen and Jie Fu and Hui Jiang and Yi Zhang},
    title = {A universal molecular mechanism driving aging},
    elocation-id = {2024.01.06.574476},
    year = {2024},
    doi = {10.1101/2024.01.06.574476},
    publisher = {Cold Spring Harbor Laboratory},
    URL = {https://www.biorxiv.org/content/early/2024/01/06/2024.01.06.574476},
    eprint = {https://www.biorxiv.org/content/early/2024/01/06/2024.01.06.574476.full.pdf},
    journal = {bioRxiv}}
```

## Support[](#support "Link to this heading")

Have a question or would like to start a new discussion? Found a bug or would like to see a feature implemented? Feel free to submit an
[issue](https://github.com/MagpiePKU/EpiTrace/issues/new).
Your help to improve EpiTrace is highly appreciated.

## Planned updates[](#planned-updates "Link to this heading")

Tutorial on (1) using G-quadruplex as reference clock-like loci, and (2) timing mutational event during oncogenesis.

[Next](about.html "About EpiTrace")

---

© Copyright <2024>, Yi Zhang, Euler Technology.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).