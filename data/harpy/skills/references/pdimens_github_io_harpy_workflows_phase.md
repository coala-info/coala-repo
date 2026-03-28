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
3. [Phase](../../workflows/phase/)

# # Phase SNPs into Haplotypes

In

[linked-read](../../categories/linked-read/),

[wgs](../../categories/wgs/)

Phase haplotypes for haplotagged data with Harpy

 You will need

* at least 2 cores/threads available
* sequence alignments:
  .bam

  ❗
  coordinate-sorted
  + **sample name**:
    a-z

    0-9

    .

    \_

    -

    case insensitive
* a variant call format file of genotypes:
  .vcf

  .bcf
* optional
   a reference genome in FASTA format:
  .fasta

  .fa

  .fasta.gz

  .fa.gz

  case insensitive

You may want to phase your genotypes into haplotypes, as haplotypes tend to be more informative
than unphased genotypes (higher polymorphism, captures relationship between genotypes). Phasing
genotypes into haplotypes requires alignment files, such as those produced by [align bwa](../align/bwa/)
and a variant call file, such as one produced by [snp freebayes](../snp/)
or [impute](../impute/). **Phasing only works on SNP data**, and will not
work for structural variants produced by [sv leviathan](../sv/leviathan/)
or [sv naibr](../sv/naibr/), preferably [filtered in some capacity](../../getting_started/guides/filtering_snps/). You can phase genotypes into haplotypes with
Harpy using the
phase
 module:

usage

```
harpy phase OPTIONS... VCF INPUTS...
```

example | phase variants using auto-detected linked-read data

```
harpy phase --threads 20 Variants/variants.raw.bcf alignments/
```

## # Running Options

In addition to the [common runtime options](../../getting_started/common_options/), the
phase
 module is configured using these command-line arguments:

