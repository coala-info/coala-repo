[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](genotypes.html)
* [Haplotypes](haplotypes.html)
* Phenotypes and Covariates
  + [Phenotype file format](#phenotype-file-format)
  + [Covariate file format](#covariate-file-format)
* [Linkage disequilibrium](ld.html)
* [Summary Statistics](linear.html)
* [Causal SNPs](snplist.html)
* [Breakpoints](breakpoints.html)
* [Sample Info](sample_info.html)
* [Models](models.html)
* [Maps](maps.html)

Commands

* [simgenotype](../commands/simgenotype.html)
* [simphenotype](../commands/simphenotype.html)
* [karyogram](../commands/karyogram.html)
* [transform](../commands/transform.html)
* [index](../commands/index.html)
* [clump](../commands/clump.html)
* [ld](../commands/ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* Phenotypes and Covariates
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/phenotypes.rst)

---

# Phenotypes and Covariates[](#phenotypes-and-covariates "Link to this heading")

## Phenotype file format[](#phenotype-file-format "Link to this heading")

Phenotypes are expected to follow [the PLINK2 .pheno file format](https://www.cog-genomics.org/plink/2.0/input#pheno). This is a
tab-separated format where the first column corresponds to the sample ID, and subsequent columns contain each of your phenotypes.

The first line of the file corresponds with the header and must begin with `#IID`.
The names of each of your phenotypes belong in the subsequent columns of the header.

See [tests/data/simple.pheno](https://github.com/cast-genomics/haptools/blob/main/tests/data/simple.pheno) for an example of a phenotype file:

```
#IID    height  bmi
HG00096 1       3
HG00097 1       6
HG00099 2       8
HG00100 2       1
HG00101 0       4
```

## Covariate file format[](#covariate-file-format "Link to this heading")

Covariates follow the same format as phenotypes.

See [tests/data/simple.covar](https://github.com/cast-genomics/haptools/blob/main/tests/data/simple.covar) for an example of a covariate file:

```
#IID    sex     age
HG00096 0       4
HG00097 1       20
HG00099 1       33
HG00100 0       15
HG00101 0       78
```

[Previous](haplotypes.html "Haplotypes")
[Next](ld.html "Linkage disequilibrium")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).