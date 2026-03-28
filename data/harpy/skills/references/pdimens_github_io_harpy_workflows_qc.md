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
3. [QC](../../workflows/qc/)

# # Quality Trim Sequences

In

[linked-read](../../categories/linked-read/),

[wgs](../../categories/wgs/)

Quality trim haplotagged sequences with Harpy

 You will need

* at least 2 cores/threads available
* paired-end [fastq](../../getting_started/inputformat/#naming-conventions) sequence files
  ❤️
  gzipped recommended
  + **sample names**:
    a-z

    0-9

    .

    \_

    -

    case insensitive
  + **forward**:
    \_F

    .F

    .1

    \_1

    \_R1\_001

    .R1\_001

    \_R1

    .R1
  + **reverse**:
    \_R

    .R

    .2

    \_2

    \_R2\_001

    .R2\_001

    \_R2

    .R2
  + **fastq extension**:
    .fq

    .fastq

    case insensitive

Raw sequences are not suitable for downstream analyses. They have sequencing adapters,
index sequences, regions of poor quality, etc. The first step of any genetic sequence
analyses is to remove these adapters and trim poor quality data. You can remove adapters,
remove duplicates, and quality trim sequences using the
qc
 module:

usage

```
harpy qc OPTIONS... INPUTS...
```

example | perform quality control with automatic adapter identification/removal

```
harpy qc --threads 20 -a auto Sequences_Raw/
```

## # Running Options

In addition to the [common runtime options](../../getting_started/common_options/), the
qc
 module is configured using these command-line arguments:

| argument | default | description |
| --- | --- | --- |
| `INPUTS` |  | required  Files or directories containing [input FASTQ files](../../getting_started/common_options/#input-arguments) |
| `--deduplicate` `-d` |  | Identify and remove PCR duplicates |
| `--extra-params` `-x` |  | Additional fastp arguments, in quotes |
| `--min-length` `-m` | `30` | Discard reads shorter than this length |
| `--max-length` `-M` | `150` | Maximum length to trim sequences down to |
| `--trim-adapters` `-a` |  | Detect and remove adapter sequences  recommended |

By default, this workflow will only quality-trim the sequences.

### # Deduplicate reads

not recommended

You can opt-in to have `fastp` deduplicate optical (PCR) duplicates. It's generally not recommended to perform deduplication during quality-checking,
as the [align](../align/) workflows use the linked-read barcode to more accurately tag reads as duplicates.

### # Trim adapters

recommended

You can opt-in to find and remove adapter content in sequences.

* accepts `auto` for automatic adapter detection and removal
* accepts a FASTA file of adapter sequences

example FASTA file of adapters

```
>Illumina TruSeq Adapter Read 1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
>Illumina TruSeq Adapter Read 2
AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
>polyA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
```

Trimming reads to different lengths

In the event you need the forward and reverse reads trimmed down to different read lengths, this can be achieved by
setting `-M` (`--max-length`) to the length you want the **forward** reads trimmed down to (e.g. `-M 125`), then specify an extra
`fastp` parameter with `-x "--max_len2 VAL"` to set the maximum length of the **reverse** reads to `VAL`, e.g. `-x "--max_len2 130"`.
In practice that would look like:

```
harpy qc -M 150 -x "--max_len2 125" -a data/fastq/
```

---

## # QC Workflow

 details

[Fastp](https://github.com/OpenGene/fastp) is an ultra-fast all-in-one adapter remover, deduplicator,
and quality trimmer. Harpy uses it to remove adapters, low-quality bases, and trim sequences down to a particular
length (default 150bp). Harpy uses the fastp overlap analysis to identify adapters for removal and a sliding window

```
graph LR
    subgraph Inputs
        F[FASTQ files]:::clean
    end
    Inputs-->A:::clean
    A([fastp]) --> B([count barcodes]):::clean
    style Inputs fill:#f0f0f0,stroke:#e8e8e8,stroke-width:2px,rx:10px,ry:10px
    classDef clean fill:#f5f6f9,stroke:#b7c9ef,stroke-width:2px
```

 qc output

The default output directory is `QC` with the folder structure below. `Sample1` and `Sample2` are generic sample names for demonstration purposes.
The resulting folder also includes a `workflow` directory (not shown) with workflow-relevant runtime files and information.

```
QC/
├── Sample1.R1.fq.gz
├── Sample1.R2.fq.gz
├── Sample2.R1.fq.gz
├── Sample2.R2.fq.gz
├── reports
│   ├── Sample1.html
│   ├── Sample2.html
│   ├── summary.bx.valid.html
│   └── trim.report.html
└── logs
    ├── err
    │   ├── Sample1.log
    │   └── Sample2.log
    └── json
        ├── Sample1.fastp.json
        └── Sample2.fastp.json
```

| item | description |
| --- | --- |
| `*.R1.fq.gz` | quality trimmed forward reads of the samples |
| `*.R1.fq.gz` | quality trimmed reverse reads of the samples |
| `logs/` | all debug/diagnostic files that aren't the trimmed reads `fastp` creates |
| `logs/err` | what fastp prints to `stderr` when running |
| `reports/*.html` | interactive html reports `fastp` creates from quality trimming |
| `reports/trim.report.html` | a report generated by `multiqc` summarizing the quality trimming results |
| `reports/summary.bx.valid.html` | a report detailing valid vs invalid barcodes and the segments causing invalidation |
| `logs/json` | json representation of the data `fastp` uses to create the html reports |

 fastp parameters

By default, Harpy runs `fastp` with these parameters (excluding inputs and outputs):

```
fastp --trim_poly_g --cut_right
```

The list of all `fastp` command line options is quite extensive and would
be cumbersome to print here. See the list of options in the [fastp documentation](https://github.com/OpenGene/fastp).

 reports

These are the summary reports Harpy generates for this workflow. You may right-click
the images and open them in a new tab if you wish to see the examples in better detail.

fastp reports

Trimming and QC

BX validation

Reports of all QC activities performed by fastp (fastp creates this)
![reports/trim.report.html](../../static/report_trim_fastp.png)

Aggregates the metrics FASTP generates for every sample during QC.
![reports/trim.report.html](../../static/report_trim_aggregate.png)

Reports the number of valid/invalid barcodes in the sequences and the segments contributing to invalidation.
![reports/summary.bx.valid.html](../../static/report_qc_bx.png)

## See also

[Common Harpy Options

Each of the main Harpy modules (e.g. or ) follows the format of](/harpy/getting_started/common_options/)
[Harpy for (non linked-read) WGS data

How to use Harpy for plain-regular WGS data](/harpy/getting_started/guides/wgs_data/)
[Home

Using Harpy to process your linked-read data](/harpy/)
[Input Format

Reads must be at least 30 base pairs in length for alignment. By default, the module removes reads <30bp.](/harpy/getting_started/inputformat/)
[Map Reads onto a genome with BWA MEM

Align haplotagged sequences with BWA MEM](/harpy/workflows/align/bwa/)
[Map Reads onto a genome with EMA

Align haplotagged sequences with EMA](/harpy/workflows/align/ema/)
[Map Reads onto a genome with strobealign

Align haplotagged sequences with strobealign](/harpy/workflows/align/strobe/)
[Resume

When calling a workflow (e.g. ), Harpy performs various file checks and validations, sets up the Snakemake command, output folder(s), etc. In the](/harpy/getting_started/troubleshooting/resume/)

[linked-read](../../tags/linked-read/)
[wgs](../../tags/wgs/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/qc.md)

[Previous
Validate](../../workflows/validate/)

[Next
Simulate](../../workflows/simulate/)

© Copyright 2026. All rights reserved.