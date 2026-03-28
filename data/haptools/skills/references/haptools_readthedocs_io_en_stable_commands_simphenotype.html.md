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
* simphenotype
  + [Usage](#usage)
  + [Model](#model)
  + [Input](#input)
  + [Output](#output)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [simphenotype](#haptools-simphenotype)
* [karyogram](karyogram.html)
* [transform](transform.html)
* [index](index.html)
* [clump](clump.html)
* [ld](ld.html)

API

* [data](../api/data.html)
* [haptools](../api/modules.html)
* [examples](../api/examples.html)

[haptools](../index.html)

* simphenotype
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/simphenotype.rst)

---

# simphenotype[](#simphenotype "Link to this heading")

Simulates a complex trait, taking into account haplotype- or local-ancestry- specific effects as well as traditional variant-level effects. The user denotes causal variants or haplotypes by specifying them in a [.snplist file](../formats/snplist.html) or [.hap file](../formats/haplotypes.html). Phenotypes are simulated from genotypes output by the [transform command](transform.html).

The implementation is based on the [GCTA GWAS Simulation](https://yanglab.westlake.edu.cn/software/gcta/#GWASSimulation) utility.

## Usage[](#usage "Link to this heading")

```
haptools simphenotype \
--replications INT \
--environment FLOAT \
--heritability FLOAT \
--prevalence FLOAT \
--normalize \
--region TEXT \
--sample SAMPLE --sample SAMPLE \
--samples-file FILENAME \
--id ID --id ID \
--ids-file FILENAME \
--chunk-size INT \
--repeats PATH \
--seed INT \
--output PATH \
--verbosity [CRITICAL|ERROR|WARNING|INFO|DEBUG|NOTSET] \
GENOTYPES HAPLOTYPES
```

## Model[](#model "Link to this heading")

Each normalized haplotype \(\vec{Z\_j}\) is encoded as an independent causal variable in a linear model:

\[\vec{y} = \sum\_j \beta\_j \vec{Z\_j} + \vec \epsilon\]

where

\[\epsilon\_i \sim N(0, \sigma^2)\]

\[\sigma^2 = v (\frac 1 {h^2} - 1)\]

The variable \(v\) can be specified via the `--environment` parameter. When not provided, \(v\) is inferred from the variance of the genotypes:

\[v = Var[\sum\_j \beta\_j \vec{Z\_j}]\]

The heritability \(h^2\) can be specified via the `--heritability` parameter and defaults to 0.5 when not provided.

When both \(v\) and \(h^2\) aren’t provided, \(\sigma^2\) is computed purely from the effect sizes, instead:

\[\sigma^2 = \Biggl \lbrace {1 - \sum \beta\_j^2 \quad \quad {\sum \beta\_j^2 \le 1} \atop 0 \quad \quad \quad \quad \quad \text{ otherwise }}\]

If a prevalence for the disease is specified via the `--prevalence` parameter, the final \(\vec{y}\) is thresholded to produce a binary case/control trait with the desired fraction of diseased individuals.

## Input[](#input "Link to this heading")

Genotypes must be specified in VCF and haplotypes must be specified in the [.snplist](../formats/snplist.html) or [.hap file format](../formats/haplotypes.html).

Note

Your `.hap` files must contain a “beta” extra field. See [this section](../formats/haplotypes.html#formats-haplotypes-extrafields-simphenotype) of the `.hap` format spec for more details.

Alternatively, you may also specify genotypes in PLINK2 PGEN format. Just use the appropriate “.pgen” file extension in the input. See the documentation for genotypes in [the format docs](../formats/genotypes.html#formats-genotypesplink) for more information.

## Output[](#output "Link to this heading")

Phenotypes are output in the PLINK2-style `.pheno` file format. If `--replications` was set to greater than 1, additional columns are output for each simulated trait.

Note

Case/control phenotypes are encoded as 0 (control) + 1 (case) **not** 1 (control) + 2 (case). The latter is assumed by PLINK2 unless the `--1` flag is used (see [the PLINK2 docs](https://www.cog-genomics.org/plink/2.0/input#input_missing_phenotype)). Therefore, you must use `--1` when providing our `.pheno` files to PLINK.

## Examples[](#examples "Link to this heading")

In its simplest usage, `simphenotype` can be used to simulate traits arising from SNPs in a [.snplist file](../formats/snplist.html).

```
haptools simphenotype tests/data/apoe.vcf.gz tests/data/apoe.snplist
```

However, if you want to simulate haplotype-based effects, you will need to `transform` your SNPs into haplotypes first. You can pass the same `.hap` file to both commands.

```
haptools transform tests/data/simple.vcf tests/data/simple.hap | \
haptools simphenotype -o simulated.pheno /dev/stdin tests/data/simple.hap
```

By default, all of the effects in the `.hap` file will be encoded as causal variables. Alternatively, you can select the causal variables manually via the `--id` or `--ids-file` parameters.

```
haptools transform tests/data/simple.vcf tests/data/simple.hap | \
haptools simphenotype --id 'H1' /dev/stdin tests/data/simple.hap
```

To simulate ancestry-specific effects from a genotypes file with population labels, use the `--ancestry` switch when running `transform`.

```
haptools transform --ancestry tests/data/simple-ancestry.vcf tests/data/simple.hap | \
haptools simphenotype --id 'H1' /dev/stdin tests/data/simple.hap
```

If speed is important, it’s generally faster to use PGEN files than VCFs.

```
haptools transform -o simple-haps.pgen tests/data/simple.pgen tests/data/simple.hap
haptools simphenotype --id 'H1' simple-haps.pgen tests/data/simple.hap
```

To simulate causal tandem repeats we require an ‘R’ line in the **.hap** file and a genotypes file with repeats instead of haplotypes.

```
haptools simphenotype --id 1:10114:GTT tests/data/simple_tr.vcf tests/data/simple_tr.hap
```

Note

If you would like to simulate from a mix of both haplotypes and repeats, you should specify your repeats in a separate file via the `--repeats` argument.

Let’s simulate two replicates of a case/control trait that occurs in 60% of samples with a heritability of 0.8. We’ll encode only two of the haplotypes in `tests/data/simphenotype.hap` as independent causal variables.

```
haptools transform tests/data/example.vcf.gz tests/data/simphenotype.hap | \
haptools simphenotype \
--replications 2 \
--heritability 0.8 \
--prevalence 0.6 \
--id 'chr21.q.3365*10' \
--id 'chr21.q.3365*11' \
--output simulated.pheno \
/dev/stdin tests/data/simphenotype.hap
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

#### simphenotype[](#haptools-simphenotype "Link to this heading")

Haplotype-aware phenotype simulation. Create a set of simulated phenotypes from a
set of haplotypes.

GENOTYPES must be formatted as a VCF or PGEN file and HAPLOTYPES must be formatted
according to the .hap format spec

Note: GENOTYPES must be the output from the transform subcommand.

```
haptools simphenotype [OPTIONS] GENOTYPES HAPLOTYPES
```

Options

-r, --replications <replications>[](#cmdoption-haptools-simphenotype-r "Link to this definition")
:   Number of rounds of simulation to perform

    Default:
    :   `1`

--environment <environment>[](#cmdoption-haptools-simphenotype-environment "Link to this definition")
:   Variance of environmental term; inferred if not specified

-h, --heritability <heritability>[](#cmdoption-haptools-simphenotype-h "Link to this definition")
:   Trait heritability

    Default:
    :   `'0.5'`

-p, --prevalence <prevalence>[](#cmdoption-haptools-simphenotype-p "Link to this definition")
:   Disease prevalence if simulating a case-control trait

    Default:
    :   `'quantitative trait'`

--normalize, --no-normalize[](#cmdoption-haptools-simphenotype-normalize "Link to this definition")
:   Whether to normalize the genotypes before using them for simulation

    Default:
    :   `True`

--region <region>[](#cmdoption-haptools-simphenotype-region "Link to this definition")
:   The region from which to extract haplotypes; ex: ‘chr1:1234-34566’ or ‘chr7’.
    For this to work, the VCF and .hap file must be indexed and the seqname provided must correspond with one in the files

    Default:
    :   `'all haplotypes'`

-s, --sample <samples>[](#cmdoption-haptools-simphenotype-s "Link to this definition")
:   A list of the samples to subset from the genotypes file (ex: ‘-s sample1 -s sample2’)

    Default:
    :   `'all samples'`

-S, --samples-file <samples\_file>[](#cmdoption-haptools-simphenotype-S "Link to this definition")
:   A single column txt file containing a list of the samples (one per line) to subset from the genotypes file

    Default:
    :   `'all samples'`

-i, --id <ids>[](#cmdoption-haptools-simphenotype-i "Link to this definition")
:   A list of the haplotype IDs from the .hap file to use as causal variables (ex: ‘-i H1 -i H2’).

    Default:
    :   `'all haplotypes'`

-I, --ids-file <ids\_file>[](#cmdoption-haptools-simphenotype-I "Link to this definition")
:   A single column txt file containing a list of the haplotype IDs (one per line) to subset from the .hap file

    Default:
    :   `'all haplotypes'`

-c, --chunk-size <chunk\_size>[](#cmdoption-haptools-simphenotype-c "Link to this definition")
:   If using a PGEN file, read genotypes in chunks of X variants; reduces memory

    Default:
    :   `'all variants'`

--repeats <repeats>[](#cmdoption-haptools-simphenotype-repeats "Link to this definition")
:   Path to a genotypes file containing tandem repeats. This is only necessary when simulating both haplotypes *and* repeats as causal effects

--seed <seed>[](#cmdoption-haptools-simphenotype-seed "Link to this definition")
:   Use this option across executions to make the output reproducible

    Default:
    :   `'chosen randomly'`

-o, --output <output>[](#cmdoption-haptools-simphenotype-o "Link to this definition")
:   A TSV file containing simulated phenotypes

    Default:
    :   `'stdout'`

-v, --verbosity <verbosity>[](#cmdoption-haptools-simphenotype-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

Arguments

GENOTYPES[](#cmdoption-haptools-simphenotype-arg-GENOTYPES "Link to this definition")
:   Required argument

HAPLOTYPES[](#cmdoption-haptools-simphenotype-arg-HAPLOTYPES "Link to this definition")
:   Required argument

[Previous](simgenotype.html "simgenotype")
[Next](karyogram.html "karyogram")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).