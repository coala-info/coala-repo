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
* transform
  + [Usage](#usage)
  + [Input](#input)
    - [Ancestry](#ancestry)
  + [Output](#output)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [transform](#haptools-transform)
* [index](index.html)
* [clump](clump.html)
* [ld](ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* transform
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/transform.rst)

---

# transform[](#transform "Link to this heading")

Transform a set of genotypes via a list of haplotypes. Create a new VCF containing haplotypes instead of variants.

The `transform` command takes as input a set of **phased** genotypes and a list of haplotypes and outputs a set of haplotype *pseudo-genotypes*, where each haplotype is encoded as a bi-allelic variant record in the output. In other words, each sample will have a genotype of `0|0`, `1|0`, `0|1`, or `1|1` indicating whether each of their two chromosome copies contains the alleles of a haplotype.

![Transforming genotypes via haplotypes](https://github.com/CAST-genomics/haptools/assets/23412689/fb3accd9-4b15-4ba7-a09c-022b405aa26f)

Users may also specify an ancestral population label for each haplotype. See the [ancestry section](#commands-transform-input-ancestry) for more details.

## Usage[](#usage "Link to this heading")

```
haptools transform \
--region TEXT \
--sample SAMPLE --sample SAMPLE \
--samples-file FILENAME \
--id ID --id ID \
--ids-file FILENAME \
--chunk-size INT \
--discard-missing \
--ancestry \
--output PATH \
--verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET] \
GENOTYPES HAPLOTYPES
```

## Input[](#input "Link to this heading")

Genotypes must be specified in VCF and haplotypes must be specified in the [.hap file format](../formats/haplotypes.html).

Alternatively, you may specify genotypes in PLINK2 PGEN format. Just use the appropriate “.pgen” file extension in the input. See the documentation for genotypes in [the format docs](../formats/genotypes.html#formats-genotypesplink) for more information.

### Ancestry[](#ancestry "Link to this heading")

If your `.hap` file contains [an “ancestry” extra field](../formats/haplotypes.html#formats-haplotypes-extrafields-transform) and your VCF contains a “POP” format field (as output by [simgenotype](simgenotype.html)), you should specify the `--ancestry` flag.
This will enable us to match the population labels of each haplotype against those in the genotypes output by [simgenotype](simgenotype.html).
In other words, a sample is said to contain a haplotype only if all of the alleles of the haplotype are labeled with the haplotype’s ancestry.

![Transforming via ancestry labels](https://github.com/CAST-genomics/haptools/assets/23412689/f00553c9-8a82-4b9e-9929-042da6d95f02)

Alternatively, you may specify a [breakpoints file](../formats/breakpoints.html) accompanying the genotypes file. It must have the same name as the genotypes file but with a `.bp` file ending. If such a file exists, `transform` will ignore any “POP” format fields in the genotypes file and instead obtain the ancestry labels from the breakpoints file. This is primarily a speed enhancement, since it’s faster to load ancestral labels from the breakpoints file.

## Output[](#output "Link to this heading")

Transform outputs *psuedo-genotypes* in VCF, but you may request genotypes in PLINK2 PGEN format, instead. Just use the appropriate “.pgen” file extension in the output path. See the documentation for genotypes in [the format docs](../formats/genotypes.html#formats-genotypesplink) for more information.

## Examples[](#examples "Link to this heading")

```
haptools transform tests/data/simple.vcf.gz tests/data/simple.hap
```

Let’s try transforming just two samples and let’s output to PGEN format:

```
haptools transform -o output.pgen -s HG00097 -s NA12878 tests/data/apoe.vcf.gz tests/data/apoe4.hap
```

To get progress information, increase the verbosity to “INFO”:

```
haptools transform --verbosity INFO -o output.vcf.gz tests/data/example.vcf.gz tests/data/basic.hap.gz
```

To match haplotypes as well as their ancestral population labels, use the `--ancestry` flag:

```
haptools transform --ancestry tests/data/simple-ancestry.vcf tests/data/simple.hap
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

#### transform[](#haptools-transform "Link to this heading")

Creates a VCF composed of haplotypes

GENOTYPES must be formatted as a VCF or PGEN and HAPLOTYPES must be formatted
according to the .hap format spec

```
haptools transform [OPTIONS] GENOTYPES HAPLOTYPES
```

Options

--region <region>[](#cmdoption-haptools-transform-region "Link to this definition")
:   The region from which to extract haplotypes; ex: ‘chr1:1234-34566’ or ‘chr7’.
    For this to work, the VCF and .hap file must be indexed and the seqname provided must correspond with one in the files

    Default:
    :   `'all haplotypes'`

-s, --sample <samples>[](#cmdoption-haptools-transform-s "Link to this definition")
:   A list of the samples to subset from the genotypes file (ex: ‘-s sample1 -s sample2’)

    Default:
    :   `'all samples'`

-S, --samples-file <samples\_file>[](#cmdoption-haptools-transform-S "Link to this definition")
:   A single column txt file containing a list of the samples (one per line) to subset from the genotypes file

    Default:
    :   `'all samples'`

-i, --id <ids>[](#cmdoption-haptools-transform-i "Link to this definition")
:   A list of the haplotype IDs to use from the .hap file (ex: ‘-i H1 -i H2’).

    Default:
    :   `'all haplotypes'`

-I, --ids-file <ids\_file>[](#cmdoption-haptools-transform-I "Link to this definition")
:   A single column txt file containing a list of the haplotype IDs (one per line) to subset from the .hap file

    Default:
    :   `'all haplotypes'`

-c, --chunk-size <chunk\_size>[](#cmdoption-haptools-transform-c "Link to this definition")
:   If using a PGEN file, read genotypes in chunks of X variants; reduces memory

    Default:
    :   `'all variants'`

--discard-missing[](#cmdoption-haptools-transform-discard-missing "Link to this definition")
:   Ignore any samples that are missing genotypes for the required variants

    Default:
    :   `False`

--ancestry[](#cmdoption-haptools-transform-ancestry "Link to this definition")
:   Also transform using VCF ‘POP’ FORMAT field and ‘ancestry’ .hap extra field

    Default:
    :   `False`

--maf <maf>[](#cmdoption-haptools-transform-maf "Link to this definition")
:   Do not output haplotypes with an MAF below this value

    Default:
    :   `'all haplotypes'`

-o, --output <output>[](#cmdoption-haptools-transform-o "Link to this definition")
:   A VCF file containing haplotype ‘genotypes’

    Default:
    :   `'stdout'`

-v, --verbosity <verbosity>[](#cmdoption-haptools-transform-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

Arguments

GENOTYPES[](#cmdoption-haptools-transform-arg-GENOTYPES "Link to this definition")
:   Required argument

HAPLOTYPES[](#cmdoption-haptools-transform-arg-HAPLOTYPES "Link to this definition")
:   Required argument

[Previous](karyogram.html "karyogram")
[Next](index.html "index")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).