[JASS](index.html)

Contents:

* [What is JASS: A python package to perform Multi-trait GWAS](about.html)
* [Installation](install.html)
* Data preparation
  + [How to generate input data for JASS](#how-to-generate-input-data-for-jass)
    - [Option 1 Nextflow pipeline:](#option-1-nextflow-pipeline)
    - [Option 2 Prepare input data using the JASS pre-processing Python package:](#option-2-prepare-input-data-using-the-jass-pre-processing-python-package)
  + [JASS input data](#jass-input-data)
    - [GWAS description](#gwas-description)
    - [GWAS results files](#gwas-results-files)
    - [Covariance file (OPTIONAL)](#covariance-file-optional)
    - [Region file](#region-file)
  + [Data imputation (optional)](#data-imputation-optional)
  + [Creation of the JASS inittable](#creation-of-the-jass-inittable)
* [Compute Multi-trait GWAS with JASS](generating_joint_analysis.html)
* [References](bibliography.html)
* [Command line reference](command_line_usage.html)
* [Developer documentation](develop.html)

[JASS](index.html)

* Data preparation
* [Edit on GitLab](https://gitlab.pasteur.fr/statistical-genetics/jass/blob/master/doc/source/data_import.rst)

---

# Data preparation[](#data-preparation "Permalink to this heading")

JASS requires GWAS summary statistics to be harmonized and formatted (see **JASS input data** section below) .
:   We advice the user to follow the methods provided in the **first section** of this page to harmonize their data.
    The **second section** describes the different input data required by JASS.

The **third section** describes an imputation tool compatible with JASS input format (optional preparation step).
Finally, we provided a command line example to assemble input data into the JASS inittable (the database of curated summary statistics used to perform the multi-trait GWAS)

## How to generate input data for JASS[](#how-to-generate-input-data-for-jass "Permalink to this heading")

### Option 1 Nextflow pipeline:[](#option-1-nextflow-pipeline "Permalink to this heading")

Preprocessing steps for JASS (data harmonisation and imputation)have been gathered into a Nextflow pipeline : [JASS pipeline Suite](https://gitlab.pasteur.fr/statistical-genetics/jass_suite_pipeline).
While this option might have stronger installation requirements, it ensure reproducibility by leveraging docker containers (fixed version of JASS and accompanying packages).
It will also be much more efficient is you a large number of heterogeneous data to handle and a computing cluster available.

### Option 2 Prepare input data using the JASS pre-processing Python package:[](#option-2-prepare-input-data-using-the-jass-pre-processing-python-package "Permalink to this heading")

To standardize the format of the input GWAS datasets, you can use the [JASS Pre-processing package](https://gitlab.pasteur.fr/statistical-genetics/JASS_Pre-processing). The [JASS Pre-processing documentation](http://statistical-genetics.pages.pasteur.fr/JASS_Pre-processing/) details the use of this tool.

## JASS input data[](#jass-input-data "Permalink to this heading")

JASS data, from Multi-trait GWAS can be computed, are stored in an HDF5 file.
This file can be created with the procedure create-inittable. This procedure needs the following input files to complete:

### GWAS description[](#gwas-description "Permalink to this heading")

This file that must contain the following columns and tab-separated:

| Consortium | Outcome | FullName | Type | Nsample | Ncase | Ncontrol | Reference | ReferenceLink | dataLink | internalDataLink |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GIANT | HIP | Hip Circumference | Anthropometry | 142762 |  |  | Shungin et al. 2015 | url to reference | url to data | local path to data |

The Consortium and outcome names must correspond to the name of the summary statistic files and covariance columns as describe in the following section. Nsample, Ncase and Ncontrol can be left blank. The last four columns
can also be left blank if the user doesn't want to run JASS on a server.

### GWAS results files[](#gwas-results-files "Permalink to this heading")

GWAS results files in the tabular format by chromosome (tab separated) *all in the same folder* with the following columns with the same header:

| rsID | pos | A0 | A1 | Z |
| --- | --- | --- | --- | --- |
| rs6548219 | 30762 | A | G | -1.133 |

**A0** is the effect allele.
The name of file *MUST* follow this pattern : "z\_{CONSORTIUM}\_{TRAIT}\_chr{chromosome number}.txt".
The consortium and the trait must be capitalized and must *NOT* contain \_ .

### Covariance file (OPTIONAL)[](#covariance-file-optional "Permalink to this heading")

A covariance file that corresponds to the covariance between traits under H0. This file is a tab-separated tabular file.

We recommend that this covariance file to be computed using the [LDScore regression](https://gitlab.pasteur.fr/statistical-genetics/jass_suite_pipeline#running-the-ldsc-regression-covariance-step)
However, this step can be fastidious and if not provided by the user, a matrix will be inferred from low signal zscore.

The traits names (columns and row names of the matrix) must correspond to the summary statistic file names: `z_{CONSORTIUM}_{TRAIT}`. You can see below an example subset that illustrates this format:

```
PHE C4D_CHD CARDIOGRAM_CHD  DIAGRAM_T2D GABRIEL_ASTHMA  GEFOS_BMD-FOREARM   GEFOS_BMD-NECK
C4D_CHD 1.0593  0.0351  0.0548  0.085   -0.0061
CARDIOGRAM_CHD  0.0351  1.0256  0.0631  0.025   -0.0002
DIAGRAM_T2D 0.0548  0.0631  1.0136  0.0382  0.0048
GABRIEL_ASTHMA  0.085   0.025   0.0382  1.0134  -0.0104
GEFOS_BMD-FOREARM   -0.0061     -0.0002     0.0048  -0.0104     1.0123
```

### Region file[](#region-file "Permalink to this heading")

Region file of approximately independant LD regions to the BED file. For european ancestry and grch37/hg19, we suggest to use the regions as defined by [[BP15](bibliography.html#id6 "Tomaz Berisa and Joseph K. Pickrell. Approximately independent linkage disequilibrium blocks in human populations. Bioinformatics, 32(2):283–285, 2015. doi:10.1093/bioinformatics/btv546.")], which is already available in [the data folder of the package](https://gitlab.pasteur.fr/statistical-genetics/jass/blob/master/data/fourier_ls-all.bed).

> For grch38, we computed these regions for the five superpopulation available in 1000G using Big SNPR [[Pri21](bibliography.html#id8 "Florian Privé. Optimal linkage disequilibrium splitting. Bioinformatics, 38(1):255-256, 07 2021. URL: https://doi.org/10.1093/bioinformatics/btab519, arXiv:https://academic.oup.com/bioinformatics/article-pdf/38/1/255/41891000/btab519.pdf, doi:10.1093/bioinformatics/btab519.")]. The corresponding files are stored at <<https://gitlab.pasteur.fr/statistical-genetics/jass_suite_pipeline/-/tree/pipeline_ancestry/input_files>>`\_.

| chr | start | stop |
| --- | --- | --- |
| chr1 | 10583 | 1892607 |

> For inferring approximately independant LD regions from your own panel we recommend using <https://privefl.github.io/bigsnpr/> .
> See [[Pri21](bibliography.html#id8 "Florian Privé. Optimal linkage disequilibrium splitting. Bioinformatics, 38(1):255-256, 07 2021. URL: https://doi.org/10.1093/bioinformatics/btab519, arXiv:https://academic.oup.com/bioinformatics/article-pdf/38/1/255/41891000/btab519.pdf, doi:10.1093/bioinformatics/btab519.")] on the matter.

## Data imputation (optional)[](#data-imputation-optional "Permalink to this heading")

using [RAISS](https://statistical-genetics.pages.pasteur.fr/raiss/).
See [[JSPA19](bibliography.html#id9 "Hanna Julienne, Huwenbo Shi, Bogdan Pasaniuc, and Hugues Aschard. RAISS: robust and accurate imputation from summary statistics. Bioinformatics, 35(22):4837-4839, 06 2019. URL: https://doi.org/10.1093/bioinformatics/btz466, arXiv:https://academic.oup.com/bioinformatics/article-pdf/35/22/4837/30706731/btz466.pdf, doi:10.1093/bioinformatics/btz466.")] on the method details.

## Creation of the JASS inittable[](#creation-of-the-jass-inittable "Permalink to this heading")

Once, GWAS summary statistics are harmonized, they are integrated into
one file by the using jass command line (see detail in command line usage). Note that GWAS results must be provided through name pattern (ruled used by Unix Shell) corresponding to the file to be included.

```
jass create-inittable --input-data-path "harmonized_GWAS_files/*.txt" --init-covariance-path $path1/Covariance_matrix_H0.csv --regions-map-path $path2/Region_file.bed --description-file-path $path3/Data_summary.csv --init-table-path $path4/init_table_EUR_not_imputed.hdf5
```

[Previous](install.html "Installation")
[Next](generating_joint_analysis.html "Compute Multi-trait GWAS with JASS")

---

© Copyright 2018, Hugues Aschard, Vi.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).