| argument | default | description |
| --- | --- | --- |
| `VCF` |  | required  Path to BCF/VCF file |
| `INPUTS` |  | required  Files or directories containing [input BAM files](../../getting_started/common_options/#input-arguments) |
| `--contigs` |  | [Contigs to plot](../../getting_started/common_options/#--contigs) in the report |
| `--extra-params` `-x` |  | Additional Hapcut2 arguments, in quotes |
| `--reference` `-r` |  | Path to reference genome if wanting to also use reads spanning indels |
| `--min-map-qual` `-q` | `20` | Minimum mapping quality score to be considered for phasing |
| `--min-map-qual` `-m` | `13` | Minimum base quality score to be considered for haplotype fragment inclusion |
| `--molecule-distance` `-d` | `100000` | Base-pair distance threshold to separate molecules |
| `--prune-threshold` `-p` | `30` | PHRED-scale (%) threshold for pruning low-confidence SNPs |
| `--vcf-samples` |  | Use samples present in vcf file for imputation rather than those found the directory |

### # Prioritize the vcf file

Sometimes you want to run imputation on all the samples present in the `INPUTS`, but other times you may want
to only impute the samples present in the `--vcf` file. By default, Harpy assumes you want to use all the samples
present in the `INPUTS` and will inform you of errors when there is a mismatch between the sample files
present and those listed in the `VCF` file. You can instead use the `--vcf-samples` flag if you want Harpy to build a workflow
around the samples present in the `VCF` file. When using this toggle, Harpy will inform you when samples in the `VCF` file
are missing from the provided `INPUTS`.

The molecule distance and pruning thresholds are considered the most impactful parameters
for running HapCut2.

### # Molecule distance

The molecule distance refers to the base-pair distance dilineating separate molecules.
In other words, when two alignments on a single contig share the same barcode, how far
away from each other are we willing to say they were and still consider them having
originated from the same DNA molecule rather than having the same barcodes by chance.
Feel free to play around with this number if you aren't sure. A larger distance means
you are allowing the program to be more lenient in assuming two alignments with the
same barcode originated from the same DNA molecule. The HapCut2 default is `20000` (20kbp),
but Harpy's default is more lenient with `100000` (100kbp). Unless you have strong evidence
in favor of it, a distance above `250000` (250kbp) would probably do more harm than good.
See [Barcode Thresholds](../../getting_started/linked_read_data/#barcode-thresholds) for a more thorough explanation.

### # Pruning threshold

The pruning threshold refers to a PHRED-scale value between 0-1 (a percentage) for removing
low-confidence SNPs from consideration. With Harpy, you configure this value as an integer
between 0-100, (*i.e.* `-p 30` is equivalent to a 0.30 threshold, aka 30%).

---

## # Phasing Workflow

 details

Phasing is performed using [HapCut2](https://github.com/vibansal/HapCUT2). Most of the tasks cannot
be parallelized, but HapCut2 operates on a per-sample basis, so the workflow is parallelized
across all of your samples to speed things along.

```
graph LR
    subgraph Inputs
        Z([sample alignments]):::clean---gen["genome (optional)"]:::clean
    end
    Inputs--->A([isolate heterozygotes]):::clean
    A ---> B([extractHAIRS]):::clean
    B-->C([LinkFragments]):::clean
    C-->D([phase blocks]):::clean
    B-->D
    A-->D
    D-->E([annotate BCFs]):::clean
    E-->F([index annotations]):::clean
    F-->G([merge annotations]):::clean
    E-->G
    A-->G
    D-->G
    G-->I([merge phased samples]):::clean
    style Inputs fill:#f0f0f0,stroke:#e8e8e8,stroke-width:2px,rx:10px,ry:10px
    classDef clean fill:#f5f6f9,stroke:#b7c9ef,stroke-width:2px
```

 phasing output

The default output directory is `Phase` with the folder structure below. `Sample1` is a generic sample name for demonstration purposes.
The resulting folder also includes a `workflow` directory (not shown) with workflow-relevant runtime files and information.

```
Phase/
├── variants.phased.bcf
├── variants.phased.bcf.csi
├── annotations
│   ├── Sample1.annot.gz
│   └── Sample1.annot.gz.tbi
├── extractHairs
│   ├── Sample1.unlinked.frags
│   └── logs
│       └── Sample1.unlinked.log
├── workflow/input
│   ├── header.names
│   ├── Sample1.bcf
│   └── Sample1.het.bcf
├── linkFragments
│   ├── Sample1.linked.frags
│   └── logs
│       └── Sample1.linked.log
├── reports
│   ├── blocks.summary.gz
│   └── phase.html
└── phaseBlocks
    ├── Sample1.blocks
    ├── Sample1.blocks.phased.VCF
    └── logs
        └── Sample1.blocks.phased.log
```

| item | description |
| --- | --- |
| `variants.phased.bcf*` | final vcf output of HapCut2 with all samples merged into a single file (with .csi index) |
| `annotations/` | phased vcf annotated with phased blocks |
| `annotations_merge/` | merged vcf of annotated and original vcf |
| `extractHairs/` | output from `extractHairs` |
| `extractHairs/logs/` | everything HapCut2's `extractHairs` prints to `stderr` |
| `input/head.names` | extra file harpy creates to support new INFO fields in the phased VCF |
| `input/*.bcf` | vcf of a single sample from the original multi-sample input vcf |
| `input/*.het.bcf` | vcf of heterozygous loci of a single sample from the original multi-sample input vcf |
| `linkFragments/` | results from HapCut2's `linkFragments` |
| `linkFragments/logs` | everything `linkFragments` prints to `stderr` |
| `reports/blocks.summary.gz` | summary information of all the samples' block files |
| `reports/phase.html` | report of haplotype phasing results |
| `phaseBlocks/*.blocks*` | output from HapCut2 |
| `phaseBlocks/logs` | everything HapCut2 prints to `stderr` |

 HapCut2 parameters

By default, Harpy runs `HAPCUT2` with these parameters (excluding inputs and outputs):

```
HAPCUT2 --nf 1 --error_analysis_mode 1 --call_homozygous 1 --outvcf 1
```

Below is a list of all `HAPCUT2` command line options, excluding those Harpy already uses or those made redundant by Harpy's implementation of HapCut2.
These are taken directly from running `HAPCUT2 --help`.

hapcut2 arguments

```
Haplotype Post-Processing Options:
--skip_prune, --sp <0/1>:           skip default likelihood pruning step (prune SNPs after the fact using column 11 of the output). default: 0
--discrete_pruning, --dp <0/1>:     use discrete heuristic to prune SNPs. default: 0

Advanced Options:
--max_iter, --mi <int> :            maximum number of global iterations. Preferable to tweak --converge option instead. default: 10000
--maxcut_iter, --mc <int> :         maximum number of max-likelihood-cut iterations. Preferable to tweak --converge option instead. default: 10000
```

 reports

These are the summary reports Harpy generates for this workflow. You may right-click
the image and open it in a new tab if you wish to see the example in better detail.

Phasing Performance

Aggregates phasing metrics overall and across all samples.
![reports/phase.html](../../static/report_phase.png)

## See also

[Call Structural Variants using NAIBR

Call structural variants using NAIBR (plus)](/harpy/workflows/sv/naibr/)
[Common Harpy Options

Each of the main Harpy modules (e.g. or ) follows the format of](/harpy/getting_started/common_options/)
[Common Issues

If you use bamutils clipOverlap on alignments that are used for the or modules, they will cause both programs to error. We don't know why, but they](/harpy/getting_started/troubleshooting/common_issues/)
[Find structural variants

Find structural variants](/harpy/workflows/sv/)
[Harpy for (non linked-read) WGS data

How to use Harpy for plain-regular WGS data](/harpy/getting_started/guides/wgs_data/)
[Home

Using Harpy to process your linked-read data](/harpy/)

[linked-read](../../tags/linked-read/)
[wgs](../../tags/wgs/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/phase.md)

[Previous
Template](../../workflows/template/)

[Next
Validate](../../workflows/validate/)

© Copyright 2026. All rights reserved.