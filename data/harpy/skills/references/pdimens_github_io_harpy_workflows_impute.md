[![](../../static/logo_trans.png)
![](../../static/logo_trans.png)](../../)v3.2

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

* [![](https://www.therkildsenlab.org/uploads/1/4/5/5/145548022/published/new-logo-smaller.png)
  Therkildsen Lab](https://www.therkildsenlab.org/)
* [![](../../static/biotech.png)
  Cornell GIH](https://www.genomicsinnovation.cornell.edu/)
* [Source](https://github.com/pdimens/harpy)
* [Submit Issue](https://github.com/pdimens/harpy/issues/new/choose)

[Powered by](https://retype.com/)

1. [Home](../../)
2. Workflows
3. [Impute](../../workflows/impute/)

# # Impute Genotypes using Sequences

In

[linked-read](../../categories/linked-read/),

[wgs](../../categories/wgs/)

Impute genotypes for haplotagged data with Harpy

 You will need

* at least 4 cores/threads available
* a tab-delimited parameter file
* sequence alignments:
  .bam

  ❗
  coordinate-sorted
  + **sample names**:
    a-z

    0-9

    .

    \_

    -

    case insensitive
* a variant call format file:
  .vcf

  .vcf.gz

  .bcf

 Curation of input VCF file

To work well with STITCH, Harpy needs the input variant call file to meet specific criteria.
Where labelled with
automatic
, Harpy will perform those curation steps on your input
variant call file. Where labelled with
manual
, you will need to perform these curation
tasks yourself prior to running the
impute
 module.

#### # Variant call file criteria

1. automatic
    Biallelic SNPs only
2. automatic
    VCF is sorted by position
3. manual
    No duplicate positions
   * example to remove duplicate positions

     ```
       bcftools norm -D in.vcf -o out.vcf
     ```
4. manual
    No duplicate sample names
   * count the occurrence of samples

     ```
       bcftools query -l file.bcf | sort | uniq -c
     ```
   * you will need to remove duplicate samples how you see fit

After variants have been called, you may want to impute missing genotypes to get the
most from your data. Harpy uses `STITCH` to impute genotypes, a haplotype-based
method that is linked-read aware. Imputing genotypes requires a variant call file
**containing SNPs**, such as that produced by [harpy snp](../snp/) and preferably [filtered in some capacity](../../getting_started/guides/filtering_snps/).
You can impute genotypes with Harpy using the
impute
 module:

usage

```
harpy impute OPTIONS... PARAMETERS VCF INPUTS...
```

example | impute only the samples in a vcf file, regardless of how many bams were supplied

```
# create a STITCH parameter file
harpy template impute > stitch.params

# run imputation
harpy impute --threads 20 --vcf-samples stitch.params data/variants.bcf data/*.bam
```

## # Running Options

In addition to the [common runtime options](../../getting_started/common_options/), the
impute
 module is configured using these command-line arguments:

| argument | default | description |
| --- | --- | --- |
| `PARAMETERS` |  | required  STITCH parameter file (tab-delimited) |
| `VCF` |  | required  Path to VCF/BCF file |
| `INPUTS` |  | required  Files or directories containing [input BAM files](../../getting_started/common_options/) |
| `--extra-params` `-x` |  | Extra arguments to add to STITCH, provided in quotes |
| `--grid-size` `-g` | 1 (per-snp) | Perform imputation in windows of a specific size, instead of per-SNP |
| `--region` `-r` |  | Specific region to impute, in the format `contig:start-end-buffer` |
| `--vcf-samples` |  | Use samples present in vcf file for imputation rather than those found the directory (see below) |

### # Impute a specific region

Use `--region` to only impute a specific genomic region, given as `contig:start-end-buffer`,
otherwise all contigs will be imputed. The `buffer` is an integer for how much before and after
your region STITCH will also look at for imputation (but will not attempt to impute).

### # Extra STITCH parameters

You may add [additional parameters](https://github.com/rwdavies/STITCH/blob/master/Options.md) to STITCH by way of the
`--extra-params` (or `-x`) option. Harpy uses the `STITCH.R` command-line tool, which requires arguments to be in the form `--argument=value`,
without spaces. Example:

```
harpy impute -t 15 -x "--regionStart=20 --regionEnd=500" stitch.params file.vcf Align/strobe
```

### # Prioritize the vcf file

Sometimes you want to run imputation on all the samples present in the `INPUTS`, but other times you may want
to only impute the samples present in the `VCF` file. By default, Harpy assumes you want to use all the samples
present in the `INPUTS` and will inform you of errors when there is a mismatch between the sample files
present and those listed in the `VCF` file. You can instead use the `--vcf-samples` flag if you want Harpy to build a workflow
around the samples present in the `VCF` file. When using this toggle, Harpy will inform you when samples in the `VCF` file
are missing from the provided `INPUTS`.

## # Parameter file

Typically, one runs STITCH multiple times, exploring how results vary with
different model parameters (explained in next section). The solution Harpy uses for this is to have the user
provide a tab-delimited dataframe file where the columns are the 6 STITCH model
parameters and the rows are the values for those parameters. The parameter file
is required and can be created manually or with [harpy template impute](../template/#impute).
If created using harpy, the resulting file includes largely meaningless values
that you will need to adjust for your study. The parameter must follow a particular format:

* tab or comma delimited
* column order doesn't matter, but all 7 column names must be present
* header row present with the specific column names below

example file

This file is tab-delimited, note the column names:

paramaters.txt

```
name    model   usebx   bxlimit   k       s       nGen
model1    diploid   TRUE    50000    10      5       50
model2    diploid   TRUE    50000   15      10      100
waffles    pseudoHaploid   TRUE    50000   10      1       50
```

example file (as a table)

This is the table view of the tab-delimited file, shown here for clarity.

| name | model | useBX | bxlimit | k | s | nGen |
| --- | --- | --- | --- | --- | --- | --- |
| model1 | diploid | TRUE | 50000 | 10 | 5 | 50 |
| model2 | diploid | TRUE | 50000 | 15 | 10 | 100 |
| waffles | pseudoHaploid | TRUE | 50000 | 10 | 1 | 50 |

parameter file columns

See the section below for detailed information on each parameter. This
table serves as an overview of the parameters.

| column name | accepted values | description |
| --- | --- | --- |
| name | alphanumeric (a-z, 0-9) and `-_.` | Arbitrary name of the parameter set, used to name outputs |
| model | `pseudoHaploid`, `diploid`, `diploid-inbred` | The STITCH model/method to use  case sensitive |
| usebx | `true`, `false`, `yes`, `no` | Whether to incorporate beadtag information  case insensitive |
| bxlimit | ≥ 1 | Distance between identical BX tags at which to consider them different molecules |
| k | ≥ 1 | Number of founder haplotypes |
| s | ≥ 1 | Number of instances of the founder haplotypes to average results over |
| nGen | ≥ 1 | Estimated number of generations since founding |

## # STITCH Parameters

model

##### # Which method to use

STITCH uses one of three "methods" reflecting different statistical and biological models:

* `diploid`: the best general method with the best statistical properties
  + run time is proportional to the square of `k` and so may be slow for large, diverse populations
* `pseudoHaploid`: uses statistical approximations that makes it less accurate than `diploid`
  + run time is proportional to `k` and may be suitable for large, diverse populations
* `diploid-inbred`: assumes all samples are completely inbred and as such uses an underlying haplotype based imputation model
  + run time is proportional to `k`

Each model assumes the samples are diploid and all methods output diploid genotypes and probabilities.

usebx

##### # Use BX barcodes

The `useBX` parameter is given as a true/false. Simulations suggest including linked-read information isn't helpful
in species with short haploblocks (it might makes things worse). So, it's worth trying both options if you aren't
sure about the length of haplotype blocks in your species.

bxlimit

The `bxlimit` parameter is an integer that informs STITCH when alignments with the same barcode on the same contig
should be considered as originating from different molecules. This is a common consideration for linked-read analyses
and 50kb (`50000`) is often a reasonable default. A lower value is considered more strict (fewer reads per moleucle)
and a higher value is considered more generous (more reads per molecule). You can/should change this value if you
have evidence that 50kb isn't appropriate. See [Barcode Thresholds](../../getting_started/linked_read_data/#barcode-thresholds) for a more thorough explanation.

k

##### # Number ancestral haplotypes

The `k` parameter is the number of ancestral haplotypes in the model. Larger K allows for more accurate imputation for
large samples and coverages, but takes longer and accuracy may suffer with lower coverage. There's value in in trying a
few values of `k` and assess performance using either external validation, or the distribution of quality scores
(*e.g.* mean / median INFO score). The best `k` gives you the best performance (accuracy, correlation or quality score distribution)
within computational constraints, while also ensuring `k` is not too large given your sequencing coverage (*e.g.* try to ensure
that each ancestral haplotype gets at least a certain average \_X of coverage, like 10X, given your number of samples and average depth).

s

##### # Number of ancestral haplotypes to average over

The `s` parameter controls the number of sets of ancestral haplotypes used and which final results are averaged over.
This may be useful for wild or large populations, like humans. The `s` value should affect RAM and run time in a near-linearly.

For the time being, it's probably best to set this value to `1` due to [this inconsistent issue](https://github.com/rwdavies/STITCH/issues/98#issuecomment-2248700697).

nGen

##### # Recombination rate between samples

The `nGen` parameter controls recombination rate between the sequenced samples and the ancestral haplotypes.
It's probably fine to set it to \frac {4 \times Ne} {k} given some estimate of effective population size {Ne} .
If you think your population can be reasonably approximated as having been founded some number of generations
ago or reduced to 2 \times k that many generations ago, use that generation time estimate. STITCH should be fairly
robust to misspecifications of this parameter.

---

## # Imputation Workflow

 details

[STITCH](https://github.com/rwdavies/STITCH) is a genotype imputation software developed for use in
the R programming language. It has quite a few model parameters that can be tweaked, but HARPY only
focuses on a small handful that have the largest impact on the quality of the results. Imputation is
performed on a per-contig (or chromosome) level, so Harpy automatically iterates over the contigs
present in the input variant call file. Using the magic of Snakemake, Harpy will automatically
iterate over these model parameters.

##### Filtering for biallelic contigs

Since STITCH creates haplotype blocks from which it imputes genotypes, it will not work for
contigs with no biallelic SNPs (obvious reasons), or contigs with a single biallelic SNP
(need 2+ SNPs to create haplotype). Therefore, Harpy first identifies which
contigs have at least 2 biallelic SNPs, then performs imputation on only those contigs.

```
graph LR
    subgraph Inputs
        v[VCF file]:::clean---gen[genome]:::clean
        gen---bam[BAM alignments]:::clean
    end
    B([split contigs]):::clean-->C([keep biallelic SNPs]):::clean
    Inputs-->B & C & G
    C-->D([convert to STITCH format]):::clean
    D-->E([STITCH imputation]):::clean
    E-->F([merge output]):::clean
    G([create file list]):::clean-->E
    style Inputs fill:#f0f0f0,stroke:#e8e8e8,stroke-width:2px,rx:10px,ry:10px
    classDef clean fill:#f5f6f9,stroke:#b7c9ef,stroke-width:2px
```

 impute output

The default output directory is `Impute` with the folder structure below. `contig1` and `contig2`
are generic contig names from an imaginary `genome.fasta` for demonstration purposes. The directory `modelname`
is a placeholder for whatever `name` you gave that parameter set in the parameter file's `name` column.
The resulting folder also includes a `workflow` directory (not shown) with workflow-relevant runtime files and information.

```
Impute/
└── modelname
    ├── modelname.bcf
    ├── modelname.bcf.csi
    ├── contigs
    │    ├── contig1.vcf.gz
    │    ├── contig1.vcf.gz.tbi
    │    ├── contig2.vcf.gz
    │    └── contig2.vcf.gz.tbi
    ├── logs
    └── reports
        ├── data
        ├── contig1.modelname.html
        ├── contig2.modelname.html
        └── modelname.summary.html
```

| item | description |
| --- | --- |
| `modelname/modelname.bcf` | final bcf file of imputed genotypes |
| `modelname/modelname.bcf.csi` | index of `modelname.bcf` |
| `modelname/reports/modelname.summary.html` | report summarizing the results of imputation across contigs |
| `modelname/reports/*.modelname.html` | summary of STITCH imputation (per contig) |
| `modelname/contigs/*.vcf.gz` | variants resulting from imputation |
| `modelname/contigs/*.vcf.gz.tbi` | index of variant file |

 STITCH parameters

While you are expected to run STITCH using your own set of
configurable parameters as described in the section below, Harpy
also runs STITCH with a few fixed parameters:

```
STITCH(
    ...,
    niterations          = 40,
    switchModelIteration = 39,
    splitReadIterations  = NA
)
```

 reports

These are the summary reports Harpy generates for this workflow. You may right-click
the images and open them in a new tab if you wish to see the examples in better detail.

STITCH Reports

Imputation Metrics

Aggregates the various outputs of a STITCH run into a single report along with `bcftools stats`.
![model*/contigs/*/*.impute.html](../../static/report_stitchimpute.png)

Reports how effective STITCH was at genotype imputation.
![model*/variants.imputed.html](../../static/report_impute.png)

## See also

[Common Harpy Options

Each of the main Harpy modules (e.g. or ) follows the format of](/harpy/getting_started/common_options/)
[Common Issues

If you use bamutils clipOverlap on alignments that are used for the or modules, they will cause both programs to error. We don't know why, but they]