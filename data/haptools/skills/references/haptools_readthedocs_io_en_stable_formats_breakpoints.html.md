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
* [Causal SNPs](snplist.html)
* Breakpoints
  + [Examples](#examples)
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

* Breakpoints
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/breakpoints.rst)

---

# Breakpoints[](#breakpoints "Link to this heading")

Breakpoints files (`.bp` files) store your samples’ local ancestry labels. Each line in the file denotes the ancestral population (ex: YRI or CEU) of a portion of a chromosomal strand (or *haplotype block*) of an individual.

The set of haplotype blocks for an individual are delimited by a sample header of the form `{sample}_1` (for the first chromosomal strand) or `{sample}_2` (for the second chromosomal strand). Blocks from `{sample}_1` must be directly followed by blocks from `{sample}_2`.

Each set of haplotype blocks follows a tab-delimited format with the following fields. Lines within a sample’s set of blocks must be sorted according to `chrom`, `bp`, and `cm` - in that order.

| Name | Type | Description |
| --- | --- | --- |
| pop | string | The population label of this haplotype block (ex: CEU or YRI) |
| chrom | string | The name of the chromosome to which this haplotype block belongs (ex: chr1) |
| bp | integer | The base-pair position of the end of the haplotype block (ex: 1001038) |
| cm | float | The centimorgan position of the end of the haplotype block (ex: 43.078) |

## Examples[](#examples "Link to this heading")

See [tests/data/outvcf\_test.bp](https://github.com/cast-genomics/haptools/blob/main/tests/data/outvcf_test.bp) for an example of a short breakpoint file:

```
Sample_1_1
YRI     1       59423086        85.107755
CEU     1       239403765       266.495714
YRI     2       229668157       244.341689
Sample_1_2
YRI     1       59423086        85.107755
YRI     1       239403765       266.495714
CEU     2       229668157       244.341689
Sample_2_1
CEU     1       59423086        85.107755
YRI     1       239403765       266.495714
CEU     2       229668157       244.341689
Sample_2_2
CEU     1       59423086        85.107755
CEU     1       239403765       266.495714
YRI     2       229668157       244.341689
```

See [tests/data/simple.bp](https://github.com/cast-genomics/haptools/blob/main/tests/data/simple.bp) for a longer example:

```
HG00096_1
YRI     1       10122   1.23
HG00096_2
CEU     1       10115   1.2
YRI     1       10116   1.21
ASW     1       10120   1.22
YRI     1       10122   1.23
HG00097_1
YRI     1       10122   1.2
HG00097_2
YRI     1       10115   1.2
CEU     1       10116   1.21
YRI     1       10122   1.23
HG00099_1
YRI     1       10116   1.2
CEU     1       10118   1.22
YRI     1       10122   1.23
HG00099_2
YRI     1       10122   1.23
HG00100_1
ASW     1       10115   1.2
CEU     1       10116   1.21
YRI     1       10120   1.22
CEU     1       10122   1.23
HG00100_2
YRI     1       10114   1.2
CEU     1       10116   1.21
YRI     1       10122   1.23
HG00101_1
YRI     1       10121   1.23
ASW     1       10122   1.23
HG00101_2
YRI     1       10115   1.2
CEU     1       10116   1.21
YRI     1       10120   1.22
ASW     1       10122   1.23
```

[Previous](snplist.html "Causal SNPs")
[Next](sample_info.html "Sample Info")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).