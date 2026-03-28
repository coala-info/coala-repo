[haptools](../index.html)

Overview

* [Installation](../project_info/installation.html)
* [Example files](../project_info/example_files.html)
* [Contributing](../project_info/contributing.html)

File Formats

* [Genotypes](../formats/genotypes.html)
* [Haplotypes](../formats/haplotypes.html)
* [Phenotypes and Covariates](../formats/phenotypes.html)
* [Linkage disequilibrium](../formats/ld.html)
* [Summary Statistics](../formats/linear.html)
* [Causal SNPs](../formats/snplist.html)
* [Breakpoints](../formats/breakpoints.html)
* [Sample Info](../formats/sample_info.html)
* [Models](../formats/models.html)
* [Maps](../formats/maps.html)

Commands

* [simgenotype](simgenotype.html)
* [simphenotype](simphenotype.html)
* [karyogram](karyogram.html)
* [transform](transform.html)
* [index](index.html)
* [clump](clump.html)
* ld
  + [Usage](#usage)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [ld](#haptools-ld)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* ld
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/ld.rst)

---

# ld[](#ld "Link to this heading")

Compute the pair-wise LD ([Pearson’s correlation coefficient](https://numpy.org/doc/stable/reference/generated/numpy.corrcoef.html)) between haplotypes (or genotypes) and a single *TARGET* haplotype (or variant).

The `ld` command takes as input a set of genotypes in VCF and a list of haplotypes (specified as a [.hap file](../formats/haplotypes.html)) and outputs a new [.hap file](../formats/haplotypes.html) with the computed LD values in an extra field.

By default, LD is computed with each haplotype in the `.hap` file. To compute LD with the variants in the genotypes file instead, you should use the [–from-gts](#cmdoption-haptools-ld-from-gts) switch. When this mode is enabled, the `.hap` output will be replaced by an [.ld file](../formats/ld.html).

Note

Repeats are not currently supported by the `ld` command. Any repeats in your `.hap` file will be ignored.

You may also specify genotypes in PLINK2 PGEN format instead of VCF format. See the documentation for genotypes in [the format docs](../formats/genotypes.html#formats-genotypesplink) for more information.

## Usage[](#usage "Link to this heading")

```
haptools ld \
--region TEXT \
--sample SAMPLE \
--samples-file FILENAME \
--id ID \
--ids-file FILENAME \
--chunk-size INT \
--discard-missing \
--from-gts \
--output PATH \
--verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET] \
TARGET GENOTYPES HAPLOTYPES
```

## Examples[](#examples "Link to this heading")

*TARGET* can either be a haplotype or a variant.

For example, let’s compute LD with the haplotype ‘chr21.q.3365\*1’.

```
haptools ld 'chr21.q.3365*1' tests/data/example.vcf.gz tests/data/basic.hap.gz | less
```

Or, let’s compute LD with the variant ‘rs429358’.

```
haptools ld -o apoe4_ld.hap rs429358 tests/data/apoe.vcf.gz tests/data/apoe4.hap
```

Alternatively, we can compute LD between the APOe4 haplotype and all genotypes in the VCF by using the `--from-gts` switch. Note that we should use a different extension for the output file now.

```
haptools ld --from-gts -o apoe4.ld APOe4 tests/data/apoe.vcf.gz tests/data/apoe4.hap
```

You can select a subset of variants (or haplotypes) using the `--id` parameter multiple times (or the `--ids-file` parameter).

```
haptools ld --from-gts -i rs543363163 -i rs7412 APOe4 tests/data/apoe.vcf.gz tests/data/apoe4.hap
```

All files used in these examples are described [here](../project_info/example_files.html).

## Detailed Usage[](#detailed-usage "Link to this heading")

### haptools[](#haptools "Link to this heading")

haptools: A toolkit for simulating and analyzing genotypes and
phenotypes while taking into account haplotype information

```
haptools [OPTIONS] COMMAND [ARGS]...
```

Options

--version[](#cmdoption-haptools-version "Link to this definition")
:   Show the version and exit.

#### ld[](#haptools-ld "Link to this heading")

Compute the pair-wise LD (Pearson’s correlation) between haplotypes (or variants)
and a single TARGET haplotype (or variant)

GENOTYPES must be formatted as a VCF or PGEN and HAPLOTYPES must be formatted
according to the .hap format spec

TARGET refers to the ID of a variant or haplotype. LD is computed pair-wise between
TARGET and all of the other haplotypes in the .hap (or genotype) file

If TARGET is a variant ID, the ID must appear in GENOTYPES. Otherwise, it must
be present in the .hap file

```
haptools ld [OPTIONS] TARGET GENOTYPES HAPLOTYPES
```

Options

--region <region>[](#cmdoption-haptools-ld-region "Link to this definition")
:   The region from which to extract haplotypes; ex: ‘chr1:1234-34566’ or ‘chr7’.
    For this to work, the VCF and .hap file must be indexed and the seqname provided must correspond with one in the files

    Default:
    :   `'all haplotypes'`

-s, --sample <samples>[](#cmdoption-haptools-ld-s "Link to this definition")
:   A list of the samples to subset from the genotypes file (ex: ‘-s sample1 -s sample2’)

    Default:
    :   `'all samples'`

-S, --samples-file <samples\_file>[](#cmdoption-haptools-ld-S "Link to this definition")
:   A single column txt file containing a list of the samples (one per line) to subset from the genotypes file

    Default:
    :   `'all samples'`

-i, --id <ids>[](#cmdoption-haptools-ld-i "Link to this definition")
:   A list of the haplotype IDs to use from the .hap file (ex: ‘-i H1 -i H2’). Or, if –from-gts, a list of the variant IDs to use from the genotypes file.
    For this to work, the .hap file must be indexed

    Default:
    :   `'all haplotypes'`

-I, --ids-file <ids\_file>[](#cmdoption-haptools-ld-I "Link to this definition")
:   A single column txt file containing a list of the haplotype (or variant) IDs (one per line) to subset from the .hap (or genotype) file

    Default:
    :   `'all haplotypes'`

-c, --chunk-size <chunk\_size>[](#cmdoption-haptools-ld-c "Link to this definition")
:   If using a PGEN file, read genotypes in chunks of X variants; reduces memory

    Default:
    :   `'all variants'`

--discard-missing[](#cmdoption-haptools-ld-discard-missing "Link to this definition")
:   Ignore any samples that are missing genotypes for the required variants

    Default:
    :   `False`

--from-gts[](#cmdoption-haptools-ld-from-gts "Link to this definition")
:   By default, LD is computed with the haplotypes in the .hap file. Use this switch to compute LD with the genotypes in the genotypes file, instead.

    Default:
    :   `False`

-o, --output <output>[](#cmdoption-haptools-ld-o "Link to this definition")
:   A .hap file containing haplotypes and their LD with TARGET

    Default:
    :   `'stdout'`

-v, --verbosity <verbosity>[](#cmdoption-haptools-ld-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

Arguments

TARGET[](#cmdoption-haptools-ld-arg-TARGET "Link to this definition")
:   Required argument

GENOTYPES[](#cmdoption-haptools-ld-arg-GENOTYPES "Link to this definition")
:   Required argument

HAPLOTYPES[](#cmdoption-haptools-ld-arg-HAPLOTYPES "Link to this definition")
:   Required argument

[Previous](clump.html "clump")
[Next](../api/data.html "data")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).