[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](genotypes.html)
* [Haplotypes](haplotypes.html)
* [Phenotypes and Covariates](phenotypes.html)
* Linkage disequilibrium
  + [Examples](#examples)
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

* Linkage disequilibrium
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/ld.rst)

---

# Linkage disequilibrium[](#linkage-disequilibrium "Link to this heading")

Linkage disequilibrium for SNPs can be specified in a tab-delimited format similar to [PLINK 1.9’s .ld file format](https://www.cog-genomics.org/plink/1.9/formats#ld). Our format contains only a subset of the full set of columns from PLINK’s:

| Name | Type | Description |
| --- | --- | --- |
| CHR | string | The name of the chromosome to which this SNP belongs (ex: 1) |
| BP | integer | The position of this SNP on the chromosome (ex: 10114) |
| SNP | string | A unique identifier for this SNP in the file (ex: ‘rs1234’) |
| R | float | Pearson’s correlation coefficient between the variant and some *TARGET* (ex: 0.42) |

## Examples[](#examples "Link to this heading")

```
CHR   BP      SNP     R
19    45411941        rs429358        0.999
19    45411947        rs11542041      0.027
19    45411962        rs573658040     -0.012
19    45411965        rs543363163     -0.012
19    45412006        rs563140413     -0.012
19    45412007        rs531939919     -0.012
19    45412040        rs769455        0.006
19    45412079        rs7412  -0.098
```

[Previous](phenotypes.html "Phenotypes and Covariates")
[Next](linear.html "Summary Statistics")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).