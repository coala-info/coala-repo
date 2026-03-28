[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](genotypes.html)
* [Haplotypes](haplotypes.html)
* [Phenotypes and Covariates](phenotypes.html)
* [Linkage disequilibrium](ld.html)
* Summary Statistics
  + [Examples](#examples)
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

* Summary Statistics
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/linear.rst)

---

# Summary Statistics[](#summary-statistics "Link to this heading")

Linear files (`.linear` files) store summary statistics from a linear model. We follow the [PLINK2 .glm.linear file format](https://www.cog-genomics.org/plink/2.0/formats#glm_linear) and use the following columns.

| Name | Type | Description |
| --- | --- | --- |
| CHROM | string | The name of the chromosome to which this SNP belongs (ex: 1) |
| POS | integer | The position of this SNP on the chromosome (ex: 10114) |
| ID | string | A unique identifier for this SNP in the file (ex: ‘rs1234’) |
| P | float | The p-value assigned to this SNP via association testing (ex: 43.078) |

## Examples[](#examples "Link to this heading")

See [tests/data/test\_snpstats.linear](https://github.com/cast-genomics/haptools/blob/main/tests/data/test_snpstats.linear) for an example of a short `.linear` file:

```
#CHROM  POS     ID      REF     ALT     A1      TEST    OBS_CT  BETA    SE      T_STAT  P       ERRCODE
1       10114   1:10114:T:C     T       C       C       ADD     2504    -0.010774       1.0004  -0.09   0.99    .
1       10116   1:10116:A:G     A       G       A       ADD     2504    -0.436  1.00034 -0.345  0.2345  .
1       10117   1:10117:C:A     C       A       A       ADD     2504    1.50    0.45    2.5     0.0005  .
1       10122   1:10122:A:G     A       G       A       ADD     2504    1.00    0.001   42.0    1.26e-102       .
```

[Previous](ld.html "Linkage disequilibrium")
[Next](snplist.html "Causal SNPs")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).