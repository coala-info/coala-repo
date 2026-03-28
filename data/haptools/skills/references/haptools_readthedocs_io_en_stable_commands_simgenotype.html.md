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

* simgenotype
  + [Basic Usage](#basic-usage)
  + [Parameter Descriptions](#parameter-descriptions)
  + [File Formats](#file-formats)
  + [Examples](#examples)
  + [Detailed Usage](#detailed-usage)
    - [haptools](#haptools)
      * [simgenotype](#haptools-simgenotype)
* [simphenotype](simphenotype.html)
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

* simgenotype
* [Edit on GitHub](https://github.com/CAST-genomics/haptools/blob/main/docs/commands/simgenotype.rst)

---

# simgenotype[](#simgenotype "Link to this heading")

Takes as input a reference set of haplotypes in VCF format and a user-specified admixture model.

Outputs a VCF file with simulated genotype information for admixed genotypes, as well as a breakpoints file that can be used for visualization. For example, you could simulate a 50/50 mixture of CEU and YRI for 10 generations. Other more complex models such as involving pulse events of new populations can also be simulated.

## Basic Usage[](#basic-usage "Link to this heading")

```
haptools simgenotype \
--model MODELFILE \
--mapdir GENETICMAPDIR \
--chroms LIST,OF,CHROMS \
--region CHR:START-END \
--ref_vcf REFVCF \
--sample_info SAMPLEINFOFILE \
--pop_field \
--out /PATH/TO/OUTPUT.VCF.GZ
```

Detailed information about each option, and example commands using publicly available files, are shown below.

## Parameter Descriptions[](#parameter-descriptions "Link to this heading")

* `--model` - Parameters for simulating admixture across generations including sample size, population fractions, and number of generations.
* `--mapdir` - Directory containing all .map files with this [structure](https://www.cog-genomics.org/plink/1.9/formats#map) where the third position is in centiMorgans
* `--out` - Full output path to file of the structure `/path/to/output.(vcf|bcf|vcf.gz|pgen)` which if `vcf.gz` is chosen outputs `/path/to/output.vcf.gz` and breakpoints file `/path/to/output.bp`
* `--chroms` - List of chromosomes to be simulated. The map file directory must contain the “chr<CHR>” where <CHR> is the chromosome identifier eg. 1,2,…,X
* `--seed` - Seed for randomized calculations during simulation of breakpoints. [Optional]
* `--popsize` - Population size for each generaetion that is sampled from to create our simulated samples. Default = max(10000, 10\*samples) [Optional]
* `--ref_vcf` - Input VCF or PGEN file used to simulate specifiic haplotypes for resulting samples
* `--sample_info` - File used to map samples in `REFVCF` to populations found in `MODELFILE`
* `--region` - Limit the simulation to a region within a single chromosome. Overwrites chroms with the chrom listed in this region. eg 1:1-10000 [Optional]
* `--pop_field` - Flag for ouputting population field in VCF output. Note this flag does not work when your output is in PGEN format. [Optional]
* `--sample_field` - Flag for ouputting sample field in VCF output. Note this flag does not work when your output is in PGEN format. Should only be used for debugging. [Optional]
* `--no_replacement` - Flag for deteremining during the VCF generation process whether we grab samples’ haplotypes with or without replacement from the reference VCF file. Default = False (With replacement) [Optional]
* `--verbosity` - What level of output the logger should print to stdout. Please see [logging levels](https://docs.python.org/3/library/logging.html) for output levels. Default = INFO [Optional]
* `--only_breakpoint` - Flag which when provided only outputs the breakpoint file. Note you will not need to provide a `--ref_vcf` or `--sample_info` file and can instead put NA. eg. `--ref_vcf NA` and `--sample_info NA` [Optional]

## File Formats[](#file-formats "Link to this heading")

* [sampleinfo format](../formats/sample_info.html)
* [model format](../formats/models.html)
* [map format](../formats/maps.html)
* [breakpoint format](../formats/breakpoints.html)

## Examples[](#examples "Link to this heading")

```
haptools simgenotype \
--model tests/data/outvcf_gen.dat \
--mapdir tests/data/map/ \
--region 1:1-83000 \
--ref_vcf tests/data/outvcf_test.vcf.gz \
--sample_info tests/data/outvcf_info.tab \
--pop_field \
--out tests/data/example_simgenotype.vcf
```

If speed is important, it’s generally faster to use PGEN files than VCFs.

```
haptools simgenotype \
--model tests/data/outvcf_gen.dat \
--mapdir tests/data/map/ \
--region 1:1-83000 \
--ref_vcf tests/data/outvcf_test.pgen \
--sample_info tests/data/outvcf_info.tab \
--pop_field \
--out tests/data/example_simgenotype.pgen
```

Warning

Writing PGEN files will require more memory than writing VCFs. The memory will depend on the number of simulated samples and variants.
You can reduce the memory required for this step by writing the variants in chunks. Just specify a `--chunk-size` value.

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

#### simgenotype[](#haptools-simgenotype "Link to this heading")

Simulate admixed genomes under a pre-defined model.

```
haptools simgenotype [OPTIONS]
```

Options

--model <model>[](#cmdoption-haptools-simgenotype-model "Link to this definition")
:   **Required** Admixture model in .dat format. See File Formats under simgenotype in the docs for complete info.

--mapdir <mapdir>[](#cmdoption-haptools-simgenotype-mapdir "Link to this definition")
:   **Required** Directory containing files with chr{1-22,X} and ending in .map in the file name with genetic map coords.

--out <out>[](#cmdoption-haptools-simgenotype-out "Link to this definition")
:   **Required** Path to desired output file. E.g. /path/to/output.vcf.gz Possible outputs are vcf|bcf|vcf.gz|pgen and there will be an additional breakpoints output with extension bp e.g. /path/to/output.bp.

--chroms <chroms>[](#cmdoption-haptools-simgenotype-chroms "Link to this definition")
:   Sorted and comma delimited list of chromosomes to simulate

--seed <seed>[](#cmdoption-haptools-simgenotype-seed "Link to this definition")
:   Random seed. Set to make simulations reproducible

--ref\_vcf <ref\_vcf>[](#cmdoption-haptools-simgenotype-ref_vcf "Link to this definition")
:   **Required** VCF or PGEN file used as reference for creation of simulated samples respective genotypes.

--sample\_info <sample\_info>[](#cmdoption-haptools-simgenotype-sample_info "Link to this definition")
:   **Required** File that maps samples from the reference VCF (–invcf) to population codes describing the populations in the header of the model file.

--region <region>[](#cmdoption-haptools-simgenotype-region "Link to this definition")
:   Subset the simulation to a specific region in a chromosome using the form chrom:start-end. Example 2:1000-2000

--pop\_field[](#cmdoption-haptools-simgenotype-pop_field "Link to this definition")
:   Flag for outputting the population field in your VCF output. NOTE this flag does not work when your output file is in PGEN format.

--sample\_field[](#cmdoption-haptools-simgenotype-sample_field "Link to this definition")
:   Flag for outputting the sample field in your VCF output. NOTE this flag does not work when your output file is in PGEN format.

--no\_replacement[](#cmdoption-haptools-simgenotype-no_replacement "Link to this definition")
:   Flag used to determine whether to sample reference haplotypes with or without replacement. (Default = Replacement)

--only\_breakpoint[](#cmdoption-haptools-simgenotype-only_breakpoint "Link to this definition")
:   Flag used to determine whether to only output breakpoints or continue to simulate a vcf file.

-c, --chunk-size <chunk\_size>[](#cmdoption-haptools-simgenotype-c "Link to this definition")
:   If requesting a PGEN output file, write genotypes in chunks of X variants; reduces memory

    Default:
    :   `'all variants'`

-v, --verbosity <verbosity>[](#cmdoption-haptools-simgenotype-v "Link to this definition")
:   The level of verbosity desired

    Default:
    :   `'INFO'`

    Options:
    :   CRITICAL | ERROR | WARNING | INFO | DEBUG | NOTSET

[Previous](../formats/maps.html "Maps")
[Next](simphenotype.html "simphenotype")

---

© Copyright 2021, Michael Lamkin, Arya Massarat.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).