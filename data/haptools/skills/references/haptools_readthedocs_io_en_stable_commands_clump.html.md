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
* clump
  + [Usage](#usage)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [clump](#haptools-clump)
* [ld](ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* clump
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/clump.rst)

---

# clump[](#clump "Link to this heading")

Clump a set of variants specified in a [.linear file](../formats/linear.html).

The `clump` command creates a clump file joining SNPs or STRs in LD with one another.

## Usage[](#usage "Link to this heading")

```
haptools clump \
--verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET] \
--summstats-snps PATH \
--gts-snps PATH \
--summstats-strs PATH \
--gts-strs PATH \
--clump-field TEXT \
--clump-id-field TEXT \
--clump-chrom-field TEXT \
--clump-pos-field TEXT \
--clump-p1 FLOAT \
--clump-p2 FLOAT \
--clump-r2 FLOAT \
--clump-kb FLOAT \
--ld [Exact|Pearson] \
--out PATH
```

## Examples[](#examples "Link to this heading")

```
haptools clump \
  --summstats-snps tests/data/test_snpstats.linear \
  --gts-snps tests/data/simple.vcf \
  --clump-id-field ID \
  --clump-chrom-field CHROM \
  --clump-pos-field POS \
  --out test_snps.clump
```

You can use `--ld [Exact|Pearson]` to indicate which type of LD calculation you’d like to perform. `Exact` utilizes an exact cubic solution adopted from [CubeX](https://github.com/t0mrg/cubex) whereas `Pearson` utilizes a Pearson R calculation. Note `Exact` only works on SNPs and not any other variant type eg. STRs. The default value is `Pearson`.

```
haptools clump \
  --summstats-snps tests/data/test_snpstats.linear \
  --gts-snps tests/data/simple.vcf \
  --clump-id-field ID \
  --clump-chrom-field CHROM \
  --clump-pos-field POS \
  --ld Exact \
  --out test_snps.clump
```

You can modify thresholds and values used in the clumping process. `--clump-p1` is the largest value of a p-value to consider being an index variant for a clump. `--clump-p2` dictates the maximum p-value any variant can have to be considered when clumping. `--clump-r2` is the R squared threshold where being greater than this value implies the candidate variant is in LD with the index variant. `--clump-kb` is the maximum distance upstream or downstream from the index variant to collect candidate variants for LD comparison. For example, `--clump-kb 100` implies all variants 100 Kb upstream and 100 Kb downstream from the variant will be considered.

```
haptools clump \
  --summstats-snps tests/data/test_snpstats.linear \
  --gts-snps tests/data/simple.vcf \
  --clump-id-field ID \
  --clump-chrom-field CHROM \
  --clump-pos-field POS \
  --clump-p1 0.001 \
  --clump-p2 0.05 \
  --clump-r2 0.7 \
  --clump-kb 200.5 \
  --out test_snps.clump
```

You can also input STRs when calculating clumps. They can be used together with SNPs or alone.

```
haptools clump \
  --summstats-strs tests/data/test_strstats.linear \
  --gts-strs tests/data/simple_tr.vcf \
  --summstats-snps tests/data/test_snpstats.linear \
  --gts-snps tests/data/simple.vcf \
  --clump-id-field ID \
  --clump-chrom-field CHROM \
  --clump-pos-field POS \
  --ld Exact \
  --out test_snps.clump
```

```
haptools clump \
  --summstats-strs tests/data/test_strstats.linear \
  --gts-strs tests/data/simple_tr.vcf \
  --clump-id-field ID \
  --clump-chrom-field CHROM \
  --clump-pos-field POS \
  --ld Exact \
  --out test_snps.clump
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

#### clump[](#haptools-clump "Link to this heading")

Performs clumping on datasets with SNPs, SNPs and STRs, and STRs.
Clumping is the process of identifying SNPs or STRs that are highly
correlated with one another and concatenating them all together into
a single “clump” in order to not repeat the same effect size due to
LD.

```
haptools clump [OPTIONS]
```

Options

--summstats-snps <summstats\_snps>[](#cmdoption-haptools-clump-summstats-snps "Link to this definition")
:   File to load snps summary statistics

--summstats-strs <summstats\_strs>[](#cmdoption-haptools-clump-summstats-strs "Link to this definition")
:   File to load strs summary statistics

--gts-snps <gts\_snps>[](#cmdoption-haptools-clump-gts-snps "Link to this definition")
:   SNP genotypes (VCF or PGEN)

--gts-strs <gts\_strs>[](#cmdoption-haptools-clump-gts-strs "Link to this definition")
:   STR genotypes (VCF)

--clump-p1 <clump\_p1>[](#cmdoption-haptools-clump-clump-p1 "Link to this definition")
:   Max pval to start a new clump

--clump-p2 <clump\_p2>[](#cmdoption-haptools-clump-clump-p2 "Link to this definition")
:   Filter for pvalue less than

--clump-id-field <clump\_id\_field>[](#cmdoption-haptools-clump-clump-id-field "Link to this definition")
:   Column header of the variant ID

--clump-field <clump\_field>[](#cmdoption-haptools-clump-clump-field "Link to this definition")
:   Column header of the p-values

--clump-chrom-field <clump\_chrom\_field>[](#cmdoption-haptools-clump-clump-chrom-field "Link to this definition")
:   Column header of the chromosome

--clump-pos-field <clump\_pos\_field>[](#cmdoption-haptools-clump-clump-pos-field "Link to this definition")
:   Column header of the position

--clump-kb <clump\_kb>[](#cmdoption-haptools-clump-clump-kb "Link to this definition")
:   clump kb radius

--clump-r2 <clump\_r2>[](#cmdoption-haptools-clump-clump-r2 "Link to this definition")
:   r^2 threshold

--ld <ld>[](#cmdoption-haptools-clump-ld "Link to this definition")
:   Calculation type to infer LD, Exact Solution or Pearson R. (Exact|Pearson). Note the Exact Solution works best when all three genotypes are present (0,1,2) in the variants being compared.

    Default:
    :   `'Pearson'`

    Options:
    :   Exact | Pearson

--out <out>[](#cmdoption-haptools-clump-out "Link to this definition")
:   **Required** Output filename

-v, --verbosity <verbosity>[](#cmdoption-haptools-clump-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

[Previous](index.html "index")
[Next](ld.html "ld")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).