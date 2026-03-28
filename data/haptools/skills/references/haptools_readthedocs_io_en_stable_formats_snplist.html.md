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
* [Summary Statistics](linear.html)
* Causal SNPs
  + [Examples](#examples)
  + [Converting to a `.hap` file](#converting-to-a-hap-file)
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

* Causal SNPs
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/snplist.rst)

---

# Causal SNPs[](#causal-snps "Link to this heading")

You can specify causal SNPs in a tab-delimited `.snplist` file. We follow [GCTA’s .snplist format](https://yanglab.westlake.edu.cn/software/gcta/#GWASSimulation) for this type of file. It has just two columns:

| Name | Type | Description |
| --- | --- | --- |
| ID | string | A unique identifier for this variant in the file (ex: ‘rs1234’) |
| BETA | float | The effect size assigned to this variant (ex: 0.08) |

Note

You should not include a header in this file. The file format does not have one.

## Examples[](#examples "Link to this heading")

Refer to [tests/data/apoe.snplist](https://github.com/cast-genomics/haptools/blob/main/tests/data/apoe.snplist) for an example containing just two SNPs.

```
rs429358        0.73
rs7412  0.30
```

## Converting to a `.hap` file[](#converting-to-a-hap-file "Link to this heading")

The capabilities of the `.snplist` format are limited. For example, it does not allow users to specify a causal allele (REF vs ALT) for each SNP. You can use [the haptools API to upgrade to a .hap file](../api/examples.html#api-examples-snps2hap) if needed.

[Previous](linear.html "Summary Statistics")
[Next](breakpoints.html "Breakpoints")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).