[MACS3](../index.html)

* [INSTALL Guide For MACS3](INSTALL.html)
* [Subcommands](subcommands_index.html)
  + [callpeak](callpeak.html)
  + [callvar](callvar.html)
  + hmmratac
    - [Description](#description)
    - [Output](#output)
    - [Essential Options](#essential-options)
      * [`-i INPUT_FILE [INPUT_FILE ...]` / `--input INPUT_FILE [INPUT_FILE ...]`](#i-input-file-input-file-input-input-file-input-file)
      * [`-f {BAMPE,BEDPE,FRAG}` / `--format {BAMPE,BEDPE,FRAG}`](#f-bampe-bedpe-frag-format-bampe-bedpe-frag)
      * [`--barcodes` and `--max-count`](#barcodes-and-max-count)
      * [`--outdir OUTDIR`](#outdir-outdir)
      * [`-n NAME`/ `--name NAME`](#n-name-name-name)
      * [`-e BLACKLIST`/`--blacklist BLACKLIST`](#e-blacklist-blacklist-blacklist)
      * [`--modelonly`](#modelonly)
      * [`--model`](#model)
      * [`-t HMM_TRAINING_REGIONS` / `--training HMM_TRAINING_REGIONS`](#t-hmm-training-regions-training-hmm-training-regions)
      * [`--min-frag-p MIN_FRAG_P`](#min-frag-p-min-frag-p)
      * [`--cutoff-analysis-only`](#cutoff-analysis-only)
      * [`--cutoff-analysis-max`](#cutoff-analysis-max)
      * [`--cutoff-analysis-steps`](#cutoff-analysis-steps)
      * [`--hmm-type`](#hmm-type)
      * [`-u HMM_UPPER` / `--upper HMM_UPPER`](#u-hmm-upper-upper-hmm-upper)
      * [`-l HMM_LOWER` / `--lower HMM_LOWER`](#l-hmm-lower-lower-hmm-lower)
      * [`-c PRESCAN_CUTOFF` / `--prescan-cutoff PRESCAN_CUTOFF`](#c-prescan-cutoff-prescan-cutoff-prescan-cutoff)
    - [Choices of cutoff values](#choices-of-cutoff-values)
    - [Tune the HMM model](#tune-the-hmm-model)
  + [bdgbroadcall](bdgbroadcall.html)
  + [bdgcmp](bdgcmp.html)
  + [bdgdiff](bdgdiff.html)
  + [bdgopt](bdgopt.html)
  + [bdgpeakcall](bdgpeakcall.html)
  + [cmbreps](cmbreps.html)
  + [filterdup](filterdup.html)
  + [pileup](pileup.html)
  + [predictd](predictd.html)
  + [randsample](randsample.html)
  + [refinepeak](refinepeak.html)
* [File Formats](fileformats_index.html)
* [Tutorial](tutorial.html)
* [Common Q & A](qa.html)
* [Contributor Covenant Code of Conduct](../CODE_OF_CONDUCT.html)
* [Contributing to MACS project](../CONTRIBUTING.html)
* [MACS3 API reference](api/index.html)

[MACS3](../index.html)

* [Subcommands](subcommands_index.html)
* hmmratac
* [View page source](../_sources/docs/hmmratac.md.txt)

---

# hmmratac[](#hmmratac "Link to this heading")

## Description[](#description "Link to this heading")

HMMRATAC (`macs3 hmmratac`) is a dedicated peak calling algorithm
based on Hidden Markov Model for ATAC-seq data. The basic idea behind
HMMRATAC is to digest ATAC-seq data according to the fragment length
of read pairs into four signal tracks: short fragments,
mono-nucleosomal fragments, di-nucleosomal fragments and
tri-nucleosomal fragments. Then integrate the four tracks using Hidden
Markov Model to consider three hidden states: open region, nucleosomal
region, and background region. The [orginal
paper](https://academic.oup.com/nar/article/47/16/e91/5519166) was
published in 2019, and the original software was written in JAVA, by
the then PhD student Evan Tarbell, a mohawk bioinformatician. In MACS3
project, we implemented HMMRATAC idea in Python/Cython and optimize
the whole process using existing MACS functions and hmmlearn, and
integrate HMMRATAC with all other modules in MACS3 such as the support
for single-cell assay (FRAG format support).

Here’s an example of how to run the `hmmratac` command:

```
$ macs3 hmmratac -i yeast.bam -n yeast
```

or with the BEDPE format of a much smaller size:

```
$ macs3 hmmratac -i yeast.bedpe.gz -f BEDPE -n yeast
```

You can convert BAMPE to BEDPE by using

```
$ macs3 filterdup --keep-dup all -f BAMPE -i yeast.bam -o yeast.bedpe
```

You can also call accessible regions on the fragment files from
scATAC-seq analysis:

```
$ macs3 hmmratac -i yeast.scATAC.frag.gz -f FRAG --barcodes selected_barcodes.txt --max-count 1
```

Please note that in order to save memory usage and fasten the process,
`hmmratac` will save intermediate temporary file to the disk. The file
size can range from megabytes to gigabytes, depending on how many
candidate regions `hmmratac` needs to decode. The temporary file will
be removed after the job is done. So please make sure there is enough
space in the ‘tmp’ directory of your system.

Please use `macs3 hmmratac --help` to see all the options. Here we
list the essential ones.

## Output[](#output "Link to this heading")

The final output file from `hmmratac` is in narrowPeak format
containing the accessible regions (open state in `hmmratac` HMM). The
columns are:

1. chromosome name
2. start position of the accessible region
3. end position of the accesssible region
4. peak name
5. peak score. The score is the 10times the maximum foldchange
   (signal/average signal) within the peak. By default, the ‘signal’
   used to calculate foldchange is the total pileup of all types of
   fragments from short to tri-nuc size fragments.
6. Not used
7. Not used
8. Not used
9. peak summit position. It’s the relative position from the start
   position to the peak summit which is defined as the position with
   the maximum foldchange score.

## Essential Options[](#essential-options "Link to this heading")

### `-i INPUT_FILE [INPUT_FILE ...]` / `--input INPUT_FILE [INPUT_FILE ...]`[](#i-input-file-input-file-input-input-file-input-file "Link to this heading")

This is the only REQUIRED parameter for `hmmratac`. Input files
containing the aligment results for ATAC-seq paired end reads. If
multiple files are given as ‘-t A B C’, then they will all be read and
pooled together. The file should be in BAMPE, BEDPE format (aligned in
paired end mode) or FRAG format (from scATAC analysis). Files can be
gzipped. Note: all files should be in the same format. REQUIRED.

### `-f {BAMPE,BEDPE,FRAG}` / `--format {BAMPE,BEDPE,FRAG}`[](#f-bampe-bedpe-frag-format-bampe-bedpe-frag "Link to this heading")

Format of input files, “BAMPE”, “BEDPE”, or “FRAG”. If there are
multiple files, they should be in the same format – either BAMPE,
BEDPE, or FRAG. Please note that the BEDPE only contains three columns
– chromosome, left position of the whole pair, right position of the
whole pair– and is NOT the same BEDPE format used by BEDTOOLS. To
convert BAMPE to BEDPE, you can use this command `macs3 filterdup --keep-dup all -f BAMPE -i input.bam -o output.bedpe`. And the FRAG
format is like BEDPE but with two extra columns – barcode and count
of the fragment. Please note that if you plan to analyze single-cell
ATAC-seq data on a specific list of barcodes, you can only use FRAG
format. For other formats, the barcode information will be
ignored. DEFAULT: “BAMPE”.

### `--barcodes` and `--max-count`[](#barcodes-and-max-count "Link to this heading")

These two options are for `-f FRAG` format only. You can let
`hmmratac` work on a selected set of barcodes by specifying
`--barcodes barcode.txt`. The `barcode.txt` should contain list of
selected barcodes and each row represents a specific barcode, like:

```
ATCGATCGATCGATCG
GCTAGCTAGCTAGCTA
...
```

The `--max-count` option is recommended for scATAC-seq since for each
single cell, Tn5 can only cut the same location once for each DNA
molecule. So theoratically, if you are studying a haploid genome, the
maximum count of the same fragment can’t be larger than 2 (i.e. should
use `--max-count 1` or `--max-count 2`).

### `--outdir OUTDIR`[](#outdir-outdir "Link to this heading")

If specified all output files will be written to that
directory. Default: the current working directory

### `-n NAME`/ `--name NAME`[](#n-name-name-name "Link to this heading")

Name for this experiment, which will be used as a prefix to generate
output file names. DEFAULT: “NA”

### `-e BLACKLIST`/`--blacklist BLACKLIST`[](#e-blacklist-blacklist-blacklist "Link to this heading")

Filename of the file containing the blacklisted regions to exclude
from the process. Any fragments overlapping with blacklisted regions
are excluded. An example of such file can be found from the ENCODE
project at: https://github.com/Boyle-Lab/Blacklist/. Alternatively, if
you wish to exclude centromeres and telomeres, you can find their
genomic coordinates and write them to a BED format file. By default,
there is no blacklist file in use.

### `--modelonly`[](#modelonly "Link to this heading")

This option will only generate the HMM model as a JSON file and
quit. This model can then be applied using the `--model`
option. Default: False

### `--model`[](#model "Link to this heading")

If provided, HMM training will be skipped and a JSON file generated
from a previous HMMRATAC run will be used instead of creating new
one. Default: NA

### `-t HMM_TRAINING_REGIONS` / `--training HMM_TRAINING_REGIONS`[](#t-hmm-training-regions-training-hmm-training-regions "Link to this heading")

Customized training regions can be provided through this option. `-t`
takes the filename of training regions (previously was BED\_file) to
use for training HMM, instead of using foldchange settings to
select. Default: NA

### `--min-frag-p MIN_FRAG_P`[](#min-frag-p-min-frag-p "Link to this heading")

We will exclude the abnormal fragments that can’t be assigned to any
of the four signal tracks. After we use EM to find the means and
stddevs of the four distributions, we will calculate the likelihood
that a given fragment length fit any of the four using normal
distribution. The criteria we will use is that if a fragment length
has less than MIN\_FRAG\_P probability to be like either of short, mono,
di, or tri-nuc fragment, we will exclude it while generating the four
signal tracks for later HMM training and prediction. The value should
be between 0 and 1. Larger the value, more abnormal fragments will be
allowed. So if you want to include more ‘ideal’ fragments, make this
value smaller. Default = 0.001

### `--cutoff-analysis-only`[](#cutoff-analysis-only "Link to this heading")

Only run the cutoff analysis and output a report. After generating the
report, the whole process will stop. By default, the cutoff analysis
will be included in the whole process, but won’t quit after the report
is generated. The report will help user decide the three crucial
parameters for `-l`, `-u`, and `-c`. So it’s highly recommanded to run
this first! Please read the report and instructions in [Choices of
cutoff values](#choices-of-cutoff-values) on how to decide the three
crucial parameters. The resolution of cutoff analysis can be
controlled by `--cutoff-analysis-max` and `--cutoff-analysis-steps`
options.

### `--cutoff-analysis-max`[](#cutoff-analysis-max "Link to this heading")

The maximum cutoff score for performing cutoff analysis. Together with
`--cutoff-analysis-steps`, the resolution in the final report can be
controlled. Please check the description in `--cutoff-analysis-steps`
for detail. The default value is 100.

### `--cutoff-analysis-steps`[](#cutoff-analysis-steps "Link to this heading")

Steps for performing cutoff analysis. It will be used to decide which
cutoff value should be included in the final report. Larger the value,
higher resolution the cutoff analysis can be. The cutoff analysis
function will first find the smallest (at least 0) and the largest (at
most 100, and controlled by –cutoff-analysis-max) foldchange score in
the data, then break the range of foldchange score into
`CUTOFF_ANALYSIS_STEPS` intervals. It will then use each foldchange
score as cutoff to call peaks and calculate the total number of
candidate peaks, the total basepairs of peaks, and the average length
of peak in basepair. Please note that the final report ideally should
include `CUTOFF_ANALYSIS_STEPS` rows, but in practice, if the
foldchange cutoff yield zero peak, the row for that foldchange value
won’t be included. The default is 100.

### `--hmm-type`[](#hmm-type "Link to this heading")

We provide two types of emissions for the Hidden Markov Model – the
Gaussian model and the Poisson model. By default, the Gaussian
emission will be used (as `--hmm-type gaussian`). To choose Poisson
emission, use `--hmm-type poisson`. The Gaussian emission can be
described by mean and variance for each state, while the simpler
Poisson only needs the lambda value. The difference can be found in
the saved json file for HMM.

### `-u HMM_UPPER` / `--upper HMM_UPPER`[](#u-hmm-upper-upper-hmm-upper "Link to this heading")

Upper limit on fold change range for choosing training sites. This is
an important parameter for training so please read. The purpose of
this parameter is to EXCLUDE those unusually highly enriched chromatin
regions so we can get training samples in ‘ordinary’ regions
instead. It’s highly recommended to run the `--cutoff-analysis-only`
first to decide the lower cutoff `-l`, the upper cutoff `-u`, and the
pre-scanning cutoff `-c`. The upper cutoff should be the cutoff in the
cutoff analysis result that can capture some (typically hundreds of)
extremely high enrichment and unusually wide peaks. Default: 20

### `-l HMM_LOWER` / `--lower HMM_LOWER`[](#l-hmm-lower-lower-hmm-lower "Link to this heading")

Lower limit on fold change range for choosing training sites. This is
an important parameter for training so please read. The purpose of
this parameter is to ONLY INCLUDE those chromatin regions having
ordinary enrichment so we can get training samples to learn the common
features through HMM. It’s highly recommended to run the
`--cutoff-analysis-only` first to decide the lower cutoff `-l`, the
upper cutoff `-u`, and the pre-scanning cutoff `-c`. The lower cutoff
should be the cutoff in the cutoff analysis result that can capture
moderate number ( about 10k ) of peaks with normal width ( average
length 500-1000bps long). Default: 10

### `-c PRESCAN_CUTOFF` / `--prescan-cutoff PRESCAN_CUTOFF`[](#c-prescan-cutoff-prescan-cutoff-prescan-cutoff "Link to this heading")

The fold change cutoff for prescanning candidate regions in the whole
dataset. Then we will use HMM to predict/decode states on these
candidate regions. The higher the prescan cutoff, the fewer regions
will be considered. Must be > 1. This is an important parameter for
decoding so please read. The purpose of this parameter is to EXCLUDE
those chromatin regions having noises/random enrichment so we can have
a large number of possible regions to predict the HMM states. It’s
highly recommended to run the `--cutoff-analysis-only` first to decide
the lower cutoff `-l`, the upper cutoff `-u`, and the pre-scanning
cutoff `-c`. The pre-scanning cutoff should be the cutoff close to the
BOTTOM of the cutoff analysis result that can capture a large number
of possible peaks with normal length (average length 500-1000bps). In
most cases, please do not pick a cutoff too low that captures almost
all the background noises from the data. Default: 1.2

## Choices of cutoff values[](#choices-of-cutoff-values "Link to this heading")

Before you proceed, it’s highly recommended to ru