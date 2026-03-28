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
3. [Validate](../../workflows/validate/)

# # Validation checks for input files

In

[linked-read](../../categories/linked-read/)

Run file format checks on haplotagged FASTQ/BAM files

 You will need

* at least 2 cores/threads available
* validate bam
  : SAM/BAM alignment files
  BAM recommended
* validate fastq
  : paired-end reads from an Illumina sequencer in FASTQ format
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

Harpy does a lot of stuff with a lot of software and each of these programs expect the incoming data to follow particular formats (plural, unfortunately).
These formatting opinions/specifics are at the mercy of the original developers and while there are times when Harpy can (and does)
modify input/output files for format compatability, it's not always feasible or practical to handle all possible cases. So, our
solution is perform what we lovingly call "pre-flight checks" to assess if your input FASTQ or BAM files are formatted correctly
for the pipeline. There are separate
validate fastq
 and
validate bam
 submodules and the result of each is a report detailing file format quality checks.

## # When to run

* validate fastq
  : the validation checks for FASTQ files are best performed *after* demultiplexing (or trimming/QC) and *before* sequence alignment
* validate bam
  : the validation checks for BAM files should be run *after* sequence alignment and *before* consuming those files for other purposes
  (e.g. variant calling, phasing, imputation)

fastq usage and example

```
harpy validate fastq OPTIONS... INPUTS...

# example
harpy validate fastq --threads 20 raw_data
```

bam usage and example

```
harpy validate bam OPTIONS... INPUTS...

# example
harpy validate bam --threads 20 Align/bwa
```

## # Running Options

In addition to the [common runtime options](../../getting_started/common_options/), the
validate fastq
 and
validate bam
 modules are configured using only command-line input arguments:

| argument | description |
| --- | --- |
| `INPUTS` | required  Files or directories containing [input fastq or bam files](../../getting_started/common_options/#input-arguments) |

## # Workflow

fastq files

Below is a table of the format specifics
validate fastq
 checks for FASTQ files. Since 10X data doesn't use
the haplotagging data format, you will find little value in running
validate fastq
 on 10X FASTQ files. Take note
of the language such as when "any" and "all" are written.

| Criteria | Pass Condition | Fail Condition |
| --- | --- | --- |
| Format | **all** reads with BX:Z: tag have properly formatted barcodes for the given linked-read platform | **any** BX:Z: barcodes have incorrect format |
| follows SAM spec | **all** reads have proper `TAG:TYPE:VALUE` comments | **any** reads have incorrectly formatted comments |
| BX:Z: last comment | **all** reads have `BX:Z`: as final comment | **at least 1 read** doesn't have `BX:Z:` tag as final comment |
| BX:Z: tag | any `BX:Z:` tags present | **all** reads lack `BX:Z:` tag |

bam files

Below is a table of the format specifics
validate bam
 checks for SAM/BAM files. Take note
of the language such as when "any" and "all" are written.

| Criteria | Pass Condition | Fail Condition |
| --- | --- | --- |
| name matches | the file name matches the `@RG ID:` tag in the header | file name does not match `@RG ID:` in the header |
| MI: tag | **any** alignments with `BX:Z:` tags also have `MI:i:` (or `MI:Z:`) tags | **all** reads have `BX:Z:` tag present but `MI:i:` tag absent |
| BX:Z: tag | any `BX:Z:` tags present | **all** alignments lack `BX:Z:` tag |
| Format | **all** alignments with BX:Z: tag have properly formatted barcodes for the given linked-read platform | **any** `BX:Z:` barcodes have incorrect format |
| BX:Z: last tag | **all** reads have `BX:Z`: as final tag in alignment records | **at least 1 read** doesn't have `BX:Z:` tag as final tag |

output

The default output directory is `Validate/fastq` or `Validate/bam` depending on which mode you are using.

Reports

The result of `validate` is a single HTML report in `inputdir/Validate/validate.xxx.html` where `xxx` is either `fastq` or `bam`
depending on which filetype you specified. The reports for both `fastq` and `bam` are very similar and give you both the
criteria of what type of format checking occurred, the context, relevance, and severity of those checks, along with pass/fails for each
file (or sample).

FASTQ file report

BAM file report

![Validate/validate.fastq.html](../../static/report_preflightfastq.png)

![Validate/validate.bam.html](../../static/report_preflightbam.png)

## See also

[Call Structural Variants using LEVIATHAN

Call structural variants using Leviathan](/harpy/workflows/sv/leviathan/)
[Home

Using Harpy to process your linked-read data](/harpy/)

[linked-read](../../tags/linked-read/)

[Edit this page](https://github.com/pdimens/harpy/edit/docs/Workflows/validate.md)

[Previous
Phase](../../workflows/phase/)

[Next
QC](../../workflows/qc/)

© Copyright 2026. All rights reserved.