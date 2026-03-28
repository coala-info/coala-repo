[JASS](index.html)

Contents:

* What is JASS: A python package to perform Multi-trait GWAS
* [Installation](install.html)
* [Data preparation](data_import.html)
* [Compute Multi-trait GWAS with JASS](generating_joint_analysis.html)
* [References](bibliography.html)
* [Command line reference](command_line_usage.html)
* [Developer documentation](develop.html)

[JASS](index.html)

* What is JASS: A python package to perform Multi-trait GWAS
* [Edit on GitLab](https://gitlab.pasteur.fr/statistical-genetics/jass/blob/master/doc/source/about.rst)

---

# What is JASS: A python package to perform Multi-trait GWAS[](#what-is-jass-a-python-package-to-perform-multi-trait-gwas "Permalink to this heading")

JASS is a Python package that handles the computation of joint statistics over sets of selected GWAS results through a command-line tool.

More precisely, users can perform multi-trait GWAS and display static plots of the results on their own data through the command-line interface. The functionality of this package can be explored on a web server, <https://jass.pasteur.fr/>, which allows users to perform multi-trait GWAS on a database of 184 summary statistics.

In this documentation, we cover the steps required for installing the software and illustrate its usage through examples.

We also briefly describe in the next section the pre-processing of raw GWAS data, which can be performed through a companion [Nextflow pipeline provided](https://gitlab.pasteur.fr/statistical-genetics/jass_suite_pipeline) alongside the JASS package.

For method details and applications, check out our publications related to JASS or its accompanying packages (RAISS).

JASS application paper [[JLM+21](bibliography.html#id2 "Hanna Julienne, Vincent Laville, Zachary R McCaw, Zihuai He, Vincent Guillemot, Carla Lasry, Andrey Ziyatdinov, Cyril Nerin, Amaury Vaysse, Pierre Lechat, and others. Multitrait gwas to connect disease variants and biological mechanisms. PLoS genetics, 17(8):e1009713, 2021.")]

Study on the statistical power of JASS [[SMenagerB+24](bibliography.html#id4 "Yuka Suzuki, Hervé Ménager, Bryan Brancotte, Raphaël Vernet, Cyril Nerin, Christophe Boetto, Antoine Auvergne, Christophe Linhard, Rachel Torchet, Pierre Lechat, and others. Trait selection strategy in multi-trait gwas: boosting snp discoverability. Human Genetics and Genomics Advances, 2024.")]

JASS computational architecture [[JLG+20](bibliography.html#id3 "Hanna Julienne, Pierre Lechat, Vincent Guillemot, Carla Lasry, Chunzi Yao, Robinson Araud, Vincent Laville, Bjarni Vilhjalmsson, Hervé Ménager, and Hugues Aschard. Jass: command line and web interface for the joint analysis of gwas results. NAR Genomics and Bioinformatics, 2(1):lqaa003, 2020.")]

RAISS [[JSPA19](bibliography.html#id9 "Hanna Julienne, Huwenbo Shi, Bogdan Pasaniuc, and Hugues Aschard. RAISS: robust and accurate imputation from summary statistics. Bioinformatics, 35(22):4837-4839, 06 2019. URL: https://doi.org/10.1093/bioinformatics/btz466, arXiv:https://academic.oup.com/bioinformatics/article-pdf/35/22/4837/30706731/btz466.pdf, doi:10.1093/bioinformatics/btz466.")]

[Previous](index.html "JASS documentation")
[Next](install.html "Installation")

---

© Copyright 2018, Hugues Aschard, Vi.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).