[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* Genotypes
  + [VCF/BCF](#vcf-bcf)
  + [PLINK2 PGEN](#plink2-pgen)
    - [Converting from VCF to PGEN](#converting-from-vcf-to-pgen)
  + [Tandem repeats](#tandem-repeats)
* [Haplotypes](haplotypes.html)
* [Phenotypes and Covariates](phenotypes.html)
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

* Genotypes
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/formats/genotypes.rst)

---

# Genotypes[](#genotypes "Link to this heading")

![https://github.com/CAST-genomics/haptools/assets/23412689/6da88941-7520-4c19-beaa-27f540f6b047](https://github.com/CAST-genomics/haptools/assets/23412689/6da88941-7520-4c19-beaa-27f540f6b047)

The time required to load various genotype file formats.[](#id2 "Link to this image")

## VCF/BCF[](#vcf-bcf "Link to this heading")

Genotype files must be specified as VCF or BCF files. They can be bgzip-compressed.

To be loaded properly, VCFs must follow the VCF specification. VCFs with duplicate variant IDs do not follow the specification; the IDs must be unique. Please validate your VCF using a tool like [gatk ValidateVariants](https://gatk.broadinstitute.org/hc/en-us/articles/360037057272-ValidateVariants) before using haptools.

## PLINK2 PGEN[](#plink2-pgen "Link to this heading")

There is also experimental support for [PLINK2 PGEN](https://github.com/chrchang/plink-ng/blob/master/pgen_spec/pgen_spec.pdf) files in some commands. These files can be loaded and created much more quickly than VCFs, so we highly recommend using them if you’re working with large datasets. See the documentation for the `GenotypesPLINK` class in [the API docs](../api/data.html#api-data-genotypesplink) for more information.

If you run out memory when using PGEN files, consider reading/writing variants from the file in chunks via the `--chunk-size` parameter.

### Converting from VCF to PGEN[](#converting-from-vcf-to-pgen "Link to this heading")

To convert a VCF containing only SNPs to PGEN, use the following command.

```
plink2 --snps-only 'just-acgt' --vcf input.vcf --make-pgen --out output
```

To convert a VCF containing tandem repeats to PGEN, use this command, instead.

```
plink2 --vcf-half-call m --make-pgen 'pvar-cols=vcfheader,qual,filter,info' --vcf input.vcf --make-pgen --out output
```

If you are seeing cryptic errors with haptools and your PGEN file, please validate it first:

```
plink2 --pfile output --validate
```

## Tandem repeats[](#tandem-repeats "Link to this heading")

VCFs containing tandem repeats usually have a *type* indicating the tool from which they originated. We support whichever types are supported by [TRTools](https://trtools.readthedocs.io/en/stable/CALLERS.html).

We do our best to infer the *type* of a TR VCF automatically. However, there will be some instances when it cannot be inferred.
Users of TRTools know to specify `--vcftype` in that situation. However, most haptools commands do not yet support the `--vcftype` parameter. Instead, you can modify the header of your VCF to trick haptools into being able to infer the *type*.

For example, if you’re using HipSTR, you can add `##command=hipstr...`. Refer to [this code in TRTools](https://trtools.readthedocs.io/en/stable/trtools.utils.tr_harmonizer.html#trtools.utils.tr_harmonizer.InferVCFType) for more details.

Please note that all of this also applies to PVAR files created from TR VCFs.

[Previous](../project_info/contributing.html "Contributing")
[Next](haplotypes.html "Haplotypes")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).